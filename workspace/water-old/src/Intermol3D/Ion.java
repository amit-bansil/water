package Intermol3D;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.Vector3f;

public final class Ion extends Molecule{
	/*static{
		Intermol3D.splash.setState("Ion Master");
	}*/
	//Feilds
	private final TrackGroup[] tg;
	private final IData data;
	private final Vector3f tPos=new Vector3f();
	private final Transform3D tTrans=new Transform3D();
	private final int numIons;
	//Track Group
	private final class TrackGroup extends BranchGroup{
		private final TrackMaster tmx, tmy, tmz;
		private static final int XTRACK=0,YTRACK=1,ZTRACK=2;
		
		private final class TrackMaster extends TransformGroup{
			public TrackMaster(int type){
    	    	addChild(ObjLib.getTrackSquare());
			}
		}
		
		public TrackGroup(){
			tmx=new TrackMaster(XTRACK);
			tmy=new TrackMaster(YTRACK);
			tmz=new TrackMaster(ZTRACK);
			addChild(tmx);
			addChild(tmy);
			addChild(tmz);
		}
		
		private final Vector3f tempV = new Vector3f();
		private final Transform3D tTrans2 = new Transform3D();
		public void moveTo(float x, float y, float z){
			//note optimizations	
			tempV.set(x,0,z);
			tTrans2.set(tempV);
			tmx.setTransform(tTrans2);
			
			tempV.z=0;tempV.y=y;
			tTrans2.rotX(Math.PI/2f);
			tTrans2.setTranslation(tempV);
			tmy.setTransform(tTrans2);
			
			tempV.z=z; tempV.x=0;
			tTrans2.rotZ(-Math.PI/2f);
			tTrans2.setTranslation(tempV);
			tmz.setTransform(tTrans2);
		}
	}
	//Public Methods
	private final TransformGroup[] move;
	
	public Ion(IData data, IonData d){
		this.data=data; this.numIons = d.numberOfIons;
		tg=new TrackGroup[d.numberOfIons];
		move=new TransformGroup[d.numberOfIons];
		for(int i=0;i<d.numberOfIons;i++){
			tg[i]=new TrackGroup();
			move[i]=new TransformGroup();
			move[i].setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
			move[i].addChild(ObjLib.getIon(d,i));
			addChild(move[i]);
		}
	}
	public void update(){
		for(int i=0;i<numIons;i++){
			tg[i].moveTo(data.getIonX(i),
				data.getIonY(i),
				data.getIonZ(i));
			tPos.set(data.getIonX(i),
				data.getIonY(i),
				data.getIonZ(i));
			tTrans.set(tPos);
			move[i].setTransform(tTrans);
		}
	}	
}
