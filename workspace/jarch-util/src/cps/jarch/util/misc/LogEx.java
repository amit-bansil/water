/*
 * LogUtils.java
 * CREATED:    Jan 9, 2005 12:52:42 PM
 * CREATED BY:     Amit Bansil
 * */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Hook;
import cps.jarch.util.notes.Nullable;
import cps.jarch.util.notes.ThreadSafe;
import cps.jarch.util.notes.UsesDefault;

import java.lang.management.ManagementFactory;
import java.lang.management.MemoryMXBean;
import java.lang.management.MemoryUsage;

/**
 * <p>
 * A [relatively] simplified logging tool that allows a class to output info
 * about what it is doing.
 * 
 * LogEx offers a significant improvement over logging with System.out since
 * whenever a message is logged through it the stack trace, time, & other
 * pertinent info are logged. It is also possible to externally separate logs by
 * instance, class, package, etc. and control the level of detail of output.
 * Note that this class is thread-safe. It does not attempt to provide anywhere
 * near the functionality of frameworks like java.util.logging or apache log4j.
 * Instead, it designed as a thin layer that sits on top of such a library to
 * provide simplified consistent access to the necessary functionality.
 * </p>
 * <h3>Uses</h3>
 * <p>
 * LogEx is meant to provide textual logs that developers can use to diagnose
 * problems. The warning function is particularly useful because it provides
 * libraries a consistent mechanism for reporting potential misuse when
 * deployed. LogEx is <b>not</b> meant for presenting execution/progress logs
 * to typical end users or administrators. Consequently, internationalization is
 * not supported. For simple applications System.out/System.err are usually
 * enough for those purposes. In other cases different a framework would
 * probably be needed.
 * </p>
 * <h3>Typical Definition</h3>
 * <p>
 * A top-level class will usually create a LogEx as follows. The class will then
 * send messages to <code>log</code> using the respective logging methods.
 * </p>
 * 
 * <pre>
 * private static final LogEx&lt;ParentType&gt; log = LogEx.createClassLog(ParentType.class);
 * </pre>
 * 
 * <h3>Logging</h3>
 * <p>
 * To output the actual logs two sets of methods are provided. First, the
 * config(*),info(*),warning(*), and error(*) functions should be used to log
 * major events during an application's execution as prescribed by their docs.
 * Second, the debugXXX(*) methods are used to log details about the execution
 * of a class.
 * </p>
 * <h3>Examining Output</h3>
 * <p>
 * The default behavior of LogEx is to print warning and error message to
 * System.err and ignore everything else. More detailed output to System.out is
 * possible via {@link LogEx#enableOutput(Level, Package)}. It is even possible to
 * enable debug output for only a particular instance of an object using the
 * {@link LogEx#enableDebug(Object)} method.
 * TODO implement these methods.
 * </p>
 * <h3>Typical Filtering</h3>
 * <p>
 * Normally final deployed applications will use the default configuration
 * described above, redirecting System.err to a file for GUI applications &
 * uploading it if anything goes wrong. Testing releases would enable all
 * messages at or above Level.CONFIG globally. This can be done by setting the
 * "cps.jarch.util.misc.LogEx.enableAllConfigOutput" environment variable to
 * true & similarly redirecting streams for GUI use. See {@link #initialize()}.
 * When debugging developers may wish to enable debug output on the particular
 * subsystems as described in 'Examining Output' above.
 * </p>
 * <h3>Log Messages</h3>
 * <p>
 * All the logging commands are wrappers around the
 * #log(ParentType, Level, String, Throwable, Object[]) method. See it
 * for details about how log messages are formatted and what information they
 * contain.
 * </p>
 * <h3>Performance</h3>
 * <p>
 * Generally speaking, the performance penalty of instrumenting code with LogEx
 * is negligible, all it adds when enableDebug is not set are a handful of
 * operations per message. If a logging method were called so many times that
 * this is causing a significant slowdown it is usually being misused because it
 * would generate an unintelligible amount of output. In the exceptional case
 * where this penalty is causing problems, you can test if
 * {@link #isDebugEnabled()} before logging.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id: LogEx.java 542 2005-09-02 12:22:53Z bansil $
 */
//TODO why is @link @link #log(ParentType, Level, String, Throwable, Object[]) broken?
//note that this class is abstract and delegates most of the work to 
//LogLoggerImpl so that if it is necessary to change the underlying implementation
//the tremendous amount of code that depends on LogEx won't break
//TODO prefacing logs with full string reps of objects is a bad idea, better to
//have a LogEx.NamedType{getObjectName(),getTypeName()} and instanceof for it
public abstract class LogEx<ParentType> {
	private static final LogEx<LogEx> log = LogEx.createClassLog(LogEx.class);
	
	public static enum Level{ERROR,WARNING,INFO,CONFIG,DEBUG}
	
	// ------------------------------------------------------------------------
	// Initialize configuration

	static {
		initialize();
	}
	/**
	 * Setup intial logging configuration. Called automatically on startup. sets
	 * up default logging configuration as described in 'Examining Output'
	 * above. calls <code>enableOutput(Level.CONFIG)</code> iff the system
	 * property cps.jarch.util.misc.LogEx.enableAllConfigOutput==true. Outputs a
	 * warning if the property is set to anything else or cannot be read.
	 * 
	 * @throws IllegalStateException
	 *             if thrown after LogEx has already been initialized.
	 */
	@ThreadSafe public static final void initialize() {
		// allow only once
		synchronized (LogEx.class) {
			if (initialized) throw new IllegalStateException("already initialized!");
			initialized = true;
		}

		// read enableAllConfigOutput
		String enableAllConfigOutput = null;
		try {
			enableAllConfigOutput = System
				.getProperty("cps.jarch.util.misc.LogEx.enableAllConfigOutput");
		} catch (IllegalArgumentException e) {// thrown by Level.valueOf
		} catch (SecurityException e) {// thrown by System.getProperty
			log.warning(null,
				"failed to read cps.jarch.util.misc.LogEx.enableAllConfigOutput"
						+ " b/c of security exception:", e);
		}
		// quit if unset
		if (enableAllConfigOutput == null) return;

		if (enableAllConfigOutput.equals("true")) {
			log.config("cps.jarch.util.misc.LogEx.enableAllConfigOutput=true,"
					+ " enabling global config logging");
			enableOutput(Level.CONFIG);
		} else {
			log.warning(null, "failed to enableAllConfigOutput b/c of unknown value "
					+ "''{0}'' for cps.jarch.util.misc.LogEx.enableAllConfigOutput",
				enableAllConfigOutput);
		}

	}
	private static boolean initialized=false;
	// ------------------------------------------------------------------------
	
	/**
	 * Create a LogEx using a logger named after <code>owner</code>. It is
	 * perfectly legal although generally not needed to create multiple loggers
	 * for the same class.
	 */
	public static <T>LogEx<T> createClassLog(Class<T> owner) {
		return new LoggerLogEx<T>(owner);
	}
	/**
	 * see 'log levels' in class comment.
	 */
	public static void setGlobalLevel(Level l) {
		LoggerLogEx.setGlobalLevelImpl(l);
	}
	public static void enableOutput(Level l) {
		//TODO implement
	}
	public static void enableOutput(Level l,@Nullable Package p) {
		//TODO implement
	}
	// ------------------------------------------------------------------------
	// basic logging commands
	
	@UsesDefault @ThreadSafe public final void error(@Nullable ParentType parent,
			String message, @Nullable Object... parameters) {
		error(parent, message, null, parameters);
	}
	/**
	 * Logs <code>message</code> w/ optional <code>parameters</code> at
	 * Level.error. Use when an operation could not complete normally because
	 * something went wrong. Often part of Exception handling logic. Clients
	 * should document conditions under which errors will be output.
	 * <code>t</code> is <code>null</code> by default. A
	 * <code>null</code> <code>message</code> will result in a NPE only if
	 * logging at Level.error is enabled.
	 */
	@ThreadSafe public final void error(@Nullable ParentType parent, String message,
			@Nullable Throwable t, @Nullable Object... parameters) {
		log(parent, Level.ERROR, message, t, parameters);
	}

	@UsesDefault @ThreadSafe public final void warning(@Nullable ParentType parent,
			String message, @Nullable Object... parameters) {
		warning(parent, message, null, parameters);
	}
	/**
	 * Logs <code>message</code> w/ optional <code>parameters</code> at
	 * Level.warning. Use when an unexpected condition was reached however the
	 * operation could still complete. Good for potential performance problems &
	 * recoverable errors. Clients should document conditions under which
	 * warnings will be output. <code>t</code> is <code>null</code>
	 * by default.  A <code>null</code> <code>message</code>
	 * will result in a NPE only if logging at Level.warning is enabled.
	 */
	@ThreadSafe public final void warning(@Nullable ParentType parent, String message,
			@Nullable Throwable t, @Nullable Object... parameters) {
		log(parent, Level.WARNING, message, t, parameters);
	}
	@UsesDefault @ThreadSafe public final void info(String message, @Nullable Object... parameters) {
		info((ParentType) null, message, parameters);
	}
	/**
	 * Logs message w/ optional parameters at Level.INFO. Use to log info about
	 * the progress of an operation. <code>parent</code> is <code>null</code>
	 * by default. A <code>null</code> <code>message</code> will result in a
	 * NPE only if logging at Level.INFO is enabled.
	 */
	@ThreadSafe public final void info(@Nullable ParentType parent,
			String message, @Nullable Object... parameters) {
		log(parent, Level.INFO, message, parameters);
	}


	@UsesDefault @ThreadSafe public final void config(
			String message, @Nullable Object... parameters) {
		config((ParentType) null, message, parameters);
	}

	/**
	 * Logs <code>message</code> w/ optional <code>parameters</code> at
	 * Level.CONFIG. Use to log info about the configuration of a subsystem or
	 * the system itself like # of CPUs, memory, L&F, etc. <code>parent</code>
	 * is <code>null</code> by default. A
	 * <code>null</code> <code>message</code> will result in a NPE only if
	 * logging at Level.CONFIG is enabled.
	 */
	@ThreadSafe public final void config(@Nullable ParentType parent, String message,
			@Nullable Object... parameters) {
		log(parent, Level.CONFIG, message, parameters);
	}
	@UsesDefault @ThreadSafe public final void debug(String message, @Nullable Object... parameters) {
		debug((ParentType) null, message, parameters);
	}
	/**
	 * Logs message w/ optional parameters at Level.DEBUG. Use to log fine
	 * grained debugging info about an operation. When used in performance
	 * critical code check <code>debugEnabled</code> first. <code>parent</code>
	 * is <code>null</code> by default.  A <code>null</code> <code>message</code>
	 * will result in a NPE only if logging at Level.DEBUG is enabled.
	 */
	@ThreadSafe public final void debug(@Nullable ParentType parent, String message,
			Object... parameters) {
		log(parent, Level.DEBUG, message, parameters);
	}

	@UsesDefault @ThreadSafe public final void debugEnterStatic() {
		debugEnter(null);
	}
	/**
	 * 
	 * Log at debug level entrance to a static function w/ the arguments passed to it.
	 * Use for all significant functions. A
	 * <code>null</code> <code>message</code> will result in a NPE only if
	 * logging at Level.DEBUG is enabled.
	 * 
	 * see #debugEnter(ParentType, String, Object...) for details
	 */
	//TODO why is @see not working in #debugEnter(ParentType, String, Object...) ??
	@UsesDefault @ThreadSafe public final void debugEnterStatic(String parameterNames,
			@Nullable final Object... parameters) {
		// optimized
		debugEnter(null,parameterNames,parameters);
	}
	@UsesDefault @ThreadSafe public final void debugEnter(@Nullable ParentType parent) {
		// optimized
		debug(parent, "entering()");
	}
	/**
	 * Log at debug level entrance to a non-static function w/ the arguments
	 * passed to it. Use for all significant functions. A
	 * <code>null</code> <code>message</code> will result in a NPE only if
	 * logging at Level.DEBUG is enabled.
	 * 
	 * @param parameterNames
	 *            a comma separated list of the argument names. log message
	 *            might look like: "( arg1={0}, arg2={1},arg3={2} ){" for
	 *            parameterNames="arg1, arg2, arg3". Empty (default) is allowed.
	 *            Any whitespace characters are stripped from parameterNames so
	 *            that, for example, " , , " would be empty & "ava, ,34" would
	 *            contain only 2 parameters. Parameter names will make a best
	 *            effort format strange input but will generally produce mangled
	 *            messages for mangled input.
	 * 
	 * @param parameters
	 *            the actual arguments in the same order as
	 *            <code>parameterNames</code>. Empty (the default) is
	 *            allowed.
	 * 
	 * @param parent
	 *            default to <code>null</code> for use in static context.
	 */
	@ThreadSafe public final void debugEnter(@Nullable final ParentType parent,
			String parameterNames, @Nullable final Object... parameters) {
		// quit early since this is a lot of work.
		if (!isDebugEnabled()) return;
		
		//strip whitespace from parameterNames
		StringBuilder parameterNamesRebuilder=new StringBuilder(parameterNames.length());
		for(int i=0;i<parameterNames.length();i++) {
			char c=parameterNames.charAt(i);
			if(!Character.isWhitespace(c)) parameterNamesRebuilder.append(c);
		}
		parameterNames=parameterNamesRebuilder.toString();
		
		/*
		 * create pre-sized string builder: resulting message will have an extra
		 * ={#} or 4 chars per parameter + leading '( ' + trailing ' ){'. note
		 * that this is a guesstimate- trailer is only '){' when no parameters
		 * and args after 9 will need 5 chars. We don't allow parameters.length>5 just incase
		 * parameters is some really long array.
		 */
		StringBuilder mb = new StringBuilder(parameterNames.length() + Math.min(parameters.length,5)
				* 4 + 5);

		// split parameterNames
		String[] parameterNamesArray = StringUtils.split(parameterNames, ',');

		// build message
		mb.append("entering(");
		for (int i = 0; i < parameters.length; i++) {
			mb.append(parameterNamesArray[i]);
			mb.append('=');
			mb.append('{');
			mb.append(i);
			mb.append('}');
			// don't add comma on last element
			if (i + 1 != parameters.length) mb.append(',');
		}
		mb.append(')');

		// log it
		debug(parent, mb.toString(), parameters);
	}

	@UsesDefault @ThreadSafe @Nullable public final void debugReturnVoid() {
		debugReturnVoid(null);
	}
	@UsesDefault @ThreadSafe @Nullable public final void debugReturnVoid(
			@Nullable ParentType parent) {
		//optimized
		debug(parent, "returning void");
	}
	/**
	 * Logs exiting a function at debug level. Use for methods that return void.
	 * Use when returning, not throwing an exception
	 * 
	 * @param condition
	 *            describes conditions of return, defaults to <code>null</code>. 
	 * @param parent
	 *            defaults to <code>null</code>
	 */
	@ThreadSafe @Nullable public final void debugReturnVoid(@Nullable ParentType parent,
			@Nullable String condition) {
		if(condition==null) debugReturnVoid(parent);
		else debug(parent, "returning void - {0}",condition);
	}

	@ThreadSafe public final <RT>RT debugReturnValue(@Nullable ParentType parent,
			@Nullable RT ret) {
		debug(parent, "returning {1} ", ret);
		return ret;
	}
	/**
	 * Logs exiting a function at debug level. <code>parent</code> defaults to
	 * <code>null</code>.
	 * 
	 * @param condition
	 *            describes conditions of return, defaults to blank.
	 * @param ret
	 *            value being returned by method. Use when returning, not
	 *            throwing an exception.
	 * @return <code>ret</code> so that this can wrap around return
	 *         statements.
	 */
	@ThreadSafe public final <RT> RT debugReturnValue(@Nullable ParentType parent,
			@Nullable RT ret,@Nullable String condition) {
		//TODO test to make sure } doesn't screw up message format
		if(condition==null) return debugReturnValue(parent,ret);
		else debug(parent, "returning {1} - {0}",condition,ret);
		return ret;
	}

	/**
	 * test if messages at Level.DEBUG (which includes those sent from all 'debug'
	 * methods) can be logged.
	 */
	@ThreadSafe public final boolean isDebugEnabled() {
		return _isLoggable(Level.DEBUG);
	}

	// ------------------------------------------------------------------------
	// log

	/** <h3>Log Messages</h3>
	 * <p>
	 * When outputting a message that contains variables,
	 * clients should normally call <code>debug("var={0}",var)</code> instead of
	 * <code>debug(&quot;var=&quot;+var)</code> since the latter will always
	 * require a potentially expensive toString call while the former, if debugging
	 * is disabled, will just check a condition. The way that this works is
	 * approximately that all methods that take a message also take an Object[]
	 * called parameters and substitute all instances of '{n}' in message with
	 * 'parameters[n]' when outputting the message (The exact method for outputting
	 * is as defined by {@link java.text.MessageFormat}). Note that you don't have
	 * to explicitly create the Object[]- by the magic of Java5's var-args feature
	 * <code>info(&quot;{0}{1}&quot;,null,null)</code> is the same as
	 * <code>info(&quot;{0}{1}&quot;,new Object[2])</code>. This can cause
	 * problems when you pass an Object[] and want it to be treated as a single
	 * parameter i.e. <code>info(&quot;{0}&quot;,new Object[3])</code> would have
	 * a message like &quot;null&quot; instead of &quot;[null,null,null]&quot;. To
	 * work around this if a message contains {0} but not any of {1},{2},or {3} and
	 * yet parameters contains more than 1 element it will be wrapped into an array
	 * so that it will be treated as 1 element. This will garble a few log messages,
	 * but <b>clients should not depend on the final output format of the log
	 * message anyway, it is implementation specific</b>.
	 * </p>
	 * <p>
	 * Array types are automatically expanded to more suitable representations when
	 * they are found as parameters for messages.
	 * </p>
	 * <p>
	 * Most logging methods also take a 'parent' object which is the instance of the
	 * parent class calling the logging command. <code>null</code> may be used for
	 * 'parent' in static contexts. {@link #enableDebug()} can be used to enable
	 * debug output for only a particular parent. Then if parent!=null
	 * parent.toString will preface the log message.
	 * </p>
	 */
	@UsesDefault @ThreadSafe public final void log(@Nullable ParentType parent,
			Level level, String message, Object... parameters) {
		log(parent, level, message, null, parameters);
	}
	/**
	 * logs a <code>message</code> w/ optional <code>parameters</code> at
	 * <code>level</code>. if <code>preface!=null</code> the message is
	 * prefaced by it. All basic logging methods above work through this method.
	 * See the class's comments for notes on how message & parameters are
	 * processed.
	 * 
	 * @param t
	 *            corresponds to the records thrown parameter, default to
	 *            <code>null</code>
	 * 
	 * @throws NullPointerException
	 *             if <code>message==null</code> & level is enabled
	 */
	@ThreadSafe public final void log(@Nullable ParentType parent, Level level,
			String message, @Nullable Throwable t, Object... parameters) {
		if (!_isLoggable(level)) return;

		LangUtils.checkArgNotNull(message, "message");

		// fix parameters potentially garbled by parameters as specified
		// in the 'log messages' section of the class header
		if (parameters != null && parameters.length > 1 && message.contains("{0}")
				&& !message.contains("{1}") && !message.contains("{2}")
				&& !message.contains("{3}")) {
			parameters=new Object[] {parameters};
		}

		if (parent == null) {
			_log(level, message, parameters, t);
		} else {
			// note that if the message contains {#} references that
			// don't correspond elements in parameters this will generate
			// a garbled message, but GIGO
			if (parameters == null || parameters.length == 0) {
				_log(level, "{0}: " + message, new Object[]{parent}, t);
			} else {
				Object[] newParameters = new Object[parameters.length + 1];
				System.arraycopy(parameters, 0, newParameters, 0, parameters.length);
				newParameters[parameters.length] = _markParent(parent);
				_log(level, "{" + parameters.length + "}: " + message, newParameters, t);
			}
		}
	}
	/**
	 * called by log to perform actual work of writing <code>message</code> to log.
	 * level has already been tested as isLoggable.
	 */
	@ThreadSafe @Hook protected abstract void _log(Level level, String message,
			Object[] parameters,@Nullable Throwable t);
	/**
	 * called to mark <code>parent</code> before putting it at the front of
	 * the parameters array so that it can be easily identified by any filters
	 * needed by enableDebug. Usually it will wrap parent in some object and
	 * return the wrapper.
	 */
	@ThreadSafe @Hook protected abstract Object _markParent(ParentType parent);
	/**
	 * test if messages at level should be processed. should be fast. it is ok
	 * to return true even if the message ultimately won't be logged on occasion but
	 * never return false unless the message definitely can be ignored.
	 */
	@ThreadSafe @Hook protected abstract boolean _isLoggable(Level level);
	// ------------------------------------------------------------------------
	/**
	 * logs initial/current/committed/max JVM heap size from MXBeans Level.INFO.
	 * 
	 * @see MemoryMXBean
	 */
	@ThreadSafe public final void logMemInfo(@Nullable ParentType parent) {
		MemoryMXBean memBean = ManagementFactory.getMemoryMXBean();
		info(parent, "Memory: Heap:{0}\n" + "    Non Heap:{1}\n" + " finalizable:{2}",
			new MemInfo(memBean.getHeapMemoryUsage()), new MemInfo(memBean
				.getNonHeapMemoryUsage()), memBean.getObjectPendingFinalizationCount());
	}

	// ------------------------------------------------------------------------
	// converts a MemoryUsage object into a string
	
	private static final class MemInfo {
		private final MemoryUsage usage;

		MemInfo(MemoryUsage usage) {
			this.usage = usage;
		}

		@Override public final String toString() {
			return "(init:" + format(usage.getInit()) + ", cur:"
					+ format(usage.getUsed()) + " , commit:"
					+ format(usage.getCommitted()) + " max:" + format(usage.getMax())
					+ ")";
		}

		// utility to output an amount of memory
		public final String format(long m) {
			return Long.toString(m);
		}
	}
	
	// ------------------------------------------------------------------------
	// output control
	@UsesDefault @ThreadSafe public void enableDebug() {
		enableDebug(null);
	}
	/**
	 * tells this logger to show all output. Meant to be enabled only when
	 * debugging a subsystem. Note that multiple calls to enableDebug will be
	 * composed together such that if any calls with <code>parent=null</code>
	 * are made than all output will be shown, un-filtered, and otherwise only
	 * message prefaced with <code>null</code> or one of the specified parents
	 * will be shown. Note that parents are compared using
	 * <code>parent.equals</code> so that if a particular parent is enabled
	 * all parents that are .equals equivalent to it will be allowed. They are
	 * also stored using {@link java.lang.ref.WeakReference}s so that a parent
	 * will eventually be removed from the filter list if it is no longer
	 * accessible.
	 * 
	 * @param instance
	 *            defaults to <code>null</code>. if not <code>null</code>
	 *            only log messages prefaced with the parent or
	 *            <code>null</code> are displayed.
	 */
	@ThreadSafe public abstract void enableDebug(
			final @Nullable ParentType instance);
	// ------------------------------------------------------------------------
	/**
	 * test LogEx by calling various logging methods. A user would need to read
	 * the output and verify that it is correct.
	 */
	public static void main(String[] args) {
		// do this in a sperate class because implementations may filter traces
		// from methods in LogEx
		SampleClass.sampleRun();
	}
}
//used by main for debugging
class SampleClass{
	public static final void sampleRun() {
		System.err.println("testing LogEx, a series of numbered messages should follow");
		System.err.println("if any numbers are skipped or any messages that start XXX");
		System.err.println("are shown something is wrong");
		System.err.println("order might be mangled however");
		System.err.println();
		LogEx<Integer> log=LogEx.createClassLog(Integer.class);
		
		log.error(null, "1.sample error w.o. parent");
		log.error(9, "2.sample error w. parent=9");
		log.error(null, "3.sample error caused by:",new Throwable());
		log.error(null, "4.sample error w.o. parent w. parameters=0,1:{0},{1}",0,1);
		log.error(11, "5.sample error w. parent=11 parameters=0,1:{0},{1}",0,1);
		log.error(11,"6.sample error w. parent=11 & mangled parameters" +
			" ''{0}'' (should be array of 3 nulls)",new Object[3]);
		log.warning(null, "7. sample warning w.o. parent");
		log.info("8. sample info w.o. parent");
		log.config("9. sample config w.o. parent");
		log.debug("XXX sample debug w.o. parent, SHOULD NOT SHOW");
		log.enableDebug();
		log.debug("10. sample debug w.o. parent");
		log.warning(null,"11. sample warning w.o. parent");
		SampleClass.sampleFunc(41,12,log);
		
		log.logMemInfo(15521);
		System.err.println("14. should have output some memory info w. parent 15521 above");
		
		System.err.println("15. finished");
	}
	public static final void sampleFunc(int a,int b,LogEx<Integer> log) {
		log.debugEnter(43, "a, b", a, b);
		System.out.println("12. should have output something like 'sampleFunc({"+a+"},{"+b+"}){' above");
		log.debugReturnVoid(10,"13. A.OK w.o. parent");
	}
}