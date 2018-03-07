/*
 * ResourceAccessor.java
 * CREATED:    Jan 10, 2005 10:55:40 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.resources;

import javax.swing.Icon;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.misc.StringUtils;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.util.MissingResourceException;
import java.util.ResourceBundle;
//TODO finish these docs, this class is obscenely overcomplicated,
//should be split into a ResourceLoader class for getting resource streams associated with a package/class
//and a MessageBundle that wraps a ResourceLoader 
/**
 * <p>
 * Provides an abstraction layer and useful utilities for accessing resources
 * that are stored in the class path. Typically a class which wishes to access associated resources will
 * define a <code>ResourceAccessor</code> as follows.:
 * </p>
 * 
 * <pre>
 * private static final ResourceAccessor res = ResourceAccessor
 * 	.loadResources(SomeClass.class);
 * </pre>
 * 
 * <p>
 * <code>res</code> should then be used to access that class's resources.
 * String resources will be loaded from a SomeClass.properties file that should
 * be placed in the same package as SomeClass. Note that SomeClass.properties
 * may have a locale specific extension as specified in {@link ResourceBundle}.
 * Images/Icons will be loaded from a 
 * </p>
 * 
 * <p>
 * Since the underlying {@link java.util.ResourceBundle} is cached and instances
 * of <code>ResourceAccessor</code> are usually static, no caching of
 * <code>ResourceAccessor</code>'s or values is performed.
 * </p>
 * 
 * <p>
 * Resources are generally {@link cps.jarch.util.notes.Constant}s by nature.
 * </p>
 * 
 * <p>
 * Errors and missing resources are handled by logging a warning and returning a
 * dummy value so that all errors can be seen from a single run and software is
 * more resistant to totally failing if a resource is missing.
 * </p>
 * 
 * 
 * @author Amit Bansil
 * @version $Id: ResourceAccessor.java 541 2005-09-02 11:59:35Z bansil $
 */
public abstract class MessageBundle {
	private static final LogEx<MessageBundle> log = LogEx
		.createClassLog(MessageBundle.class);
	
	// ------------------------------------------------------------------------
	// creation
	/**
	 * Create MessageBundle for loading messages from properties file
	 * corresponding to owner. result is not cached.
	 */
	public static final MessageBundle create(Class owner) {
		log.debugEnterStatic("owner, hasIcons", owner);
		return new ResourceMessageBundle(owner);
	}
	/**
	 * character for separating elements of a resource's path.
	 */
	private static final char SEPARATOR_CHAR = '/';
	
	/**
	 * @return a <code>ResourceAccessor</code> that prefixes all keys with
	 *         <code>'.'+keyPrefix</code> or <code>this</code> if
	 *         <code>keyPrefix</code> is <code>null</code> or empty.
	 */
	@Constant public MessageBundle deriveChild(@Nullable String keyPrefix) {
		log.debugEnter(this, "keyPrefix", keyPrefix);
		if (keyPrefix == null || keyPrefix.length() == 0) return this;
		else return doDeriveChild(keyPrefix);
	}

	/**
	 * @return a ResourceAccessor that simply returns keys as values.
	 *         <code>loadImage</code> will fail and <code>tryLoadImage</code>
	 *         will return <code>null</code>. This method is meant for
	 *         prototyping, not production code, and thus it is deprecated.
	 */
	@Constant @Deprecated public static final MessageBundle getIdentity() {
		return IDENTITY;
	}

	private static final MessageBundle IDENTITY = new IdentityMessageBundle();
	// ------------------------------------------------------------------------
	private static final class ResourceMessageBundle extends MessageBundle{
		private final ResourceBundle bundle;//null means just return keys
		private final String bundlePath;
		private final String bundleName;
		private ImageLoader images;//null initially
		
		ResourceMessageBundle(Class owner){
			bundleName=owner.getSimpleName();
			bundlePath=owner.getPackage().getName().replace('.', SEPARATOR_CHAR);
			bundle=ResourceBundle.getBundle(bundlePath+SEPARATOR_CHAR+bundleName);
			//TODO add local specific extension to name so that it shows in to string here
		}

		@Override MessageBundle doDeriveChild(String keyPrefix) {
			return new ChildMessageBundle(this,keyPrefix);
		}
		@Override String doLoadString(String key) {
			try {
				return bundle.getString(key);
			} catch (ClassCastException e) {
				String s = bundle.getObject(key).toString();
				warnValueCorrupt(key, "expected string", s, e);
				return s;
			} catch (MissingResourceException e) {
				// OPTIMIZED for when almost all keys always have values
				// few tests for resource not present, otherwise would
				// preload log this for performance
				return null;
			}
		}
		
		
		@Override public @Nullable Icon tryLoadIcon(String key) {
			String name=tryLoadString(key);
			if(name==null)return null;
			if(images==null)
				images=new ImageLoader(new ResourceLoader(bundlePath));
			
			return images.tryLoadIcon(name);
		}
		
		//object methods
		@Override public String toString() {
			return "ResourceMessageBundle-"+bundlePath+SEPARATOR_CHAR+bundleName;
		}		
		@Override public int hashCode() {
			final int PRIME = 31;
			int result = 1;
			result = PRIME * result + ((bundleName == null) ? 0 : bundleName.hashCode());
			result = PRIME * result + ((bundlePath == null) ? 0 : bundlePath.hashCode());
			return result;
		}
		@Override public boolean equals(Object obj) {
			if (this == obj) return true;
			if (obj == null) return false;
			if (getClass() != obj.getClass()) return false;
			final ResourceMessageBundle other = (ResourceMessageBundle) obj;
			if (bundleName == null) {
				if (other.bundleName != null) return false;
			} else if (!bundleName.equals(other.bundleName)) return false;
			if (bundlePath == null) {
				if (other.bundlePath != null) return false;
			} else if (!bundlePath.equals(other.bundlePath)) return false;
			return true;
		}
	}
	private static final class ChildMessageBundle extends MessageBundle{
		private final String keyPrefix;//has trailing '.'
		private final MessageBundle parent;
		public ChildMessageBundle(MessageBundle parent, String keyPrefix) {
			this.keyPrefix=keyPrefix+'.';
			this.parent=parent;
		}
		@Override MessageBundle doDeriveChild(String keyPrefix) {
			return new ChildMessageBundle(parent,this.keyPrefix+keyPrefix);
		}
		@Override String doLoadString(String key) {
			return parent.doLoadString(keyPrefix+key);
		}
		@Override public Icon tryLoadIcon(String name) {
			return parent.tryLoadIcon(keyPrefix+name);
		}
		//object methods
		@Override public final String toString() {
			return parent.toString()+':'+keyPrefix;
		}
		@Override public int hashCode() {
			final int PRIME = 31;
			int result = 1;
			result = PRIME * result + ((keyPrefix == null) ? 0 : keyPrefix.hashCode());
			result = PRIME * result + ((parent == null) ? 0 : parent.hashCode());
			return result;
		}
		@Override public boolean equals(Object obj) {
			if (this == obj) return true;
			if (obj == null) return false;
			if (getClass() != obj.getClass()) return false;
			final ChildMessageBundle other = (ChildMessageBundle) obj;
			if (keyPrefix == null) {
				if (other.keyPrefix != null) return false;
			} else if (!keyPrefix.equals(other.keyPrefix)) return false;
			if (parent == null) {
				if (other.parent != null) return false;
			} else if (!parent.equals(other.parent)) return false;
			return true;
		}
		
	}
	private static final class IdentityMessageBundle extends MessageBundle{
		@Override MessageBundle doDeriveChild(String keyPrefix) {
			return this;
		}
		@Override String doLoadString(String key) {
			return null;
		}
		@Override public Icon tryLoadIcon(String name) {
			return null;
		}
		public @Override String toString() {
			return "IDENTITY";
		}
	}
	// ------------------------------------------------------------------------
	//hooks
	/**
	 * @return <code>String</code> value associated with <code>key</code> or
	 *         <code>null</code> no such value is defined. note that normally
	 *         no whitespace is stripped to allow leading spaces if needed.
	 */
	@Constant abstract @Nullable String doLoadString(String key);
	//prefix has no trailing '.'
	abstract MessageBundle doDeriveChild(@Nullable String keyPrefix);
	public abstract @Nullable Icon tryLoadIcon(String name);
	// ------------------------------------------------------------------------
	// string access
	// ------------------------------------------------------------------------

	/**
	 * @see MessageBundle#doLoadString(String)
	 * @return the <code>String</code> value associated with <code>key</code>
	 *         or <code>null</code> if no such value is defined.
	 */
	@Constant public final @Nullable String tryLoadString(String key) {
		return doLoadString(key);
	}

	/**
	 * @see MessageBundle#doLoadString(String)
	 * @return the value associated with key, not null. If none is defined key
	 *         is returned.
	 */
	@Constant public final String loadString(String key) {
		String ret = doLoadString(key);
		if (ret == null) {
			warnValueCorrupt(key, "value not found", null, null);
			return key;
		}
		return ret;
	}

	/**
	 * @return if this contains a String value for key. Faster to tryLoadString and deal
	 * with null case.
	 */
	@Constant public final boolean hasKey(String key) {
		return doLoadString(key) != null;
	}

	/**
	 * Load an array of <code>keys</code>, possibly converting them to
	 * <code>String</code>s if they are not already, and add
	 * <code>prefix</code> before each as well as <code>postfix</code>
	 * after. If a resolved key cannot be found a warning is printed and the key
	 * is used for its value.
	 * 
	 * @param prefix
	 *            defaults to <code>null</code>. Ignored if <code>null</code>.
	 * @param postfix
	 *            defaults to <code>null</code>. Ignored if <code>null</code>.
	 * 
	 * If no value is defined a key is used for value and a warning printed.
	 */
	@Constant public final String[] loadStringArray(@Nullable String prefix,
			Object[] keys, @Nullable String postfix) {
		String[] ret = new String[keys.length];

		String prefixStr = StringUtils.isBlank(prefix) ? "" : prefix + ".";

		for (int i = 0; i < keys.length; i++) {
			StringBuilder k = new StringBuilder(keys[i].toString());
			if (!StringUtils.isBlank(postfix)) {
				k.append('.');
				k.append(postfix);
			}
			ret[i] = loadString(prefixStr + k);
		}
		return ret;
	}
	@Constant public final String[] loadStringArray(@Nullable String prefix,
			Object[] keys) {
		return loadStringArray(prefix, keys, null);
	}

	
	// ------------------------------------------------------------------------
	// error reporting
	// ------------------------------------------------------------------------
	/**
	 * 
	 * log a warning explaining that the <code>value</code> obtained from
	 * <code>key</code> in this bundle is corrupt.
	 * 
	 * @param value
	 *            the string value associated with key, possibly
	 *            <code>null</code>, or an object created from it. defaults
	 *            to <code>tryLoadString(key)</code>
	 * @param t
	 *            the exception that caused the error, possibly
	 *            <code>null</code>.
	 * 
	 */
	public final void warnValueCorrupt(String key, String msg, @Nullable Object value,
			@Nullable Throwable t) {
		LangUtils.checkArgNotNull(key, "key");
		LangUtils.checkArgNotNull(msg, "msg");
		log.warning(this, "Value Corrupt: {0}" + "\n  key    =''{1}''"
				+ "\n  value  =''{2}''", t, msg, key, value);
	}

	public final void warnValueCorrupt(String key){
		warnValueCorrupt(key, null, tryLoadString(key), null);
	}

}
