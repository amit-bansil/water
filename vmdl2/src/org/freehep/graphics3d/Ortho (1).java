package org.freehep.graphics3d;

/**
 * @author Mark Donszelmann
 * @version $Id: Ortho.java,v 1.1 2000/11/17 15:43:56 duns Exp $
 */

public class Ortho {
    
    public double left, right;
    public double top, bottom;
    public double near, far;
    
    public Ortho(double left, double right, double bottom, double top, double near, double far) {
        this.left = left;
        this.right = right;
        this.bottom = bottom;
        this.top = top;
        this.near = near;
        this.far = far;
    }
    
    public String toString() {
        return "["+left+", "+right+"]["+bottom+", "+top+"]["+near+", "+far+"]";
    }
}
