package Intermol3D;

public final class TransparentWaterMolecule extends BallWaterMolecule{
        //transparent
        static final class TOxAtom extends Atom{
                public TOxAtom(){
                    addChild(ObjLib.getTOAtom());
                }
        }
        static final class THydAtom extends Atom{
	    public THydAtom(){
		addChild(ObjLib.getTHAtom());
	    }
        }
	private static final Atom[] createAtoms(){
		Atom[] atoms=new Atom[3];
		atoms[0]=new TOxAtom();
		atoms[1]=new THydAtom();
		atoms[2]=new THydAtom();
		return atoms;	
	}
	TransparentWaterMolecule(IData d, int n){
		super(d,n,createAtoms());
	}		
}