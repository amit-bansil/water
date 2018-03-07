package Intermol3D;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.vecmath.Vector3f;

//Atom
class Atom extends TransformGroup{
	private final Transform3D t3d = new Transform3D();
	public Atom(){
		setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
	}
	public void moveTo(Vector3f pos){	
		t3d.set(pos);
		setTransform(t3d);
	}
}
public class BallWaterMolecule extends Molecule{
	/*static{
		Intermol3D.splash.setState("Molecule Master");
	}*/
	//Feilds
	protected final Atom[] atoms;
	private final TrackGroup tg;
	protected final IData data; protected final int dRefNum;
	private final Vector3f tPos=new Vector3f();
	
	private final class OxAtom extends Atom{
		public OxAtom(){
			addChild(ObjLib.getOAtom());
		}
	}
	private final class HydAtom extends Atom{
		public HydAtom(){
			addChild(ObjLib.getHAtom());
		}
	}
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
		private final Transform3D tTrans = new Transform3D();
		public void moveTo(float x, float y, float z){
			//note optimizations	
			tempV.set(x,0,z);
			tTrans.set(tempV);
			tmx.setTransform(tTrans);
			
			tempV.z=0;tempV.y=y;
			tTrans.rotX(Math.PI/2f);
			tTrans.setTranslation(tempV);
			tmy.setTransform(tTrans);
			
			tempV.z=z; tempV.x=0;
			tTrans.rotZ(-Math.PI/2f);
			tTrans.setTranslation(tempV);
			tmz.setTransform(tTrans);
		}
	}
	//Public Methods
	public BallWaterMolecule(IData data, int dRefNum){
		this.data=data; this.dRefNum = dRefNum;
		atoms = new Atom[3];
		
		tg=new TrackGroup();
		atoms[0]=new OxAtom(); addChild(atoms[0]);
		atoms[1]=new HydAtom(); addChild(atoms[1]);
		atoms[2]=new HydAtom(); addChild(atoms[2]);
	}
	public BallWaterMolecule(IData data, int dRefNum, Atom[] a){
		this.data=data; this.dRefNum=dRefNum;
		tg=new TrackGroup();
		atoms=a; for(int i=0;i<atoms.length;i++) addChild(atoms[i]);
	}
        //does not add atoms
        protected BallWaterMolecule(IData data, int dRefNum, boolean v){
		this.data=data; this.dRefNum = dRefNum;
		atoms = new Atom[3];
		
		tg=new TrackGroup();
		atoms[0]=new OxAtom();
		atoms[1]=new HydAtom();
		atoms[2]=new HydAtom();
        }
        protected BallWaterMolecule(IData data, int dRefNum, Atom[] a, boolean v){
		this.data=data; this.dRefNum=dRefNum;
		tg=new TrackGroup();
		atoms=a;
	}
	public void update(){
		tg.moveTo(data.getPX(dRefNum,data.O_ATOM),
			data.getPY(dRefNum,data.O_ATOM),
			data.getPZ(dRefNum,data.O_ATOM));
		tPos.set(data.getPX(dRefNum,data.O_ATOM),
			data.getPY(dRefNum,data.O_ATOM),
			data.getPZ(dRefNum,data.O_ATOM));
		atoms[0].moveTo(tPos);
		tPos.set(data.getPX(dRefNum,data.H1_ATOM),
			data.getPY(dRefNum,data.H1_ATOM),
			data.getPZ(dRefNum,data.H1_ATOM));
		atoms[1].moveTo(tPos);
		tPos.set(data.getPX(dRefNum,data.H2_ATOM),
			data.getPY(dRefNum,data.H2_ATOM),
			data.getPZ(dRefNum,data.H2_ATOM));
		atoms[2].moveTo(tPos);
	}	
}