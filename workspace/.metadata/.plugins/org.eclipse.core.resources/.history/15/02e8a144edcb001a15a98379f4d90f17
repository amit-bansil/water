/*
 * EnumEvent.java
 * CREATED:    Feb 7, 2005 12:37:24 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-event
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event.tools;

import java.util.EventObject;

/**
 * An event identified by an enumeration constant.
 * @author Amit Bansil
 * @version $Id$
 */
public class EnumEvent<T extends Enum> extends EventObject {
	private final T action;
	public EnumEvent(Object source,T action) {
		super(source);
		this.action=action;
	}
	public T getAction() {
		return action;
	}
}
