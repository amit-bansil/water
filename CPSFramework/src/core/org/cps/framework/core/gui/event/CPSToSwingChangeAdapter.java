/*
 * Created on Feb 23, 2003
 */
package org.cps.framework.core.gui.event;

import javax.swing.SwingUtilities;

import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;

/**
 * handles CPSEvent on Swing thread
 * @author Amit Bansil
 */
//OPTIMIZE just call straightup when already in event thread?
public abstract class CPSToSwingChangeAdapter<T> implements ValueChangeListener<T>{
	private final String name;
	protected CPSToSwingChangeAdapter(String actionName){
		name=actionName;
	}
	public final void eventOccurred(final ValueChangeEvent<T> evt) {
		CPSQueue.getInstance().checkThread();
		SwingUtilities.invokeLater(new Runnable(){
			public void run(){
				//don'w pass src since it should be accessed only from CPS
				if(evt!=null)
				swingRun(evt.getOldValue(),evt.getNewValue());
				else swingRun(null,null);
			}
		});
	}
	protected abstract void swingRun(final T oldValue,final T newValue);
	public final String toString(){
		return name;
	}
}
