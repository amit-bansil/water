/*
 * SimpleDialog.java
 * CREATED:    Mar 13, 2005 8:42:36 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.dialog;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JOptionPane;
import javax.swing.WindowConstants;

import java.awt.Component;
import java.awt.Container;

/**
 * an easy wrapper for a 1 shot modal dialog.
 * 
 * @version 1.0
 * @author Amit Bansil
 */
public class SimpleDialog {
	private final JDialog dialog;
	private final Component parent;
	
	public SimpleDialog(String title, Component parent, Container content) {
		this(title, parent, content, null);
	}

	public SimpleDialog(String title, Component parent, Container content,
			JButton defaultButton) {
		dialog = new JDialog(JOptionPane.getFrameForComponent(parent), title,
				true);

		dialog.setContentPane(content);
		if(defaultButton!=null)dialog.getRootPane().setDefaultButton(defaultButton);
		dialog.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
		this.parent=parent;
	}
	private boolean shown=false;
	public final void setVisible(boolean v) {
		if(v) {
			if(shown)throw new IllegalStateException("already shown");
			shown=true;
			dialog.pack();
			dialog.setLocationRelativeTo(parent);
		}else {
			if(!shown)throw new IllegalStateException("!yet shown");
		}
		dialog.setVisible(v);
	}
}
