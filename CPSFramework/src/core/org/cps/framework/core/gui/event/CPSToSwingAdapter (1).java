/*
 * CPSToSwingRunnableAdapter.java
 * CREATED:    Dec 31, 2003 5:24:27 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.event;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.queue.CPSQueue;

import javax.swing.SwingUtilities;

/**
 * executes runnable on swing triggered by cps
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class CPSToSwingAdapter<T> implements Runnable,GenericListener{
	private final String name;
	private final boolean concatenateEvents;
	private boolean runPending=false;
	protected CPSToSwingAdapter(String actionName,boolean concatenateEvents){
		name=actionName;
		this.concatenateEvents=concatenateEvents;
	}
	//runnable
	public final void run() {
		CPSRun(null);
	}
	//generic listener
	public final void eventOccurred(Object evt) {
		CPSRun(evt);
	}
	private T context=null;
	public final void CPSRun(Object evt) {
		CPSQueue.getInstance().checkThread();
	    synchronized(this){
			context=getContext(evt,context);
			if(!concatenateEvents||!runPending){
			    runPending=true;
			    if(concatenateEvents) {//real lazy if we can
			    	CPSQueue.getInstance().postRunnableCPSNow(cpsRunner);
			    }else cpsRunner.run();
			}
	    }
	}
	private final Runnable cpsRunner=new Runnable() {
		public void run() {
	    	SwingUtilities.invokeLater(swingRunner);
		}
		public String toString() {
			return name;
		}	
	};
	private final Runnable swingRunner=new Runnable(){
		public void run() {
			_swingRun();
		}
		public String toString() {
			return name;
		}
	};
	private final void _swingRun(){
	    final T tempContext;
		synchronized(this){
		    tempContext=context;
		    context=null;
		    runPending=false;
	    }
		swingRun(tempContext);
	}
	
	protected abstract void swingRun(T context);
	
	//CONTEXT MUST BE THREADSAFE,don't call,only accessed from cps
	//might get called alot
	protected T getContext(Object evt,T oldContext){return null;}
	
	public final String toString(){
		return name;
	}
}
