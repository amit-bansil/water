/*
 * SimpleConstrainedNotifier.java
 * CREATED:    Jul 6, 2004 8:16:25 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.simple;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericNotifier;
import org.cps.framework.core.event.core.VetoException;

import java.util.EventObject;

/**
 */
public abstract class SimpleConstrainedNotifier implements SimpleObservable{
    
	public SimpleConstrainedNotifier() {
	    //empty
	}
	private final GenericNotifier<EventObject> notifier=new GenericNotifier<EventObject>();
    public void addListener(GenericListener<EventObject> l){
        notifier.addListener(l);
    }
    public void removeListener(GenericListener<EventObject> l){
        notifier.removeListener(l);
    }
    protected final void _fireEvent(EventObject e){
        notifier.fireEvent(e);
    }
    public abstract void fireEvent()throws VetoException;

    public void unlink() {
    	//do nothing
    }
}