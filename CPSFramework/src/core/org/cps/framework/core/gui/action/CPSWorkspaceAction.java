/*
 * CPSWorkspaceAction.java
 * CREATED:    Jan 2, 2004 4:18:36 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.action;

import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.gui.event.CPSToSwingChangeAdapter;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

/**
 * a workspace action whose property and state are managed on the CPS thread.
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class CPSWorkspaceAction extends SwingWorkspaceAction {
	protected final BoundPropertyRO<Boolean> cpsEnabled;
	private final ValueChangeListener<Boolean> enabledL;
	public CPSWorkspaceAction(ResourceAccessor parentRes,String name,
			BoundPropertyRO<Boolean> enabled) {
		super(parentRes,name, enabled==null?null:new DefaultBoundPropertyRW<Boolean>(false,enabled.get()));
		//safe to create from swing if always enabled
		if(enabled!=null) {
			CPSQueue.getInstance().checkThread();
			cpsEnabled=enabled;
			enabledL=new CPSToSwingChangeAdapter<Boolean>("update "+name+" enabled") {
				public void swingRun(Boolean oldValue,Boolean newValue) {
					((BoundPropertyRW<Boolean>)enabled()).set(newValue);
				}
			};
			cpsEnabled.addListener(enabledL);
		}else { 
			cpsEnabled=null;
			enabledL=null;
		
		}
	}
	public final void unlink() {
		if(cpsEnabled!=null) {
			cpsEnabled.removeListener(enabledL);
		}
	}
	protected final void _perform() {
		CPSQueue.getInstance().postRunnableExt(new Runnable() {
			public void run() {
				doCPS();
			}
		});
	}
	protected abstract void _cpsPerform();
	public final void doCPS() {
		CPSQueue.getInstance().checkThread();
		if(cpsEnabled!=null&&!cpsEnabled.get().booleanValue())return;
		_cpsPerform();
	}
}
