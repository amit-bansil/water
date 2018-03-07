/*
 * CREATED ON:    Jul 27, 2005 6:15:18 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.simulation.graphics;

import java.io.Serializable;

/**
 * an abstract mathematical line in 2space. straight vertical is allowed.
 * immutable.<br>
 * ID: $Id$
 */
//TODO implement readObject&writeObject
//@SuppressWarnings({"SerializableHasSerializationMethods", "serial"})
public class Line implements Serializable {
	private final double m, b; 
	/**
	 * @return line's slope, in (-infinity,+infinity]
	 */
	public final double getSlope() {
		return m;
	}
	/**
	 * @return line's y intercept unless isVertical, in whichcase b is x-intercept
	 */
	public final double getIntercept() {
		return b;
	}
	public final boolean isInterceptX() {
		return isVertical();
	}
	public final boolean isInterceptY() {
		return !isVertical();
	}
	public final boolean isVertical() {
		return m==Double.POSITIVE_INFINITY;
	}
	public final boolean isHorizontal() {
		return m==0;
	}
	/**
	 * @return line's xintecept, in (-infinity,+infinity)
	 * @throws IllegalStateException if isHorizontal
	 */
	public final double getXIntercept() {
		return getInverse().getYIntercept();
	}
	/**
	 * @return line's yintecept, in (-infinity,+infinity)
	 * @throws IllegalStateException if isVertical
	 */
	public final double getYIntercept() {
		if(isVertical())throw new IllegalStateException("vertical");
		else return b;
	}
	/**
	 * @return y=mx+b or Double.NaN if vertical
	 */
	public final double getY(double x) {
		if(isVertical())return Double.NaN;
		else return m*x+b;
	}
    public final double getX(double y){
		return getInverse().getX(y);
    }
    // ------------------------------------------------------------------------
	//comparison
	
	@Override
	public boolean equals(Object obj) {
        if(!(obj instanceof Line))return false;
        try {
			Line l = (Line) obj;
			if (l == this) return true;
			else return l.m==m&&l.b==b;
		} catch (ClassCastException e) {
			return false;
		}
	}

	@Override
	public int hashCode() {
		//inlined from Arrays.hashCode(double[])
		int result = 1;
		long bits;
		bits = Double.doubleToLongBits(m);
		result = 31 * result + (int) (bits ^ (bits >>> 32));
		bits = Double.doubleToLongBits(b);
		result = 31 * result + (int) (bits ^ (bits >>> 32));
		return result;
	}
	// ------------------------------------------------------------------------
	//creation

	public static final Line X_AXIS = new Line(0, 0);

	public static final Line Y_AXIS = new Line(Double.POSITIVE_INFINITY,0);

	public static final Line Y_EQUALS_X = new Line(0, 1);
	
	/**
	 * note that a slope of +infinity will be converted to -infinity.
	 * 
	 * @param m
	 *            slope, may be +- infinity
	 * @param b
	 *            y inercept, may be +- infinity
	 * @throws IllegalArgumentException
	 *             if m or b is NaN
	 * @throws IllegalArgumentException
	 *             if b is not finite
	 */
	private Line(double m, double b) {
		if (Double.isNaN(m)) throw new IllegalArgumentException("m is NaN");
		if (Double.isNaN(b)) throw new IllegalArgumentException("b is NaN");
		if (Double.isInfinite(b)) throw new IllegalArgumentException("b is not finite");
		if (m == Double.NEGATIVE_INFINITY) m = Double.POSITIVE_INFINITY;
		this.m = m;
		this.b = b;
	}
	//NOTE since inverse is consistent immutability & threadsaftey are maintained.
    private Line inverse=null;
    public Line getInverse() {
        if(inverse==null){
            if(isHorizontal()) {
                inverse= createVertical(b);
            }
            else if(isVertical()) {
                inverse= createHorizontal(b);
            }else {
                double im=1/m;
                double ib=(-b)*im;
                inverse= new Line(im,ib);
            }
        }
		return inverse;
	}
	public static Line createHorizontal(double yIntcept) {
		return new Line(0,yIntcept);
	}
	public static Line createVertical(double xIntecept) {
		return new Line(Double.POSITIVE_INFINITY,xIntecept);
	}
	/**
	 * create line from two points.
	 * @return null if points are not distinct
	 */
	public static Line create(double x0,double y0,double x1,double y1) {
		if(x0==x1) {
			//degenerate case
			if(y0==y1)return null;
			//vertical
			return createVertical(x0);
		}else {
			double m=(y1-y0)/(x1-x0);
			double b=y1-m*x1;
			return new Line(m,b);
		}
	}
	// ------------------------------------------------------------------------
	//test
	public static final void main(String[] args) {
		
		if(Line.create(12,34,12,34)!=null)throw new Error();
		
		Line[] tests=new Line[] {
				Line.create(12,53,232,131),
				Line.X_AXIS,
				Line.Y_AXIS,
				Line.Y_EQUALS_X,
				Line.create(11,31,432,31),
				createVertical(22),
				createHorizontal(45),
		};
		for(Line l:tests) {
			if(!l.isVertical()&&!l.isHorizontal()) {
				double y=l.getY(45);
				double x=l.getInverse().getY(y);
				if(Math.abs(x-45)>Double.MIN_VALUE*8)
					throw new Error();
			}
		}
		
		//TODO test serialization,comparison,etc.,log
	}
}
