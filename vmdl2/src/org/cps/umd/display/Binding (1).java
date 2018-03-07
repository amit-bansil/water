package org.cps.umd.display;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */
import java.awt.*;
public abstract class Binding {
	private final UMDDisplay display;
	public Binding(UMDDisplay display) {
		this.display=display;
	}
	public Cursor getNormalCursor(){
		return Cursor.getDefaultCursor();
	}
	public abstract Cursor getActiveCursor();

	public final void anchor(){
		anchor(display.camera);
	}
	protected abstract void anchor(CameraData c);

	public final void move(int x,int y){
		move(x,y,display.camera);
	}
	protected abstract void move(int x,int y,CameraData c);
}