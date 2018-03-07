/*
 * CREATED ON:    Apr 23, 2006 5:29:04 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.simulation;

import cps.jarch.util.collections.ArrayFinal;
import cps.jarch.util.notes.Nullable;

import javax.vecmath.Tuple3f;

/**
 * <p>TODO document Scene
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */

public final class SimScene{
	SimScene(Engine raw) {
		this.raw=raw;
	}
	private final Engine raw;

	public void getBoundsSize(float[] target) {
		target[0]=(float) raw.bx;
		target[1]=(float) raw.by;
		target[2]=(float) raw.bz;
	}
	
	// ------------------------------------------------------------------------
	//atoms
	
	public static final int O_ATOM_NUMBER = 2, H1_ATOM_NUMBER = 0, H2_ATOM_NUMBER = 1;

	public final void getAtomPosition(int moleculeNumber, int atomNumber, float[] dst,
			int dstStart) {
		dst[dstStart] = raw.rn[moleculeNumber][0][atomNumber];
		dst[dstStart+1] = raw.rn[moleculeNumber][1][atomNumber];
		dst[dstStart+2] = raw.rn[moleculeNumber][2][atomNumber];
	}


	public final int getMoleculeCount() {
		return raw.mols;
	}
	// ------------------------------------------------------------------------
	//velocity/energy
	public final void getAtomVelocity(int moleculeNumber, int atomNumber, double[] dst,
			int dstStart) {
		dst[dstStart] = raw.ve[moleculeNumber][0][atomNumber];
		dst[dstStart] = raw.ve[moleculeNumber][1][atomNumber];
		dst[dstStart] = raw.ve[moleculeNumber][2][atomNumber];
	}

	public final float getAtomKineticEnergy(int moleculeNumber, int atomNumber) {
		return (float) Math.sqrt(raw.ve[moleculeNumber][0][atomNumber]
				* raw.ve[moleculeNumber][0][atomNumber]
				+ raw.ve[moleculeNumber][1][atomNumber]
				* raw.ve[moleculeNumber][1][atomNumber]
				+ raw.ve[moleculeNumber][2][atomNumber]
				* raw.ve[moleculeNumber][2][atomNumber]);
	}

	public final double getMoleculePotentialEnergy(int moleculeNumber) {
		return raw.potH2O[moleculeNumber];
	}
	
	// ------------------------------------------------------------------------
	//bonds
	public final void getHBondSrcPosition(int bondNumber, float[] dst, int dstStart) {
		int srcMolNum = raw.indxww[bondNumber][0];
		getAtomPosition(srcMolNum, O_ATOM_NUMBER, dst, dstStart);
	}

	public final void getHBondDstPosition(int bondNumber, float[] dst, int dstStart) {
		int dstMolNum = raw.indxww[bondNumber][1];
		int dstAtomNum = raw.indxww[bondNumber][2];
		getAtomPosition(dstMolNum, dstAtomNum, dst, dstStart);
	}

	public int getHBondCount() {
		return raw.hbonds;
	}

	// ------------------------------------------------------------------------
	//ions
	private int oldLatRes = -1;

	private double oldCut = -1;

	private PELandscapeCalculator landCalc = null;

	public int[] generatePEMatrix(ArrayFinal<Ion> ions, int latRes, double cut, float x) {
		if (landCalc == null || oldLatRes != latRes || oldCut != cut)
			landCalc = new PELandscapeCalculator(latRes, cut,raw);
		landCalc.generatePELandscape(ions, x);
		return landCalc.getLandscape();
	}

	public @Nullable ArrayFinal<Ion> getIons() {
		return raw.ions;
	}

	public void removeIons() {
		raw.remove_ion();
	}

	public void insertIon(@Nullable ArrayFinal<Ion> ions) {
		raw.insert_ion(ions);
	}

	public void insertIon(@Nullable ArrayFinal<Ion> ions, Tuple3f position) {
		raw.insert_ion(ions, position.x, position.y, position.z);
	}

	public final void getIonPosition(int ionNumber, float[] dst, int dstStart) {
		dst[dstStart] = (float) raw.xni[ionNumber];
		dst[dstStart + 1] = (float) raw.yni[ionNumber];
		dst[dstStart + 2] = (float) raw.zni[ionNumber];
	}
}