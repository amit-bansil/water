/*
 * GLAccess.java
 * CREATED:    Aug 22, 2004 10:25:30 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.GL;
import net.java.games.jogl.GLDrawable;
import net.java.games.jogl.GLU;

/**
 * TODO filter all gl commands through this interface so that,
 * for example. glGets can be avoided.
 * @version 0.0
 * @author Amit Bansil
 */
public class GLAccess {
	private final GL gl;
	private final GLU glu;
	
	public GLAccess(GLDrawable drawable) {
		this.gl=drawable.getGL();
		this.glu=drawable.getGLU();
		gl.glEnableClientState(GL.GL_VERTEX_ARRAY);
	}
	public GL getGL() {
		return gl;
	}
	public GLU getGLU() {
		return glu;
	}
	private boolean colorsEnabled=false;
	public final void setColorArraysEnabled(boolean v) {
		if(colorsEnabled==v)return;
		
		if(v)gl.glEnableClientState(GL.GL_COLOR_ARRAY);
		else gl.glDisableClientState(GL.GL_COLOR_ARRAY);
		
		colorsEnabled=v;
	}
}
