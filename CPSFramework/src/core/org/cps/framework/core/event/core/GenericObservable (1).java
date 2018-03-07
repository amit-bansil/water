/*
 * CREATED:    Jul 24, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.core;


/**
 */
public interface GenericObservable<ET/*TODO cheetah bug extends EventObject*/>{
    public void addListener(GenericListener<ET> l);
    public void removeListener(GenericListener<ET> l);
    //TODO: hasListeners()
    public void unlink();
}
