/*
 * CPSActionListener.java created on May 4, 2003 by Amit Bansil. Part of The
 * Virtual Molecular Dynamics Laboratory, vmdl2 project. Copyright 2003 Center
 * for Polymer Studies, Boston University.
 */
package org.cps.framework.core.gui.event;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.queue.CPSQueue;

import javax.swing.SwingUtilities;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
/**
 * handles swing event from any source on CPSQueue could clone event and pass to
 * CPS but that would still encourage insecure access through references...
 * instead override getContext to read any state from swing OPTIMIZE don't sync
 * when no context
 * 
 * TODO abstract EventQueue
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class SwingToCPSAdapter<T>
	implements ActionListener,ChangeListener,PropertyChangeListener,
		DocumentListener,Runnable,GenericListener{
	protected final String name;
	private final boolean concatenateEvents;
	private boolean runPending=false;
	public SwingToCPSAdapter(String name,boolean concatenateEvents) {
		this.name = name;
		this.concatenateEvents=concatenateEvents;
	}
	//generic listener
	public final void eventOccurred(Object evt) {
		swingRun(evt);
	}
	//runnable
	public final void run() {
		swingRun(null);
	}
	
	//propertyChange
	public final void propertyChange(PropertyChangeEvent evt){
	    swingRun(evt);
	}
	//documentlistener-uses force swingrun since update may (unlikely) occur
    // async
	public final void insertUpdate(DocumentEvent e){
	    forceSwingRun(e);
	}
	public final void removeUpdate(DocumentEvent e){
	    forceSwingRun(e);
	}
	public final void changedUpdate(DocumentEvent e){
	    forceSwingRun(e);
	}
	//actionlistener
	public final void actionPerformed(ActionEvent e) {
		swingRun(e);
	}
	//changeListener
	public final void stateChanged(ChangeEvent e){
	    swingRun(e);
	}
	private final void forceSwingRun(final Object evt){
	    if(SwingUtilities.isEventDispatchThread()) swingRun(evt);
	    else SwingUtilities.invokeLater(new Runnable(){
	        public void run(){
	            swingRun(evt);
	        }
	    });
	}
	
	private T context;
	public final void swingRun(Object evt) {
		GuiEventUtils.checkThread();
	    synchronized(this){
			context=getContext(evt,context);
			if(!concatenateEvents||!runPending){
			    runPending=true;
			    CPSQueue.getInstance().postRunnableExt(cpsRunner);
			}
	    }
	}
	private final Runnable cpsRunner=new Runnable(){
		public void run() {
		    _cpsRun();
		}
		public String toString() {
			return name;
		}
	};
	//CONTEXT MUST BE THREADSAFE,don't call,only accessed from swing
	//might get called alot
	protected T getContext(Object evt,T oldContext){return null;}
	protected final void _cpsRun(){
	    final T tempContext;
		synchronized(this){
		    tempContext=context;
		    context=null;
		    runPending=false;
	    }
		CPSRun(tempContext);
	}
	protected abstract void CPSRun(T context);
	
	public String toString() {
		return name;
	}
}