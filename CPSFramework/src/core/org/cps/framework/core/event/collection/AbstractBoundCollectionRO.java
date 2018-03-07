/*
 * AbstractBoundCollectionRO.java
 * CREATED:    Jul 11, 2004 7:00:27 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Collection;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericNotifier;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class AbstractBoundCollectionRO<T>
	implements BoundCollectionRO<T>{
	public AbstractBoundCollectionRO() {
	    //do nothing
	}	
	//event stuff
	private final GenericNotifier<CollectionChangeEvent<T>> notifier=new GenericNotifier<CollectionChangeEvent<T>>();
	
	public final void addListener(CollectionListener<T> l){
	    notifier.addListener(l);
	}
	public final void removeListener(CollectionListener<T> l){
	    notifier.removeListener(l);
	}
//	TODO cheetah bugs require the 2 methods below
	public final void addListener(GenericListener<CollectionChangeEvent<T>> l){
	    notifier.addListener(l);
	}
	public final void removeListener(GenericListener<CollectionChangeEvent<T>> l){
	    notifier.removeListener(l);
	}
	//fire
	protected final void fire_add(T e){
	    fire_replace(null,e);
	}
	protected final void fire_remove(T e){
	    fire_replace(e,null);
	}
	protected final void fire_replace(T oldE,T newE){
	    if(notifier.hasListeners())notifier.fireEvent(new SingleElementChangeEvent<T>(this,newE,oldE));
	}
	protected final void fire_change(Collection<? extends T> added,Collection<? extends T> removed){
	    if(notifier.hasListeners())notifier.fireEvent(new DefaultCollectionChangeEvent<T>(this,added,removed));
	}
	protected final void fire_clear(Collection<T> oldElements){
	    fire_change(null,oldElements);
	}
	public void unlink() {
		//do nothing
	}
}
