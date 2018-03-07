/*
 * WorkspaceDialog.java
 * CREATED:    Dec 27, 2003 3:36:30 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.core.event.queue.RunnableEx;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Component;
import java.lang.reflect.InvocationTargetException;

/**
 * Generic superclass for threadsafe blocking modal dialogs. immutable. TEST
 * threadsafety. TODO generic show returntype
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class WorkspaceDialog<T> {
	private static final ResourceAccessor dialogResources = ResourceAccessor
			.load(WorkspaceDialog.class);

	public static final ResourceAccessor getDialogResources() {
		return dialogResources;
	}

	//description
	public final BasicDescription getDescription() {
		return description;
	}

	private final BasicDescription description;

	protected WorkspaceDialog(ResourceAccessor parentRes, String name) {
		this.description = new BasicDescription(parentRes, name);
	}

	/**
	 * each show call should create a new (awt) dialog.
	 * 
	 * @param parent
	 *            the component to center dialog above, null is allowed TEST
	 *            null works
	 * @return user's selection or null if none
	 */
	public final T show(final Component parent) {
		try {
			return GuiEventUtils.invokeAndWait(new RunnableEx<T>() {
				public final T run() throws Exception {
					return _show(parent);
				}
			});
		} catch (InvocationTargetException e) {
			//should not happen
			throw new Error(e);
		}
	}

	/**
	 * hook to show dialog. occurs on EDT. exceptions are promted to errors and
	 * propagated to show caller
	 * 
	 * @param parent
	 *            component to show above, may be null
	 * @return user's selection or null if none.
	 */
	protected abstract T _show(Component parent);
}