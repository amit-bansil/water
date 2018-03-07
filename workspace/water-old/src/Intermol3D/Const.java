package Intermol3D;
import javax.swing.ImageIcon;

import java.awt.Dimension;
import java.awt.GraphicsEnvironment;
import java.awt.event.KeyEvent;
import java.io.File;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

public final class Const{
    public static final Dimension buttonSize=new Dimension(50,50);
    public static final String helpDir="help\\";
    public static final String imageDir="Images/";
    public static final String configDir="Config/";
    public static String ioRoot;
    public static ResourceBundle configs=ResourceBundle.getBundle(configDir+"presets");
    private static ResourceBundle userVisibleStrings=ResourceBundle.getBundle("IntermolDefault");
    public static IConfig config=new IConfig(ClassLoader.getSystemResourceAsStream(configDir+"ice24.itx"));
    /*This supports basic internationilization:
    All user visible text is written in IntermolDefault.properties,
    in the form {key}={text} then {text} is accessed by calling
    Const.trans({key}).*/
    public static final String trans(String key){
        try{
            return userVisibleStrings.getString(key);
        }catch(MissingResourceException e){
            System.err.println("Failed to load text "+key+"\n"+e.toString()+"\n");
            return key;
        }
    }
    /*This method gets the string corresponding to {key}
    and returns the Virtual Key code of the first letter,
    needed to determin keyboard shortcuts for menu items.
     */
     public static final String _ToSPC(final String s){
     	String r=new String();
     	for(int i=0;i<s.length();i++){
     		if(s.charAt(i)=='_') r+=" ";
     		else r+=s.charAt(i)+"";
     	}
     	return r;
     }
     public static final String SPCTo_(final String s){
     	String r=new String();
     	for(int i=0;i<s.length();i++){
     		if(s.charAt(i)==' ') r+="_";
     		else r+=s.charAt(i)+"";
     	}
     	return r;
     }
     public static final ImageIcon getImage(String name){
     	java.net.URL u=ClassLoader.getSystemResource(imageDir+name);
     	return new ImageIcon(u);
     }
    public static final java.awt.image.BufferedImage getImage(int x, int y){
        return GraphicsEnvironment.getLocalGraphicsEnvironment().
        getDefaultScreenDevice().
        getDefaultConfiguration().
        createCompatibleImage(x,y);
    }

    public static final int transVK(String key){
        try{
            return (int)(userVisibleStrings.getString(key).charAt(0));
        }catch(MissingResourceException e){
            System.err.println("Failed to load VK "+key+"\n"+e.toString()+"\n");
            return KeyEvent.VK_UNDEFINED;
        }
    } 
    public static final void init(String[] args){
    	if(args.length>0) ioRoot=args[0];
    	else ioRoot="Configurations"+File.separator;
    }
}