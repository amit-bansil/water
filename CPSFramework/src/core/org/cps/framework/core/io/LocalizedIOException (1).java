/*
 * LocalizedIOException.java
 * CREATED:    Dec 28, 2003 2:01:47 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;


import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.io.IOException;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class LocalizedIOException extends IOException {
	private static final ResourceAccessor res = ResourceAccessor.load(LocalizedIOException.class);
	private final String localMessage;
	public LocalizedIOException(String messageKey) {
		this(messageKey,null,null);
	}
	/**
	 * creates LocalizedIOException.
	 * @param messageKey requried
	 * @param data can be null or length 0
	 * @param cause can be null
	 */
	public LocalizedIOException(String messageKey,Object[][] data,Throwable cause) {
		super(messageKey);
		if(cause!=null) initCause(cause);
		ResourceAccessor r=res;
		//OPTIMIZE do this lazily
		localMessage=r.composite(data).getString(messageKey);
	}
	
	public String getLocalizedMessage() {
		return localMessage;
	}
}
