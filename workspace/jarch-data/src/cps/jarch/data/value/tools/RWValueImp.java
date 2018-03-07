/*
 * DefaultBoundPropertyRW.java CREATED: Aug 9, 2003 12:49:06 PM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package cps.jarch.data.value.tools;

import cps.jarch.data.io.SaveableDataProxy;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.RejectedValueException;
import cps.jarch.util.notes.Nullable;

import java.util.concurrent.locks.Lock;


/**
 * Basic <code>RWValue</code> implementation.
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public class RWValueImp<T> extends CheckedValueImp<T>
		implements RWValue<T>,SaveableDataProxy {
	/**
	 * creates not null RWValueImp.defaultValue must not be null.
	 */
	public RWValueImp(T initial) {
		this(initial,false);
	}
	/**
	 * creates RWValueImp set to initial value <code>defaultValue</code>.
	 * @throws Error if set does not accept defaultValue
	 */
	public RWValueImp(T initial, boolean allowsNull) {
		this(initial,allowsNull,null);
	}
	/**
	 * creates nullable RWValueImp that is initially <code>null</code>.
	 */
	public RWValueImp() {
		this(null,true,null);
	}
	public RWValueImp(T initial,boolean allowsNull,@Nullable Lock lock) {
		super(allowsNull,lock);
		setInitial(initial);
	}
	
	public final void set(T newValue) {
		try {
			checkedSet(newValue);
		} catch (RejectedValueException e) {
			//should not happen since check is empty
			throw new Error(e);
		}
	}
	
	@Override protected final void check(T newValue) throws RejectedValueException {
		//do nothing
	}

}