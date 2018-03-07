package Intermol3D;

import javax.vecmath.Color3f;
import javax.vecmath.Vector3f;

public final class IonData{
	static final int CHLORINE=0,FLUORINE=1,SODIUM=2,LITHIUM=3,POTASSIUM=4,BROMINE=5,
		IODINE=6,HELIUM=7,NEON=8,ARGON=9,KRYPTON=10,XENON=11,CESIUM=12,NONE=13;
	private static final int NUM_IONS      =13;//TO DO: remove dependency imported from internal data
	private static final double[][] rgb_index=new double[16][3];
	static{
		rgb_index[13][0]=1.0;rgb_index[13][1]=1.0;rgb_index[13][2]=1.0;
		rgb_index[14][0]=1.0;rgb_index[14][1]=0.0;rgb_index[14][2]=0.0;	
		rgb_index[15][0]=0.0;rgb_index[15][1]=1.0;rgb_index[15][2]=1.0;
		rgb_index[HELIUM][0]=1.0;rgb_index[HELIUM][1]=1.0;rgb_index[HELIUM][2]=0.0;
		rgb_index[CHLORINE][0]=0.0;rgb_index[CHLORINE][1]=1.0;rgb_index[CHLORINE][2]=0.0;
		rgb_index[ARGON][0]=0.0;rgb_index[ARGON][1]=1.0;rgb_index[ARGON][2]=0.0;
		rgb_index[LITHIUM][0]=1.0;rgb_index[LITHIUM][1]=0.5;rgb_index[LITHIUM][2]=0.0;
		rgb_index[BROMINE][0]=1.0;rgb_index[BROMINE][1]=0.0;rgb_index[BROMINE][2]=0.5;
		rgb_index[SODIUM][0]=1.0;rgb_index[SODIUM][1]=0.0;rgb_index[SODIUM][2]=0.5;
		rgb_index[KRYPTON][0]=1.0;rgb_index[KRYPTON][1]=0.0;rgb_index[KRYPTON][2]=0.5;
		rgb_index[FLUORINE][0]=0.0;rgb_index[FLUORINE][1]=0.5;rgb_index[FLUORINE][2]=1.0;
		rgb_index[POTASSIUM][0]=0.0;rgb_index[POTASSIUM][1]=0.5;rgb_index[POTASSIUM][2]=1.0;
		rgb_index[NEON][0]=0.0;rgb_index[NEON][1]=0.5;rgb_index[NEON][2]=1.0;
		rgb_index[IODINE][0]=0.5;rgb_index[IODINE][1]=0.0;rgb_index[IODINE][2]=1.0;
		rgb_index[CESIUM][0]=0.0;rgb_index[CESIUM][1]=0.0;rgb_index[CESIUM][2]=1.0;
		rgb_index[XENON][0]=0.5;rgb_index[XENON][1]=0.0;rgb_index[XENON][2]=1.0;
	}
	private static final int maxNumIons=2;
	
	public static final String[] nobleGasNames=new String[]{"He  ","Ne  ","Ar  ","Kr  ","Xe  "};
	public static final int[] nobleGasType=new int[]{7,8,9,10,11};
	public static final String[] plusSaltNames=new String[]{"Na+ ","Li+ ","K+  ","Cs+ "};
	public static final int[] plusSaltType=new int[]{2,3,4,12};
	public static final String[] minusSaltNames=new String[]{"Cl- ","F-  ","Br- ","I-  "};
	public static final int[] minusSaltType=new int[]{0,1,5,6};
	public static final String ion_names="Cl- F-  Na+ Li+ K+  Br- I-  He  Ne  Ar  Kr  Xe  Cs+ ";
	
	public final Color3f color[]=new Color3f[maxNumIons];
	public final double sigion[]=new double[maxNumIons],epsion[]=new double[maxNumIons]
		,solch[]=new double[maxNumIons],waition[]=new double[maxNumIons];
	public int iontype[]=new int[maxNumIons];
	public String name;
	public final float size[]=new float[maxNumIons];
	public int numberOfIons;
	private final IData data;
	public int[] createLandscape(float xPos, int latRes, int cutOff){
		return data.generatePeMatrix(this, latRes,cutOff,xPos);
	}
	public IonData(int type, int num, IData dat){
		this(new int[]{type},num,dat);
	}
	public IonData(int[] type,int num, IData dat){
		for(int i=0;i<num;i++) iontype[i]=type[i];
		data=dat;
		numberOfIons=num;
		
		String s1=new String();
		for(int i=0;i<num;i++) s1+=ion_names.substring((4*type[i]),(4*type[i])+4);
		name=s1;
System.out.println(name);
		init();
	}
	public IonData(String n,int num,IData dat){
//		System.out.println(n+"3NAME");
		name=n; data=dat;
		numberOfIons=num;
		String s, s1;
		for(int i=0;i<num;i++){
			iontype[i]=NONE;
		    s=name.substring(4*i);
		    for(int j=0;j<NUM_IONS;j++){
		    	s1=ion_names.substring(4*j);
		        if((s.charAt(0)==s1.charAt(0))&&(s.charAt(1)==s1.charAt(1))){
		        	iontype[i]=j;
		            break;
		        }
		    }
			if(iontype[i]==NONE) throw new IllegalArgumentException("Unknown ion type!");
		}
		init();
	}
	private void init(){
		for(int i=0;i<numberOfIons;i++){
			color[i]=new Color3f((float)rgb_index[iontype[i]][0],(float)rgb_index[iontype[i]][1],(float)rgb_index[iontype[i]][2]);
			switch(this.iontype[i]){
		   		/* Cl - jorgensen parameters */
		        case CHLORINE:
		       		sigion[i] = 0.3732306; epsion[i] = 0.5654149; solch[i] = -1.0; waition[i] = 34.96885;
		           	break;
		       /* F - jorgensen parameters */
		       case FLUORINE:
		           sigion[i] = 0.352; epsion[i] = 0.1234519; solch[i] = -1.0; waition[i] = 18.99840;
		           break;
		       /* Na - jorgensen parameters */
		       case SODIUM:
		           sigion[i] = 0.2446165; epsion[i] = 2.088542; solch[i] =1.0; waition[i] = 22.9898;
		           break;
		       /* Li - jorgensen parameters */
		       case LITHIUM:
		           sigion[i] = 0.1993304; epsion[i] = 4.118660; solch[i] = 1.0; waition[i] = 7.01600;
		           break;
	           /* K - heinzinger parameters */
		       case POTASSIUM:
		           sigion[i] = 0.325; epsion[i] = 0.5684810; solch[i] = 1.0; waition[i] = 38.96371;
		           break;
	           /* Br - heinzinger parameters */
		       case BROMINE:
		           sigion[i] = 0.416; epsion[i] = 0.5684810; solch[i] = -1.0; waition[i] = 80.9163;
		           break;
	           /* I -  heinzinger parameters */
		       case IODINE:
		           sigion[i] = 0.441; epsion[i] = 0.2282355; solch[i] = -1.0; waition[i] = 126.9044;
		           break;
	           /* He - geiger parameters */
	           case HELIUM:
		           sigion[i] = 0.256; epsion[i] = 0.08491; solch[i] = 0.0; waition[i] = 4.0026;
		           break;
	           /* Ne - geiger parameters */
		       case NEON:
		           sigion[i] = 0.276; epsion[i] = 0.295076; solch[i] = 0.0; waition[i] = 20.183;
		           break;
	           /* Ar - geiger parameters */
		       case ARGON:
		           sigion[i] = 0.341; epsion[i] = 0.9954366; solch[i] = 0.0; waition[i] = 39.948;
		           break;
	           /* Kr - geiger parameters */
		       case KRYPTON:
		           sigion[i] = 0.366; epsion[i] = 1.379038; solch[i] = 0.0; waition[i] = 83.80;
		           break;
	           /* Xe - geiger parameters */
		       case XENON:
		           sigion[i] = 0.37; epsion[i] = 0.7531200; solch[i] = 0.0; waition[i] = 130.9051;
		           break;
	           /* Cs -  heinzinger parameters */
		       case CESIUM:
		           sigion[i] = 0.361; epsion[i] = 0.6624250; solch[i] = 1.0; waition[i] = 132.9051;
		           break;
		       default:
		           break;
		  	}
			size[i]=(float)sigion[i]/2;
		}
	}
	public Vector3f getDistance(){
            Vector3f v;
            if(numberOfIons==2)
                v=new Vector3f( (float)((sigion[0]+sigion[1])/4.0f)-0.01f,0,0 );
            else v=new Vector3f(0,0,0);
            return v;			    
	}
	
}
