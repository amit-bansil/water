/*
 * ProgressScreen.java CREATED: Jan 5, 2004 3:18:31 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.util.progress;

import java.awt.Dimension;
import java.awt.EventQueue;
import java.awt.Frame;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Window;
import java.awt.image.ImageObserver;

/**
 * TODO actual progress stuff sets itself as default progress handler for
 * everything, and shows an image+progress bar. minimal dependencies for speed
 * TODO put this imageloading code into ImageLoader TODO single thread??
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ProgressScreen {
	final Frame parent;

	boolean loaded = false;

	final Image image;

	final Window window;

	final String imageName;

	Object lock = new Object();

	private final ImageObserver observer = new ImageObserver() {
		public boolean imageUpdate(Image img, int infoflags, int x, int y,
				final int width, final int height) {
			if (img != image) throw new UnknownError();
			if ((infoflags & ALLBITS) != 0) {
				EventQueue.invokeLater(new Runnable() {
					public void run() {
						window.setSize(new Dimension(width, height));
						Dimension ssize = window.getToolkit().getScreenSize();
						window.setLocation(ssize.width / 2 - width / 2,
								ssize.height / 2 - height / 2);

						synchronized (lock) {
							loaded = true;
							window.setVisible(true);
							window.toFront();
							lock.notify();
						}
					}
				});
				return false;
			} else if ((infoflags & ERROR) != 0) {
				throw new Error("could not load image:" + imageName);

			} else
				return true;
		}

	};

	public ProgressScreen(String imageFile) {
		this.imageName = imageFile;
		window = new Window(parent = new Frame()) {
			public void update(Graphics g) {
				paint(g);
			}

			public void paint(Graphics g) {
				if (loaded) g.drawImage(image, 0, 0, this);

			}
		};
		image = window.getToolkit().getImage(
				ClassLoader.getSystemResource(imageFile));
		window.getToolkit().prepareImage(image, -1, -1, observer);
		synchronized (lock) {
			while (!loaded)
				try {
					lock.wait();
				} catch (InterruptedException e) {
					//should not happen
					throw new Error(e);
				}
		}

	}

	public final void done() {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				parent.dispose();
				window.setVisible(false);
				window.dispose();
			}
		});
	}
}