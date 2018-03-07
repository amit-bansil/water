package org.cps.umd.display;
import java.awt.Graphics;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public class BoxDrawer2D extends BoxDrawer{
	public BoxDrawer2D() {
	   super();
	}
	private static final float[][] unscaled=new float[][]{
		{-1,-1},{1,-1},{-1,1},{1,1}};
	protected final int[][] out=new int[4][3];

	public final void drawFrontFace(CameraData c,Graphics g){
		g.setColor(color);
		for(int i=0;i<4;i++){
			c.transform(unscaled[i][0]*x,unscaled[i][1]*y,0,out[i]);
		}
		drawLine(g,out[0],out[1]);
		drawLine(g,out[0],out[2]);
		drawLine(g,out[3],out[1]);
		drawLine(g,out[3],out[2]);
	}

	public final void drawRearFace(CameraData c,Graphics g){}
}