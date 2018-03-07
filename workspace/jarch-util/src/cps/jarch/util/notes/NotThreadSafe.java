/*
 * CREATED ON:    Sep 1, 2005 2:13:32 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.METHOD;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
//ERROR this is a bad idea, too vague...
/**
 * <p>
 * Explicity mark a method as not being safe for multi-threaded access.
 * Usually not needed since this is assumed. Only used in cases where a client
 * might expect that a method is {@link ThreadSafe}.
 * </p>
 * 
 * @see cps.jarch.util.misc.Worker for an example
 * @version $Id$
 * @author Amit Bansil
 */
@Target({METHOD})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface NotThreadSafe {
	//empty
}
