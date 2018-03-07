/**
 * <p>
 * General purpose utility classes.
 * To maximize stability, this components size and complexity has been minimized.
 * Algorithms are only added if many different packages use them.
 * They are small, simple, and self-contained. Particularly unstable, specific, or tiny 
 * code may be more effectively reused through copying between packages instead of 
 * integration into this layer.
 * </p>
 * <h3>Copying Code From This Layer</h3>
 * <p>
 * The convention for clients seeking to decrease their dependence on a class
 * in this components is that they copy the entire class into their
 * codebase. The class should either be renamed [project
 * package name][original class name] and placed as a public class in
 * the root of the project's package hierarchy, or made a
 * package private class at the root of the particular package that needs to be isolated.
 * For example <code>cps.jarch.util.misc.LangUtils</code> would become
 * either <code>edu.bu.cps.celest.brightness.BrighntessLangUtils</code> or
 * <code>edu.bu.cps.celest.brightness.canvas.LangUtils</code>. Usually this can be
 * done in Eclipse by closing all projects that are not used by the project meant to be
 * isolated and jArch-util, running a move and then a rename refactoring on
 * the desired class, and then reverting jArch-util. A note should be added at the bottom
 * of the heading javadoc explaining "This class was copied from the CPS jArch utility
 * layer class [original class name] [original class version]." Also list any changes made.
 * </p>
 * <h3>Dependencies</h3>
 * <p>
 * Some classes in this component are derived from Apache's commons-lang package.
 * See <a href="http://jakarta.apache.org/commons/lang/">
 * http://jakarta.apache.org/commons/lang/</a>. Note that the actual commons-lang package
 * is not referenced so as to keep this component as simple as possible, code was copied
 * as needed instead.
 * </p>
 * @version $Id: package-info.java 570 2005-09-11 22:32:52Z bansil $
 * @author Amit Bansil
 */
package cps.jarch.util;