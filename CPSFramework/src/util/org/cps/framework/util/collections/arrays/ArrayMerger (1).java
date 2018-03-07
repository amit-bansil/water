/*
 * ArrayMerger.java
 * CREATED:    January 4, 2003
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.arrays;

import java.lang.reflect.Array;
/**
 * Utility methods for combining arrays, usually uses System.arraycopy
 * @version 0.1
 * @author Amit Bansil
 */
public final class ArrayMerger {
	//same as below but more general, can sepcity type of ret array
	public static final <T> Object slowMerge(Object a1,Object a2,Class<T> type){
		final int l1=Array.getLength(a1);
		final int l2=Array.getLength(a1);
		return fastMerge(a1,a2,l1,l2,Array.newInstance(type,l1+l2));
	}
	//note returns object[] not anything more specific
	//returns a new array == a1+a2
	public static final Object[] merge(Object[] a1,Object[] a2){
		return (Object[])fastMerge(a1,a2,a1.length,a2.length,new Object[a1.length+a2.length]);
	}
	//flattens n array
	public static final <T> Object[] slowMerge(final Object[][] array,Class<T> type){
		int length=0;
		for(int i=0;i<array.length;i++){
			length+=array[i].length;
		}
		Object[] ret=(Object[])Array.newInstance(type,length);
		int n=0;
		for(int i=0;i<array.length;i++){
			final Object[] o=array[i];
			System.arraycopy(o,0,ret,n,o.length);
			n+=o.length;
		}
		return ret;
	}
	//returns a1+a2 in dst
	public static final Object fastMerge(Object a1,Object a2,int l1,int l2,Object dst){
		System.arraycopy(a1,0,dst,0,l1);
		System.arraycopy(a2,0,dst,l1,l2);
		return dst;
	}
	//returns || of each element in a1 and a2 in dst
	public static final boolean[] or(boolean[] a1,boolean[] a2,boolean[] dst){
		final int l=a1.length<=a2.length?a1.length:a2.length;
		for(int i=0;i<l;i++){
			dst[i]=a1[i]||a2[i];
		}
		return dst;
	}
}
