package org.cps.umd.display;
import org.freehep.graphics3d.*;
/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */
/*inline the transform3d,use a real matrix class and ditch freehep*/
public class Camera3D extends CameraData {

	private Transform3D trans=new Transform3D();
	private float tA,tX,tY,tZ;
	private int tXI,tYI;
	public Camera3D(float internalScale) {
		super(internalScale);
	}
	/*todo make these editable, move rotation etc. to this class*/
	private float fov,zdist;
	protected final void doPrepare() {
		synchronized(trans){
			tA=(scale/100f)*getViewScale()*internalScale;
			trans=new Transform3D();
			float rx=rotation[1];
			float ry=-rotation[0];
			tX=translation[0];
			tY=translation[1];
			tZ=translation[2];
			trans.translate(tX,tY,tZ);
			trans.rotate(1d,0d,0d,rx/500f);
			trans.rotate(0d,1d,0d,ry/500f);
			trans.scale(tA,tA,tA);
			tXI=(int)getViewTranslateX();
			tYI=(int)getViewTranslateY();
			fov=.001f;
			zdist=1000;
		}
	}
	/*todo inline trans class*/
	public final void transform(float x,float y,float z,final int[] tp){
		synchronized(trans){
			trans.get(x,y,z,tp);
			x=((tp[0]/((tp[2]+zdist)*fov)))+tXI;
			y=((tp[1]/((tp[2]+zdist)*fov)))+tYI;
			tp[0]=(int)x;
			tp[1]=(int)y;
		}
	}

	public final void transform(final float[] in,final int length,final int dstOff,
								final int[] xo,final int[] yo,final int[] zo,
								final float[] radii,final int[] scaledRadii){

		synchronized(trans){
			int n=dstOff,m=0,o=0;
			final int[] tp=new int[3];
			for(;o<length;n++,m+=3,o++){
				trans.get(in[m],in[m+1],in[m+2],tp);
				xo[n]=(int)Math.round(((tp[0]/((tp[2]+zdist)*fov)))+tXI);//can we just add .5f?
				yo[n]=(int)Math.round(((tp[1]/((tp[2]+zdist)*fov)))+tYI);
				zo[n]=tp[2];
				scaledRadii[n]=(int)Math.round(((tA*radii[o])/((tp[2]+zdist)*fov)));
			}
		}
	}
	protected final int getDimensions() {return 3;}
}