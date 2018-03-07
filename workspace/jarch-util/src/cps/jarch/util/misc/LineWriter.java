/*
 * CREATED ON:    Dec 29, 2005 12:00:56 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.misc;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilterWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;

/**
 * <p>
 * Writes out lines of strings separated by the default platform separator.
 * overcomes odd exception handling & constructors in PrintWriter.
 * TODO finish docs.
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public class LineWriter extends FilterWriter{
	private static final LogEx<LineWriter> log = LogEx.createClassLog(LineWriter.class);
	private static final String lineSeparator;
	static {
		String _lineSeparator="\n";
		try {
			_lineSeparator=System.getProperty("line.separator");
		}catch(SecurityException e) {
			log.warning(null,"could not get property line.separator, guessing \n",e);
		}
		lineSeparator=_lineSeparator;
	}
	public LineWriter(Writer dst) {
		super(dst);
		LangUtils.checkArgNotNull(dst);
	}
	public LineWriter(File f) throws FileNotFoundException {
		//FileOutputStream throws NPE on f==null
		super(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(f))));
		assert f!=null;
	}
	//TODO have a checkLineValid method so we can fail if the line contains newlines
	public final void writeLine(String s) throws IOException {
		write(s);
		writeLine();
	}
	public final void writeLine() throws IOException {
		write(lineSeparator);
	}
	public void write(Object o) throws IOException {
		write(o.toString());
	}
	public void writeLine(Object o) throws IOException {
		writeLine(o.toString());
	}
}
