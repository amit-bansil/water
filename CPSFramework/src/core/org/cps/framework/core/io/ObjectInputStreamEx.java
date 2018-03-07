/*
 * ObjectInputStreamEx.java
 * CREATED:    Aug 15, 2003 6:54:03 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import org.cps.framework.util.collections.basic.SafeStack;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ObjectInputStreamEx extends ObjectInputStream {
	private final boolean compressed;
	private static final SafeStack<String> section = new SafeStack<String>();
	public ObjectInputStreamEx(InputStream in) throws IOException {
		super(in);
		compressed = readBoolean();
		if (beginSection(ObjectOutputStreamEx.SECTION_NAME)
			!= (compressed
				? ObjectOutputStreamEx.COMPRESSED_VERSION
				: ObjectOutputStreamEx.STANDARD_VERSION))throw new IOException("unknown version");
	}
	public final void beginSection(String name,int expectedVersion) throws IOException {
		int ret=beginSection(name);
		if(ret!=expectedVersion)throw new IOException("unexpected version");
	}
	public final int beginSection(String name) throws IOException {
		if (name == null)
			throw new NullPointerException();
		if (!compressed) {
			if (!(name + "{").equals(readUTF()))
				throw new IOException("expected beginning of section " + name);
		}
		section.push(name);
		return readSmallInt();
	}
	public final void endSection(String name) throws IOException {
		section.pop(name);
		if (name == null)
			throw new NullPointerException();
		if (!compressed) {
			if (!("}" + name).equals(readUTF()))
				throw new IOException("expected end of section" + name);
		}
	}
	public final int readSmallInt() throws IOException {
		return readByte() - ObjectOutputStreamEx.SMALL_INT_CONVERSION;
	}
	public final String[] readUTFArray()throws IOException{
		final int len=readInt();
		final String[] ret=new String[len];
		for(int i=0;i<len;i++){
			ret[i]=readUTF();
		}
		return ret;
	}
}
