/*
 * CREATED ON:    Apr 16, 2006 3:46:34 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import cps.water.moleculedisplay.GLAccess.Quadrics;

import javax.media.opengl.GL;
import javax.media.opengl.GLAutoDrawable;
import javax.media.opengl.GLEventListener;
import javax.media.opengl.glu.GLU;
import javax.media.opengl.glu.GLUquadric;
import javax.vecmath.Color3f;

/**
 * @version $Id$
 * @author Amit Bansil
 */
class Renderer implements GLEventListener{
	// ------------------------------------------------------------------------
	//drawing constants
	static final float hSize = 0.1f;
	static final float oSize = 0.16f;
	static final float originSize = 0.1f;
    static final float covBondThickness=.02f;
	 static final float shrinkCoef=1/3f;//amount to shrink atoms
	 static final Color3f oColor=new Color3f(0.9f,0.9f,0.9f);
     static final Color3f hColor=new Color3f(0.9f,0.0f,0.0f);
     static final Color3f hBondColor=new Color3f(0.0f,0.8f,0.8f);
     static final Color3f boxColor=new Color3f(0.2f,0.2f,0.2f);
	 static final int oSlices=12,oStacks=12,hSlices=8,hStacks=8;
	 static final float nearZClip=5,farZClip=60;
	 static final float hBondWeight=1f,boxWeight=1f;
	 static final int covBondSlices=10;
	// ------------------------------------------------------------------------
    // subsystems
	private final BoxDrawer boxDrawer=new BoxDrawer();
	private final CovBondDrawer covBondDrawer=new CovBondDrawer();
	private final AtomsDrawer atomsDrawer=new AtomsDrawer();
	
	// ------------------------------------------------------------------------
	//camera properties
	private final float[] translation=new float[3];
	private float rotateX,rotateY,zoom;
	private boolean shrinkAtoms;
	private float brightness=1f;
	
	float[] atomPositions=new float[0];
	int moleculeCount;
	int hBondCount;
	//a packed array
	//{bond 1: source position x,y,z, destination position: x,y,z, bond 2...}
	float[] hBondPositions=new float[0];
	final float[] boxSize=new float[3];
	

	// return if the bond defined by
	// {bondPositions[nextOffset-6],...,bondPositions[nextOffset-1]
	// is longer in any dimension than 1/2 box size in that dimension
	/*private boolean isTooLong(float[] bondPositions, int nextOffset) {
		int firstOffset = nextOffset - 6;
		for (int i = 0; i < 3; i++)
			if (Math.abs(bondPositions[firstOffset + i + 3]
					- bondPositions[firstOffset + i]) * 2 > boxSize[i]) return true;

		return false;
	}*/
	//translates positions from index nextOffset-count thru nextOffset-1
	//wrapping around as needed
	//this assumes translation is within box size
	final void translate(float[] positions,int count) {
		for(int i=0;i<count*3;i+=3) {
			for(int j=0;j<3;j++) {
				float n=positions[i+j]+translation[j];
				if(n>boxSize[j]) {
					n-=boxSize[j];
					positions[i+j]=n;
				}
			}
		}
	}
	
	public void read(RenderScene scene,DisplayModel displayModel) {
		displayModel.lock.lock();
		
		shrinkAtoms=displayModel.shrinkMolecules().get();
		rotateX=displayModel.getRotateX();
		rotateY=displayModel.getRotateY();
		zoom=displayModel.cameraZoom().get();
		
		displayModel.lock.unlock();
		
		//copy data
		moleculeCount=scene.moleculeCount;
		hBondCount=scene.hBondCount;
		if(atomPositions.length<scene.atomPositions.length)atomPositions=new float[scene.atomPositions.length];
		if(hBondPositions.length<scene.hBondPositions.length)hBondPositions=new float[scene.hBondPositions.length];
		System.arraycopy(scene.boxSize, 0, boxSize, 0, 3);
		System.arraycopy(scene.hBondPositions,0,hBondPositions,0,6*hBondCount);
		System.arraycopy(scene.atomPositions,0,atomPositions,0,9*moleculeCount);
		//apply translation
		translate(atomPositions,moleculeCount*3);
		translate(hBondPositions,hBondCount*2);
	}
	public void clear() {
		hBondCount=moleculeCount=0;
	}
	// ------------------------------------------------------------------------
	// rendering
	private void initialize(GLAccess gla) {
		covBondDrawer.init(gla);
		atomsDrawer.init(gla);
		boxDrawer.init(gla);
	}

	private void render(GLAccess gla) {		
		//gla.setBrighness(brightness);
		gla.setupCamera(rotateX, rotateY, 0, 0, 0, zoom);
		
		/*GLUquadric q=glu.gluNewQuadric();
		glu.gluQuadricOrientation(q, GLU.GLU_OUTSIDE);
		glu.gluSphere(q, 1.0f, 20, 20);
		glu.gluDeleteQuadric(q);*/

		//draw sold stuff first
		covBondDrawer.draw(gla,atomPositions,moleculeCount,boxSize);
		atomsDrawer.draw(gla,atomPositions,shrinkAtoms?shrinkCoef:1,moleculeCount);
		//then draw lines
		boxDrawer.draw(gla,boxSize);
		//bonds
		gla.setColor(hBondColor);
		gla.drawLines(hBondPositions, 0, hBondCount,hBondWeight,boxSize);
	}
	/*public void kill(GLAccess gla) {
		boxDrawer.kill(gla);
		covBondDrawer.kill(gla);
		atomsDrawer.kill(gla);
	}*/
	 
	 // ------------------------------------------------------------------------
	
	private final GLAccess gla=new GLAccess();
	private final GLU glu=new GLU();
	public void display(GLAutoDrawable drawable) {
		gla.setup(drawable.getGL());
		gla.preDraw();
		render(gla);
		gla.release();
	}

	public void displayChanged(GLAutoDrawable drawable, boolean modeChanged,
			boolean deviceChanged) {
		//do nothing
	}

	public void init(GLAutoDrawable drawable) {
		gla.setup(drawable.getGL());
		gla.init();
		initialize(gla);
		gla.release();
	}

	public void reshape(GLAutoDrawable drawable, int x, int y, int width,
			int height) {
		gla.setup(drawable.getGL());
		gla.reshape(x, y, width, height, Renderer.nearZClip, Renderer.farZClip);
		gla.release();
	}


}


/*

// ------------------------------------------------------------------------
//bindings
private SimModel simModel;
private DisplayModel displayModel;

private final SimpleLink simModelLink=new SimpleLink() {
	 void receive(EventObject event) {
		simModelChanged();
	}
};
private final DelayedLink displayModelLink=DelayedLink.createConditionalLink(
	EDTWorker.getInstance(),5, TimeUnit.MILLISECONDS,new SimpleLink() {
		 void receive(EventObject event) {
			displayModelChanged();
		}
});
 final synchronized void setModels(@Nullable SimModel simM,@Nullable DisplayModel displayM) {
	if(simModel!=null)simModel.getChangeSource().disconnect(simModelLink);
	simModel=simM;
	if(simM!=null) simM.getChangeSource().connect(simModelLink);
	simModelChanged();
	reset();
}
*/