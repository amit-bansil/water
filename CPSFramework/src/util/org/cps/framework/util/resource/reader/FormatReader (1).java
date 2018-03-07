/*
 * DateReader.java
 * CREATED:    Dec 20, 2003 11:23:35 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

import java.text.Format;
import java.text.ParseException;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class FormatReader<T> extends DefaultReader<T> {
	private final Format format;
	public FormatReader(Format format) {
		this.format=format;
	}

	protected T _read(String data, String currentDirectory)
		throws ParseException {
		return (T)format.parseObject(data);
	}

}
