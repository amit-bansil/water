/*
 * ConstanConstrainedtPropertyRO.java CREATED: Aug 9, 2003 11:32:02 AM AUTHOR:
 * Amit Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.core.Constraint;
import org.cps.framework.core.event.core.ConstraintNotifier;
import org.cps.framework.core.event.core.VetoException;

/**
 */
public abstract class AbstractConstrainedPropertyRO<T> extends AbstractBoundPropertyRO<T>
	implements ConstrainablePropertyRO<T> {

	public AbstractConstrainedPropertyRO(boolean allowsNull) {
		super(allowsNull);
	}
//	event stuff
	private final ConstraintNotifier<ValueChangeEvent<T>> notifier=
	    new ConstraintNotifier<ValueChangeEvent<T>>();
	public final void addConstraint(Constraint<ValueChangeEvent<T>> l) {
		notifier.addListener(l);
	}
	public final void removeConstraint(Constraint<ValueChangeEvent<T>> l) {
		notifier.removeListener(l);
	}
	protected final void checkValue(T oldValue,T newValue) throws VetoException {
	   if(!notifier.hasListeners())return;
		notifier.checkEvent(new ValueChangeEvent<T>(this,oldValue,newValue));
	}
}