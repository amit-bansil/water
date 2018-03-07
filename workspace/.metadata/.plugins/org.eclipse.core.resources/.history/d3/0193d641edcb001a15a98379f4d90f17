/*
 * LocalVirtualFile.java
 * CREATED:    Jan 3, 2004 3:26:20 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.application.io;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class LocalVirtualFile implements VirtualFile {
	private final File f;
	private final boolean canRead,canWrite;
	public LocalVirtualFile(File f) {
		super();
		this.f=f;
		canRead=f.canRead();
		canWrite=f.canWrite();
	}
	public final File getFile() {
		return f;
	}
	public String getTitle() {
	    String name=f.getName();
		int d=name.indexOf('.');
		if(d==-1)return name;
		else return name.substring(0,d);
	}
	public boolean canRead() {
		return canRead;
	}
	public boolean canWrite() {
		return canWrite;
	}
	public String getName() {
		return f.getAbsolutePath();
	}
	public OutputStream getOutputStream() throws IOException {
		return new FileOutputStream(f);
	}
	public InputStream getInputStream() throws IOException {
		return new FileInputStream(f);
	}
	//good for debugging
	@Override
	public final String toString() {
		return "LocalVirtualFile[path="+f+", canRead="+canRead+", canWrite="+canWrite+ ']';
	}
}
