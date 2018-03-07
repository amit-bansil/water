/*
 * CREATED ON:    Jan 22, 2006 7:49:12 PM
 * CREATED BY:    bansil 
 */
/*
 * CREATED ON:    Nov 26, 2005 8:23:20 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.resources;

import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Immutable;

/**
 * <p>
 * An immutable <code>String</code> of only lower case letters, numbers,
 * dashes, & periods. Used to identify objects. must have length > 0.
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public @Immutable class Name {
	/**
	 * used to separate 'elements' of a name, like in 1.0-dev-snapshot-r123, which would be 
	 * considered a single name composed of 4 elements.
	 */
	public static final String SEPARATOR="-";
	
	private final String name;
	/**
	 * test if <code>s</code>contains illegal characters or is empty.
	 */
	public static final boolean isName(String s) {
		if(s.length()==0)return false;
		for(int i=0;i<s.length();i++) {
			char c=s.charAt(i);
			if(Character.isLetter(c)&&Character.isLowerCase(c))continue;
			if(Character.isDigit(c))continue;
			if(c=='.'||c=='-')continue;
			return false;
		}
		return true;
	}
	/**
	 * @throws IllegalArgumentException if <code>!isName(name)</code>
	 */
	public static final void checkIsName(String name)throws NotANameException {
		if (!isName(name))
			throw new NotANameException(name);
	}
	public static final Name laxCreate(String name)throws NotANameException {
		return new Name(name.toLowerCase());
	}
	/**
	 * creates Name.
	 * @throws IllegalArgumentException if <code>!isName(name)</code>.
	 */
	public Name(String name)throws NotANameException {
		checkIsName(name);
		this.name=name;
	}
	public @Constant String get() {
		return name;
	}
	@Override public @Constant String toString() {
		return name;
	}
	@Override public final boolean equals(Object o) {
		if(o==this)return true;
		if(o==null)return false;
		
		Name b=(Name)o;
		return b.name.equals(name);
	}
	@Override public final int hashCode() {
		return name.hashCode();
	}
	//TODO document
	public static final class NotANameException extends Exception {
		public NotANameException(String name) {
			super("name '" + name
					+ "' contains illegal characters or is empty");
		}
	}

}
