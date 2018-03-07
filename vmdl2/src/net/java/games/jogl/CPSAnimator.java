/*
 * CPSAnimator.java
 * CREATED:    Aug 22, 2004 9:05:02 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package net.java.games.jogl;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.event.queue.CPSQueue;

/**
 * rip off on animator designed for CPS rendering basically prevents none cps
 * calls to display also caps framerate
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class CPSAnimator {
	private static final int MAX_FPS = 15;

	private static final long MIN_DELAY = (1000l * 1000l * 1000l) / MAX_FPS;
	public static final int PRIORTY=1;
	
	private GLCanvas drawable;
	private final Application app;
	public CPSAnimator(final GLCanvas ldrawable, Application app) {
		CPSQueue.getInstance().checkThread();
		this.drawable = ldrawable;
		this.app=app;
		// Workaround for NVidia driver bug 80174
		drawable.willSetRenderingThread();
		
	}
	//for some reason setup only works if called after visible
	public void setup() {
		//ERROR!!! this drawable is keeping the event queue or something alive
		//which is preventing shutdown
		drawable.setRenderingThread(Thread.currentThread());
		drawable.setNoAutoRedrawMode(true);
		app.getShutdownManager().addShutdownHook(new Runnable() {
			public void run() {
				drawable.setRenderingThread(null);
				drawable.setNoAutoRedrawMode(false);
				drawable.getParent().remove(drawable);
				drawable = null;
			}
		});
	}
	private long lastTime = -1;

	private boolean redrawPending = false;

	private final Runnable reposter = new Runnable() {
		public void run() {
			redrawPending = false;
			postRedraw();
		}
	};
	private final Runnable redrawer = new Runnable() {
		public void run() {
			redrawPending=false;
			System.err.println("display");
			drawable.display();
		}
	};
	public void postRedraw() {
		if(redrawPending)return;
		redrawPending=true;
		//make sure we're in cps-OPTIMIZE instead break of a RedrawEXT method
		if (!CPSQueue.getInstance().isInCPSThread()) {
			CPSQueue.getInstance().postRunnableExt(reposter);
			return;
		}
		///??? better to use frame time???
		long now = CPSQueue.getInstance().getTrueTime();
		
		//prevent too quick a redraw
		if (lastTime != -1 && lastTime + MIN_DELAY > now) {
			CPSQueue.getInstance().postRunnableCPSLater(reposter,
					MIN_DELAY - (now - lastTime), PRIORTY);
			return;
		}
		lastTime = now;
		CPSQueue.getInstance().postRunnableCPSNow(redrawer);
	}
}