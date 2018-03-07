/*
 * FormHolder.java
 * CREATED:    Aug 17, 2004 5:24:41 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import javax.swing.JScrollPane;
import javax.swing.JSplitPane;

import java.awt.Component;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class FormHolder {
	public FormHolder() {
		header=new FormHeader();
		scroll=new JScrollPane();
		split=new JSplitPane(JSplitPane.VERTICAL_SPLIT,
				header.getComponent(),scroll);
	}
	private final FormHeader header;
	public FormHeader getHeader() {
		return header;
	}
	public void setContent(Component c) {
		scroll.getViewport().setView(c);
	}
	public Component getContent(Component c) {
		return scroll.getViewport().getView();
	}
	private final JSplitPane split;
	private final JScrollPane scroll;
	public Component getComponent() {
		return split;
	}
}
