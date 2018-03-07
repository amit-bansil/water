/*
 * CREATED ON:    Aug 24, 2005 8:48:30 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.data.event.tools;


import ca.odell.glazedlists.event.ListEvent;
import ca.odell.glazedlists.event.ListEventListener;

import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.EventObject;
import java.util.Observable;
import java.util.Observer;
/**
 * <p>
 * A general purpose adapter that binds many different kinds of listeners to
 * runnable. Events are intentionally not passed, if you need the individual
 * event use the individual listener.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id$
 */
public abstract class LinkAdapter extends Link implements Runnable, ActionListener,
		PropertyChangeListener, Observer, ChangeListener, ListEventListener,ItemListener {
	public LinkAdapter() {
		super();
	}

	public LinkAdapter(String name) {
		super(name);
	}

	public final void actionPerformed(ActionEvent e) {
		run();
	}

	public final void propertyChange(PropertyChangeEvent evt) {
		run();
	}

	public final void update(Observable o, Object arg) {
		run();
	}

	public final void stateChanged(ChangeEvent e) {
		run();
	}

	public final void itemStateChanged(ItemEvent e) {
		run();
	}
	@Override public final void signal(EventObject e) {
		run();
	}

	@SuppressWarnings("unchecked")
	public final void listChanged(ListEvent listChanges) {
		while (listChanges.nextBlock()) {
			// just read changes so that they don't accumulate in memory
		}
		run();
	}

}
