/*
 * CREATED ON:    Aug 11, 2005 4:48:39 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.TYPE;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * Tags a type that once instantiated does not change its state. Precisely, an
 * <code>Immutable</code> type is one that could be implemented with only
 * final fields of types that either are or could be <code>Immutable</code> or
 * are primitives. It is not uncommon, however, for actual implementations
 * to internally keep fields that are initialized lazily for performance
 * reasons.
 * 
 * @see java.lang.String which is a classic example of an <code>Immutable</code> type
 * @version $Id: Immutable.java 561 2005-09-08 01:27:22Z bansil $
 * @author Amit Bansil
 */
@Documented
@Target({TYPE})
@Retention(RetentionPolicy.SOURCE)
public @interface Immutable {
	//empty
}
