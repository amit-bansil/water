/*
 * SimpleNotifier.java
 * CREATED:    Jul 6, 2004 8:14:42 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.simple;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericNotifier;
import org.cps.framework.core.event.core.GenericObservable;

import java.util.EventObject;

/**
 * utility class that allows clients to listen for events from a
 * source object. sources normally expose only SimpleObservable while internally using
 * this to notify clients. SimpleNotifiers can be linked to
 * eachother by addStateDependecy. this sender will fire whenever any of its
 * state dependants are changed.
 */
public final class SimpleNotifier implements SimpleObservable{

	private final EventObject event;
	public SimpleNotifier(Object source) {
		event = new EventObject(source);
	}
	private final GenericNotifier<EventObject> notifier=new GenericNotifier<EventObject>();
    public void fireEvent(){
        notifier.fireEvent(event);
    }
    public void addListener(GenericListener<EventObject> l){
        notifier.addListener(l);
    }
    public void removeListener(GenericListener<EventObject> l){
        notifier.removeListener(l);
    }
    

	private GenericListener ocdl;
	/**
     * this is fires whenever source fiers
     * 
     * @param source
     */
	public final <ET> void addStateDependency(GenericObservable<ET> source) {
		if (ocdl == null) { //lazy creation
			ocdl = new GenericListener() {
				public void eventOccurred(Object e) {//TODO
					fireEvent();
				}
			};
		}
		source.addListener(ocdl);

	}
	public final <ET> void removeStateDependency(GenericObservable<ET> source) {
	    assert ocdl!=null;
		source.removeListener(ocdl);
	}
	

    public void unlink() {
    	//do nothing
    }
}
