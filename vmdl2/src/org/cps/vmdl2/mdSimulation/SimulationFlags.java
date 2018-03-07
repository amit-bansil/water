package org.cps.vmdl2.mdSimulation;

/**
 * Title:        Universal Molecular Dynamics
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      Boston University
 * @author Amit Bansil
 * @version 0.0a
 */
//flags encapsulate changes to data caused by a call on the simulation
public class SimulationFlags {

	public SimulationFlags() {
		//empty
	}
	private int flag;
	public void setFlag(int i){
		flag=i;
	}
	public boolean isChanged(){
		return flag!=CHANGE_NONE;
	}
	private boolean test(int i){
		return (i&flag)==i;
	}
	public boolean isParameterValuesChanged(){
		return test(CHANGE_PARAM_V);
	}
	public boolean isParameterDataChanged(){
		return test(CHANGE_PARAM_D);
	}
	public boolean isInputParameterDataChanged(){
		return test(CHANGE_INPUT_PARAM_D);
	}
	public boolean isPositionsChanged(){
		return test(CHANGE_POSITIONS);
	}
	public boolean isVelocitiesChanged(){
		return test(CHANGE_VELOCITIES);
	}
	public boolean isBondsChanged(){
		return test(CHANGE_BONDS);
	}
	public boolean isAtomCountChanged(){
		return test(CHANGE_NUM_ATOMS);
	}
	public boolean isBScanSizeChanged(){
		return test(CHANGE_BONDS_SCAN);
	}
	public boolean isBondTypesChanged(){
		return test(CHANGE_TYPES_BONDS);
	}
	public boolean isAtomTypesChanged(){
		return test(CHANGE_TYPES_ATOMS);
	}
	public boolean isTypeDescriptionsChanged(){
		return test(CHANGE_TYPE_DESC);
	}
	public boolean isNumDimensionsChanged(){
		return test(CHANGE_NUM_DIMS);
	}
	public boolean isSizeChanged(){
		return test(CHANGE_SIZE);
	}
	public boolean isMaxBondsChanged() {
		return test(CHANGE_TYPE_MAX_BONDS);
	}
	public boolean isMaxAtomsChanged() {
		return test(CHANGE_TYPE_MAX_ATOMS);
	}
	
	private static final int CHANGE_PARAM_V=  	    0x0001;
	private static final int CHANGE_PARAM_D=	 	0x0002;
	private static final int CHANGE_INPUT_PARAM_D=	0x0008;
	private static final int CHANGE_POSITIONS=		0x0010;
	private static final int CHANGE_VELOCITIES=	    0x0020;
	private static final int CHANGE_BONDS=			0x0040;
	private static final int CHANGE_NUM_ATOMS=		0x0080;
	private static final int CHANGE_BONDS_SCAN=		0x0100;
	private static final int CHANGE_TYPES_BONDS=	0x0200;
	private static final int CHANGE_TYPES_ATOMS=    0x0400;
	private static final int CHANGE_TYPE_DESC= 	    0x0800;
	private static final int CHANGE_TYPE_MAX_BONDS= 0x1000;
	private static final int CHANGE_TYPE_MAX_ATOMS= 0x2000;
	private static final int CHANGE_NUM_DIMS=    	0x4000;
	private static final int CHANGE_SIZE=			0x8000;

	private static final int CHANGE_NONE=          0x0000;
}