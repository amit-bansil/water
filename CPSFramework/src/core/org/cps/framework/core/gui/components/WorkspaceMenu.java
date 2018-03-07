/*
 * WorkspaceMenu.java created on Apr 6, 2003 by Amit Bansil. Part of The
 * Virtual Molecular Dynamics Laboratory, vmdl2 project. Copyright 2003 Center
 * for Polymer Studies, Boston University.
 */
package org.cps.framework.core.gui.components;

import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.HashMap;

import javax.swing.Icon;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JRadioButtonMenuItem;

import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.gui.action.ActionDescription;
import org.cps.framework.core.gui.action.SwingWorkspaceAction;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.util.resource.reader.StringArrayReader;
import org.cps.framework.util.resources.accessor.ResourceAccessor;
import org.cps.framework.util.resources.loader.IconLoader;
import org.cps.framework.util.resources.loader.ResourceError;

/**
 * a menu in where most data is stored in a resource accessor and
 * WorkspaceActions. accessor should hold "menu" key for menu & "order" key for
 * order. order is a string[] and can contain {separator} wherever menu needs
 * separator
 * 
 * @author Amit Bansil.
 * 
 */
public class WorkspaceMenu extends JMenu {
	private final ResourceAccessor res;

	protected final ResourceAccessor getResources() {
		return res;
	}

	private final HashMap<String,JMenuItem> items = new HashMap<String,JMenuItem>();

	private final String[] order;

	public WorkspaceMenu(ResourceAccessor res) {
		GuiEventUtils.checkThread();
		this.res = res;
		//this.workspace = w;
		order = res.getObject("order", StringArrayReader.INSTANCE);
		//TODO awkward resourcing
		init(this, new ActionDescription(getResources(), "menu"),false);
	}

	//adds menu item, note that name should be unique
	public final void addMenuItem(final SwingWorkspaceAction action) {
		GuiEventUtils.checkThread();
		if (initialized)
				throw new IllegalStateException(
						"can not add items once initialized");
		final JMenuItem m = new JMenuItem();
		final ActionDescription ad = action.getDescription();
		final String name = ad.getName();

		if (items.put(name, m) != null) //not recoverable
				throw new Error("name " + ad.getName() + " taken");

		init(m, ad,true);

		//link up, permanent
		m.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				action.perform();
			}
		});
		m.setEnabled(action.enabled().get().booleanValue());
		action.enabled().addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				m.setEnabled(evt.getNewValue().booleanValue());
			}
		});
	}

	private boolean initialized = false;

	//build menu, called once
	public final void initialize() {
		GuiEventUtils.checkThread();
		if (initialized)
				throw new IllegalStateException("can only be initialized once");
		initialized = true;
		for (int i = 0; i < order.length; i++) {
			String key = order[i];
			if (key.equals("<SEPARATOR>")) addSeparator();
			else {
				JMenuItem m = items.get(key);
				if (m == null)
						throw new ResourceError("unknown element name:" + key,
								res.getResourceName());
				add(m);
			}
		}
	}

	//initialize JMenuItem or JMenu
	private static final Icon BLANK_ICON = IconLoader.getBlankIcon(16);

	//CALCULATE DEFAULT ICON SIZE???
	private final void init(JMenuItem m, ActionDescription desc,boolean indent) {
		GuiEventUtils.checkThread();
		m.setText(desc.getTitle());
		
		if (desc.hasIcon()) {
			m.setIcon(desc.getIcon());
			//TODO proper disabled icon
			m.setDisabledIcon(BLANK_ICON);
		} else {
			if(indent) m.setIcon(BLANK_ICON);
		}
		//hack to fix silly left margin-does not even really work...
		if(!(m instanceof JCheckBoxMenuItem ||m instanceof JRadioButtonMenuItem)&&indent) {
			m.setMargin(new Insets(0,-16,0,0));
		}
		if (desc.hasAccelerator()) {
			if (m instanceof JMenu)
					throw new UnsupportedOperationException(
							"menu's can't have accelerators");
			m.setAccelerator(desc.getAccelerator());
		}

		if (desc.hasMnemonic()) {
			if (desc.hasMnemonicIndex())
					m.setDisplayedMnemonicIndex(desc.getMnemonicIndex());
			if (desc.hasMnemonicKeyCode())
					m.setMnemonic(desc.getMnemonicKeyCode());
		}
	}
}
