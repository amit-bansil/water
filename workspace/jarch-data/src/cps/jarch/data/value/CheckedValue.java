/*
 * CheckedValue.java
 * CREATED:    Jun 19, 2005 1:18:10 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.value;


/**
 * A bound property that can be set but has the option to reject proposed
 * values. Set should first change the property and then notify listeners.
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public interface CheckedValue<T> extends ROValue<T>{
	/**
	 * make <code>newValue</code> the value that <code>get()</code> will
	 * return and then notify listeners of this change unless <code>newValue</code>
	 * is not acceptable.
	 * 
	 * @throws RejectedValueException
	 *             if <code>newValue</code> is not an acceptable value of type
	 *             <code>T</code> as specified by implementations of this
	 *             method. Implementations must ensure that any value that is
	 *             acceptable at one point in the particular RWValue instance's life is
	 *             acceptable at any other time. i.e. if an implementation checks that
	 *             that numbers are within a certain range, that range should be final for
	 *             any particular instance.
	 */
	public void checkedSet(T newValue)throws RejectedValueException;
}