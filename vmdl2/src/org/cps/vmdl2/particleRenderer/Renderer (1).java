/*
 * Renderer.java
 * CREATED:    Aug 22, 2004 8:56:10 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.CPSAnimator;
import net.java.games.jogl.DebugGL;
import net.java.games.jogl.GL;
import net.java.games.jogl.GLCanvas;
import net.java.games.jogl.GLCapabilities;
import net.java.games.jogl.GLDrawable;
import net.java.games.jogl.GLDrawableFactory;
import net.java.games.jogl.GLEventListener;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.simple.SimpleListener;
import org.cps.framework.core.gui.event.GuiEventUtils;

import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * TODO render offscreen?
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class Renderer {
	//members
	private final GLCanvas canvas;

	private final Container canvasHolder;

	public Component getComponent() {
		GuiEventUtils.checkThread();
		return canvasHolder;
	}

	private final Camera camera;

	public Camera getCamera() {
		checkState();
		return camera;
	}

	private final Lights lights;

	public Lights getLights() {
		checkState();
		return lights;
	}

	//drawers
	private final List<Drawer> drawersToInit = new ArrayList(),
			drawersToKill = new ArrayList(), activeDrawers = new ArrayList();

	private final Set<Drawer> drawers = new HashSet();

	public void addDrawer(Drawer d) {
		checkState();
		if (!drawers.add(d))
				throw new IllegalArgumentException("drawer " + d
						+ " already added");
		d.observable().addListener(redrawListener);
		drawersToInit.add(d);
		drawerCache = null;
		animator.postRedraw();
	}

	public void removeDrawer(Drawer d) {
		checkState();
		if (!drawers.remove(d))
				throw new IllegalArgumentException("drawer " + d + " not added");
		d.observable().removeListener(redrawListener);
		//get out fast if we havn't even init'd this one
		if (drawersToInit.remove(d)) return;
		activeDrawers.remove(d);
		drawersToKill.add(d);
		drawerCache = null;
		animator.postRedraw();
	}

	//mouse handling
	private final MouseHandler mouseHandler;

	public MouseHandler getMouseHandler() {
		checkState();
		return mouseHandler;
	}

	private final void pushMouseEvent(MouseEvent e) {
		GuiEventUtils.checkThread();
		if (mouseHandler.pushMouseEvent(e)) {
			animator.postRedraw();
		}
	}

	//state-prevent non cps access and recursive calls from redraw
	private final void checkState() {
		CPSQueue.getInstance().checkThread();
		if (drawing)
				throw new IllegalStateException(
						"don't access render while drawing");
	}

	//constructor
	//	??? better to just pull Shutdown hook
	public Renderer(Application app) {
		CPSQueue.getInstance().checkThread();

		//rending helpers
		camera = new Camera(this);
		lights = new Lights(this);

		mouseHandler = new MouseHandler();

		canvas = GLDrawableFactory.getFactory().createGLCanvas(
				new GLCapabilities());

		//lock canvas to cps
		animator = new CPSAnimator(canvas, app);

		//bind mouse
		canvas.addMouseListener(new MouseListener() {
			public void mouseClicked(MouseEvent e) {
				pushMouseEvent(e);
			}

			public void mousePressed(MouseEvent e) {
				pushMouseEvent(e);
			}

			public void mouseReleased(MouseEvent e) {
				pushMouseEvent(e);
			}

			public void mouseEntered(MouseEvent e) {
				pushMouseEvent(e);
			}

			public void mouseExited(MouseEvent e) {
				pushMouseEvent(e);
			}
		});
		canvas.addMouseMotionListener(new MouseMotionListener() {
			public void mouseDragged(MouseEvent e) {
				pushMouseEvent(e);
			}

			public void mouseMoved(MouseEvent e) {
				pushMouseEvent(e);
			}
		});

		//		 Use debug pipeline
		    canvas.setGL(new DebugGL(canvas.getGL()));

		//bind drawing only once canvas is showing
		setup.run();
		//we need to manually force redraws on awt updates
		canvasHolder = new JPanel() {
			public void paintComponent(Graphics g) {
				redrawInABit();
				super.paintComponent(g);
			}
		};
		canvasHolder.setLayout(new BorderLayout(0, 0));
		canvasHolder.add(canvas, BorderLayout.CENTER);
		canvas.addComponentListener(new ComponentListener() {
			public void componentResized(ComponentEvent e) {
				needsResize = true;
				redrawInABit();
			}

			public void componentShown(ComponentEvent e) {
				redrawInABit();
			}

			public void componentMoved(ComponentEvent e) {
			}

			public void componentHidden(ComponentEvent e) {
			}
		});
	}
	//ERROR hack to fix redraw problems with screen randomly being drawn blank
	//on resize/show
	private final void redrawInABit() {
		CPSQueue.getInstance().postRunnableExt(new Runnable() {
			public void run() {
				CPSQueue.getInstance().postRunnableCPSLater(new Runnable() {
					public void run() {
						animator.postRedraw();
					}
				},1000,10);
			}
		});
	}
	private boolean needsInit = true, needsResize = true;

	private final Runnable setup = new Runnable() {
		public void run() {
			if (!canvas.isShowing()) {
				CPSQueue.getInstance().postRunnableCPSLater(setup, 50, 0);
				return;
			}
			animator.setup();
			canvas.addGLEventListener(new GLEventListener() {
				public void init(GLDrawable drawable) {
					Renderer.this.init(drawable);
					needsInit = false;
				}

				public void display(GLDrawable drawable) {
					if (needsInit) init(drawable);
					if (needsResize) {
						Dimension size = canvas.getSize();
						//TODO location?????
						reshape(drawable, 0, 0, size.width, size.height);
					}
					redraw();
				}

				public void reshape(GLDrawable drawable, int x, int y,
						int width, int height) {
					Renderer.this.reshape(x, y, width, height);
					needsResize = false;
				}

				public void displayChanged(GLDrawable drawable,
						boolean modeChanged, boolean deviceChanged) {
					//not implemented anyway....
				}
			});
		}
	};

	private boolean bound = false;

	//drawing
	//animator responsible for redrawing using cps thread
	private final CPSAnimator animator;

	//provides access to GL&GLU
	private GLAccess access;

	private boolean drawing = false, tranformValid = false,
			ignoreRedraw = false;

	private final SimpleListener redrawListener = new SimpleListener() {
		public void eventOccurred(EventObject event) {
			postRedraw();
		}
	};

	//called by camera/lights when dirty
	void postRedraw() {
		CPSQueue.getInstance().checkThread();
		if (!ignoreRedraw) {
			if (drawing) { throw new IllegalStateException(
					"don't modify drawers while drawing"); }
			animator.postRedraw();
		}
	}

	//called by camera/lights when animating
	//TODO don't just max framerate...
	void forceRedraw() {
		CPSQueue.getInstance().checkThread();
		animator.postRedraw();
	}

	private void reshape(int x, int y, int width, int height) {
		System.out.println("reshaping");
		//make sure we're in cps and not currently drawing
		checkState();
		//logRenderingHardware();
		access.getGL().glMatrixMode(GL.GL_PROJECTION);
		camera.reshape(access, x, y, width, height);
		access.getGL().glMatrixMode(GL.GL_MODELVIEW);
		tranformValid = false;

		lights.init(access);
	}

	private final void init(GLDrawable drawable) {
		System.out.println("init");
		//should only be called once
		assert access == null;
		access = new GLAccess(drawable);
	}

	private Drawer[] drawerCache = null;
	//OPTIMIZE draw to display list so that on camera changes we can just call that
	private void redraw() {
		//System.err.println("redraw");
		//make sure we're in cps and not currently drawing
		checkState();
		//set drawing flag now to prevent changes to handlers/drawers
		drawing = true;
		try {
			//process mouse events&prevent changes from handler
			//causing unnecessary redraw
			//do before clear so handler can use old screen
			ignoreRedraw = true;
			try {
				if (tranformValid) mouseHandler.processMouseEvents(access,
						camera);
				else
					mouseHandler.processMouseEvents(camera);
			} finally {
				ignoreRedraw = false;
			}

			//clear screen&old tranform
			access.getGL().glClear(
					GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
			tranformValid = false;
			access.getGL().glLoadIdentity();

			//update drawers with no model view transform
			if (drawerCache == null) {
				for (Drawer d : drawersToKill) {
					access.getGL().glPushMatrix();
					d.kill(access);
					access.getGL().glPopMatrix();
				}
				for (Drawer d : drawersToInit) {
					access.getGL().glPushMatrix();
					d.init(access);
					access.getGL().glPopMatrix();
				}
				activeDrawers.removeAll(drawersToKill);
				activeDrawers.addAll(drawersToInit);
				drawerCache = activeDrawers.toArray(new Drawer[activeDrawers
						.size()]);
			}

			//we set tranform valid here so that matrix will get popped
			//even if camera fails to transform

			lights.preTransformDraw(access);
			camera.transform(access);
			tranformValid = true;
			lights.postTransformDraw(access);
			
			//now do drawing
			for (Drawer d : drawerCache) {
				access.getGL().glPushMatrix();
				d.draw(access);
				access.getGL().glPopMatrix();
			}

		} finally {
			drawing = false;
		}
	}

	//TODO actually use a log
	private void logRenderingHardware() {
		GL gl = access.getGL();
		System.err.println("GL_VENDOR: " + gl.glGetString(GL.GL_VENDOR));
		System.err.println("GL_RENDERER: " + gl.glGetString(GL.GL_RENDERER));
		System.err.println("GL_VERSION: " + gl.glGetString(GL.GL_VERSION));
		System.err.println();
	}
}

