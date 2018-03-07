/*
 * SplashScreen.java
 * CREATED:    Jan 8, 2005 8:12:23 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.components;

import javax.swing.BorderFactory;
import javax.swing.Icon;
import javax.swing.JLabel;
import javax.swing.JWindow;
import javax.swing.SwingUtilities;

import java.awt.Color;
import java.awt.Graphics;

/**
 * a splashscreen is a window that shows an image in the center of the screen.
 * 
 * to ensure the splashscreen is show the startup runnable is executed after the screen is painted.
 * OPTIMIZE don't use swing,direct from app desc&show version etc. on bottom
 * @version 1.0
 * @author Amit Bansil
 */
public class SplashScreen {
	private final JWindow window;
	private boolean started=false;
	public SplashScreen(Icon image,final Runnable startup) {
		window = new JWindow();
		JLabel l=new JLabel(image) {
			@Override
			public void paint(Graphics g) {
				super.paint(g);
				if (!started) {
					//only start application once :)
					started = true;
					SwingUtilities.invokeLater(startup);
					
				}
			}
		};
		l.setBorder(BorderFactory.createLineBorder(Color.lightGray,1));
		window.setContentPane(l);
		window.pack();
		
		//center on screen
		window.setLocationRelativeTo(null);		
		window.setAlwaysOnTop(true);
		window.setVisible(true);
	}

	public final void close() {
		window.dispose();
	}
}
