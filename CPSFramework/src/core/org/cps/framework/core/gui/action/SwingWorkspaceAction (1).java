/*
 * WorkspaceAction.java CREATED: Dec 21, 2003 4:02:14 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.gui.action;

import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.ConstantBoundPropertyRO;
import org.cps.framework.core.gui.dialogs.ErrorDialog;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.core.util.HelpReference;
import org.cps.framework.core.util.WebBrowser;
import org.cps.framework.core.util.WebBrowser.BrowserException;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Component;
import java.awt.Container;
import java.net.URL;

/**
 * encapsulates an action. accessible from EDT only.
 * 
 * @todo undo support
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class SwingWorkspaceAction {
	private static final ResourceAccessor res = ResourceAccessor
			.load(SwingWorkspaceAction.class);

	private final ActionDescription desc;

	public final ActionDescription getDescription() {
		return desc;
	}

	public SwingWorkspaceAction(ResourceAccessor parentRes, String name) {
		this(parentRes, name, null);
	}

	public SwingWorkspaceAction(ResourceAccessor parentRes, String name,
			BoundPropertyRO<Boolean> enabled) {
		this.desc = new ActionDescription(parentRes, name);
		this.enabled = enabled != null ? enabled
				: new ConstantBoundPropertyRO<Boolean>(Boolean.TRUE);
	}

	/**
	 * perform the action. must be invoked on GUIthread will do nothing if not
	 * enabled TODO log blocked actions
	 */
	public final void perform() {
		GuiEventUtils.checkThread();
		if (enabled.get().booleanValue()) _perform();
	}

	/**
	 * hook to perform action. called on GUIThread only when enabled.
	 */
	protected abstract void _perform();

	private final BoundPropertyRO<Boolean> enabled;

	/**
	 * only accessible from GUI TEST access
	 * 
	 * @return a boolean property indicating if the action can be performed.
	 */
	public BoundPropertyRO<Boolean> enabled() {
		GuiEventUtils.checkThread();
		return enabled;
	}

	//some utilities for common actions
	public static final SwingWorkspaceAction showURLAction(
			final ResourceAccessor parentRes, final String name, final URL l,
			final Component parent) {

		return new SwingWorkspaceAction(parentRes, name) {
			protected void _perform() {
				try {
					WebBrowser.showURL(l);
				} catch (BrowserException e) {
					ErrorDialog.createErrorDialog(null, e).show(parent);
				}
			}
		};
	}

	public static final SwingWorkspaceAction moreInfoAction(
			final BasicDescription desc,final Container parent) {
		final HelpReference help=desc.getMoreInfo();
		return new SwingWorkspaceAction(res.composite(new Object[]{"name",
				desc.getTitle()}), "moreInfo") {
			protected void _perform() {
				help.showHelpPage(parent);
			}
		};
	}

}