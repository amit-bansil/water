/*
 * ButtonFactory.java
 * CREATED:    Jun 19, 2005 10:53:31 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.builder;

import cps.jarch.data.value.RWValue;
import cps.jarch.gui.components.CELESTLook;
import cps.jarch.gui.data.BooleanBinder;

import javax.swing.AbstractButton;
import javax.swing.Icon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JToggleButton;

import java.awt.Insets;
import java.awt.Font;
import java.awt.event.ActionListener;
/**
 * TODO doc.
 */

public class ButtonFactory {
	/**
	 * creates a LinkButton that looks like a hyperlink loading the label
	 * (required) and icon (may be null) through res.
	 */
	/*public static final LocalizableComponent<LinkButton> createURLLinkButton(
			String resKeyPrefix,ActionListener al) {
		LinkButton ret = new LinkButton(false) {
			protected boolean textSet = false;

			@Override
			protected void refresh() {
				if (!textSet) {
					textSet = true;
					setText("<html><u>" + title + "</u></html>");
				}
				if (isEnabled()) {
					if (isPressed()) {
						setForeground(Color.red);
					} else {
						setForeground(Color.blue.darker());
					}
				}
			}
		};
		// if (iconKey != null) ret.setIcon(res.loadImageIcon(iconKey));
		setTooltip(resKeyPrefix, ret);
		ret.addActionListener(al);
		return ret;
	}*/

	public static LocalizableButton<JButton> createButton(
			String name, ActionListener al) {
		JButton ret = new JButton();
		if(al!=null)ret.addActionListener(al);
		return new LocalizableButton<JButton>(name,ret);
	}
	
	/**
	 */
	public static LocalizableButton<AbstractButton> createToolbarButton(
			String name,ActionListener al) {
		AbstractButton ret = _createToolbarButton(al);
		if(al!=null)ret.addActionListener(al);
		return new LocalizableButton<AbstractButton>(name,ret);
	}

	public static AbstractButton createToolbarButton(Icon icon) {
		AbstractButton ret = _createToolbarButton(null);
		ret.setIcon(icon);
		return ret;
	}

	private static AbstractButton _createToolbarButton(
			ActionListener al) {
		JButton ret = new JButton();
		ret.setRolloverEnabled(true);
		// ret.setBorderPainted(false);
		ret.setMargin(new Insets(1, 1, 1, 1));
		if (al != null) ret.addActionListener(al);
		return ret;
	}

	public LocalizableButton<JToggleButton> createToggleButton(String name,
			RWValue<Boolean> source) {
		JToggleButton ret = new JToggleButton();
		BooleanBinder.bindToggleButton(source, ret);
		return new LocalizableButton<JToggleButton>(name,ret);
	}

	public static LocalizableButton<JCheckBox> createCheckBox(
			String name, RWValue<Boolean> source) {
		JCheckBox ret = new JCheckBox();
		BooleanBinder.bindToggleButton(source, ret);
		return new LocalizableButton<JCheckBox>(name, ret);
	}

	public static LocalizableButton<JCheckBox> createHeaderCheckBox(String name,
			RWValue<Boolean> source) {
		LocalizableButton<JCheckBox> ret = createCheckBox(name, source);
		//TODO bind font changes
		ret.getTarget().setFont(CELESTLook.getInstance().getTitleFont());
		return ret;
	}

	public static class LocalizableButton<T extends AbstractButton> extends
			AbstractLocalizableComponent<T> {
		public LocalizableButton(String name, T c) {
			super(name, c);
		}

		@Override
		protected void setIcon(T c, Icon i) {
			c.setIcon(i);
		}

		@Override
		protected void setText(T c, String title) {
			c.setText(title);
		}
		
		@Override
		protected void setEnabled(T c,boolean b) {
			c.setEnabled(b);
		}

		@Override
		protected void setFont(T c,Font f) {
			c.setFont(f);
		}
	}
}