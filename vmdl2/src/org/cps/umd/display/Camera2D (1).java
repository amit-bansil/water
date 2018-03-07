package org.cps.umd.display;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public final class Camera2D extends CameraData {
	private float tS,tA,tX,tY,tI;
	public Camera2D(float internalScale) {
		super(internalScale);
	}

	protected final void doPrepare() {
		tA=(scale/100f)*getViewScale();
		tI=internalScale;
		tS=tA*tI;
		tX=(translation[0]*tS)+getViewTranslateX();
		tY=(translation[1]*tS)+getViewTranslateY();
	}
	public final void transform(final float x,final float y,final float z,final int[] result){
		result[0]=(int)((x*tS)+tX);
		result[1]=(int)((y*tS)+tY);
	}
	public final void transform(final float[] in,final int length,final int dstOff,
								final int[] xo,final int[] yo,final int[] zo,
								final float[] radii,final int[] scaledRadii){
		int n=dstOff,m=0,o=0;
		for(;o<length;n++,m+=3,o++){
			scaledRadii[n]=(int)(radii[o]*tA);
			xo[n]=(int)((in[m]*tS)+tX);
			yo[n]=(int)((in[m+1]*tS)+tY);
		}
	}
	protected final int getDimensions() {return 2;}
}