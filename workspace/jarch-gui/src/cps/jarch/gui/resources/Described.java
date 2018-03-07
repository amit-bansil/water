/*
 * LocalizedEnum.java
 * CREATED:    Jun 14, 2005 9:24:38 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.resources;

import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import javax.swing.Icon;

/**
 * An object which can be expressed in a localized manner. This
 * description is deeply immutable.
 */
public interface Described {

	public static String DESCRIPTION_KEY_POSTFIX = "description";

	public static String TITLE_KEY_POSTFIX = "title";

	public static String ICON_KEY_POSTFIX = "icon";

	/**
	 * A short tile for the object, not <code>null</code>. May throw an error
	 * if the title is loaded lazily and it is not found.
	 */
	@Constant public String getTitle();

	/**
	 * 1 or 2 sentences describing the object.
	 */
	@Constant @Nullable public String getDescription();

	//TODO custom icon extension, allowing multiple sizes?
	/**
	 * implementation should specify size of icon or if it is always
	 * <code>null</code>.
	 */
	@Constant @Nullable public Icon getIcon();

	/**
	 * @return unlocalized name of object.
	 */
	@Constant public String getName();
}