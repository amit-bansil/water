/*
 * CREATED ON:    Aug 11, 2005 4:53:08 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.TYPE;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * <p>
 * A class that has a single globally accessible instance. By convention,
 * singletons should define a <code>(public) static (final) getInstance()</code>
 * method which returns that instance. <code>getInstance()</code> may wish to
 * perform a lazy initialization, although often this provides little benefit
 * since static fields are usually not initialized until the containing class is
 * first accessed. Singletons often define static utility methods that simply call
 * their non static equivalent in getInstance().
 * </p>
 * 
 * @see cps.jarch.util.misc.LogEx specifically VerySimpleFormatter for a
 *      trivial example. A more complex case is cps.jarch.gui.util.EDTWorker.
 * @version $Id: Singleton.java 570 2005-09-11 22:32:52Z bansil $
 * @author Amit Bansil
 */
@Target({TYPE})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface Singleton {
	//empty
}