/*
 * IntReader.java
 * CREATED:    Dec 20, 2003 10:22:03 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

/**
 * DefaultReader that handles integers
 * @version 0.1
 * @author Amit Bansil
 */
public class IntReader extends DefaultReader<Integer> {
	private final int min,max;
	public IntReader(int min,int max) {
		this.min=min;
		this.max=max;
	}
	protected Integer _read(String data, String currentDirectory) {
		Integer ret=new Integer(data);
		int r=ret.intValue();
		if(r<min||r>max)throw new IllegalArgumentException(r+" not in ["+min+","+max+"]");
		return ret;
	}

}
