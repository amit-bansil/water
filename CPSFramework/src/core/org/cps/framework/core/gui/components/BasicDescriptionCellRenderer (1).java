/*
 * BasicDescriptionCellRenderer.java
 * CREATED:    Jul 9, 2004 9:08:11 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.util.BasicDescription;

import javax.swing.Icon;
import javax.swing.JTree;
import javax.swing.tree.DefaultTreeCellRenderer;

import java.awt.Component;

/**
 * renders a tree where userdata objects are either basic descriptions or
 * strings. override _convertUserObject if other types of data are desired
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class BasicDescriptionCellRenderer extends DefaultTreeCellRenderer {

	public BasicDescriptionCellRenderer() {
		super();
	}

	public final Component getTreeCellRendererComponent(JTree tree,
			Object value, boolean sel, boolean expanded, boolean leaf, int row,
			boolean hasFocus) {
		value = _convertUserObject(value);

		String title = null, desc = null;
		Icon icon = null;
		if (value instanceof BasicDescription) {
			BasicDescription d = ((BasicDescription) value);
			title = d.getTitle();
			desc = d.hasDescription() ? d.getDescription() : d.getFullTitle();
			if (d.hasIcon()) icon = d.getIcon();
		} else if (!(value instanceof String))
			throw new IllegalArgumentException("value "+value+" not string or" +
					" BasicDescription");

		super.getTreeCellRendererComponent(tree, value, sel, expanded, leaf,
				row, hasFocus);
		
		if(icon!=null)setIcon(icon);
		if(desc!=null)setToolTipText(desc);
		if(title!=null)setText(title);

		return this;
	}

	protected Object _convertUserObject(Object in) {
		return in;
	}
}