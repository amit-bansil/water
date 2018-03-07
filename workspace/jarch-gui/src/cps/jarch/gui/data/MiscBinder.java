/*
 * MiscBinder.java
 * CREATED:    Jun 19, 2005 2:51:58 PM
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
import cps.jarch.data.value.RWValue;
import cps.jarch.util.misc.LangUtils;

import javax.swing.JComboBox;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;
import javax.swing.text.JTextComponent;

import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.EventObject;

/**
 * perform misc. bindings between GUI components and data models. Bindings push
 * the model value to the GUI components if the two are different and then keep
 * the two in sync unless otherwise stated. Most methods return an unlinker that
 * breaks this binding.
 */
public class MiscBinder {
	// ERROR hack to prevent recursion
	protected static boolean changingText = false;

	/**
	 * binds the text of a <code>JTextComponent</code> to a
	 * <code>String</code> bound property.
	 */
public static final Unlinker bindText(final RWValue<String> source,
			final JTextComponent target) {

		// targetListener
		final DocumentListener docL = new DocumentListener() {
            public void insertUpdate(DocumentEvent e) {
				update();
			}

			public void removeUpdate(DocumentEvent e) {
				update();
			}

			public void changedUpdate(DocumentEvent e) {
				update();
			}
			private final void update() {
				if (changingText) return;
				changingText = true;
				source.set(target.getText());
				changingText = false;
			}
		};
		target.getDocument().addDocumentListener(docL);
		// sourceListener
		final Link sourceListener = new Link() {
			@Override public void signal(EventObject event) {
				if (changingText) return;
				changingText = true;
				// prevent recursion
				target.getDocument().removeDocumentListener(docL);
				if(LangUtils.equals(target.getText(),source.get()))
					target.setText(source.get());
				target.getDocument().addDocumentListener(docL);
				changingText = false;
			}
		};
		// push initial value
		DataUtils.linkAndSync(source, sourceListener);

		return new Unlinker() {
			public void unlink() {
				target.getDocument().removeDocumentListener(docL);
				source.disconnect(sourceListener);
			}
		};
	}

	/**
	 * Binds a ComboBox to an Enum property. Since the selection index is used,
	 * the constants array must have the same order as the elements in the Enum.
	 * thus usually T.values() is used.
	 */
	public static <T extends Enum>Unlinker bindComboBox(
			final RWValue<T> source, final JComboBox target, final T[] constants) {
		// source->target
		final Link sourceListener = new Link() {
			@Override public void signal(EventObject event) {
				target.setSelectedIndex(source.get().ordinal());
			}
		};
		// pushes value
		DataUtils.linkAndSync(source, sourceListener);

		// target->source
		final ItemListener targetListener = new ItemListener() {
			public void itemStateChanged(ItemEvent e) {
				source.set(constants[target.getSelectedIndex()]);
			}
		};
		target.addItemListener(targetListener);

		return new Unlinker() {
			public void unlink() {
				source.disconnect(sourceListener);
				target.removeItemListener(targetListener);
			}
		};
	}
}
