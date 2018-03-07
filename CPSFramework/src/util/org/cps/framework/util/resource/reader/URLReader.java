/*
 * URLReader.java
 * CREATED:    Dec 20, 2003 11:14:51 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

import java.net.MalformedURLException;
import java.net.URL;

/**
 * Default Reader that reads URLs
 * @version 0.1
 * @author Amit Bansil
 */
public class URLReader extends DefaultReader<URL> {
	public static final URLReader INSTANCE=new URLReader();
	private URLReader() {
	    //Do nothing
	}
	protected URL _read(String data, String currentDirectory)
		throws MalformedURLException {
		return new URL(data);
	}

}
