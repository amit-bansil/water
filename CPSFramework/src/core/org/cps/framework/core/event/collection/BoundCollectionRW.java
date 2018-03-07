/*
 * BoundCollectionRW.java
 * CREATED:    Jul 11, 2004 1:34:23 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Collection;

/**
 *
 * @version 0.0
 * @author Amit Bansil
 */
public interface BoundCollectionRW<E> extends BoundCollectionRO<E> {
    //throws illegalargumentException if can't add
    void add(E e);
    //throws illegalargumentException if can't remove
    //this is more restrictive then collection, which allows the removal of
    //any Object. Generally, however, this is unsafe, but if you really need it
    //you can just create an untyped collection
    void remove(E e);
    //make sure both are !null?
    //throws illegalargumentException if can't replace
    //when possible newE should be in oldE place
    void replace(E oldE,E newE);
    //throws illegalargumentException if can't add every element in c
    //no gaurantees about placement,use null for empty add/remove
    void change(Collection<? extends E> remove,Collection<? extends E> add);
    void clear();
}
