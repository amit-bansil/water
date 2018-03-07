/*
 * CREATED ON:    Apr 21, 2006 4:52:09 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.util;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.ROValue;

import javax.swing.SwingUtilities;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.EventObject;

/**
 * <p>TODO document MouseToggleHandler
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public abstract class MouseToggleHandler implements MouseListener,MouseMotionListener{
	public MouseToggleHandler(ROValue<Boolean> active) {
		this.active=active;
		active.connect(new Link() {
			@Override public void signal(EventObject event) {
				update();
			}
		});
	}
	public void mouseClicked(MouseEvent e) {
		doSetState(State.ACTIVE);
	}
	public void mouseEntered(MouseEvent e) {
		in=true;
		update();
	}
	public void mouseExited(MouseEvent e) {
		in=false;
		update();
	}
	public void mousePressed(MouseEvent e) {
		if(SwingUtilities.isLeftMouseButton(e))
			down=pressed=true;
		update();
	}
	public void mouseReleased(MouseEvent e) {
		if(SwingUtilities.isLeftMouseButton(e))
			pressed=false;
		update();
	}
	public void mouseDragged(MouseEvent e) {
		if(SwingUtilities.isLeftMouseButton(e))
			down=true;
		in=true;
		update();
	}
	public void mouseMoved(MouseEvent e) {
		down=pressed=false;
		in=true;
		update();
	}
	private final ROValue<Boolean> active;
	private boolean in;//mouse is inside component
	private boolean pressed;//left mouse is pressed & was pressed in component
	private boolean down;//mouse is down
	
	private final void update() {
		if(active.get())doSetState(State.ACTIVE);
		else if(in&&pressed) {
			assert down;
			doSetState(State.PRESSED);
		}else if(in&&!down) {
			doSetState(State.ROLLOVER);
		}else {
			doSetState(State.NORMAL);
		}
	}
	public static enum State{ACTIVE,NORMAL,ROLLOVER,PRESSED}
	private State oldState=null;
	private final void doSetState(State s) {
		if (oldState != s) {
			setState(s);
			oldState = s;
		}
	}
	protected abstract void setState(State s);
}