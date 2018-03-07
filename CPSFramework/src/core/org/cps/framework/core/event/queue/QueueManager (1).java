/*
 * QueueManager.java
 * CREATED:    Dec 22, 2003 11:07:58 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.queue;


import java.util.HashSet;
import java.util.Set;

/**
 * handles creating/killing queue
 * a queue is only available when a lock is held
 * @version 0.1
 * @author Amit Bansil
 */
public class QueueManager {

	private static CPSQueue INSTANCE;
	public static final CPSQueue getInstance() {
		if (INSTANCE == null) {
			assert locks.isEmpty();
			throw new IllegalStateException("no locks taken out");
		}
		assert !locks.isEmpty();
		return INSTANCE;
	}
	private static final Set<Object> locks = new HashSet<Object>();
	//returns lock
	public static final synchronized Object checkoutLock() {
		if (locks.isEmpty()) {
			if (INSTANCE != null)
				throw new UnknownError();
			INSTANCE = new CPSQueue();
		}
		Object lock = new Object();
		if (!locks.add(lock))
			throw new UnknownError();
		return lock;

	}
	public static final synchronized void checkinLock(Object lock) {
		if(!locks.remove(lock))throw new IllegalArgumentException("lock not checkedout");
		if (locks.isEmpty()) {
			assert INSTANCE != null;
			INSTANCE.kill();
			INSTANCE=null;
		}
	}
}
