package org.cps.umd.display;

import java.awt.Cursor;
import org.cps.umd.display.*;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public final class PanBinding extends Binding {

	public PanBinding(UMDDisplay display) {
		super(display);
	}
	int cx,cy;
	protected final void anchor(CameraData c){
		cx=(int)c.pan[0];
		cy=(int)c.pan[1];
	}
	protected final void move(int x, int y, CameraData c) {
		c.setPan(new float[]{cx-x,cy-y});
	}
	public Cursor getActiveCursor() {
		return Cursor.getPredefinedCursor(Cursor.MOVE_CURSOR);
	}
}