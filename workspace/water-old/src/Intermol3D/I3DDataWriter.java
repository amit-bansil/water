/*
 * I3DDataRecorder.java
 *
 * Created on October 18, 2000, 2:38 PM
 */

package Intermol3D;

/**
 *
 * @author  unknown
 * @version 
 */
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.Enumeration;
import java.util.Hashtable;
/*
FLAGS--
-1 End Movie
0 End flags
1 Key Frame
2 Add ion (byte 1num,byte 2num)
3 Remove ion
4 Add property (byte hookNum)
5 Remove property (byte hookNum
6 Bond data on
7 Bond data off
8 Vel data on
9 Vel data off
10 PE data on
11 PE data off

*/




public final class I3DDataWriter extends MovieIO {
    private final DataOutputStream out;
    
    //control-------------------------------------------------------------------
    public I3DDataWriter(IData dat,DataOutputStream file) {
    	super(dat,null);
    	out=file;
    	
    	keyFrame();
    }
    public void step(){
	    try{
	    	if(writeFlags()) return;
	    	writePositions();
	    	writeProperties();
	    	if(bondsOn) writeBonds();
	    	if(bondsOn) writeBonds();
	    	if(velOn) writeVelocities();
	    	if(peOn) writePE();
    	}catch(Exception e){
    		e.printStackTrace();
    	}
    }
    public void finish(){
    	newFlags.put(new Byte(FLAG_END_MOVIE),VALUE_EMPTY);
    }
    public void destroy(){
    	try{
    		out.flush();
    		out.close();
    	}catch(IOException e){
    		e.printStackTrace();
    	}
    }
    
    //FLAGS---------------------------------------------------------------------
    private final Hashtable newFlags=new Hashtable();
    private boolean writeFlags() throws IOException{
    	Enumeration flags=newFlags.keys();
    	boolean ret=false;
    	while(flags.hasMoreElements()){
    		byte v=((Byte)flags.nextElement()).byteValue();
    		out.writeByte(v);
    		switch(v){
    			case FLAG_END_MOVIE:
    				destroy();
    				ret=true;
    				break;
    			case FLAG_KEY_FRAME:
    				writeKeyFrame();
    				ret=true;
    				break;
    			case FLAG_ADD_ION:
    				int[] dat=(int[])newFlags.get(new Byte(v));
    				out.writeByte((byte)dat[0]);
    				out.writeByte((byte)dat[1]);
    				break;
    			case FLAG_PE_ON:
    				writeInitialPE();
    				break;
    			case FLAG_VEL_ON:
    				writeInitialVelocities();
    				break;
    			case FLAG_BOND_ON:
    				writeInitialBonds();
    				break;
    			case FLAG_ADD_PROPERTY:
    				out.writeByte(((FrameProperty)newFlags.get(new Byte(v))).id);
    				((FrameProperty)newFlags.get(new Byte(v))).writeInitial(out);
    				propertyListeners.add(newFlags.get(new Byte(v)));
    				break;
    			case FLAG_REMOVE_PROPERTY:
    				out.writeByte(((FrameProperty)newFlags.get(new Byte(v))).id);
    				propertyListeners.remove(newFlags.get(new Byte(v)));
    				break;
    		}
    	}
    	out.writeByte(FLAG_END_FLAGS);
    	return ret;
    }
    public void keyFrame(){
        newFlags.put(new Byte(FLAG_END_MOVIE),VALUE_EMPTY);
    }
    public void addIon(int[] ionNum){
    	newFlags.put(new Byte(FLAG_ADD_ION),ionNum);
    	newFlags.put(new Byte(FLAG_ADD_PROPERTY),ion1Position);
    	newFlags.put(new Byte(FLAG_ADD_PROPERTY),ion2Position);
    }
    public void removeIon(){
        newFlags.put(new Byte(FLAG_REMOVE_ION),VALUE_EMPTY);
        newFlags.put(new Byte(FLAG_REMOVE_PROPERTY),ion1Position);
        newFlags.put(new Byte(FLAG_REMOVE_PROPERTY),ion2Position);
    }
    public void addProperty(FrameProperty f){
    	newFlags.put(new Byte(FLAG_ADD_PROPERTY),f);
    }
    public void removeProperty(FrameProperty f){
    	newFlags.put(new Byte(FLAG_REMOVE_PROPERTY),f);
    }
    
    boolean bondsOn;
    public void setBondEnabled(boolean v){
        bondsOn=v;
        if(v) newFlags.put(new Byte(FLAG_BOND_ON),VALUE_EMPTY);
    	else newFlags.put(new Byte(FLAG_BOND_OFF),VALUE_EMPTY);
    }
    
    boolean velOn;
    public void setVelEnabled(boolean v){
    	velOn=v;
        if(v) newFlags.put(new Byte(FLAG_VEL_ON),VALUE_EMPTY);
    	else newFlags.put(new Byte(FLAG_VEL_OFF),VALUE_EMPTY);
    }
    
    boolean peOn;
    public void setPEEnalbled(boolean v){
    	peOn=v;
        if(v) newFlags.put(new Byte(FLAG_PE_ON),VALUE_EMPTY);
    	else newFlags.put(new Byte(FLAG_PE_OFF),VALUE_EMPTY);    	
    }
    
    //Writes--------------------------------------------------------------------
    //bonds
    private void writeInitialBonds(){
    }
    private void writeBonds() throws IOException{
    	out.writeInt(data.getNumBonds());
        for(int i=0;i<data.getNumBonds();i++){
            out.writeShort((short)data.getBonds()[i][0]);
            if(data.getBonds()[i][2]==0) out.writeShort(data.getBonds()[i][1]+1);
            else out.writeShort(-(data.getBonds()[i][1]+1));
        }
    }
    //pe
    private float[] curPE;

    private void writeInitialPE() throws IOException{
    	curPE=new float[data.numMols];
		float f;
    	double max=Double.MIN_VALUE,min=Double.MAX_VALUE;
    	float v;
    	for(int i=0;i<data.numMols;i++){
    		v=(float)data.getAtomPE(i);
    		if(v>max) max=v;
    		if(v<min) min=v;
    	}
    	byte b;
		out.writeDouble(max); out.writeDouble(min);
    	for(int i=0;i<data.numMols;i++){
    		b=compressByte(data.getAtomPE(i),max,min);
    		out.writeByte(b);
    		curPE[i]=expandByte(b,max,min);
    	}
    }
    private void writePE() throws IOException{
    	float f;
    	double max=Double.MIN_VALUE,min=Double.MAX_VALUE;
    	float v;
    	for(int i=0;i<data.numMols;i++){
    		v=(float)data.getAtomPE(i)-curPE[i];
    		if(v>max) max=v;
    		if(v<min) min=v;
    	}
    	byte b;
		out.writeDouble(max); out.writeDouble(min);
    	for(int i=0;i<data.numMols;i++){
    		b=compressByte(data.getAtomPE(i)-curPE[i],max,min);
    		out.writeByte(b);
    		curPE[i]=expandByte(b,max,min);
    	}
    }
    //key frame
    private float[][][] curRN;
    private void writeKeyFrame() throws IOException{
    	out.writeByte(data.numMols);
    	curRN=new float[data.numMols][3][3];
		double[] max=new double[3], min=new double[3];
		for(int j=0;j<3;j++){
			max[j]=Double.MIN_VALUE; min[j]=Double.MAX_VALUE;
		}
		float v;
		for(int i=0;i<data.numMols;i++){
			for(int k=0;k<3;k++){
				for(int j=0;j<3;j++){
					v=data.getRaw()[i][j][k];
					if(v>max[j]) max[j]=v;
					if(v<min[j]) min[j]=v;				
				}
			}
		}
		char vn;
		for(int j=0;j<3;j++){
			out.writeDouble(max[j]); out.writeDouble(min[j]);
		}
    	for(int i=0;i<data.numMols;i++){
            for(int k=0;k<3;k++){
            	for(int j=0;j<3;j++){
            		vn=compressChar(data.getRaw()[i][j][k],max[j],min[j]);
	                out.writeChar(vn);             
            		curRN[i][j][k]=expandChar(vn,max[j],min[j]);
            	}
            }
        }
    }
    //3*n arrays
    private void writePositions() throws IOException{
		double[] max=new double[3], min=new double[3];
		for(int j=0;j<3;j++){
			max[j]=Double.MIN_VALUE; min[j]=Double.MAX_VALUE;
		}
		float v;
		for(int i=0;i<data.numMols;i++){
			for(int k=0;k<3;k++){
				for(int j=0;j<3;j++){
					if(data.getJumped(i,j)) continue;
					v=data.getRaw()[i][j][k]-curRN[i][j][k];
					if(v>max[j]) max[j]=v;
					if(v<min[j]) min[j]=v;				
				}
			}
		}
		byte n;
		for(int j=0;j<3;j++){
			out.writeDouble(max[j]); out.writeDouble(min[j]);
		}
    	for(int i=0;i<data.numMols;i++){
            for(int k=0;k<3;k++){
            	for(int j=0;j<3;j++){
            		if(data.getJumped(i,j)){
            			out.writeByte(FLAG_BYTE);
            			out.writeFloat(data.getRaw()[i][j][k]);
            		}else{
	            		n=compressFlagByte(data.getRaw()[i][j][k]-curRN[i][j][k],max[j],min[j]);
		                out.writeByte(n);             
	            		curRN[i][j][k]=expandByte(n,max[j],min[j]);
	            	}
            	}
            }
        }
    }
    //velocities
    private float[][][] curVE;
    private void writeInitialVelocities() throws IOException{
    	curVE=new float[data.numMols][3][3];
		double[] max=new double[3], min=new double[3];
		for(int j=0;j<3;j++){
			max[j]=Double.MIN_VALUE;min[j]=Double.MAX_VALUE;
		}
		float v;
		for(int i=0;i<data.numMols;i++){
			for(int j=0;j<3;j++){
				v=data.getVX(i,j);
				if(v>max[0]) max[0]=v;
				if(v<min[0]) min[0]=v;
				v=data.getVY(i,j);
				if(v>max[1]) max[1]=v;
				if(v<min[1]) min[1]=v;
				v=data.getVZ(i,j);
				if(v>max[2]) max[2]=v;		
				if(v<min[2]) min[2]=v;
			}
		}
		byte n;
		for(int j=0;j<3;j++){
			out.writeDouble(max[j]); out.writeDouble(min[j]);
		}
    	for(int i=0;i<data.numMols;i++){
			for(int j=0;j<3;j++){    	
				n=compressByte(data.getVX(i,j),max[0],min[0]);
				out.writeByte(n);
				curVE[i][j][0]=expandByte(n,max[0],min[0]);
				
				n=compressByte(data.getVY(i,j),max[1],min[1]);
				out.writeByte(n);
				curVE[i][j][1]=expandByte(n,max[1],min[1]);
				
				n=compressByte(data.getVZ(i,j),max[2],min[2]);
				out.writeByte(n);
				curVE[i][j][2]=expandByte(n,max[2],min[2]);
			}
        }
    }
    private void writeVelocities() throws IOException{
		double[] max=new double[3], min=new double[3];
		for(int j=0;j<3;j++){
			max[j]=Double.MIN_VALUE;min[j]=Double.MAX_VALUE;
		}
		float v;
		for(int i=0;i<data.numMols;i++){
			for(int j=0;j<3;j++){
				v=data.getVX(i,j)-curVE[i][j][0];
				if(v>max[0]) max[0]=v;
				if(v<min[0]) min[0]=v;
				v=data.getVY(i,j)-curVE[i][j][1];
				if(v>max[1]) max[1]=v;
				if(v<min[1]) min[1]=v;
				v=data.getVZ(i,j)-curVE[i][j][2];
				if(v>max[2]) max[2]=v;		
				if(v<min[2]) min[2]=v;
			}
		}
		byte n;
		for(int j=0;j<3;j++){
			out.writeDouble(max[j]); out.writeDouble(min[j]);
		}
    	for(int i=0;i<data.numMols;i++){
			for(int j=0;j<3;j++){    	
				n=compressByte(data.getVX(i,j)-curVE[i][j][0],max[0],min[0]);
				out.writeByte(n);
				curVE[i][j][0]=expandByte(n,max[0],min[0]);
				
				n=compressByte(data.getVY(i,j)-curVE[i][j][0],max[1],min[1]);
				out.writeByte(n);
				curVE[i][j][1]=expandByte(n,max[1],min[1]);
				
				n=compressByte(data.getVZ(i,j)-curVE[i][j][0],max[2],min[2]);
				out.writeByte(n);
				curVE[i][j][2]=expandByte(n,max[2],min[2]);
			}
        }
    }
    //properties
    private void writeProperties() throws IOException{
    	Enumeration props=propertyListeners.elements();
    	while(props.hasMoreElements())
    		((FrameProperty)props.nextElement()).write(out);
    }
}