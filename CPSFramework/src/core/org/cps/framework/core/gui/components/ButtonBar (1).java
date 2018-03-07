/*
 * ButtonBarBuilder.java
 * CREATED:    Aug 16, 2004 9:27:25 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.util.PropertyChangeDescriber;
import org.cps.framework.core.gui.action.ActionDescription;
import org.cps.framework.core.gui.action.SwingWorkspaceAction;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.util.resource.reader.StringArrayReader;
import org.cps.framework.util.resources.accessor.ResourceAccessor;
import org.cps.framework.util.resources.loader.IconLoader;
import org.cps.framework.util.resources.loader.ResourceError;

import com.sun.java.swing.SwingUtilities2;

import javax.swing.AbstractButton;
import javax.swing.Box;
import javax.swing.ButtonModel;
import javax.swing.Icon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.plaf.ButtonUI;
import javax.swing.plaf.basic.BasicButtonUI;
import javax.swing.plaf.basic.BasicHTML;

import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FontMetrics;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class ButtonBar {
	public static final class Ordered extends ButtonBar{
		public Ordered(boolean links, boolean vertical) {
			super(links, vertical);
		}
		public Component build(ResourceAccessor res) {
			String[] order=
				order = res.getObject("order", StringArrayReader.INSTANCE);
			for (String key:order) {
				if (key.equals("<SEPARATOR>")) _addSeparator();
				else {
					SwingWorkspaceAction action=actions.get(key);
					if(action==null)
						throw new ResourceError("unknown element name:" + key,
							res.getResourceName());
					_addAction(action);
				}
			}
			return _build();
		}
		public void registerButton(SwingWorkspaceAction action) {
			super.registerButton(action);
			String name=action.getDescription().getName();
			if(name==null||actions.put(name,action)!=null) 
				throw new Error("name " + name + " taken");//not recoverable
		}
		private final Map<String,SwingWorkspaceAction> actions=new HashMap();
		public void unlink() {
			super.unlink(actions.values());
			actions.clear();
		}
	}
	public static final class UnOrdered extends ButtonBar{
		public UnOrdered(boolean links, boolean vertical) {
			super(links, vertical);
		}
		public Component build() {
			return _build();
		}
		public void registerButton(SwingWorkspaceAction action) {
			super.registerButton(action);
			actions.add(action);
			_addAction(action);
		}
		public void addSeperator() {
			_addSeparator();
		}
		private final List<SwingWorkspaceAction> actions=new ArrayList();
		public void unlink() {
			super.unlink(actions);
			actions.clear();
		}
	}
	//UI CONSTANTS
	private static final Dimension LINKS_SEPARATOR = new Dimension(3, 1),
			BUTTONS_SEPARATOR = new Dimension(2, 2);

	private static final Color LINK_BACKGROUND = Color.WHITE,
			LINK_FOREGROUND = Color.BLUE, LINK_PRESSED = Color.RED;

	private static final Insets EMPTY_MARGIN = new Insets(0, 0, 0, 0);

	private static final ButtonUI LINK_BUTTON_UI = new BasicButtonUI() {
		public void installDefaults(AbstractButton b) {
			super.installDefaults(b);
			//TODO obey plaf by allowing uninstall+other value
			b.setMargin(EMPTY_MARGIN);
			b.setBackground(LINK_BACKGROUND);
			b.setForeground(LINK_FOREGROUND);
		}

		//ERROR this painting code will never be called if we have HTML text...
		protected void paintText(Graphics g, JComponent c, Rectangle textRect,
				String text) {
			AbstractButton b = (AbstractButton) c;
			ButtonModel model = b.getModel();
			FontMetrics fm = SwingUtilities2.getFontMetrics(c, g);
			int mnemonicIndex = b.getDisplayedMnemonicIndex();

			/* Draw the Text */
			if (model.isEnabled()) {
				if (model.isArmed() && model.isPressed()) {//pressed
					g.setColor(LINK_PRESSED);
				} else {
					g.setColor(b.getForeground());
				}
				int x = textRect.x + getTextShiftOffset(), y = textRect.y
						+ fm.getAscent() + getTextShiftOffset();
				if (model.isRollover()) {
					SwingUtilities2.drawString(c, g, text, x, y);
					//FontMetrics fm = g.getFontMetrics();
					int underlineRectX = x;
					int underlineRectY = y;
					int underlineRectWidth = SwingUtilities2.stringWidth(c, fm,
							text);
					int underlineRectHeight = 1;
					g.fillRect(underlineRectX, underlineRectY + 1,
							underlineRectWidth, underlineRectHeight);
				} else {
					/** * paint the text normally */
					SwingUtilities2.drawStringUnderlineCharAt(c, g, text,
							mnemonicIndex, x, y);
				}
			} else {
				/** * paint the text disabled ** */
				g.setColor(b.getBackground().brighter());
				SwingUtilities2.drawStringUnderlineCharAt(c, g, text,
						mnemonicIndex, textRect.x, textRect.y + fm.getAscent());
				g.setColor(b.getBackground().darker());
				SwingUtilities2.drawStringUnderlineCharAt(c, g, text,
						mnemonicIndex, textRect.x - 1, textRect.y
								+ fm.getAscent() - 1);
			}
		}
	};

	//TODO proper size...
	private static final Icon BLANK_ICON = IconLoader.getBlankIcon(16);

	private final boolean links;

	private final Container target;

	private final boolean vertical;

	boolean built = false;

	public ButtonBar(boolean links, boolean vertical) {
		GuiEventUtils.checkThread();
		this.links = links;
		this.vertical = vertical;
		target = vertical ? Box.createVerticalBox() : Box.createHorizontalBox();
		if(links)target.setBackground(LINK_BACKGROUND);//TODO ui
	}

	public void registerButton(SwingWorkspaceAction action) {
		GuiEventUtils.checkThread();
		if (built) throw new IllegalStateException("built");
	}

	protected Component _build() {//call at end of build
		if (built) throw new IllegalStateException("built");
		built = true;
		return target;
	}

	public abstract void unlink();

	protected final void unlink(Collection<SwingWorkspaceAction> actions) {
		GuiEventUtils.checkThread();
		if (!built) throw new IllegalStateException("!built");
		for (SwingWorkspaceAction a : actions) {
			enabledL.stopListeningTo(a.enabled(), false);
		}
	}

	protected final void _addSeparator() {
		GuiEventUtils.checkThread();
		if (built) throw new IllegalStateException("built");
		if (links) {
			target.add(Box.createRigidArea(LINKS_SEPARATOR));
		} else {
			target.add(Box.createRigidArea(BUTTONS_SEPARATOR));
		}
	}
	//todo use actionbutton
	protected final void _addAction(final SwingWorkspaceAction action) {
		GuiEventUtils.checkThread();
		if (built) throw new IllegalStateException("built");

		final JButton b = new JButton();

		final ActionDescription ad = action.getDescription();

		GuiEventUtils.checkThread();
		b.setText(ad.getTitle());

		if (ad.hasIcon()) {
			b.setIcon(ad.getIcon());
		} else {
			if (vertical) b.setIcon(BLANK_ICON);
		}

		if (ad.hasAccelerator()) {
			//TODO warn about this being meaingless (fine)&descs for menus??
		}

		if (ad.hasMnemonic()) {
			if (ad.hasMnemonicIndex())
					b.setDisplayedMnemonicIndex(ad.getMnemonicIndex());
			if (ad.hasMnemonicKeyCode())
					b.setMnemonic(ad.getMnemonicKeyCode());
		}

		if (ad.hasDescription()) {
			b.setToolTipText(ad.getDescription());
		}

		if (links) {
			if (BasicHTML.isHTMLString(b.getText()))//??? should text be trimmed
					throw new UnsupportedOperationException(
							"html text not yet supported in link buttons");
			b.setUI(LINK_BUTTON_UI);
		}

		b.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				action.perform();
			}
		});
		enabledL.startListeningTo(action.enabled(), b, true);
		target.add(b);
	}

	private final PropertyChangeDescriber enabledL = new PropertyChangeDescriber<JButton, Boolean>() {
		protected void _propertyChanged(ValueChangeEvent<Boolean> e, JButton b) {
			b.setEnabled(e.getNewValue().booleanValue());
		}
	};
}