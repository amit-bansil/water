/*
 * CREATED:    Jul 30, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.event;

import org.cps.framework.core.event.simple.SimpleNotifier;
import org.cps.framework.core.event.simple.SimpleObservable;

/**
 */
public final class SwingToCPSObservable extends SwingToCPSAdapter{
    private final SimpleNotifier notifier; 
    public SwingToCPSObservable(String name, boolean concatenateEvents,Object source){
        super(name,concatenateEvents);
        notifier=new SimpleNotifier(source);
    }

    public void CPSRun(Object context){
        notifier.fireEvent();
    }
    public SimpleObservable getObservable(){
        return notifier;
    }
}
