/*
 * Camera.java
 * CREATED:    Aug 22, 2004 8:55:03 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.GL;

import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.util.lang.misc.FastMath;

/**
 * TODO make all these parameters intrapolated so that we can smoothly change
 * rotation and zoom.
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class Camera {
	public static final float NEAR_Z = 5, FAR_Z = 60;

	//properties
	private float translationx=0,translationy=0,translationz=-10;
	
	public final void setTranslation(float x,float y,float z) {
		if(x!=translationx||y!=translationy||z!=translationz) {
			this.translationx = x;
			this.translationy = y;
			this.translationz = z;
			update();
		}
	}
	//rotation in degrees
	private float rotationx = 0, rotationy = 0, rotationz = 0;

	public void setRotation(float x, float y, float z) {
		if(x!=rotationx||y!=rotationy||z!=rotationz) {
			this.rotationx = x;
			this.rotationy = y;
			this.rotationz = z;
			update();
		}
	}

	public float getRotationX() {
		return rotationx;
	}

	public float getRotationY() {
		return rotationy;
	}

	public float getRotationZ() {
		return rotationz;
	}

	//spin in degrees per second
	private float spinx =0f, spiny =0f, spinz =0f;

	public float getSpinX() {
		return spinx;
	}

	public void setSpin(float x, float y, float z) {
		if(x!=spinx||y!=spiny||z!=spinz) {
			spinx =x;
			spiny =y;
			spinz =z;
			if (spinx == 0 && spinz == 0 && spinz == 0) {
				if (spinStartTime != -1)
						spinStartTime = CPSQueue.getInstance().getTrueTime();
			} else {
				spinStartTime = -1;
			}
			update();
		}
	}

	public float getSpinY() {
		return spiny;
	}

	public float getSpinZ() {
		return spinz;
	}

	//zoom
	private double zoom=1;

	public void setZoom(double zoom) {
		if(zoom!=this.zoom) {
			this.zoom = zoom;
			update();
		}
	}

	private final Renderer renderer;

	public Camera(Renderer renderer) {
		this.renderer = renderer;
	}

	public void reshape(GLAccess access, int x, int y, int width, int height) {
		float h = (float) height / (float) width;
		GL gl = access.getGL();
		gl.glLoadIdentity();
		gl.glFrustum(-1.0f, 1.0f, -h, h, NEAR_Z, FAR_Z);
	}

	private final void update() {
		renderer.postRedraw();
	}

	private long spinStartTime =-1;

	public void transform(GLAccess access) {

		float rx = rotationx, ry = rotationy, rz = rotationz;

		if (spinStartTime != -1) {
			double dt = (CPSQueue.getInstance().getTrueTime() - spinStartTime)
					/ (1000d * 1000d * 1000d);
			rx += spinx * dt;
			ry += spiny * dt;
			rz += spinz * dt;
			renderer.forceRedraw();
		}

		GL gl = access.getGL();
		gl.glTranslatef(translationx, translationy,translationz);
		gl.glRotatef(rx, 0.0f, 1.0f, 0.0f);
		gl.glRotatef(ry, 1.0f, 0.0f, 0.0f);
		gl.glRotatef(rz, 0.0f, 0.0f, 1.0f);
		gl.glScaled(zoom,zoom,zoom);
	}
}