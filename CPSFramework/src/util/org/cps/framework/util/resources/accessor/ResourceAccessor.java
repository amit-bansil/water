/*
 * AbstractResourceAccessor.java
 * CREATED:    Aug 10, 2003 5:45:08 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.apache.commons.lang.ArrayUtils;
import org.cps.framework.util.resource.reader.ObjectReader;

import java.util.Map;
import java.util.MissingResourceException;

/**
 * Utility class for accessing internationalized resources.
 * values are guaruntted not to be null.
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class ResourceAccessor {
	//create
	public static final ResourceAccessor load(Class source){
		return AccessorLoader.getInstance().loadAccessor(source);
	}
	
	private final String resName;
	protected ResourceAccessor(String resName) {
		this.resName = resName;
	}
	//return null if not found
	protected abstract Object _get(String key,ObjectReader resReader);
	public abstract boolean hasKey(String key);
	//OPTIMIZE-
	public final boolean hasKeys(String[] keys) {
		for (int i = 0; i < keys.length; i++) {
			if (!hasKey(keys[i]))
				return false;
		}
		return true;
	}
	//check that a key is present. if it is not throws a missing resource exception
	public final void checkKey(String key) {
		getObject(key); //trivial implementation
	}
	
	//see ResourceBundle for the general contract of these methods
	//notice that they throw MissingResourceExceptions
	public final String getString(String key)throws MissingResourceException {
		return (String) getObject(key);
	}
	public final Object getObject(String key)throws MissingResourceException {
		return getObject(key,null);
	}
	public final <T> T getObject(String key,ObjectReader<T> resReader)throws MissingResourceException{
		T ret = (T)_get(key,resReader);
		if (ret == null) {
			throw new MissingResourceException(
				"Can't find resource!\n"+
					"\tkey="+key+"\n"+
					"\tbundle="+resName,
				resName,
				key);
		}
		return ret;
	}
	public final String getResourceName() {
		return resName;
	}
	/**
	 * returns prefixed resource accessor below this,
	 * if name is null or length zero returns this.
	 * @param name
	 * @return
	 */
	public final ResourceAccessor getChild(String name){
		if(name==null||name.length()==0) return this;
		else return new PrefixedResourceAccessor(this,name);
	}
	/**
	 * if data==null or is empty returns this.
	 * @param data map in org.apache.commons.collections.ArrayUtil.toMap format
	 * @return a composite resource accessor combing data with this.
	 */
	public final ResourceAccessor composite(Object[] data) {
		if(data==null||data.length==0)return this;
		else return composite(ArrayUtils.toMap(data));
	}
	public final ResourceAccessor composite(Map data) {
		return new CompositeResourceAccessor(this,
				new MapResourceAccessor("composition data",data,null));
	}
	/**
	 * @param overrider
	 * @return a resource accessor in which overriders values take the place of this object values
	 */
	public final ResourceAccessor override(ResourceAccessor overrider) {
		return new SubResourceAccessor(this,overrider);
	}
	/**
	 * overrides a specific key with a value
	 * @param key key to override
	 * @param value new value
	 * @return the new accessor
	 */
	public final ResourceAccessor override(String key,Object value) {
		return override(new SingleKeyResourceAccessor(key,value,key+"override"));
	}
}
