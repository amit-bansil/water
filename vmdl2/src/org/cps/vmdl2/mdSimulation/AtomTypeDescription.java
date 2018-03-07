package org.cps.vmdl2.mdSimulation;

/**
 * Title: Universal Molecular Dynamics Description: Copyright: Copyright (c)
 * 2001 Company: Boston University
 * 
 * @author Amit Bansil
 * @version 0.0a
 */
//referred to from simulation type data
public abstract class AtomTypeDescription {

	public static final int HIDDEN_ATOM_RADIUS = 0;

	public final boolean isVisible() {
		return getRadius() != HIDDEN_ATOM_RADIUS;
	}

	public final boolean isStar() {
		return getRadius() < 0;
	}

	public final void getElement(char[] element) {
		element[0] = getElement0();
		element[1] = getElement1();
	}

	public abstract float getRadius();

	public abstract float[] getColor();

	//first and second characters of element
	public abstract char getElement0();

	public abstract char getElement1();

	public abstract String getDescription();
}