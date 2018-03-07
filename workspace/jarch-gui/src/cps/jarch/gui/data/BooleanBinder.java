/*
 * BooleanBinder.java
 * CREATED:    Jun 19, 2005 2:51:29 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.data;

import cps.jarch.data.DataUtils;
import cps.jarch.data.event.Unlinker;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;

import javax.swing.JCheckBox;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.JToggleButton;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import java.awt.Component;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.util.EventObject;
import java.util.Stack;
/**
 * Static utility method to connect Boolean data models to Boolean GUI
 * properties. Most methods return an
 * {@link cps.jarch.data.event.Unlinker} that can be used to break the
 * binding. Unless otherwise stated, the initial value of the data model is
 * pushed to the GUI object if the GUI has a different value from the data mode &
 * then the two are kept in sync until the binding in unlinked.
 */
public class BooleanBinder {

	/**
	 * binds selected property of a JCheckbox to a boolean property.
	 */
	public static Unlinker bindToggleButton(final RWValue<Boolean> source,
			final JToggleButton target) {
		return bindCheckBox(source, (JCheckBox.ToggleButtonModel) target
			.getModel());
	}

	/**
	 * binds selected property of a JCheckboxMenuItem to a boolean property.
	 */
	public static Unlinker bindCheckBox(final RWValue<Boolean> source,
			final JCheckBoxMenuItem target) {
		return bindCheckBox(source, (JCheckBox.ToggleButtonModel) target
			.getModel());
	}
	public static Unlinker bindCheckBox(RWValue<Boolean> source,JCheckBox target) {
		return bindCheckBox(source, (JCheckBox.ToggleButtonModel) target
			.getModel());
	}
	/**
	 * internal utility to bind a ToggleButtonModel to a RWValue.
	 */
	private static final Unlinker bindCheckBox(final RWValue<Boolean> source,
			final JToggleButton.ToggleButtonModel target) {
		// source->target
		final Link sourceListener = new Link() {
			@Override public void signal(EventObject event) {
				target.setSelected(source.get());
			}
		};
		source.connect(sourceListener);
		// target->source
		final ChangeListener targetListener = new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				source.set(target.isSelected());
			}
		};
		target.addChangeListener(targetListener);
		// push initial value
		target.setSelected(source.get());
		// allow unlink
		return new Unlinker() {
			public void unlink() {
				target.removeChangeListener(targetListener);
				source.disconnect(sourceListener);
			}
		};
	}

	/**
	 * binds the "enabled" boundProperty of two JComponents.
	 */
	public static final Unlinker bindEnabled(final JComponent source,
			final JComponent target) {
		// source->target
		final PropertyChangeListener sourceListener = new PropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent evt) {
				if (target.isEnabled() != source.isEnabled())
					target.setEnabled(source.isEnabled());
			}
		};
		source.addPropertyChangeListener("enabled", sourceListener);

		// target->source
		final PropertyChangeListener targetListener = new PropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent evt) {
				if (target.isEnabled() != source.isEnabled())
					source.setEnabled(target.isEnabled());
			}
		};
		target.addPropertyChangeListener("enabled", targetListener);

		// push source->target
		target.setEnabled(source.isEnabled());

		return new Unlinker() {
			public void unlink() {
				source.removePropertyChangeListener("enabled", sourceListener);
				target.removePropertyChangeListener("enabled", targetListener);
			}
		};
	}

	/**
	 * binds the "enabled" boundProperty of a JComponent to a boolean bound
	 * property. one way binding, recursive over JPanels.
	 */
	public static final Unlinker bindPanelEnabled(
			final ROValue<Boolean> source, final JComponent target) {
		return bindEnabled(source, target, true);
	}

	private static final Unlinker bindEnabled(final ROValue<Boolean> source,
			final JComponent target, final boolean recurse) {
		// sourceListener
		final Link sourceListener = new Link() {
			@Override public void signal(EventObject event) {
				Stack<JComponent> targetStack = new Stack<JComponent>();
				targetStack.push(target);
				final boolean enabled = source.get();

				while (!targetStack.isEmpty()) {
					JComponent t = targetStack.pop();
					if (t.isEnabled() != enabled) t.setEnabled(enabled);
					// recurse over contained JComponents if we're a JPanel
					if (recurse && t instanceof JPanel) {

						for (Component c : t.getComponents()) {
							if (c instanceof JComponent)
								targetStack.push((JComponent) c);
						}
					}
				}
			}
		};
		// push initial value
		DataUtils.linkAndSync(source, sourceListener);
		return DataUtils.createUnlinker(source,sourceListener);
	}
	//TODO this does not work well for scroll panes
	/**
	 * binds the "enabled" boundProperty of a JComponent to a boolean bound
	 * property. One way binding, can be unlinked, non recursive. Two way
	 * avoided since should not be calling <code>setEnabled</code> on
	 * controls.
	 */
	public static final Unlinker bindControlEnabled(
			final ROValue<Boolean> source, final JComponent target) {
		return bindEnabled(source, target, false);
	}

	private static final Object OLD_DIVIDER_LOCATION_KEY = new Object();

	/**
	 * binds the "visible" boundProperty of a JComponent to a boolean bound
	 * property.
	 */
	public static final Unlinker bindVisible(final RWValue<Boolean> source,
			final Component target) {
		final Unlinker sourceUnlinker=bindVisibleDown(source, target);

		// targetListener
		final PropertyChangeListener targetListener = new PropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent evt) {
				source.set(target.isVisible());
			}
		};
		target.addPropertyChangeListener("visible", targetListener);
		return new Unlinker() {
			public void unlink() {
				target.removePropertyChangeListener("visible", targetListener);
				sourceUnlinker.unlink();
			}
		};
	}
	/**
	 * perform one way binding of a boolean property to a component's visible
	 * property.
	 */
	public static Unlinker bindVisibleDown(final ROValue<Boolean> source,final Component target) {
		//sourceListener
		final Link sourceListener = new Link() {
			@Override public void signal(EventObject event) {
				if (target.isVisible() != source.get())
					target.setVisible(source.get());
				// fix for JSplitPanes not resizing properly
				if (target.getParent() instanceof JSplitPane) {
					JSplitPane split = (JSplitPane) target.getParent();
					if (!source.get()) {
						// on hide save divider location
						int length = split.getOrientation() == JSplitPane.HORIZONTAL_SPLIT ? split
							.getWidth()
								: split.getHeight();
						if (length == 0) return;
						split.putClientProperty(OLD_DIVIDER_LOCATION_KEY, split
							.getDividerLocation()
								/ (double)length);
					} else {
						// on show restore divider location
						Double dividerLocation = (Double) split
							.getClientProperty(OLD_DIVIDER_LOCATION_KEY);
						if (dividerLocation != null) {
							split.setDividerLocation(dividerLocation);
						}
					}
				}
			}
		};
		// push initial value
		DataUtils.linkAndSync(source, sourceListener);
		return DataUtils.createUnlinker(source,sourceListener);
	}



}