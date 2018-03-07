package org.cps.umd.display;

import java.awt.Cursor;
import org.cps.*;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public final class ScaleBinding extends Binding {

	public ScaleBinding(UMDDisplay display) {
		super(display);
	}
	float ascale;
	protected final void anchor(CameraData c){
		ascale=c.scale;
	}
	protected final void move(int x, int y, CameraData c) {
		c.setScale(y+ascale);
	}
	public Cursor getActiveCursor() {
		return Cursor.getPredefinedCursor(Cursor.N_RESIZE_CURSOR);
	}
}