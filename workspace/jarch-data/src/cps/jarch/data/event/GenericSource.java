/*
 * CREATED:    Jul 24, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event;

import java.util.EventObject;

/**
 * An object that can be observed by registering
 * {@link GenericLink}s with it. It sends events &
 * accepts links of type <code>EventType</code>. Most <code>GenericSource</code>
 * implementations delegate this behavior to a
 * {@link GenericPublisher} or other <code>GenericSource</code>.<br>
 * 
 * <code>GenericLink</code> querying is intentionally not supported to discourage any
 * access to <code>GenericLink</code>s through this object. <br>
 * 
 * it is essential that clients call <code>disconnect</code> after calling
 * <code>connect</code> if they wish to be garbage collected before the
 * <code>GenericSource</code> they registered with, otherwise a sort of memory leak
 * may occur. The {@link Unlinker} object factors out
 * this behavior.<br>
 * @version $Id$
 */
public interface GenericSource<EventType extends EventObject> {
	/**
	 * connect <code>l</code> to this so that future events from this
	 * <code>Source</code> will be sent to it.
	 * 
	 * @throws Error
	 *             (not exception) possibly, but not always, if <code>l</code> is already
	 *             connected to this, for error checking.
	 */
	public void connect(GenericLink<? super EventType> l);

	/**
	 * disconnect <code>l</code> from this.
	 * 
	 * @throws Error
	 *             (not exception) possibly, but not always, if <code>l</code>
	 *             is not connected to this, for error checking.
	 */
	public void disconnect(GenericLink<? super EventType> l);

}
