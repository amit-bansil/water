/*
 * AttributeEvent.java CREATED: January 18, 2003 AUTHOR: Amit Bansil PROJECT:
 * vmdl2 Copyright 2003 The Center for Polymer Studies, Boston University, all
 * rights reserved.
 */
package org.cps.framework.core.event.util;

import java.util.EventObject;

import org.cps.framework.util.collections.arrays.ArrayFiller;
import org.cps.framework.util.collections.arrays.ArrayMerger;
/**
 * A fast notification of the fields in a source object that are changed. each
 * field should be given an ID that stands for either a flag or pair of
 * changeIndexes, (or both), This class is desigined for a large number of
 * attributes (10+), describing complex changes in datastructures
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class AttributeEvent extends EventObject{
	public AttributeEvent(int maxFlagID, int maxIndexID,Object source) {
	    super(source);
		flags = new boolean[maxFlagID];
		firstChangeIndex = new int[maxIndexID];
		lastChangeIndex = new int[maxIndexID];
		reset();
	}
	//true to make first reset work,will be false afterward
	private boolean isChanged=true;

	private final boolean[] flags;
	private final int[] firstChangeIndex;
	private final int[] lastChangeIndex;
	/**
     * default value for the first and last index changed index of all fields,
     * specifies change index is unknown or invalid.
     */
	public static final int INDEX_UNSET = -1;
	/**
     * sets everything to unchanged.
     */
	public final void reset() {
		if (isChanged) {
			isChanged = false;
			ArrayFiller.fillFalse(flags, 0, flags.length);
			ArrayFiller.fillMinus1(firstChangeIndex,0,firstChangeIndex.length);
			ArrayFiller.fillMinus1(lastChangeIndex,0,lastChangeIndex.length);
		}
	}
	/**
     * sets any fields in this object or e as changed. change indexes are
     * expanded to include both (union)
     * 
     * @param e
     */
	public final void or(AttributeEvent e) {
		checkEvent(e);
		if (e.isChanged()) {
			isChanged=true;
			assert INDEX_UNSET < 0;
			ArrayMerger.or(flags, e.flags, flags);
			for (int i = 0; i < firstChangeIndex.length; i++) {
				if(e.firstChangeIndex[i]!= INDEX_UNSET){//both must be set
					if(firstChangeIndex[i] > e.firstChangeIndex[i])
						firstChangeIndex[i]= e.firstChangeIndex[i];
					if (lastChangeIndex[i] < e.lastChangeIndex[i]) {
						lastChangeIndex[i]= e.lastChangeIndex[i];
					}
				}
			}
		}
	}
	/**
     * sets the flags in this to match e. e must be compatible with this
     * 
     * @param e
     */
	public final void set(AttributeEvent e) {
		checkEvent(e);
		/*
         * if(!e.isChanged){ reset(); return; }
         */
		isChanged=e.isChanged;
		System.arraycopy(
			e.flags,
			0,
			flags,
			0,
			flags.length);
		System.arraycopy(e.firstChangeIndex,0,firstChangeIndex,0,firstChangeIndex.length);
		System.arraycopy(e.lastChangeIndex,0,lastChangeIndex,0,firstChangeIndex.length);
	}
	/**
     * change indexes are left unset....
     * 
     * @param flag
     */
	public final void setChanged(int flagID){
		isChanged=flags[flagID]=true;
	}
	//both first and last must be set or neither
	public final void setChanged(int flagID,int indexID,int firstIndex,int lastIndex){
		if(firstIndex==INDEX_UNSET||lastIndex==INDEX_UNSET){
			if(firstIndex==INDEX_UNSET||lastIndex==INDEX_UNSET)
			    throw new IllegalArgumentException("first and last index must be set together");
		}
		isChanged=flags[flagID]=true;
		firstChangeIndex[indexID]=firstIndex;
		lastChangeIndex[indexID]=lastIndex;
	}
	/**
     * utility to set a flag and indicies from firstChanged to (changeLength-1)
     * 
     * @param flag
     * @param indexFlag
     * @param changeLength #of indicies changed
     * @param firstChanged first index changed
     */
	public final void setLengthChanged(int flagID,int indexFlagID,int firstChanged,int changeLength){
		setChanged(flagID,indexFlagID,firstChanged,firstChanged+changeLength-1);
	}
	//makes sure an event will play property with this one (class is instance
    // and lengths==)
	//subclasses may optimize by simply checking class if fixed lengths
	protected void checkEvent(AttributeEvent e) {
		if (this.getClass().isInstance(e)||e.flags.length!=flags.length
		        ||e.firstChangeIndex.length!=firstChangeIndex.length) {
			throw new IllegalArgumentException(
			        "cannot or/set with diffrent type of attribute event or" +
			        " event with diffrent numIndexes");
		}
	}
	//both these must be set together or both unset
	/**
     * always UNSET if ID is unchanged, may be unset otherwise
     * 
     * @param id
     * @return
     */
	public final int getFirstIndexChanged(int indexID) {
		return firstChangeIndex[indexID];
	}
	/**
     * always UNSET if ID is unchanged, may be unset otherwise
     * 
     * @param id
     * @return
     */
	public final int getLastIndexChanged(int indexID) {
		return lastChangeIndex[indexID];
	}
	/**
     * true if anything has been changed
     * 
     * @return
     */
	public final boolean isChanged() {
		return isChanged;
	}
	/**
     * true if this flag is changed
     * 
     * @param ID
     * @return
     */
	public final boolean isChanged(int flagID) {
		return flags[flagID];
	}
}
