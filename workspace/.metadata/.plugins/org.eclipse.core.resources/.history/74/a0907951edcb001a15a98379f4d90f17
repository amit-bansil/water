package cps.jarch.simulation.graphics;

import java.awt.geom.Rectangle2D;

/**
 * Static utility functions for common graphics operations.<br>
 * Created by Amit Bansil on Aug 6, 2005 3:00:27 PM.
 */
public class GraphicsUtils {
    //--------------------------------------------------------------------------
    //graphics related

    /**
     * increase r.x by x and r.y by y.
     */
    public static final void translate(Rectangle2D r, double x, double y) {
        r.setRect(r.getX() + x, r.getY() + y, r.getWidth(), r.getHeight());
    }

    /**
     * increate r.width by x and r.height by y.
     */
    public static final void expand(Rectangle2D r, double x, double y) {
        r.setRect(r.getX(), r.getY(), r.getWidth() + x, r.getHeight() + y);
    }

    /*
	 * fix width and height of a rectangle to be within specified aspect ratio.
	 * center if desired.
	 */
	public static final void fixAspect(Rectangle2D d, float minAspect, float maxAspect,
			boolean center) {
		fixAspect(d,minAspect,maxAspect,center,center);
	}
	public static final void fixAspect(Rectangle2D d, float minAspect, float maxAspect,
				boolean centerX,boolean centerY) {
		double aspect = d.getWidth() / d.getHeight();
		double nx = d.getX(), ny = d.getY(), nh = d.getHeight(), nw = d.getWidth();

		if (aspect < minAspect) {
			nh = d.getWidth() / minAspect;
			if (centerY) ny += (d.getHeight() - nh) / 2;
		} else if (aspect > maxAspect) {
			nw = maxAspect * d.getHeight();
			if (centerX) nx += (d.getWidth() - nw) / 2;
		}
		d.setRect(nx, ny, nw, nh);
	}
}
