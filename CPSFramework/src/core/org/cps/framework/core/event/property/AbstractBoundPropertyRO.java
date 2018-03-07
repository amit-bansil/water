/*
 * AbstractBoundPropertyRO.java CREATED: Aug 9, 2003 11:38:22 AM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.event.property;

import org.apache.commons.lang.NullArgumentException;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericNotifier;

/**
 * Simple implementation of a bound RO property. handles listeners.
 * implementations should define get. this implementation must be externally
 * synchronized.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class AbstractBoundPropertyRO<T> implements BoundPropertyRO<T> {
	public AbstractBoundPropertyRO(boolean allowsNull) {
		this.allowsNull = allowsNull;
	}

	//arg checking
	private final boolean allowsNull;

	public boolean allowsNull() {
		return allowsNull;
	}

	protected void checkArgument(T newValue) throws NullArgumentException,
			ClassCastException {
		if (newValue == null) {
			if (!allowsNull()) throw new NullArgumentException(toString());
			return;//dont check type for value==null
		}
	}

	//event stuff
	private final GenericNotifier<ValueChangeEvent<T>> notifier = new GenericNotifier<ValueChangeEvent<T>>();

	public final void addListener(ValueChangeListener<T> l) {
		notifier.addListener(l);
	}

	public final void removeListener(ValueChangeListener<T> l) {
		notifier.removeListener(l);
	}

	//	TODO cheetah bugs require the 2 methods below
	public final void addListener(GenericListener<ValueChangeEvent<T>> l) {
		notifier.addListener(l);
	}

	public final void removeListener(GenericListener<ValueChangeEvent<T>> l) {
		notifier.removeListener(l);
	}

	protected final void fireChange(T oldValue, T newValue) {
		if (!notifier.hasListeners()) return;
		notifier.fireEvent(new ValueChangeEvent<T>(this, oldValue, newValue));
	}

	public void unlink() {
		//do nothing
	}
}