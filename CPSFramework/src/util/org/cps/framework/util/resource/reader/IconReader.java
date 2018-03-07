/*
 * IconReader.java
 * CREATED:    Dec 20, 2003 10:17:57 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

import org.cps.framework.util.resources.loader.IconLoader;

import javax.swing.Icon;

/**
 * DefaultReader that reads imageicon from {currentDirectory}\images\{data}
 * @version 0.1
 * @author Amit Bansil
 */
public class IconReader extends DefaultReader<Icon> {
	public static final IconReader INSTANCE=new IconReader();
	private IconReader() {
	    //Do nothing
	}
	protected Icon _read(String data, String currentDirectory) {
		return IconLoader.getIcon(currentDirectory+IconLoader.IMAGES_DIR+data);
	}

}
