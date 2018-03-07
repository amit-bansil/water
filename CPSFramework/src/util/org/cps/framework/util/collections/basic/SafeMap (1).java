/*
 * Created on Feb 22, 2003
 */
package org.cps.framework.util.collections.basic;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;



/**
 * A map that throws exceptions when values are unexplicitly overwritten or
 * unavailable. null values are not allowed.
 * 
 * @author Amit Bansil
 * @version 0.1
 */
public final class SafeMap<K,V>{
	private final Map<K,V> map,mapRO;
	public SafeMap(int initialCapacity, float loadFactor) {
		map=new HashMap<K,V>(initialCapacity,loadFactor);
		mapRO=Collections.unmodifiableMap(map);
	}
	public SafeMap() {
		map=new HashMap<K,V>();
		mapRO=Collections.unmodifiableMap(map);
	}
	/**
     * @return unmodifiable map
     */
	public final Map<K,V> getMap(){
		return mapRO;
	}
	public final boolean containsKey(K key) {
		return map.containsKey(key);
	}
	public void put(K key, V value) {
		if (value == null)
			throw new NullPointerException("null value not allowed");
		V r = map.put(key, value);
		if (r != null) {
			map.put(key, r); //restore
			throw new IllegalArgumentException(
				"key "
					+ key
					+ " already used by "
					+ r
					+ " so "
					+ value
					+ " could not be added");
		}
	}
	public Object replace(K key, V value) {
		if (value == null)
			throw new NullPointerException("null value not allowed");
		V r = map.put(key, value);
		if (r == null) {
			map.put(key, r); //restore
			throw new IllegalArgumentException(
				"key "
					+ key
					+ " not yet defined so "
					+ value
					+ " was not replaced");
		}
		return r;
	}
	//less safe remove
	public V remove(K key) {
		V r=map.remove(key);
		if (r == null)
			throw new IllegalArgumentException(
				"key " + key + " can't be removed until it is added");
		return r;
	}
	//safe get
	public V get(K key){
		V ret=map.get(key);
		if(ret==null)throw new IllegalArgumentException("key "+key+" not defined");
		return ret;
	}
	//safe remove
	public V remove(K key, V value) {
		if (value == null)
			throw new NullPointerException("null value not allowed");
		V r = map.remove(key);
		if (r != value) {
			map.put(key, r); //restore
			throw new IllegalArgumentException(
				"key "
					+ key
					+ " contains "
					+ r
					+ " not "
					+ value
					+ " so was not removed");
		}
		return r;
	}
}
