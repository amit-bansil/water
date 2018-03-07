/*
 * CREATED:    Jul 19, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.core;

import java.util.EventObject;

/**
 * signifies that a change encapsulated by an event has been blocked,
 * normally by a Constraint.
 * the localized message should be filled in whenever possible, however,
 * null may be substituted in which case getLocalizedMessage() will return
 * getMessage.
 * This is a general version of java bean's PropertyVetoException
 */
public class VetoException extends Exception{
    public VetoException(EventObject event,String message){
        super(message);
        this.local=null;
        this.vetoedEvent=event;
    }

    public VetoException(EventObject event,String message,String localizedMessage, Throwable cause){
        super(message,cause);
        this.local=localizedMessage;
        this.vetoedEvent=event;
    }
    
    public VetoException(EventObject event,String message,String localizedMessage){
        super(message);
        this.local=localizedMessage;
        this.vetoedEvent=event;
    }
    
    private final String local;
    private final EventObject vetoedEvent;
    public EventObject getVetoedEvent(){
        return vetoedEvent;
    }
    public String getLocalizedMessage() {
        return local!=null?local:getMessage();
    }
}
