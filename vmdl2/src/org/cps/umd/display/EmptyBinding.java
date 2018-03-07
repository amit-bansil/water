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

public class EmptyBinding extends Binding {

  public EmptyBinding(UMDDisplay display) {
	  super(display);
  }
  protected void move(int x, int y, CameraData c) {
  }
  public Cursor getActiveCursor() {
    return Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR);
  }
  protected void anchor(CameraData c) {
  }
}