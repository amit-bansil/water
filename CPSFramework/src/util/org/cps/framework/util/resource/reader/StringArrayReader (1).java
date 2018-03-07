/*
 * StringArrayReader.java
 * CREATED:    Dec 20, 2003 10:14:56 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

import org.apache.commons.lang.StringUtils;

/**
 * Reader that handles String[]s tokenized by commas
 * @version 0.1
 * @author Amit Bansil
 */
public class StringArrayReader extends DefaultReader<String[]> {
	public static final StringArrayReader INSTANCE=new StringArrayReader();
	private StringArrayReader() {
	    //Do nothing
	}

	protected String[] _read(String data, String currentDirectory) {
		return StringUtils.split(data,',');
	}

}
