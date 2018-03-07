package Intermol3D;
import javax.swing.JOptionPane;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.Serializable;
import java.io.StreamTokenizer;


class IConfig implements Serializable{
    private float[][][] rn=null;
    private double[][][] ve=null;	
    public int mols=1;
    private int nfi=1, nacc=1;
    private double bx=1,by=1,bz=1,
            aeges=1,atemp=1,apres=1,
            arho=1,delta=1,rhop=1,egesp=1;

    public IConfig(){
    }
    public IConfig(InputStream is){
    	try{
    		fromText(is);
	    }catch(Exception e){
	    	e.printStackTrace();
	    	JOptionPane.showMessageDialog(null, "Could not read configuration", "Error", JOptionPane.ERROR_MESSAGE);
	    }
    }
    public void finished(){
    }
    public void fromData(InternalData data){
            int zlen=3;//data.rn[0][0].length;
            int ylen=3;//(int)(data.rn[0].length/zlen);
            int xlen=data.mols;//(int)(data.rn.length/ylen);

            ve=new double[xlen][ylen][zlen];
            rn=new float[xlen][ylen][zlen];

            for(int x=0;x<xlen;x++){
                    for(int y=0;y<ylen; y++){
                            for(int z=0;z<zlen;z++){
                                    rn[x][y][z]=data.rn[x][y][z];
                                    ve[x][y][z]=data.ve[x][y][z];	
                            }
                    }
            }
            mols=data.mols; nfi=data.nfi; nacc=data.nacc;
            bx=data.bx; by=data.by; bz=data.bz;
            aeges=data.aeges; atemp=data.atemp; apres=data.apres;
            arho=data.arho; delta=data.delta; rhop=data.rhop; egesp=data.egesp;
    }
    public void fromText(String fileName) throws IOException{
    	fromText(new FileInputStream(fileName));
    }
    public void fromText(InputStream is) throws IOException{
        try{
            StreamTokenizer SToken = new StreamTokenizer(new InputStreamReader(is));
            SToken.parseNumbers();
            SToken.nextToken();
            if((int)SToken.nval!=6789145) throw new IllegalArgumentException("File not valid");
            SToken.nextToken();
            mols=(int)SToken.nval;

            SToken.nextToken();
            nfi=(int)SToken.nval;
            SToken.nextToken();
            nacc=(int)SToken.nval;

            SToken.nextToken();
            bx=SToken.nval;
            SToken.nextToken();
            by=SToken.nval;
            SToken.nextToken();
            bz=SToken.nval;

            SToken.nextToken();
            aeges=SToken.nval;
            SToken.nextToken();
            atemp=SToken.nval;
            SToken.nextToken();
            apres=SToken.nval;

            SToken.nextToken();
            arho=SToken.nval;
            SToken.nextToken();
            delta=SToken.nval;
            SToken.nextToken();
            rhop=SToken.nval;

            SToken.nextToken();
            egesp=SToken.nval;

            rn=new float[mols][3][3];
            for(int i=0;i<mols;i++){
            for(int k=0;k<3;k++){
                    SToken.nextToken();
                            rn[i][0][k]=(float)SToken.nval;
                            SToken.nextToken();
                            rn[i][1][k]=(float)SToken.nval;
                            SToken.nextToken();
                            rn[i][2][k]=(float)SToken.nval;
                    }
            }
            
            }catch(Exception ex){
                    ex.printStackTrace();
            }
    }
    public static void save(final InternalData data,final OutputStream os) throws IOException{
    	final PrintStream pw=new PrintStream(os);

    	pw.println("6789145");
    	pw.println(data.mols);
    	pw.println(data.nfi+" "+data.nacc);
    	pw.println(data.bx+" "+data.by+" "+data.bz);
    	pw.println(data.aeges+" "+data.atemp+" "+data.apres);
    	pw.println(data.arho+" "+data.delta+" "+data.rhop);
    	pw.println(data.egesp);
    	for(int i=0;i<data.mols;i++){
            for(int k=0;k<3;k++){
            	pw.println(
            		data.rn[i][0][k]+" "+
            		data.rn[i][1][k]+" "+
            		data.rn[i][2][k]);
            }
       	}
    }
    public void toData(InternalData data){
        int zlen=3;//data.rn[0][0].length;
        int ylen=3;//(int)(data.rn[0].length/zlen);
        int xlen=mols;//(int)(data.rn.length/ylen);

        for(int x=0;x<xlen;x++){
            for(int y=0;y<ylen; y++){
                for(int z=0;z<zlen;z++){
                    data.rn[x][y][z]=rn[x][y][z];
                    if(ve!=null) data.ve[x][y][z]=ve[x][y][z];	
                }
            }
        }
        data.mols=mols; data.nfi=nfi; data.nacc=nacc;
        data.bx=bx; 	data.by=by; data.bz=bz;
        data.aeges=aeges; data.atemp=atemp; data.apres=apres;
        data.arho=arho; data.delta=delta; data.rhop=rhop; data.egesp=egesp;
    }	
}
