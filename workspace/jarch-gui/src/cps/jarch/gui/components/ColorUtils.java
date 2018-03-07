/*
 * ColorUtils.java
 * CREATED:    Jun 25, 2005 9:09:36 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.components;

import java.awt.Color;

/**
 * Misc static utilities methods working with color objects
 */
public class ColorUtils {
	public static final Color mix(Color a, Color b, float amount) {
		return new Color(avg(a.getRed(), b.getRed(), amount), avg(a.getGreen(),
			b.getGreen(), amount), avg(a.getBlue(), b.getBlue(), amount));
	}
	private static int avg(int a, int b, float amount) {
		return Math.round(a + ((b - a) * amount));
	}
}
