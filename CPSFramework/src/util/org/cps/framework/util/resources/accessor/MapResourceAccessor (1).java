/*
 * ResourceAccessor.java
 * CREATED:    Aug 8, 2003 8:34:54 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resource.reader.ObjectReader;
import org.cps.framework.util.resources.loader.ResourceError;

import java.util.Map;

/**
 * Map backed implementation that
 * @version 0.1
 * @author Amit Bansil
 */
public class MapResourceAccessor extends ResourceAccessor {
	private final Map resMap;
	private final String resourceDir;
	//be careful not to mess with data after creation...
	//TODO prevent data from being changeds
	public MapResourceAccessor(String resName, Map data,String resourceDir) {
		super(resName);
		resMap=data;
		this.resourceDir=resourceDir;
	}
	public final boolean hasKey(String key) {
		return resMap.containsKey(key);
	}

	/* (non-Javadoc)
	 * @see org.cps.util.resources.AbstractResourceAccessor#_get(java.lang.String)
	 */
	protected Object _get(String key,ObjectReader reader) {
		try{
			Object r=resMap.get(key);
			return reader!=null&&r!=null?reader.read(r,resourceDir):r;
		}catch(ResourceError e){
			e.setResName(getResourceName());
			throw e;
		}
	}
	
}
