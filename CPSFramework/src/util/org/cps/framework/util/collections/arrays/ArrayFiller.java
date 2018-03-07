/*
 * ArrayFiller.java
 * CREATED:    January 5, 2003
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.arrays;

import java.lang.reflect.Array;

//test thread saftey & integreity by having a few threads hammer this
//class and check there results, also maksure proper exceptions are thrown
//also benchmark
/**
 * A utility class for quickly filling arrays with many variables. Works best on large arrays.
 * to add a fillZero style fill create a constant, add the correct type to Bufs,and fill it in the static
 * block below. Then add a method like fillZero
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public final class ArrayFiller {
	//fill 0
	private static final float[] ZEROS_F = new float[1000];
	public static final void fillZero(float[] a, int offset, int length) {
		fill(a, ZEROS_F, ZEROS_F.length, offset, length);
	}
	private static final int[] ZERO_I = new int[1000];
	public static final void fillZero(int[] a, int offset, int length) {
		fill(a, ZERO_I, ZERO_I.length, offset, length);
	}
	private static final double[] ZERO_D = new double[1000];
	public static final void fillZero(double[] a, int offset, int length) {
		fill(a, ZERO_D, ZERO_D.length, offset, length);
	}
	//fill -1
	private static final int[] MINUS1=new int[1000];
	static{fill(MINUS1,new Integer(-1));}
	public static final void fillMinus1(int[] a, int offset, int length) {
		fill(a, MINUS1,MINUS1.length, offset, length);
	}
	//fill true/false
	private static final boolean[] FALSE=new boolean[1000];
	private static final boolean[] TRUE=new boolean[1000];
	static{
		fill(FALSE,Boolean.FALSE);
		fill(TRUE,Boolean.TRUE);
	}
	public static final void fill(
		boolean[] a,
		boolean b,
		int offset,
		int length) {
		if (b) {
			fillTrue(a, offset, length);
		} else {
			fillFalse(a, offset, length);
		}
	}
	public static final void fillTrue(boolean[] a, int offset, int length) {
		fill(a, TRUE,TRUE.length, offset, length);
	}
	public static final void fillFalse(boolean[] a, int offset, int length) {
		fill(a, FALSE,FALSE.length, offset, length);
	}
	//null
	private static final Object[] NULL=new Object[1000];
	public static final void fillNull(Object[] a, int offset, int length) {
		fill(a, NULL,NULL.length,offset, length);
	}
	//this fills an array with the values in a buffes.
	//if the buffer is not big enough a tile fill is performed
	//would it be faster+more secure to check for overfow?
	public static final void fill(
		final Object dst,
		final Object buffer,
		final int bufferLength,
		final int offset,
		final int length) {
		if (length <= bufferLength) {
			System.arraycopy(buffer, 0, dst, offset, length);
		} else {
			System.arraycopy(buffer, 0, dst, offset, bufferLength);
			//do a tile fill now
			fill(dst, offset, length, bufferLength);

		}
	}
	//slowest
	public static final void fill(Object a, Object v) {
		fill(a, v, 0, Array.getLength(a));
	}
	//fills array a from offset to offset+length with v,good for very large arrays
	//v is auto unwrapped
	//faster	
	public static final void fill(Object a, Object v, int offset, int length) {
		if (length >= 2) { //most common
			Array.set(a, offset, v);
			//set two elements since this is probably faster
			//than calling array copy on 1 elemnt
			Array.set(a, offset + 1, v);
			fill(a, offset, length, 2);
		} else if (length == 1) {
			Array.set(a, offset, v);
		} //do nothing if length==0
	}
	//fills a with a[offset] from offset to offset+length assuming the first s elements are correctly set
	//this does sort of 'tile fill', tiling the from a[offset] to a[offset+s] up to length
	//fastest
	public static final void fill(Object a, int offset, int length, int s) {
		while (length - (s * 2) > 0) {
			System.arraycopy(a, offset, a, s + offset, s);
			s += s;
		}
		System.arraycopy(a, offset, a, s + offset, length - s);
		//OPTIMIZE maybe faster to test length-s!=0
	}
}
