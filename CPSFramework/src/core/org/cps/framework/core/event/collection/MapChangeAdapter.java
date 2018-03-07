/*
 * MapChangeAdapter.java
 * CREATED:    Aug 19, 2004 1:19:15 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;

import java.util.Map;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class MapChangeAdapter<K,V> extends CollectionChangeAdapter<Map.Entry<K,V>> {
	//todo make hooks protected
	public final void elementAdded(Map.Entry<K,V> e) {
		mappingAdded(e.getKey(),e.getValue());
	}

	public final void elementRemoved(Map.Entry<K,V> e) {
		mappingRemoved(e.getKey(),e.getValue());
	}
	protected abstract void mappingAdded(K key,V value);
	protected abstract void mappingRemoved(K key,V value);
}
