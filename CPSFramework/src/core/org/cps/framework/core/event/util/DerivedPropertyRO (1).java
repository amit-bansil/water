/*
 * DerivedPropertyRO.java
 * CREATED:    Aug 20, 2004 6:28:30 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.util;

import org.apache.commons.lang.ObjectUtils;
import org.cps.framework.core.event.property.AbstractBoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class DerivedPropertyRO<T> extends AbstractBoundPropertyRO<T> {
	private final BoundPropertyRO[] srcs;
	public DerivedPropertyRO(boolean allowsNull,BoundPropertyRO p,T initialValue) {
		this(allowsNull,new BoundPropertyRO[] {p},initialValue);
	}
	protected final BoundPropertyRO[] getSrcs() {
		return srcs;
	}
	public DerivedPropertyRO(boolean allowsNull,BoundPropertyRO[] srcs,T initalValue) {
		super(allowsNull);
		this.srcs=srcs;
		l=new ValueChangeListener<Object>() {
			public void eventOccurred(ValueChangeEvent<Object> e) {
				T old=value;
				value=update(e);
				if(!ObjectUtils.equals(old,value)) {
					fireChange(old,value);
				}
			}
		};
		value=initalValue;
		for(int i=0;i<srcs.length;i++)srcs[i].addListener(l);
	}
	private final ValueChangeListener l;
	private T value;
	public final T get() {
		return value;
	}
	public final void unlink() {
		for(int i=0;i<srcs.length;i++)srcs[i].removeListener(l);
	}
	protected abstract T update(ValueChangeEvent e);
}
