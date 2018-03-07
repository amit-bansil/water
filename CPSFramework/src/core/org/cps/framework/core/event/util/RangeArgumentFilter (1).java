/*
 * RangeArgumentFilter.java CREATED: Aug 9, 2003 5:12:53 PM AUTHOR: Amit Bansil
 * PROJECT: vmdl2 Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.event.util;

import java.text.MessageFormat;

import org.apache.commons.lang.math.Range;
import org.cps.framework.core.event.core.Constraint;
import org.cps.framework.core.event.core.VetoException;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

/**
 * filter makes sure NUMBER is within a range
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class RangeArgumentFilter<T extends Number> implements Constraint<ValueChangeEvent<T>> {
	private static final ResourceAccessor res =
		ResourceAccessor.load(RangeArgumentFilter.class);
	protected static final String out_of_range_pattern =
		res.getString("out_of_range_pattern");
	private final Range range;
	public final Range getRange() {
		return range;
	}
	/*
     * type must be Comparable min||max may be null to be ignored
     */
	public RangeArgumentFilter(Range range) {
		this.range = range;
	}
	public void checkEvent(ValueChangeEvent<T> evt)
		throws VetoException {
		Object value = evt.getNewValue();
		if (value == null)
			return; //if null is allowed must assume it is in range???
		if (!range.containsNumber((Number) value))
			throw new OutOfRangeException(evt, range);
	}
	public static class OutOfRangeException extends VetoException{
		private final Range range2;
		public OutOfRangeException(ValueChangeEvent evt, Range r) {
			super(
			        evt,	"value '" + evt.getNewValue() + 
			        "' out of range '" + r + '\'');
			this.range2 = r;
		}
		public final Number getValue() {
			return ((ValueChangeEvent<Number>)getVetoedEvent()).getNewValue();
		}
		public final Range getRange() {
			return range2;
		}
		public final String getLocalizedMessage() {
			return MessageFormat.format(
				out_of_range_pattern,
				new Object[] {
					getRange().getMaximumNumber(),
					getRange().getMinimumNumber(),
					getValue()});
		}
	}
}