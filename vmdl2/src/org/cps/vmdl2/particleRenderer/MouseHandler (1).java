/*
 * MouseHandlerManager.java
 * CREATED:    Aug 23, 2004 3:35:15 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.List;

/**
 * TODO implement this class for real,should allow picking, such that if
 * handlers are sorted by some priotiy variable and are called sequentially to
 * handler the newEvents in processMouseEvents. if they get a hit then lower
 * priority handlers are ignored.
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class MouseHandler {
	//private final List<Handler> handlers=new ArrayList();
	private final List<MouseEvent> mouseEvents = new ArrayList();

	public MouseHandler() {
		super();
	}

	private boolean mousePressed = false;

	//push events to queue here and return true if they warrant a redaw
	private MouseEvent lastEvent;

	private int drx, dry, sx, sy;

	public boolean pushMouseEvent(MouseEvent e) {
		//synchronized(mouseEvents) {
		synchronized (this) {
			if (!mousePressed) {
				if (e.getID() == MouseEvent.MOUSE_PRESSED) {
					mousePressed = true;
					lastEvent = e;
					return false;
				}
			} else {
				if (e.getID() == MouseEvent.MOUSE_DRAGGED) {
					drx += e.getX() - lastEvent.getX();
					dry += e.getY() - lastEvent.getY();
					lastEvent = e;
					return true;
				} else if (e.getID() == MouseEvent.MOUSE_RELEASED) {
					sx = e.getX() - lastEvent.getX();
					sy = e.getY() - lastEvent.getY();
					mousePressed = false;
					lastEvent = null;
					return true;
				}
			}
			return false;
		}
		//}
	}

	//handle events (called during redraw) as above
	public void processMouseEvents(GLAccess access, Camera camera) {
		//synchronized(mouseEvents) {
		synchronized (this) {
			camera.setRotation(camera.getRotationX() + drx, camera
					.getRotationY()
					+ dry, camera.getRotationZ());
			camera.setSpin(sx, sy, 0);
			drx = 0;
			sx = 0;
			dry = 0;
			sy = 0;
		}
		//}
	}

	//this means clear really
	public void processMouseEvents(Camera camera) {
		//synchronized(mouseEvents) {

		//}
	}

	public static interface Handler {
		public int getPriority();

		public boolean beginDragging(Camera camera, GLAccess access,
				MouseEvent e);

		public void drag(Camera camera, GLAccess access, MouseEvent e);

		public void finishDragging(Camera camera, GLAccess access, MouseEvent e);

		public void clear();
	}
}