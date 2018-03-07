/*
 * CircularFloatArray.java
 * CREATED:    Aug 20, 2004 4:15:22 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.lang.misc;


/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */

public class CircularFloatArray {
	private final float[] internal;
//	number of elements before we have to start increasing offset
	private final int size;

	private int offset, length, end;
//  true if we wrap around
	private boolean full;

	public CircularFloatArray(int length) {
		this(new float[length], 0, 0);
	}
	public static final CircularFloatArray create(float[] f,int offset,int length) {
		CircularFloatArray ret=new CircularFloatArray(length);
		ret.add(f,offset,length);
		return ret;
	}
	//passed array must be flat,note that f is held onto
	private CircularFloatArray(float[] f, int offset, int length) {
		internal = f;
		this.offset = offset;
		end = length - offset;
		size = f.length;
		this.length = length;
		full = false;
	}
	public final void clear() {
		offset=0;
		length=0;
		end=0;
		full=false;
	}
	public final float sum() {
		float ret=0;
		if(full)for(int i=0;i<size;i++)ret+=internal[i];
		else for(int i=offset;i<offset+length;i++)ret+=internal[i];
		return ret;
	}
	public final boolean isEmpty() {
		return length==0;
	}
	
	public final void add(float f) {
		if (end >= size) {
			end = 0;
			full = true;
		}
		internal[end] = f;
		end++;
		length++;
		if (full) offset++;
	}

	public final void add(float[] f) {
		add(f, 0, f.length);
	}

	public final void add(final float[] f, int offset, int length) {
		for (int i = offset; i < length; i++)
			add(f[i]); //optimize
	}
	//first element in pretend array actually accessible
	public final int getOffset() {
		return offset;
	}
	//length of pretend array
	public final int getLength() {
		return length;
	}
	//max number of elements actually in array
	public final int getSize() {
		return size;
	}
	//number of elements actuall in array
	public final int getCount() {
		return length-offset;
	}
	public final void getAll(float[] f) {
		System.arraycopy(internal, end, f, 0, internal.length - end);
		System.arraycopy(internal, 0, f, internal.length - end, end);
	}

	public final float get(int o) {
		if (o < offset)
				throw new ArrayIndexOutOfBoundsException(
						"index<=first valid index[" + offset + "]");
		o = end - (length - o);
		if (o >= end)
				throw new ArrayIndexOutOfBoundsException("index[" + o
						+ "]>=length[" + length + "]");
		if (o < 0) o += size;
		return internal[o];
	}

	public final void get(int offset, int length, float[] f) {
		for (int i = offset; i < length; i++)
			f[i] = get(i);//OPTIMIZE
	}

	public final void get(int offset, float[] f) {
		get(offset, f.length);
	}

	public final float[] get(int offset, int length) {
		final float[] f = new float[length];
		get(offset, length, f);
		return f;
	}

	public String toString() {
		return super.toString() + "[data=" + internal + ",offset=" + offset
				+ ",length=" + length + ",end=" + end + ",full=" + full + "]";
	}
}