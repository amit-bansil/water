package cps.jarch.util.misc;

import cps.jarch.util.notes.Immutable;
import cps.jarch.util.notes.Nullable;

/**
 * A generic range of comparable values. Immutable. <code>T</code> must be
 * {@link cps.jarch.util.notes.Immutable} as well.
 * 
 * @author Amit Bansil
 * @version $Id: Range.java 521 2005-08-30 19:54:25Z bansil $.
 */
public @Immutable class Range<T extends Comparable<T>> {
	// ------------------------------------------------------------------------
	// fields 
	
    private final T min, max;
    private final boolean minInclusive,maxInclusive;
    
    /**
	 * @return true iff <code>getMin()</code> is in the range. insignificant if
	 *         <code>getMin()==null</code>.
	 */
    public final boolean isMinInclusive() {
    	return minInclusive;
    }
    /**
	 * @return true iff <code>getMax()</code> is in the range. insignificant if
	 *         <code>getMax()==null</code>.
	 */
    public final boolean isMaxInclusive() {
    	return maxInclusive;
    }
    /**
     * @return minimum of range or <code>null</code> if no min.
     */
    public final @Nullable T getMin() {
    	return min;
    }
    /**
     * @return maximum of range or <code>null</code> if no max.
     */
    public final @Nullable T getMax() {
    	return max;
    }
    
    // ------------------------------------------------------------------------
    // convenience factory methods
    
    /**
     * @return range of values strictly greater than <code>min</code>.
     */
    public static final <T extends Comparable<T>> Range<T> greaterThan(T min){
    	LangUtils.checkArgNotNull(min);
    	return new Range<T>(null,min,false,false);
    }
    /**
     * @return range of values strictly less than <code>max</code>
     */
    public static final <T extends Comparable<T>> Range<T> lessThan(T max){
    	LangUtils.checkArgNotNull(max);
    	return new Range<T>(max,null,false,false);
    }
    /**
	 * @return range of values greater than or equal to <code>min</code>.
	 */
    public static final <T extends Comparable<T>> Range<T> greaterThanOrEquals(T min){
    	LangUtils.checkArgNotNull(min);
    	return new Range<T>(null,min,true,true);
    }
    /**
     * @return range of values less than or equal to <code>max</code>.
     */
    public static final <T extends Comparable<T>> Range<T> lessThanOrEquals(T max){
    	LangUtils.checkArgNotNull(max);
    	return new Range<T>(max,null,true,true);
    }
    /**
     * @return range of values in the exclusive range (min,max).
     */
    public static final <T extends Comparable<T>> Range<T> openRange(T max,T min){
    	LangUtils.checkArgNotNull(max);
    	LangUtils.checkArgNotNull(min);
    	return new Range<T>(max,min,false,false);
    }
    /**
     * @return range of values in the inclusive range [min,max].
     */
    public static final <T extends Comparable<T>> Range<T> closedRange(T max, T min){
    	LangUtils.checkArgNotNull(max);
    	LangUtils.checkArgNotNull(min);
    	return new Range<T>(max,min,true,true);
    }
    /**
     * @return that contains all values.
     */
    @SuppressWarnings("unchecked") public static final
    	<T extends Comparable<T>>Range<T> allRange() {
		return allRange;
	}
    @SuppressWarnings("unchecked")
    	private static final Range allRange=new Range(null,null,false,false);
    
    /**
	 * create Range from <code>min</code> to <code>max</code>. use <code>null</code>
	 * to specify no max and/or min. 
	 * 
	 * @throws IllegalArgumentException
	 *             if <code>min<max</code> (when both are defined.
	 */
    public Range(@Nullable T min,@Nullable T max,
                 boolean minInclusive, boolean maxIncluseive) {
        if(min!=null&&max!=null){
            if(min.compareTo(max)==1)
            throw new IllegalArgumentException(
                    "invalid range: min '"+min+"' < max '"+max+ '\'');
        }
        this.min=min;
        this.max=max;

        this.minInclusive=minInclusive;
        this.maxInclusive=maxIncluseive;
    }
    /**
	 * @return iff <code>value</code> is in this Range.
	 */
    public boolean contains(T value){
    	LangUtils.checkArgNotNull(value);
        //check min
        if(min!=null){
            int v=min.compareTo(value);
            //false if less min greater than value
            if(v==1)return false;
            //fail if == but !minInclusive
            if(!minInclusive&&v==0)return false;
        }
        //check max
        if(max!=null){
            int v=max.compareTo(value);
            //false if max less than value
            if(v==-1)return false;
            //false if == but !maxInclusive
            if(!maxInclusive&&v==0)return false;
        }
        return true;
    }
    private static final char INFINITY_CHAR='\u221E';
    @Override
	public String toString(){
        if(min==null&&max==null)return "Range:<all>";

        StringBuilder sb=new StringBuilder(20);
        sb.append("Range: ");

        if(min!=null){
           sb.append(minInclusive?"[":"(");
           sb.append(min);
        }else{
           sb.append('[');
           sb.append(INFINITY_CHAR);
        }

        if(max!=null){
            sb.append(max);
            sb.append(maxInclusive?']':')');
        }else{
            sb.append(INFINITY_CHAR);
            sb.append(']');
        }

        return sb.toString();
    }
    
    // ------------------------------------------------------------------------
    // Object implementation
    
    @Override public final int hashCode() {
    	return LangUtils.hashCode(min,max);
    }
    @Override public final boolean equals(Object o) {
		if (o == null || !(o instanceof Range)) return false;
		Range r = (Range) o;
		return LangUtils.equals(min, r.min) && LangUtils.equals(max, r.max);
	}
}
