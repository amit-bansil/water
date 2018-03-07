package org.cps.umd.display;
import java.awt.Color;
import java.awt.Graphics;
/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public abstract class BoxDrawer{

    public BoxDrawer() {
		color=Color.gray;
    }
	protected Color color;
	public final void setColor(Color color){
		this.color=color;
	}
	protected float x,y,z;
	public final void setSize(float x,float y,float z){
		this.x=x/2; this.y=y/2; this.z=z/2;
	}

	protected static final void drawLine(Graphics g,int[] v1,int[] v2){
		g.drawLine(v1[0],v1[1],v2[0],v2[1]);
	}

	public abstract void drawFrontFace(CameraData c,Graphics g);
	public abstract void drawRearFace(CameraData c,Graphics g);
}
