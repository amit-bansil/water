/*
 * CREATED ON:    Dec 22, 2005 5:06:26 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Nullable;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * Utility for reading streams that contain lists of text data.
 * </p>
 * 
 * @version $Id: ListReader.java 82 2005-12-29 05:18:39Z bansil $
 * @author Amit Bansil
 */
public class ListReader extends LineNumberReader{
	/**
	 * default extension that should be used by named resources that contain
	 * data intended for processing by a ListReader.
	 */
	public static final String EXTENSION=".list";
	
	public ListReader(Reader in) {
		super(in);
		abazaba();
	}
	private void abazaba() {
		throw new NotImplementedException(ListReader.class,"abazaba");
	}
	/**
	 * @return next non-blank non-comment line or <code>null</code> if the end of the
	 * stream is reached. Comment lines are any line starting with a '#' character.
	 * Any trailing whitespace is stripped from the line returned.
	 */
	public final @Nullable String readDataLine()throws IOException {
		String line=readLine();
		
		//end of file
		if(line==null)return line;
		
		//try again on blank line
		if(StringUtils.isBlank(line))return readDataLine();
		
		//try again on comments
		if(line.charAt(0)=='#')return readDataLine();
		
		//otherwise strip trailing whitespace & return
		return stripTrailingWhitespace(line);
	}
	// ------------------------------------------------------------------------
	// external utility methods

	/**
	 * @return all the data lines in <code>url</code>
	 */
	public static final List<String> asList(InputStream s)throws IOException{
		ListReader r=new ListReader(new InputStreamReader(s));
		try {
			return asList(r);
		}finally {
			r.close();
		}
	}
	/**
	 * @return all the data lines in <code>f</code>
	 */
	public static final List<String> asList(File f)throws IOException{
		ListReader r=new ListReader(new FileReader(f));
		try {
			return asList(r);
		}finally {
			r.close();
		}
	}
	/**
	 * @return all the data lines remaining in <code>r</code>
	 */
	public static final List<String> asList(ListReader r)throws IOException{
		List<String> ret=new ArrayList<String>();
		String l;
		while((l=r.readDataLine())!=null)ret.add(l);
		return ret;
	}
	
	// ------------------------------------------------------------------------
	// internal utility methods
	
    private static String stripTrailingWhitespace(String s) {
            for(int i=s.length()-1;i>=0;i--)
                    if(!Character.isWhitespace(s.charAt(i)))return s.substring(0,i+1);
            return "";
    }
    // TODO document
	public IOException newIOE(String message,String line) {
		return new IOException(
			"An error ocurred while parsing line " + getLineNumber()+":\n" +
					"Problem: " + message + "\n" + 
					"Line: '" + line + "'");
	}
}
