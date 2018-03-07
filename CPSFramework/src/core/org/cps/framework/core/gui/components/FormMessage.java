/*
 * FormMessage.java
 * CREATED:    Aug 15, 2004 6:25:01 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.gui.action.SwingWorkspaceAction;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.util.resource.reader.IconReader;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.Icon;

import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.MissingResourceException;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class FormMessage extends BasicDescription{
	private static final ResourceAccessor res = ResourceAccessor.load(
			FormMessage.class);
	
	public static final Icon error_badge=res.getObject("error_badge.icon",
			IconReader.INSTANCE);
	public static final Icon warning_badge=res.getObject("warning_badge.icon",
			IconReader.INSTANCE);
	public static final Icon error_message=res.getObject("error_message.icon",
			IconReader.INSTANCE);
	public static final Icon warning_message=res.getObject("warning_badge.icon",
			IconReader.INSTANCE);
	
	public static final int WARNING_TYPE=0,ERROR_TYPE=1,INFO_TYPE=2;
	private final int type;
	public final int getType() {
		return type;
	}
	public final Icon getBadge() {
		switch(type) {
			case WARNING_TYPE:return warning_badge;
			case ERROR_TYPE:return error_badge;
			case INFO_TYPE:return null;
			default: throw new UnknownError();
		}
	}
	private final Collection<SwingWorkspaceAction> actions;
	public final Collection<SwingWorkspaceAction> getActions(){
		return actions;
	}
	public FormMessage(ResourceAccessor parentRes, String name,int type) {
		super(parentRes,name);
		this.type=type;
		Collection c=Collections.emptySet();
		actions=c;
		//force description
		getDescription();
	}
	public FormMessage(ResourceAccessor parentRes, String name,int type,
			SwingWorkspaceAction[] actions) {
		super(parentRes,name);
		this.type=type;
		this.actions=Collections.unmodifiableCollection(Arrays.asList(actions));
		//force description
		getDescription();
	}
	public Icon getIcon() throws MissingResourceException {
		if(!super.hasIcon()) {
			switch(type) {
				case WARNING_TYPE:return warning_message;
				case ERROR_TYPE:return error_message;
			}
		}
		return super.getIcon();
	}
	public boolean hasIcon() {
		return super.hasIcon()||type==WARNING_TYPE||type==ERROR_TYPE;
	}
}
