/*
 * CREATED:    Jul 19, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.core;

import java.util.EventListener;

/**
 * used with constraint notifier to prevent certain types of change events by firing VetoExceptions
 */
public interface Constraint<EventType/*CHEETAH BUG extends EventObject*/> extends EventListener{
    public void checkEvent(EventType event)throws VetoException;
}
