/*
 * ResourceError.java
 * CREATED:    Dec 18, 2003 6:22:04 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.loader;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */

public class ResourceError extends Error {
	private String resName;
	public final void setResName(String name){
		if(resName!=UNDEFINED_RESNAME)throw new IllegalStateException("cannot resname once assigned");
		resName=name;
	}
	private static final String UNDEFINED_RESNAME="Unknown Resource";
	public ResourceError(String message,Throwable cause){
		this(message,UNDEFINED_RESNAME,cause);
	}
	public ResourceError(String message, String resName) {
		super(message);
		this.resName = resName;
	}
	public ResourceError(String message, String resName, Throwable cause) {
		super(message, cause);
		this.resName = resName;
	}
	public String toString() {
		return super.toString() + ";resource=" + resName;
	}
}