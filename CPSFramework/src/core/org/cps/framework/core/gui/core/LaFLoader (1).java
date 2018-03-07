/*
 * LaFLoader.java
 * CREATED:    Dec 21, 2003 3:48:49 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.core;

import org.cps.framework.util.resources.loader.ResourceManager;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class LaFLoader {
	//default instance
	private static final LaFLoader DEFAULT=new DefaultLaFLoader();
	public static final LaFLoader getInstance(){
		return (LaFLoader)ResourceManager.getLoader(LaFLoader.class,DEFAULT);
	}
	public abstract void setupUI();
}
