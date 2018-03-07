/*
 * ConfirmDialog.java CREATED: Dec 27, 2003 3:36:43 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.Icon;
import javax.swing.JOptionPane;

import java.awt.Component;

/**
 * shows a dialog asking the user if they would like to perform an poperation
 * and prompting for a yes/no response or, optionally, to cancel the triggering
 * operation. UNCLEAR default is yes if the users closes cancels is possible
 * otherwise no is selected
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ConfirmDialog extends WorkspaceDialog {
	//TODO allow supression pref (and pref for suppression of suppresion prefs)
	//TODO allow initial selection selection
	
	//TODO MAKE THESE ENUMERATIONS
	public static final Object CHOICE_YES = "choice.yes",
			CHOICE_NO = "choice.no", CHOICE_CANCEL = "choice.cancel";
	public static final String YES_KEY="yes_option",NO_KEY="no_option",
			CANCEL_KEY="cancel_option";
	public static final int WARNING_TYPE = 0, QUESTION_TYPE = 1;

	private final boolean allowCancel;

	private final int type;

	private final Object[] options;
	public ConfirmDialog(ResourceAccessor res,String name, boolean allowCancel,
			int type) {
		this(res,name,allowCancel,type,false);
	}
	//if customlabels must res must have
	//YES_KEY,NO_KEY, and if allowCancel, CANCEL_KEY
	public ConfirmDialog(ResourceAccessor res,String name, boolean allowCancel,
			int type,boolean customLables) {
		super(res,name);
		this.allowCancel = allowCancel;
		this.type = type;
		if(customLables) {
			//TODO match order to GUI
			options=new String[allowCancel?3:2];
			options[0]=getDescription().getData().getString(YES_KEY);
			options[1]=getDescription().getData().getString(NO_KEY);
			if(allowCancel)
				options[2]=getDescription().getData().getString(CANCEL_KEY);
		}else {
			options=null;
		}
	}
	static {
		//hacky...
		assert JOptionPane.YES_OPTION==0;
		assert JOptionPane.NO_OPTION==1;
		assert JOptionPane.CANCEL_OPTION==2;
		assert JOptionPane.CLOSED_OPTION==-1;
	}
	protected Object _show(Component parent) {
		int ret;
		int messageType = this.type == WARNING_TYPE ?
				JOptionPane.WARNING_MESSAGE : JOptionPane.QUESTION_MESSAGE;
		int optionType = allowCancel ? JOptionPane.YES_NO_CANCEL_OPTION
				: JOptionPane.YES_NO_OPTION;
		Icon icon = getDescription().hasIcon() ? getDescription().getIcon()
				: null;
		ret = JOptionPane.showOptionDialog(parent,getDescription()
				.getDescription(),getDescription().getTitle(),optionType,
				messageType,icon,options,null);
		
		switch(ret) {
			case JOptionPane.YES_OPTION:
				return CHOICE_YES;
			case JOptionPane.NO_OPTION:
				return CHOICE_NO;
			case JOptionPane.CANCEL_OPTION:
				assert allowCancel;
				return CHOICE_CANCEL;
			case JOptionPane.CLOSED_OPTION:
				if(allowCancel)return CHOICE_CANCEL;
				else return CHOICE_NO;
			default:
				throw new UnknownError();
		}
	}
}
