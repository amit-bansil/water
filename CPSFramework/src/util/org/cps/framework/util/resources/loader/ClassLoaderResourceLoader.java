/*
 * ClassLoaderResourceLoader.java
 * CREATED:    Aug 10, 2003 8:13:37 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.loader;

import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ClassLoaderResourceLoader extends ResourceLoader{
	public ClassLoaderResourceLoader() {
	    //do nothing
	}
	/* (non-Javadoc)
	 * @see org.cps.util.resources.ResourceLoader#getResourcesHook(java.lang.String)
	 */
	 private static final URL[] EMPTY_URL_ARRAY=new URL[0];
	 //TODO just return an enumeration for performance...
	protected URL[] _getResource(String name) {
		try {
			Enumeration<URL> ret=ResourceManager.getClassLoader().getResources(name);
			//OPTIMIZED for length==0||length==1
			if(ret==null||!ret.hasMoreElements()) return EMPTY_URL_ARRAY;
			URL first=ret.nextElement();
			if(!ret.hasMoreElements()) return new URL[]{first};
			else{
				List<URL> r=new ArrayList<URL>();
				r.add(first);
				do{
					r.add(ret.nextElement());
				}while(ret.hasMoreElements());
				return r.toArray(new URL[r.size()]);
			}
		} catch (IOException e) {
			return EMPTY_URL_ARRAY;
		}
		
	}

}
