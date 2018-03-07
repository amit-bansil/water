/*
 * CollectionChangeAdapter.java
 * CREATED:    Jul 11, 2004 2:48:39 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;


/**
 * adapts collectionchangelistener so that only objectAdded/removed must be implemented
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class CollectionChangeAdapter<T> implements CollectionListener<T>{
    public final void eventOccurred(CollectionChangeEvent<T> evt){
        if(evt instanceof SingleElementChangeEvent){
            SingleElementChangeEvent<T> sevt=(SingleElementChangeEvent<T>)evt;
            T added=sevt.getElementAdded();
            T removed=sevt.getElementRemoved();
            if(added!=null)elementAdded(added);
            if(removed!=null)elementRemoved(removed);
        }else{
            //OPTIMIZE quit early on DefaultEvent's empty colls
            for(T e:evt.getElementsAdded())elementAdded(e);
            for(T e:evt.getElementsRemoved())elementRemoved(e);
        }
    }
    //todo make hooks protected
	public abstract void elementAdded(T e);
	public abstract void elementRemoved(T e);

}
