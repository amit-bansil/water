/*
 * Publisher.java
 * CREATED:    Jun 18, 2005 10:07:38 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event;

import java.util.EventObject;

/**
 * Delegate use by {@link cps.jarch.data.event.GenericSource}s to track links and
 * send them events. <code>Source</code> implementations should generally hold
 * a private <code>Publisher</code> instance instead of sub-classing a
 * concrete <code>Publisher</code> to (1) avoid exposing fireEvent and (2)
 * allow varying publishing behavior.
 * @version $Id$
 */
public interface GenericPublisher<EventType extends EventObject> extends
		GenericSource<EventType> {
	/**
	 * Broadcasts event to the links registered with this source.<br>
	 * <code>event</code> must be immutable. Events must be not null.
	 */
	public void sendEvent(EventType event);

	/**
	 * Query this publisher to see if it has any links connected to it. Meant so
	 * that clients can avoid needless calls to <code>sendEvent</code>.
	 */
	public boolean hasLinks();
}