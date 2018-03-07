/*
 * Math.java
 * CREATED:    Aug 17, 2004 7:51:34 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class FastMath {
	//TODO fast implementations using tables
	public static float sqrt(float l) {
		return (float)Math.sqrt(l);
	}
	//trig
	public static float sin(float l) {
		return (float)Math.sin(l);
	}
	public static float cos(float l) {
		return (float)Math.cos(l);
	}
	public static float tan(float l) {
		return (float)Math.tan(l);
	}
	public static float asin(float l) {
		return (float)Math.asin(l);
	}
	public static float acos(float l) {
		return (float)Math.acos(l);
	}
	public static float atan(float l) {
		return (float)Math.atan(l);
	}
	//exp
	public static float log2(float l) {
		return (float)Math.log(l);
	}
	public static float log10(float l) {
		return (float)Math.log10(l);
	}
	public static float pow(float base,float n) {
		return (float)Math.pow(base,n);
	}
	public static float exp(float n) {
		return (float)Math.exp(n);
	}
}
