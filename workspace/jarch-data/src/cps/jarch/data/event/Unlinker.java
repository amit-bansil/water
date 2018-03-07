/*
 * Binding.java
 * CREATED:    Jan 25, 2005 10:16:27 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event;
//TODO composite unlinker class for 1,2,n unlinkers (var args style),
//have a CompositeUnlinkerBuilder so it can be done by calling add over and over
//OPTIMIZE this using a thread local pool?

/**
 * disconnects a {@link cps.jarch.data.event.GenericLink}> from a
 * {@link cps.jarch.data.event.GenericSource}.
 * @version $Id$
 */
public interface Unlinker {
	/**
	 * disconnects links associated with this Unlinker. Will usually, but
	 * not always, throw an error if called after these links have already been
	 * disconnected, for error checking.
	 */
	public void unlink();
}
