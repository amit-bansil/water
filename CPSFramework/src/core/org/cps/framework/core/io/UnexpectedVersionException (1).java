/*
 * UnexpectedVersion.java
 * CREATED:    Jan 10, 2005 3:31:11 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import java.io.IOException;

/**
 * Signals that data was not readable because it does not have the proper version.
 * this can usually be rememedied by using the correct app to open the doc.
 * @version 1.0
 * @author Amit Bansil
 */
public class UnexpectedVersionException extends IOException {
	private final String versionType,expectedVersion,givenVersion;
	public UnexpectedVersionException(String versionType,
			String expectedVersion, String givenVersion) {
		super("The '" + versionType + "' version is '" + givenVersion
				+ "' which is not compatible with the expected version "
				+ givenVersion);
		this.versionType=versionType;
		this.expectedVersion=expectedVersion;
		this.givenVersion=givenVersion;
	}
	
	public String getExpectedVersion() {
		return expectedVersion;
	}
	public String getGivenVersion() {
		return givenVersion;
	}
	public String getVersionType() {
		return versionType;
	}
}
