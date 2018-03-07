/*
 * FileMenu.java created on Apr 6, 2003 by Amit Bansil.
 * Part of The Virtual Molecular Dynamics Laboratory, vmdl2 project.
 * Copyright 2003 Center for Polymer Studies, Boston University.
 **/
package org.cps.framework.core.application.gui;

import org.cps.framework.core.application.core.ShutdownManager;
import org.cps.framework.core.gui.action.CPSWorkspaceAction;
import org.cps.framework.core.gui.components.WorkspaceMenu;
import org.cps.framework.util.resources.accessor.ResourceAccessor;
/**
 * @author Amit Bansil.
 * 
 * TODO redesign to allow import,export,print etc.
 */
public final class FileMenu extends WorkspaceMenu {
	public FileMenu(DocumentActions d,final ShutdownManager shutdown) {
		super(ResourceAccessor.load(FileMenu.class));
		
		addMenuItem(d.getNewAction());
		addMenuItem(d.getOpenAction());
		addMenuItem(d.getSaveAction());
		addMenuItem(d.getRevertAction());
		addMenuItem(d.getSaveAsAction());
		addMenuItem(d.getImportAction());
		addMenuItem(d.getExportAction());
		
		addMenuItem(new CPSWorkspaceAction(getResources(),"quit",null) {
			protected void _cpsPerform() {
				shutdown.shutdown();
			}
		});
		initialize();
	}

}
