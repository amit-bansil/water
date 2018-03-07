package org.cps.umd.display;

import java.awt.Cursor;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public class RotateBinding extends Binding {

  public RotateBinding(UMDDisplay display) {
	  super(display);
  }
  float rx,ry;
  protected void move(int x, int y, CameraData c) {
    c.setRotation(rx-x,ry-y);
  }
  public Cursor getActiveCursor() {
    return Cursor.getPredefinedCursor(Cursor.MOVE_CURSOR);
  }
  protected void anchor(CameraData c) {
    rx=c.rotation[0];
	ry=c.rotation[1];
  }
}