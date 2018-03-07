/*
 * CREATED: Jul 26, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.core.application.core;

import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.io.LocalVirtualFile;
import org.cps.framework.core.io.VirtualFile;

import javax.swing.ImageIcon;
import javax.swing.JWindow;
import javax.swing.SwingUtilities;

import java.awt.Graphics;
import java.awt.Image;
import java.io.File;

/**
 * builder to create applications. TODO MacOS X shell integration TODO
 * splash,progress screen
 */
public abstract class ApplicationBuilder {
	//splash screen stuff
	//call this ASAP (from static block in main class)
	private static JWindow splash;
	private static Image splashImage;
	//note that this resource is not looked up using the accessorloader...
	public static final void showSplashScreen(String splashImageResName) {
		if (splash != null)
				throw new IllegalStateException(
						"can't show splashscreen over existing");
		ImageIcon splashImageIcon = new ImageIcon(ClassLoader.getSystemResource(
				splashImageResName));
		
		splashImage = splashImageIcon.getImage();
		splash = new JWindow() {
			public void update(Graphics g) {
				print(g);
			}
			public void paint(Graphics g) {
				if (splash != null) g.drawImage(splashImage, 0, 0, splash);
			}
		};
		splash.setSize(splashImageIcon.getIconWidth(), splashImageIcon
				.getIconHeight());
		splash.setLocationRelativeTo(null);
		splash.setAlwaysOnTop(true);
		splash.setVisible(true);
	}
	//called automatically from cps
	private static final void killSplash() {
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				if (splash != null) {
					splash.setVisible(false);
					splash.dispose();
					splashImage.flush();
					splashImage = null;
					splash = null;
				}
			}
		});
	}
	
	//parses a url out of main args or returns null if main args is empty;
	//throws IllegalArgument if more than one parameter
	//TODO better error handling, should print proper usage to system.err or
	// such
	public static final File parseMainArgs(String[] args) {
		if (args == null || args.length == 0) return null;
		else if (args.length == 1) return new File(args[0]);
		else
			throw new IllegalArgumentException(
					"unexpected number of arguments:" + args.length);
	}

	public ApplicationBuilder() {
		this((VirtualFile) null);
	}

	//simple implementation that will load initial file after startup
	//or blank if null
	//DO NOT INITIALIZE COMPONENTS IN CONSTRUCTOR since _registerCompoents is
	//called asynchronously
	public ApplicationBuilder(final File initialFile) {
		this(initialFile != null ? new LocalVirtualFile(initialFile) : null);
	}

	public ApplicationBuilder(final VirtualFile initialFile) {
		final Object lock = Application.aquireLock();
		CPSQueue.getInstance().postRunnable(new Runnable() {
			public void run() {
				Application app = new Application(_createDescription(), lock);
				_registerComponents(app);
				app.startup();
				if (initialFile != null) app.getGUI().getDocumentActions()
						.loadDocument(initialFile);
				else
					app.getDocumentManager().loadBlankDocument();

				killSplash();
			}
		});
	}

	//all these are called from CPSThread

	//just create/get description
	protected abstract ApplicationDescription _createDescription();

	//init components here, register document data, add stuff to GUI
	protected abstract void _registerComponents(Application app);

}