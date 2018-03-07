/*
 * SceneDataSource.java
 *
 * Created on July 25, 2000, 1:47 PM
 */

package Intermol3D;

/**
 *
 * @author  unknown
 * @version 
 */
public class SceneDataSource extends Object {
    private final IData data;
    /** Creates new SceneDataSource */
    public SceneDataSource(IData d) {
        data=d;
    }
    public float[][][] getCoords(){
        return data.getRaw();
    }
    public float[][] getCoordsBuffer(){
        return new float[data.numMols*3][3];
    }
    public int getCoordsBufferX(){ return data.numMols; }
    public int getCoordsBufferY(){ return 3; }
    public int[][] getBonds(){ return data.getBonds(); }
    public I3DObject[] getExt(){ return new I3DObject[0]; }
    public I3DObject[] getExtBuffer(){ return new I3DObject[0]; }
    public int getExtX(){ return 0; }
    public int getNumBonds(){ return data.getNumBonds(); }
    public float getBx(){return data.getBoundsSize().x;}
    public float getBy(){return data.getBoundsSize().y;}
    public float getBz(){return data.getBoundsSize().z;}
}