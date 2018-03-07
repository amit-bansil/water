/*
 * BoxDrawer.java
 * CREATED:    Aug 23, 2004 9:14:53 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.water.moleculedisplay;

import cps.water.moleculedisplay.GLAccess.DisplayList;
import cps.water.moleculedisplay.GLAccess.LineDrawer;

/**
 * TODO: label axes
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class BoxDrawer{
	private DisplayList displayList;

	public void kill(GLAccess gla) {
		displayList.kill();
		displayList=null;
	}

	public void init(GLAccess gla) {
		displayList=gla.beginList();
		
		LineDrawer l=gla.beginLines(Renderer.boxWeight);
		//gl.glNormal3f(0,0,1);
		gla.setColor(Renderer.boxColor);
		
		//front
		l.drawLine(0.0f, 0.0f, 0.0f,1.0f, 0.0f, 0.0f);
		l.drawLine(0.0f, 0.0f, 0.0f,0.0f, 1.0f, 0.0f);
		l.drawLine(1.0f, 1.0f, 0.0f,1.0f, 0.0f, 0.0f);
		l.drawLine(1.0f, 1.0f, 0.0f,0.0f, 1.0f, 0.0f);
		//back
		l.drawLine(0.0f, 0.0f, 1.0f,1.0f, 0.0f, 1.0f);
		l.drawLine(0.0f, 0.0f, 1.0f,0.0f, 1.0f, 1.0f);
		l.drawLine(1.0f, 1.0f, 1.0f,1.0f, 0.0f, 1.0f);
		l.drawLine(1.0f, 1.0f, 1.0f,0.0f, 1.0f, 1.0f);
		
		//connection
		l.drawLine(1.0f, 1.0f, 0.0f,1.0f, 1.0f, 1.0f);
		l.drawLine(1.0f, 0.0f, 0.0f,1.0f, 0.0f, 1.0f);
		l.drawLine(0.0f, 1.0f, 0.0f,0.0f, 1.0f, 1.0f);
		l.drawLine(0.0f, 0.0f, 0.0f,0.0f, 0.0f, 1.0f);

		l.end();
		
		displayList.end();
	}

	//OPTIMIZE-create second display list for all commands?
	//push geometry faster
	
	//gl.glTranslatef(ox, oy, oz);
	//gl.glScalef(sx, sy, sz);
	public void draw(GLAccess gla,float[] size) {
		gla.pushMatrix();
		gla.translate(size[0]/-2f,size[1]/-2f, size[2]/-2f);
		gla.scale(size[0], size[1], size[2]);
		gla.setLightingEnabled(false);
		displayList.call();
		gla.popMatrix();
	}

}