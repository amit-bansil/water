package org.cps.umd.display;

import java.awt.AWTException;
import java.awt.Canvas;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.GraphicsConfiguration;
import java.awt.Image;
import java.awt.ImageCapabilities;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;

/**
 * <p>
 * Title: Universal Molecular Dynamics
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2001
 * </p>
 * <p>
 * Company: Boston University
 * </p>
 * 
 * @author Amit Bansil
 * @version 0.0a
 */

public class OffScreenCanvas extends Canvas {
	private Image backbuffer;

	private Graphics backGraphics;

	private int curWidth, curHeight;

	private boolean needsResize, needsRedraw;

	public OffScreenCanvas() {
		backbuffer = null;
		needsResize = true;
		needsRedraw = true;

		addComponentListener(new ComponentAdapter() {
			public void componentResized(ComponentEvent e) {
				needsResize = true;
			}
		});
	}

	public void update(final Graphics g) {
		paint(g);
	}

	public void paint(final Graphics g) {
		final Dimension size = getSize();
		if (backbuffer != null) {
			g.drawImage(backbuffer, (size.width - curWidth) / 2,
					(size.height - curHeight) / 2, curWidth, curHeight, null);
		} else {
			g.setColor(getBackground());
			g.fillRect(0, 0, size.width, size.height);
		}
	}

	public void doRepaint() {
//System.err.println("redrawn");
		Graphics g = getGraphics();
		paint(g);
		//repaint();
		g.dispose();
	}

	public boolean resizeOffscreen() {
		final int width = getSize().width, height = getSize().height;
		needsResize = false;
		needsRedraw = true;
		if (backbuffer != null) {
			backbuffer.flush();
			backGraphics.dispose();
		}
		backbuffer = null;
		curWidth = width;
		curHeight = height;
		try {
			GraphicsConfiguration g=getGraphicsConfiguration();
			backbuffer = g.createCompatibleVolatileImage(width, height,
							new ImageCapabilities(true));
			//not avail in 1.1 so just
			//	backbuffer=createImage(width,height);
		} catch (AWTException e) {
			throw new Error(e);
		}
		backGraphics = backbuffer.getGraphics();
		return true;
	}

	public Graphics getOffGraphics() {
		return backGraphics;
	}

	public boolean needsRedraw() {
		return needsRedraw;
	}

	public boolean isDrawable() {
		return isVisible();
	}

	public void noteRedrawn() {
		needsRedraw = false;
	}

	public boolean needsResize() {
		return needsResize;
	}

	public void finish() {
		if (backbuffer == null) return;
		backbuffer.flush();
		backbuffer = null;
		backGraphics.dispose();
		needsResize = true;
		needsRedraw = true;
		repaint();
	}
}