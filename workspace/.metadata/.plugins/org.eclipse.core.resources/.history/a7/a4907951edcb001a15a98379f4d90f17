/*
 * CREATED ON:    Aug 1, 2005 12:31:21 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.simulation.graphics;

import cps.jarch.gui.util.ComponentProxy;

import javax.swing.JComponent;
import javax.swing.JPanel;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Insets;
import java.awt.Rectangle;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;

/**
 * a drawing surface that <br>
 * ID: $Id$
 */
public abstract class JCanvas implements ComponentProxy {
    public JCanvas() {
        c = new JPanel() {
            private final Rectangle2D tempBounds=new Rectangle2D.Double();
            private final Insets tempInsets=new Insets(0,0,0,0);
            @Override
            protected void paintComponent(Graphics g) {
                tempBounds.setRect(0,0,c.getWidth(),c.getHeight());
                c.getInsets(tempInsets);
                shrinkRectangle(tempBounds,tempInsets);
                // OPTIMIZE don't paint when not showing?
                doPaint(g,tempBounds,false);
            }
        };

        setSize(100, 100);
        setAspectRange(0,Float.MAX_VALUE);
    }

    private final JComponent c;

    public final JComponent getComponent() {
        return c;
    }
    //TODO integrate with MouseHandler, GraphicsConfiguration,
    //& a new <T extends Geometry> object,
    //which is a cache of what is going to be rendered/moused at a particular size.
    //private Dimension validatedSize;
    //TODO doc
    public final void requestRepaint() {
    	c.repaint();
    }
    //--------------------------------------------------------------------------
    //size

    // pref=min
    public void setSize(int minX, int minY) {
        setSize(minX, minX, minY, minY, Integer.MAX_VALUE, Integer.MAX_VALUE);
    }

    // max=unbounded
    public void setSize(int minX, int prefX, int maxX, int minY) {
        setSize(minX, prefX, maxX, minY, Integer.MAX_VALUE, Integer.MAX_VALUE);
    }

//    @SuppressWarnings({"MethodWithTooManyParameters"})
    public void setSize(int minX, int prefX, int maxX, int minY, int prefY,
                        int maxY) {
        c.setMinimumSize(new Dimension(minX, minY));
        c.setPreferredSize(new Dimension(prefX, prefY));
        c.setMaximumSize(new Dimension(maxX, maxY));
    }

    //--------------------------------------------------------------------------
    //aspect ratio, centering

    private float minAspect,maxAspect;

    public boolean isCenter() {
        return center;
    }

    public void setCenter(boolean center) {
        this.center = center;
    }

    public float getMaxAspect() {
        return maxAspect;
    }

    public void setAspectRange(float minAspect,float maxAspect) {
        if (minAspect > maxAspect)
            throw new IllegalArgumentException("invalid range");
        this.maxAspect = maxAspect;
        this.minAspect = minAspect;
    }

    public float getMinAspect() {
        return minAspect;
    }

    private boolean center;


    //round a rectangle to have integer coordinates
    public static final  void roundRect(Rectangle2D r){
        r.setRect(Math.round(r.getX()),Math.round(r.getY()),
                   Math.round(r.getWidth()),Math.round(r.getHeight()));
    }
    //shrink a rectangle to respect insets,used before calling do paint
    public static final void shrinkRectangle(Rectangle2D rect, Insets insets){
        GraphicsUtils.translate(rect,insets.left,insets.top);
        GraphicsUtils.expand(rect,
                             - (insets.left + insets.right),- (insets.top + insets.bottom));
    }

    //--------------------------------------------------------------------------
    //painting
    //paints g rescaling
    private void doPaint(Graphics g,Rectangle2D rect,boolean isExt) {
        // OPTIMIZE honor isOpaque flag and fill only insets/aspect shrink if true?
        //paint background-note we use entire clipping area, which may be larger or smaller
        //than what we acutally paint
        Rectangle clipRect=g.getClipBounds();
        g.setColor(c.getBackground());
        g.fillRect(clipRect.x,clipRect.y,clipRect.width,clipRect.height);

        GraphicsEx gex=new GraphicsEx(g);
        gex.setForegroundColor(c.getForeground());
        gex.setBackgroundColor(c.getBackground());

        GraphicsUtils.fixAspect(rect,minAspect,maxAspect,center);
        roundRect(rect);

        paint(gex,rect,isExt);

        gex.dispose();
    }
    /**
     * note that bounds are the bounds you should paint within, call g.getClipRect for the actual clipping
     * region, which may be larger.
     */
    public abstract void paint(GraphicsEx g, Rectangle2D bounds,boolean isExt);

    /**
     * paints bounds inside of img
     */
    public final void paintImage(BufferedImage img,Rectangle2D bounds){
        doPaint(img.getGraphics(),bounds,true);
    }
    public final void paintImage(BufferedImage img){
        paintImage(img,new Rectangle(0,0,img.getWidth(),img.getHeight()));
    }
}
