/*
 * Link.java
 * CREATED:    Jun 18, 2005 3:48:28 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-event
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event;

import java.util.EventListener;
import java.util.EventObject;
//TODO rename this to GenericLink and make SimpleLink Link
/**
 * A generalization of {@link java.util.EventListener}.
 * GenericLinks are registered with {@link GenericSource} objects
 * which call <code>signal</code> on them when events occur.
 * @version $Id$
 */
public interface GenericLink<EventType extends EventObject> extends EventListener {
	/**
	 * Unless explicitly stated, event is not <code>null</code>.
	 * <code>event.getSource()</code> may be any object 'responsible' for the
	 * event, and is not necessarily a {@link GenericSource} (if any) that this link is
	 * registered with.
	 */
	public void signal(EventType event);
}