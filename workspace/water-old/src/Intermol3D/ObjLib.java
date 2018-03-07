package Intermol3D;

import com.sun.j3d.utils.geometry.Box;
import com.sun.j3d.utils.geometry.Sphere;

import javax.media.j3d.Appearance;
import javax.media.j3d.BoundingBox;
import javax.media.j3d.Bounds;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.ColoringAttributes;
import javax.media.j3d.Group;
import javax.media.j3d.LineArray;
import javax.media.j3d.LineAttributes;
import javax.media.j3d.LineStripArray;
import javax.media.j3d.Material;
import javax.media.j3d.PolygonAttributes;
import javax.media.j3d.QuadArray;
import javax.media.j3d.Shape3D;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.media.j3d.TransparencyAttributes;
import javax.media.j3d.TriangleFanArray;
import javax.vecmath.Color3f;
import javax.vecmath.Point3d;
import javax.vecmath.Point3f;
import javax.vecmath.TexCoord2f;
import javax.vecmath.Vector3f;

public final class ObjLib{
    static{
        Intermol3D.splash.setState("Model Library");
    }
    //sizes
    static final float trackSize = 0.16f;
    static Point3f boundsSize = new Point3f(1f,1f,1f);//1;//2.5f;
    static float avgBoundsSize(){
        return (boundsSize.x+boundsSize.y+boundsSize.z)/3f;
    }
    static float maxBound(){
        if( boundsSize.x>=boundsSize.y){
            if( boundsSize.x>=boundsSize.z){
                return boundsSize.x;
            }else{
                return boundsSize.z;
            }
        }else if(boundsSize.z>=boundsSize.y){
            return boundsSize.z;
        }else{
            return boundsSize.y;
        }
    }
    static final float hSize = 0.1f;
    static final float oSize = 0.16f;
    static final float originSize = 0.1f;
    //camera in I3DDisplay

    //colors
    static final Color3f ionColor
    = new Color3f(0.0f,0.7f,0.7f);
    static final Color3f gridColor
    = new Color3f(0.7f,0.7f,0.7f);
    static final Color3f boxColor
    = new Color3f(0.4f,0.4f,0.4f);
    static final Color3f oColor
    = new Color3f(0.9f,0.9f,0.9f);
    static final Color3f hColor
    = new Color3f(0.9f,0.0f,0.0f);
    static final Color3f originColor
    = new Color3f(0.75f,0.75f,0.75f);
    static final Color3f stickColor
    = new Color3f(0.8f,0.0f,0.0f);
    static final Color3f bondColor
    = new Color3f(0.0f,0.8f,0.8f);
    static final Color3f hilightColor
    = new Color3f(1f,1f,1f);
    static final Color3f depthColor
    = new Color3f(0,0,0);
    static final float MAT_ALPHA=0.05f;
    static final float PLANE_ALPHA=0.8f;
    //Shading System- NOT PORTABLE REQUIRES ONE O ATOM PER MOLECULE
    static final Color3f fullyShaded =
    new Color3f(1.0f,1.0f,1.0f);
    static final Color3f unShaded =
    new Color3f(0.3f,0.3f,0.3f);

    public static final Color3f mix(Color3f a, float wA, Color3f b, float wB){
        float x = ((a.x*wA)*(b.x*wB))/(wA+wB);
        float y = ((a.y*wA)*(b.y*wB))/(wA+wB);
        float z = ((a.z*wA)*(b.z*wB))/(wA+wB);
        return new Color3f(x,y,z);
    }
    static final float nw=IData.numMols;
    public static final Color3f mix2(Color3f a,float n){
        return new Color3f(
        (unShaded.x+((fullyShaded.x-unShaded.x)*(n/nw)))*a.x,
        (unShaded.y+((fullyShaded.y-unShaded.y)*(n/nw)))*a.y,
        (unShaded.z+((fullyShaded.z-unShaded.z)*(n/nw)))*a.z);
    }
    public static final Appearance WireFrame = new Appearance();
    static{
        PolygonAttributes pa = new PolygonAttributes();
        pa.setPolygonMode(PolygonAttributes.POLYGON_LINE);
        WireFrame.setColoringAttributes( new ColoringAttributes(
        boxColor,ColoringAttributes.FASTEST));
        WireFrame.setPolygonAttributes(pa);
    }
    public static final Appearance IonWireFrame = new Appearance();
    static{
        PolygonAttributes pa = new PolygonAttributes();
        pa.setPolygonMode(PolygonAttributes.POLYGON_LINE);
        WireFrame.setColoringAttributes( new ColoringAttributes(
        boxColor,ColoringAttributes.FASTEST));
        WireFrame.setPolygonAttributes(pa);
    }
    public static Appearance getShadedMat(Color3f color){
        return getColoredMat(color); //LOOK AT NOTE 1
    }
    public static Appearance getTransparentMat(Color3f color){
        Appearance ret=getColoredMat(color);
        ret.setTransparencyAttributes(
        new TransparencyAttributes(TransparencyAttributes.BLENDED,MAT_ALPHA));
        return ret;
    }
    public static Appearance getPlaneMat(Color3f color){
        Appearance ret=getColoredMat(color);
        ret.setTransparencyAttributes(
        new TransparencyAttributes(TransparencyAttributes.BLENDED,PLANE_ALPHA));
        return ret;
    }
    public static Appearance getColoredMat(Color3f color){
        Material m = new Material(color, depthColor,
        color, hilightColor, 80.0f);
        m.setLightingEnable(true);
        Appearance app = new Appearance();
        app.setMaterial(m);
        return app;
    }
    public static Material getColoredMaterial(Color3f color){
        Material m = new Material(color, depthColor,
        color, hilightColor, 80.0f);
        m.setLightingEnable(true);
        return m;
    }
    public static Appearance GetTrackFrame(){
        Appearance temp = new Appearance();
        PolygonAttributes pa = new PolygonAttributes();
        pa.setPolygonMode(PolygonAttributes.POLYGON_LINE);
        temp.setColoringAttributes( new ColoringAttributes(
        gridColor//NOTE 1
        ,ColoringAttributes.FASTEST));
        temp.setPolygonAttributes(pa);
        return temp;
    }
    public static Appearance getStickMolecule(){
        Appearance temp = new Appearance();
        PolygonAttributes pa = new PolygonAttributes();
        pa.setPolygonMode(PolygonAttributes.POLYGON_LINE);
        temp.setColoringAttributes( new ColoringAttributes(
        stickColor
        ,ColoringAttributes.FASTEST));
        temp.setLineAttributes(new LineAttributes(2,LineAttributes.PATTERN_SOLID,
        false));
        temp.setPolygonAttributes(pa);
        return temp;
    }
    public static Appearance getBond(){
        Appearance temp = new Appearance();
        PolygonAttributes pa = new PolygonAttributes();
        pa.setPolygonMode(PolygonAttributes.POLYGON_LINE);
        temp.setColoringAttributes( new ColoringAttributes(
        bondColor
        ,ColoringAttributes.FASTEST));
        temp.setLineAttributes(new LineAttributes(1,LineAttributes.PATTERN_SOLID,
        false));
        temp.setPolygonAttributes(pa);
        return temp;
    }
    public static Sphere getTHAtom(){
        return new Sphere(hSize,
        Sphere.GENERATE_NORMALS, 8, getTransparentMat(hColor));
    }
    public static Sphere getHAtom(){
        Sphere atom = new Sphere(hSize,
        Sphere.GENERATE_NORMALS, 8, getShadedMat(hColor));
        return atom;
    }
    public static Sphere getMiniHAtom(){
        Sphere atom = new Sphere(hSize/3f,
        Sphere.GENERATE_NORMALS, 8/2, getShadedMat(hColor));
        return atom;
    }
    public static Sphere getTOAtom(){
        return new Sphere(oSize,
        Sphere.GENERATE_NORMALS, 10, getTransparentMat(oColor));
    }
    public static Sphere getOAtom(){
        Sphere atom = new Sphere(oSize,
        Sphere.GENERATE_NORMALS, 10, getShadedMat(oColor));
        return atom;
    }
    public static Sphere getMiniOAtom(){
        Sphere atom = new Sphere(oSize/3f,
        Sphere.GENERATE_NORMALS, 7, getShadedMat(oColor));
        return atom;
    }
    public static Sphere getIon(IonData d, int n){
        return new Sphere(d.size[n],Sphere.GENERATE_NORMALS,10,getShadedMat(d.color[n]));
    }
    public static Group getIon(IonData d){

        Group g=new Group();
        if(d.numberOfIons==1){
            g.addChild(getIon(d,0));
            return g;
        }else if(d.numberOfIons==2){
            TransformGroup tg1=new TransformGroup();
            Transform3D t3d1=new Transform3D();
            TransformGroup tg2=new TransformGroup();
            Transform3D t3d2=new Transform3D();
            tg1.addChild(getIon(d,0));
            tg2.addChild(getIon(d,1));
            t3d1.set(d.getDistance());
            Vector3f tv3f=new Vector3f(-d.getDistance().x,-d.getDistance().y,-d.getDistance().z);
            t3d2.set(tv3f);
            tg1.setTransform(t3d1);
            tg2.setTransform(t3d2);
            g.addChild(tg1);
            g.addChild(tg2);
            return g;
        }else{
            throw new IllegalArgumentException("Groups of more than 2 ions not supported");
        }
    }
    public static Box getOriginBox(){
        return new Box(originSize,originSize,
        originSize,getColoredMat(originColor));
    }
    public static Shape3D getPlane(){
        QuadArray geo=new QuadArray(4, QuadArray.COORDINATES |
        QuadArray.NORMALS |
        QuadArray.TEXTURE_COORDINATE_2);
        Point3f[] coords=new Point3f[4];
        coords[0]=new Point3f(0,0,0);
        coords[1]=new Point3f(0,boundsSize.y,0);
        coords[2]=new Point3f(0,1,boundsSize.z);
        coords[3]=new Point3f(0,0,boundsSize.z);

        TexCoord2f[] texCoords=new TexCoord2f[4];
        texCoords[0]=new TexCoord2f(0,0);
        texCoords[1]=new TexCoord2f(1,0);
        texCoords[2]=new TexCoord2f(1,1);
        texCoords[3]=new TexCoord2f(0,1);

        Vector3f[] normals=new Vector3f[4];
        normals[0]=new Vector3f(1,0,0);
        normals[1]=new Vector3f(1,0,0);
        normals[2]=new Vector3f(1,0,0);
        normals[3]=new Vector3f(1,0,0);

        geo.setCoordinates(0,coords);
        geo.setTextureCoordinates(0,0,texCoords);
        geo.setNormals(0,normals);
        return new Shape3D(geo,getPlaneMat(new Color3f(1,1,1)));
    }
    public static Shape3D getBoundsGrid(){
        LineStripArray boundsGeo = new LineStripArray(
    11,TriangleFanArray.COORDINATES, new int[]{11});

        Point3f[] cords = new Point3f[11];
        cords[0] = new Point3f(1/2f,-1/2f,-1/2f);
        cords[1] = new Point3f(-1/2f,-1/2f,-1/2f);
        cords[2] = new Point3f(-1/2f,-1/2f,1/2f);
        cords[3] = new Point3f(-1/2f,1/2f,1/2f);
        cords[4] = new Point3f(-1/2f,1/2f,-1/2f);
        cords[5] = new Point3f(1/2f,1/2f,-1/2f);
        cords[6] = new Point3f(1/2f,-1/2f,-1/2f);
        cords[7] = new Point3f(1/2f,-1/2f,1/2f);
        cords[8] = new Point3f(-1/2f,-1/2f,1/2f);
        cords[9] = new Point3f(-1/2f,-1/2f,-1/2f);
        cords[10] = new Point3f(-1/2f,1/2f,-1/2f);

        boundsGeo.setCoordinates(0,cords);

        return new Shape3D(boundsGeo,WireFrame);

    }
    public static Shape3D createIonGrid(int res){
        res=res/2;
        LineArray boundsGeo = new LineArray(
        (res+1)*4,LineArray.COORDINATES);

        Point3f[] cords = new Point3f[(res+1)*4];
        for(int i=0;i<res+1;i++){
            cords[i*4]=new Point3f(0,0,(boundsSize.z/res)*i);
            cords[(i*4)+1]=new Point3f(0,boundsSize.y,(boundsSize.z/res)*i);
            cords[(i*4)+2]=new Point3f(0,(boundsSize.y/res)*i,0);
            cords[(i*4)+3]=new Point3f(0,(boundsSize.y/res)*i,boundsSize.z);
        }
        boundsGeo.setCoordinates(0,cords);

        return new Shape3D(boundsGeo,IonWireFrame);
    }
    public static Bounds getBounds(){
        return new BoundingBox(new Point3d(0,0,0),
        new Point3d(boundsSize.x,boundsSize.y,boundsSize.z));
    }
    public static Shape3D getTrackSquare(){
        QuadArray trackGeo = new QuadArray( 4,
        QuadArray.COORDINATES);

        trackGeo.setCoordinate(0,new Point3f(trackSize,0f,trackSize));
        trackGeo.setCoordinate(1,new Point3f(trackSize,0f,-trackSize));
        trackGeo.setCoordinate(2,new Point3f(-trackSize,0f,-trackSize));
        trackGeo.setCoordinate(3,new Point3f(-trackSize,0f,trackSize));

        return new Shape3D(trackGeo,GetTrackFrame());
    }
    ObjLib(){
    }
    public static void removeAllChildren(BranchGroup g){
        int n=g.numChildren();
        for(int i=0;i<n;i++){
            g.removeChild(0);
        }
    }
}