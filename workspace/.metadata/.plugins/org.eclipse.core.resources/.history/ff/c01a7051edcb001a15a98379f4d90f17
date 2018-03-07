/*
 * ScientificFormat.java
 * CREATED:    Mar 18, 2005 5:36:07 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-simulation
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.simulation.math;
import java.math.BigDecimal;
import java.text.FieldPosition;
import java.text.Format;
import java.text.ParsePosition;

/**
 * This code formats numbers in Scientific Notation. The input Number object is
 * returned as a ScientificFormated string. There are two output styles: Pure
 * and Standard scientific notation. Pure formatted numbers have precisely the
 * number of digits specified by the significant digits (sigDig) parameter and
 * always specify a Base 10 Exponential(E). Standard formated numbers have the
 * number of digits specified by the significant digits (sigDig) parameter but
 * will not have a Base 10 Exponential(E) if the number of digits in the
 * mantissa <= maxWidth.
 * 
 * @author Paul Spence
 * @author Mark Donszelmann
 * @version $Id: ScientificFormat.java 484 2005-08-17 06:38:30Z bansil $
 */

//@SuppressWarnings({"ALL"})
public class ScientificFormat extends Format {
	//TODO proper test
	static {
		assert roundSigFigs(123.456,3)==123;
		assert roundSigFigs(123.456,4)==123.5;
		assert roundSigFigs(123.456,1)==100;
		assert roundSigFigs(123.456,7)==123.456;
		assert roundSigFigs(.000123456,1)==.0001;
		assert roundSigFigs(.000123456,11)==.000123456;
	}
	public static final double roundSigFigs(double d,int numFigs) {
		if(numFigs<1)throw new IllegalArgumentException("<1 sigFigs??");
		if(Double.isInfinite(d))return d;
		if(Double.isNaN(d))return d;
		
		double exp=Math.floor(Math.log10(d));
		exp-=numFigs-1;
		double c=Math.pow(10,exp);
		
		double ret=Math.round(d/c)*c;
		if(Double.isNaN(ret)) {
			//ERROR we should not need this hack
			return d;
		}
		return ret;
	}
	//AB 8-19-04 some instances
	public static final ScientificFormat SHORT_INSTANCE=
		new ScientificFormat(3,5,false);
	public static final ScientificFormat LONG_INSTANCE=
		new ScientificFormat(5,8,false);
	/**
	 * The number of significant digits the number is formatted to is recorded
	 * by sigDigit. The maximum width allowed fro the returned String is
	 * recorded by MaxWidth
	 */
	private int sigDigit = 5;

	private int maxWidth = 8;

	private boolean SciNote = false; //set to true for pure Scientific Notation

	/**
	 * Sets the significant digits, maximum allowable width and number
	 * formatting style (SciNote == true for Pure formatting).
	 */
	public ScientificFormat(int sigDigit, int maxWidth, boolean SciNote) {
		setSigDigits(sigDigit);
		setMaxWidth(maxWidth);
		setScientificNotationStyle(SciNote);
	}

	/**
	 * Implementation of inherited abstract method. Checks to see if object to
	 * be formatted is of type Number. If so casts the Number object to double
	 * and calls the format method. Returns the result.
	 */
	@Override
	public StringBuffer format(Object obj, StringBuffer toAppendTo,
			FieldPosition pos) {
		if (obj instanceof Number) {
			String result = format(((Number) obj).doubleValue());
			return toAppendTo.append(result);
		} else
			throw new IllegalArgumentException(
					"Cannot format given Object as a Number");
	}

	/**
	 * Dummy implementation of inherited abstract method.
	 */
	@Override
	public Object parseObject(String source, ParsePosition pos) {
		return null;
	}

	/**
	 * Returns the number of significant digits
	 */
	public int getSigDigits() {
		return sigDigit;
	}

	/**
	 * Returns the maximum allowable width of formatted number excluding any
	 * exponentials
	 */
	public int getMaxWidth() {
		return maxWidth;
	}

	/**
	 * Returns the formatting style: True means Pure scientific formatting,
	 * False means standard.
	 */
	public boolean getScientificNotationStyle() {
		return SciNote;
	}

	/**
	 * Sets the number of significant digits for the formatted number
	 */
	public void setSigDigits(int SigDigit) {
		if (SigDigit < 1) throw new IllegalArgumentException("sigDigit");
		sigDigit = SigDigit;
	}

	/**
	 * Sets the maximum allowable length of the formattted number mantissa
	 * before exponential notation is used.
	 */
	public void setMaxWidth(int mWidth) {
		if (mWidth < 3) throw new IllegalArgumentException("maxWidth");
		maxWidth = mWidth;
	}

	/**
	 * Sets the format style used. There are two output styles: Pure and
	 * Standard scientific notation. Pure formatted numbers have precisely the
	 * number of digits specified by the significant digits (sigDig) parameter
	 * and always specify a Base 10 Exponential(E). Standard formated numbers
	 * have the number of digits specified by the significant digits (sigDig)
	 * parameter but will not have a Base 10 Exponential(E) if the number of
	 * digits in the mantissa <= maxWidth.
	 */
	public void setScientificNotationStyle(boolean sciNote) {
		SciNote = sciNote;
	}

	//simplify method for taking log base 10 of x
	private final static double k = 1 / Math.log(10);

	private double Log10(double x) {
		if (x == 0) return 0;
		else
			return Math.log(x) * k;
	}

	private int resolveErrorSigDigit(double x, double dx) {
		//dx should never be negative
		dx = Math.abs(dx);
		//make x +ve cause negative doesn't effect sigdigits
		x = Math.abs(x);

		//these circumstances errorsigdit does equal sigdigit, excluding
		// infinity and Nan which are handled by format
		if (dx == 0 || Double.isInfinite(dx) || Double.isNaN(dx) || dx >= x)
				return sigDigit;

		//fail cases for log, method fails to handle
		if (x == 0 || Double.isInfinite(x) || Double.isNaN(x)) return sigDigit;

		//other wise solve for cases when dx< x
		int log = (int) Math.round(Log10(dx / x));//always will return negative
												  // number
		int errorsigdigit = sigDigit + log;
		if (errorsigdigit < 1) return 1;
		return errorsigdigit;
	}

	/**
	 * Format the number using scientific notation
	 */
	//{ab 8-19-04, use unicode chars rather than strings
	//undetermined is empty set sign
	private static final String UNDETERMINED='\u00D8'+"",INFINITY='\u221E'+"";
	public String format(double d) {
		// Deal with a few special values first
		if (Double.isInfinite(d)) {
			if(d>0) return INFINITY;
			else return "-"+INFINITY;
		}
		if (Double.isNaN(d)) return UNDETERMINED;

		String result = "";
		double c = 0;
		int ShiftNumber = 0;
		int IntOfNumberinput = 0;

		//preserve sign
		if (d == 0) return "0";
		else {
			c = d;
			d = Math.abs(c);
		}

		// (i.e. 10 -> 1, 100 -> 2,9 -> 0 , .9 -> -1, .0009 -> -4)
		//error here 10 -> 1.0000 floors to 0
		IntOfNumberinput = (int) Math.floor(Log10(d));//returns largest int
													  // value that is smaller
													  // than log10(d)

		//deal with above error
		if ((IntOfNumberinput > -1)
				&& (d % (Math.pow(10, IntOfNumberinput + 1)) == 0)) {
			IntOfNumberinput++;
		}

		//if 0<d<1 then log10(d)is neg, IntofNumberinput is negative
		if (Log10(d) < 0) {
			ShiftNumber = sigDigit - IntOfNumberinput - 1;
		} else {
			ShiftNumber = sigDigit - IntOfNumberinput;
		}

		//outputs num with all sigdigs to right of decimal place or rounded up
		// one extra
		long temp = Math.round(Math.pow(10, ShiftNumber) * d);
		String Formatted = String.valueOf(temp);

		//check rounding method, if neccessary add 1 to IntOfNumberinput
		BigDecimal tempbunk = new BigDecimal(Math.pow(10, ShiftNumber) * d);
		long bunk = tempbunk.longValue();
		String Formattedbunk = String.valueOf(bunk);

		if (Formatted.length() > Formattedbunk.length()) {
			IntOfNumberinput++;
		}

		//Do not display in pure sci notattion - limit use of E
		if (SciNote == false) {
			if (IntOfNumberinput < 0) {
				String LoopZero1 = "";
				for (int a = 0; a < (Math.abs(IntOfNumberinput) - 1); a++) {
					LoopZero1 = LoopZero1 + "0";
				}
				result = "0" + "." + LoopZero1 + Formatted;

			}

			else {
				String[] FillDigits = new String[IntOfNumberinput + 1];
				for (int a = 0; a <= IntOfNumberinput; a++) {
					FillDigits[a] = "0";
				}

				int a = 0;

				while ((a < Formatted.length()) && a <= IntOfNumberinput) {
					FillDigits[a] = Formatted.substring(a, a + 1);
					a++;
				}

				for (int i = 0; i <= FillDigits.length - 1; i++) {
					result = result + FillDigits[i];
				}

				int length = result.length();

				if (length < sigDigit) {
					String resultaddon = "";
					int i = -1;
					if (IntOfNumberinput == 0) {
						while (length < sigDigit) {
							resultaddon = resultaddon
									+ Formatted.substring(result.length() + i
											+ 1, result.length() + i + 2);
							length++;
							i++;
						}
					} else {
						i = 0;
						while (length < sigDigit) {
							resultaddon = resultaddon
									+ Formatted.substring(result.length() + i,
											result.length() + i + 1);
							length++;
							i++;
						}
					}

					result = result + "." + resultaddon;
				}
			}

			if (result.length() > maxWidth) {
				result = Formatted.substring(0, 1) + "."
						+ Formatted.substring(1, sigDigit) + "E"
						+ IntOfNumberinput;
			}
		}

		//output in pure Scientific Notation
		if (SciNote == true) {
			result = Formatted.substring(0, 1) + "."
					+ Formatted.substring(1, sigDigit) + "E" + IntOfNumberinput;
		}

		//regain negative and return
		if (c > 0) return result;
		else
			return "-" + result;

	}

	/**
	 * Format the number using scientific notation
	 */
	public String formatError(double d, double dx) {
		return formatError(resolveErrorSigDigit(d, dx), dx);
	}

	/**
	 * Format the number using scientific notation
	 */
	public String formatError(int eSD, double d) {
		// Deal with a few special values first
		if (Double.isInfinite(d)) return maxWidth < 8 ? "INF" : "Infinite";
		if (Double.isNaN(d)) return "NaN";

		int errorSigDigit = eSD;

		String result = "";
		double c = 0;
		int ShiftNumber = 0;
		int IntOfNumberinput = 0;

		//preserve sign
		if (d == 0) return "0";
		else {
			c = d;
			d = Math.abs(c);
		}

		// (i.e. 10 -> 1, 100 -> 2,9 -> 0 , .9 -> -1, .0009 -> -4)
		//error here 10 -> 1.0000 floors to 0
		IntOfNumberinput = (int) Math.floor(Log10(d));//returns largest int
													  // value that is smaller
													  // than log10(d)

		//deal with above error
		if ((IntOfNumberinput > -1)
				&& (d % (Math.pow(10, IntOfNumberinput + 1)) == 0)) {
			IntOfNumberinput++;
		}

		//if 0<d<1 then log10(d)is neg, IntofNumberinput is negative
		if (Log10(d) < 0) {
			ShiftNumber = errorSigDigit - IntOfNumberinput - 1;
		} else {
			ShiftNumber = errorSigDigit - IntOfNumberinput;
		}

		//outputs num with all sigdigs to right of decimal place or rounded up
		// one extra
		long temp = Math.round(Math.pow(10, ShiftNumber) * d);
		String Formatted = String.valueOf(temp);

		//check rounding method, if neccessary add 1 to IntOfNumberinput
		BigDecimal tempbunk = new BigDecimal(Math.pow(10, ShiftNumber) * d);
		long bunk = tempbunk.longValue();
		String Formattedbunk = String.valueOf(bunk);

		if (Formatted.length() > Formattedbunk.length()) {
			IntOfNumberinput++;
		}

		//Do not display in pure sci notattion - limit use of E
		if (SciNote == false) {
			if (IntOfNumberinput < 0) {
				String LoopZero1 = "";
				for (int a = 0; a < (Math.abs(IntOfNumberinput) - 1); a++) {
					LoopZero1 = LoopZero1 + "0";
				}
				result = "0" + "." + LoopZero1 + Formatted;

			}

			else {
				String[] FillDigits = new String[IntOfNumberinput + 1];
				for (int a = 0; a <= IntOfNumberinput; a++) {
					FillDigits[a] = "0";
				}

				int a = 0;

				while ((a < Formatted.length()) && a <= IntOfNumberinput) {
					FillDigits[a] = Formatted.substring(a, a + 1);
					a++;
				}

				for (int i = 0; i <= FillDigits.length - 1; i++) {
					result = result + FillDigits[i];
				}

				int length = result.length();

				if (length < errorSigDigit) {
					String resultaddon = "";
					int i = -1;
					if (IntOfNumberinput == 0) {
						while (length < errorSigDigit) {
							resultaddon = resultaddon
									+ Formatted.substring(result.length() + i
											+ 1, result.length() + i + 2);
							length++;
							i++;
						}
					} else {
						i = 0;
						while (length < errorSigDigit) {
							resultaddon = resultaddon
									+ Formatted.substring(result.length() + i,
											result.length() + i + 1);
							length++;
							i++;
						}
					}

					result = result + "." + resultaddon;
				}
			}

			if (result.length() > maxWidth) {
				result = Formatted.substring(0, 1) + "."
						+ Formatted.substring(1, errorSigDigit) + "E"
						+ IntOfNumberinput;
			}
		}

		//output in pure Scientific Notation
		if (SciNote == true) {
			result = Formatted.substring(0, 1) + "."
					+ Formatted.substring(1, errorSigDigit) + "E"
					+ IntOfNumberinput;
		}

		//regain negative and return
		if (c > 0) return result;
		else
			return "-" + result;

	}

}