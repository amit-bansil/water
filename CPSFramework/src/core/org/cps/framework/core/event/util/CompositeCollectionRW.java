/*
 * CREATED:    Jul 24, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.cps.framework.core.event.collection.AbstractBoundCollectionRO;
import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.CollectionChangeEvent;
import org.cps.framework.core.event.collection.CollectionListener;
import org.cps.framework.core.event.collection.SingleElementChangeEvent;

/**
 */
public class CompositeCollectionRW<T> extends AbstractBoundCollectionRO{
    private final List<T> collection=new ArrayList<T>();
    private final CollectionListener<T> listener=new CollectionListener<T>(){
        public void eventOccurred(CollectionChangeEvent<T> e){
            if(e instanceof SingleElementChangeEvent){
                SingleElementChangeEvent<T> se=(SingleElementChangeEvent<T>)e;
                T added=se.getElementAdded();
                T removed=se.getElementRemoved();
                if(removed!=null)get().remove(removed);
                if(added!=null)get().add(added);
                _fire_replace(removed,added);
            }else{
                Collection<? extends T> added=e.getElementsAdded();
                Collection<? extends T> removed=e.getElementsRemoved();
                get().addAll(added);
                get().removeAll(removed);
                _fire_change(added,removed);
            }
        }
    };
    
	protected final void _fire_replace(T oldE,T newE){
	    fire_replace(oldE,newE);
	}
	protected final void _fire_change(Collection<? extends T> added,Collection<? extends T> removed){
	    fire_change(added,removed);
	}
    public CompositeCollectionRW(){
        //empty
    }
    public final void addCollection(BoundCollectionRO<T> c){
        collection.addAll(c.get());
        fire_change(c.get(),null);
        c.addListener(listener);
    }
    public final void removeCollection(BoundCollectionRO<T> c){
        collection.removeAll(c.get());
        fire_change(null,c.get());
        c.removeListener(listener);//order??
    }
    public Collection<T> get(){
        return collection;
    }
}
