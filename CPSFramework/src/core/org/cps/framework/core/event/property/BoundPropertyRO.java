/*
 * PropertyRO.java
 * CREATED:    Aug 9, 2003 11:03:28 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.core.GenericObservable;

/**
 * A less verbose implemenation of a JavaBeans BoundProperty. This is the root
 * of all other propreties. It can be read and observered.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public interface BoundPropertyRO<T> extends
		GenericObservable<ValueChangeEvent<T>>{
	public boolean allowsNull();

	public T get();
}