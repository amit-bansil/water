/*
 * StringEditor.java
 * CREATED:    Aug 19, 2004 10:00:08 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.lang.StringUtils;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.gui.event.GuiEventUtils;

import javax.swing.Box;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JTextField;
import javax.swing.event.DocumentEvent;
import javax.swing.event.DocumentListener;

/**
 * TODO support inclusion in larger forms with form messages, externalize
 * strings
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class Editor<T> {
	private final BoundPropertyRW<T> value;

	public BoundPropertyRO<T> value() {
		GuiEventUtils.checkThread();
		return value;
	}

	private final JLabel label;

	private final JTextField field;

	private final JComponent component;

	public final JComponent getComponent() {
		return component;
	}

	public void setText(String text) {
		GuiEventUtils.checkThread();
		field.setText(text);
	}

	public Editor(int fieldSize) {
		//ok off event since...
		value = new DefaultBoundPropertyRW<T>();
		field = new JTextField(fieldSize);
		label = new JLabel(" ");

		field.getDocument().addDocumentListener(new DocumentListener() {
			public void insertUpdate(DocumentEvent e) {
				updateText();
			}

			public void removeUpdate(DocumentEvent e) {
				updateText();
			}

			public void changedUpdate(DocumentEvent e) {
				updateText();
			}
		});
		component = Box.createVerticalBox();
		label.setAlignmentX(0);
		field.setAlignmentX(0);
		component.add(field);
		component.add(label);
	}

	private String currentError = null;

	protected final void setError(String error) {
		GuiEventUtils.checkThread();
		if (!ObjectUtils.equals(error, currentError)) {
			boolean hadError = StringUtils.isBlank(currentError);
			currentError = error;
			if (StringUtils.isBlank(error)) {
				GuiEventUtils.invokeAfterDelay(true, 25, updateErrorR);
			} else {
				if (!hadError) {
					GuiEventUtils.invokeAfterDelay(true, 200, updateErrorR);
				} else {
					GuiEventUtils.invokeAfterDelay(true, 50, updateErrorR);
				}
			}
		}
	}

	private final Runnable updateErrorR = new Runnable() {
		public void run() {
			if(StringUtils.isBlank(currentError)) {
				label.setIcon(null);
			}else {
				label.setIcon(FormMessage.error_message);
			}
			label.setText(currentError);
		}
	};

	String currentText = "";

	private final void updateText() {
		String text = field.getText();
		if (!ObjectUtils.equals(currentText, text)) {
			currentText = text;
			T v;
			if (!StringUtils.isBlank(text)) {
				v = parse(text);
			} else {
				setError("value must not be blank");
				v = null;
			}
			value.set(v);
		}
	}

	protected abstract T parse(String text);
	//TODO better field sizes
	public static final class IntegerEditor extends Editor<Integer> {
		private final int min, max;

		//inclusive range
		public IntegerEditor(int min, int max) {
			super(20);
			this.min = min;
			this.max = max;
		}

		public Integer parse(String text) {
			String error = null;
			int n = 0;
			try {
				n = Integer.parseInt(text);
				if (n <= min) {
					error = "value must be >= " + min;
				} else if (n >= max) {
					error = "value must be <= " + max;
				}
			} catch (NumberFormatException e) {
				error = "value must be a whole number";
			}
			if (error == null) {
				setError(" ");
				return new Integer(n);
			} else {
				setError(error);
				return null;
			}
		}
	}

	public static final class DoubleEditor extends Editor<Double> {
		private final double min, max;

		private final boolean maxInclusive, minInclusive;

		public DoubleEditor(double min, boolean minInclusive, double max,
				boolean maxInclusive) {
			super(20);
			if (max <= min) throw new IllegalArgumentException("bad range");
			this.maxInclusive = maxInclusive;
			this.minInclusive = minInclusive;
			this.min = min;
			this.max = max;
		}

		public Double parse(String text) {
			String error = null;
			double n = 0;
			try {
				n = Double.parseDouble(text);
				if (Double.isNaN(n)) throw new NumberFormatException();

				if (minInclusive) {
					if (n < min) {
						error = "value must be >= " + min;
					}
				} else {
					if (n <= min) {
						error = "value must be > " + min;
					}
				}
				if (maxInclusive) {
					if (n > max) {
						error = "value must be <= " + max;
					}
				} else {
					if (n >= max) {
						error = "value must be < " + max;
					}
				}

			} catch (NumberFormatException e) {
				error = "value must be a real number";
			}
			if (error == null) {
				setError(" ");
				return new Double(n);
			} else {
				setError(error);
				return null;
			}
		}
	}
}