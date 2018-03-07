/*
 * BoundPropertyRW.java
 * CREATED:    Aug 9, 2003 11:05:45 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

/**
 * A bound property that can be set. first set the property then notify listeners.
 * This is used when all acceptable values for set are known at design time.
 * @version 0.1
 * @author Amit Bansil
 */
public interface BoundPropertyRW<T> extends BoundPropertyRO<T>{
	public void set(T value);
}
