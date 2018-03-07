package org.cps.umd.display;
/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */
public interface Drawer{
	public boolean needsRedraw();
	public boolean needsInit();

	public void init(int offset,int bScanSize);
	public void offsetChanged(int offset);
	public void positionsAndRadiiLost();
	public void colorsLost();
	public void bondsLost();
	public void bScanSizeChanged(int scanSize);
	public int redraw(CameraData camera,int[] xa,int[] ya,int[] za,int[] radii,int[] colors,int[] bonds);
	public int getMinBScanSize();
	public int getSize();
}