/*
 * MessageDialog.java CREATED: Dec 27, 2003 3:36:18 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.JOptionPane;

import java.awt.Component;

/**
 * A dialog that simply presents information. TEST types are unique
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class MessageDialog extends WorkspaceDialog {
	//resources
	protected static final ResourceAccessor MESSAGE_RESOURCES = WorkspaceDialog
			.getDialogResources().getChild("message");
	//type
	public static final int ERROR_TYPE = JOptionPane.ERROR_MESSAGE,
			INFO_TYPE = JOptionPane.INFORMATION_MESSAGE,
			WARNING_TYPE = JOptionPane.WARNING_MESSAGE;

	private final int type;

	public final int getType() {
		return type;
	}

	//constructor
	public MessageDialog(ResourceAccessor res,String name, int type) {
		super(res,name);
		this.type = type;
	}

	//show
	//TEST null icon uses type icon
	protected Object _show(Component parent) {
		JOptionPane.showMessageDialog(parent,
				getDescription().getDescription(), getDescription().getTitle(),
				type, getDescription().hasIcon() ? getDescription().getIcon()
						: null);
		return null;
	}
}
