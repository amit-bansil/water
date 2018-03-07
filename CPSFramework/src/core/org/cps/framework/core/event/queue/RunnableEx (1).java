/*
 * RunnableEx.java CREATED: Dec 27, 2003 6:54:25 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.event.queue;

import java.lang.reflect.InvocationTargetException;

/**
 * a runnable that allows cross thread synchronous exception and return type
 * propogation. TEST that synchronization works
 * 
 * @version 0.1
 * @author Amit Bansil
 */
//TODO generic exception type
public interface RunnableEx<RT> {
	/**
	 * adapter to standard runnable. normally push on queue and then call done.
	 * synchronization MUST occur externally.
	 */
	public static final class RunnableExAdapter<RT2> implements Runnable {
		private RT2 ret = null;

		private boolean run = false;

		private Exception e = null;

		private final RunnableEx<RT2> r;

		public RunnableExAdapter(RunnableEx<RT2> r) {
			this.r = r;
		}

		public final void run() {
			try {
				ret = r.run();
			} catch (Exception e_l) {
				//UNCLEAR better to catch throwable???
				//what about thread death...
				this.e = e_l;
			} finally {
				run = true;
			}
		}

		//returns results of run
		public final RT2 done() throws InvocationTargetException {
			if (!run)
					throw new Error("not synchronized; done called before run");

			if (e != null) throw new InvocationTargetException(e);
			return ret;
		}
	}

	public RT run() throws Exception;
}
