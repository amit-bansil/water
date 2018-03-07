package org.cps.umd.display;

import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.vmdl2.mdSimulation.Clock;

import java.awt.Component;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;
import java.util.Hashtable;

/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public final class MouseBinding{
	private Binding binding;
	private boolean pressed=false;
	private int ax,ay,mx,my;
	//private CPSVector pressedComponents=new CPSVector();
	private boolean running=false;
	private final UMDDisplay display;
	private final ArrayList pressedComponents=new ArrayList();
	private final MouseListener mouseListener=new MouseAdapter() {
		public void mousePressed(MouseEvent e) {
			if(binding==null||pressed||display.camera==null) return;
			running=true;
			ax=e.getX(); ay=e.getY();
			mx=0; my=0;
			synchronized(display.camera){
				binding.anchor();
			}
			pressed=true;
			((Component)e.getSource()).setCursor(binding.getActiveCursor());
			pressedComponents.add(e.getSource());
			redraw();
		}
		public void mouseReleased(MouseEvent e) {
			if(binding==null||!pressed) return;
			running=false;
			mx=ax-e.getX();
			my=ay-e.getY();
			((Component)e.getSource()).setCursor(binding.getNormalCursor());
			pressedComponents.remove(e.getSource());
			if(pressedComponents.isEmpty()) pressed=false;
			redraw();
		}
	};
	private final MouseMotionListener mouseMotionListener=new MouseMotionAdapter(){
		public void mouseDragged(MouseEvent e) {
			if(binding==null||!pressed) return;
			mx=ax-e.getX();
			my=ay-e.getY();
			redraw();
		}
	};
	private boolean redrawing=false;
	private final void redraw() {
		if(Clock.runningHack)return;
		
		if(redrawing)return;
		redrawing=true;
		final int redrawCount=display.redrawCount;
		
		CPSQueue.getInstance().postRunnableExt(new Runnable(){
			public void run() {
				if(display.redrawCount==redrawCount) { CPSQueue.getInstance().postRunnableCPSLater(new Runnable() {
					public void run() {
						redrawing=false;
						if(display.redrawCount==redrawCount) display.postredraw();
					}
				},CPSQueue.getInstance().getTrueTime()+50*1000*1000,1);
				}else redrawing=false;
			}
		});
	}
	public final void update(){
		if(running){
			synchronized(display.camera){
				binding.move(mx,my);
			}
		}
	}


	public final void finish(){
		running=false;
		target.removeMouseListener(mouseListener);
		target.removeMouseMotionListener(mouseMotionListener);
	}

	private final String mode;
	private final String[] modes;

	private final Component target;
	public static final String MODE="mode",MODES="modes";
	final Hashtable table;
	public MouseBinding(Component target,UMDDisplay display) {
		this.display=display;
		table=new Hashtable();
		table.put("Pan",new PanBinding(display));
		table.put("Scale",new ScaleBinding(display));
		table.put("None",new EmptyBinding(display));
		table.put("Rotate",new RotateBinding(display));

		mode="Rotate";
		binding=new RotateBinding(display);

		modes=new String[]{"Pan","Scale","None","Rotate"};

		this.target=target;

		target.addMouseListener(mouseListener);
		target.addMouseMotionListener(mouseMotionListener);
		target.setCursor(binding.getNormalCursor());
	}
	public void setMode(String mode) {

		binding=(Binding)table.get(mode);
		MouseBinding.this.target.setCursor(binding.getNormalCursor());

		if(pressed){
			MouseBinding.this.target.setCursor(binding.getActiveCursor());
		}
	}
}