/*
 * DefaultBoundPropertyRW.java CREATED: Aug 9, 2003 12:49:06 PM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.core.io.SaveableData;

import java.io.IOException;

/**
 * basic RW property implementation.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class DefaultBoundPropertyRW<T> extends AbstractBoundPropertyRO<T>
		implements BoundPropertyRW<T>,SaveableData {

	public DefaultBoundPropertyRW() {
		this(true, null);
	}

	public DefaultBoundPropertyRW(T defaultValue) {
		this(false, defaultValue);
	}

	public DefaultBoundPropertyRW(boolean allowsNull, T defaultValue) {

		super(allowsNull);

		set(defaultValue);
	}

	private T value = null;

	/*
	 * thorws an illegalargumentexception if filter does not accept value if set
	 * to the same value as before no action is taken, even if during
	 * firing,invalid values would throw Excepions.
	 */
	public final void set(T newValue) {
		checkArgument(newValue);
		if (newValue == this.value
				|| (newValue != null && newValue.equals(value))) return;
		T oldValue = value;
		value = newValue;
		fireChange(oldValue, newValue);
	}

	public final T get() {
		return value;
	}

	//io
	public final void write(ObjectOutputStreamEx out) throws IOException {
		if(!isSaveable())throw new Error(this+" not saveable");
		out.writeObject(get());
	}
	public final void read(ObjectInputStreamEx in) throws IOException {
		if(isSaveable()) {
			try {
				set((T)in.readObject());
			}catch (ClassNotFoundException e) {
				//should not happen
				throw new Error(e);
			}
		}
	}
	public final void initialize() {
		//do nothing???
	}
	private BoundCollectionRO<GenericObservable<?>> col=null;
	public final BoundCollectionRO<GenericObservable<?>> getStateObjects() {
		if(col==null) {
			col=EventUtils.singletonCollection((GenericObservable<?>)this);
		}
		return col;
	}
	//override to prevent save
	public boolean isSaveable() {
		return true;
	}
}