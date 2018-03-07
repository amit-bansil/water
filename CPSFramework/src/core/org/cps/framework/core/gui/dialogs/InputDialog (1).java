/*
 * InputDialog.java
 * CREATED:    Aug 17, 2004 1:45:52 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.core.gui.components.SimpleWindow;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSeparator;
import javax.swing.SwingConstants;

import java.awt.Component;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * prompts
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class InputDialog<T> extends WorkspaceDialog<T> {	
	protected InputDialog(ResourceAccessor parentRes, String name,
			boolean encourageCancel, boolean smallContent,JComponent edt) {
		super(parentRes, name);
		//ok off event since gui invisible
		content = new JPanel();
		content.setLayout(new GridBagLayout());
		GridBagConstraints gbc=new GridBagConstraints();
		gbc.insets=new Insets(0,0,0,0);
		gbc.anchor=GridBagConstraints.NORTHWEST;
		gbc.gridheight=gbc.gridwidth=1;
		gbc.ipadx=gbc.ipady=0;
		gbc.gridx=gbc.gridy=0;
		gbc.weightx=gbc.weighty=0;
		gbc.fill=GridBagConstraints.NONE;
		
		content.setBorder(BorderFactory.createEmptyBorder(12, 12, 12, 12));
		if (smallContent && getDescription().hasDescription()) {
			JLabel descLabel = new JLabel(getDescription().getDescription()
					+ ":", SwingConstants.LEFT);
			gbc.insets=new Insets(0,0,2,0);
			content.add(descLabel,gbc);
			gbc.gridy++;
		}

		gbc.fill=GridBagConstraints.HORIZONTAL;
		
		JComponent editor = edt;
		gbc.weightx=gbc.weighty=1;
		content.add(editor,gbc);
		gbc.gridy++;

		if (smallContent) {
			//content.add(Box.createVerticalGlue());
			content.add(Box.createVerticalStrut(18),gbc);
		} else {
			content.add(new JSeparator(),gbc);
		}
		gbc.gridy++;

		gbc.fill=GridBagConstraints.NONE;
		
		okButton = new JButton("OK");
		okButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(okButton.isEnabled()) {
					OK = true;
					window.hide();
				}
			}
		});
		Box buttonPanel=Box.createHorizontalBox();
		buttonPanel.add(Box.createHorizontalGlue());
		if (encourageCancel) {
			JButton cancelButton = new JButton("cancel");
			cancelButton.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					window.hide();
				}
			});
			JComponent buttons = new JPanel(new GridLayout(1, 2, 6, 0));
			buttons.add(okButton);
			buttons.add(cancelButton);
			buttonPanel.add(buttons);
		} else {
			buttonPanel.add(okButton);
		}
		gbc.anchor=GridBagConstraints.SOUTHEAST;
		content.add(buttonPanel,gbc);
	}

	boolean OK = false;

	private SimpleWindow window;

	private final JComponent content;
	private final JButton okButton;
	//TODO macos&windows ordering,extralize strings, mnemonics,etc. through
	//fast static ui
	//optimize away window creation in simple window by keeping a stack of old
	//dialogs
	protected final T _show(Component parent) {
		window = SimpleWindow.createDialog(getDescription()
				.getTitle(), parent, true, true);
		GuiEventUtils.checkThread();
		window.setContent(content);
		window.setDefaultButton(okButton);
		link();
		window.show();
		unlink();
		window=null;
		return OK ? getEditorValue() : null;
	}
	protected final void setOKEnabled(boolean v) {
		if(okButton.isEnabled()!=v)okButton.setEnabled(v);
	}
	protected final void setOKVisible(boolean v) {
		okButton.setVisible(v);
	}
	protected abstract void link();
	protected abstract void unlink();

	protected abstract T getEditorValue();//null for cancel
}