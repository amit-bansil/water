/*
 * ConstrainedPropertyRO.java
 * CREATED:    Aug 9, 2003 11:05:18 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

import org.cps.framework.core.event.core.Constraint;
/**
 * A bound property that is constrained.
 * rember that when a change occurs first the vetoe listeners get to check the change
 * then it actually happens, then the change listeners are notified
 * @version 0.1
 * @author Amit Bansil
 */
public interface ConstrainablePropertyRO<T> extends BoundPropertyRO<T>{
    public void addConstraint(Constraint<ValueChangeEvent<T>> l);
    public void removeConstraint(Constraint<ValueChangeEvent<T>> l);
}
