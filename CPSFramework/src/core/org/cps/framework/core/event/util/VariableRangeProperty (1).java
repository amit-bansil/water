/*
 * VariableRangeProperty.java CREATED: Aug 9, 2003 8:09:23 PM AUTHOR: Amit
 * Bansil PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.event.util;

import java.text.MessageFormat;

import org.cps.framework.core.event.core.Constraint;
import org.cps.framework.core.event.core.VetoException;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.ConstrainablePropertyRW;
import org.cps.framework.core.event.property.DefaultConstrainedPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

/**
 * A set of three constrained properties representing a value in a maximum,and
 * minimum that are also properties. setting out of range values will cause
 * Vetos it is an inclusive range.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
final class VariableRangeProperty<valueType extends Comparable> {
	private final ConstrainablePropertyRW<valueType> max, min, value;
	/*
     * @throws IllegalArgumentexception if range is invalid ???should
     * subproperties holders be this???
     */
	public VariableRangeProperty(
		boolean allowsNull,
		valueType minValue,
		valueType maxValue,
		valueType value)
		throws IllegalArgumentException {
		this.max = new DefaultConstrainedPropertyRW<valueType>(allowsNull, maxValue);
		this.min = new DefaultConstrainedPropertyRW<valueType>(allowsNull, minValue);
		this.value = new DefaultConstrainedPropertyRW<valueType>(allowsNull, value);
		RangeConstraint<valueType> MaxMin =
			new RangeConstraint<valueType>(
				this.value,
				RangeConstraint.CONDITION_NOT_LESS_THAN);
		RangeConstraint<valueType> ValueMax =
			new RangeConstraint<valueType>(
				this.value,
				RangeConstraint.CONDITION_NOT_GREATER_THAN);
		RangeConstraint<valueType> ValueMin =
			new RangeConstraint<valueType>(
				this.value,
				RangeConstraint.CONDITION_NOT_LESS_THAN);
		RangeConstraint<valueType> MinMax =
			new RangeConstraint<valueType>(
				this.value,
				RangeConstraint.CONDITION_NOT_GREATER_THAN);
		//test initial values
		if (!(MaxMin.obeys(max.get()) || MinMax.obeys(min.get())))
			throw new IllegalArgumentException(
				"invalid range should be max["
					+ max
					+ "] >= value["
					+ value
					+ "] >= min["
					+ min
					+ "]");
		assert ValueMax.obeys(value) && ValueMin.obeys(value);

		this.value.addConstraint(ValueMin);
		this.value.addConstraint(ValueMax);
		this.max.addConstraint(MaxMin);
		this.min.addConstraint(MinMax);
	}
	public final ConstrainablePropertyRW<valueType> getMax() {
		return max;
	}
	public final ConstrainablePropertyRW<valueType> getMin() {
		return min;
	}
	public final ConstrainablePropertyRW<valueType> getValue() {
		return value;
	}

	private static final ResourceAccessor res=ResourceAccessor.load(VariableRangeProperty.class);
	protected static final String out_of_range_pattern=res.getString("out_of_range_pattern");
	/**
     * rejects all new values that do not fufull condition toward their limit if
     * limit or limit.get is null all values are acceptable as are undefined
     * values throws a classcast exception if limit is not comparable
     * 
     * @version 0.1
     * @author Amit Bansil
     */
	private final class RangeConstraint<VT extends Comparable> implements Constraint<ValueChangeEvent<VT>> {
		public static final int CONDITION_GREATER_THAN = 0; //>
		public static final int CONDITION_LESS_THAN = 1; //<
		public static final int CONDITION_NOT_GREATER_THAN = 2; ///<=
		public static final int CONDITION_NOT_LESS_THAN = 3; //>=
		private final int c;
		private final boolean b;
		protected final BoundPropertyRO<VT> limit;
		public RangeConstraint(BoundPropertyRO<VT> limit, int condition) {
			this.limit = limit;
			switch (condition) {
				case CONDITION_GREATER_THAN :
					c = 1;
					b = true;
					break;
				case CONDITION_LESS_THAN :
					c = -1;
					b = true;
					break;
				case CONDITION_NOT_GREATER_THAN :
					c = 1;
					b = false;
					break;
				case CONDITION_NOT_LESS_THAN :
					c = -1;
					b = false;
					break;
				default :
					throw new IllegalArgumentException(
						"condition " + condition + " undefined");
			}
		}
		public final void checkEvent(ValueChangeEvent<VT> evt)
			throws VetoException {
			VT newValue = evt.getNewValue();
			if (!obeys(newValue))
				throw new VetoException(evt,
						"value "
							+ evt.getNewValue()
							+ "must be "
							+ getConstraintString()
							+ " than "
							+ limit.get(),
						MessageFormat.format(
								out_of_range_pattern,
								new Object[] {
									evt.getNewValue(),
									getConstraintString(),
									limit.get()})
						,null);
		}
		/*
         * checks if a value v obeys this constraint
         */
		public final boolean obeys(VT v) {
			if (v == null)
				return true;
			if (limit == null)
				return true;
			VT l = limit.get();
			if (l == null)
				return true;
			return (v.compareTo(l) == c) == b;
		}
		protected final String getConstraintString() {
			if (b) {
				return (c == 1 ? ">" : "<");
			} else {
				return (c == 1 ? "<=" : ">=");
			}
		}

	}
}
