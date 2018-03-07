// Decompiled by DJ v3.2.2.67 Copyright 2002 Atanas Neshkov  Date: 8/28/02 3:39:07 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   IInputData.java

package Intermol3D;

import javax.vecmath.Point3f;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;

// Referenced classes of package Intermol3D:
//            IData, I3DDataReader, ObjLib, ShakeFailException, 
//            IonData

public final class IInputData extends IData
{

    public void removeIons()
    {
        super.removeIons();
    }

    public void addIon(IonData dat, Point3f ionPos)
    {
        super.addIon(dat);
    }

    public int[] generatePeMatrix(IonData data, int latRes, double cut, float f)
    {
        return null;
    }

    public void setNumBonds(int v)
    {
        hbonds = v;
    }

    public int getNumBonds()
    {
        return hbonds;
    }

    public void setBoundsSize(float x, float y, float z)
    {
        bx = x;
        by = y;
        bz = z;
    }

    public Point3f getBoundsSize()
    {
        return new Point3f(bx, by, bz);
    }

    public void setMode(int m)
    {
        super.mode = m;
    }

    public boolean getJumped(int mol, int fld)
    {
        return false;
    }

    public double getPressure()
    {
        return apres;
    }

    public void setPressure(double value)
    {
        apres = value;
    }

    public double getTemp()
    {
        return atemp;
    }

    public void setTemp(double value)
    {
        atemp = value;
    }

    public double getEnergy()
    {
        return 0.0D;
    }

    public void setEnergy(double d)
    {
    }

    public double getDensity()
    {
        return arho;
    }

    public void setDensity(double value)
    {
        arho = value;
    }

    public double getTemperature2()
    {
        return temp;
    }

    public double getDensity2()
    {
        return rho;
    }

    public double getPressure2()
    {
        return pres;
    }

    public double getPE2()
    {
        return epot;
    }

    public double getKE2()
    {
        return ekin;
    }

    public double getTotalEnergy2()
    {
        return eges;
    }

    public void setTemperature2(double v)
    {
        temp = v;
    }

    public void setDensity2(double v)
    {
        rho = v;
    }

    public void setPressure2(double v)
    {
        pres = v;
    }

    public void setPE2(double v)
    {
        epot = v;
    }

    public void setKE2(double v)
    {
        ekin = v;
    }

    public void setTotalEnergy2(double v)
    {
        eges = v;
    }

    public IInputData(File f)
    {
        running = false;
        file = f;
        clear();
    }

    public void setPositions(float p[][][])
    {
        super.rn = p;
    }

    public void setVE(double v[][][])
    {
        super.ve = v;
    }

    public void setNI(double x[], double y[], double z[])
    {
        super.xni = x;
        super.yni = y;
        super.zni = z;
    }

    public void setPH2O(double h[])
    {
        super.potH2O = h;
    }

    public void setBonds(int b[][])
    {
        super.indxww = b;
    }

    public void step()
        throws ShakeFailException
    {
        reader.step();
        for(int i = 0; i < super.frameSteps; i++)
            setFNum(getFNum() + 1);

        ObjLib.boundsSize = getBoundsSize();
    }

    public void clear()
    {
        setFNum(0);
        try
        {
            reader = new I3DDataReader(this, new DataInputStream(new BufferedInputStream(new FileInputStream(file))));
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        reader.step();
        ObjLib.boundsSize = getBoundsSize();
    }

    private int hbonds;
    private float bx;
    private float by;
    private float bz;
    double apres;
    double atemp;
    double arho;
    double temp;
    double rho;
    double pres;
    double epot;
    double ekin;
    double eges;
    private I3DDataReader reader;
    private final File file;
    //public boolean running; removed ab 1 17 03 hides parent, never read
}