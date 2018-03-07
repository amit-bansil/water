/*
 * IConfigFilter.java
 *
 * Created on August 3, 2000, 11:57 AM
 */

package Intermol3D;

/**
 *
 * @author  unknown
 * @version 
 */
import javax.swing.filechooser.FileFilter;

public class IConfigFilter extends FileFilter {
	public static final IConfigFilter
		FILTER_ALL=new IConfigFilter(new String[]{"itx","icf","imv"},Const.trans("file.filter.all")),
		FILTER_TXT=new IConfigFilter(new String[]{"itx"},Const.trans("file.filter.txt")),
		FILTER_ICF=new IConfigFilter(new String[]{"icf"},Const.trans("file.filter.icf")),
		FILTER_IMV=new IConfigFilter(new String[]{"imv"},Const.trans("file.filter.imv"));
	
	private final String t[],d;
    public IConfigFilter(String[] type, String desc){
    	t=type;
    	d=desc;
    }
    public String[] getType(){
    	return t;
    }
    public boolean accept(java.io.File f) {
        if (f.isDirectory()) {
            return true;
        }

        String extension = getExtension(f);
        if (extension != null) {
            for(int i=0;i<t.length;i++){
            	if(t[i].equals(extension)) return true;
            }
        }

        return false;
    }

    /*
     * Get the extension of a file.
     */
    public static String getExtension(java.io.File f) {
        String ext = null;
        String s = f.getName();
        int i = s.lastIndexOf('.');

        if (i > 0 &&  i < s.length() - 1) {
            ext = s.substring(i+1).toLowerCase();
        }
        return ext;
    }
    public static final boolean isICF(String s){
    	int i = s.lastIndexOf('.');
    	String ext=null;
    	if (i > 0 &&  i < s.length() - 1) {
            ext = s.substring(i+1).toLowerCase();
        	if(ext.equals("icf")) return true;
        }
        return false;
    }
    // The description of this filter
    public String getDescription() {
        return d;
    }
}