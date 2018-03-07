// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 8/28/02 3:39:09 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   FrameProperty.java

package Intermol3D;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;

public abstract class FrameProperty
{

    public FrameProperty(String n)
    {
        id = totalNum;
        name = n;
        totalNum++;
    }

    public void writeInitial(DataOutputStream dataoutputstream)
        throws IOException
    {
    }

    public void readInitial(DataInputStream datainputstream)
        throws IOException
    {
    }

    public void read(DataInputStream datainputstream)
        throws IOException
    {
    }

    public void write(DataOutputStream dataoutputstream)
        throws IOException
    {
    }

    public final int id;
    public final String name;
    private static int totalNum;
}