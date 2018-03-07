package Intermol3D;
import com.sun.j3d.utils.universe.SimpleUniverse;

import javax.media.j3d.AmbientLight;
import javax.media.j3d.BoundingSphere;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Canvas3D;
import javax.media.j3d.DirectionalLight;
import javax.media.j3d.Group;
import javax.media.j3d.ImageComponent;
import javax.media.j3d.ImageComponent2D;
import javax.media.j3d.Screen3D;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JPanel;
import javax.vecmath.Color3f;
import javax.vecmath.Point3d;
import javax.vecmath.Vector3d;
import javax.vecmath.Vector3f;

import java.awt.BorderLayout;
import java.awt.Container;
import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
import java.awt.event.MouseMotionListener;
import java.awt.image.BufferedImage;

public class I3DDisplay extends Container{

    static{
        Intermol3D.splash.setState("3D Code");
    }
    private final IData data;
    private ViewManager vm=null;
    private Molecule[] molecules;
    private final BranchGroup objRoot=new BranchGroup();
    private final BranchGroup moleculeRoot=new BranchGroup();
    private final BranchGroup ionRoot=new BranchGroup();
    private Ion[] ions= null;
    private Canvas3D canvas;
    private SimpleUniverse simpleU;
    private final JPanel controls;
    private final JComboBox energyBox;
    
    public I3DDisplay(JPanel face,JPanel cont, IData d,JComboBox energy){
        controls=cont; data=d; energyBox=energy;
        canvas=new Canvas3D(SimpleUniverse.getPreferredConfiguration());

        simpleU = new SimpleUniverse(canvas);
        vm = new ViewManager(simpleU.getViewingPlatform().getViewPlatformTransform());
        createSceneGraph();
        simpleU.addBranchGraph(objRoot);

        if(d.ions!=null) for(int i=0;i<d.ions.length;i++) addIon(d.ions[i]);
        addComponentListener(new ComponentAdapter(){
            public void componentResized(ComponentEvent e){
                removeAll();
                simpleU.getViewer().getView().removeCanvas3D(canvas);
                canvas=new Canvas3D(SimpleUniverse.getPreferredConfiguration());
                simpleU.getViewer().getView().addCanvas3D(canvas);

                addCanvas();
            }
        });
        setLayout(null); addCanvas();
        enableControls();
        face.setLayout(new BorderLayout());
        face.add(this);
    }
    private void addCanvas(){
        add(canvas);
        canvas.setSize(new Dimension(getSize().width,getSize().height));
        canvas.setLocation(new Point(0,0));
    }
    //screen shot support------------------------------------------------------------
    private boolean offScreen=false;
    private Canvas3D offCanvas;
    public void renderOff(){
    	offCanvas.renderOffScreenBuffer();
    	offCanvas.waitForOffScreenRendering();
    }
    public void setHighQuality(boolean v){
    	simpleU.getViewer().getView().setSceneAntialiasingEnable(v);
    }
    public void setOffScreen(boolean v){
    	if(v==offScreen) return;
    	offScreen=v;
    	if(v==true){
        	offCanvas=new Canvas3D(SimpleUniverse.getPreferredConfiguration(),true);
            BufferedImage offImage=new BufferedImage(getSize().width,getSize().height,
            	BufferedImage.TYPE_INT_ARGB);
		    ImageComponent2D buffer = new ImageComponent2D(
		                                ImageComponent.FORMAT_RGBA, offImage);
		    //buffer.setCapability(ImageComponent2D.ALLOW_IMAGE_READ);
		    offCanvas.setOffScreenBuffer(buffer);
		    Screen3D s=canvas.getScreen3D(),offS=offCanvas.getScreen3D();
		    offS.setSize(s.getSize());
		    offS.setPhysicalScreenWidth(s.getPhysicalScreenWidth());
		    offS.setPhysicalScreenHeight(s.getPhysicalScreenHeight());
		    simpleU.getViewer().getView().addCanvas3D(offCanvas);
    	}else{
    		simpleU.getViewer().getView().removeCanvas3D(offCanvas);
    		offCanvas=null;
    	}	
    }
    public BufferedImage getOffScreenImage(){
		return offCanvas.getOffScreenBuffer().getImage();
    }

    public void start(){
        updateMols();
    }

    public void stop(){
        updateMols();
    }

    public void step(){
        updateMols();
    }

    public void clear(){
    	canvas.stopRenderer();
    	if(ions!=null) removeIons();
    	
	    if(molecules!=null){
	    	ObjLib.removeAllChildren(moleculeRoot);    
	        molecules=null;
    	}
    	
    	displayMode=Const.trans("displayMode.balls");
    	energyMode=Const.trans("energy.off");
    	vm.setView(vm.STANDARD);
    	viewPresets.setSelectedIndex(0);
    	displayPresets.setSelectedIndex(0);
    	energyBox.setSelectedIndex(0);
    	
    	setSpectrum(null);
    	
        molecules=new BallWaterMolecule[IData.numMols];
        for(int i = 0; i< molecules.length; i++){
            molecules[i]=createBallWaterMolecule(data,i);
            moleculeRoot.addChild(molecules[i]);
        }

        updateMols();
        
        canvas.startRenderer();
    }
    private final Vector3f tv3f=new Vector3f();

    private void updateMols(){

        for(int i = 0; i< molecules.length; i++)
        molecules[i].update();
        if(ions!=null){
            for(int i = 0; i< ions.length; i++) ions[i].update();
        }
        updateScale();
    }
    public String toString(){
        return "I3DDisplay\n";
    }
    //3d ion view hook
    protected BallWaterMolecule createBallWaterMolecule(IData data, int n){
        if(energyMode==null)
            return new BallWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.off")))
            return new BallWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.pe")))
            return new PEWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.ke")))
            return new KEWaterMolecule(data,n);
        else
            return null;
    }
    protected BallWaterMolecule createMiniWaterMolecule(IData data, int n){
        if(energyMode==null)
            return new MiniWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.off")))
            return new MiniWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.pe")))
            return new MiniPEWaterMolecule(data,n);
        else if(energyMode.equals(Const.trans("energy.ke")))
            return new MiniKEWaterMolecule(data,n);
        else
            return null;
    }
    private void createSceneGraph() {
        objRoot.addChild(moleculeRoot);
        objRoot.addChild(ionRoot);

        lightScene(objRoot);
        addSceneBox(objRoot);

        moleculeRoot.setCapability(Group.ALLOW_CHILDREN_EXTEND);
        moleculeRoot.setCapability(Group.ALLOW_CHILDREN_WRITE);
        moleculeRoot.setCapability(Group.ALLOW_CHILDREN_READ);
        moleculeRoot.setCapability(BranchGroup.ALLOW_DETACH);

        ionRoot.setCapability(Group.ALLOW_CHILDREN_EXTEND);
        ionRoot.setCapability(Group.ALLOW_CHILDREN_WRITE);
        ionRoot.setCapability(Group.ALLOW_CHILDREN_READ);

        objRoot.setCapability(BranchGroup.ALLOW_DETACH);

        objRoot.compile();
    }

    public void addIon(IonData d){
        canvas.stopRenderer();
        if(ions == null){
            ions=new Ion[1];
        }else{
            Ion[] temp=new Ion[ions.length+1];
            for(int i=0;i<ions.length;i++){
                temp[i]=ions[i];
            }
            ions=temp;
            //throw new IllegalStateException("multiple ion groups not supported");
        }
        ions[ions.length-1]=new Ion(data,d);
        ions[ions.length-1].compile();
        ionRoot.addChild(ions[ions.length-1]);
        ions[ions.length-1].update();

        canvas.startRenderer();
    }
    public void removeIons(){ //throw new IllegalStateException("multiple ion groups not supported");
        canvas.stopRenderer();
        if(ions==null) throw new IllegalStateException("No ions present to be removed!");
        /*if(ions.length==1){
            ions[0].detach();
            ions=null;
            return;
        }*/
        for(int i=0;i<ions.length;i++)
            ions[i].detach();        
        ions=null;
        //Ion[] temp=new Ion[ions.length-1];
        //int n=0;

        //for(int i=0;i<ions.length;i++){
        //    if(ions[i].dRefNum!=dRefNum){
        //        temp[n]=ions[i]; n++;
        //    }else{
                //ionRoot.removeChild(0); //TO DO make meaningful, not zero
        //        ions[i].detach();
        //    }

        //}
        //ions=temp;
        canvas.startRenderer();
    }
    private void createMoleculeGraph(){
        canvas.stopRenderer();
        ObjLib.removeAllChildren(moleculeRoot);
        if(Const.trans("displayMode.balls").equals(displayMode)){
            molecules=new BallWaterMolecule[IData.numMols];
            for(int i = 0; i< IData.numMols; i++){
                molecules[i]=createBallWaterMolecule(data,i);
                molecules[i].compile();
                moleculeRoot.addChild(molecules[i]);
            }
        }else if(Const.trans("displayMode.mixed").equals(displayMode)){
            molecules=new Molecule[IData.numMols+1];
            for(int i = 0; i< IData.numMols; i++){
                molecules[i]=createMiniWaterMolecule(data,i);
                molecules[i].compile();
                moleculeRoot.addChild(molecules[i]);
            }
            molecules[IData.numMols]=new StickWaterMolecule(data);
            molecules[IData.numMols].compile();
            moleculeRoot.addChild(molecules[IData.numMols]);
        }else if(Const.trans("displayMode.sticks").equals(displayMode)){
System.out.println("sticks");
            molecules=new StickWaterMolecule[1];
            molecules[0]=new StickWaterMolecule(data);
            molecules[0].compile();
            moleculeRoot.addChild(molecules[0]);
        }
        updateMols();
        canvas.startRenderer();

    }
    private void lightScene(BranchGroup root){
        //Shine it with two lights.
        Color3f lColor = new Color3f(0.7f, 0.7f, 0.7f);
        Color3f alColor = new Color3f(0.45f, 0.45f, 0.45f);
        Vector3f lDir  = new Vector3f(0.0f, -1.0f, -1.0f);

        BoundingSphere bounds =
        new BoundingSphere(new Point3d(0.0,0.0,0.0), 100.0);

        AmbientLight algt = new AmbientLight(alColor);
        algt.setInfluencingBounds(bounds);
        root.addChild(algt);

        DirectionalLight dlgt = new DirectionalLight(lColor, lDir);
        dlgt.setInfluencingBounds(bounds);
        root.addChild(dlgt);
    }
    private final TransformGroup boundsScale=new TransformGroup();
    private void addSceneBox(BranchGroup root){
        boundsScale.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);
        root.addChild(boundsScale);
        boundsScale.addChild(ObjLib.getBoundsGrid());
        Transform3D rx=new Transform3D(),ry=new Transform3D(),rz=new Transform3D();
        rx.rotX(Math.PI); ry.rotY(Math.PI/2); rz.rotZ(Math.PI/2);
        ry.mul(rz);
        rx.mul(ry);
        TransformGroup boundsRotation=new TransformGroup(rx);
        boundsScale.addChild(boundsRotation);
        boundsRotation.addChild(ObjLib.getBoundsGrid());
        updateScale();
    }
    private final Transform3D boundsTransform=new Transform3D();
    private void updateScale(){
        boundsTransform.setScale(new Vector3d((double)ObjLib.boundsSize.x,(double)ObjLib.boundsSize.y,(double)ObjLib.boundsSize.z));
        boundsScale.setTransform(boundsTransform);
    }
    private Point anchor=new Point();
    private ComboGroupEx displayPresets=new ComboGroupEx("displayMode.label"),
    viewPresets=new ComboGroupEx("view.label");
    private JPanel displayControls=new JPanel();
    private MouseMotionListener trackballL, zoomL;
    private JButton zoom,trackball;
    /*private final VectorControl spinDirection=new VectorControl(400,400,Const.buttonSize.width,Const.buttonSize.height){
        protected void vectorChanged(){
            vm.setSpin(getVector().x,getVector().y);
        }
    };
    private final JCheckBox spinningBox=new JCheckBox(Const.trans("spinning.label"),false);
    private final JLabel zoomLabel=new JLabel(Const.trans("zoom.label")),
    trackBallLabel=new JLabel(Const.trans("trackball.label")),
    displayLabel=new JLabel(Const.trans("displayMode.label")),
    viewLabel=new JLabel(Const.trans("view.label"));*/
    private String displayMode,energyMode;
    private void enableControls(){
        displayPresets.addItem(Const.trans("displayMode.balls"));
        displayPresets.addItem(Const.trans("displayMode.sticks"));
        //displayPresets.addItem(Const.trans("displayMode.pe"));
        displayPresets.addItem(Const.trans("displayMode.mixed"));
        displayPresets.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==e.SELECTED){
                    String evt=(String)(e.getItem());
                    if(evt.equals(displayMode)) return;
                    displayMode=evt;
                    createMoleculeGraph();
                }
            }
        });
        displayMode=Const.trans("displayMode.balls");

        viewPresets.addItem(Const.trans("cameraMode.fixed.standard"));
        viewPresets.addItem(Const.trans("cameraMode.fixed.top"));
        viewPresets.addItem(Const.trans("cameraMode.fixed.front"));
        viewPresets.addItem(Const.trans("cameraMode.fixed.left"));
        viewPresets.addItem(Const.trans("cameraMode.spinning.slow"));
        viewPresets.addItem(Const.trans("cameraMode.spinning.fast"));
        viewPresets.addItemListener(new ItemListener(){
            public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==e.SELECTED){
                    String evt=(String)(e.getItem());
                    if(evt.equals(Const.trans("cameraMode.fixed.standard") ))
                        vm.setView(vm.STANDARD);
                    else if(evt.equals(Const.trans("cameraMode.fixed.top") ))
                        vm.setView(vm.TOP);
                    else if(evt.equals(Const.trans("cameraMode.fixed.front") ))
                        vm.setView(vm.FRONT);
                    else if(evt.equals(Const.trans("cameraMode.fixed.left") ))
                        vm.setView(vm.LEFT);
                    else if(evt.equals(Const.trans("cameraMode.spinning.slow")))
                        vm.setView(vm.SPIN_SLOW);
                    else if(evt.equals(Const.trans("cameraMode.spinning.fast")))
                        vm.setView(vm.SPIN_FAST);
                    
                }
            }
        });
        
        energyBox.addItem(Const.trans("energy.off"));
        energyBox.addItem(Const.trans("energy.pe"));
        energyBox.addItem(Const.trans("energy.ke"));
        energyBox.addItemListener(new ItemListener(){
        public void itemStateChanged(ItemEvent e){
                if(e.getStateChange()==e.SELECTED){
                    String evt=(String)(e.getItem());
                    if(evt.equals(energyMode)) return;
                    energyMode=evt;
                    if(energyMode.equals(Const.trans("energy.off")))
			            setSpectrum(null);
			        else if(energyMode.equals(Const.trans("energy.pe")))
			            setSpectrum("pespectrum.gif");
			        else if(energyMode.equals(Const.trans("energy.ke")))
			            setSpectrum("kespectrum.gif");
                    createMoleculeGraph();
                }
            }
        });
        
        energyMode=Const.trans("energy.off");
        displayControls=controls;
        displayControls.setLayout(new BoxLayout(displayControls, BoxLayout.X_AXIS));
        //displayControls.setBackground(Color.darkGray);

        zoom=new ToolbarButtonEx("zoom",false);

        trackball=new ToolbarButtonEx("trackball",false);

        zoom.addMouseListener(new MouseAdapter(){
            public void mousePressed(MouseEvent e){
                anchor.x=e.getX(); anchor.y=e.getY();
                controls.setCursor(Cursor.getPredefinedCursor( Cursor.S_RESIZE_CURSOR));
                zoom.addMouseMotionListener(zoomL);
            }
            public void mouseReleased(MouseEvent e){
                zoom.removeMouseMotionListener(zoomL);
                controls.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
            }
        });
        trackball.addMouseListener(new MouseAdapter(){
            public void mousePressed(MouseEvent e){
                anchor.x=e.getX(); anchor.y=e.getY();
                controls.setCursor(Cursor.getPredefinedCursor( Cursor.MOVE_CURSOR ));
                trackball.addMouseMotionListener(trackballL);
            }
            public void mouseReleased(MouseEvent e){
                trackball.removeMouseMotionListener(trackballL);
                controls.setCursor(Cursor.getPredefinedCursor(Cursor.DEFAULT_CURSOR));
            }
        });
        zoomL=new MouseMotionAdapter(){
            public void mouseDragged(MouseEvent e){
                vm.changeZoom(e.getY()-anchor.y);
                anchor.y=e.getY();
            }
        };
        trackballL=new MouseMotionAdapter(){
            public void mouseDragged(MouseEvent e){
                vm.changeAngle(e.getX()-anchor.x,e.getY()-anchor.y);
                anchor.x=e.getX(); anchor.y=e.getY();
            }
        };

        displayPresets.setAlignmentY(1.0f);
        viewPresets.setAlignmentY(1.0f);
        zoom.setAlignmentY(0.5f);
        trackball.setAlignmentY(0.5f);

        displayControls.add(displayPresets.getPanel());
        displayControls.add(javax.swing.Box.createRigidArea(new Dimension(5,5)));
        displayControls.add(viewPresets.getPanel());
        displayControls.add(javax.swing.Box.createRigidArea(new Dimension(5,5)));
        displayControls.add(zoom);
        displayControls.add(javax.swing.Box.createRigidArea(new Dimension(2,2)));
        displayControls.add(trackball);
    }
	/*public static final JFrame spectrumWindow= new JFrame();
	private static final JLabel         spectrumIcon=new JLabel();
	static{
		JPanel content=new JPanel();
		content.setLayout(new BorderLayout());
		content.setBorder(BorderFactory.createEmptyBorder(6,6,6,6));
		content.add(spectrumIcon,BorderLayout.CENTER);
		spectrumWindow.setContentPane(content);
		spectrumWindow.setVisible(false);
	}*/	
	private void setSpectrum(String name){
		/*if(name==null){ spectrumWindow.setVisible(false); return; }
		spectrumWindow.setTitle(energyMode+" Spectrum");
		spectrumIcon.setIcon(new ImageIcon(ClassLoader.getSystemResource(Const.imageDir+name))); 
		spectrumWindow.setVisible(true);
		spectrumWindow.pack();
		spectrumWindow.setLocation(20,20);
		spectrumWindow.toFront();*/
	}
    private IonGrid grid;
    private BranchGroup gridTransform;
    public void addIonGrid(IonGrid grid){
        canvas.stopRenderer();
        this.grid=grid;
        grid.setCapability(BranchGroup.ALLOW_DETACH);
        gridTransform=new BranchGroup();
        gridTransform.setCapability(BranchGroup.ALLOW_DETACH);
        //gridTransform.setCapability(BranchGroup.ALLOW_CHILDREN_WRITE);
        //gridTransform.setCapability(BranchGroup.ALLOW_DETACH);
        Transform3D gt3d=new Transform3D();
        gt3d.set( new Vector3f(ObjLib.boundsSize.x/-2f,
        	ObjLib.boundsSize.y/-2f,ObjLib.boundsSize.z/-2f ));        	
        TransformGroup gt=new TransformGroup(gt3d);
        gridTransform.addChild(gt);        
        gt.addChild(grid);
        gridTransform.compile();
        ionRoot.addChild(gridTransform);
        canvas.startRenderer();
    }
    public void removeIonGrid(){
        canvas.stopRenderer();
        gridTransform.detach();
        gridTransform=null;
        grid=null;
        canvas.startRenderer();
    }
}

