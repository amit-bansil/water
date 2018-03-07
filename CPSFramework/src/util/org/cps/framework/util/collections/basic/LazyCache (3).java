/*
 * LazyCache.java
 * CREATED:    Dec 18, 2003 6:51:31 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.basic;

import java.util.HashMap;
import java.util.Map;

/**
 * A thread safe cache that loads object only once. set can be used to inject a value.
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class LazyCache<K,V>{
	private final Map<K,V> map;
	public LazyCache(){
		map=new HashMap<K,V>();
	}
	public V get(K key){
		return get(key,null);
	}
	public V get(K key,V context){
		V ret=map.get(key);
		if(ret==null){
			synchronized(map){
				ret=map.get(key);
				if(ret==null){
					ret=load(key,context);
					map.put(key,ret);
				}
			}
		}
		return ret;
	}
	//returns success
	public boolean set(K key,V value){
		synchronized(map){
			if(map.get(key)!=null)return false;
			map.put(key,value);
			return true;
		}
	}
	public abstract V load(K key,Object context);
}
