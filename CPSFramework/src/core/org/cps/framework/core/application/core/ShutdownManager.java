/*
 * ShutdownManager.java CREATED: Dec 22, 2003 2:52:34 AM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.application.core;

import java.util.logging.Logger;

import org.cps.framework.core.event.core.VetoException;
import org.cps.framework.core.event.property.ConstrainablePropertyRO;
import org.cps.framework.core.event.property.ConstrainablePropertyRW;
import org.cps.framework.core.event.property.DefaultConstrainedPropertyRW;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.queue.ListRunnableQueue;
import org.cps.framework.core.event.queue.QueueManager;

/**
 * handles application shutdown
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ShutdownManager {
	private final Object lock;

	public ShutdownManager(Object lock) {
		this.lock = lock;
	}

	//log
	private static final Logger log = Logger.getLogger(ShutdownManager.class
			.getName());

	//shutdown
	private boolean shutdown = false;

	private final ListRunnableQueue queue = new ListRunnableQueue(log);

	public final boolean isShutdown() {
		return shutdown;
	}

	private final ConstrainablePropertyRW<Boolean> shutdownBegun = new DefaultConstrainedPropertyRW<Boolean>(
			false, Boolean.FALSE);

	//boolean
	public final ConstrainablePropertyRO<Boolean> shutdownBegun() {
		CPSQueue.getInstance().checkThread();
		return shutdownBegun;
	}

	//returns success
	public final boolean shutdown() {
		CPSQueue.getInstance().checkThread();
		if (shutdown || shutdownBegun.get().booleanValue())
				return false;
		try {
			shutdownBegun.set(Boolean.TRUE);
		} catch (VetoException e) {
			return false;
		}
		queue.executeAll();
		shutdown = true;
		QueueManager.checkinLock(lock);
		return true;
	}

	public final void addShutdownHook(Runnable r) {
		if (shutdown) throw new IllegalStateException();
		CPSQueue.getInstance().checkThread();
		queue.addRunnable(r);
	}

	public final void removeShutdownHook(Runnable r) {
		if (shutdown) throw new IllegalStateException();
		CPSQueue.getInstance().checkThread();
		queue.removeRunnable(r);
	}

}
