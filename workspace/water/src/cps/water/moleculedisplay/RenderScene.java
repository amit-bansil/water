/*
 * CREATED ON:    May 2, 2006 8:30:28 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import cps.water.simulation.SimScene;

/**
 * <p>TODO document RenderScene
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class RenderScene {
	// ------------------------------------------------------------------------
	//scene properties
	//a packed array
	//{molecule 1: oxygen atom: x, y, z, hydrogen atom 1: x, y, z, hydrogen atom 2: x, y z, molecule 2...}
	float[] atomPositions=new float[0];
	int moleculeCount;
	int hBondCount;
	//a packed array
	//{bond 1: source position x,y,z, destination position: x,y,z, bond 2...}
	float[] hBondPositions=new float[0];
	final float[] boxSize=new float[3];
	
	public final void readScene(SimScene scene) {
		
		moleculeCount=scene.getMoleculeCount();
		hBondCount=scene.getHBondCount();
		if(atomPositions.length<moleculeCount*9) 
			atomPositions=new float[moleculeCount*9];
		if(hBondPositions.length<hBondCount*6)hBondPositions=new float[hBondCount*6];
		scene.getBoundsSize(boxSize);
		
		//read atom positions
		for(int i=0,j=0;i<moleculeCount;i++) {
			scene.getAtomPosition(i, SimScene.O_ATOM_NUMBER, atomPositions, j);
			j+=3;
			scene.getAtomPosition(i, SimScene.H1_ATOM_NUMBER, atomPositions, j);
			j+=3;
			scene.getAtomPosition(i, SimScene.H2_ATOM_NUMBER, atomPositions, j);
			j+=3;
			//apply translation
			//translate(atomPositions,j,9);
		}
		//read bond positions
		final int origHBondCount=hBondCount;
		for(int i=0,j=0;i<origHBondCount;i++) {
			scene.getHBondSrcPosition(i, hBondPositions, j);
			j+=3;
			scene.getHBondDstPosition(i, hBondPositions, j);
			j+=3;
			//apply translation
			//translate(hBondPositions,j,6);
			//break bond if too long
			//if(isTooLong(hBondPositions,j)) {
			//	hBondCount--;//fewer bonds
			//	j-=6;//overwrite last bond
			//}
		}
	}
}
