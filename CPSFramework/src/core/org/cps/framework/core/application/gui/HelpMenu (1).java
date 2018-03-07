/*
 * HelpMenu.java created on Apr 6, 2003 by Amit Bansil. Part of The Virtual
 * Molecular Dynamics Laboratory, vmdl2 project. Copyright 2003 Center for
 * Polymer Studies, Boston University.
 */
package org.cps.framework.core.application.gui;

import org.cps.framework.core.application.core.ApplicationDescription;
import org.cps.framework.core.gui.action.SwingWorkspaceAction;
import org.cps.framework.core.gui.components.AboutScreen;
import org.cps.framework.core.gui.components.WorkspaceMenu;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Container;

/**
 * @author Amit Bansil.
 */
//TODO error handling
public class HelpMenu extends WorkspaceMenu {
	protected AboutScreen splash;

	public HelpMenu(final ApplicationDescription desc, final Container parent) {
		super(ResourceAccessor.load(HelpMenu.class));
		final ResourceAccessor res = getResources().composite(
				new Object[][]{{"app_title", desc.getShortTitle()},
						{"organization", desc.getOrganizationTitle()}});

		addMenuItem(SwingWorkspaceAction.showURLAction(res, "online", desc
				.getWebsiteURL(), parent));
		addMenuItem(SwingWorkspaceAction.showURLAction(res, "contact", desc
				.getContactURL(), parent));
		/*TODO renable this feature when help is setup
		 * addMenuItem(new SwingWorkspaceAction(res, "guide") {
			public final void _perform() {
				desc.getHelpReference().showHelpPage(parent);
			}
		});*/

		addMenuItem(new SwingWorkspaceAction(res, "about") {
			public final void _perform() {
				if (splash != null) splash.close();
				//TODO full about screen
				splash = new AboutScreen(parent, desc.getAboutScreen(), true);
			}
		});

		initialize();
	}
}