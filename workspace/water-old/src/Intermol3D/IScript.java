package Intermol3D;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Hashtable;
import java.util.Vector;

final class IScript{
    private Hashtable events;
    private static final Vector hooks=new Vector();
    private final IData data;
    //asociates a description with a method name for auto caption generation
    public static void register(String methodName,String desc){
    }
    
    IScript(IData dat){
        data=dat;
    }
    //runs a frames events
    public void run(int fNum){
    }
    //saves an event to a specific frame
    public void add(int fNum,String methodName,Object[] args){
    }
    //removes event at fNum
    public void remove(int fNum){
    }
    //moves all events including and after fnum back length frames
    public void cut(int fNum,int length){
    }
    //saves this script
    public void save(OutputStream out){
    }
    //loads a script
    public void load(InputStream in){
    }
    //returns the current caption
    public String getCation(){
        return null;
    }
    
}