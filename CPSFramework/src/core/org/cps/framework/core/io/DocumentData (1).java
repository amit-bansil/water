/*
 * Saveable.java
 * CREATED:    Aug 17, 2003 1:44:12 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;


/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public interface DocumentData extends SaveableData{
	/**
	 * restore initial state.
	 * can get called after failed load...
	 */
	public void loadBlank();
}
