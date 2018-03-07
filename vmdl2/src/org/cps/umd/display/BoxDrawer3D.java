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

public class BoxDrawer3D extends BoxDrawer{
	public BoxDrawer3D() {
	   super();
	}
	private static final float[][] unscaled=new float[][]{
		{-1,-1, 1},{1,-1, 1},{-1,1, 1},{1,1, 1},
		{-1,-1,-1},{1,-1,-1},{-1,1,-1},{1,1,-1}};
	private final int[][] out=new int[8][3];
	private static final int[][] faces=new int[][]{
		{2,3,1,0},{6,7,5,4},{2,3,7,6},{0,1,5,4},{0,4,6,2},{1,5,7,3}
	};
	private static final int[][] mids=new int[][]{
		{0,0,1},{0,0,-1},{0,1,0},{0,-1,0},{-1,0,0},{1,0,0}
	};
	private final int[] v=new int[3];
	private static final double[] cam=new double[]{0,0,1};
	private final void drawFace(CameraData c,Graphics g,final boolean b){
		g.setColor(color);
		for(int i=0;i<out.length;i++){
			c.transform(unscaled[i][0]*x,unscaled[i][1]*y,unscaled[i][2]*z,out[i]);
		}
		final int[] o=new int[3];
		c.transform(0,0,0,o);

		for(int i=0;i<faces.length;i++){

			c.transform(mids[i][0]*x,mids[i][1]*y,mids[i][2]*z,v);
			v[0]-=o[0];
			v[1]-=o[1];
			v[2]-=o[2];
			final double l=(int)Math.sqrt(v[0]*v[0]+v[1]*v[1]+v[2]*v[2]);
			//1.76 is a geuss must be effected by fov, why??
			if( (Math.acos( (v[0]/l)*cam[0] + (v[1]/l)*cam[1] + (v[2]/l)*cam[2] )>(Math.PI/1.76d))==b ){
				final int[] indexes=faces[i];
				drawLine(g,out[indexes[0]],out[indexes[1]]);
				drawLine(g,out[indexes[1]],out[indexes[2]]);
				drawLine(g,out[indexes[2]],out[indexes[3]]);
				drawLine(g,out[indexes[3]],out[indexes[0]]);
			}
		}
	}
	public final void drawFrontFace(CameraData c,Graphics g){
		drawFace(c,g,true);
	}

	public final void drawRearFace(CameraData c,Graphics g){
		drawFace(c,g,false);
	}
}