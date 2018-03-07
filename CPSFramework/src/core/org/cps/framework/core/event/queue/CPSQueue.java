/**
 * VMDL2. Created on Jan 19, 2003 by Amit Bansil. Copyright 2002 The Center for
 * Polymer Studies, All rights reserved.
 */
package org.cps.framework.core.event.queue;

import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * handles execution of actions encapsulated in runnables. very fast, designed
 * for use in RT apps with high percision timing etc. starts when
 * appcount>=1;dies when appcount=0
 * TODO support mutltithreading with an execute async command
 * (should have a pool of extra threads (say #(processors*2)-1)waiting,
 *  execute asyn is called from extra thread with an aSyncRunnable
 *  which has CPSInit,AsyncRun,CPSFinish & progress+cancel+(?)pause hooks)
 * ...really there should be an Action package which has progress stuff as well
 * ...eventqueues should be abstracted so that posting from CPStoSwing can be automatic
 * @version 0.1
 * @author Amit Bansil
 */
public final class CPSQueue implements Runnable {
	//CONSTANTS
	private static final int DEFAULT_PRIORITY = Thread.NORM_PRIORITY; //?

	private static final Logger logger = Logger.getLogger(CPSQueue.class
			.getName());
	//in nanoseconds
	//must be > 1ms or we'll end up calling wait(0), which will hang
	public static final int MIN_WAIT = 2*1000*1000;

	public static final CPSQueue getInstance() {
		return QueueManager.getInstance();
	}
	//MEMBERS

	private final ListRunnableQueue externalQueue = new ListRunnableQueue(
			Logger.getLogger(logger.getName() + ".externalQueue"));

	private final TimedRunnableQueue cpsLaterQueue = new TimedRunnableQueue(
			Logger.getLogger(logger.getName()+".cpsLaterQueue"));
	
	private final ListRunnableQueue cpsNowQueue =new ListRunnableQueue(
			Logger.getLogger(logger.getName() + ".cpsNowQueue"));
	
	private final Thread thread;
	
	private final Object threadLock = new Object();
	
	private boolean waiting = false;
	
	private boolean alive = true;
	
	//CONSTRIUCTOR
	public CPSQueue() {
		thread = new Thread(this, "CPS Event Thread");
		setPriority(DEFAULT_PRIORITY);
		thread.start();
	}

	//THREAD CHECKS
	//TODO rename,make static using getInstance()??
	public final void checkThread() {
		if (!isInCPSThread()) throw new Error("!in CPS thread");
	}

	public boolean isInCPSThread() {
		return Thread.currentThread().equals(thread);
	}
	//THREAD PRIORITY
	public final int getPriority() {
		return thread.getPriority();
	}
	public final void setPriority(int p) {
		logger.log(Level.FINER, "priority={0}", new Integer(p));
		thread.setPriority(p);
	}
	//THREAD STATE
	public final void kill() {
		alive = false;
	}
	//TIMING-in nanoseconds
	public final long getTrueTime() {
		return System.nanoTime();
	}
	public long getNextFrameTime() {
		checkThread();
		if(!hasNextFrame())throw new IllegalStateException("no next frame yet");
		return cpsLaterQueue.getNextTime();
	}
	public boolean hasNextFrame() {
		checkThread();
		return cpsLaterQueue.getNextTime()!=Long.MAX_VALUE;
	}
	public long getFrameTime() {
		return time;
	}
	/**
     * posts a runnable from the cps queue to execute on the cpsqueue ASAP.
     * returns immediatly.
     * 
     * @param r
     */
	public final void postRunnableCPSNow(Runnable r) {
		checkThread();
		cpsNowQueue.addRunnable(r);
	}
	/**
     * schedules a runnable to execute later. on CPS. returns immediatly. if two
     * events want to run in the same time slice higher priority takes
     * prescedence. no gaurantee is made that r will run exactly at time t but
     * it will execute before any r schueled to run later even if at a lower
     * priority.
     * 
     * @param r task to execute
     * @param t TrueTime to run at
     * @param p priority run at.
     * @throws Error if not in CPS thread
     * @throws IllegalArgumentException if t>Long.MAX_VALUE/2
     */
	public final void postRunnableCPSLater(Runnable r, long t, int p) {
		checkThread();
		cpsLaterQueue.postRunnable(r,t,p);
	}
	/**
     * utility to post a runnable from any thread (including CPS) that will
     * execute later on CPS thread.  returns immediately
     * 
     * @param r
     */
	public final void postRunnable(Runnable r){
	    if(isInCPSThread()) postRunnableCPSNow(r);
	    else postRunnableExt(r);
	}
	/**
     * pushes a runnable from another thread onto CPS. returns immediatly.
     * 
     * @param r the runnable
     * @throws Error if already on CPS thread
     */
	public final void postRunnableExt(Runnable r) {
		if (isInCPSThread()) throw new Error("in CPS thread");

		synchronized (threadLock) {
			externalQueue.addRunnable(r);
			if (waiting) threadLock.notify();
		}
	}
	private long time;
	public void run() {
		while (alive) {
			time=getTrueTime();
			long nextTime=cpsLaterQueue.getNextTime();
			//check once to avoid unneeded sync
			if (time + MIN_WAIT < nextTime&&externalQueue.isEmpty()) {
				//assuming this sync is quick no need to recalc time
				synchronized (threadLock) {
					waiting = true;
					//OPTIMIZE call getTrueTime less
					do{
						try {
							//TODO round instead of truncate?
							threadLock.wait(( nextTime - time) / (1000l*1000l));
							time=getTrueTime();
						} catch (InterruptedException e) {
							//should not happen
							logger.log(Level.SEVERE, "CPSThread interrupted", e);
						}
					}while(externalQueue.isEmpty()
							&&time + MIN_WAIT < nextTime);
					waiting = false;
				}
			} else {
				Thread.yield();
				time=getTrueTime();
			}
			if(time + MIN_WAIT >= nextTime) {
			    //executes only one slice of events at a time
				cpsLaterQueue.executeNext();
			}
			if (!externalQueue.isEmpty()) {
				synchronized (threadLock) {
					externalQueue.pushQueue();
				}
				externalQueue.executePending();
			}
			//has to be last otherwise we might end up waiting
			//even with nowQueue events pending
			cpsNowQueue.executeAll();
		}
		cpsNowQueue.cleanup();
		externalQueue.cleanup();
		cpsLaterQueue.cleanup();
		assert cpsNowQueue.isEmpty()&&externalQueue.isEmpty()&&cpsLaterQueue.isEmpty();
		
		//ERROR!!!!! hack for not exiting
		System.exit(0);
	}
}
