/*
 * ObjectInputStreamEx.java
 * CREATED:    Aug 15, 2003 6:54:03 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.io;

import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectInputStream;
import java.util.Stack;
/**
 * 
 */
public class ObjectInputStreamEx{
	private final boolean compressed;
	private static final Stack<String> section = new Stack<String>();
    private final ObjectInputStream in;
    public ObjectInputStreamEx(InputStream in) throws IOException {
		this.in=new ObjectInputStream(in);
		compressed = readBoolean();
		if (beginSection(ObjectOutputStreamEx.SECTION_NAME)
			!= (compressed
				? ObjectOutputStreamEx.COMPRESSED_VERSION
				: ObjectOutputStreamEx.STANDARD_VERSION))throw new IOException("unknown version");
	}
	
	//------------------------------------------------------------------------
	//sectioning/versioning
	//------------------------------------------------------------------------
	//sections have a name and version
	public final void beginSection(String name,int expectedVersion) throws IOException {
		int ret=beginSection(name);
		if(ret!=expectedVersion)throw new IOException("unexpected version");
	}
	public final int beginSection(String name) throws IOException {
		if (name == null)
			throw new NullPointerException();
		if (!compressed) {
			if (!(name + '{').equals(readUTF()))
				throw new IOException("expected beginning of section " + name);
		}
		section.push(name);
		return readSmallInt();
	}
	public final void endSection(String name) throws IOException {
		if(!section.pop().equals(name))throw new Error("unexpected section name");
		if (name == null)
			throw new NullPointerException();
		if (!compressed) {
			if (!('}' + name).equals(readUTF()))
				throw new IOException("expected end of section" + name);
		}
	}
	//------------------------------------------------------------------------
	//extra data types
	//------------------------------------------------------------------------
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
    //--------------------------------------------------------------------------
    //delegate methods
    public boolean readBoolean() throws IOException {return in.readBoolean();}

    public byte readByte() throws IOException {return in.readByte();}

    public char readChar() throws IOException {return in.readChar();}

    public double readDouble() throws IOException {return in.readDouble();}

    public float readFloat() throws IOException {return in.readFloat();}

    public int readInt() throws IOException {return in.readInt();}

    public long readLong() throws IOException {return in.readLong();}

    public short readShort() throws IOException {return in.readShort();}

    public String readUTF() throws IOException {return in.readUTF();}

    public Object readObject()throws IOException,ClassNotFoundException{
        return in.readObject();
    }
}
