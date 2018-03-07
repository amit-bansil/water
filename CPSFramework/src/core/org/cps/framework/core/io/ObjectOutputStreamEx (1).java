/*
 * ObjectOutputStreamEx.java
 * CREATED:    Aug 15, 2003 6:53:42 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import org.cps.framework.util.collections.basic.SafeStack;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

/**
 * TODO unittests,allow creation of difffrent versions:depending on logging/debugging needs
 * @version 0.1
 * @author Amit Bansil
 */
public final class ObjectOutputStreamEx extends ObjectOutputStream {
	private final boolean compressed;
	public static final String SECTION_NAME="ObjectOutputStream";
	public static final byte COMPRESSED_VERSION=1;
	public static final byte STANDARD_VERSION=2;
	private final SafeStack<String> section=new SafeStack<String>();
	public ObjectOutputStreamEx(OutputStream out,boolean compressed) throws IOException {
		super(out);
		this.compressed=compressed;
		writeBoolean(compressed);
		beginSection(SECTION_NAME,compressed?COMPRESSED_VERSION:STANDARD_VERSION);
	}
	public final void close()throws IOException{
		endSection(SECTION_NAME);
		super.close();
	}
	public final void beginSection(String sectionName,int sectionVersion)throws IOException{
		if(sectionName==null)throw new NullPointerException();
		if(!compressed) writeUTF(sectionName+"{");
		writeSmallInt(sectionVersion);
		section.push(sectionName);
	}
	public final void endSection(String sectionName)throws IOException{
		if(sectionName==null)throw new NullPointerException();
		section.pop(sectionName);
		if(!compressed) writeUTF("}"+sectionName);
	}
	/*
	 * writes an int as a byte assuming it is >=-1 && < 255. 
	 * throws an ioexception if not
	 * TODO optimize
	 */
	public static final int SMALL_INT_CONVERSION=1+Byte.MIN_VALUE;
	public final void writeSmallInt(int v)throws IOException{
		byte b=(byte)(v+SMALL_INT_CONVERSION);
		if(b<Byte.MIN_VALUE||b>Byte.MAX_VALUE)throw new IOException("value "+v+" outofbounds");
		assert b-SMALL_INT_CONVERSION==v;
		writeByte(b);
	}
	public final void writeUTFArray(String[] s)throws IOException{
		writeInt(s.length);
		for(int i=0;i<s.length;i++)writeUTF(s[i]);
	}
}
