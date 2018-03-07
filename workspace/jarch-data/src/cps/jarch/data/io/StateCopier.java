/*
 * CREATED ON:    Apr 26, 2006 7:00:25 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.data.io;

import cps.jarch.util.misc.LogEx;
import cps.jarch.util.notes.Nullable;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;

/**
 * <p>
 * A utility class for copying the state of a {@link SaveableData} type from one
 * instance into another... TODO move this into a 'Model' class which replaces
 * 'SaveableData'. Model should generally be exposed via a Decorator pattern.
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public class StateCopier {
	private static final LogEx<StateCopier> log = LogEx.createClassLog(StateCopier.class);

	// ByteArrayOutputStream implementation that allows direct access to buffer
	// for better performance
	private static final class ByteArrayOutputStreamEx extends ByteArrayOutputStream {
		ByteArrayOutputStreamEx(byte[] buf) {
			super();
			this.buf = buf;
		}

		byte[] getBuffer() {
			return buf;
		}
	}

	public static final int DEFAULT_BUFFER_SIZE = 128;

	/**
	 * Copies data from <code>source</code> into <code>dest</code>, storing
	 * data temporarily in <code>buf</code> or a larger array if buf is too
	 * small or <code>null</code>. Note that although this method allows the
	 * state of a saveable data object to be copied into the state of another
	 * saveable data that subclasses it this is generally erroneous- a copy
	 * should usually be performed only between objects of the exact same type.
	 * TODO warn on such usage?
	 * 
	 * @throws IOException
	 *             if writing state to buffer or reading it back fails.
	 * @return the array that the temporary data was stored in.
	 */
	public static final <SourceType extends SaveableData, DstType extends SourceType>byte[] doCopy(
			SourceType source, DstType dest, @Nullable byte[] buf) throws IOException {
		log.debugEnterStatic("source, dest, buf", source, dest, buf);

		if (buf == null) buf = new byte[DEFAULT_BUFFER_SIZE];
		ByteArrayOutputStreamEx bout = new ByteArrayOutputStreamEx(buf);
		ObjectOutputStreamEx out = new ObjectOutputStreamEx(bout, false);
		try {
			source.write(out);
			out.flush();
		} finally {
			out.close();
		}
		// get buf from bout incase it has been expanded
		buf = bout.getBuffer();

		ObjectInputStreamEx in = new ObjectInputStreamEx(new ByteArrayInputStream(buf));
		dest.read(in);

		return buf;
	}

	/**
	 * Convenience method that promotes any IOException thrown by
	 * {@link #doCopy(SaveableData, SaveableData, byte[])} to an Error.
	 */
	public static final <SourceType extends SaveableData, DstType extends SourceType>byte[] copy(
			SourceType source, DstType dest, @Nullable byte[] buf) {

		try {
			return doCopy(source, dest, buf);
		} catch (IOException e) {
			throw new Error("should not happen", e);
		}
	}
}