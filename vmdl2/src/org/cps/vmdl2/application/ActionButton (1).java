/*
 * ActionButton.java
 * CREATED:    Aug 20, 2004 11:09:40 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.application;

import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.action.ActionDescription;
import org.cps.framework.core.gui.action.SwingWorkspaceAction;

import javax.swing.JButton;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ActionButton extends JButton {
	private final SwingWorkspaceAction action;
	private final ActionListener al=new ActionListener(){
		public void actionPerformed(ActionEvent e) {
			if(action.enabled().get().booleanValue())action.perform();
		}
	};
	private final ValueChangeListener vl=new ValueChangeListener<Boolean>() {
		public void eventOccurred(ValueChangeEvent<Boolean> e) {
			setEnabled(e.getNewValue().booleanValue());
			//ERROR just don't reset focus here,
			//insead listen to enabled on 'primary buttons'
			SimulationGUI.resetFocus();
		}
	};
	public ActionButton(SwingWorkspaceAction action) {
		super();
		this.action=action;
		ActionDescription desc=action.getDescription();
		setText(desc.getTitle());
		if(desc.hasDescription())setToolTipText(desc.getDescription());
		if(desc.hasIcon())setIcon(desc.getIcon());
		if(desc.hasDisabledIcon())setDisabledIcon(desc.getDisabledIcon());
		if(desc.hasMnemonic())setMnemonic(desc.getMnemonicKeyCode());
		EventUtils.hookupListener(action.enabled(),vl);
		addActionListener(al);
	}
	public final void unlink() {
		removeActionListener(al);
		action.enabled().removeListener(vl);
		
	}
}
