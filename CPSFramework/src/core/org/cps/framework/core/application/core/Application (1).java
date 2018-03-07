/*
 * AllTests.java
 * CREATED:    January 19, 2003
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.application.core;
import org.cps.framework.core.application.gui.ApplicationGUI;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.queue.QueueManager;
import org.cps.framework.core.io.DocumentManager;

import java.util.prefs.Preferences;

/**
 * centeral class that initializes and kills CPS applications.
 * @author Amit Bansil
 */
public final class Application {
    public static final Object aquireLock(){
        return QueueManager.checkoutLock();
    }
	//lock to dispose of on shutdown
    //must be called on CPSThread
	public Application(ApplicationDescription description,Object lock) {
		CPSQueue.getInstance().checkThread();
		this.desc = description;
		prefs =
			Preferences.userRoot().node(Application.class.getName()).node(
				description.getName());
		
		shutdownManager=new ShutdownManager(lock);
		
		documentManager =
			new DocumentManager(
				description.getVersion(),
				description.getName());
		//this must be last since it depends on all of the above
		gui=new ApplicationGUI(this);
	}
	//managers
	private final ApplicationGUI gui;
	public final ApplicationGUI getGUI() {
		return gui;
	}

	private final DocumentManager documentManager;
	public final DocumentManager getDocumentManager() {
		return documentManager;
	}
	private final ApplicationDescription desc;
	public final ApplicationDescription getDescription() {
		return desc;
	}
	//TODO real prefrences
	private final Preferences prefs;
	public final Preferences getPrefrences() {
		return prefs;
	}
	//state
	private boolean started = false;
	public final void startup() {
		CPSQueue.getInstance().checkThread();
		if (started)
			throw new IllegalStateException();
		documentManager.finishedRegisteringDocumentData();
		gui.startup();
		started = true;
	}
	private final ShutdownManager shutdownManager;
	public final ShutdownManager getShutdownManager(){
		return shutdownManager;
	}
	public final boolean isStarted() {
		return started;
	}
}
