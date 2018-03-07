/*
 * CREATED:    January 18, 2003
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.core;

import java.util.EventListener;
/**
 * A basic EventListener which is notified of particular eventobjects.
 * intended to be used with GenericNotifier.
 */
//RENAME Listener to Link
public interface GenericListener<EventObjectType/*Cheetah BUG extends EventObject*/>
	extends EventListener{
	public void eventOccurred(EventObjectType event);
}
