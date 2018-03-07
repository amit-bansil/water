/*
 * CREATED:    Jul 22, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.List;

/**
 */
public interface BoundListRO<T> extends BoundCollectionRO<T>{
    public List<T> getList();//TODO return a list when covariance supported
    public boolean isSet();
}
