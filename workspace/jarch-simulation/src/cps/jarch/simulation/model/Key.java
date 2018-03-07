/*
 * CREATED ON:    Jan 20, 2006 6:34:51 AM
 * CREATED BY:    bansil 
 */
package cps.jarch.simulation.model;

import cps.jarch.data.value.tools.Converter;
import cps.jarch.gui.resources.DescribedImpl;
import cps.jarch.gui.resources.DescribedProxy;
import cps.jarch.gui.resources.MessageBundle;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.Range;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Immutable;
import cps.jarch.util.notes.Nullable;

/**
 * <p>
 * A key that maps to a particular type of value. Values can be filtered so that
 * only certain instances within that type are allowed. The value type must be
 * immutable. The information provided by a key is intended to be enough that a
 * GUI could set its value.
 * </p>
 * 
 * @version $Id$
 * @author bansil
 */
//note heavy  reflection from Converter
@Immutable public abstract class Key<ValueType> implements DescribedProxy{
	
	private final Converter<ValueType,String> converter;
	/**
	 * @return Converter that maps values associated with the key to strings and
	 *         back. <code>getToStringConverter().isConvertSafe()==true</code>
	 *         always but rarely is
	 *         <code>getToStringConverter().isUnconvertSafe()==true</code>.
	 */
	public final @Constant Converter<ValueType,String> getToStringConverter(){
		return converter;
	}
	private final Description description;
	/**
	 * @return description of this key. getDescription().getName() is they key's
	 *         name.
	 */
	public final @Constant Description getDescription() {
		return description;
	}
	private final boolean nullable;
	/**
	 * @return if null values are allowed for this key.
	 */
	public final @Constant boolean isNullable() {
		return nullable;
	}
	private final ValueType defaultValue;
	/**
	 * @return value of key in a map if no value is specified.
	 */
	public final @Constant @Nullable ValueType getDefaultValue() {
		return defaultValue;
	}
	/**
	 * @throws Exception
	 *             if a particular instance of value is can be assigned to keys
	 *             of this type. Implementations should document the exact
	 *             conditions under which exceptions will be thrown and provide
	 *             methods like <code>checkNull(ValueType)</code> below so
	 *             clients can determine if the value is OK. Implementations
	 *             should call
	 *             <code>super.checkValue(@Nullable ValueType value)</code>.
	 *             Implemenations should be consistent, i.e. for a particular
	 *             key instance k and value instance v k.checkValue(v) should
	 *             always return the same result. This should follow naturally
	 *             from the fact that ValueType and Key are immutable.
	 */
	public void checkValue(@Nullable ValueType value)throws Exception {
		checkNull(value);
	}
	//this format so a client can determine exact failure easily
	/**
	 * @throws NullPointerException if(value==null&&!nullable)
	 */
	public final void checkNull(@Nullable ValueType value)throws NullPointerException{
		if(value==null&&!nullable)throw new NullPointerException("value=null not allowed");
	}
	
	/**
	 * creates Key.
	 * 
	 * @throws IllegalArgumentException
	 *             if not <code>converter.isConvertSafe()</code> &
	 *             <code>converter.isNullable()==nullable</code>
	 */
	public Key(Converter<ValueType, String> converter, Description description,
			@Nullable ValueType defaultValue, boolean nullable) {
		super();
		LangUtils.checkArgNotNull(description);
		if (!converter.isConvertSafe())
			throw new IllegalArgumentException("converter " + converter
					+ " must be convert safe");
		if (converter.isNullable() != nullable)
			throw new IllegalArgumentException("converter " + converter
					+ " should have same nullability as Key:" + nullable);
		
		this.converter = converter;
		this.description = description;
		this.nullable = nullable;
		this.defaultValue = defaultValue;
		checkNull(defaultValue);
	}
	/**
	 * Key for types whose values are within a {@link Range}. Good for numbers.
	 * Type must be convertible to/from strings via
	 * {@link Converter#createReflectiveStringConverter(Class, boolean)}.
	 */
	public static abstract class RangedKey<T extends Comparable<T>> extends Key<T> {
		@Override public void checkValue(@Nullable T value) throws Exception {
			super.checkValue(value);
			checkInRange(value);
		}
		private final Range<T> range;
		public final void checkInRange(@Nullable T value) {
			if (value != null && !range.contains(value))
				throw new IllegalArgumentException("value '" + value + "' must be in "
						+ range);
		}
		public RangedKey(Class<T> type, Description description, T defaultValue,
				boolean nullable, Range<T> range) {
			super(Converter.createReflectiveStringConverter(type, nullable), description,
				defaultValue, nullable);
			LangUtils.checkArgNotNull(range);
			this.range=range;
			checkInRange(defaultValue);
		}
	}
	/**
	 * Key for values that can be set to true, false, or possibly <code>null</code>.
	 */
	public static final class BooleanKey extends Key<Boolean>{
		public BooleanKey(Description description,Boolean defaultValue, boolean nullable) {
			super(Converter.createReflectiveStringConverter(Boolean.class, nullable),
				description, defaultValue, nullable);
		}
	}
	/**
	 * Key for values that can be set to constants of a particular enum type.
	 */
	public static final class EnumKey<T extends Enum> extends Key<T>{
		private final Class<T> type;
		public EnumKey(Class<T> type, Description description, T defaultValue,
				boolean nullable) {
			super(Converter.createEnumToStringConverter(type, nullable),
				description, defaultValue, nullable);
			this.type=type;
		}
		//generics should prevent this from ever being needed
		@Override public void checkValue(@Nullable T value)throws Exception {
			super.checkValue(value);
			checkType(value);
		}
		public final void checkType(@Nullable T value)throws NullPointerException{
			if(value!=null) {
				if(type.isInstance(value));
			}
		}
	}
	/**
	 * Adds letter field to described. This letter is normally part of the Key's
	 * name although it is not required to be and intended to be used as a mnemonic.
	 */
	public static final class Description extends DescribedImpl{
		public Description(MessageBundle res, String name) {
			super(res, name);
			res=res.deriveChild(name);
			String letterRaw=res.tryLoadString(LETTER_KEY);
			Character letter=null;
			if(letterRaw!=null) {
				if(letterRaw.length()!=1) {
					res.warnValueCorrupt(LETTER_KEY,
						"expected a single character, ignoring",
						null,null);
				}else {
					letter=letterRaw.charAt(0);
				}
			}
			this.letter=letter;
		}
		private final Character letter;
		public final @Nullable Character getLetter() {
			return letter;
		}
		public static final String LETTER_KEY="LETTER";
	}
}