package cps.jarch.simulation.graphics;

import java.awt.geom.Dimension2D;
import java.awt.geom.Point2D;
import java.io.Serializable;

/**
 * immutable Point2d.Double.
 * 
 * @author Amit Bansil
 * @version $Id: VectorFinal.java 522 2005-08-30 19:54:47Z bansil $.
 */
public class VectorFinal implements Serializable{
    private final double x,y;

    public final double getX(){
        return x;
    }
    public final double getY(){
        return y;
    }
    public final Point2D toPoint(Point2D dst){
        dst.setLocation(x,y);
        return dst;
    }
    public final Dimension2D toDimension(Dimension2D dst){
        dst.setSize(x,y);
        return dst;
    }


    public VectorFinal(double x, double y) {
        this.x = x;
        this.y = y;
    }
}
