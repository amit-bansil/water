/*
 * PrefixedResourceAccessor.java
 * CREATED:    Aug 13, 2003 12:25:37 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resource.reader.ObjectReader;


/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
class PrefixedResourceAccessor extends ResourceAccessor {
	private final String prefix;
	private final ResourceAccessor res;
	PrefixedResourceAccessor(ResourceAccessor bundle,String prefix) {
		super(bundle.getResourceName()+"["+prefix+"]");
		if(prefix==null||prefix.length()==0)throw new IllegalArgumentException("must specify prefix");
		if(prefix.endsWith("."))throw new IllegalArgumentException("prefix may not end with '.'");
		if(bundle==null) throw new NullPointerException("res not specified");
		this.prefix=prefix+".";
		this.res=bundle;
	}
	protected Object _get(String key,ObjectReader reader) {
		return res._get(prefix+key,reader);
	}
	public boolean hasKey(String key) {
		return res.hasKey(prefix+key);
	}

}
