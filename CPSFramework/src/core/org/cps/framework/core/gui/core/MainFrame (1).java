/*
 * MainFrame.java
 * CREATED:    Aug 22, 2003 4:42:58 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.core;

import org.cps.framework.core.gui.components.SimpleWindow;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.util.resources.loader.IconLoader;

import javax.swing.JFrame;
import javax.swing.JMenuBar;

import java.awt.Frame;
import java.awt.Rectangle;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.util.prefs.Preferences;

/**
 * Application mainframe.
 * disposes on hide.
 * must be linked to app shutdown externally
 * @version 0.1
 * @author Amit Bansil
 */
public class MainFrame extends SimpleWindow {
	private final JFrame frame;
	protected final Preferences prefs;
	//used only for creating subdialogs
	public final Frame getFrame() {
		return frame;
	}
	public final JMenuBar getMenuBar(){
		GuiEventUtils.checkThread();
		return menuBar;
	}
	private final BasicDescription appDesc;
	public MainFrame(
		BasicDescription appDesc,
		Preferences workspacePrefs) {
		this( appDesc, new JFrame(), workspacePrefs);
	}
	private MainFrame(
		BasicDescription appDesc,
		final JFrame frame,
		final Preferences workspacePrefs) {
		super(frame, true);
		GuiEventUtils.checkThread();
		this.prefs = workspacePrefs.node("mainFrame");
		frame.addWindowListener(new WindowAdapter() {
			public void windowOpened(WindowEvent e) {
				int state = prefs.getInt("state", Frame.NORMAL);
				if (state == Frame.ICONIFIED)
					state = Frame.NORMAL;
				frame.setExtendedState(state);
			}
			public void windowClosing(WindowEvent e) {
				saveLocation();
			}
		});

		this.frame = frame;
		this.appDesc = appDesc;
		frame.setIconImage(IconLoader.toImage(appDesc.getIcon(), frame));
		clearTitle();
		menuBar=new JMenuBar();
		frame.setJMenuBar(menuBar);
		initializeLocation();
	}

	public final void clearTitle() {
		setTitle(null);
	}
	public final void setTitle(String title) {
		GuiEventUtils.checkThread();
		String appTitle = appDesc.getTitle();
		if (title == null) {
			frame.setTitle(appTitle);
		} else {
			frame.setTitle(appTitle + " - " + title);
		}
	}
	protected final JMenuBar menuBar;
	//location
	//	frame sizer
	public static final int DEFAULT_WIDTH = 600, DEFAULT_HEIGHT = 400;
	private final void initializeLocation() {
		//screens[i].getConfigurations() takes >2sec to execute
		//which is too long so just faking it
		Rectangle bounds = /*ensureOnScreen(*/
		new Rectangle(
			prefs.getInt("location.x", Integer.MIN_VALUE),
			prefs.getInt("location.y", Integer.MIN_VALUE),
			prefs.getInt("size.width", DEFAULT_WIDTH),
			prefs.getInt("size.height", DEFAULT_HEIGHT /*)*/
		));
		if (bounds.x != Integer.MIN_VALUE && bounds.y != Integer.MIN_VALUE)
			frame.setBounds(bounds);
		else {
			frame.setSize(bounds.getSize());
			frame.setLocationRelativeTo(null);
		}
	}
	protected final void saveLocation() {
		int state = frame.getExtendedState();
		prefs.putInt("state", state);
		if (state != Frame.NORMAL)
			frame.setExtendedState(Frame.NORMAL);

		prefs.putInt("size.width", frame.getSize().width);
		prefs.putInt("size.height", frame.getSize().height);
		prefs.putInt("location.x", frame.getLocation().x);
		prefs.putInt("location.y", frame.getLocation().y);
	}
}
