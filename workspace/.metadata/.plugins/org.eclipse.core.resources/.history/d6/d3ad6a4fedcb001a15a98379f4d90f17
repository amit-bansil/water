/*
 * LayoutUtils.java
 * CREATED:    Mar 10, 2005 10:21:22 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.components;

import cps.jarch.util.notes.Nullable;

import javax.swing.Box;
import javax.swing.Icon;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;

/**
 * common utility operations for creating swing layouts.
 * TODO elimate this class altogether
 * @version 1.0
 * @author Amit Bansil
 */
public class LayoutUtils {
	// TODO doc
	public static final JComponent glueHorizontal(@Nullable Component left,@Nullable Component mid,
			@Nullable Component right) {
		JPanel ret = new JPanel(new BorderLayout(CELESTLook.getInstance()
			.getLargePadSize(), CELESTLook.getInstance().getLargePadSize()));
		if (left != null) ret.add(left, BorderLayout.WEST);
		if (right != null) ret.add(right, BorderLayout.EAST);
		if (mid != null) ret.add(mid, BorderLayout.CENTER);
		return ret;
	}
	// TODO doc
	public static final JComponent glueVertical(@Nullable Component top,@Nullable Component mid,
			@Nullable Component bottom) {
		JPanel ret = new JPanel(new BorderLayout(CELESTLook.getInstance()
			.getLargePadSize(), CELESTLook.getInstance().getLargePadSize()));
		if (top != null) ret.add(top, BorderLayout.NORTH);
		if (bottom != null) ret.add(bottom, BorderLayout.SOUTH);
		if (mid != null) ret.add(mid, BorderLayout.CENTER);
		return ret;
	}
	/**
	 * create's two components stuck together with a small amount of padding
	 * between them.
	 */
	public static final JComponent glueHorizontal(Component left, Component right,
			int padding) {
		// OPTIMIZE use box layout
		// if(space<0)throw new IllegalArgumentException();
		Box ret = Box.createHorizontalBox();
		ret.add(left);
		ret.add(Box.createRigidArea(new Dimension(padding, padding)));
		ret.add(right);
		return ret;
	}

	/**
	 * left aligns a component.
	 * @return a Container wrapping that left aligns it
	 */
	public static final Container left(Component t) {
		Box ret = Box.createHorizontalBox();
		ret.add(t);
		ret.add(Box.createHorizontalGlue());
		return ret;
	}
	public static Component smallPad() {
		int s=CELESTLook.getInstance().getSmallPadSize();
		return Box.createRigidArea(new Dimension(s,s));
	}
	public static Component mediumPad() {
		int s=CELESTLook.getInstance().getMediumPadSize();
		return Box.createRigidArea(new Dimension(s,s));
	}
	public static Component largePad() {
		int s=CELESTLook.getInstance().getLargePadSize();
		return Box.createRigidArea(new Dimension(s,s));
	}

	/**
	 * puts an icon to the left of c. used as a workaround for layout problems
	 * with URLLinkButtons
	 */
	public static final Component stickIcon(Icon icon, Component c) {
		return glueHorizontal(new JLabel(icon), c, CELESTLook.getInstance()
			.getSmallPadSize());
	}
}
