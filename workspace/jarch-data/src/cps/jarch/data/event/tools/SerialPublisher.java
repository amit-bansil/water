/*
 * BasicEventSender.java
 * CREATED:    Aug 10, 2003 1:31:38 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event.tools;


import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.GenericPublisher;

import java.util.ArrayList;
import java.util.EventObject;
import java.util.List;

/**
 * Basic <code>Publisher</code> implementation.<br>
 * 
 * not synchronized; designed for single threaded access. Recursive listener
 * notification will generate an error. Optimized for fast event sending at the
 * expense of a few operations extra to connect/disconnect links.
 * 
 * @author Amit Bansil
 */
public final class SerialPublisher<EventType extends EventObject> implements
		GenericPublisher<EventType> {
	// list of links connected to this
	private final List<GenericLink<? super EventType>> links;

	// size of links, kept for optimization
	private int linkCount;

	/**
	 * creates empty SerialPublisher w/ initialCapacity 4.
	 */
	public SerialPublisher() {
		this(4);
	}

	/**
	 * creates SerialPublisher with <code>initialCapacity</code>.
	 */
	public SerialPublisher(int initialCapacity) {
		links = new ArrayList<GenericLink<? super EventType>>(initialCapacity);
		linkCount = 0;
	}

	// when links is empty we use this array for cache to avoid
	// needless object creation
	private static final GenericLink[] EMPTY_LINK_ARRAY = new GenericLink[0];

    private GenericLink<? super EventType>[] cache = null;
    /**
     * @see cps.jarch.data.event.GenericSource#connect(cps.jarch.data.event.GenericLink)
     */
	public void connect(GenericLink<? super EventType> l) {
		if (links.contains(l)) throw new Error("link already connected:" + l);
		// clear cache
		linkCount++;
		links.add(l);
		cache = null;
	}
	/**
	 * @see cps.jarch.data.event.GenericSource#disconnect(cps.jarch.data.event.GenericLink)
	 */
	public void disconnect(GenericLink<? super EventType> l) {
		boolean removed = links.remove(l);
		if (!removed) { throw new Error("listener " + l + "not added"); }
		// clear cache
		linkCount--;
		cache = null;
	}

	/**
	 * @see cps.jarch.data.event.GenericPublisher#hasLinks()
	 */
	public final boolean hasLinks() {
		return linkCount != 0;
	}

	/**
	 * broadcasts e to links. Optimized to be called when already hasLinks(). It
	 * is perfectly legal to add/remove listeners while firing, although a
	 * listener that is added will not be notified of the current event.
	 * The order in which links are notified is undefined.
	 * 
	 * @throws Error
	 *             if fireEvent is called while in fireEvent to aggressively
	 *             prevent recursive link hierarchies.
	 */
	@SuppressWarnings("unchecked")
	public final void sendEvent(final EventType event) {
		if (firing) throw new Error("can't fire while firing");
		firing = true;

		if (cache == null) {
			// unchecked.
			if (linkCount == 0) cache = EMPTY_LINK_ARRAY;
			else cache = links.toArray(new GenericLink[links.size()]);

		}

		try {
			// localize cache so that modification to listeners
			// while firing will not cause NPE
			GenericLink<? super EventType>[] localCache = cache;
            for (GenericLink<? super EventType> aLocalCache : localCache) {
                aLocalCache.signal(event);
            }
		} finally {
			firing = false;
		}
	}

	private boolean firing = false;

}
