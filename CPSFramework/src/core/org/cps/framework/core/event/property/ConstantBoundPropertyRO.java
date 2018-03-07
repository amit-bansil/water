/*
 * ConstantBoundPropertyRO.java
 * CREATED:    Dec 21, 2003 4:18:11 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ConstantBoundPropertyRO<T> extends AbstractBoundPropertyRO<T> {
	private final T value;
	public ConstantBoundPropertyRO(T value){
		this(false,value);
	}
	public ConstantBoundPropertyRO(boolean allowsNull, T value) {
		super(allowsNull);
		if(value==null&&!allowsNull)throw new NullPointerException("null value not allowed");
		this.value=value;
	}
	public T get() {
		return value;
	}

}
