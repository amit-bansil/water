/*
 * CREATED:    Jul 21, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Collection;
import java.util.Collections;

/**
 * used to optimize add/remove.
 */
public final class SingleElementChangeEvent<T> extends CollectionChangeEvent<T>{
    private final T added;
    private final T removed;
    public SingleElementChangeEvent(BoundCollectionRO<T> src,T added,T removed){
        super(src);
        this.added=added;
        this.removed=removed;
    }
    //OPTIMIZE-cache collections,seperate add/remove events
    public @Override Collection<T> getElementsAdded(){
        return Collections.unmodifiableCollection(Collections.singleton(added));
    }

    public @Override Collection getElementsRemoved(){
        return Collections.unmodifiableCollection(Collections.singleton(removed));
    }
    public T getElementAdded(){
        return added;
    }
    public T getElementRemoved(){
        return removed;
    }
}