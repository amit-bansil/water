package org.cps.vmdl2.mdSimulation;


/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2001</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.0a
 */

public class SimulationTypeData {

	public SimulationTypeData() {
		reset();
	}
	//changed
	public void setChangeFlag(SimulationFlags flags){
		typeDescsChanged=flags.isTypeDescriptionsChanged();
		bondTypesChanged=flags.isBondTypesChanged();
		atomTypesChanged=flags.isAtomTypesChanged();

		if(typeDescsChanged|bondTypesChanged|atomTypesChanged) changed=true;

		if(typeDescsChanged){
			if(atomTypeDescs==null||getAtomTypeCount()>atomTypeDescs.length){
				atomTypeDescs=new _AtomTypeDescription[getAtomTypeCount()+5];
				for(int i=0;i<atomTypeDescs.length;i++) atomTypeDescs[i]=new _AtomTypeDescription(i);
			}
			if(bondTypeDescs==null||getBondTypeCount()>bondTypeDescs.length){
				bondTypeDescs=new _BondTypeDescription[getAtomTypeCount()+5];
				for(int i=0;i<bondTypeDescs.length;i++) bondTypeDescs[i]=new _BondTypeDescription(i);
			}
		}
	}
	public void reset(){
		if(changed){
			typeDescsChanged=false;
			changed=false;
			bondTypesChanged=false;
			atomTypesChanged=false;
			lastAtomTypeChanged=firstAtomTypeChanged=0;
			lastBondTypeChanged=firstBondTypeChanged=0;
		}
	}

	private boolean typeDescsChanged,changed,bondTypesChanged,atomTypesChanged;

	//these are public for native access only
	public int firstAtomTypeChanged,firstBondTypeChanged,
		lastAtomTypeChanged,lastBondTypeChanged;

	public int getFirstAtomTypeChanged(){return firstBondTypeChanged;}
	public int getFirstBondTypeChanged(){return firstAtomTypeChanged;}
	public int getLastAtomTypeChanged(){return lastAtomTypeChanged;}
	public int getLastBondTypeChanged(){return lastBondTypeChanged;}

	public boolean isTypeDescsChanged(){return typeDescsChanged;}
	public boolean isBondTypesChanged(){return bondTypesChanged;}
	public boolean isAtomTypesChanged(){return atomTypesChanged;}
	public boolean isChanged(){return changed;}
	//typedata


	//these are public for native access only
	public float[] atomTypeColors,bondTypeColors;
	public float[] bondTypeRadii,atomTypeRadii;
	public int[] bondOrders;
	public char[] atomTypeElements;
	public String[] atomTypeDescriptions;

	public float[] getAtomTypeColors(){ return atomTypeColors; }
	public float[] getBondTypeColors(){ return bondTypeColors; }
	public int[] getBondOrders(){ return bondOrders; }
	public float[] getBondTypeRadii(){ return bondTypeRadii; }
	public float[] getAtomTypeRadii(){ return atomTypeRadii; }
	public char[] getAtomTypeElements(){ return atomTypeElements; }
	public String[] getAtomTypeTitles(){ return atomTypeDescriptions;}
	private final class _AtomTypeDescription extends AtomTypeDescription{
		final int index;
		public _AtomTypeDescription(final int index){
			this.index=index;
		}
		public float getRadius(){return atomTypeRadii[index];}
		private final float[] color=new float[3];
		public float[] getColor(){
			System.arraycopy(atomTypeColors,index*3,color,0,3);
			return color;
		}
		public char getElement0(){ return atomTypeElements[index*2];}
		public char getElement1(){ return atomTypeElements[index*2+1];}
		public String getDescription(){ return atomTypeDescriptions[index];}
	}
	private final class _BondTypeDescription extends BondTypeDescription{
		final int index;
		public _BondTypeDescription(final int index){
			this.index=index;
		}
		public float getRadius(){return bondTypeRadii[index];}
		private final float[] color=new float[3];
		public float[] getColor(){
			System.arraycopy(bondTypeColors,index*3,color,0,3);
			return color;
		}
		public int getOrder(){ return bondOrders[index]; }
	}
	private AtomTypeDescription[] atomTypeDescs=new _AtomTypeDescription[0];
	private BondTypeDescription[] bondTypeDescs=new _BondTypeDescription[0];

	public int[] bondTypes,atomTypes;
	public final int getAtomType(int i){ return atomTypes[i]; }
	public final int getBondType(int i){ return bondTypes[i]; }
	public final AtomTypeDescription getAtomTypeDescription(int i){return atomTypeDescs[i]; }
	public final BondTypeDescription getBondTypeDescription(int i){return bondTypeDescs[i]; }
	public final int getAtomTypeCount(){ return atomTypeRadii.length; }
	public final int getBondTypeCount(){ return bondTypeRadii.length; }
	public final int[] getBondTypes(){ return bondTypes; }
	public final int[] getAtomTypes(){ return atomTypes; }
	public final AtomTypeDescription[] getAtomTypeDescriptions(){return atomTypeDescs; }
	public final BondTypeDescription[] getBondTypeDescriptions(){return bondTypeDescs; }
}