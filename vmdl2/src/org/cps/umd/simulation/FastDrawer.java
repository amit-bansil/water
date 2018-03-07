package org.cps.umd.simulation;

import org.cps.umd.display.CameraData;
import org.cps.umd.display.Drawer;
import org.cps.umd.display.UMDDisplay;
import org.cps.vmdl2.mdSimulation.SimulationDisplayData;
import org.cps.vmdl2.mdSimulation.SimulationTypeData;
import org.cps.vmdl2.mdSimulation.UMDSimulation;

import java.awt.Color;

/**
 * <p>
 * Title: Universal Molecular Dynamics
 * </p>
 * <p>
 * Description: A Universal Interface for Molecular Dynamics Simulations
 * </p>
 * <p>
 * Copyright: Copyright (c) 2002
 * </p>
 * <p>
 * Company: Boston University
 * </p>
 * 
 * @author Amit Bansil
 * @version 0.1a
 */

public class FastDrawer implements Drawer {
	public static final float fit(float f, float max, float min) {
		return Math.min(Math.max(f, min), max);
	}
	boolean needsInit;

	boolean changed, positionsChanged, bondsChanged, radiiChanged,
			colorsChanged;

	private final SimulationDisplayData displayData;

	private final SimulationTypeData typeData;

	private final UMDSimulation sim;

	private int realBScanSize;

	private final boolean colorByKE, forceTypeColors, forceRadii,
			colorByNumber;

	private final float spectrumMax, spectrumMin, hMax, hMin;

	private float[] colorsA, radiiA;

	public FastDrawer(UMDDisplay display, UMDSimulation sim) {
		needsInit = true;

		colorByKE = false;
		forceTypeColors = false;
		forceRadii = false;
		spectrumMin = -1;
		spectrumMax = 1;
		colorsA = new float[0];
		radiiA = new float[0];
		colorByNumber = false;
		hMax = 1;
		hMin = 0;

		displayData = sim.getDisplayData();
		typeData = sim.getTypeData();
		this.sim = sim;

		positions = displayData.getPositions();
		types = typeData.getAtomTypes();
		//update(true);

		realBScanSize = displayData.getBScanSize();
		changed = positionsChanged = bondsChanged = radiiChanged = colorsChanged = true;
	}

	private boolean doInternalUpdate = false;

	private final void doNothing(int o) {//needs some code to prevent inlining
										 // to nothing?
		o++;
		o = (int) Math.sqrt(o * 21);
	}

	public static final float SCALE_FACTOR = .25f, UNSCALE_FACTOR = .5f;

	public final void update(boolean reMapTypes) {
		doInternalUpdate = false;
		if (typeData.isAtomTypesChanged()) {
			reMapTypes = true;
			types = typeData.getAtomTypes();
		}
		if (typeData.isTypeDescsChanged()) reMapTypes = true;
		if (displayData.isPositionsChanged()) {
			positions = displayData.getPositions();
			changed = positionsChanged = true;
		}
		if (count != displayData.getAtomCount()) {
			count = displayData.getAtomCount();
			if (count > size || count / UNSCALE_FACTOR > size)
					size = (int) (count * (1 + SCALE_FACTOR));
			changed = positionsChanged = true;
			if (count > types.length) reMapTypes = true;
		}
		if (displayData.isBondsChanged()) {
			changed = bondsChanged = true;
		}
		if (displayData.isBScanSizeChanged()) {
			changed = bondsChanged = true;
			realBScanSize = displayData.getBScanSize();
		}
		if (reMapTypes) {
			createSpectrum();
			final int typeCount = typeData.getAtomTypeCount();
			int[] typeColorsxxx = new int[typeCount];
			int n = 0, cxx;
			float[] c = typeData.getAtomTypeColors();
			final float[] caa = colorsA;
			if (forceTypeColors) {
				if (caa.length == c.length) c = caa;
				else if (caa.length < c.length) {
					System.arraycopy(caa, 0, c, 0, caa.length);
					colorsA = c;
				}
			}
			//System.out.println("starting typeColors{");

			for (int i = 0; i < typeCount; i++, n += 3) {
				cxx = 0xff000000 | ((int) (c[n + 0] * 255)) << 16
						| ((int) (c[n + 1] * 255)) << 8
						| ((int) (c[n + 2] * 255)) << 0;
				typeColorsxxx[i] = cxx;
				//the line of code below should do absolutly nothing.
				//however without it some simulations (for example bonding)
				// [perhaphs because of reaction?? causing typeRemap events]
				//will set some of its typeColors to 0 [black] and draw wrong
				doNothing(typeColorsxxx[i]);
				//System.out.println("["+new
				// java.awt.Color(typeColors[i])+"]");// why does this nooed to
				// be done in two statements???
			}
			this.typeColors = typeColorsxxx;
			//System.out.println("}done typeColors");
			types = typeData.getAtomTypes();
			float[] typeRadii = typeData.getAtomTypeRadii();
			final float[] raa = radiiA;
			if (forceRadii) {
				if (raa.length == typeRadii.length) typeRadii = raa;
				else if (raa.length < typeRadii.length) {
					System.arraycopy(raa, 0, typeRadii, 0, raa.length);
					radiiA = typeRadii;
				}
			}
			if (radii.length != types.length) radii = new float[types.length];
			for (int i = 0; i < types.length; i++)
				radii[i] = typeRadii[types[i]];

			changed = true;
			radiiChanged = colorsChanged = true;
		}
	}

	public boolean needsRedraw() {
		return changed;
	}

	public boolean needsInit() {
		return needsInit;
	}

	int offset, bScanSize;

	public void init(int offset, int bScanSize) {
		this.offset = offset;
		this.bScanSize = bScanSize;
		needsInit = false;
		changed = positionsChanged = bondsChanged = radiiChanged = colorsChanged = true;
	}

	public void offsetChanged(int offset) {
		this.offset = offset;
		changed = positionsChanged = bondsChanged = radiiChanged = colorsChanged = true;
	}

	public void positionsAndRadiiLost() {
		changed = positionsChanged = radiiChanged = true;
	}

	public void colorsLost() {
		changed = colorsChanged = true;
	}

	public void bondsLost() {
		changed = positionsChanged = bondsChanged = radiiChanged = colorsChanged = true;
	}

	public void bScanSizeChanged(int scanSize) {
		bScanSize = scanSize;
		changed = bondsChanged = true;
	}

	private float[] positions = new float[0];

	private float[] radii = new float[0];

	private int[] types = new int[0];

	private int[] typeColors = new int[0];

	private int count, size;

	private static final int[] SPECTRUM = new int[32];

	private void createSpectrum() {
		for (int i = 0; i < SPECTRUM.length; i++)
			SPECTRUM[i] = Color.HSBtoRGB(hueChange((float) i
					/ (SPECTRUM.length - 1f)), 1, 1);
	}

	private final float hueChange(float i) {
		return (i * (hMax - hMin)) + hMin;
	}

	public int redraw(CameraData camera, int[] xa, int[] ya, int[] za,
			int[] oR, int[] colors, int[] bonds) {
		if (!changed)
				throw new IllegalStateException(
						"attempt to update unchanged drawer");
		boolean doKE = false;
		if (positionsChanged || radiiChanged) {
			camera.transform(positions, count, offset, xa, ya, za, radii, oR);
			if (colorByKE) doKE = colorByKE;
		}
		//System.out.println("STARTING
		// COLORS[off="+offset+",count="+count+"]{");
		if (colorsChanged && !colorByKE && !colorByNumber) {
			for (int i = 0; i < count; i++) {
				colors[i + offset] = typeColors[types[i]];
				//System.out.print("["+types[i]+"]");
			}/* not sure if this should be count */
		} else
			doKE = colorByKE || colorByNumber;
		if (doKE) {
			final int l = SPECTRUM.length;
			final float off = -spectrumMin;
			final float s = (1 / (spectrumMax - spectrumMin)) * l;
			final float[] v = displayData.getVelocties();
			int n = 0;

			for (int i = 0; i < count; i++) {

				if (colorByNumber) {
					colors[i + offset] = SPECTRUM[(int) fit(0, l - 1,
							((float) i / (float) count) * l)];
				} else {
					float vaa = v[n] * v[n] + v[n + 1] * v[n + 1] + v[n + 2]
							* v[n + 2];
					colors[i + offset] = SPECTRUM[(int) fit(0, l - 1,
							(vaa + off) * s)];
				}
				n += 3;
			}
		}
		//System.out.println("}FINISHED COLORS");
		if (bondsChanged) {//todo: real bonds support
			final int[] realBonds = displayData.getBonds();
			if (bScanSize == realBScanSize) {
				System.arraycopy(realBonds, 0, bonds, offset, count);
			}
			final int t = count * realBScanSize;
			int j = 0, l;
			for (int i = 0; i < t; i += realBScanSize) {
				int n = 0;
				while (true) {
					if (n >= realBScanSize) {
						bonds[j + n] = -1;
						break;
					}
					l = realBonds[n + i];
					bonds[j + n] = l;
					if (l == -1) break;
					n++;
				}
				j += bScanSize;
			}
		}
		changed = positionsChanged = bondsChanged = radiiChanged = colorsChanged = false;
		return count;
	}

	public int getMinBScanSize() {
		return realBScanSize;
	}

	public int getSize() {
		return size;
	}
}