/*
 * CREATED ON:    Aug 22, 2005 12:44:35 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.PARAMETER;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Tag either a method whose return value could be <code>null</code> or a parameter
 * that can safely be set to <code>null</code> without always causing an
 * Exception. Unless the documentation states otherwise, any
 * method not declared as Nullable should never return a <code>null</code>
 * value, and, similarly, using <code>null</code> for any parameter that is
 * not explicitly Nullable should result in some kind of
 * exception or immediate failure, preferably a NullPointerException.
 * Local variables & class fields, cannot be tagged
 * as Nullable since they are usually not part of the class's specification.
 * 
 * @see cps.jarch.util.misc.LangUtils#checkArgNotNull(Object) for a test
 *      used frequently to enforce this condition. Note that often this is not needed
 *      since the code will fail in some other obvious place.
 * @version $Id: Nullable.java 570 2005-09-11 22:32:52Z bansil $
 * @author Amit Bansil
 */
@Target({PARAMETER, METHOD})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface Nullable {
	//empty
}
