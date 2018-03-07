/*
 * BoxDrawer.java
 * CREATED:    Aug 23, 2004 9:14:53 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.GL;

/**
 * TODO: label axes
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class BoxDrawer extends Drawer {
	//grayscale color
	private static final float COLOR_R = 0.2f, COLOR_G = 0.2f, COLOR_B = 0.2f;

	public BoxDrawer() {
		super();
	}

	private float sx = 1, sy = 1, sz = 1, ox = -1/2f, oy = -1/2f, oz = -1/2f;

	public void setSize(float x, float y, float z) {
		if (sx != x || sy != y || sz != z) {
			sx = x;
			sy = y;
			sz = z;
			notifier().fireEvent();
		}
	}

	public void setOrigin(float x, float y, float z) {
		if (ox != x || oy != y || oz != z) {
			ox = x;
			oy = y;
			oz = z;
			notifier().fireEvent();
		}

	}

	private boolean listCreated = false;

	private int lname;

	public void kill(GLAccess access) {
		assert listCreated;
		access.getGL().glDeleteLists(lname, 1);
		listCreated = false;
	}

	public void init(GLAccess access) {
		assert !listCreated;
		lname = access.getGL().glGenLists(1);
		GL gl = access.getGL();

		gl.glNewList(lname, GL.GL_COMPILE);
		gl.glBegin(GL.GL_LINES);
		gl.glNormal3f(0,0,1);
		gl.glColor3f(COLOR_R,COLOR_G,COLOR_B);
		
		//front
		gl.glVertex3f(0.0f, 0.0f, 0.0f);
		gl.glVertex3f(1.0f, 0.0f, 0.0f);

		gl.glVertex3f(0.0f, 0.0f, 0.0f);
		gl.glVertex3f(0.0f, 1.0f, 0.0f);

		gl.glVertex3f(1.0f, 1.0f, 0.0f);
		gl.glVertex3f(1.0f, 0.0f, 0.0f);

		gl.glVertex3f(1.0f, 1.0f, 0.0f);
		gl.glVertex3f(0.0f, 1.0f, 0.0f);
		//back
		gl.glVertex3f(0.0f, 0.0f, 1.0f);
		gl.glVertex3f(1.0f, 0.0f, 1.0f);

		gl.glVertex3f(0.0f, 0.0f, 1.0f);
		gl.glVertex3f(0.0f, 1.0f, 1.0f);

		gl.glVertex3f(1.0f, 1.0f, 1.0f);
		gl.glVertex3f(1.0f, 0.0f, 1.0f);

		gl.glVertex3f(1.0f, 1.0f, 1.0f);
		gl.glVertex3f(0.0f, 1.0f, 1.0f);
		
		//connection
		gl.glVertex3f(1.0f, 1.0f, 0.0f);
		gl.glVertex3f(1.0f, 1.0f, 1.0f);

		gl.glVertex3f(1.0f, 0.0f, 0.0f);
		gl.glVertex3f(1.0f, 0.0f, 1.0f);

		gl.glVertex3f(0.0f, 1.0f, 0.0f);
		gl.glVertex3f(0.0f, 1.0f, 1.0f);

		gl.glVertex3f(0.0f, 0.0f, 0.0f);
		gl.glVertex3f(0.0f, 0.0f, 1.0f);

		gl.glEnd();
		gl.glEndList();
		listCreated = true;

	}

	//OPTIMIZE-create second display list for all commands?
	//push geometry faster
	public void draw(GLAccess access) {
		assert listCreated;
		GL gl = access.getGL();

		gl.glTranslatef(ox, oy, oz);
		gl.glScalef(sx, sy, sz);
		
		gl.glCallList(lname);
	}

}