// Copyright 2000, CERN, Geneva, Switzerland and SLAC, Stanford, U.S.A.
package org.freehep.graphics3d;

import java.io.*;
import java.util.*;

/**
 * Taken from Graphics Gems (page 476 and 770).
 *
 * @author Mark Donszelmann
 * @version $Id: Transform3D.java,v 1.5 2002/06/12 23:15:15 duns Exp $
 */

public class Transform3D implements Serializable {

    protected Stack transforms;
    protected Matrix4 m;
    protected boolean valid;

    private Matrix4 translation = Matrix4.identity();
    private Matrix4 rotation = new Matrix4();
    private Matrix4 ortho = new Matrix4();
    private Matrix4 frustum = new Matrix4();
    public Transform3D() {
        transforms = new Stack();
        m = Matrix4.identity();
        valid = false;
    }

    /**
     * Pushes a copy of this transform on the stack.
     */
    public void push() {
        transforms.push(new Matrix4(m));
    }

    /**
     * Pops the top transform off the stack.
     */
    public void pop() {
        m = (Matrix4)transforms.pop();
        valid = false;
    }

    /**
     * Applies matrix transform and viewport functions.
     * <PRE>
     *      xw = (xn + 1) * width / 2 + x0;
     *      yw = height - (yn + 1) * height / 2 + y0;
     * </PRE>
     * @return transformed point into int[2] using viewport parameters
     */
    public double[] get(double x, double y, double z, double x0, double y0, double width, double height, double[] result) {
        if (result == null) {
           result = new double[2];
        }
        result[0] = (m.m00*x + m.m01*y + m.m02*z + m.m03+1)*(width/2.0) + x0;
        result[1] = height - (m.m10*x + m.m11*y + m.m12*z + m.m13+1)*(height/2.0) + y0;
        return result;
    }

    /**
     * Applies matrix transform and viewport functions.
     * <PRE>
     *      xw = (xn + 1) * width / 2 + x0;
     *      yw = height - (yn + 1) * height / 2 + y0;
     * </PRE>
     * @return transformed Polyline3 into int[2][n] using viewport parameters
     */
   /* public int[][] get(Polyline3 poly, int x0, int y0, int width, int height, int[][] result) {
        if (result == null) {
           result = new int[2][poly.size()];
        }
        double xi, yi, zi;
        Vector3 p;
        int i = poly.size();
        while (i>0) {
            i--;
            p = poly.p[i];
            xi = p.x;
            yi = p.y;
            zi = p.z;
            result[0][i] = (int)((m.m00*xi + m.m01*yi + m.m02*zi + m.m03+1)*(width >> 1)) + x0;
            result[1][i] = height - (int)((m.m10*xi + m.m11*yi + m.m12*zi + m.m13+1)*(height >> 1)) + y0;
        }
        return result;
    }*/

    /**
     * Transforms Polyline3 into double array.
     *
     * @return transformed Polyline3 into double[3][n]
     */
  /*  public double[][] get(Polyline3 poly, double[][] result) {
        if (result == null) {
           result = new double[3][poly.size()];
        }
        double xi, yi, zi;
        Vector3 p;
        int i=poly.size();
        while (i>0) {
            i--;
            p = poly.p[i];
            xi = p.x;
            yi = p.y;
            zi = p.z;
            result[0][i] = m.m00*xi + m.m01*yi + m.m02*zi + m.m03;
            result[1][i] = m.m10*xi + m.m11*yi + m.m12*zi + m.m13;
            result[2][i] = m.m20*xi + m.m21*yi + m.m22*zi + m.m23;
        }
        return result;
    }*/


    /**
     * Transforms array of points into double array.
     *
     * @return transformed array of points in double[3][n]
     */
    public double[][] get(double[] x, double[] y, double[] z, double[][] result) {
        if (result == null) {
           result = new double[3][x.length];
        }
        double xi, yi, zi;
        int i=x.length-1;
        while (i>0) {
            i--;
            xi = x[i];
            yi = y[i];
            zi = z[i];
            result[0][i] = m.m00*xi + m.m01*yi + m.m02*zi + m.m03;
            result[1][i] = m.m10*xi + m.m11*yi + m.m12*zi + m.m13;
            result[2][i] = m.m20*xi + m.m21*yi + m.m22*zi + m.m23;
        }
        return result;
    }

    /**
     * Transforms piont into double array.
     *
     * @return transformed point in double[3]
     */
    public double[] get(double x, double y, double z, double[] result) {
        if (result == null) {
            result = new double[3];
        }
        result[0] = m.m00*x + m.m01*y + m.m02*z + m.m03;
        result[1] = m.m10*x + m.m11*y + m.m12*z + m.m13;
        result[2] = m.m20*x + m.m21*y + m.m22*z + m.m23;
        return result;
    }
	public void get(float x, float y, float z, int[] result) {
		result[2] =(int)( m.m20*x + m.m21*y + m.m22*z + m.m23);
		result[0] =(int)( m.m00*x + m.m01*y + m.m02*z + m.m03);
		result[1] =(int)( m.m10*x + m.m11*y + m.m12*z + m.m13);
	}
	/**
	 * Return U coordinate.
     *
     * @return U coordinate after transformation
     */
    public double getU(double x, double y, double z) {
        return m.m00*x + m.m01*y + m.m02*z + m.m03;
    }

    /**
     * Return V coordinate.
     *
     * @return V coordinate after transformation
     */
    public double getV(double x, double y, double z) {
        return m.m10*x + m.m11*y + m.m12*z + m.m13;
    }

    /**
     * Return W coordinate.
     *
     * @return W coordinate after transformation
     */
    public double getW(double x, double y, double z) {
        return m.m20*x + m.m21*y + m.m22*z + m.m23;
    }

    /**
     * Scales non-uniformly along the x, y and z-axes.
     *
     * The current transform matrix M is multiplied by:
     * <pre>
     *      m00 m01 m02 m03       sx  0   0   0
     *      m10 m11 m12 m13       0   sy  0   0
     *      m20 m21 m22 m23       0   0   sz  0
     *      m30 m31 m32 m33       0   0   0   1
     * </pre>
     */
    public void scale(double sx, double sy, double sz) {
        m.m00 = sx*m.m00;
        m.m01 = sy*m.m01;
        m.m02 = sz*m.m02;
        m.m10 = sx*m.m10;
        m.m11 = sy*m.m11;
        m.m12 = sz*m.m12;
        m.m20 = sx*m.m20;
        m.m21 = sy*m.m21;
        m.m22 = sz*m.m22;
        m.m30 = sx*m.m30;
        m.m31 = sy*m.m31;
        m.m32 = sz*m.m32;

        valid = false;
    }

    /**
     * Translates the current transform.
     *
     * The current transform matrix M is multiplied by:
     * <pre>
     *      m00 m01 m02 m03         1   0   0   tx
     *      m10 m11 m12 m13         0   1   0   ty
     *      m20 m21 m22 m23         0   0   1   tz
     *      m30 m31 m32 m33         0   0   0   1
     * </pre>
     */
    public void translate(double tx, double ty, double tz) {
        translation.set(
            1.0, 0.0, 0.0, tx,
            0.0, 1.0, 0.0, ty,
            0.0, 0.0, 1.0, tz,
            0.0, 0.0, 0.0, 1.0
        );
        m.multiply(translation, m);

        valid = false;
    }
/*
    public void perspectiveZ(double d) {
        double f = -1.0/d;
        m.m03 = m.m03 + m.m02*f;
        m.m02 = 0;
        m.m13 = m.m13 + m.m12*f;
        m.m12 = 0;
        m.m23 = m.m23 + m.m22*f;
        m.m22 = 0;
        m.m33 = m.m33 + m.m32*f;
        m.m32 = 0;

        valid = false;
    }
*/

    /**
     * Rotates over unit vector ux,uy,uz by angle theta (in radiants).
     *
     * The current Matrix M is multiplied by:
     * <pre>
     *      m00 m01 m02 m03         x^2(1-c) + c    xy(1-c) - zs    xz(1-c) + ys    0
     *      m10 m11 m12 m13         yx(1-c) + zs    y^2(1-c) + c    yz(1-c) - xs    0
     *      m20 m21 m22 m23         xz(1-c) - ys    yz(1-c) + xs    z^2(1-c) + c    0
     *      m30 m31 m32 m33         0               0               0               1
     * </pre>
     * where c = cos(theta), s = sin(theta) and ||(ux,uy,uz)|| = 1.
     */
    public void rotate(double ux, double uy, double uz, double theta) {
        double c = Math.cos(theta);
        double s = Math.sin(theta);
        double t = 1.0 - c;
        double d = Math.sqrt(ux*ux + uy*uy + uz*uz);
        double x = ux / d;
        double y = uy / d;
        double z = uz / d;

        rotation.set(
            x*x*t + c,     x*y*t - z*s,    x*z*t + y*s,    0.0,
            y*x*t + z*s,   y*y*t + c,      y*z*t - x*s,    0.0,
            x*z*t - y*s,   y*z*t + x*s,    z*z*t + c,      0.0,
            0.0,           0.0,            0.0,            1.0
        );
        m.multiply(rotation, m);

        valid = false;
    }

    /**
     * Creates a parallel projection.
     *
     * The current Matrix M is multiplied by:
     * <pre>
     *      m00 m01 m02 m03         2/(right-left)  0               0               -(right+left)/(right-left)
     *      m10 m11 m12 m13         0               2/(top-bottom)  0               -(top+bottom)/(top-bottom)
     *      m20 m21 m22 m23         0               0               -2/(far-near)   -(far+near)/(far-near)
     *      m30 m31 m32 m33         0               0               0               1
     * </pre>
     * where if denominators are 0 for scaling factors, the scale factor defaults to 1, and
     * if denominators are 0 for translation factors, the translation factor defaults to 0.
     */
    public void ortho(double left, double right, double bottom, double top, double near, double far) {
        double sx = (right - left != 0.0) ?  2.0 / (right - left) : 1;
        double sy = (top - bottom != 0.0) ?  2.0 / (top - bottom) : 1;
        double sz = (far - near   != 0.0) ? -2.0 / (far - near)   : -1;
        double tx = (right - left != 0.0) ? -(right+left)/(right-left) : 0;
        double ty = (top - bottom != 0.0) ? -(top+bottom)/(top-bottom) : 0;
        double tz = (far - near   != 0.0) ? -(far+near)/(far-near) : 0;
        ortho.set(
            sx,   0.0,  0.0,  tx,
            0.0,  sy,   0.0,  ty,
            0.0,  0.0,  sz,   tz,
            0.0,  0.0,  0.0,  1.0
        );
        m.multiply(ortho, m);

        valid = false;
    }

    /**
     * Creates a perspective projection.
     *
     * The current Matrix M is multiplied by:
     * <pre>
     *      m00 m01 m02 m03    2*near/(right-left) 0                   (right+left)/(right-left)  0
     *      m10 m11 m12 m13    0                   2*near/(top-bottom) (top+bottom)/(top-bottom)  0
     *      m20 m21 m22 m23    0                   0                   -(far+near)/(far-near)     -2*far*near/(far-near)
     *      m30 m31 m32 m33    0                   0                   -1                         0
     * </pre>
     * where if denominators are 0 for scaling factors, the scale factor defaults to 1, and
     * if denominators are 0 for translation factors, the translation factor defaults to 0.
     */
    public void frustum(double left, double right, double bottom, double top, double near, double far) {
        if (left == right) {
            throw new IllegalArgumentException("Frustum: left and right are equal: "+left);
        }
        if (bottom == top) {
            throw new IllegalArgumentException("Frustum: bottom and top are equal: "+bottom);
        }
        if (near < 0.0) {
            throw new IllegalArgumentException("Frustum: near must be a positive distance: "+near);
        }
        if (far < 0.0) {
            throw new IllegalArgumentException("Frustum: far must be a positive distance: "+far);
        }
        double sx = (2.0 * near) / (right - left);
        double sy = (2.0 * near) / (top - bottom);
        double c = (far - near != 0.0) ? - (far+near) / (far-near)  : 0;
        double a = (right+left)/(right-left);
        double b = (top+bottom)/(top-bottom);
        double d = (far - near != 0.0) ? -(2*far*near)/(far-near) : 0;
        frustum.set(
            sx,   0.0,  a,    0.0,
            0.0,  sy,   b,    0.0,
            0.0,  0.0,  c,    d,
            0.0,  0.0,  -1.0, 0.0
        );
        m.multiply(frustum, m);

        valid = false;
    }

    private Matrix4 multiply = new Matrix4();

    /**
     * Multiply transform matrix by matrix.
     */
    public void multiply(Matrix4 matrix) {
        matrix.transpose(multiply);
        m.multiply(multiply, m);
        valid = false;
    }

    /**
     * Set transform matrix to matrix.
     */
    public void setMatrix(Matrix4 matrix) {
        m.m00 = matrix.m00; m.m01 = matrix.m01; m.m02 = matrix.m02; m.m03 = matrix.m03;
        m.m10 = matrix.m10; m.m11 = matrix.m11; m.m12 = matrix.m12; m.m13 = matrix.m13;
        m.m20 = matrix.m20; m.m21 = matrix.m21; m.m22 = matrix.m22; m.m23 = matrix.m23;
        m.m30 = matrix.m30; m.m31 = matrix.m31; m.m32 = matrix.m32; m.m33 = matrix.m33;

        valid = false;
    }

    /**
     * Returns current transform.
     *
     * @return current transform matrix
     */
    public Matrix4 getMatrix() {
        return m;
    }

    /**
     * @return true if current transform is equals to object
     */
    public boolean equals(Object object) {
        return m.equals(object);
    }

    /**
     * @return hashcode for current transform
     */
    public int hashCode() {
        return m.hashCode();
    }

    /**
     * @return string representation for this transform
     */
    public String toString() {
        return m.toString();
    }

    private double nx, ny, nz;
    private double theta;

    /**
     * Validates the current transform and extracts its parameters.
     * <p>
     * Taken from Graphics Gems II (page 466)
     */
    protected void validate() {
        // Now calculate the rotation around vector and angle
        theta = Math.acos((m.m00 + m.m11 + m.m22 - 1.0)/2.0);
        double sint2 = 2*Math.sin(theta);
        if (sint2 != 0.0) {
            nx = (m.m12 - m.m21) / sint2;
            ny = (m.m20 - m.m02) / sint2;
            nz = (m.m01 - m.m10) / sint2;
        } else {
            nx = 0;
            ny = 0;
            nz = 0;
        }

        valid = true;
    }

}
