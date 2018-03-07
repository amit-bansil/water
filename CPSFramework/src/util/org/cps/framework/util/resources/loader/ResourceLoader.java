/*
 * ResourceLoader.java
 * CREATED:    Aug 10, 2003 8:09:49 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.loader;

import java.net.URL;

/**
 * The gloabl resourceloader can only be set before it is accessed.
 * if it accessed before it is set a default will be assigned.
 * all methods are thread safe.
 * 
 * the main class should assign it in a static block for custom functionality
 * 
 * resource names should be valid jarpaths.
 * 
 * TODO progress
 * @version 0.1
 * @author Amit Bansil
 */

public abstract class ResourceLoader {
	//default instance
	private static final ResourceLoader DEFAULT=new ClassLoaderResourceLoader();
	public static final ResourceLoader getInstance(){
		return (ResourceLoader)ResourceManager.getLoader(ResourceLoader.class,DEFAULT);
	}
	/**
	 * never null
	 * @param name
	 * @return
	 * @throws ResourceError if not found or multiple
	 */
	public final URL getResource(String name) throws ResourceError {
		URL[] ret = getResources(name);
		if (ret.length != 1){
			if(ret.length==0)throw new ResourceError("Resource not found",name);
			throw new ResourceError(
				"expected 1 resource but found " + ret.length,
				name);
		}
		return ret[0];
	}

	/**
	 * returns url[] length may be zero but never null
	 * length might 0 but never null
	 */
	private static final URL[] EmtpyURLArray = new URL[0];
	public final URL[] getResources(String name) {
		if (name == null)
			throw new NullPointerException();
		URL[] ret = _getResource(name);
		if (ret == null)
			return EmtpyURLArray;
		else
			return ret;
	}
	/**
	 * returns true if getResource is possible
	 * @param name
	 * @return
	 */
	public boolean hasResource(String name) {
		return getResources(name).length != 0;
	}
	//like classLoader.getresource,but no specified loader
	protected abstract URL[] _getResource(String name);
}
