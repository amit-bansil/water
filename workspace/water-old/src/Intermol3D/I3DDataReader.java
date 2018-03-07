// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 8/28/02 3:39:06 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   I3DDataReader.java

package Intermol3D;

import java.io.DataInputStream;
import java.io.IOException;
import java.util.Enumeration;

// Referenced classes of package Intermol3D:
//            MovieIO, IInputData, IData, FrameProperty

public class I3DDataReader extends MovieIO
{

    public I3DDataReader(IInputData dat, DataInputStream file)
        throws IOException
    {
        super(null, dat);
        in = file;
        super.inputData.setBonds(null);
        super.inputData.setPH2O(null);
        super.inputData.setVE(null);
        keyFrame();
    }

    public void step()
    {
        try
        {
            if(readFlags())
                return;
            readPositions();
            readProperties();
            if(bondsOn)
                readBonds();
            if(velOn)
                readVelocities();
            if(peOn)
                readPE();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

    public void destroy()
    {
        try
        {
            in.close();
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }

    private boolean readFlags()
        throws IOException
    {
        boolean ret = false;
        for(byte v = in.readByte(); v != 0; v = in.readByte())
            switch(v)
            {
            case -1: 
                destroy();
                ret = true;
                break;

            case 1: // '\001'
                keyFrame();
                ret = true;
                break;

            case 2: // '\002'
                int inputData[] = new int[2];
                inputData[0] = in.readByte();
                inputData[1] = in.readByte();
                break;

            case 10: // '\n'
                peOn = true;
                readInitialPE();
                break;

            case 11: // '\013'
                peOn = false;
                break;

            case 8: // '\b'
                velOn = true;
                readInitialVelocities();
                break;

            case 9: // '\t'
                velOn = false;
                break;

            case 6: // '\006'
                bondsOn = true;
                readInitialBonds();
                break;

            case 7: // '\007'
                bondsOn = false;
                break;
            }

        return ret;
    }

    private void readInitialBonds()
    {
        bonds = new int[IData.numMols][3];
        super.inputData.setBonds(bonds);
    }

    private void readBonds()
        throws IOException
    {
        super.inputData.setNumBonds(in.readInt());
        for(int i = 0; i < super.inputData.getNumBonds(); i++)
        {
            bonds[i][0] = in.readShort();
            short temp = in.readShort();
            if(temp < 0)
                bonds[i][2] = 1;
            else
                bonds[i][2] = 0;
            bonds[i][1] = Math.abs(temp) - 1;
        }

    }

    private void readInitialPE()
        throws IOException
    {
        pe = new double[IData.numMols];
        super.inputData.setPH2O(pe);
        double max = in.readDouble();
        double min = in.readDouble();
        for(int i = 0; i < IData.numMols; i++)
            pe[i] = MovieIO.expandByte(in.readByte(), max, min);

    }

    private void readPE()
        throws IOException
    {
        double max = in.readDouble();
        double min = in.readDouble();
        for(int i = 0; i < IData.numMols; i++)
            pe[i] += MovieIO.expandByte(in.readByte(), max, min);

    }

    private void keyFrame()
        throws IOException
    {
        IData.numMols = in.readByte();
        rn = new float[IData.numMols][3][3];
        super.inputData.setPositions(rn);
        double max[] = new double[3];
        double min[] = new double[3];
        for(int j = 0; j < 3; j++)
        {
            max[j] = in.readDouble();
            min[j] = in.readDouble();
        }

        for(int i = 0; i < IData.numMols; i++)
        {
            for(int k = 0; k < 3; k++)
            {
                for(int j = 0; j < 3; j++)
                    rn[i][j][k] = MovieIO.expandChar(in.readChar(), max[j], min[j]);

            }

        }

    }

    private void readPositions()
        throws IOException
    {
        double max[] = new double[3];
        double min[] = new double[3];
        for(int j = 0; j < 3; j++)
        {
            max[j] = in.readDouble();
            min[j] = in.readDouble();
        }

        for(int i = 0; i < IData.numMols; i++)
        {
            for(int k = 0; k < 3; k++)
            {
                for(int j = 0; j < 3; j++)
                {
                    byte n = in.readByte();
                    if(n == super.FLAG_BYTE)
                        rn[i][j][k] = in.readFloat();
                    else
                        rn[i][j][k] = MovieIO.expandByte(n, max[j], min[j]);
                }

            }

        }

    }

    private void readInitialVelocities()
        throws IOException
    {
        ve = new double[IData.numMols][3][3];
        super.inputData.setVE(ve);
        double max[] = new double[3];
        double min[] = new double[3];
        for(int j = 0; j < 3; j++)
        {
            max[j] = in.readDouble();
            min[j] = in.readDouble();
        }

        for(int i = 0; i < IData.numMols; i++)
        {
            for(int j = 0; j < 3; j++)
            {
                ve[i][j][0] = MovieIO.expandByte(in.readByte(), max[0], min[0]);
                ve[i][j][1] = MovieIO.expandByte(in.readByte(), max[1], min[1]);
                ve[i][j][2] = MovieIO.expandByte(in.readByte(), max[2], min[2]);
            }

        }

    }

    private void readVelocities()
        throws IOException
    {
        double max[] = new double[3];
        double min[] = new double[3];
        for(int j = 0; j < 3; j++)
        {
            max[j] = in.readDouble();
            min[j] = in.readDouble();
        }

        for(int i = 0; i < IData.numMols; i++)
        {
            for(int j = 0; j < 3; j++)
            {
                ve[i][j][0] += MovieIO.expandByte(in.readByte(), max[0], min[0]);
                ve[i][j][1] += MovieIO.expandByte(in.readByte(), max[1], min[1]);
                ve[i][j][2] += MovieIO.expandByte(in.readByte(), max[2], min[2]);
            }

        }

    }

    private void readProperties()
        throws IOException
    {
        for(Enumeration props = super.propertyListeners.elements(); props.hasMoreElements(); ((FrameProperty)props.nextElement()).read(in));
    }

    private final DataInputStream in;
    boolean bondsOn;
    boolean velOn;
    boolean peOn;
    int bonds[][];
    double pe[];
    float rn[][][];
    private double ve[][][];
}