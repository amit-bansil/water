
/*
 * ObjectOutputStreamEx.java
 * CREATED:    Aug 15, 2003 6:53:42 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.io;

import cps.jarch.util.misc.LangUtils;

import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.OutputStream;
import java.util.Stack;

/**
 * @see ObjectInputStreamEx
 * TODO unittests,allow creation of difffrent versions:depending on logging/debugging needs
 * TODO create something like a 'blockdata' output stream to allow skipping,
 *      
 * @version 0.1
 * @author Amit Bansil
 */
//TODO keep the underling ObjectOutputStream private.
//have a custom writeObject method that uses it
//and fixes enum handling w/ retroweaver
//and possibly optimizes primitive types?
public final class ObjectOutputStreamEx{
	public static final String SECTION_NAME="ObjectOutputStream";
	public static final byte COMPRESSED_VERSION=(byte)1;
	public static final byte STANDARD_VERSION=(byte)2;
    //--------------------------------------------------------------------------
    private final boolean compressed;
	private final Stack<String> section=new Stack<String>();
    private final ObjectOutputStream out;
    public ObjectOutputStreamEx(OutputStream out,boolean compressed) throws IOException {
		this.out=new ObjectOutputStream(out);
		this.compressed=compressed;
		writeBoolean(compressed);
		beginSection(SECTION_NAME,compressed?COMPRESSED_VERSION:STANDARD_VERSION);
	}

    public final void close()throws IOException{
		endSection(SECTION_NAME);
		out.close();
	}

    //------------------------------------------------------------------------
	//SECTIONS
	//------------------------------------------------------------------------
	
	public final void beginSection(String sectionName,int sectionVersion)throws IOException{
		LangUtils.checkArgNotNull(sectionName,"sectionName");
		if(!compressed) writeUTF(sectionName+ '{');
		writeSmallInt(sectionVersion);
		section.push(sectionName);
	}
	public final void endSection(String sectionName)throws IOException{
		LangUtils.checkArgNotNull(sectionName,"sectionName");
		if(!section.pop().equals(sectionName))throw new Error("unexpected section name");
		if(!compressed) writeUTF('}' +sectionName);
	}
	//------------------------------------------------------------------------
	
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
        for (String value : s)
            writeUTF(value);
	}
    //--------------------------------------------------------------------------
    //delagate methods

    public void flush() throws IOException {out.flush();}

    public void writeBoolean(boolean val) throws IOException {out.writeBoolean(val);}

    public void writeByte(int val) throws IOException {out.writeByte(val);}

    public void writeChar(int val) throws IOException {out.writeChar(val);}

    public void writeDouble(double val) throws IOException {out.writeDouble(val);}

    public void writeFloat(float val) throws IOException {out.writeFloat(val);}

    public void writeInt(int val) throws IOException {out.writeInt(val);}

    public void writeLong(long val) throws IOException {out.writeLong(val);}

    public void writeShort(int val) throws IOException {out.writeShort(val);}

    public void writeUTF(String str) throws IOException {out.writeUTF(str);}

    public void writeObject(Object obj)throws IOException{
        out.writeObject(obj);
    }
}
