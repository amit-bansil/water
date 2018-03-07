/*
 * CREATED ON:    Dec 22, 2005 5:25:42 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.CONSTRUCTOR;
import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * <p>
 * Tags a method method which simply provides a default value for a parameter.
 * Such methods should call another method in the same class with the same name,
 * simply passing the default value or performing the equivalent function. The target
 * method should document the default value. Such methods should precede their targets
 * and do not need to be documented.
 * </p>
 * @version $Id: UsesDefault.java 94 2006-01-23 10:13:13Z bansil $
 * @author Amit Bansil
 */

@Target({METHOD,CONSTRUCTOR})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface UsesDefault {
	//empty
}
