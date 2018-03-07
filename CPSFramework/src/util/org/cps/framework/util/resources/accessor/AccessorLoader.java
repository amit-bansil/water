/*
 * PropertiesLoader.java
 * CREATED:    Dec 20, 2003 12:21:34 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resources.loader.ResourceManager;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
abstract class AccessorLoader {
	//default instance
	/*
	 * todo progress,localize files stuck in jar
	 * @param name
	 * @throws UnsatisfiedLinkError
	 */
	private static final AccessorLoader DEFAULT = new DefaultAccessorLoader();
	public static final AccessorLoader getInstance() {
		return (AccessorLoader) ResourceManager.getLoader(
			AccessorLoader.class,
			DEFAULT);
	}

	public final ResourceAccessor loadAccessor(Class source) {
		return loadAccessor(ResourceManager.resolveName(source));
	}
	/*
	 * loads a ResourceBundle. mostly to avoid classes from having to decide on correct classloader
	 * @param string
	 * @return
	 */
	public abstract ResourceAccessor loadAccessor(String name);
}
