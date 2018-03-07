/*
 * BoundCollectionRO.java
 * CREATED:    Jul 11, 2004 1:27:32 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.collection;
import java.util.Collection;

import org.cps.framework.core.event.core.GenericObservable;
/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public interface BoundCollectionRO<T> extends GenericObservable<CollectionChangeEvent<T>>{
	/**
	 * @return unmodifiable collection
	 */
	public Collection<T> get();
	/*public void addListener(CollectionListener<T> l);
	public void removeListener(CollectionListener<T> l);*/
}
