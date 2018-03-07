/*
 * FullIcontFig.java
 *
 * Created on August 2, 2000, 10:42 AM
 */

package Intermol3D;

/**
 *
 * @author  unknown
 * @version 
 */
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
public final class FullIconfig extends IConfig {
    public static final long key=29082348283469879l;
    private byte[] dat;
    /** Creates new FullIcontFig */
    public FullIconfig() {
    }   
    public FullIconfig(InputStream is){
    	try{
    		fromText(is);
    	}catch(IOException ex){ ex.printStackTrace(); }
    }
    public void finished(){
    	dat=null;
    }
    public void fromData(final InternalData data){
    	ByteArrayOutputStream baos=new ByteArrayOutputStream();
    	try{save(data,new DataOutputStream(baos));
    	dat=baos.toByteArray();
    	baos=null;
		}catch(IOException ex){ ex.printStackTrace(); }
    }
    public void fromText(InputStream is) throws IOException{
	    ByteArrayOutputStream baos=new ByteArrayOutputStream();
	    int i=is.read();
	    while(i!=-1){
	  		baos.write(i);
	  		i=is.read();
	    }
    	dat=baos.toByteArray();
    	baos=null;
    }
    public void toData(InternalData data){
    	try{load(new DataInputStream(new ByteArrayInputStream(dat)),data);}
    	catch(IOException ex){ ex.printStackTrace(); }
    }
    
    public static final void load(final DataInputStream dis,final InternalData data) throws IOException{
        if(dis.readLong()!=key) throw new IllegalArgumentException("Not a full iConfig");
        double rnMax=dis.readDouble(),rnMin=dis.readDouble();
        double veMax=dis.readDouble(),veMin=dis.readDouble();
        double hOffMax=dis.readDouble(),hOffMin=dis.readDouble();      
        data.mols=dis.readInt();
        data.nfi=dis.readInt();
        data.nacc=dis.readInt();
        data.bx=dis.readDouble();
        data.by=dis.readDouble();
        data.bz=dis.readDouble();
        data.aeges=dis.readDouble();
        data.atemp=dis.readDouble();
        data.apres=dis.readDouble();
        data.arho=dis.readDouble();
        data.delta=dis.readDouble();
        data.rhop=dis.readDouble();
        data.egesp=dis.readDouble();
        data.hbonds=dis.readInt();
        for(int i=0;i<data.mols;i++){
            for(int j=0;j<3;j++){
                for(int k=0;k<3;k++)
                    data.ve[i][j][k]=convert(dis.readChar(),veMax,veMin);
                data.rn[i][0][j]=convert(dis.readChar(),hOffMax,hOffMin);
                data.rn[i][1][j]=convert(dis.readChar(),hOffMax,hOffMin);
                data.rn[i][2][j]=convert(dis.readChar(),rnMax,rnMin);           
            }
        }
        short temp;
        for(int i=0;i<data.hbonds;i++){
            data.indxww[i][0]=dis.readShort();
            temp=dis.readShort();
            if(temp<0) data.indxww[i][2]=1; else data.indxww[i][2]=0;
            data.indxww[i][1]=Math.abs(temp)-1;
//System.err.println("S"+data.indxww[i][0]+","+data.indxww[i][1]+","+data.indxww[i][2]);
        }
    }

    public static final void save(final InternalData data,final OutputStream os) throws IOException{
    	final DataOutputStream dos=new DataOutputStream(os);
        double rnMax=Double.MIN_VALUE,rnMin=Double.MAX_VALUE;
        double veMax=rnMax,veMin=rnMin;
        double hOffMax=rnMax,hOffMin=veMin;
        for(int i=0;i<data.mols;i++){
            for(int k=0;k<3;k++){
                for(int j=0;j<3;j++){
                    if(data.ve[i][j][k]>veMax) veMax=data.ve[i][j][k];
                    else if(data.ve[i][j][k]<veMin) veMin=data.ve[i][j][k];
                }
                if(data.rn[i][2][k]>rnMax) rnMax=data.rn[i][2][k];
                else if(data.rn[i][2][k]<rnMin) rnMin=data.rn[i][2][k];
                
                if(data.rn[i][0][k]-data.rn[i][2][k]>hOffMax)
                    hOffMax=data.rn[i][0][k]-data.rn[i][2][k];
                else if(data.rn[i][0][k]-data.rn[i][2][k]<hOffMin)
                    hOffMin=data.rn[i][0][k]-data.rn[i][2][k];
                
                if(data.rn[i][1][k]-data.rn[i][2][k]>hOffMax)
                    hOffMax=data.rn[i][1][k]-data.rn[i][2][k];
                else if(data.rn[i][1][k]-data.rn[i][2][k]<hOffMin)
                    hOffMin=data.rn[i][1][k]-data.rn[i][2][k];
            }
        }        
        dos.writeLong(key);
        dos.writeDouble(rnMax); dos.writeDouble(rnMin);
        dos.writeDouble(veMax); dos.writeDouble(veMin);
        dos.writeDouble(hOffMax); dos.writeDouble(hOffMin);
        dos.writeInt(data.mols);
        dos.writeInt(data.nfi);
        dos.writeInt(data.nacc);
        dos.writeDouble(data.bx);
        dos.writeDouble(data.by);
        dos.writeDouble(data.bz);
        dos.writeDouble(data.aeges);
        dos.writeDouble(data.atemp);
        dos.writeDouble(data.apres);
        dos.writeDouble(data.arho);
        dos.writeDouble(data.delta);
        dos.writeDouble(data.rhop);
        dos.writeDouble(data.egesp);
        dos.writeInt(data.hbonds);
        for(int i=0;i<data.mols;i++){
            for(int j=0;j<3;j++){
                for(int k=0;k<3;k++)
                    dos.writeChar(convert(data.ve[i][j][k],veMax,veMin));
                dos.writeChar(convert(data.rn[i][0][j],hOffMax,hOffMin));
                dos.writeChar(convert(data.rn[i][1][j],hOffMax,hOffMin));
                dos.writeChar(convert(data.rn[i][2][j],rnMax,rnMin));                
            }
        }
        for(int i=0;i<data.hbonds;i++){
            dos.writeShort((short)data.indxww[i][0]);
            if(data.indxww[i][2]==0) dos.writeShort(data.indxww[i][1]+1);
            else dos.writeShort(-(data.indxww[i][1]+1));
        }
    }   
    private static final char convert(double v,double max,double min){
        return (char)(((v-min)/(max-min))*Character.MAX_VALUE);
    }
    private static final float convert(char v,double max,double min){
        return (float)( ( ((float)((float)v)/((float)Character.MAX_VALUE))*(max-min))+min);
    }
}