/*
 * CREATED ON:    Aug 24, 2005 7:40:51 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.components;

import cps.jarch.gui.util.ComponentProxy;
import cps.jarch.util.notes.Nullable;

import javax.swing.JComponent;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.Component;
import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * Very simple utility class for layingout MainPanels. Create either
 * <code>Horizontal</code> or <code>Vertical</code> instance. 'Top'/'Left' &
 * 'Bottom'/'Right' subcomponents are given there preferred size while the
 * 'Middle' subcomponents is scaled to fit the entire space remaining in center.
 * If a subcomponents if placed in a position that already holds a component the
 * existing component is removed. Place <code>null</code> at a location to
 * clear it.
 * {@link cps.jarch.gui.components.CELESTLook#getLargePadSize()} pixels
 * space is created between components.
 * </p>
 * 
 * @see java.awt.BorderLayout for info on underlying layout manager.
 * @author Amit Bansil
 * @version $Id$
 */
public class MainPanel implements ComponentProxy{

	public final void setMiddle(@Nullable ComponentProxy c) {
		setSubComponent(c.getComponent(),BorderLayout.CENTER);
	}
	public final void setMiddle(@Nullable Component c) {
		setSubComponent(c,BorderLayout.CENTER);
	}
	public static final class Horizontal extends MainPanel{
		public final void setLeft(@Nullable ComponentProxy c) {
			super.setSubComponent(c.getComponent(),BorderLayout.WEST);
		}
		public final void setRight(@Nullable ComponentProxy c) {
			super.setSubComponent(c.getComponent(),BorderLayout.EAST);
		}
		public final void setLeft(@Nullable Component c) {
			super.setSubComponent(c,BorderLayout.WEST);
		}
		public final void setRight(@Nullable Component c) {
			super.setSubComponent(c,BorderLayout.EAST);
		}
	}
	public static final class Vertical extends MainPanel{
		public final void setTop(@Nullable ComponentProxy c) {
			super.setSubComponent(c.getComponent(),BorderLayout.NORTH);
		}
		public final void setBottom(@Nullable ComponentProxy c) {
			super.setSubComponent(c.getComponent(),BorderLayout.SOUTH);
		}
		public final void setTop(@Nullable Component c) {
			super.setSubComponent(c,BorderLayout.NORTH);
		}
		public final void setBottom(@Nullable Component c) {
			super.setSubComponent(c,BorderLayout.SOUTH);
		}
	}
	//OPTIMIZE could do this with an array since we never have more than three components
	//but this is so much cleaner
	private final Map<String,Component> componentsByLocation=new HashMap<String, Component>();
	private final void setSubComponent(@Nullable Component c,String location) {
		Component old=componentsByLocation.put(location, c);
		if(old!=null) panel.remove(old);
		if(c!=null) panel.add(c,location);
	}
	private final JPanel panel;
	public MainPanel() {
		final int s=CELESTLook.getInstance().getLargePadSize();
		panel=new JPanel(new BorderLayout(s,s));
	}
	public JComponent getComponent() {
		return panel;
	}
}
