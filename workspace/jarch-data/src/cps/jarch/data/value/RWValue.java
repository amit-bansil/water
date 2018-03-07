/*
 * BoundPropertyRW.java
 * CREATED:    Aug 9, 2003 11:05:45 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.value;

import cps.jarch.util.notes.Nullable;

/**
 * A bound property that can be set to any value. Set should first change the
 * property and then notify listeners.
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public interface RWValue<T> extends CheckedValue<T>{
	/**
	 * set implementations should be equivalent to calling <code>checkedSet</code>.
	 * <code>checkedSet</code> should be implemented in such a way that no
	 * RejectedValueException's are thrown.
	 */
	public void set(@Nullable T newValue);
}