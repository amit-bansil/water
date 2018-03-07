/*
 * CREATED ON:    Aug 24, 2005 7:30:04 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.notes;

import static java.lang.annotation.ElementType.METHOD;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
//ERROR this is a bad idea, it adds very little...
/**
 * <p>
 * A <code>protected</code> method of a non final 'parent' class that is
 * <b>intended to be called only by the parent class</b>. They are usually used
 * to notify subclasses of an event and/or request a value. This helps to avoid
 * often awkward and delicate invocations of <code>super</code> methods caused
 * by overloading. As such, hooks are normally <code>abstract</code>.
 * Parents, however, may provide a default implementation. By convention their
 * name should be prefaced by an '_'. This prevents a name conflict with any
 * <code>public</code> method in the parent whose main purpose is to call the
 * hook. Parents should document the exact conditions under which a hook will be
 * called as well as what actions it should take. The default implementation, if
 * any, should also be explained. Hook implementations in classes that extend
 * parent classes should not be tagged as hooks unless they are meant to be
 * overridden.
 * </p>
 * <p>
 * See <code>cps.jarch.gui.builder.UIPanel._setActive(boolean)</code>
 * for an example.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id: Hook.java 570 2005-09-11 22:32:52Z bansil $
 */
@Target({METHOD})
@Retention(RetentionPolicy.SOURCE)
@Documented
public @interface Hook {
	// empty
}
