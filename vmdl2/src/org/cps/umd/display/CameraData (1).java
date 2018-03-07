package org.cps.umd.display;

import java.awt.Dimension;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public abstract class CameraData {
	public void setSpin(float sx,float sy) {
		spin[0]=sx;
		spin[1]=sy;
		float[] s=spin;
		boolean spun=false;
		for(int i=0;i<s.length;i++) if(s[0]!=0){ spun=true; break;}
		spinning=spun;
		prepared=false;
	}
	public void setRotation(float x,float y) {
		rotation[0]=x;
		rotation[1]=y;
		prepared=false;
	}
	protected abstract int getDimensions();

	private float sWidth,sHeight;
	protected float getViewScale(){
		if(sWidth/sHeight>actRatio){
			return sHeight/eHeight;
		}else{
			return sWidth/eWidth;
		}

	}
	protected float getWidth(){return sWidth;}
	protected float getHeight(){return sHeight;}
	protected float getViewTranslateX(){
		return sWidth/2f+pan[0];
	}
	protected float getViewTranslateY(){
		return sHeight/2f+pan[1];
	}
	//aspectratio
	private float eWidth,eHeight;
	private float actRatio;

	boolean prepared=false;
	private boolean spinning=false;
	protected float scale;
	protected final float internalScale;
	protected final float[] translation;
	protected final float[] aspectRatio;
	protected final float[] pan;
	protected final float[] rotation;
	protected final float[] spin;
	protected final int zMax,zMin;

	public static final float MAX_SCALE=1600.0f,MIN_SCALE=1.0f;
	protected CameraData(float defaultInternalScale) {
		prepared=false;
		scale=100.0f;
		internalScale=defaultInternalScale;
		translation=new float[] {0,0,0};
		eWidth=300; eHeight=300;
		actRatio=eWidth/eHeight;
		aspectRatio=new float[] {eWidth,eHeight};

		zMax=Integer.MAX_VALUE;
		zMin=Integer.MIN_VALUE;

		pan=new float[] {0,0};
		rotation=new float[] {0.0f,0.0f};
		spin=new float[] {0,0};
	}

	public final void setSize(Dimension size){
		//synchronized(this){
			if(size.width!=sWidth||size.height!=sHeight){
				sWidth=size.width;
				sHeight=size.height;
			}
			prepared=false;
		//}
	}
	public final void checkSpin(){
		if(spinning){
			boolean spun=false;
			float[] s=spin;
			for(int i=0;i<s.length;i++) if(s[0]!=0){ spun=true; break;}
			if(spun){
				prepared=false;
				float[] r=rotation;
				for(int i=0;i<r.length;i++) r[i]+=s[i];
			}
		}
	}
	private int zMinv=Integer.MAX_VALUE,zMaxv=Integer.MIN_VALUE;
	public int getZMin(){return zMinv;}
	public int getZMax(){return zMaxv;}

	public final void prepare(){
		if(prepared)return;
		prepared=true;
		zMaxv=zMax;
		zMinv=zMin;
		eWidth=aspectRatio[0];
		eHeight=aspectRatio[0];
		actRatio=eWidth/eHeight;
		doPrepare();
	}
	protected abstract void doPrepare();
	public abstract void transform(final float x,final float y,final float z,final int[] result);
	public abstract void transform(final float[] in,final int length,final int dstOff,
								final int[] xo,final int[] yo,final int[] zo,
								final float[] radii,final int[] scaledRadii);
	public void setPan(float[] fs) {
		pan[0]=fs[0];
		pan[1]=fs[1];
		prepared=false;
	}
	public void setScale(float f) {
		if(f>MAX_SCALE) f=MAX_SCALE;
		if(f<MIN_SCALE) f=MIN_SCALE;
		scale=f;
	}
}