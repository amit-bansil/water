/*
 * StringConverter.java
 * CREATED:    Jun 17, 2005 2:51:24 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-util
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.value.tools;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Immutable;
import cps.jarch.util.notes.Reflect;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.text.ParseException;

/**
 * Converts objects of InputType to and from OutputType. converters must
 * gaurantee for any converter c<A,B> and an instance of A a,
 * a.equals(c.unconvert(c.convert(a)), and vice versa for an instance of type B.
 * Conversions should also be consistent unless otherwise specified. So for a
 * particular converter instance values should always convert back and forth to
 * the same number (i.e. the converter should be immutable).
 */
@Immutable public abstract class Converter<InputType, OutputType> {
	private final boolean nullable;

	/**
	 * creates Converter. This basic implementation just enforces whether or not
	 * null values are accepted and does not allow exceptions when safe.
	 * 
	 * @param nullable
	 */
	public Converter(boolean nullable, boolean convertSafe,
			boolean unconvertSafe) {
		this.nullable = nullable;
		this.convertSafe = convertSafe;
		this.unconvertSafe = unconvertSafe;
	}

	// constant
	public final boolean isNullable() {
		return nullable;
	}

	// internal test, throws Conversion exception if v==null and !nullable
	private boolean checkReturnNull(Object v) throws ConversionException {
		if (v == null) {
			if (nullable) return true;
			else throw new ConversionException(
				"(un)convert failed w. converter '" + this
						+ "': null not allowed", null);
		} else return false;
	}

	/**
	 * @return the output generated from in, or null if in==null & nullable.
	 * @throws ConversionException
	 *             if conversion fails or in==null & !nullable.
	 */
	public final OutputType convert(InputType in) throws ConversionException {
		if (checkReturnNull(in)) return null;
		try {
			return _convert(in);
		} catch (ConversionException e) {
			if (convertSafe) {
				throw new Error("convert failed despite supposed saftey", e);
			} else throw e;
		}
	}

	/**
	 * hook for subclasses to perform conversion in. in is never null.
	 */
	protected abstract OutputType _convert(InputType in)
			throws ConversionException;

	/**
	 * @return the input generated from out, or null if out==null & nullable.
	 * @throws ConversionException
	 *             if conversion fails or out==null & !nullable.
	 */
	public final InputType unconvert(OutputType out) throws ConversionException {
		if (checkReturnNull(out)) return null;
		try {
			return _unconvert(out);
		} catch (ConversionException e) {
			if (unconvertSafe) {
				throw new Error("unconvert failed despite supposed saftey", e);
			} else throw e;
		}
	}

	/**
	 * hook for subclasses to perform un-conversion in. <code>out</code> is
	 * never <code>null</code>.
	 */
	protected abstract InputType _unconvert(OutputType out)
			throws ConversionException;

	/**
	 * should override toString to make it clear what converter caused the
	 * problem.
	 * 
	 * @param out
	 *            value that could not be converted
	 * @param message
	 *            details, non blank
	 * @param cause
	 *            nullable exception that caused this
	 * @return ConversionException explaining that (un)conversion could not be
	 *         performed.
	 */
	protected final ConversionException unconvertFailed(OutputType out,
			String message, Throwable cause) {
		return new ConversionException("failed to convert '" + out
				+ "' w. converter " + this + ": " + message, cause);
	}

	protected final ConversionException convertFailed(Object input,
			String message, Throwable cause) {
		return new ConversionException("failed to unconvert '" + input + " w. "
				+ this + ": " + message, cause);

	}

	public static final class ConversionException extends Exception {
		public ConversionException(String message, Throwable cause) {
			super(message);
			initCause(cause);
		}
	}

	/**
	 * if unconvert or convert is considered safe then conversionExceptions will
	 * never be thrown for the respective methods as long as nullability is
	 * honered.
	 */
	private final boolean convertSafe, unconvertSafe;

	public final boolean isConvertSafe() {
		return convertSafe;
	}

	public final boolean isUnconvertSafe() {
		return unconvertSafe;
	}

	// ------------------------------------------------------------------------
	// common converters
	// ------------------------------------------------------------------------
	//the compiler does not seem to be able to correctly infer the return type here
	//so lets just do this unchecked.
	/**
	 * a converter which does nothing, except possibly filtering null values
	 */
	public static final Converter getIdentityConverter(
			boolean allowsNull) {
		return allowsNull ? nullableIdentityConverter
				: nonNullIdentityConverter;
	}

	/**
	 * check if a converter is a identity converter as defined by
	 * getIdentityConverter(). Used for optimizations. A converter may do
	 * nothing and still not be an identityConverter.
	 */
	public static boolean isIdentityConverter(Converter c) {
		return c == nonNullIdentityConverter || c == nullableIdentityConverter;
	}

	private static final IdentityConverter nullableIdentityConverter = new IdentityConverter(
		true),
			nonNullIdentityConverter = new IdentityConverter(false);

	private static final class IdentityConverter<InT> extends Converter<InT,InT> {
		public IdentityConverter(boolean nullable) {
			super(nullable, true, true);
		}

		@Override
		public InT _convert(InT in) {
			return in;
		}

		@Override
		public InT _unconvert(InT out) {
			return out;
		}

		@Override
		public final String toString() {
			return "identityConverter";
		}
	}

	/**
	 * converts between an enum and a string using the enum's name() operation.
	 * good for io since converting to an int would be less robust, although
	 * faster. values is searched when unconverting back and thus
	 * EnumType.values() should be used to generated it. conversions from
	 * strings which don't have a corresponding entry in values will fail, even
	 * if they are valid constants.
	 */
	public static <T extends Enum>Converter<T, String> createEnumToStringConverter(
			final Class<T> type,final boolean nullable) {
		LangUtils.checkArgNotNull(type,"type");
		return new Converter<T, String>(nullable, true, false) {
			@Override
			public String _convert(T in) throws ConversionException {
				return in.name();
			}

			@SuppressWarnings("unchecked") @Override
			public T _unconvert(String out) throws ConversionException {
				if (out == null) {
					assert nullable;
					return null;
				}
				try {
					return Enum.valueOf(type, out);//unchecked
				}catch(IllegalArgumentException e) {
					//no constant named 'out' was found in type
					throw unconvertFailed(out, "constant not found", e);
				}
			}

			@Override
			public final String toString() {
				return "EnumToStringConverter for "+ type;
			}
		};
	}

	/**
	 * performs conversion for a generic class c reflectivly using the
	 * contructor in c that takes only a String and toString().<br>
	 * 
	 * When converting fromString:<br>
	 * -if the constructor can't be invoked an error is thrown on conversion<br>
	 * -any exception thrown during the target contructor's invocation is
	 * wrapped as a parseException.
	 * 
	 * @throws Error
	 *             if that constructor does not exist.
	 */
	public static @Reflect <T>Converter<T, String> createReflectiveStringConverter(
			final Class<T> type, boolean nullable) {
		// for strings do nothing, unchecked:
		//if (String.class.equals(type)) return getIdentityConverter(nullable);

		try {
			final Constructor<T> constructor = type
				.getConstructor(STRING_TO_OBJECT_CONTRUCTOR_ARGS);

			return new Converter<T, String>(nullable, true, false) {
				@Override
				public String _convert(T in) {
					return in.toString();
				}

				@Override
				public T _unconvert(String out) throws ConversionException {
					try {
						return toObject(out, constructor);
					} catch (ParseException e) {
						throw unconvertFailed(out, "unparseable", e.getCause());
					}
				}

				@Override
				public String toString() {
					return "ReflectiveStringCreator[" + type + ']';
				}
			};

		} catch (NoSuchMethodException e1) {
			throw new Error(type
					+ " does not have constructor that takes only a string", e1);
		}
	}

	private static final Class[] STRING_TO_OBJECT_CONTRUCTOR_ARGS = new Class[]{String.class};

	// create an object of type T using constructor
	private static <T>T toObject(String s, Constructor<T> constructor)
			throws ParseException {
		try {
			return constructor.newInstance(new Object[]{s});
		} catch (IllegalArgumentException e) {
			// should not happen
			throw new Error(e);
		} catch (InstantiationException e) {
			throw new Error(e);
		} catch (IllegalAccessException e) {
			throw new Error(e);
		} catch (InvocationTargetException e) {
			ParseException ex = new ParseException(s, -1);
			ex.initCause(e);
			throw ex;
		}
	}

	/**
	 * combines two converters.
	 * 
	 * @throws IllegalArgumentException
	 *             if only 1 converter accepts null.
	 */
	public static <InType, IntermediateType, OutType>Converter<InType, OutType> createCompositeConverter(
			final Converter<InType, IntermediateType> inConverter,
			final Converter<IntermediateType, OutType> outConverter) {
		if (inConverter.isNullable() != outConverter.isNullable())
			throw new IllegalArgumentException(
				"inConverter.isNullable()!=outConverter.isNullable()");
		return new Converter<InType, OutType>(inConverter.isNullable(),
			inConverter.isConvertSafe() && outConverter.isConvertSafe(),
			outConverter.isUnconvertSafe() && inConverter.isUnconvertSafe()) {
			@Override
			protected OutType _convert(InType in) throws ConversionException {
				return outConverter.convert(inConverter.convert(in));
			}

			@Override
			protected InType _unconvert(OutType out) throws ConversionException {
				return inConverter.unconvert(outConverter.unconvert(out));
			}

			@Override
			public String toString() {
				return "CompositeConverter:[" + inConverter.toString() + "]->["
						+ outConverter.toString() + ']';
			}
		};
	}
}
