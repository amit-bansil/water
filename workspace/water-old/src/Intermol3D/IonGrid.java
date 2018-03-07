package Intermol3D;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Group;
import javax.media.j3d.Shape3D;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.Vector3f;

import java.awt.Cursor;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
/*
final class IonGridLandscape extends IonGrid{
	Texture2D landscape; 
	protected Shape3D createIonGrid(int res){
		Shape3D temp=ObjLib.getPlane();
		TextureAttributes ta=new TextureAttributes(
			TextureAttributes.REPLACE,new Transform3D(),
			new Color4f(), TextureAttributes.NICEST);
		Texture2D tex=new Texture2D(Texture.BASE_LEVEL,Texture.RGB,res,res);
		tex.setBoundaryModeS(tex.CLAMP);
		tex.setBoundaryModeT(tex.CLAMP);
		tex.setMagFilter(tex.BASE_LEVEL_POINT);
		tex.setMinFilter(tex.BASE_LEVEL_POINT);
		tex.setCapability(tex.ALLOW_IMAGE_WRITE);
		
		landscape =tex;
		temp.getAppearance().setTexture(tex);
		temp.getAppearance().setTextureAttributes(ta);
		//redraw(0);
		return temp;
		//return ObjLib.createIonGrid(res);
	}
	IonGridLandscape(SliderGroupEx sli,int latRes, I3DDisplay disp,IonData data){
		super(sli,latRes,disp,data);
	}
	public void redraw(float v,IonData dat,int res, int cut){
		BufferedImage scape=new BufferedImage(res,res,BufferedImage.TYPE_INT_ARGB);
		scape.setRGB(0,0,res,res,dat.createLandscape(v, res, cut),0,res);
		landscape.setImage(0,new ImageComponent2D(ImageComponent.FORMAT_RGB,scape));
	}
	
}*/
class IonGrid extends BranchGroup{
	private final SliderGroupEx slider;
	private final TransformGroup viewTransform=new TransformGroup(),
		ionTransform=new TransformGroup();
	private int xAnchor;
	private final I3DDisplay frame;
	private Group ion; private BranchGroup ionBranch =new BranchGroup();
	protected Shape3D createIonGrid(int res){
		return ObjLib.createIonGrid(res);
	}
	IonGrid(SliderGroupEx sli,int latRes, I3DDisplay disp,IonData data){
		this.slider=sli; frame=disp;
		addChild(viewTransform);
		viewTransform.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		viewTransform.addChild(createIonGrid(latRes));
		ionTransform.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
		ionTransform.setCapability(TransformGroup.ALLOW_CHILDREN_EXTEND);
		ionTransform.setCapability(TransformGroup.ALLOW_CHILDREN_WRITE);
		viewTransform.addChild(ionTransform);
		ionBranch.setCapability(BranchGroup.ALLOW_DETACH);
		ionTransform.addChild(ionBranch);
		
		ion=ObjLib.getIon(data);
		ionBranch.addChild(ion);
		
		disp.addMouseMotionListener(new MouseMotionAdapter(){
			public void mouseDragged(MouseEvent e){
				float v=(((float)e.getX())-((float)xAnchor))/250f;
				if(v>=1) v=1;
				else if(v<=0) v=0;
				slider.setRealValue(v);
				//slider.fireStateChanged();
			}
		});
		disp.addMouseListener(new MouseAdapter(){
			public void mousePressed(MouseEvent e){
				frame.setCursor(Cursor.getPredefinedCursor( Cursor.E_RESIZE_CURSOR));
				xAnchor=e.getX();
			}
			public void mouseReleased(MouseEvent e){
				frame.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
			}
		});
	}
	private final Vector3f   tPos=new Vector3f(0,0,0);
	private final Transform3D tTrans=new Transform3D();
	
	public void updateGrid(float realX){
		tPos.x=realX;
		tTrans.set(tPos);
		viewTransform.setTransform(tTrans);
	}
	private final Vector3f	iPos=new Vector3f(0,0,0);
	private final Transform3D iTrans=new Transform3D();
	
	public void updateIonPos(float realY,float realZ){
		iPos.y=realZ; iPos.z=realY;
		iTrans.set(iPos);
		ionTransform.setTransform(iTrans);
	}
	public void updateIon(IonData newIon){
		ionTransform.removeChild(0);
		ion=ObjLib.getIon(newIon);
		ionBranch=new BranchGroup();
		ionBranch.setCapability(BranchGroup.ALLOW_DETACH);
		ionBranch.addChild(ion);
		ionTransform.addChild(ionBranch);
	}
}