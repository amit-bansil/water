package Intermol3D;

//Mini
public class MiniWaterMolecule extends BallWaterMolecule{
	static final class MiniOxAtom extends Atom{
            public MiniOxAtom(){
                addChild(ObjLib.getMiniOAtom());
            }
        }
        static final class MiniHydAtom extends Atom{
                public MiniHydAtom(){
                        addChild(ObjLib.getMiniHAtom());
                }
        }
	private static final Atom[] createAtoms(){
		Atom[] atoms=new Atom[3];
		atoms[0]=new MiniOxAtom();
		atoms[1]=new MiniHydAtom();
		atoms[2]=new MiniHydAtom();
		return atoms;	
	}
	MiniWaterMolecule(IData d, int n){
		super(d,n,createAtoms());
        }
        protected MiniWaterMolecule(IData d, int n, boolean v){
            super(d,n,createAtoms(),v);
        }
}