/*
 * Lights.java
 * CREATED:    Aug 22, 2004 11:15:26 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.GL;

/**
 * TODO allow fade in/fade out
 * @version 0.0
 * @author Amit Bansil
 */
public class Lights {

	public Lights(Renderer renderer) {
		//TODO hold onto renderer to update on fades
	}

	public void preTransformDraw(GLAccess access) {
	}

	public void postTransformDraw(GLAccess access) {
	}

	public void init(GLAccess access) {
		GL gl=access.getGL();
		//OPTIMIZE use a buffer here or in access

		float pos[] = {1.0f, 1.0f,1.0f, 0.0f};
		gl.glLightfv(GL.GL_LIGHT0, GL.GL_POSITION, pos);
		
		//float[] light_position = new float[]{1.0f, 1.0f, 1.0f, 0.0f};
		float[] model_ambient = new float[]{0.5f, 0.5f,0.5f, 1.0f};
		gl.glLightModelfv(GL.GL_LIGHT_MODEL_AMBIENT, model_ambient);
		
		float[] mat_specular = new float[]{1.0f, 1.0f, 1.0f, 1.0f};
		float[] mat_shininess = new float[]{50.0f};
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_SPECULAR, mat_specular);
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_SHININESS, mat_shininess);

		float[] mat_ambient = new float[]{0.5f, 0.5f, 0.5f, 1.0f};
		float[] mat_diffuse = new float[]{1.0f, 1.0f, 1.0f, 1.0f};
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_AMBIENT, mat_ambient);
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_DIFFUSE, mat_diffuse);
		gl.glColorMaterial(GL.GL_FRONT, GL.GL_AMBIENT);
		gl.glColorMaterial(GL.GL_FRONT, GL.GL_DIFFUSE);
		
		gl.glEnable(GL.GL_COLOR_MATERIAL);
		gl.glEnable(GL.GL_LIGHTING);
		gl.glEnable(GL.GL_LIGHT0);
		
		gl.glEnable(GL.GL_CULL_FACE);
		gl.glEnable(GL.GL_DEPTH_TEST);
		gl.glEnable(GL.GL_NORMALIZE);
		System.err.println("done lighting");
	}
}
