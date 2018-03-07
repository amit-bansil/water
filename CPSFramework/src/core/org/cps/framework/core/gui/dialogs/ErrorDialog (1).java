/*
 * ErrorDialog.java CREATED: Dec 28, 2003 10:09:06 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.util.lang.misc.LocalizedException;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.util.HashMap;
import java.util.Map;

/**
 * @version 0.1
 * @author Amit Bansil
 */
public final class ErrorDialog extends MessageDialog {
	private ErrorDialog(ResourceAccessor parentRes,String name) {
		super(parentRes,name, ERROR_TYPE);
	}

	private static final ResourceAccessor errorResAccess = MESSAGE_RESOURCES
			.getChild("error");

	private static final String generalDescription = errorResAccess
			.getString("general_description"),
			fullErrorPattern = errorResAccess.getString("full_pattern"),
			shortErrorPattern = errorResAccess.getString("short_pattern"),
			midErrorPattern = errorResAccess.getString("mid_pattern"),
			basicErrorPattern = errorResAccess.getString("basic_pattern");

	public static final ErrorDialog createErrorDialog(String specificError,
			Throwable t) {
		String description;
		final Map<String,String> data = new HashMap<String,String>();
		data.put("error_general", generalDescription);
		if (t != null && t instanceof LocalizedException) {
			data.put("error_detail", t.getLocalizedMessage());
			if (specificError != null) {
				data.put("error_specific", specificError);
				description = fullErrorPattern;
			} else {
				description = midErrorPattern;
			}
		} else {
			if (specificError != null) {
				data.put("error_specific", specificError);
				description = shortErrorPattern;
			} else
				description = basicErrorPattern;
		}
		//no name for description
		return new ErrorDialog(errorResAccess.override(
				BasicDescription.DESCRIPTION_KEY, description).composite(data),null);
	}

}
