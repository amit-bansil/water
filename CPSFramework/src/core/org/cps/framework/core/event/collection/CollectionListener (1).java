/*
 * CollectionChangeListener.java
 * CREATED:    Jul 11, 2004 2:43:03 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import org.cps.framework.core.event.core.GenericListener;

/**
 * shorthand
 */
public interface CollectionListener<T> extends GenericListener<CollectionChangeEvent<T>> {
    //empty
}
