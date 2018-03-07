/*
 * SingleKeyResourceAccessor.java
 * CREATED:    Dec 28, 2003 2:41:09 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resource.reader.ObjectReader;

/**
 * a resource accessor that holds a single key and value.
 * @version 0.1
 * @author Amit Bansil
 */
public class SingleKeyResourceAccessor extends ResourceAccessor {
	private final String key;
	private final Object value;
	
	/**
	 * creates SingleKeyResourceAccessor.
	 * @param key
	 * @param value
	 * @param resName
	 */
	public SingleKeyResourceAccessor(String key,Object value,String resName) {
		super(resName);
		this.key=key;
		this.value=value;
	}

	/**
	 * @see org.cps.framework.util.resources.accessor.ResourceAccessor#_get(java.lang.String, org.cps.framework.util.resource.reader.ObjectReader)
	 * @param key_p
	 * @param resReader
	 * @return
	 */
	protected Object _get(String key_p, ObjectReader resReader) {
		if(key_p.equals(this.key)) {
			if(resReader!=null) return resReader.read(value,null);
			else return value;
		}else {
			return null;
		}
	}

	/**
	 * @see org.cps.framework.util.resources.accessor.ResourceAccessor#hasKey(java.lang.String)
	 * @param key_p
	 * @return
	 */
	public boolean hasKey(String key_p) {
		return this.key.equals(key_p);
	}

}
