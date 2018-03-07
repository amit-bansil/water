/*
 * CREATED ON:    Aug 1, 2005 12:07:05 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.simulation.graphics;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.Shape;
import java.awt.AlphaComposite;
import java.awt.geom.AffineTransform;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Line2D;
import java.awt.geom.Rectangle2D;
import java.util.Stack;

/**
 * wrapper around graphics 2d. for single threaded rescalable graphics. usually
 * created at the start of paint and disposed at the end.<br>
 * ID: $Id$
 */
//@SuppressWarnings({"ClassWithTooManyMethods"})
public class GraphicsEx {
	private final Graphics2D g2d;
	public GraphicsEx(Graphics g) {
		g2d = (Graphics2D)g.create();
		//antialias everything, big hit 
		g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_ON);
		//fractional font metrics, small hit
		g2d.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS,
			RenderingHints.VALUE_FRACTIONALMETRICS_ON);
		g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
			RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL,
			RenderingHints.VALUE_STROKE_PURE);
		g2d.setRenderingHint(RenderingHints.KEY_STROKE_CONTROL,
			RenderingHints.VALUE_STROKE_PURE);
        setAlpha(1.0f);
    }
	public final void dispose() {
		g2d.dispose();
	}
	// ------------------------------------------------------------------------
	// transform
	
	private final Stack<AffineTransform> transforms = new Stack<AffineTransform>();
    //s=length of side of new view, (x0,y0) is the origin
    //so drawing at (0,0) paints (x0,y0) & drawing at (1,0) paints (s+x0,y0)
    //in the previous coords
    public final void pushTransform(double x0, double y0, double s) {
		AffineTransform t=AffineTransform.getScaleInstance(s,s);
		t.translate(x0,y0);
		pushTransform(t);
	}

    public final void pushTransform(AffineTransform transform) {
		transforms.push(g2d.getTransform());
		g2d.transform(transform);
	}

	public final void popTransform() {
		g2d.setTransform(transforms.pop());
	}

	// ------------------------------------------------------------------------
	// stroke weight
	
	private float currentWeight=-1.0f;
	public void setStrokeWeight(float w) {
		if(w<=0)throw new IllegalArgumentException("weight '"+w+"' <=0");
        //noinspection FloatingPointEquality
        if(currentWeight==w)return;
		currentWeight=w;
		
		g2d.setStroke(new BasicStroke(w/ 250.0f));
	}
	public void setThinStroke() {
		setStrokeWeight(1.0f);
	}
	public void setThickStroke() {
		setStrokeWeight(10.0f);
	}
	public void setExThickStroke() {
		setStrokeWeight(10.0f);
	}
	
	// ------------------------------------------------------------------------
	// color
	
	//OPTIMIZE cache objects, no change most of the time
	public void setColor(Color c) {
		g2d.setColor(c);
	}
    private Color backgroundColor=Color.WHITE;

    public Color getBackgroundColor() {
        return backgroundColor;
    }

    public void setBackgroundColor(Color backgroundColor) {
        this.backgroundColor = backgroundColor;
    }

    public Color getForegroundColor() {
        return foregroundColor;
    }

    public void setForegroundColor(Color foregroundColor) {
        this.foregroundColor = foregroundColor;
    }

    private Color foregroundColor=Color.BLUE.darker();

    public void setColorBackground() {
		g2d.setColor(backgroundColor);
	}
	public void setColorForeground() {
		g2d.setColor(foregroundColor);
	}
	public void setColor(float intensity) {
		setColor(Calibrator.getInstance().toColor(intensity));
	}
    private float currentAlpha=Float.NaN;
    public void setAlpha(float alpha){
        if(currentAlpha==alpha)return;
        currentAlpha=alpha;
        g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER,alpha));
    }
    // ------------------------------------------------------------------------
	//line
	private final Line2D line=new Line2D.Float();
	public void drawLineSeg(float x0,float y0,float x1,float y1) {
		line.setLine(x0,y1,x1,y1);
		draw(line);
	}
	//rect
	private final Rectangle2D rect=new Rectangle2D.Float();
	public void drawRect(float x,float y,float w,float h) {
		rect.setRect(x,y,w,h);
		draw(rect);
	}
	public void drawSquare(float cx,float cy,float s) {
		float s2=s/2;
		rect.setRect(cx-s2,cy-s2,s,s);
		draw(rect);
	}
	//circle
	private final Ellipse2D ellipse=new Ellipse2D.Float();
	public void drawCircle(float cx,float cy,float r) {
		ellipse.setFrameFromCenter(cx,cy,cx-r,cy-r);
		draw(ellipse);
	}
	public void drawEllipse(float x0,float y0,float s) {
		drawEllipse(x0,y0,s,s);
	}
	public void drawEllipse(float x0,float y0,float w,float h) {
		ellipse.setFrame(x0,y0,w,h);
		draw(ellipse);
	}
	//draw
	private boolean fill=true;
	public void drawFilled() {
		fill=true;
	}
	public void drawStroked() {
		fill=false;
	}
	public void draw(Shape s) {
		if(fill) g2d.fill(s); 
		else g2d.draw(s);
		
	}
}
