/*
 * CREATED:    Jul 21, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Collection;
import java.util.EventObject;

/**
 */
public abstract class CollectionChangeEvent<E> extends EventObject{

    public CollectionChangeEvent(BoundCollectionRO<E> src){
        super(src);
    }
    public abstract Collection<? extends E> getElementsAdded();
    public abstract Collection<? extends E> getElementsRemoved();
}
