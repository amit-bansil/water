/*
 * SimpleConstrainableNotifier.java
 * CREATED:    Jul 6, 2004 8:08:46 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.simple;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
import org.cps.framework.core.event.core.Constraint;
import org.cps.framework.core.event.core.ConstraintNotifier;
import org.cps.framework.core.event.core.VetoException;

import java.util.EventObject;

/**
 */
public final class SimpleConstrainableNotifier extends SimpleConstrainedNotifier implements SimpleConstrainable{
    
	private final EventObject event;
	public SimpleConstrainableNotifier(Object source) {
		event = new EventObject(source);
	}
    public void fireEvent() throws VetoException{
        constraints.checkEvent(event);
        _fireEvent(event);
    }
    private final ConstraintNotifier<EventObject> constraints=new ConstraintNotifier();
    public final void addConstraint(Constraint<EventObject> c){
        constraints.addListener(c);
    }
    public final void removeConstraint(Constraint<EventObject> c){
        constraints.removeListener(c);
    }
}
