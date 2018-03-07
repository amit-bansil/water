/*
 * HitTester.java
 * CREATED:    Jun 15, 2005 12:01:00 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-util
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.simulation.graphics;

import java.awt.Point;
import java.awt.Rectangle;

/**
 * Static methods for determing if a point is in a region.<br>
 * Designed for finding what part of a drawing the mouse is in.<br>
 * OPTIMIZE return fastest if the mouse is not in a region, so that a large
 * number of regions can be quickly tested.
 * 
 * @author Amit Bansil
 */
//@SuppressWarnings({"MethodWithTooManyParameters"})
public class HitTester {
	/**
	 * IAE if r<0
	 * 
	 * @return true iff v in [min-r,min+size+r]
	 */
	public static boolean in(int v, int r, int min, int size) {
		if (r < 0) throw new IllegalArgumentException("negative size");
		if (size < 0) {
			return v <= min + r && v >= min + size - r;
		} else {
			return v >= min - r && v <= min + size + r;
		}
	}

	/**
	 * @return true iff v in [min,min+size]
	 */
	public static boolean in(int v, int min, int size) {
		if (size < 0) {
			return v <= min && v >= min + size;
		} else {
			return v >= min && v <= min + size;
		}
	}

	/**
	 * Tests if a sqaure 'point' intersects a rectangle. negative width and
	 * height ARE allowed, however pr must be >=0.
	 * 
	 * @param px
	 *            x coordinate of point
	 * @param py
	 *            y coordinate of point
	 * @param pr
	 *            size of point, positive
	 * @param rx
	 *            x coordinate of rectangle
	 * @param ry
	 *            y coordinate of rectangle
	 * @param w
	 *            width of rectangle, positive
	 * @param h
	 *            height of rectangle, positive
	 */
	public static boolean nearRect(int px, int py, int pr, int rx, int ry,
			int w, int h) {
		return in(px, pr, rx, w) && in(py, pr, ry, h);
	}

	public static boolean nearRect(Point p, int pr, Rectangle r) {
		return nearRect(p.x, p.y, pr, r.x, r.y, r.width, r.height);
	}

	/**
	 * as above except the point has side 0.
	 */
	public static boolean inRect(int px, int py, int rx, int ry, int w, int h) {
		return in(px, rx, w) && in(py, ry, h);
	}

	public static boolean inRect(Point p, Rectangle r) {
		return inRect(p.x, p.y, r.x, r.y, r.width, r.height);
	}

	/**
	 * like nearRect except interior is excluded.
	 */
	public static boolean nearRectBorder(int px, int py, int pr, int rx,
			int ry, int w, int h) {
		return nearRect(px, py, pr, rx, ry, w, h)
				&& !inRect(px, py, rx, ry, w, h);
	}

	public static boolean nearRectBorder(Point p, int pr, Rectangle r) {
		return nearRectBorder(p.x, p.y, pr, r.x, r.y, r.width, r.height);
	}

	/**
	 * test if the square point with side pr at (px,py) intersects the line from
	 * (x0,y0) to (x1,y1).
	 */
	public static boolean nearLine(int px, int py, int pr, int x0, int y0,
			int x1, int y1) {
		// move origin to (x0,y0)
		px -= x0;
		py -= y0;
		x1 -= x0;
		y1 -= y0;

		// in bounding rectangle
		if (!nearRect(px, py, pr, 0, 0, x1, y1)) return false;
		// in either of these degenerate cases we're done
		// since all we have is a rectangle
		if (x1 == 0 || y1 == 0) return true;

		if (!nearMathLine(px, py, pr, x1, y1)) return false;

		// corner at origin, by using perpendicular line
		if (!nearMathLine(px, py, pr, -y1, x1)) return false;

		// check far corner
        return nearMathLine(px - x1, py - y1, pr, -y1, x1);

    }

	/**
	 * @return true iff (px,py) is at most pr from the line through (0,0) which
	 *         extends infinitely in both directions with slope w/h. Error if
	 *         h==0||pr<0.
	 */
	public static boolean nearMathLine(int px, int py, int pr, int w, int h) {
		if (pr < 0) throw new IllegalArgumentException("negative size");
		// find length of shortest vertical line between p and the line
		// and make sure its magnitude is less than pr
		int dh = ((px * w) / h) - py;
		if (dh > pr || dh < -pr) return false;
		return false;
	}
}
