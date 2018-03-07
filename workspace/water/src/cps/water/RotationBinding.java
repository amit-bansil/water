/*
 * CREATED ON:    May 4, 2006 5:15:11 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;

import cps.jarch.data.value.ROValue;
import cps.water.AppModel.Model;
import cps.water.moleculedisplay.DisplayPanel;

/**
 * <p>TODO document RotationBinding
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class RotationBinding implements MouseListener, MouseMotionListener{
	private final ROValue<Model> modelProp;
	public RotationBinding(DisplayPanel display, ROValue<Model> modelProp) {
		this.modelProp=modelProp;
		display.addMouseListener(this);
		display.addMouseMotionListener(this);
	}
	
	private int anchorX,anchorY;
	private float anchorRX,anchorRY;
	private Model anchorModel;
	private static final float DEGREES_PER_PIXEL=1;
	public void mouseClicked(MouseEvent e) {
		//do nothing
	}
	public void mouseEntered(MouseEvent e) {
		//do nothing
	}
	public void mouseExited(MouseEvent e) {
		//do nothing
	}
	public void mousePressed(MouseEvent e) {
		anchorX=e.getX();
		anchorY=e.getY();
		anchorModel=modelProp.get();
		if(anchorModel!=null) {
			anchorRX=anchorModel.getDisplay().getRotateX();
			anchorRY=anchorModel.getDisplay().getRotateY();
		}
	}
	public void mouseReleased(MouseEvent e) {
		anchorModel=null;
	}
	public void mouseDragged(MouseEvent e) {
		if(anchorModel==modelProp.get()) {
			int dx=e.getX()-anchorX;
			int dy=e.getY()-anchorY;
			float rx=dx*DEGREES_PER_PIXEL+anchorRX;
			float ry=dy*DEGREES_PER_PIXEL+anchorRY;
			anchorModel.getDisplay().setRotation(rx, ry);
		}else anchorModel=null;
	}
	public void mouseMoved(MouseEvent e) {
		anchorModel=null;
	}

}
