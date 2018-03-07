/*
 * CREATED ON:    Sep 1, 2005 2:06:26 PM
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
 * Tags a method as well as any other ThreadSafe methods in the
 * same class as being safely callable from multiple threads at once. By
 * 'safely' it is meant that the result is defined, even if this result is
 * always an exception. If this tag is not present a method should be assumed to
 * be {@link NotThreadSafe} unless the documentation states otherwise. Even if
 * the particular implementation seems ThreadSafe clients should not depend on
 * this behavior being preserved in later releases. It is intentionally not
 * possible to tag an entire type as ThreadSafe since it is
 * unclear what this would mean. This also helps remind implementors 
 * to ensure that for each method the implementation is in fact thread safe.
 * </p>
 * 
 * @see cps.jarch.util.misc.Worker for an example
 * @version $Id$
 * @author Amit Bansil
 */

@Target({METHOD})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface ThreadSafe {
	//empty
}
