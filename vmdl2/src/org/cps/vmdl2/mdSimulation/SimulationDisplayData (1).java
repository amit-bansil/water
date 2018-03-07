package org.cps.vmdl2.mdSimulation;


/**
 * Title:        Universal Molecular Dynamics
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      Boston University
 * @author Amit Bansil
 * @version 0.0a
 */
//provides DisplayData from simulation
public class SimulationDisplayData{
	public SimulationDisplayData() {
		reset();
	}
	public float[] size;
	public float[] getSize(){
		return size;
	}
	//data
	public int[] bonds;
	public float[] positions,velocities;
	public int numAtoms;
	public int bScanSize;
	public int numDimensions;
	public final int getNumDimensions(){
		return numDimensions;
	}
	public final boolean is3D(){return numDimensions==3;}
	public final boolean is2D(){return numDimensions==2;}

	public final int getBondFrom(int i){ return bonds[i*2]; }
	public final int getBondTo(int i){ return bonds[(i*2)+1]; }
	public final int[] getBonds(){ return bonds; }
	public final float[] getPositions(){ return positions; }
	public final float[] getVelocties(){ return velocities; }
	public final void getPosition(float[] t,int i){ System.arraycopy(positions,i*3,t,0,3); }
	public final void getVelocity(float[] t,int i){ System.arraycopy(velocities,i*3,t,0,3); }
	public final int getAtomCount(){ return numAtoms; }
	public final int getBScanSize(){ return bScanSize; }
	//change
	public int firstChangedBond,firstChangedPosition,firstChangedVelocity,
		lastChangedBond,lastChangedPosition,lastChangedVelocity;

	public final int getFirstPositionChanged(){return firstChangedPosition;}
	public final int getFirstVelocityChanged(){return firstChangedVelocity;}
	public final int getLastPositionChanged(){return lastChangedPosition;}
	public final int getLastVelocityChanged(){return lastChangedVelocity;}
	public final int getFirstBondChanged(){return firstChangedBond;}
	public final int getLastBondChanged(){return lastChangedBond;}

	private boolean bondsChanged,positionsChanged,velocitiesChanged,numAtomsChanged,
			bScanSizeChanged,changed,sizeChanged;

	public final void setChangeFlag(SimulationFlags flag){
		bondsChanged=flag.isBondsChanged();
		positionsChanged=flag.isPositionsChanged();
		velocitiesChanged=flag.isVelocitiesChanged();
		numAtomsChanged=flag.isAtomCountChanged();
		bScanSizeChanged=flag.isBScanSizeChanged();
		sizeChanged=flag.isSizeChanged();
		if(positionsChanged|bondsChanged|velocitiesChanged|numAtomsChanged|bScanSizeChanged|sizeChanged)
			changed=true;
	}

	public final void reset(){
		if(changed){
			changed=false;
			sizeChanged=false;
			positionsChanged=false;
			bondsChanged=false;
			velocitiesChanged=false;
			bScanSizeChanged=false;
			numAtomsChanged=false;
			firstChangedPosition=firstChangedVelocity=firstChangedBond=0;
			lastChangedBond=lastChangedPosition=lastChangedVelocity=0;
		}
	}
	public final boolean isChanged(){
		return changed;
	}
	public final boolean isPositionsChanged(){
		return positionsChanged;
	}
	public final boolean isVelocitiesChanged(){
		return velocitiesChanged;
	}
	public final boolean isBondsChanged(){
		return bondsChanged;
	}
	public final boolean isAtomCountChanged(){
		return numAtomsChanged;
	}
	public final boolean isBScanSizeChanged(){
		return bScanSizeChanged;
	}
	public final boolean isSizeChanged(){
		return sizeChanged;
	}
}