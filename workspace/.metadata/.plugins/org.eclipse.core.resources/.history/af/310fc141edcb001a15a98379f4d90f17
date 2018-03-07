package cps.jarch.application;

import java.io.File;

/**
 * static subsystem that keeps a detailed log of everything in the local
 * filesystem
 * 
 * TODO implement
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ErrorFileLogging {
	/**
	 * when verbose logging is enabled the consoles as well as all logs above
	 * Level.FINE are logged to a single temp file. This file is automatically
	 * deleted on normal program termination
	 * otherwise 
	 * 		logs only Level.SEVERE & Sys.err to tempfile
	 * 
	 * the log should begin with config info:path to log file (FRIST) and:
	 * jvm/os/mem/arch info from mxbeans env variables, sys.properties, user
	 * info, etc.
	 * 
	 * also enable verbose logging on all mx beans
	 * 
	 * rem to log consoles through loggers at Level.INFO & Level.SEVERE
	 * 
	 * rem. to authflush severe amd setup (flush), close,delete on exit
	 * 
	 * @throws IllegalStateException
	 *             if logging enabled
	 * 
	 * @return true if appending old log
	 */
	public static final boolean enableVerboseLogging(boolean verbose) {
		return false;
	}

	/**
	 * @return true if logging is enabled
	 */
	public static final boolean isEnabled() {
		return false;
	}
	
	/**
	 * 
	 * @throws IllegalStateException
	 *             if logging not yet enabled
	 */
	public static final boolean isVerbose() {
		throw new IllegalStateException("logging not enabled");
	}

	/**
	 * checks if log contains errors (i.e. severe log data)
	 * 
	 * always true when no logging
	 * 
	 * app should check on shutdown and prompt user to upload if it isn't clean
	 * 
	 * @throws IllegalStateException
	 *             if logging not yet enabled
	 */
	public static final boolean isClean() {
		throw new IllegalStateException("logging not enabled");
	}

	/**
	 * @return file log is being written to
	 * @throws IllegalStateException
	 *             if logging not yet enabled
	 */
	public static final File getTargetFile() {
		throw new IllegalStateException("logging not enabled");
	}
	
	/**
	 * flushes all logs to file, rem. to do this on save
	 */
	public static final void flush() {
		throw new UnsupportedOperationException();//TODO
	}
}
