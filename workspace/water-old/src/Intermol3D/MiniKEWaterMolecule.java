package Intermol3D;
import com.sun.j3d.utils.geometry.Sphere;

import javax.media.j3d.Material;

import java.awt.Color;
public final class MiniKEWaterMolecule extends MiniWaterMolecule{
        Material[] mats=new Material[3];
        
        MiniKEWaterMolecule(IData d, int n){
            super(d,n,false); 
            for(int i=0;i<3;i++){
                mats[i]=((Sphere)atoms[i].getChild(0)).getShape().getAppearance().getMaterial();
                mats[i].setCapability(Material.ALLOW_COMPONENT_WRITE);
                addChild(atoms[i]);
            }
        }		
        private static double PE_MAX=10d,PE_MIN=0;
        public void update(){
            super.update();
            
            for(int i=0;i<3;i++){
                float ke=(float)((data.getAtomKE(dRefNum,i)-PE_MIN)/(PE_MAX-PE_MIN));
            
                if(ke>.87f) ke=.87f;
                if(ke<0f) ke=0f;

                Color c=Color.getHSBColor(1f-ke,1f,1f);

                float r=((float)c.getRed())/255f;
                float g=((float)c.getBlue())/255f;
                float b=((float)c.getGreen())/255f;
            
                mats[i].setAmbientColor(r,g,b);
                mats[i].setDiffuseColor(r,g,b);
            }
        }
}