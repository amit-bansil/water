/*
 * DefaultReader.java
 * CREATED:    Dec 20, 2003 10:11:34 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

import org.cps.framework.util.resources.loader.ResourceError;

/**
 * ResourceReader implementation that simplifies read to just handle string data
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class DefaultReader<T> implements ObjectReader<T> {
	public DefaultReader(){
	    //do nothing
	}
	public T read(Object data, String currentDirectory) {
		if(data instanceof String){
			try {
				return _read((String)data,currentDirectory);
			} catch (Throwable t) {
				throw new ResourceError("could not parse data:"+data,t);
			}
		}else{
		    try {
			    return (T)data;
			} catch (ClassCastException t) {
				throw new ResourceError("unexpected type for data:"+data,t);
			}
		}
	}
	protected abstract T _read(String data,String currentDirectory)throws Exception;
}
