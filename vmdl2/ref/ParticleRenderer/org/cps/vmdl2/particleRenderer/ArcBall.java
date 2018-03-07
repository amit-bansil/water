/*
 * ArcBall.java
 * CREATED:    Aug 17, 2004 7:35:28 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import javax.vecmath.Matrix3f;
import javax.vecmath.Matrix4f;
import javax.vecmath.Quat4f;
import javax.vecmath.Vector3f;

/**
 * keep size uptodate with setSize,
 * on press anchor, update transform matrix with drag,then get transform
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ArcBall {
	public ArcBall() {
		reset();
	}
	private void mapToSphere(int mx,int my,Vector3f result){
		float x=-((mx/halfWidth)-1f);
		float y=(my/halfHeight)-1f;
		float length=x*x+y*y;
//		If the point is mapped outside of the sphere... (length > radius squared)
		if(length>1.0f) {
			float norm=1/FastMath.sqrt(length);
			result.set(x*norm,y*norm,0);
		}else {
			result.set(x,y,FastMath.sqrt(1.0f - length));
		}
	}
	private final Vector3f startVec=new Vector3f(),endVec=new Vector3f();
	private float halfWidth,halfHeight;
	public void setSize(int width,int height) {
		System.out.println(width+","+height);
		this.halfWidth=(width-1f)/2f;
		this.halfHeight=(height-1f)/2f;
	}
	public void reset() {
		currentRotation.setIdentity();
		lastRotation.setIdentity();
		updateTransformation();
	}
	public void anchor(int x,int y) {
		mapToSphere(x,y,startVec);
		lastRotation.set(currentRotation);
	}
	private final Vector3f perpendicular=new Vector3f();
	private final Quat4f rotation=new Quat4f();
	private final Matrix3f currentRotation=new Matrix3f(),lastRotation=new Matrix3f();
	private final Matrix4f transformation=new Matrix4f();
	private final float[] transformationArray=new float[16];
	public synchronized void drag(int x,int y) {
		mapToSphere(x,y,endVec);
		perpendicular.cross(startVec,endVec);
		if(perpendicular.length()>1.0e-5f) {
//			We're ok, so return the perpendicular vector as the transform after all
			rotation.set(perpendicular.x,perpendicular.y,perpendicular.z,
					startVec.dot(endVec));
		}else {
//			The begin and end vectors coincide, so return an identity transform
			rotation.set(0,0,0,0);
		}
		currentRotation.set(rotation);
		currentRotation.mul(lastRotation);
		
		updateTransformation();
	}
	private synchronized final void updateTransformation() {
		transformation.set(currentRotation);
		
		int n=0;
		for(int r=0;r<4;r++) {
			for(int c=0;c<4;c++) {
				transformationArray[n]=transformation.getElement(r,c);
				n++;
			}
		}
	}
	public synchronized float[] getRotationTransformation() {
		return transformationArray;
	}
}
