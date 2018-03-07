/*
 * MessageDialog.java CREATED: Dec 27, 2003 3:36:18 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package cps.jarch.gui.dialog;

import cps.jarch.gui.resources.DescribedException;
import cps.jarch.gui.resources.MessageBundle;

import javax.swing.JOptionPane;

import java.awt.Component;

/**
 * A dialog that simply presents information. TEST types are unique
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class MessageDialog extends WorkspaceDialog<Object> {
	// type
	public static enum Type {
		ERROR_TYPE(JOptionPane.ERROR_MESSAGE), INFO_TYPE(
				JOptionPane.INFORMATION_MESSAGE), WARNING_TYPE(
				JOptionPane.WARNING_MESSAGE);
		private final int JOptPaneConst;

		public int getJOptionPaneConstant() {
			return JOptPaneConst;
		}

		private Type(int jOptPaneConst) {
			this.JOptPaneConst = jOptPaneConst;
		}
	}

	private final Type type;

	public final Type getType() {
		return type;
	}
	//TODO rewrite for new message dialog
	// constructor
	public MessageDialog(String name, MessageBundle res, Type type,
			Object... messageData) {
		super(name, res);
		this.type = type;
	}

	// show
	@Override
	protected Object _show(Component parent) {
		// TODO log warning instead
		//if (StringUtils.isBlank(getMessage()))
		//	throw new Error("dialog " + getName() + " contains blank message:'"
		//			+ getMessage() + '\'');
		JOptionPane.showMessageDialog(parent, getMessage(), getTitle(), type
				.getJOptionPaneConstant());
		return null;
	}

	// ------------------------------------------------------------------------
	// Error Dialog
	// ------------------------------------------------------------------------

	private static final String FULL_ERROR_PATTERN = "full_pattern",
			SHORT_ERROR_PATTERN = "short_pattern",
			MID_ERROR_PATTERN = "mid_pattern",
			BASIC_ERROR_PATTERN = "basic_pattern",
			GENERAL_MESSAGE = getDialogResources().loadString(
					"message.error.general_description");

	public static final MessageDialog createErrorDialog(String specificError) {
		return createErrorDialog(specificError, null);
	}

	public static final MessageDialog createErrorDialog(String specificError,
			Throwable t) {
		String pattern;
		String lm = "";
        //noinspection InstanceofIncompatibleInterface
        if (t != null && t instanceof DescribedException) {
            lm = t.getLocalizedMessage();
            if (specificError != null) {
                pattern = FULL_ERROR_PATTERN;
            } else {
                pattern = MID_ERROR_PATTERN;
            }
        } else {
            if (specificError != null) {
                pattern = SHORT_ERROR_PATTERN;
            } else
                pattern = BASIC_ERROR_PATTERN;
        }
		// no name for description
		// OPTIMIZE cache dialog resources below message.error
		//OPTIMIZE build this up from a list to avoid performing replaces on unused parameters
		if(specificError==null)specificError="";
		return new MessageDialog("message.error." + pattern,
				getDialogResources(), Type.ERROR_TYPE, "error_general",
				GENERAL_MESSAGE, "error_specific", specificError,
				"error_detail", lm);
	}

}
