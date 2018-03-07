/*
 * GuiUtils.java
 * CREATED:    Jan 8, 2005 10:10:41 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.util;

import cps.jarch.data.event.tools.Link;

import java.awt.Component;
import java.util.EventObject;

/**
 * <br>
 * @version $Id: GuiUtils.java 523 2005-08-30 21:31:54Z bansil $
 * @author Amit Bansil
 */
public class GuiUtils {

	/**
	 * creates a listener that causes a component to be redrawn. <br>
	 * OPTIMIZE invoke repaint lazily.
	 * 
	 * @param component
	 *            component to be repainted
	 * @return GenericListener
	 */
	public static Link createRepaintListener(
			final Component component) {
		return new Link() {
			@Override public void signal(EventObject event) {
				component.repaint();
			}
		};
	}
}