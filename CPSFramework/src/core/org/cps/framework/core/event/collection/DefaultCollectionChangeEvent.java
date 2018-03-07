/*
 * CREATED: Jul 21, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.core.event.collection;

import java.util.Collection;
import java.util.Collections;

/**
 */
public final class DefaultCollectionChangeEvent<T> extends
		CollectionChangeEvent<T> {
	private final Collection< ? extends T> added;

	private final Collection< ? extends T> removed;

	private static final Collection EMPTY_COLLECTION_RO = Collections
			.unmodifiableCollection(Collections.emptySet());

	public DefaultCollectionChangeEvent(BoundCollectionRO<T> src,
			Collection< ? extends T> elementsAdded,
			Collection< ? extends T> elementsRemoved) {
		super(src);
		this.added = elementsAdded != null ? Collections
				.unmodifiableCollection(elementsAdded) : EMPTY_COLLECTION_RO;
		this.removed = elementsRemoved != null ? Collections
				.unmodifiableCollection(elementsRemoved) : EMPTY_COLLECTION_RO;
	}

	public Collection< ? extends T> getElementsAdded() {
		return added;
	}

	public Collection< ? extends T> getElementsRemoved() {
		return removed;
	}

}