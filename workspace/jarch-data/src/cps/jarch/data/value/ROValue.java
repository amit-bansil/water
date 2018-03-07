/*
 * PropertyRO.java
 * CREATED:    Aug 9, 2003 11:03:28 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.value;

import cps.jarch.data.event.tools.Source;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.util.concurrent.locks.Lock;

/**
 * A less verbose implementation of a "JavaBeans Bound Property." Also, ROValues
 * can be manipulated without reflection. This is the root of all other types of
 * properties. It can be read via get and observed by connecting a
 * <code>Link</code>. The link will be signaled after any changes to the
 * value returned by get(). Optional locking is also available.
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public interface ROValue<T> extends
		Source{
	public boolean isNullable();
	/**
	 * @return value being observed, possibly <code>null</code> if <code>isNullable()</code>.
	 */
	public @Nullable T get();
	/**
	 * @return When reading/writing an ROValue in a context that may be
	 *         multi-threaded the corresponding locks in getLock() (if not
	 *         <code>null</code>) should be acquired to force a set of
	 *         operations to be completed atomically.
	 */
	public @Nullable @Constant Lock getLock();
}