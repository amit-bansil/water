/*
 * AtomDrawer.java
 * CREATED:    Aug 24, 2004 1:55:38 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import net.java.games.jogl.GL;
import net.java.games.jogl.GLU;
import net.java.games.jogl.GLUquadric;
import net.java.games.jogl.util.BufferUtils;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.util.collections.arrays.ArrayFiller;
import org.cps.vmdl2.mdSimulation.UMDSimulation;

import java.nio.FloatBuffer;

/**
 * OPTIMIZE use different sphere lists based on radius+distancefrom viewer
 * [Level of Detail optimization...]
 * 
 * TODO allow unlink
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class AtomDrawer extends Drawer {
	private static final float color_scale=1f;
	private final int sphereResolution;
	private final UMDSimulation simulation;
	public AtomDrawer(UMDSimulation lsimulation, int sphereResolution) {
		super();
		this.simulation=lsimulation;
		this.sphereResolution = sphereResolution;
		simulation.observable().addListener(new GenericListener() {
			public void eventOccurred(Object arg0) {
				//OPTIMIZE be more selective about change flags
				if(simulation.getTypeData().isChanged()) {
					updateColors();
					notifier().fireEvent();
					return;
				}
				if(simulation.getDisplayData().isChanged()) {
					notifier().fireEvent();
				}
				
			}
		});
	}

	private float radiusScale = 1f;

	public void setRadiusScale(float f) {
		if (radiusScale != f) {
			radiusScale = f;
			notifier().fireEvent();
		}
	}

	private float radiusCutoff = 1f;

	public void setRadiusCutoff(float f) {
		if (radiusCutoff != f) {
			radiusCutoff = f;
			notifier().fireEvent();
		}
	}

	private boolean listCreated = false;

	private int sphereList;
	private FloatBuffer vertexBuffer,colorBuffer;
	private int bufferCapacity=0;
	private final void allocateBuffers(int capacity) {
		final int l=capacity*3;
		color=new float[l];
		vertexBuffer=BufferUtils.newFloatBuffer(l);
		colorBuffer=BufferUtils.newFloatBuffer(l);
		updateColors();
	}
	private final void prepBuffers(int count) {
		vertexBuffer.position(0);
		vertexBuffer.limit(count*3);
		//??? do we need to position color buffer either way
		if(multiplePointColors&&updateColorBuffer) {
			colorBuffer.limit(count*3);
			colorBuffer.position(0);
		}
	}
	private final void resetBuffers() {
		vertexBuffer.position(0);
		if(updateColorBuffer) {
			colorBuffer.position(0);
		}
	}
	
	private boolean updateColorBuffer=true;
	private float pointR=-1, pointG=-1, pointB=-1;
	private boolean multiplePointColors=false;
	private float[] color=null;
	private final void updateColors() {
		if(!updateColorBuffer) {
			updateColorBuffer=true;
			multiplePointColors=false;
			pointR=pointG=pointB=-1;
		}
	}
	
	public void kill(GLAccess access) {
		assert listCreated;
		access.getGL().glDeleteLists(sphereList, 1);
		listCreated = false;
	}

	public void init(GLAccess access) {
		assert !listCreated;
		GL gl = access.getGL();
		GLU glu = access.getGLU();

		sphereList = gl.glGenLists(1);
		GLUquadric quadric = glu.gluNewQuadric();
		glu.gluQuadricOrientation(quadric, GLU.GLU_OUTSIDE);
	
		gl.glNewList(sphereList, GL.GL_COMPILE);
		glu.gluSphere(quadric, 1.0f, sphereResolution, sphereResolution);
		gl.glEndList();
		listCreated = true;

		glu.gluDeleteQuadric(quadric);
	}
	//OPTIMIZE render to display list that is only updated on position change?
	//OPTIMIZE sort by type only updating as neccessary to avoid changing color
	//create a 2d Drawer
	//create a point only drawer
	//allow pointsize setting
	//use quads/textured quads???
	//push,say, 20 tranforms at a time and draw them all at once?
	public void draw(GLAccess access) {
		assert listCreated;
		GL gl = access.getGL();
		
		final float[] positions=simulation.getDisplayData().getPositions();
		final int l=simulation.getDisplayData().getAtomCount();
		final int[] types=simulation.getTypeData().getAtomTypes();
		final float[] radii=simulation.getTypeData().getAtomTypeRadii();
		final float[] colors=simulation.getTypeData().getAtomTypeColors();

		if(l>bufferCapacity) allocateBuffers(l);
		else resetBuffers();
		
		int lastType=Integer.MIN_VALUE+1,lastPointV=-1,lastPointI=-1;
		int pointCount=0;
		
		float radius=-1,r=-1,g=-1,b=-1f;
		boolean point=false;
		int v=0,i=0;
		//OPTIMIZE remember type lenths so that we don't even have to iterate
		//for a whole bunch of points or (even better) sort so that it is all optimized
		for(;i<l;i++,v+=3) {
			int type=types[i];
			if(type!=lastType) {
				lastType=type;
				//ERROR hack since we don't really no radii
				if(type==0) {
					radius=0;
				}else {
					radius=radii[type];
				}
				if(lastPointV!=-1) {
					storePoints(v,lastPointV,positions);
					pointCount+=i-lastPointI;
				}
				if(updateColorBuffer||radius>radiusCutoff) {
					r=colors[type*3]*color_scale;
					g=colors[type*3+1]*color_scale;
					b=colors[type*3+2]*color_scale;
				}
				if(radius<radiusCutoff) {
					point=true;
					lastPointV=v;
					lastPointI=i;
					if(updateColorBuffer) {
						
						if(pointR==-1) {
							pointR=r;pointG=g;pointB=b;
						}else if(!multiplePointColors){
							if(pointR!=r||pointG!=g||pointB!=b) multiplePointColors=true;
						}	
						color[0]=r;
						color[1]=g;
						color[2]=b;
					}
				}else {
					lastPointV=-1;
					point=false;
					radius*=radiusScale;
					gl.glColor3f(r,g,b);
				}
			}
			if(!point) {
				gl.glPushMatrix();
				gl.glTranslatef(positions[v+0],positions[v+1],positions[v+2]);
				gl.glScalef(radius,radius,radius);
				gl.glCallList(sphereList);
				gl.glPopMatrix();
			}
		}
		if(lastPointV!=-1) {
			storePoints(v,lastPointV,positions);
			pointCount+=i-lastPointI;
		}
		prepBuffers(pointCount);
		if(pointCount>0) {
			gl.glNormal3f(0,0,1);
			if(multiplePointColors) {
				assert pointR!=-1;
				gl.glColor3f(pointR,pointG,pointB);
				access.setColorArraysEnabled(false);
			}else {
				access.setColorArraysEnabled(true);
				gl.glColorPointer(3,GL.GL_FLOAT,0,colorBuffer);
			}
			gl.glVertexPointer(3,GL.GL_FLOAT,0,vertexBuffer);
			gl.glDrawArrays(GL.GL_POINTS,0,pointCount);
		}
		updateColorBuffer=false;
	}
	private final void storePoints(int v,int lastPointV,float[] positions) {
		int vl=v-lastPointV;
		vertexBuffer.put(positions,lastPointV,vl);
		if(vl>3)ArrayFiller.fill(color,0,vl,3);
		if(updateColorBuffer) {
			colorBuffer.put(color,0,vl);
		}
		
	}
}