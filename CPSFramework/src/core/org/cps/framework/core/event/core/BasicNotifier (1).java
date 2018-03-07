/*
 * BasicEventSender.java
 * CREATED:    Aug 10, 2003 1:31:38 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.core;

import java.util.ArrayList;
import java.util.EventListener;
import java.util.List;

/**
 * utility class for tracking and sending events to listeners.
 * observable object should delegate this behavior to a subclass
 * of this object designed for a specific listener type.
 * 
 * not synchronized; designed for single threaded access, locks while firing events
 * to prevent recursive loops.
 * 
 * @version 0.1.
 * @author Amit Bansil
 */
public abstract class BasicNotifier<LT extends EventListener>{
    
	private transient final List<LT> listeners;
	private int listenerCount = 0;
	public BasicNotifier() {
		this(4);
	}
	public BasicNotifier(int initialCapacity) {
		listeners = new ArrayList<LT>(initialCapacity);
	}
	private static final Object[] EMPTY_LISTENERS_ARRAY=new Object[0];
	private transient Object[] cache = null;
	/**
	 * @param l
	 * @throws IllegalArgumentException if listener is added twice w/o being removed
	 */
	public final void addListener(LT l) {
		if(listeners.contains(l))throw new IllegalArgumentException("can't add listener "+l+"twice");
		listenerCount++;
		listeners.add(l);
		cache = null;
	}
	public final void removeListener(LT l) {
		boolean removed = listeners.remove(l);
		if (!removed) {
			throw new IllegalArgumentException("listener "+l+"not added");
		}
		listenerCount--;
		cache = null;
	}
	//used to access cache and lock listeners,care should be taken not the write to this array
	protected final Object[] checkOutListeners() {
		if (firing)
			throw new IllegalStateException("can't fire while firing");
		firing = true;
		if (cache == null) {
			if (listenerCount == 0)
				cache = EMPTY_LISTENERS_ARRAY; //OPTIMIZED for empty
			else
				cache = listeners.toArray();
		}
		return cache;
	}
	public final boolean hasListeners() {
		return listenerCount != 0;
	}
	protected final void checkInListeners() {
		if (!firing)
			throw new IllegalStateException("should be firing");
		firing = false;
	}
	private transient boolean firing = false;
	public final boolean isFiring() {
		return firing;
	}
}
