package cps.jarch.gui.components;

import javax.swing.JLabel;

import java.awt.Cursor;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.ArrayList;
import java.util.List;

/**
 * TODO rewrite w/ UI, allow focusing
 * <p>Title: CPSFileManager</p>
 * <p>Description: Simple File Manager for CPS Applications</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University Center For Polymer Studies</p>
 * @author Amit Bansil
 * @version 1.0
 */

//@SuppressWarnings({"ClassTooDeepInInheritanceTree"})
public abstract class LinkButton extends JLabel {
	protected final boolean rollover;
	public LinkButton(boolean rollover) {
		super();
		this.rollover=rollover;
		
		setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
		
		addMouseListener(new MouseAdapter() {
			@Override
			public void mouseReleased(MouseEvent e) {
				pressed=false;
				refresh();
				if(in) doClick(e.getModifiers());
			}
			@Override
			public void mouseEntered(MouseEvent e) {
				in=true;
				if(LinkButton.this.rollover)refresh();
			}
			@Override
			public void mouseExited(MouseEvent e) {
				in=false;
				if(LinkButton.this.rollover) refresh();
			}
			@Override
			public void mousePressed(MouseEvent e) {
				pressed=true;
				refresh();
			}
		});
		addPropertyChangeListener("enabled",new PropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent evt) {
				refresh();
			}
		});
		refresh();
	}
	protected boolean in=false,pressed=false;
	protected boolean isIn() {
		return in;
	}
	protected boolean isPressed() {
		return pressed;
	}
	/**
	 * hook to update text/icon whenever state it is changed.
	 */
	protected abstract void refresh();
	private final List<ActionListener> als=new ArrayList<ActionListener>();
	public final void addActionListener(ActionListener a){als.add(a);}
	public final void removeActionListener(ActionListener a){als.remove(a);}
	public final void doClick(int mods){
		if(isEnabled()) {
			final ActionEvent e=new ActionEvent(this,ActionEvent.ACTION_PERFORMED,
					null,mods);
			for(ActionListener a: als){
				a.actionPerformed(e);
			}
		}
	}

}