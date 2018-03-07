/*
 * AbstractBoundPropertyRO.java CREATED: Aug 9, 2003 11:38:22 AM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package cps.jarch.data.value;

import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.GenericPublisher;
import cps.jarch.data.event.tools.SerialPublisher;
import cps.jarch.util.notes.Nullable;

import java.util.EventObject;
import java.util.concurrent.locks.Lock;
//TODO this class duplicates the functionality of Source, abstract it out?
/**
 * Simple implementation of a read only property that is a <code>Source</code>
 * for <code>ValueChange</code> events. Delegates link handling to a
 * <code>Publisher</code>. implementations should define <code>get()</code>.
 * this implementation must be externally synchronized.
 * 
 * @param <T>
 *            the type of value this property excepts.
 * @author Amit Bansil
 */
public abstract class AbstractROValue<T>  implements ROValue<T>{
	/**
	 * creates AbstractROValue that uses a SimplePublisher.
	 */
	public AbstractROValue(boolean nullable,@Nullable Lock lock) {
		this(nullable,new SerialPublisher<EventObject>(),lock);
	}
	public AbstractROValue(boolean nullable, GenericPublisher<EventObject> publisher,
			@Nullable Lock lock) {
		this.lock=lock;
		this.nullable = nullable;
		this.publisher = publisher;
	}
	private final Lock lock;
	public final Lock getLock() {
		return lock;
	}
	private final boolean nullable;

	public final boolean isNullable() {
		return nullable;
	}

	// event stuff
	private final GenericPublisher<EventObject> publisher;
	private final EventObject event=new EventObject(this);
	protected final void fireChange() {
		if (!publisher.hasLinks()) return;
		publisher.sendEvent(event);
	}

	@Override
	public final String toString() {
		return getClass().getSimpleName() + "-value=[" + get() + ']';
	}
	
	public void connect(GenericLink<? super EventObject> l) {
		publisher.connect(l);
	}
	public void disconnect(GenericLink<? super EventObject> l) {
		publisher.disconnect(l);
	}
}