/*
 * RunnableQueue.java CREATED: Dec 22, 2003 12:49:06 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.event.queue;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 * Utility class to execute a series of runnables. NOT SYNCHRONIZED. order of
 * execution is FIFO. normally add runnables then push pending then execute
 * pending. runnables can be added/ removed during pending executing.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public final class ListRunnableQueue {
	private final Logger log;

	private final boolean logRunnables;

	public ListRunnableQueue(Logger log) {
		this.log = log;
		//for performance logRunnables is set once
		logRunnables = log.isLoggable(Level.FINER);

	}

	private int pendingCount = 0;

	private int queueCount = 0;

	private final List<Runnable> queue = new ArrayList<Runnable>(30);

	private Runnable[] pending = new Runnable[30];

	/*
	 * checks if any runnables pending
	 */
	public final boolean isEmpty() {
		return queueCount == 0;
	}

	/**
	 * pushes queue to pending and clears queue
	 * 
	 * @throws IllegalStateException
	 *             if runnables already pending
	 */
	public final void pushQueue() {
		if (pendingCount != 0)
				throw new IllegalStateException("unexecuted events pending");
		if (queueCount > pending.length) {
			//expand array
			pending = new Runnable[queueCount];
		}
		queue.toArray(pending);
		pendingCount = queueCount;
		removeAll();
	}
	/**
	 * executes pending and clears them
	 *
	 */
	public final void executePending() {
		while (pendingCount>0) {
			pendingCount--;
			try {
				if (logRunnables) {
					log.log(Level.FINER, "running {0}", pending[pendingCount]);
					pending[pendingCount].run();
					log.log(Level.FINER, "done {0}", pending[pendingCount]);
				} else {
					pending[pendingCount].run();
				}
			} catch (Exception e) {
				log.log(Level.SEVERE, "exception running {0}:{1}",
						new Object[]{pending[pendingCount], e});
				log.log(Level.INFO,"exeption details",e);
			}
			pending[pendingCount]=null;
		}
	}
	/**
	 * pushes&executes pending until none left.
	 * overflows if it takes more than a hundred cycles to do this
	 */
	public final void executeAll() {
		for (int i = 0;!queue.isEmpty(); i++) {
			if(i>=100){
				log.severe("shutdown hook overflow");
				cleanup();
				break;
			}
			pushQueue();
			executePending();
		}
	}
	/**
	 * add runnable to queue
	 * 
	 * @param r
	 */
	public final void addRunnable(Runnable r) {
		queue.add(r);
		queueCount++;
		if (logRunnables) log.log(Level.FINER, "added pending {0}", r);

	}

	/**
	 * remove runnable from queue
	 * 
	 * @param r
	 * @throws IllegalArgumentException
	 *             if runnable no in queue
	 */
	public final void removeRunnable(Runnable r) {
		if (!queue.remove(r))
				throw new IllegalArgumentException("runnable " + r
						+ " not in queue");
		queueCount--;
		if (logRunnables) log.log(Level.FINER, "removed from queue {0}", r);

	}

	private final void removeAll() {
		queueCount = 0;
		queue.clear();
	}

	/**
	 * cleanup,if anything left in queue warns about it and kills
	 */
	public final void cleanup() {
		if (!isEmpty()) {
			log.log(Level.WARNING, "unremoved runables:{0}",
					new Object[]{queue.toArray()});
			removeAll();
		}
	}
}
