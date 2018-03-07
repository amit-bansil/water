package Intermol3D;
import javax.swing.JPanel;

import java.awt.Color;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.ComponentAdapter;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.geom.AffineTransform;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;

abstract class PEView extends JPanel{
	public abstract void setX(float x);
	public abstract void setIon(IonData ionData,float xv);
	public abstract void setLatRes(int latRes);
	public abstract void update();
}

final class PEFlatView extends PEView{
	private final SliderGroupEx zSlider,ySlider;
	private IonData ion;
	private float xPos=-1;
	private int[] peLandscape;//use y*width+x
	private int latRes,cutoff;
	private BufferedImage scape;
	private AffineTransformOp rescale;
	private int xAnchor,yAnchor;
	PEFlatView(SliderGroupEx y, SliderGroupEx z, IonData id, int res,int cut){
		zSlider=z; ySlider=y;ion=id; cutoff=cut;
		setSize(250,250);
		
		setLatRes(res);
		setX(0);
		
		addComponentListener(new ComponentAdapter(){
			public void componentResized(){
				setLatRes(latRes);
			}
		});
		
		addMouseMotionListener(new MouseMotionAdapter(){
			public void mouseDragged(MouseEvent e){
				float v=((float)e.getX())/((float)getSize().width);
				if(v>=1) v=1;
				else if(v<=0) v=0;
				zSlider.setRealValue(v);
				v=1f-( ((float)e.getY())/((float)getSize().height));
				if(v>=1) v=1;
				else if(v<=0) v=0;
				ySlider.setRealValue(v);
				fastRepaint();
			}
		});
		addMouseListener(new MouseAdapter(){
			public void mousePressed(MouseEvent e){
				setCursor(Cursor.getPredefinedCursor( Cursor.HAND_CURSOR));
			}
			public void mouseReleased(MouseEvent e){
				setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
			}
		});
	}
	public void setX(float num){
		if(xPos==num) return; else xPos=num;
System.out.println("draw graph");
		peLandscape=ion.createLandscape(xPos,latRes,cutoff);
		Color pixel;
		scape.setRGB(0,0,latRes+1,latRes+1,peLandscape,0,latRes);
		paintImmediately(0,0,getSize().width,getSize().height);
	
	}
	public void setIon(IonData ionData,float xv){
		ion=ionData; //TO DO: real support
		setX(xv);
	}
	private boolean fastPainton=false;
	public void update(){
		fastRepaint();
	}
	public void setSize(Dimension d){
		super.setSize(d);
		System.out.println(d.width+","+d.height);
	}
	public void fastRepaint(){
		fastPainton=true;
		paintImmediately(0,0,getSize().width,getSize().height);
	}
	BufferedImageOp rescaleop;
	public void paintComponent(Graphics g){
		//if(!fastPainton){
			if(scape!=null){
				if(rescaleop!=null){
					((Graphics2D)g).drawImage(scape,rescaleop,(getSize().width/latRes)/-2,(getSize().height/latRes)/-2 );
				}
			}
		//}else fastPainton=false;
		
		for(int i=0;i<ion.numberOfIons;i++){
			g.setColor(new Color(ion.color[i].x,ion.color[i].y,ion.color[i].z));
			g.fillOval(
				(int)( ((double)getSize().width)*((    double)zSlider.getRealValue()) )  - ((int)(ion.sigion[i]*80f)),
				(int)( ((double)getSize().height)*(1d-(double)ySlider.getRealValue()) ) - ((int)(ion.sigion[i]*80f)),
				(int)(ion.sigion[i]*160f),(int)(ion.sigion[i]*160f) );
		}	
	}
	public void setLatRes(int res){
		latRes=res;
		AffineTransform scale=new AffineTransform();
		scale.scale((double)getSize().width/(double)latRes,(double)getSize().height/(double)latRes);
		rescaleop=new AffineTransformOp(scale,AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
		scape=new BufferedImage(latRes+1,latRes+1,BufferedImage.TYPE_INT_ARGB);
	}
}
/*final class PE3DView extends PEView{
	private IonData data;
	private final SliderGroupEx zSlider,ySlider,xSlider;
	private final PE3DDisplay display;
	private IonGridLandscape grid; private int cut,res;
	PE3DView(SliderGroupEx y, SliderGroupEx z,SliderGroupEx x, IonData d, int res, int cut, IData idat,IInterface gui){
		zSlider=z; ySlider=y;data=d; this.cut=cut; this.res=res; data=d; xSlider=x;
		display=new PE3DDisplay(idat,gui);
		grid=new IonGridLandscape(x,res,display,data);
		setX(1f-(float)x.getRealValue());
		setSize(250,250);
		setLayout(new BorderLayout());
		add(display,BorderLayout.CENTER);
		display.addIonGrid(grid);
		display.clear();
	}
	public void setX(float x){
		grid.updateGrid(x);
		grid.redraw(x,data,res,cut);
		display.updateView(x,(float)ySlider.getRealValue(),(float)zSlider.getRealValue());
	}
	public void setIon(IonData ionData,float xv){
		data=ionData;
		grid.updateIon(ionData);
		grid.redraw(xv,ionData,res,cut);
	}
	public void setLatRes(int latRes){
		display.removeIonGrid();
		grid=new IonGridLandscape(xSlider,res,display,data);
		display.addIonGrid(grid);
	}
	public void update(){
		grid.updateIonPos((float)ySlider.getRealValue()*ObjLib.boundsSize.y,(float)zSlider.getRealValue()*ObjLib.boundsSize.z);
	}
}
final class PE3DDisplay extends I3DDisplay{
	PE3DDisplay(IData d,IInterface gui){
		super(gui,d);
	}
	protected BallWaterMolecule createBallWaterMolecule(IData data, int n){
		return new TransparentWaterMolecule(data,n);
	}
	private final Transform3D viewT3D=new Transform3D();
	protected void enableControls(){
		//do nothing instead of load interface
	}
	public void updateView(float x,float y,float z){
		x*=ObjLib.boundsSize.x;y*=ObjLib.boundsSize.y;z*=ObjLib.boundsSize.z;
		viewT3D.lookAt(new Point3d(x+(ObjLib.boundsSize.x*2),y,z), new Point3d(x,y,z),
			new Vector3d(0,1,0));
		viewT3D.invert();
		//viewTransform.setTransform(viewT3D);
	}
}*/