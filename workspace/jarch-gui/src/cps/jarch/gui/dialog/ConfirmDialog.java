/*
 * ConfirmDialog.java CREATED: Dec 27, 2003 3:36:43 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package cps.jarch.gui.dialog;

import cps.jarch.gui.resources.MessageBundle;
import cps.jarch.util.notes.Immutable;

import javax.swing.JOptionPane;

import java.awt.Component;

/**
 * Shows a dialog asking the user if they would like to perform an operation.
 * TODO rewrite w. prefs, forcing of verb for yes,  & new workspace dialog
 * @version $Id: ConfirmDialog.java 543 2005-09-02 12:23:19Z bansil $
 * @author Amit Bansil
 */
public @Immutable class ConfirmDialog extends WorkspaceDialog<ConfirmDialog.Choice> {
	// TODO allow suppression preference
	//(and preference for suppression of suppression preference)
	// TODO allow initial selection selection
	public static enum Choice {
		YES, NO, CANCEL
	}

	public static final String YES_KEY = "yes_option", NO_KEY = "no_option",
			CANCEL_KEY = "cancel_option";

	public static enum Type {
		WARNING(JOptionPane.WARNING_MESSAGE), QUESTION(JOptionPane.QUESTION_MESSAGE);
		final int typeConst;

		public final int getJOptionPaneTypeConstant() {
			return typeConst;
		}

		Type(int typeConst) {
			this.typeConst = typeConst;
		}
	}

	private final boolean allowCancel;

	private final Type type;

	private final Object[] options;
/*
	public ConfirmDialog(String name, ResourceAccessor res, boolean allowCancel,
			Type type, Object... messageData) {
		this(name, res, allowCancel, type, false, messageData);
	}
	*/
	// if custom labels must res must have
	// YES_KEY,NO_KEY, and if allowCancel, CANCEL_KEY
	public ConfirmDialog(String name, MessageBundle res, boolean allowCancel,
			Type type, boolean customLables) {
		super(name, res);
		this.allowCancel = allowCancel;
		this.type = type;
		if (customLables) {
			// TODO match order to GUI
			options = new String[allowCancel ? 3 : 2];
			options[0] = res.loadString(name + '.' + YES_KEY);
			options[1] = res.loadString(name + '.' + NO_KEY);
			if (allowCancel) options[2] = res.loadString(name + '.' + CANCEL_KEY);
		} else {
			options = null;
		}
	}

	@Override protected ConfirmDialog.Choice _show(Component parent) {
		// TODO log warning instead
		//if (StringUtils.isBlank(getMessage()))
		//	throw new Error("dialog " + getName() + " contains blank message:'"
		//			+ getMessage() + '\'');

		int ret;
		int optionType = allowCancel ? JOptionPane.YES_NO_CANCEL_OPTION
				: JOptionPane.YES_NO_OPTION;
		ret = JOptionPane.showOptionDialog(parent, getMessage(), getTitle(), optionType,
			type.getJOptionPaneTypeConstant(), null, options, null);

		switch (ret) {
			case JOptionPane.YES_OPTION:
				return Choice.YES;
			case JOptionPane.NO_OPTION:
				return Choice.NO;
			case JOptionPane.CANCEL_OPTION:
				assert allowCancel;
				return Choice.CANCEL;
			case JOptionPane.CLOSED_OPTION:
				if (allowCancel) return Choice.CANCEL;
				else return Choice.NO;
			default:
				throw new UnknownError();
		}
	}
}
