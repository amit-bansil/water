/*
 * ConstrainedPropertyWO.java
 * CREATED:    Sep 3, 2003 5:51:35 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.core.VetoException;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public interface ConstrainedPropertyRW<T> extends BoundPropertyRO<T>{
	public void set(T value)throws VetoException;
}
