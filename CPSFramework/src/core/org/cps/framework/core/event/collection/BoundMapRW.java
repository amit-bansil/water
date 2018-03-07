/*
 * CREATED: Jul 22, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.core.event.collection;

import org.cps.framework.util.collections.basic.MapEntry;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

/**
 */
public class BoundMapRW<K,V> extends AbstractBoundCollectionRO<Map.Entry<K,V>>
		implements BoundMapRO<K,V>{
	
    private final Map<K,V> safeMap,map;
    private final Collection<Map.Entry<K,V>> col,safeCol;
    //factory methods
    public static final <TK,TV> BoundMapRW<TK,TV> create(int capacity,float load_factor){
        return new BoundMapRW<TK,TV>(capacity,load_factor);
    }
    public static final <TK,TV> BoundMapRW<TK,TV> create(int capacity){
        return new BoundMapRW<TK,TV>(capacity);
    }
    public static final <TK,TV> BoundMapRW<TK,TV> create(){
        return new BoundMapRW<TK,TV>();
    }
    
    public BoundMapRW(int capacity,float load_factor){
        this(new HashMap<K,V>(capacity,load_factor),
                new ArrayList<Map.Entry<K,V>>(capacity));
    }
    public BoundMapRW(int capacity){
        this(new HashMap<K,V>(capacity),
                new ArrayList<Map.Entry<K,V>>(capacity));
    }
    public BoundMapRW(){
        this(new HashMap<K,V>(),
                new ArrayList<Map.Entry<K,V>>());
    }
    
	private BoundMapRW(Map<K,V> map,Collection<Map.Entry<K,V>> col) {
		this.map=map;
		this.col=col;
		safeMap=Collections.unmodifiableMap(map);
		safeCol=Collections.unmodifiableCollection(col);
	}
	
	public Map<K,V> getMap() {
		return safeMap;
	}
	
	public  Collection<Map.Entry<K,V>> get() {
		return safeCol;
	}
	
	
	public V safeGet(K key) {
		V ret=map.get(key);
		if(ret==null)throw new IllegalArgumentException("key "+key+" not found in "+this);
		return ret;
	}
	public void safePut(K key,V value){
	    V ret=map.get(key);
	    if(ret!=null)throw new IllegalArgumentException("key "+key+
	            " already in use by value "+value+" in "+this);
	    put(key,value);
	}
//	npe on value==null
	public V safeRemove(K key,V value){
	    V ret=map.get(key);
	    if(!value.equals(key))
	        throw new IllegalArgumentException("key "+key+
		            " used by value "+ret+" not "+value+" in "+this);
	    put(key,null);
	    return ret;
	}
//	npe on oldValue==null
	public V safeReplace(K key,V oldValue,V newValue){
	    V ret=map.get(key);
	    if(!oldValue.equals(key))
	        throw new IllegalArgumentException("key "+key+
		            " used by value "+ret+" not "+oldValue+" in "+this);
	    put(key,newValue);
	    return ret;
	}
	//npe on key==null
	public V put(K key,V value){
	    V ret=map.put(key,value);
	    Map.Entry<K,V> removed;
	    if(ret==null){
	        if(value==null) return ret;
	        else removed=null;
	    }else if(!ret.equals(value))return ret;
	    else removed= new MapEntry<K,V>(key,ret);
	    
	    Map.Entry<K,V> added=value==null?null:new MapEntry<K,V>(key,value);
	    fire_replace(removed,added);
	    return ret;
	}
	public void clear() {
	    Collection<Map.Entry<K,V>> old=new ArrayList<Map.Entry<K,V>>(col);
		map.clear();
		col.clear();
		fire_clear(old);
	}
}
