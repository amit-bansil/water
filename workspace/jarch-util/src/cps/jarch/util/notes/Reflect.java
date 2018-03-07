/*
 * CREATED ON:    Aug 24, 2005 7:07:09 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.CONSTRUCTOR;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;
import static java.lang.annotation.ElementType.TYPE;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
//ERROR this is a bad idea, too specialized...
/**
 * <p>
 * Tag code that uses reflection. Often this use is very indirect, such as
 * calling into the java class libraries. Note that code that calls code tagged
 * as <code>Reflect</code> need not mark itself as such. Access of a type's
 * '.class' field, although also involving reflection, need not be tagged. This
 * is meant to help diagnosing problems reflection causes with performance and
 * obfuscation.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id: Reflect.java 570 2005-09-11 22:32:52Z bansil $
 */
@Target({METHOD, TYPE, FIELD, PARAMETER, CONSTRUCTOR})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface Reflect {
	//empty
}
