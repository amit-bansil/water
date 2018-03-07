/*
 * CREATED:    Jul 22, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Map;

/**
 * the entries in the map are not the entries in the collection
 */
public interface BoundMapRO<K,V> extends BoundCollectionRO<Map.Entry<K,V>>{
    public Map<K,V> getMap();
    //will throw iae if key not set
    public V safeGet(K key);
}
