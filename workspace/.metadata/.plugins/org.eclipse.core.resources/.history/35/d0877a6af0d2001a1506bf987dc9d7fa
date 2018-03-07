/*
 * CREATED ON:    Aug 11, 2005 4:46:35 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.METHOD;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * <p>
 * Generally tags a method of an object which takes no arguments and returns the
 * value of a final field of the same object. Note that the returned value often
 * may have writeable fields. If not returning a final field, the method should
 * return a value that for any particular instance of the enclosing class is
 * either reference '==' and/or '.equals' to all values returned at any time by
 * that method when invoked upon that particular instance.
 * </p>
 * 
 * @version $Id: ShallowConstant.java 570 2005-09-11 22:32:52Z bansil $
 * @author Amit Bansil
 */
@Target({METHOD})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface Constant {
//empty
}
