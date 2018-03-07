/*
 * IO.java
 * CREATED:    Dec 20, 2003 2:06:38 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resource.reader;

/**
 * Handles creation of an object from some data
 * CurrentDirectory may be null.
 * @version 0.1
 * @author Amit Bansil
 */
public interface ObjectReader<T> {
	public T read(Object data,String currentDirectory);
}
