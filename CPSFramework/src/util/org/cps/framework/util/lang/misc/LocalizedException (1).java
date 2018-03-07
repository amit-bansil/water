/*
 * LocalizedException.java
 * CREATED:    Sep 4, 2003 10:23:35 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.lang.misc;

/**
 * marker interface for exceptions that implement getLocalizedMessage to return
 * something actually localized.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public interface LocalizedException {
	public String getLocalizedMessage();
}
