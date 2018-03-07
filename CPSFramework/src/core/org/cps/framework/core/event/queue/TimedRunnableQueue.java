/*
 * PrioritizedRunnableQueue.java CREATED: Dec 31, 2003 1:48:10 PM AUTHOR: Amit
 * Bansil PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.event.queue;

import java.util.PriorityQueue;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * queue that executes runnables at a specific time in a specific order
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class TimedRunnableQueue {
	private static final class PrioritizedRunnable implements Comparable {
		protected final Runnable r;

		protected final int priority;

		protected final long time;

		public PrioritizedRunnable(final Runnable r, final int priority,
				final long time) {
			this.r = r;
			this.priority = priority;
			this.time = time;
		}

		//TEST that this works with priorityquee since equals not
		// overloaded+no comparator
		public int compareTo(Object o) {
			PrioritizedRunnable p = (PrioritizedRunnable) o;
			if (p.time < time) return -1;
			else if (p.time > time) return 1;

			if (p.priority > priority) return -1;
			else if (p.priority < priority) return 1;

			return 0;
		}
	}

	private final Logger logger;

	private long nextTime = Long.MAX_VALUE;

	public TimedRunnableQueue(Logger log) {
		super();
		this.logger = log;
	}

	//TODO warn when now queue excedes this limit
	private final PriorityQueue<PrioritizedRunnable> runnableQueue = new PriorityQueue<PrioritizedRunnable>(50);
	public final boolean isEmpty() {
		return runnableQueue.isEmpty();
	}
	public final void postRunnable(Runnable r, long t, int p) {
		if (t > Long.MAX_VALUE / 2)
				throw new IllegalArgumentException("time overflow");
		runnableQueue.add(new PrioritizedRunnable(r, p, t));
		if (t < nextTime) nextTime = t;
		if (logger.isLoggable(Level.FINER)) {
			logger.log(Level.FINER,
					"runnable {2} schueled to run at {0}, priority {1}",
					new Object[]{new Long(t), new Integer(p), r});
		}
	}

	/**
	 * @return trueTime of next execution or Long.MAX_VALUE if no next
	 */
	public long getNextTime() {
		return nextTime;
	}

	/**
	 * executes all runnables schueled to run at same time as head of queue.
	 */
	public final void executeNext() {
		final boolean logFinest=logger.isLoggable(Level.FINEST);
		while (nextTime != Long.MAX_VALUE) {
			PrioritizedRunnable r = runnableQueue.poll();
			PrioritizedRunnable next = runnableQueue.peek();

			if (next == null) nextTime = Long.MAX_VALUE;
			else
				nextTime = r.time;

			try {
				if(logFinest)logger.log(Level.FINEST,"running {0}",r);
				r.r.run();
				if(logFinest)logger.log(Level.FINEST,"done running {0}",r);
			} catch (Throwable e) {
				//UNCLEAR better to catch only exceptions??
				if (e instanceof ThreadDeath) throw (ThreadDeath) e;
				logger.log(Level.SEVERE, "uncaught throwable running {0}:{1}",
						new Object[]{r.r, e});
				logger.log(Level.INFO,"exeption details",e);
			}
			if (r.time != nextTime) break;
		}
	}


	/**
	 * cleanup,if anything left in queue warns about it and kills
	 */
	public final void cleanup() {
		if (!isEmpty()) {
			logger.log(Level.WARNING, "unremoved runables:{0}",
					new Object[]{runnableQueue.toArray()});
			runnableQueue.clear();
		}
	}
}
