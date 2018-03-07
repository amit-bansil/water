/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.util;

import java.util.ArrayList;
import java.util.Collection;

import org.cps.framework.core.event.collection.AbstractBoundCollectionRO;
import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;

/**
 * a derived collection is like a composite collection except filtered.
 * (composite collections are not really needed)
 */
public class DerivedCollectionRO<T> extends AbstractBoundCollectionRO<T>{
    private final Collection<T> col;
    private final Class<T> type;
	public DerivedCollectionRO(Class<T> type) {
		col=new ArrayList();
		this.type=type;
	}
	
	public Collection<T> get() {
		return col;
	}
	//optimize:add/remove in groups
	public final void addSource(BoundCollectionRO<? extends T> src){
	    for(T e:src.get())cl.elementAdded(e);
	    src.addListener(cl);
	}
	public final void removeSource(BoundCollectionRO<? extends T> src){
	    for(T e:src.get())cl.elementRemoved(e);
	    src.removeListener(cl);
	}
	private final CollectionChangeAdapter cl=new CollectionChangeAdapter<T>(){
        public void elementAdded(T e){
            if(_check(e)){
                col.add(e);
                fire_add(e);
            }
        }
        public void elementRemoved(T e){
            if(_check(e)){
                col.remove(e);
                fire_remove(e);
            }
        }
	};
	//must be consistent or will leak on remove
	protected boolean _check(T element){
	    return type.isInstance(element);
	}
}
