/*
 * SimpleConstrainable.java
 * CREATED:    Jul 6, 2004 8:11:06 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.simple;

import org.cps.framework.core.event.core.Constraint;

import java.util.EventObject;

/**
 * marker
 */
public interface SimpleConstrainable extends SimpleObservable{
    public void addConstraint(Constraint<EventObject> c);
    public void removeConstraint(Constraint<EventObject> c);
}

