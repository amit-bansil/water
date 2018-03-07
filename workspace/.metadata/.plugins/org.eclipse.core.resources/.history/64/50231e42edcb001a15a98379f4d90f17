/*
 * VirtualFile.java
 * CREATED:    Dec 28, 2003 8:33:19 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.application.io;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * an interface representing a basic file
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public interface VirtualFile {
	/**
	 * not null or empty...
	 * 
	 * @return human readable name
	 */
	public String getTitle();

	/**
	 * get inputStream may fail even if canread
	 * 
	 * @return document readable
	 */
	public boolean canRead();

	/**
	 * get getOuputStream may fail even if canwrite
	 * 
	 * @return document writeable
	 */
	public boolean canWrite();

	/**
	 * instance constant. must not be null or empty.
	 * 
	 * @return internal name of document
	 */
	public String getName();

	/**
	 * @return stream to output to
	 * @throws IOException 
	 *             if can't write or fails when trying
	 */
	public OutputStream getOutputStream() throws IOException;

	/**
	 * @return stream to read input from
	 * @throws IOException 
	 *             if can't read or fails when trying
	 */
	public InputStream getInputStream() throws IOException;
}
