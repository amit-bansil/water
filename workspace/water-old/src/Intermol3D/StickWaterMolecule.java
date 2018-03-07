package Intermol3D;
import javax.media.j3d.LineArray;
import javax.media.j3d.Shape3D;

public final class StickWaterMolecule extends Molecule{
/*	static{
		Intermol3D.splash.setState("Stick Geometry");
	}*/
	
	private final IData data;
	private final Shape3D molecules/*,tracks*/,bonds;
	//private final PointArray trackG;
	private final LineArray molsG;
	private final LineArray bondsG;
	public StickWaterMolecule(IData data){
		this.data=data;
			
		/*trackG=new PointArray(IData.numMols*3,
			PointArray.COORDINATES);*/
		molsG=new LineArray(IData.numMols*4,
			LineArray.COORDINATES);
		bondsG=new LineArray(IData.numMols*4,
			LineArray.COORDINATES);
				
		//trackG.setCapability(trackG.ALLOW_COORDINATE_WRITE);
		molsG.setCapability(molsG.ALLOW_COORDINATE_WRITE);
		bondsG.setCapability(molsG.ALLOW_COORDINATE_WRITE);
		
		update();//???
	
		molecules=new Shape3D(molsG,ObjLib.getStickMolecule());
		//tracks=new Shape3D(trackG,ObjLib.GetTrackFrame());
		bonds=new Shape3D(bondsG,ObjLib.getBond());
		
		addChild(molecules);
		//addChild(tracks);
		addChild(bonds);
	}
	
	private float o[]=new float[3];
	private float h1[]=new float[3];
	private float h2[]=new float[3];
	private float px[]={1,0,1};
	private float py[]={1,1,0};
	private float pz[]={0,1,1};
	private float zero[]={0,0,0};
	
	public void update() {
		int n = 0, m = 0;
		for (int i = 0; i < IData.numMols; i++) {
			px[0] = data.getPX(i, data.O_ATOM);
			py[1] = data.getPY(i, data.O_ATOM);
			pz[2] = data.getPZ(i, data.O_ATOM);
			px[2] = data.getPZ(i, data.O_ATOM);
			py[0] = data.getPX(i, data.O_ATOM);
			pz[1] = data.getPY(i, data.O_ATOM);

			/*
			 * trackG.setCoordinate(m,px); trackG.setCoordinate(m+1,py);
			 * trackG.setCoordinate(m+2,pz);
			 */

			o = new float[]{px[0], py[1], pz[2]};
			h1 = new float[]{data.getPX(i, data.H1_ATOM), data.getPY(i, data.H1_ATOM),
					data.getPZ(i, data.H1_ATOM)};
			h2 = new float[]{data.getPX(i, data.H2_ATOM), data.getPY(i, data.H2_ATOM),
					data.getPZ(i, data.H2_ATOM)};
			molsG.setCoordinate(n, h1);
			molsG.setCoordinate(n + 1, o);
			molsG.setCoordinate(n + 2, o);
			molsG.setCoordinate(n + 3, h2);
			n += 4;
			m += 3;
		}
		n = 0;
		for (int i = 0; i < IData.numMols * 2; i++) {
			if (i < data.getNumBonds()) {
				float[] src = new float[]{
						data.getPX(data.getBonds()[i][0], data.O_ATOM),
						data.getPY(data.getBonds()[i][0], data.O_ATOM),
						data.getPZ(data.getBonds()[i][0], data.O_ATOM)};
				float[] dst = new float[]{
						data.getPX(data.getBonds()[i][1], data.getBonds()[i][2]),
						data.getPY(data.getBonds()[i][1], data.getBonds()[i][2]),
						data.getPZ(data.getBonds()[i][1], data.getBonds()[i][2])};
				
				boolean tooLong=false;
				if(Math.abs(src[0]-dst[0])>ObjLib.boundsSize.x/2)tooLong=true;
				if(Math.abs(src[1]-dst[1])>ObjLib.boundsSize.y/2)tooLong=true;
				if(Math.abs(src[2]-dst[2])>ObjLib.boundsSize.z/2)tooLong=true;
				if(!tooLong) {
					bondsG.setCoordinate(n, src);
					bondsG.setCoordinate(n + 1, dst);
				}else {
					bondsG.setCoordinate(n, zero);
					bondsG.setCoordinate(n + 1, zero);
				}
			} else {
				bondsG.setCoordinate(n, zero);
				bondsG.setCoordinate(n + 1, zero);
			}
			n += 2;
		}
	}	
}