/*
 * CREATED ON:    Dec 24, 2005 11:57:27 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Nullable;
import cps.jarch.util.notes.Singleton;
import cps.jarch.util.notes.ThreadSafe;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.logging.Filter;
import java.util.logging.Formatter;
import java.util.logging.Handler;
import java.util.logging.LogRecord;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;
import java.util.logging.StreamHandler;

/**
 * <p>LogEx implementation using java.util.logging.
 * </p>
 * @version $Id: LoggerLogEx.java 84 2006-01-20 04:32:54Z bansil $
 * @author Amit Bansil
 */
public class LoggerLogEx<ParentType> extends LogEx<ParentType> {
	public static final void setGlobalLevelImpl(cps.jarch.util.misc.LogEx.Level l) {
		//note that if their is some weird logging configuration in place
		//this might not do much
		Logger.getLogger("").setLevel(convertLevel(l));
	}
	
	private final Logger logger;
	public LoggerLogEx(Class<ParentType> owner){
		logger=Logger.getLogger(owner.getName());
	}

	private static final java.util.logging.Level convertLevel(cps.jarch.util.misc.LogEx.Level level) {
		switch(level) {
			case ERROR:
				return java.util.logging.Level.SEVERE;
			case WARNING:
				return java.util.logging.Level.WARNING;
			case INFO:
				return java.util.logging.Level.INFO;
			case CONFIG:
				return java.util.logging.Level.CONFIG;
			case DEBUG:
				return java.util.logging.Level.FINE;
			default:
				throw new Error("unexpected level "+level);
		}
	}

	@Override protected Object _markParent(ParentType parent) {
		return new Parent(parent);
	}
	@Override protected boolean _isLoggable(cps.jarch.util.misc.LogEx.Level level) {
		return logger.isLoggable(convertLevel(level));
	}
	
	//------------------------------------------------------------------------
	// internal logging support

	// logs a message, derived from JDK1.5.0_01
	// Logger.log(Level,String,Object[])
	@Override @ThreadSafe protected void _log(cps.jarch.util.misc.LogEx.Level level, String message, Object[] parameters,
			Throwable t) {
		LogRecord lr = new LogRecord(convertLevel(level), message);

		// expand parameters that are arrays, note performance hit here
		if (parameters != null)
			for (int i = 0; i < parameters.length; i++) {
				parameters[i] = StringUtils.deepToString(parameters[i]);
			}

		lr.setParameters(parameters);

		lr.setLoggerName(logger.getName());

		lr.setThrown(t);

		// note that resource bundle is not set

		inferCaller(lr);

		logger.log(lr);
	}

	// set source class & source method name on r derived from JDK1.5.0_01
	// LogRecord.inferCaller
	private static void inferCaller(LogRecord r) {
		// Get the stack trace.
		StackTraceElement stack[] = (new Throwable()).getStackTrace();
		// First, search back to a method in the Logger class.
		int ix = 0;
		while (ix < stack.length) {
			StackTraceElement frame = stack[ix];
			if (isHiddenFrame(frame)) {
				break;
			}
			ix++;
		}
		// Now search for the first frame before the "Logger" class.
		while (ix < stack.length) {
			StackTraceElement frame = stack[ix];
			if (!isHiddenFrame(frame)) {
				// We've found the relevant frame.
				r.setSourceClassName(frame.getClassName());
				r.setSourceMethodName(frame.getMethodName());
				return;
			}
			ix++;
		}
		// We haven't found a suitable frame, so just punt. This is
		// OK as we are only committed to making a "best effort" here.
	}

	// ------------------------------------------------------------------------
	// Stack frame hiding

	private static final String LOGEX_CLASS_NAME = LogEx.class.getName();
	private static final String IMPL_CLASSNAME = LoggerLogEx.class.getName();

	// test if a stack frame should be hidden from log output
	private static boolean isHiddenFrame(StackTraceElement frame) {
		String cname = frame.getClassName();
		return cname.equals("java.util.logging.Logger") || cname.equals(LOGEX_CLASS_NAME)||
			cname.equals(IMPL_CLASSNAME);
	}
	
	// ------------------------------------------------------------------------

	
	@Override @ThreadSafe public void enableDebug(final @Nullable ParentType parent) {
		synchronized(debugOutputters){
			Outputter debugOutputter=debugOutputters.get(logger.getName());
			// create debugOutputter if we don't have one yet
			if (debugOutputter == null) debugOutputters.put(logger.getName(),
				debugOutputter = new Outputter(logger));
	
			// if everything is being allowed through just quit
			if (!debugOutputter.isFilterParents()) return;
	
			if (parent == null) {
				// if parent is null allow everything
				debugOutputter.setFilterParents(false);
			} else {
				// otherwise enable this parent
				debugOutputter.setParentAllowed(parent, true);
			}
		}
	}
	//note that access to debugOutputters must be synchronized as above.
	//we need to keep a map of these so that there is only 1 debugOutputter per logger
	//maps loggername->Outputter
	private static final Map<String,Outputter> debugOutputters=new HashMap<String, Outputter>();
	
	// ------------------------------------------------------------------------
	// utility classes
	private static final class Outputter {
		private final Logger log;
		Outputter(Logger log) {
			this.log=log;
			handler.setLevel(java.util.logging.Level.ALL);
			log.setLevel(java.util.logging.Level.ALL);
			handler.setFilter(filter);
			setFilterParents(true);
			log.addHandler(handler);
		}

		private final Handler handler = new SystemOutHandler();
		private boolean filterParents=false;
		final void setFilterParents(boolean v) {
			filterParents=v;
		}

		final boolean isFilterParents() {
			return filterParents;
		}

		private final Object value = new Object();

		// OPTIMIZE use a specialized WeakSet here
		private final WeakHashMap<Object, Object> allowedParents = new WeakHashMap<Object, Object>();

		// add/remove a parent from the list of allowed parents
		// filtered parents are kept in a weak hash map to prevent memory leaks
		final void setParentAllowed(Object parent, boolean v) {
			if (v) allowedParents.put(parent, value);
			else allowedParents.remove(parent);
		}

		// only log messages from allowed parents & that wouldn't be picked up
		//by the parent logger
		private final Filter filter = new Filter() {
			public boolean isLoggable(LogRecord record) {
				if (log.getParent().isLoggable(record.getLevel())) return false;
				
				if(!filterParents)return true;
				
				Object recordParent = getParent(record);

				// static context
				if (recordParent == null) {
					return true;
				} else {
					return allowedParents.containsKey(recordParent);
				}
			}

			private final @Nullable Object getParent(LogRecord r) {
				Object[] params = r.getParameters();
				if (params == null || params.length == 0) return null;
				Object lastParam = params[params.length - 1];
				if (!(lastParam instanceof Parent)) return null;
				return ((Parent) lastParam).get();
			}
		};
	}


	// ------------------------------------------------------------------------
	// simple wrapper class used to mark parent in arguments
	private static final class Parent {
		private final Object type;

		public final Object get() {
			return type;
		}

		public Parent(Object type) {
			LangUtils.checkArgNotNull(type);
			this.type = type;
		}

		@Override public String toString() {
			return type.toString();
		}
	}

	// ------------------------------------------------------------------------
	// System.out handler derived from JDK1.5.0_01 console handler
	private static final class SystemOutHandler extends StreamHandler {
		SystemOutHandler() {
			setOutputStream(System.out);
			setFormatter(VerySimpleFormatter.getInstance());
		}

		@Override public synchronized void publish(LogRecord record) {
			super.publish(record);
			// OPTIMIZE this makes many unneeded calls to flush, especially if
			// the filter blocks many of the messages, they may not have any
			// penalty
			// if their is nothing to flush however.
			//flush();
		}

		@Override public synchronized void close() {
			flush();
		}
	}

	// ------------------------------------------------------------------------
	/**
	 * This formatter is designed for debug output.
	 * it shows about half the info of the regular SimpleFormatter.
	 */
	private static @Singleton class VerySimpleFormatter extends SimpleFormatter {
		private static final VerySimpleFormatter INSTANCE = new VerySimpleFormatter();

		public static final Formatter getInstance() {
			return INSTANCE;
		}

		private VerySimpleFormatter() {
			super();
		}

		@SuppressWarnings("unchecked") private String lineSeparator = (String) java.security.AccessController
			.doPrivileged(new sun.security.action.GetPropertyAction("line.separator"));

		private StringBuilder sb;

		@Override public synchronized String format(LogRecord record) {
			if (this.sb == null) this.sb = new StringBuilder(80);
			else this.sb.setLength(0);
			
			StringBuilder sb = this.sb;
			// level
			String message = formatMessage(record);
			sb.append(record.getLevel().getLocalizedName());
			sb.append(": ");
			// class name
			String className=record.getSourceClassName();
			if (className == null) {
				className=record.getLoggerName();
			}
			int lastDot=className.lastIndexOf('.');
			if(lastDot!=-1)className=className.substring(lastDot+1);
			sb.append(className);
			sb.append('#');

			// method name
			if (record.getSourceMethodName() != null) {
				sb.append(record.getSourceMethodName());
				sb.append(": ");
			}
			// message
			sb.append(message);
			sb.append(lineSeparator);
			// exception
			if (record.getThrown() != null) {
				try {
					StringWriter sw = new StringWriter();
					PrintWriter pw = new PrintWriter(sw);
					record.getThrown().printStackTrace(pw);
					pw.close();

					sb.append(sw.toString());
				} catch (Exception ex) {
					// an exception here is a very bad thing.
					// all we can do is hope that System.err is working
					System.err
						.println("An unexpected exception was caught while trying print a log record");
					System.err.println("Log Record:" + record.toString());
					System.err.println("Exception:" + ex.toString());
					ex.printStackTrace();
				}
			}
			return sb.toString();
		}
	}
}
