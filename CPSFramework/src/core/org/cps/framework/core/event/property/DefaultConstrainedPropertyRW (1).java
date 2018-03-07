/*
 * DefaultConstrainedProperty.java CREATED: Aug 9, 2003 6:25:43 PM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.core.VetoException;
/**
 * @version 0.1
 * @author Amit Bansil
 */
public class DefaultConstrainedPropertyRW<T>
	extends AbstractConstrainedPropertyRO<T>
	implements ConstrainablePropertyRW<T> {
	
	public DefaultConstrainedPropertyRW(
		boolean allowsNull) {
		this(allowsNull,null);
	}
	
	public DefaultConstrainedPropertyRW(
		boolean allowsNull,
		T defaultValue) {
		super(allowsNull);
		try{
			set(defaultValue);
		}catch(VetoException e){
			throw new Error("bad initial value",e);
		}
	}
	private T value = null;
	/*
     * thorws an illegalargumentexception if filter does not accept values. no
     * action taken if newValue==oldVlaue
     */
	public final void set(T newValue)throws VetoException {
		checkArgument(newValue);
		//perhaps notify first incase vetos change?

		if (newValue == this.value||(newValue != null && newValue.equals(value))) return;
		
		checkValue(value,newValue);
		T oldValue=value;
		value = newValue;
		fireChange(oldValue,value);
	}
	public final T get() {
		return value;
	}
}
