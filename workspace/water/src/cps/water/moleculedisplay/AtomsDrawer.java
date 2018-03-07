/*
 * CREATED ON:    Apr 24, 2006 1:56:20 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import cps.water.moleculedisplay.GLAccess.DisplayList;
import cps.water.moleculedisplay.GLAccess.Quadrics;

/**
 * <p>TODO document AtomsDrawer
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
class AtomsDrawer {
	private DisplayList hAtomList,oAtomList;
	
	final void init(GLAccess gla) {
		Quadrics quadrics=gla.createQuadrics();
		hAtomList=gla.beginList();
		quadrics.sphere(Renderer.hSize, Renderer.hSlices, Renderer.hStacks);
		hAtomList.end();
		oAtomList=gla.beginList();
		quadrics.sphere(Renderer.oSize, Renderer.oSlices, Renderer.oStacks);
		oAtomList.end();
		quadrics.kill();
	}
	final void draw(GLAccess gla,float[] positions,float radScale,int numMols) {
		gla.setLightingEnabled(true);
		
		//draw o atoms
		gla.setColor(Renderer.oColor);
		draw(gla,positions,radScale,0,oAtomList,numMols*9);
		//draw h1 atoms
		gla.setColor(Renderer.hColor);
		draw(gla,positions,radScale,3,hAtomList,numMols*9);
		//draw h1 atoms
		draw(gla,positions,radScale,6,hAtomList,numMols*9);
	}
	private static final void draw(GLAccess gla,
		final float[] positions,final float radScale,final int offset,
		final DisplayList atomList,final int numIndices) {		
		for(int i=offset;i<numIndices;i+=9) {
			gla.pushMatrix();
			gla.translate(positions[i], positions[i+1], positions[i+2]);
			if(radScale!=1)
				gla.scale(radScale, radScale, radScale);
			atomList.call();
			gla.popMatrix();
		}
	}
	final void kill(GLAccess gla) {
		hAtomList.kill();
		oAtomList.kill();
		hAtomList=null;
		oAtomList=null;
	}
}