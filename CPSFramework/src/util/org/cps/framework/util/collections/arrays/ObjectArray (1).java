/*
 * ObjectArray.java
 * CREATED:    Aug 19, 2003 9:44:02 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.arrays;

import java.util.Arrays;

/**
 * This wrapper for object arrays correctly implements hashcode, equals, and toString for Object[].
 * it works great as a key in hashtables keyed by muliple values
 * notice that although the array is immutable its contents are not.
 * array may not be null;
 * @version 0.1
 * @author Amit Bansil
 */
public class ObjectArray<T> implements Cloneable{
	protected final Object[] array;
	public static final <T> ObjectArray<T> create(T[] array){
		return new ObjectArray<T>(array);
	}
	public static final <T> ObjectArray<T> create(T a){
		return new ObjectArray<T>(new Object[]{a});
	}
	public static final <T> ObjectArray<T> create(T a,T b){
		return new ObjectArray<T>(new Object[]{a,b});
	}
	//TODO use var args
	private ObjectArray(Object[] array) {
		if(array==null)throw new NullPointerException();
		this.array=array;
	}
	public ObjectArray(ObjectArray<T> source){
		this.array=source.array;
	}
	protected Object clone(){//TODO return T when covariant
		return new ObjectArray<T>(this);
	}
	public boolean equals(Object o) {
		if(!(o instanceof ObjectArray))return false;
		return Arrays.deepEquals(array,((ObjectArray)o).array);
	}
	//xor all elements
	public int hashCode() {
		return Arrays.deepHashCode(array);
	}
	public String toString() {
		return Arrays.deepToString(array);
	}
}
