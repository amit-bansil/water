/*
 * MapEntry.java
 * CREATED:    Jul 9, 2004 7:40:57 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.basic;


import java.util.Map;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class MapEntry<K,V> extends Pair<K,V> implements Map.Entry<K,V>{
    private final K k;
    private final V v;
    public MapEntry(K k,V v){
    	super(k,v);
        assert k!=null&&v!=null;
        this.k=k;
        this.v=v;
    }
    public K getKey(){
        return k;
    }

    public V getValue(){
        return v;
    }

    public V setValue(V v){
        throw new UnsupportedOperationException();
    }
}
