package Intermol3D;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.swing.Timer;
import javax.vecmath.Point3d;
import javax.vecmath.Vector3d;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public final class ViewManager implements ActionListener{
static{ Intermol3D.splash.setState("View Presets"); }
    public static final int TOP=0,LEFT=1,FRONT=2,STANDARD=3,SPIN_SLOW=4,SPIN_FAST=5;
    private final Timer timer=new Timer(1000/25,this);
    private final Transform3D current=new Transform3D();
    private TransformGroup tg;
    public ViewManager(TransformGroup tg){
        this.tg=tg;
        setZoom(ObjLib.avgBoundsSize()+1);
        setCenter(0,0,0);
        setAngle(Math.toRadians(-135),Math.toRadians(-45));
        instantSnap();
    }
    public void setTransformGroup(TransformGroup g){
        tg=g;
        g.setTransform(current);
    }
    public void setView(int n){
        setZoom(ObjLib.avgBoundsSize()+1);
        setCenter(0,0,0);
        switch(n){
            case TOP:
                setSpinning(false);setAngle(Math.toRadians(-135),Math.toRadians(0));
                
            break;
            case LEFT:
                setSpinning(false);setAngle(Math.toRadians(-90),Math.toRadians(-90));

            break;
            case FRONT:
                setSpinning(false);setAngle(Math.toRadians(-180),Math.toRadians(-90));

            break;
            case STANDARD:
                setSpinning(false);setAngle(Math.toRadians(-135),Math.toRadians(-45));

            break;
            case SPIN_FAST:
                setSpinning(true); setSpin(80,0);
            break;
            case SPIN_SLOW:
                setSpinning(true); setSpin(20,0);
            break;
            default:
            throw new IllegalArgumentException(
            "Unexpected View Constant: "+n);
        }
        gradualSnap(20);
    }

    private Point3d center,desiredCenter;
    private double angley,anglex, desiredAnglex,desiredAngley;
    private double zoom, desiredZoom;

    public void setCenter(double x,double y, double z){
        desiredCenter=new Point3d(x,y,z);
    }
    public void setAngle(double x, double y){
        desiredAnglex=x; desiredAngley=y;
    }
    public void setZoom(double zoom){
        desiredZoom=zoom;
    }
    public void changeZoom(int x){
        desiredZoom+=(x/10d);
        zoom=desiredZoom;
        instantSnap();
        //if(!spin){ instantSnap(); desiredZoom+=(x/10d); }
        //else{ zoom=desiredZoom+=(x/10d); }
    }
    public void changeAngle(int x,int y){
        //if(!spin){
        desiredAnglex+=Math.toRadians(x);
        desiredAngley+=Math.toRadians(y);
        anglex=desiredAnglex;
        angley=desiredAngley;
        instantSnap();
        /*}else{
        deltaX+=(Math.toRadians(x/40d));
        deltaY+=(Math.toRadians(y/40d));
        }*/
    }
    public void setSpin(float x,float y){

        deltaX=Math.toRadians(x/40d);
        deltaY=Math.toRadians(y/40d);

    }
    boolean spin=false;
    public void setSpinning(boolean v){
        spin=v;
        if(v){
            deltaX=0;
            deltaY=0;
            timer.start();
        }else timer.stop();
    }
    private int alpha=0;
    private double deltaZoom, deltaX,deltaY;
    private Point3d deltaCenter;

    public void instantSnap(){
        if(!spin){
            zoom=desiredZoom;
            anglex=desiredAnglex;
            angley=desiredAngley;
            center=desiredCenter;
            desiredAnglex=anglex=anglex%Math.toRadians(360d);
            desiredAngley=angley=angley%Math.toRadians(360d);
            update();
        }
    }
    public void gradualSnap(int n){
        if(!spin){
            alpha=n;
            deltaZoom=(zoom-desiredZoom)/alpha;
            deltaX=(anglex-desiredAnglex)/alpha;
            deltaY=(angley-desiredAngley)/alpha;
            deltaCenter=new Point3d(
            (center.x-desiredCenter.x)/alpha,
            (center.y-desiredCenter.y)/alpha,
            (center.z-desiredCenter.z)/alpha
            );
            timer.start();
        }
    }
    Transform3D transformX=new Transform3D(),
    transformY=new Transform3D();
    private void update(){
        //System.out.println((int)Math.toDegrees(anglex)+","
        //			+(int)Math.toDegrees(angley)+","
        //			+zoom);

        transformY.rotZ(-anglex);
        transformX.rotX(-angley);


        current.set(new Transform3D());

        current.mul(transformX, current);
        current.mul(transformY, current);

        Vector3d translation = new Vector3d(
        center.x+(zoom*Math.sin(anglex)*Math.sin(angley)),
        center.y+(zoom*Math.cos(anglex)*Math.sin(angley)),
        center.z+(zoom*Math.cos(angley))
        );
        current.setTranslation(translation);

        // Update xform
        tg.setTransform(current);
    }
    public void actionPerformed(ActionEvent e){
        if(spin){
            desiredAnglex=anglex-=deltaX;
            desiredAngley=angley-=deltaY;
            update();
        }else if(alpha>0){
            zoom-=deltaZoom;
            anglex-=deltaX;
            angley-=deltaY;
            center.sub(deltaCenter);
            alpha--;
            update();
        }else{
            timer.stop();
        }
        desiredAnglex=anglex=anglex%Math.toRadians(360d);
        desiredAngley=angley=angley%Math.toRadians(360d);
    }
    public Transform3D getView(){
        return current;
    }
}