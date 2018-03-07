/*
 * SplashScreen.java created on Apr 21, 2003 by Amit Bansil.
 * Part of The Virtual Molecular Dynamics Laboratory, vmdl2 project.
 * Copyright 2003 Center for Polymer Studies, Boston University.
 **/
package org.cps.framework.core.gui.components;

import org.cps.framework.core.gui.event.GuiEventUtils;

import javax.swing.Icon;
import javax.swing.JLabel;

import java.awt.Container;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

/**
 * @author Amit Bansil.
 */
public final class AboutScreen{
	private final SimpleWindow window;
	public AboutScreen(Container parent, Icon icon, boolean clickClose) {
		super();
		GuiEventUtils.checkThread();
		JLabel content = new JLabel(icon);
		window=SimpleWindow.createWindow(true,parent);
		window.setContent(content);
		if (clickClose) {
			content.addMouseListener(new MouseAdapter() {
				public void mouseClicked(MouseEvent e) {
					close();
				}
			});
		}
		window.show();
	}
	public final void close(){
		GuiEventUtils.checkThread();
		window.hide();
	}
}
