package org.freehep.graphics3d;

/**
 * Keeps a quaternion.
 * <p>
 * Original ArcBall C code from Ken Shoemake, Graphics Gems IV, 1993.
 *
 * @author Mark Donszelmann
 * @version $Id: Quaternion.java,v 1.2 2002/06/12 23:15:15 duns Exp $
 */

public class Quaternion {

    public double x, y, z, w;

    /**
     * creates a quaternion from x,y,z,w
     */
    public Quaternion(double x, double y, double z, double w) {
        set(x,y,z,w);
    }

    /**
     * creates a null quaternion
     */
    public Quaternion() {
        set(0,0,0,0);
    }

    /**
     * creates a new quaternion from q
     */
    public Quaternion(Quaternion q) {
        set(q.x, q.y, q.z, q.w);
    }

    /**
     * @return a string representation of quaternion
     */
    public String toString() {
        return "["+x+", "+y+", "+z+", "+w+"]";
    }

/* old code
    public void copyInto(Quaternion q) {
        q.x = x;
        q.y = y;
        q.z = z;
        q.w = w;
    }
*/

    /**
     * @return length of quaternion
     */
    public double length() {
        return Math.sqrt(x*x + y*y + z*z + w*w);
    }

    /**
     * @return normalized form of quaternion, or null if length is 0;
     */
    public Quaternion normalize(Quaternion r) {
        if (r == null) r = new Quaternion();
        double f = length();
        if (f == 0.0) {
            r = null;
        } else {
            r.set(x/f, y/f, z/f, w/f);
        }
        return r;
    }


    /**
     * Construct rotation matrix from (possibly non-unit) quaternion.
     * Assumes matrix is used to multiply column vector on the left:
     * vnew = mat vold.  Works correctly for right-handed coordinate system
     * and right-handed rotations.
     */
    Matrix4 toMatrix(Matrix4 m) {
        if (m == null) m = new Matrix4();
        double Nq = x*x + y*y + z*z + w*w;
        double s = (Nq > 0.0) ? (2.0 / Nq) : 0.0;
        double xs = x*s,	      ys = y*s,	      zs = z*s;
        double wx = w*xs,	      wy = w*ys,	  wz = w*zs;
        double xx = x*xs,	      xy = x*ys,	  xz = x*zs;
        double yy = y*ys,	      yz = y*zs,	  zz = z*zs;
        return m.set(
            1.0 - (yy + zz),    xy - wz,            xz + wy,            0.0,
            xy + wz,            1.0 - (xx + zz),    yz - wx,            0.0,
            xz - wy,            yz + wx,            1.0 - (xx + yy),    0.0,
            0.0,                0.0,                0.0,                1.0
        );
    }

    /**
     * @return quaternion product (this * q).  Note: order is important!
     * To combine rotations, use the product this.multiply(q),
     * which gives the effect of rotating by this then q.
     */
    public Quaternion multiply(Quaternion q, Quaternion r) {
        if (r == null) r = new Quaternion();
        return r.set(
            w*q.x + x*q.w + y*q.z - z*q.y,
            w*q.y + y*q.w + z*q.x - x*q.z,
            w*q.z + z*q.w + x*q.y - y*q.x,
            w*q.w - x*q.x - y*q.y - z*q.z
        );
    }

    /**
     * @return conjugate of quaternion.
     */
    public Quaternion conjugate(Quaternion r) {
        if (r == null) r = new Quaternion();
        return r.set(-x, -y, -z, w);
    }

    /**
     * @return the quaternion set to x,y,z,w
     */
    public Quaternion set(double x, double y, double z, double w) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.w = w;
        return this;
    }

    /**
     * @return the quaternion set to q
     */
    public Quaternion set(Quaternion q) {
        this.x = q.x;
        this.y = q.y;
        this.z = q.z;
        this.w = q.w;
        return this;
    }
}
