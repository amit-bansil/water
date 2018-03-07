/*
 * CREATED:    Jul 18, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.property;

import java.util.EventObject;

/**
 */
public class ValueChangeEvent<T> extends EventObject{
    private final T oldValue,newValue;
//  TODO restrict src when covariance supported
    public ValueChangeEvent(BoundPropertyRO<T> source,T oldValue,T newValue){
        super(source);
        this.oldValue=oldValue;
        this.newValue=newValue;
    }
    public final T getOldValue(){
        return oldValue;
    }
    public final T getNewValue(){
        return newValue;
    }
}
