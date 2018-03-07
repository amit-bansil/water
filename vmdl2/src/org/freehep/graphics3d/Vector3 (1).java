package org.freehep.graphics3d;

/**
 * Keeps a 3 dimensional vector.
 * <p>
 * Original ArcBall C code from Ken Shoemake, Graphics Gems IV, 1993.
 *
 * @author Mark Donszelmann
 * @version $Id: Vector3.java,v 1.2 2002/06/12 23:15:15 duns Exp $
 */

public class Vector3 {

    public double x, y, z;

    /**
     * creates vector from x,y,z
     */
    public Vector3(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
    }

    /**
     * creates null vector
     */
    public Vector3() {
        this(0,0,0);
    }

    /**
     * creates vector from v
     */
    public Vector3(Vector3 v) {
        this(v.x, v.y, v.z);
    }

    /**
     * @return string representation of vector
     */
    public String toString() {
        return "["+x+", "+y+", "+z+"]";
    }

    /**
     * @return length
     */
    public double length() {
        return Math.sqrt(x*x + y*y + z*z);
    }

    /**
     * @return normal vector , or null if length is 0
     */
    public Vector3 normalize(Vector3 r) {
        if (r == null) r = new Vector3();
        double vlen = length();
        if (vlen != 0.0) {
    	    return r.set(x/vlen, y/vlen, z/vlen);
        }
        return null;
    }

    /**
     * @return vector scaled by s
     */
    public Vector3 scale(double s, Vector3 r) {
        if (r == null) r = new Vector3();
        return r.set(s*x, s*y, s*z);
    }

    /**
     * @return difference between vector and s
     */
    public Vector3 sub(Vector3 s, Vector3 r) {
        if (r == null) r = new Vector3();
        return r.set(x - s.x, y - s.y, z - s.z);
    }

    /**
     * @return sum of vector and v
     */
    public Vector3 add(Vector3 v, Vector3 r) {
        if (r == null) r = new Vector3();
        return r.set(x + v.x, y + v.y, z + v.z);
    }

    /**
     * @return the negation of vector
     */
    public Vector3 negate(Vector3 r) {
        if (r == null) r = new Vector3();
        return r.set(-x, -y, -z);
    }

    /**
     * @return dot product of vector and v
     */
    public double dot(Vector3 v) {
        return x*v.x + y*v.y + z*v.z;
    }


    /**
     * @return cross produc of vector x v
     */
    public Vector3 cross(Vector3 v, Vector3 r) {
        if (r == null) r = new Vector3();
        return r.set(y*v.z-z*v.y, z*v.x-x*v.z, x*v.y-y*v.x);
    }

    /**
     * @return half arc between vector and v
     */
    public Vector3 bisect(Vector3 v, Vector3 r) {
        if (r == null) r = new Vector3();
        add(v, r);
        double length = r.length();
        return (length < 1.0e-7) ? r.set(0, 0, 1) : r.scale(1/length, r);
    }

    /**
     * @return the vector set to x,y,z
     */
    public Vector3 set(double x, double y, double z) {
        this.x = x;
        this.y = y;
        this.z = z;
        return this;
    }
}
