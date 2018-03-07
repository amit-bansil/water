package org.cps.framework.core.util;

import org.cps.framework.util.resource.reader.DefaultReader;
import org.cps.framework.util.resource.reader.ObjectReader;

import java.awt.Container;

/*
 * HelpReference.java
 * CREATED:    Nov 13, 2003 3:13:19 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
/**
 * Stub for help framework
 * @version 0.1
 * @author Amit Bansil
 */
public class HelpReference {
	public static ObjectReader<HelpReference> READER=new DefaultReader<HelpReference>() {
		protected HelpReference _read(String data, String currentDirectory) {
			return new HelpReference(data);
		}
	};

	public HelpReference(String ref){
	    //TODO implement
	}
	public void showHelpPage(Container parent) {
		//TODO implement
		throw new UnsupportedOperationException();
	}
}
