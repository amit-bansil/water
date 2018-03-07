/*
 * MapEntry.java
 * CREATED:    Jun 18, 2005 2:51:22 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-util
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.util.collections;

import cps.jarch.util.misc.LangUtils;

import java.util.Map;

/**
 * A trivial implementation of {@link java.util.Map.Entry}. Copied from
 * {@link java.util.AbstractMap}.SimpleEntry, which is not public. Minimal Annotations
 * have been added.
 * 
 * @author Amit Bansil
 * @version $Id: MapEntry.java 570 2005-09-11 22:32:52Z bansil $
 */
public class MapEntry<K, V>extends Object implements Map.Entry<K, V>{
	private K key;

	private V value;

	public MapEntry(K key, V value) {
		this.key = key;
		this.value = value;
	}

	public MapEntry(Map.Entry<K, V> e) {
		this.key = e.getKey();
		this.value = e.getValue();
	}

	public K getKey() {
		return key;
	}

	public V getValue() {
		return value;
	}

	public V setValue(V newvalue) {
		V oldValue = this.value;
		this.value = newvalue;
		return oldValue;
	}

	@Override
	public boolean equals(Object o) {
		if (!(o instanceof Map.Entry)) return false;
		
		@SuppressWarnings("unchecked")
		Map.Entry<K, V> e = (Map.Entry<K, V>) o;
		
		return LangUtils.equals(key, e.getKey()) && LangUtils.equals(value, e.getValue());
	}

	@Override
	public int hashCode() {
		return ((key == null) ? 0 : key.hashCode())
				^ ((value == null) ? 0 : value.hashCode());
	}

	@Override
	public String toString() {
		return key + "=" + value;
	}
}
