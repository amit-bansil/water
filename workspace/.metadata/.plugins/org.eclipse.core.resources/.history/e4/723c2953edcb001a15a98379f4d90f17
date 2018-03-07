/*
 * StringUtils.java
 * CREATED:    Feb 6, 2005 5:09:01 PM
 * CREATED BY: Amit Bansil
 * */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Nullable;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * misc string utilities.
 * </p>
 * <p>
 * Derived from apache-commons-lang StringUtils.java 161243 2005-04-14 04:30:28Z
 * ggregory.
 * </p>
 * <p>
 * The <code>StringUtils</code> class defines certain words related to
 * String handling.
 * </p>
 * <ul>
 *  <li>null - <code>null</code></li>
 *  <li>empty - a zero-length string (<code>""</code>)</li>
 *  <li>space - the space character (<code>' '</code>, char 32)</li>
 *  <li>whitespace - the characters defined by {@link Character#isWhitespace(char)}</li>
 *  <li>trim - the characters &lt;= 32 as in {@link String#trim()}</li>
 * </ul>
 *
 * <p><code>StringUtils</code> handles <code>null</code> input Strings quietly.
 * That is to say that a <code>null</code> input will return <code>null</code>.
 * Where a <code>boolean</code> or <code>int</code> is being returned
 * details vary by method.</p>
 *
 * <p>A side effect of the <code>null</code> handling is that a
 * <code>NullPointerException</code> should be considered a bug in
 * <code>StringUtils</code> (except for deprecated methods).</p>
 *
 * <p>Methods in this class give sample code to explain their operation.
 * The symbol <code>*</code> is used to indicate any input including <code>null</code>.</p>
 * @version $Id: StringUtils.java 536 2005-09-01 21:33:07Z bansil $
 * @author Amit Bansil
 */
@SuppressWarnings("unchecked") public class StringUtils {

	// padding
	// ------------------------------------------------------------------------
	/**
	 * <p>
	 * The maximum size to which the padding constant(s) can expand.
	 * </p>
	 *
	 * from apache commons-lang:2.0
	 */
	private static final int PAD_LIMIT = 8192;

	/**
	 * <p>
	 * An array of <code>String</code>s used for padding.
	 * </p>
	 * 
	 * <p>
	 * Used for efficient space padding. The length of each String expands as
	 * needed.
	 * </p>
	 * 
	 * from apache commons-lang:2.0
	 */
	private static final String[] PADDING = new String[Character.MAX_VALUE];

	static {
		// space padding is most common, start with 64 chars
		PADDING[32] = "                                                                ";
	}

	/**
	 * <p>
	 * Right pad a String with spaces (' ').
	 * </p>
	 * 
	 * <p>
	 * The String is padded to the size of <code>size</code>.
	 * </p>
	 * 
	 * <pre>
	 *   StringUtils.rightPad(null, *)   = null
	 *   StringUtils.rightPad(&quot;&quot;, 3)     = &quot;   &quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 3)  = &quot;bat&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 5)  = &quot;bat  &quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 1)  = &quot;bat&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, -1) = &quot;bat&quot;
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 * 
	 * @param str
	 *            the String to pad out, may be null
	 * @param size
	 *            the size to pad to
	 * @return right padded String or original String if no padding is
	 *         necessary, <code>null</code> if null String input
	 */
	public static @Nullable String rightPad(@Nullable String str, int size) {
		return rightPad(str, size, ' ');
	}

	/**
	 * <p>
	 * Right pad a String with a specified character.
	 * </p>
	 * 
	 * <p>
	 * The String is padded to the size of <code>size</code>.
	 * </p>
	 * 
	 * <pre>
	 *   StringUtils.rightPad(null, *, *)     = null
	 *   StringUtils.rightPad(&quot;&quot;, 3, 'z')     = &quot;zzz&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 3, 'z')  = &quot;bat&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 5, 'z')  = &quot;batzz&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, 1, 'z')  = &quot;bat&quot;
	 *   StringUtils.rightPad(&quot;bat&quot;, -1, 'z') = &quot;bat&quot;
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 * 
	 * @param str
	 *            the String to pad out, may be null
	 * @param size
	 *            the size to pad to
	 * @param padChar
	 *            the character to pad with
	 * @return right padded String or original String if no padding is
	 *         necessary, <code>null</code> if null String input
	 * @since 2.0
	 */
	public static @Nullable String rightPad(@Nullable String str, int size, char padChar) {
		if (str == null) { return null; }
		int pads = size - str.length();
		if (pads <= 0) { return str; // returns original String when possible
		}
		if (pads > PAD_LIMIT) { return rightPad(str, size, String
			.valueOf(padChar)); }
		return str.concat(padding(pads, padChar));
	}

	/**
	 * <p>
	 * Returns padding using the specified delimiter repeated to a given length.
	 * </p>
	 * 
	 * <pre>
	 *   StringUtils.padding(0, 'e')  = &quot;&quot;
	 *   StringUtils.padding(3, 'e')  = &quot;eee&quot;
	 *   StringUtils.padding(-2, 'e') = IndexOutOfBoundsException
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 * 
	 * @param repeat
	 *            number of times to repeat delim
	 * @param padChar
	 *            character to repeat
	 * @return String with repeated character
	 * @throws IndexOutOfBoundsException
	 *             if <code>repeat &lt; 0</code>
	 */
	private static String padding(int repeat, char padChar) {
		// be careful of synchronization in this method
		// we are assuming that get and set from an array index is atomic
		String pad = PADDING[padChar];
		if (pad == null) {
			pad = String.valueOf(padChar);
		}
		while (pad.length() < repeat) {
			pad = pad.concat(pad);
		}
		return pad.substring(0, repeat);
	}

	/**
	 * <p>
	 * Right pad a String with a specified String.
	 * </p>
	 * 
	 * <p>
	 * The String is padded to the size of <code>size</code>.
	 * </p>
	 * 
	 * <pre>
	 *     StringUtils.rightPad(null, *, *)      = null
	 *     StringUtils.rightPad(&quot;&quot;, 3, &quot;z&quot;)      = &quot;zzz&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 3, &quot;yz&quot;)  = &quot;bat&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 5, &quot;yz&quot;)  = &quot;batyz&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 8, &quot;yz&quot;)  = &quot;batyzyzy&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 1, &quot;yz&quot;)  = &quot;bat&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, -1, &quot;yz&quot;) = &quot;bat&quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 5, null)  = &quot;bat  &quot;
	 *     StringUtils.rightPad(&quot;bat&quot;, 5, &quot;&quot;)    = &quot;bat  &quot;
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 * 
	 * @param str
	 *            the String to pad out, may be <code>null</code>
	 * @param size
	 *            the size to pad to
	 * @param padStr
	 *            the String to pad with, <code>null</code> or empty treated
	 *            as single space
	 * @return right padded String or original String if no padding is
	 *         necessary, <code>null</code> if <code>null</code> String
	 *         input
	 */
	public static @Nullable String rightPad(@Nullable String str, int size,
			@Nullable String padStr) {
		if (str == null) { return null; }
		if (padStr == null || padStr.length() == 0) {
			padStr = " ";
		}
		int padLen = padStr.length();
		int strLen = str.length();
		int pads = size - strLen;
		if (pads <= 0) { return str; // returns original String when possible
		}
		if (padLen == 1 && pads <= PAD_LIMIT) { return rightPad(str, size, padStr
			.charAt(0)); }

		if (pads == padLen) {
			return str.concat(padStr);
		} else if (pads < padLen) {
			return str.concat(padStr.substring(0, pads));
		} else {
			char[] padding = new char[pads];
			char[] padChars = padStr.toCharArray();
			for (int i = 0; i < pads; i++) {
				padding[i] = padChars[i % padLen];
			}
			return str.concat(new String(padding));
		}
	}

	// Abbreviating
	// -----------------------------------------------------------------------
	/**
	 * <p>
	 * Abbreviates a String using ellipses. This will turn "Now is the time for
	 * all good men" into "Now is the time for..."
	 * </p>
	 * 
	 * <p>
	 * Specifically:
	 * <ul>
	 * <li>If <code>str</code> is less than <code>maxWidth</code>
	 * characters long, return it.</li>
	 * <li>Else abbreviate it to
	 * <code>(substring(str, 0, max-3) + "...")</code>.</li>
	 * <li>If <code>maxWidth</code> is less than <code>4</code>, throw an
	 * <code>IllegalArgumentException</code>.</li>
	 * <li>In no case will it return a String of length greater than
	 * <code>maxWidth</code>.</li>
	 * </ul>
	 * </p>
	 * 
	 * <pre>
	 *      StringUtils.abbreviate(null, *)      = null
	 *      StringUtils.abbreviate(&quot;&quot;, 4)        = &quot;&quot;
	 *      StringUtils.abbreviate(&quot;abcdefg&quot;, 6) = &quot;abc...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefg&quot;, 7) = &quot;abcdefg&quot;
	 *      StringUtils.abbreviate(&quot;abcdefg&quot;, 8) = &quot;abcdefg&quot;
	 *      StringUtils.abbreviate(&quot;abcdefg&quot;, 4) = &quot;a...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefg&quot;, 3) = IllegalArgumentException
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to check, may be null
	 * @param maxWidth
	 *            maximum length of result String, must be at least 4
	 * @return abbreviated String, <code>null</code> if null String input
	 * @throws IllegalArgumentException
	 *             if the width is too small
	 * @since 2.0
	 */
	public static @Nullable String abbreviate(@Nullable String str, int maxWidth) {
		return abbreviate(str, 0, maxWidth);
	}

	/**
	 * <p>
	 * Abbreviates a String using ellipses. This will turn "Now is the time for
	 * all good men" into "...is the time for..."
	 * </p>
	 * 
	 * <p>
	 * Works like <code>abbreviate(String, int)</code>, but allows you to
	 * specify a "left edge" offset. Note that this left edge is not necessarily
	 * going to be the leftmost character in the result, or the first character
	 * following the ellipses, but it will appear somewhere in the result.
	 * 
	 * <p>
	 * In no case will it return a String of length greater than
	 * <code>maxWidth</code>.
	 * </p>
	 * 
	 * <pre>
	 *      StringUtils.abbreviate(null, *, *)                = null
	 *      StringUtils.abbreviate(&quot;&quot;, 0, 4)                  = &quot;&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, -1, 10) = &quot;abcdefg...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 0, 10)  = &quot;abcdefg...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 1, 10)  = &quot;abcdefg...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 4, 10)  = &quot;abcdefg...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 5, 10)  = &quot;...fghi...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 6, 10)  = &quot;...ghij...&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 8, 10)  = &quot;...ijklmno&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 10, 10) = &quot;...ijklmno&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghijklmno&quot;, 12, 10) = &quot;...ijklmno&quot;
	 *      StringUtils.abbreviate(&quot;abcdefghij&quot;, 0, 3)        = IllegalArgumentException
	 *      StringUtils.abbreviate(&quot;abcdefghij&quot;, 5, 6)        = IllegalArgumentException
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to check, may be null
	 * @param offset
	 *            left edge of source String
	 * @param maxWidth
	 *            maximum length of result String, must be at least 4
	 * @return abbreviated String, <code>null</code> if null String input
	 * @throws IllegalArgumentException
	 *             if the width is too small
	 * @since 2.0
	 */
	public static @Nullable String abbreviate(@Nullable String str, int offset, int maxWidth) {
		if (str == null) { return null; }
		if (maxWidth < 4) { throw new IllegalArgumentException(
			"Minimum abbreviation width is 4"); }
		if (str.length() <= maxWidth) { return str; }
		if (offset > str.length()) {
			offset = str.length();
		}
		if ((str.length() - offset) < (maxWidth - 3)) {
			offset = str.length() - (maxWidth - 3);
		}
		if (offset <= 4) { return str.substring(0, maxWidth - 3) + "..."; }
		if (maxWidth < 7) { throw new IllegalArgumentException(
			"Minimum abbreviation width with offset is 7"); }
		if ((offset + (maxWidth - 3)) < str.length()) { return "..."
				+ abbreviate(str.substring(offset), maxWidth - 3); }
		return "..." + str.substring(str.length() - (maxWidth - 3));
	}

	// split
	// ------------------------------------------------------------------------

	/**
	 * 
	 * <p>
	 * Checks if a String is whitespace, empty ("") or null.
	 * </p>
	 * 
	 * <pre>
	 *         StringUtils.isBlank(null)      			== true
	 *         StringUtils.isBlank(&quot;&quot;)        == true
	 *         StringUtils.isBlank(&quot; &quot;)       == true
	 *         StringUtils.isBlank(&quot;bob&quot;)     == false
	 *         StringUtils.isBlank(&quot;  bob  &quot;) == false
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to check, may be null
	 * @return <code>true</code> if the String is null, empty or whitespace
	 */
	public static boolean isBlank(@Nullable String str) {
		int strLen;
		if (str == null || (strLen = str.length()) == 0) { return true; }
		for (int i = 0; i < strLen; i++) {
			if ( !Character.isWhitespace(str.charAt(i)) ) { return false; }
		}
		return true;
	}

	// split
	// ------------------------------------------------------------------------
	/**
	 * <p>
	 * Splits the provided text into an array, separator specified. This is an
	 * alternative to using StringTokenizer.
	 * </p>
	 * 
	 * <p>
	 * The separator is not included in the returned String array. Adjacent
	 * separators are treated as one separator.
	 * </p>
	 * 
	 * <p>
	 * A <code>null</code> input String returns <code>null</code>.
	 * </p>
	 * 
	 * <pre>
	 *             StringUtils.split(null, *)         = null
	 *             StringUtils.split(&quot;&quot;, *)           = []
	 *             StringUtils.split(&quot;a.b.c&quot;, '.')    = [&quot;a&quot;, &quot;b&quot;, &quot;c&quot;]
	 *             StringUtils.split(&quot;a..b.c&quot;, '.')   = [&quot;a&quot;, &quot;b&quot;, &quot;c&quot;]
	 *             StringUtils.split(&quot;a:b:c&quot;, '.')    = [&quot;a:b:c&quot;]
	 *             StringUtils.split(&quot;a\tb\nc&quot;, null) = [&quot;a&quot;, &quot;b&quot;, &quot;c&quot;]
	 *             StringUtils.split(&quot;a b c&quot;, ' ')    = [&quot;a&quot;, &quot;b&quot;, &quot;c&quot;]
	 * </pre>
	 * 
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to parse, may be null
	 * @param separatorChar
	 *            the character used as the delimiter, <code>null</code>
	 *            splits on whitespace
	 * @return an array of parsed Strings, <code>null</code> if null String
	 *         input
	 * @since 2.0
	 */
	public static @Nullable String[] split(@Nullable String str, char separatorChar) {
		// Performance tuned for 2.0 (JDK1.4)

		if (str == null) { return null; }
		int len = str.length();
		if (len == 0) { return EMPTY_STRING_ARRAY; }
		List<String> list = new ArrayList<String>();
		int i = 0, start = 0;
		boolean match = false;
		while (i < len) {
			if (str.charAt(i) == separatorChar) {
				if (match) {
					list.add(str.substring(start, i));
					match = false;
				}
                i++;
                start = i;
				continue;
			}
			match = true;
			i++;
		}
		if (match) {
			list.add(str.substring(start, i));
		}
		return list.toArray(new String[list.size()]);
	}

	// private to discourage dependencies on this class
	private static final String[] EMPTY_STRING_ARRAY = new String[0];
	/**
	 * <p>
	 * Splits the provided text into an array, using whitespace as the
	 * separator. Whitespace is defined by {@link Character#isWhitespace(char)}.
	 * </p>
	 * 
	 * <p>
	 * The separator is not included in the returned String array. Adjacent
	 * separators are treated as one separator. For more control over the split
	 * use the StrTokenizer class.
	 * </p>
	 * 
	 * <p>
	 * A <code>null</code> input String returns <code>null</code>.
	 * </p>
	 * 
	 * <pre>
	 *  StringUtils.split(null)       = null
	 *  StringUtils.split(&quot;&quot;)         = []
	 *  StringUtils.split(&quot;abc def&quot;)  = [&quot;abc&quot;, &quot;def&quot;]
	 *  StringUtils.split(&quot;abc  def&quot;) = [&quot;abc&quot;, &quot;def&quot;]
	 *  StringUtils.split(&quot; abc &quot;)    = [&quot;abc&quot;]
	 * </pre>
	 * 
	 * @param str
	 *            the String to parse, may be <code>null</code>
	 * @return an array of parsed Strings, <code>null</code> if
	 *         <code>null</code> String input
	 */
    public static @Nullable String[] split(@Nullable String str) {
        return split(str, null, -1);
    }
    


    /**
	 * <p>
	 * Splits the provided text into an array, separators specified. This is an
	 * alternative to using StringTokenizer.
	 * </p>
	 * 
	 * <p>
	 * The separator is not included in the returned String array. Adjacent
	 * separators are treated as one separator. For more control over the split
	 * use the StrTokenizer class.
	 * </p>
	 * 
	 * <p>
	 * A <code>null</code> input String returns <code>null</code>. A
	 * <code>null</code> separatorChars splits on whitespace.
	 * </p>
	 * 
	 * <pre>
	 *  StringUtils.split(null, *)         = null
	 *  StringUtils.split(&quot;&quot;, *)           = []
	 *  StringUtils.split(&quot;abc def&quot;, null) = [&quot;abc&quot;, &quot;def&quot;]
	 *  StringUtils.split(&quot;abc def&quot;, &quot; &quot;)  = [&quot;abc&quot;, &quot;def&quot;]
	 *  StringUtils.split(&quot;abc  def&quot;, &quot; &quot;) = [&quot;abc&quot;, &quot;def&quot;]
	 *  StringUtils.split(&quot;ab:cd:ef&quot;, &quot;:&quot;) = [&quot;ab&quot;, &quot;cd&quot;, &quot;ef&quot;]
	 * </pre>
     *
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to parse, may be null
	 * @param separatorChars
	 *            the characters used as the delimiters, <code>null</code>
	 *            splits on whitespace
	 * @return an array of parsed Strings, <code>null</code> if null String
	 *         input
	 */
	public static @Nullable String[] split(@Nullable String str,
			@Nullable String separatorChars) {
		return splitWorker(str, separatorChars, -1, false);
	}

    /**
	 * <p>
	 * Splits the provided text into an array with a maximum length, separators
	 * specified.
	 * </p>
	 * 
	 * <p>
	 * The separator is not included in the returned String array. Adjacent
	 * separators are treated as one separator.
	 * </p>
	 * 
	 * <p>
	 * A <code>null</code> input String returns <code>null</code>. A
	 * <code>null</code> separatorChars splits on whitespace.
	 * </p>
	 * 
	 * <p>
	 * If more than <code>max</code> delimited substrings are found, the last
	 * returned string includes all characters after the first
	 * <code>max - 1</code> returned strings (including separator characters).
	 * </p>
	 * 
	 * <pre>
	 *    StringUtils.split(null, *, *)            = null
	 *    StringUtils.split(&quot;&quot;, *, *)              = []
	 *    StringUtils.split(&quot;ab de fg&quot;, null, 0)   = [&quot;ab&quot;, &quot;cd&quot;, &quot;ef&quot;]
	 *    StringUtils.split(&quot;ab   de fg&quot;, null, 0) = [&quot;ab&quot;, &quot;cd&quot;, &quot;ef&quot;]
	 *    StringUtils.split(&quot;ab:cd:ef&quot;, &quot;:&quot;, 0)    = [&quot;ab&quot;, &quot;cd&quot;, &quot;ef&quot;]
	 *    StringUtils.split(&quot;ab:cd:ef&quot;, &quot;:&quot;, 2)    = [&quot;ab&quot;, &quot;cd:ef&quot;]
	 * </pre>
 	 *
	 * from apache commons-lang:2.0
	 *
	 * @param str
	 *            the String to parse, may be null
	 * @param separatorChars
	 *            the characters used as the delimiters, <code>null</code>
	 *            splits on whitespace
	 * @param max
	 *            the maximum number of elements to include in the array. A zero
	 *            or negative value implies no limit
	 * @return an array of parsed Strings, <code>null</code> if
	 *         <code>null</code> String input
	 */
	public static @Nullable String[] split(@Nullable String str,
			@Nullable String separatorChars, int max) {
		return splitWorker(str, separatorChars, max, false);
	}
    /**
	 * Performs the logic for the <code>split</code> and
	 * <code>splitPreserveAllTokens</code> methods that return a maximum array
	 * length.
	 * 
	 * @param str
	 *            the String to parse, may be <code>null</code>
	 * @param separatorChars
	 *            the separate character
	 * @param max
	 *            the maximum number of elements to include in the array. A zero
	 *            or negative value implies no limit.
	 * @param preserveAllTokens
	 *            if <code>true</code>, adjacent separators are treated as
	 *            empty token separators; if <code>false</code>, adjacent
	 *            separators are treated as one separator.
	 *
	 * from apache commons-lang:2.0
     *
	 * @return an array of parsed Strings, <code>null</code> if null String
	 *         input
	 */
	private static @Nullable String[] splitWorker(@Nullable String str,
			@Nullable String separatorChars, int max, boolean preserveAllTokens) {
		// Performance tuned for 2.0 (JDK1.4)
		// Direct code is quicker than StringTokenizer.
		// Also, StringTokenizer uses isSpace() not isWhitespace()

		if (str == null) { return null; }
		int len = str.length();
		if (len == 0) { return EMPTY_STRING_ARRAY; }
		List list = new ArrayList();
		int sizePlus1 = 1;
		int i = 0, start = 0;
		boolean match = false;
		boolean lastMatch = false;
		if (separatorChars == null) {
			// Null separator means use whitespace
			while (i < len) {
				if (Character.isWhitespace(str.charAt(i))) {
					if (match || preserveAllTokens) {
						lastMatch = true;
						if (sizePlus1++ == max) {
							i = len;
							lastMatch = false;
						}
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
					continue;
				} else {
					lastMatch = false;
				}
				match = true;
				i++;
			}
		} else if (separatorChars.length() == 1) {
			// Optimise 1 character case
			char sep = separatorChars.charAt(0);
			while (i < len) {
				if (str.charAt(i) == sep) {
					if (match || preserveAllTokens) {
						lastMatch = true;
						if (sizePlus1++ == max) {
							i = len;
							lastMatch = false;
						}
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
					continue;
				} else {
					lastMatch = false;
				}
				match = true;
				i++;
			}
		} else {
			// standard case
			while (i < len) {
				if (separatorChars.indexOf(str.charAt(i)) >= 0) {
					if (match || preserveAllTokens) {
						lastMatch = true;
						if (sizePlus1++ == max) {
							i = len;
							lastMatch = false;
						}
						list.add(str.substring(start, i));
						match = false;
					}
					start = ++i;
					continue;
				} else {
					lastMatch = false;
				}
				match = true;
				i++;
			}
		}
		if (match || (preserveAllTokens && lastMatch)) {
			list.add(str.substring(start, i));
		}
		return (String[]) list.toArray(new String[list.size()]);
	}
	
	// arrayToString
	// ------------------------------------------------------------------------
	/**
	 * <p>
	 * returns a String representations of <code>element</code>, expanding it
	 * if it is an array using the corresponding Arrays.toString(xxx) method.
	 * </p>
	 * <p>
	 * returns <code>"null"</code> if <code>element==null</code>.
	 * </p>
	 * <p>
	 * returns <code>element.toString()</code> if <code>element</code> is
	 * not an array as determined by element.getClass().isArray().
	 * </p>
	 * 
	 * @see Arrays#deepToString(java.lang.Object[]) for the implementation from
	 *      which this was derived.
	 */
	public static String deepToString(@Nullable Object element) {
		if (element == null) {
			return "null";
		} else {
			Class eClass = element.getClass();
			//OPTIMIZE use instanceof instead of reflection??
			if (eClass.isArray()) {
				if (eClass == byte[].class) {
					return (Arrays.toString((byte[]) element));
				} else if (eClass == short[].class) {
					return (Arrays.toString((short[]) element));
				} else if (eClass == int[].class) {
					return (Arrays.toString((int[]) element));
				} else if (eClass == long[].class) {
					return (Arrays.toString((long[]) element));
				} else if (eClass == char[].class) {
					return (Arrays.toString((char[]) element));
				} else if (eClass == float[].class) {
					return (Arrays.toString((float[]) element));
				} else if (eClass == double[].class) {
					return (Arrays.toString((double[]) element));
				} else if (eClass == boolean[].class) {
					return (Arrays.toString((boolean[]) element));
				} else { // element is an array of object references
					assert Object[].class.isAssignableFrom(eClass);
					return (Arrays.deepToString((Object[]) element));
				}
			} else { // element is non-null and not an array
				return element.toString();
			}
		}
	}
}
