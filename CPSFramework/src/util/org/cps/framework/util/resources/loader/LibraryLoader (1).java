/*
 * LibraryLoader.java
 * CREATED:    Dec 18, 2003 6:24:08 PM
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
public abstract class LibraryLoader {
	public abstract void loadLibrary(Class parent,String name) throws UnsatisfiedLinkError;
	//default instance
	//TODO progress,localize files stuck in jar
	private static final LibraryLoader DEFAULT=new LibraryLoader(){
		public void loadLibrary(Class parent,String name) throws UnsatisfiedLinkError {
			String libName = System.mapLibraryName(name);
			String resource =
				ResourceLoader.getInstance().getResource(
					(parent.getPackage().getName() + ".").replace('.', ResourceManager.JAR_SEPARATOR_CHAR) + libName)
					.getFile();
			System.load(resource);
		}
	};
	public static final LibraryLoader getInstance(){
		return (LibraryLoader)ResourceManager.getLoader(LibraryLoader.class,DEFAULT);
	}
}
