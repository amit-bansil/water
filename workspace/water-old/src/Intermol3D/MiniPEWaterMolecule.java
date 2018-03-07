package Intermol3D;
import com.sun.j3d.utils.geometry.Sphere;

import javax.media.j3d.Material;

import java.awt.Color;
public final class MiniPEWaterMolecule extends MiniWaterMolecule{
        Material[] mats=new Material[3];
        
        MiniPEWaterMolecule(IData d, int n){
            super(d,n,false); 
            for(int i=0;i<3;i++){
                mats[i]=((Sphere)atoms[i].getChild(0)).getShape().getAppearance().getMaterial();
                mats[i].setCapability(Material.ALLOW_COMPONENT_WRITE);
                addChild(atoms[i]);
            }
        }		
        private static final double PE_MIN=-50,PE_MAX=50;
        public void update(){
            super.update();
            
            /*if(PE_MIN>data.getAtomPE(dRefNum)){
                PE_MIN=data.getAtomPE(dRefNum);
                System.out.println(PE_MIN);
            }
            if(PE_MAX<data.getAtomPE(dRefNum)){
                PE_MAX=data.getAtomPE(dRefNum);
                System.out.println(PE_MAX);
            }*/
            
            float pe=(float)((data.getAtomPE(dRefNum)-PE_MIN)/(PE_MAX-PE_MIN));
            
            if(pe>.87f) pe=.87f;
            if(pe<0) pe=0f;
            
            Color c=Color.getHSBColor(1f-pe,1f,1f);
            
            float r=((float)c.getRed())/255f;
            float g=((float)c.getBlue())/255f;
            float b=((float)c.getGreen())/255f;
            
            for(int i=0;i<3;i++){
                mats[i].setAmbientColor(r,g,b);
                mats[i].setDiffuseColor(r,g,b);
            }
        }
}