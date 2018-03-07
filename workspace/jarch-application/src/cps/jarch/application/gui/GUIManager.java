/*
 * GUI.java
 * CREATED:    Jan 8, 2005 10:35:25 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.application.gui;

import cps.jarch.application.Application;
import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.tools.Condition;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.gui.builder.CELESTAction;
import cps.jarch.gui.components.CELESTLook;

import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JMenuBar;
import javax.swing.JPanel;
import javax.swing.JRootPane;
import javax.swing.WindowConstants;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.GraphicsEnvironment;
import java.awt.Rectangle;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.event.WindowListener;
import java.util.EventObject;

/**
 * just a hack for the moment TODO breakout mainframe, mainframe title,mainframe
 * positioning
 * 
 * @version 0.1
 * @author Amit Bansil
 */
//@SuppressWarnings({"ClassWithTooManyFields"})
public class GUIManager {
	static {
		// WARNING avoid swing loaded
		CELESTLook.setup();
	}

	private final JMenuBar menuBar = new JMenuBar();

	private final JPanel contentHolder = new JPanel(new BorderLayout(0, 0));
	public final Container getDialogParent() {
		return contentHolder;
	}
	private final DocumentGUI docGUI;

	private final Application application;

	public final DocumentGUI getDocGUI() {
		return docGUI;
	}

	public final void setContentPane(Container c) {		
		contentHolder.removeAll();
		contentHolder.add(c);
		
	}

	private final WindowListener windowListener = new WindowAdapter() {
		@Override
		public void windowClosing(WindowEvent e) {
			application.tryShutdown();
		}
	};

	public GUIManager(final Application application) {
		this.application = application;
		docGUI = new DocumentGUI(application.getDocumentManager(), application
			.getDescription(), contentHolder);

		buildMenus();

		application.connectShutdownLink(new GenericLink<EventObject>() {
			public void signal(EventObject event) {
				frame.dispose();
			}
		});
		fullScreen.connect(new Link() {
			@Override public void signal(EventObject event) {
				updateFullScreen();
			}
		});
		final int s=CELESTLook.getInstance().getLargePadSize();
		contentHolder.setBorder(BorderFactory.createEmptyBorder(
			s,s,s,s));
	}

	private void buildMenus() {
		// add exit action
		final CELESTAction exit = new CELESTAction("exit") {
			@Override
			protected void doAction() {
				application.tryShutdown();
			}
		};
		docGUI.getFileMenu().addAction(exit);
		// build menubar
		menuBar.add(docGUI.getFileMenu().getComponent());

		// bind confirm close
		application.addPreShutdownConstraint(new Condition() {
			public boolean check() {
				return getDocGUI().confirmClose();
			}
		});
	}

	public void startup() {
		updateFullScreen();
		frame.setVisible(true);
	}

	// ------------------------------------------------------------------------
	// fullscreen
	// ------------------------------------------------------------------------

	//TODO if we blacked out the screen when switching around
	//in and out of full screen mode the transition would be cleaner
	//(that won't actually work, but it is a start, better would be to show
	//old and new at same time)
	//TODO extract fullscreen stuff into seperate optiional component
	
	protected JFrame frame = null;

	private final RWValueImp<Boolean> fullScreen = new RWValueImp<Boolean>(
		false);

	private Rectangle oldWindowBounds = null;

	private int oldWindowState;

	private boolean wasFullScreen = false;

	public final RWValue<Boolean> fullScreen() {
		return fullScreen;
	}

	// updates/creates frame to reflect fullscreen vairable
	//TODO logging
	//TODO move alot of this code to gui package.
	//ERROR does not correctly restore window bounds when maximized
	private final void updateFullScreen() {
		boolean lFullScreen = this.fullScreen.get();
		// quit on no change if initialized before
		if (wasFullScreen == lFullScreen && frame != null) { return; }
		// setup new frame
		JFrame newFrame = new JFrame(application.getDescription().getTitle());
		newFrame.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
		newFrame.addWindowListener(windowListener);
		newFrame.setContentPane(contentHolder);
		
		if (lFullScreen) {
			// enable full screen if desired
			newFrame.setUndecorated(true);
			//in case isDefaultLookAndFeelDecorated
			//we must also tell the rootpane to hide its decorations
			newFrame.getRootPane().setWindowDecorationStyle(JRootPane.NONE);
			newFrame.setResizable(false);
			//no menu in full screen mode			
		} else {
			newFrame.setJMenuBar(menuBar);
			
			// use old window bounds if they were set
			if (oldWindowBounds != null) {
				newFrame.setBounds(oldWindowBounds);
				newFrame.setExtendedState(oldWindowState);
			} else {
				// otherwise calculate
				newFrame.pack();
				// center on screen since setLocationByPlatform seems tweeky on
				// Win98
				newFrame.setLocationRelativeTo(null);
				// frame.setLocationByPlatform(true);

				// resize window so that it fits on screen
				Rectangle maxWindowBounds = GraphicsEnvironment
					.getLocalGraphicsEnvironment().getMaximumWindowBounds();
				newFrame.setBounds(maxWindowBounds.intersection(newFrame
					.getBounds()));
			}
		}
		boolean wasVisible = false;
		// dispose of old window if we have one
		if (frame != null) {
			// save old windows bounds if it is not fullscreen
			// so that when we exit full screen we can pick it back up
			if (!wasFullScreen) {
				oldWindowBounds = frame.getBounds();
				oldWindowState = frame.getExtendedState();
			}
			wasVisible = frame.isVisible();
			frame.removeWindowListener(windowListener);
			frame.setMenuBar(null);
			//frame.setContentPane(null);
			frame.setVisible(false);
			frame.dispose();
		}

		// show new window
		if (lFullScreen) {
			// this shows the frame selected
			GraphicsEnvironment.getLocalGraphicsEnvironment()
				.getDefaultScreenDevice().setFullScreenWindow(newFrame);
		} else if (wasFullScreen && frame != null) {
			GraphicsEnvironment.getLocalGraphicsEnvironment()
				.getDefaultScreenDevice().setFullScreenWindow(null);
			newFrame.setVisible(true);
		} else {
			newFrame.setVisible(wasVisible);
		}

		// update frame
		wasFullScreen = lFullScreen;
		frame = newFrame;
	}
}