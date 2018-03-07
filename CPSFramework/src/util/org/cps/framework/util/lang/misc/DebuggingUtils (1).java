package org.cps.framework.util.lang.misc;

import org.apache.commons.lang.ObjectUtils;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.WeakHashMap;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.LogRecord;
import java.util.logging.Logger;
import java.util.logging.StreamHandler;
/**
 * @version 0.1
 * @author Amit Bansil
 */
public class DebuggingUtils {
	private static final Logger log =
		Logger.getLogger(DebuggingUtils.class.getName());
	private static final Map<String,Map<Object,Integer>> objectIDs = new HashMap<String,
		Map<Object,Integer>>();
	private static Object COUNT_KEY = new Object();
	/*
	 * returns an objects name, ideally the result of getName() if the class
	 * implements that method and returns a non null value. otherwise the class
	 * name is substituted. slow.
	 */
	public static final String getName(Object o) {
		if (o == null)
			return "null";
		try {
			Object r =
				o.getClass().getMethod("getName", EMPTY_CLASS_ARRAY).invoke(
					o,
					(Object[])null);
			if ((r != null && r instanceof String) && (((String)r).length()!=0))
				return (String) r;
		} catch (Throwable t) {
			log.log(
				Level.FINEST,
				"error {0} getting name for {1}",
				new Object[] { t, o });
		}
		return StringUtilsEx.getLastCompontent(o.getClass().getName());
	}
	private static final Class[] EMPTY_CLASS_ARRAY = new Class[0];
	/*
	 * a name for an object more descriptive than the hashcode, returns
	 * getName() followed by an ID# unique for that name returns "null" for
	 * null slow.
	 */
	public static final String getNamedID(Object o) {
		if (o == null)
			return "null";
		assert !o.equals(COUNT_KEY);
		String name = getName(o);
		Map<Object,Integer> ids = objectIDs.get(name);
		if (ids == null) {
			ids = new WeakHashMap<Object,Integer>();
			objectIDs.put(name, ids);
			if (objectIDs.size() > OBJECT_ID_LOG_WARNING_SIZE)
				log.log(
					Level.SEVERE,
					"object id map contains {0} elements, may degrade performance",
					new Integer(objectIDs.size()));
			ids.put(COUNT_KEY, ZERO);
		}
		Integer id=ids.get(o);
		if(id==null){
			//can't throw null pointer
			int count = ids.get(COUNT_KEY).intValue();
			count++;
			if (ids.size() > NAME_LOG_WARNING_SIZE)
				log.log(
					Level.SEVERE,
					"id map for name {1} contains {0} elements, may degrade performance",
					new Object[]{new Integer(ids.size()),name});
			id=new Integer(count);
			ids.put(COUNT_KEY,id);
			ids.put(o, id);
			
		}
		return name+" "+id;
	}
	private static final int OBJECT_ID_LOG_WARNING_SIZE = 10000,
		NAME_LOG_WARNING_SIZE = 1000;
	private static final Integer ZERO = new Integer(0);
	//	RIPPED FROM java.util.logging.SimplerFormatter
	//an ultra simple logger good for system.out
	//Singleton
	//don't need hires time since records use system
	protected static final long start = System.currentTimeMillis();
	public static Formatter realSimpleFormatter = new Formatter() {
		private String lineSeparator =
			(String) java.security.AccessController.doPrivileged(
			new sun.security.action.GetPropertyAction("line.separator"));
		public synchronized String format(LogRecord record) {
			StringBuffer sb = new StringBuffer();
			// Minimize memory allocations here.
			String message = formatMessage(record);
			sb.append(record.getLevel().getLocalizedName());
			sb.append(": ");
			sb.append(message);

			if (record.getThrown() != null) { //should really not be used...
				try {
					StringWriter sw = new StringWriter();
					PrintWriter pw = new PrintWriter(sw);
					record.getThrown().printStackTrace(pw);
					pw.close();
					sb.append(sw.toString());
				} catch (Exception ex) {
					throw new Error(ex);
				}
			}

			//		time
			sb.append(" (t=" + (record.getMillis() - start) / 1000f + "s)");

			sb.append(lineSeparator);

			return sb.toString();
		}
	};

	/**
	 * real simple formatter to System.out based on ConsoleHandler
	 */
	public static final StreamHandler outConsoleHandler =new StreamHandler(System.out,realSimpleFormatter) {
		public void publish(LogRecord record) {
			super.publish(record);
			flush();
		}
		public void close() {
			flush();
		}
	};
	/*
	 * logs change at Level.FINER w/o showing old
	 */
	public static final void logChange(
		Logger logger,
		Object fieldHolder,
		String field,
		Object value) {
		logChange(logger, Level.FINER, fieldHolder,field, value);
	}
	/*
	 * logs change w/o showing old
	 */
	public static final void logChange(
		Logger logger,
		Level logLevel,
	Object fieldHolder,
		String field,
		Object value) {
		logChange(logger, logLevel, fieldHolder,field, value, false);
	}
	/**
	 * utility method log a value only when it changes. not very fast. values
	 * indexed by fieldName and logger. currently if too may objects build up
	 * in the log a warning will be printed, perhaps it may be better to use a
	 * RefrenceMap the KeyHolder and key are combined to name the object.
	 * either key/keyHolder may be null, but if both are null it's an error.
	 * 
	 * @param logger
	 *            output Logger
	 * @param logLevel
	 *            msg LogLevel
	 * @param fieldHolder
	 *            object holding field, required
	 * @param fieldName
	 *            not required
	 * @param value
	 *            value that may be changed
	 * @param showOldValue
	 *            will log old and new values if true otherwise only new
	 */
	public static final void logChange(
		Logger logger,
		Level logLevel,
	Object fieldHolder,
		String fieldName,
		Object value,
		boolean showOldValue) {
		if (logger.isLoggable(logLevel)) {
			synchronized (changeLog) {
				//resolve field name
				if(fieldName==null) fieldName="";
				if(fieldHolder==null){
					if(fieldName.length()==0)throw new NullPointerException("both key&key holder are unset");
				}else{
					String kn=DebuggingUtils.getNamedID(fieldHolder);
					if(fieldName.length()==0)fieldName=kn;
					else fieldName=kn+":"+fieldName;
				}
				//value to string
				value=ObjectUtils.toString(value);
				//get old value
				Map<String,Object> m = getChangeLog(logger);
				String oldValue = (String)m.get(fieldName);
				
				//don't do anything if no change
				if (!ObjectUtils.equals(value, oldValue)) return;
					
				//warn if log overflowing
				if (m.size() > CHANGE_LOG_MAP_WARNING_SIZE)
					log.log(
						Level.SEVERE,
						"change log map for logger {1} contains {0} elements, may degrade performance",
						new Object[] { new Integer(m.size()), logger });
				
				//save value
				m.put(fieldName, value);
				
				//print change
				if (showOldValue)
					logger.log(
						logLevel,
						"'{0}'='{1}'->'{2}'",
						new Object[] { fieldName, oldValue, value });
				else
					logger.log(
						logLevel,
						"'{0}'='{1}'",
						new Object[] { fieldName, value });
				
			}
		}
	}
	public static final int CHANGE_LOG_MAP_WARNING_SIZE = 1000;
    //UNCLEAR changelog may leak but loggers usually static
	private static final Map<Logger,Map<String,Object>> changeLog = new HashMap<Logger,Map<String,Object>>();
	private static final Map<String,Object> getChangeLog(Logger l) {
		if (!changeLog.containsKey(l))
			changeLog.put(l, new HashMap<String,Object>());
		return changeLog.get(l);
	}
}
