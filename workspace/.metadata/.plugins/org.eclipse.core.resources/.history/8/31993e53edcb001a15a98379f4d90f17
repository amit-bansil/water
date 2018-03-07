/*
 * MiscUtils.java
 * CREATED:    Jan 10, 2005 5:04:09 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.util.misc;

import java.util.Arrays;

import cps.jarch.util.notes.Nullable;

/**
 * <p>
 * Very basic static utility methods. Contains only methods used by a massive
 * number of classes. An excellent candidate to in-line (see component
 * documentation for how to do this). All of these methods are thread safe
 * although they have not been tagged as such to make them easier to in-line
 * into code that does not use this package.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id: LangUtils.java 536 2005-09-01 21:33:07Z bansil $
 */
public final class LangUtils {
    /**
	 * <p>
	 * Compares two objects for equality, where either one or both objects may
	 * be <code>null</code>.
	 * </p>
	 * 
	 * <pre>
	 *  LangUtils.equals(null, null)                  			== true
	 *  LangUtils.equals(null, &quot;&quot;)                    == false
	 *  LangUtils.equals(&quot;&quot;, null)                    == false
	 *  LangUtils.equals(&quot;&quot;, &quot;&quot;)            == true
	 *  LangUtils.equals(Boolean.TRUE, null)          			== false
	 *  LangUtils.equals(Boolean.TRUE, &quot;true&quot;)        == false
	 *  LangUtils.equals(Boolean.TRUE, Boolean.TRUE)  			== true
	 *  LangUtils.equals(Boolean.TRUE, Boolean.FALSE) 			== false
	 * </pre>
	 * 
	 * <p>
	 * derived from org.apache.commons.lang.ObjectUtils#equals(java.lang.Object,
	 * java.lang.Object).
	 * </p>
	 * 
	 * @param a
	 *            the first object, may be <code>null</code>
	 * @param b
	 *            the second object, may be <code>null</code>
	 *            
	 * @return <code>true</code> if the values of both objects are the same
	 */
	public static final boolean equals(@Nullable Object a,@Nullable Object b) {
		//optimized
		
		//this takes both the case where both a & b are null as well as the case
		//where they are the same object
        if (a == b) {
            return true;
        }
        
        //now since we know both a & b are not null we know is one is they are different
        if ((a == null) || (b == null)) {
            return false;
        }
        
        return a.equals(b);
	}
	/**
	 * Validate that the argument to a method which takes 1 argument is not
	 * <code>null</code>.
	 * 
	 * @see cps.jarch.util.notes.Nullable for best practices regarding
	 *      <code>null</code> arguments
	 * 
	 * @param arg
	 *            the argument to test as not being <code>null</code>.
	 * @throws NullPointerException
	 *             if <code>arg==null</code>
	 */
	public static final void checkArgNotNull(Object arg) {
        if (arg == null) {
            throw new NullPointerException("argument must not be null");
        }
	}
	/**
	 * Validate that the argument named <code>argName</code> to a method which
	 * takes multiple argument is not <code>null</code>.
	 * 
	 * @see cps.jarch.util.notes.Nullable for best practices regarding
	 *      <code>null</code> arguments
	 * @param arg
	 *            the argument to test as not being <code>null</code>. For
	 *            performance reasons a blank/<code>null</code> argName is
	 *            allowed iff <code>arg!=null</code> but should not be used.
	 * @param argName
	 *            the name of the argument being tested.
	 * 
	 * @throws NullPointerException
	 *             if <code>arg==null</code>
	 * 
	 * @throws Error
	 *             if <code>StringUtils.isBlank(argName)</code>. only checked
	 *             if <code>arg==null</code> however.
	 */
	public static final void checkArgNotNull(Object arg,String argName) {
        if (arg == null) {
        	if(StringUtils.isBlank(argName))
        		throw new Error("unexpected blank argName");
            throw new NullPointerException("argument '"+argName+"' must not be null");
        }
	}
	// ------------------------------------------------------------------------

	//OPTIMIZE manually inline
	public static final int hashCode(Object a) {
		return a==null?0:a.hashCode();
	}
	public static final int hashCode(Object a,Object b) {
		return (hashCode(a)+31)*31+hashCode(b);
	}
	public static final int hashCode(Object a,Object b,Object c) {
		return (hashCode(a,b)+31)*31+hashCode(c);
	}
	public static final int hashCode(Object a,Object b,Object c,Object e) {
		return (hashCode(a,b,c)+31)*31+hashCode(b);
	}
	/**
	 * @return optimized calculation of <code>Arrays.hashCode(a)</code>.
	 */
	public static final int hashCode(Object... a) {
		return Arrays.hashCode(a);
	}
}
