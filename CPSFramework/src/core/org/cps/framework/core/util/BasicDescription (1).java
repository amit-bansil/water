/*
 * BasicDescription.java
 * CREATED:    Aug 8, 2003 7:53:44 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.util;

import org.apache.commons.lang.StringUtils;
import org.cps.framework.util.resource.reader.IconReader;
import org.cps.framework.util.resources.accessor.MapResourceAccessor;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.Icon;

import java.util.HashMap;
import java.util.Map;
import java.util.MissingResourceException;

/**
 * BasicDescription based on a resourceAccessor
 * 
 * @version 1.0
 * @author Amit Bansil
 */
public class BasicDescription {
	public final BasicDescription overrideName(String name,String title,String
			description) {
		Map<String,String> newData=new HashMap();
		if(!StringUtils.isBlank(title)) {
			newData.put(TITLE_KEY,title);
			newData.put(TITLE_FULL_KEY,title);
			newData.put(TITLE_SHORT_KEY,title);
		}
		if(!StringUtils.isBlank(description)) {
			newData.put(DESCRIPTION_KEY,description);
		}
		ResourceAccessor data=getData();
		if(!newData.isEmpty())data=data.override(new MapResourceAccessor(
				name+"(synthetic data)",newData,null));
		return new BasicDescription(data, name, false);
	}

	private final String name;

	public final String getName() {
		return name;
	}

	private final ResourceAccessor data;

	public final ResourceAccessor getData() {
		return data;
	}

	private final String title;

	public BasicDescription(ResourceAccessor parentRes, String name) {
		this(parentRes, name, true);
	}

	public BasicDescription(ResourceAccessor data, String name,
			boolean childResources) {
		this.data = childResources ? data.getChild(name) : data;
		//OPTIMIZED get title now so we will fail if it is not defined
		title = this.data.getString(TITLE_KEY);
		this.name = name != null ? name : this.data.getResourceName();
	}

	//keys
	public static final String DESCRIPTION_KEY = "description";

	public static final String TITLE_KEY = "title";

	public static final String TITLE_FULL_KEY = "title.full";

	public static final String TITLE_SHORT_KEY = "title.short";

	public static final String ICON_KEY = "icon";

	public static final String MORE_INFO_KEY = "info_url";

	//elements
	//always present
	public final String getTitle() {
		return title;
	}

	public final String getFullTitle() {
		if (hasFullTitle()) return data.getString(TITLE_FULL_KEY);
		else
			return getTitle();
	}

	public final String getShortTitle() {
		if (hasShortTitle()) return data.getString(TITLE_SHORT_KEY);
		else
			return getTitle();
	}

	//may fail
	public final HelpReference getMoreInfo() throws MissingResourceException {
		return data.getObject(MORE_INFO_KEY, HelpReference.READER);
	}

	public Icon getIcon() throws MissingResourceException {
		return data.getObject(ICON_KEY, IconReader.INSTANCE);
	}

	public final String getDescription() throws MissingResourceException {
		return data.getString(DESCRIPTION_KEY);
	}

	//test for various elements
	public final boolean hasShortTitle() {
		return data.hasKey(TITLE_SHORT_KEY);
	}

	public final boolean hasFullTitle() {
		return data.hasKey(TITLE_FULL_KEY);
	}

	public boolean hasIcon() {
		return data.hasKey(ICON_KEY);
	}

	public final boolean hasDescription() {
		return data.hasKey(DESCRIPTION_KEY);
	}

	public final boolean hasMoreInfo() {
		return data.hasKey(MORE_INFO_KEY);
	}
	//for artificial descriptions:
}