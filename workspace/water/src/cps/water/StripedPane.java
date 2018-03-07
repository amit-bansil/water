/*
 * CREATED ON:    May 2, 2006 3:52:27 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water;

import cps.jarch.gui.resources.ImageLoader;

import javax.swing.JComponent;

import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Insets;
import java.awt.Paint;
import java.awt.TexturePaint;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;

/**
 * <p>TODO document StripedPane
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class StripedPane extends JComponent {
	private Paint stripedPaint;
	public StripedPane() {
		setOpaque(true);
		setDoubleBuffered(true);
	}
	@Override protected void paintComponent(Graphics g) {
		if (stripedPaint == null) {
			BufferedImage bi = ImageLoader.toBufferedImage(ControlFactory
				.loadIcon("stripes.gif"), this);
			stripedPaint = new TexturePaint(bi, new Rectangle2D.Float(0, 0,
				bi.getWidth(), bi.getHeight()));
		}
		//TODO move graphics context saving & insets application to a 'drawing' class
		//also see about unnessary repainting of backaground, opqueness etc.
		Graphics2D g2 = (Graphics2D) g;
		Paint oldPaint = g2.getPaint();
		g2.setPaint(stripedPaint);
		Insets insets = getInsets();
		Dimension size = getSize();
		g2.fillRect(insets.left, insets.top, size.width - (insets.left + insets.right),
			size.height - (insets.left + insets.right));
		g2.setPaint(oldPaint);
	}
}
