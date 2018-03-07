/*
 * CREATED ON:    Dec 28, 2005 3:54:00 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Nullable;
import cps.jarch.util.notes.ThreadSafe;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * <p>Common utilities for working with input/ouput streams.
 * </p>
 * @version $Id: IOUtils.java 99 2006-01-27 15:27:25Z bansil $
 * @author Amit Bansil
 */
public class IOUtils {
	private static final LogEx<IOUtils> log = LogEx.createClassLog(IOUtils.class);
	// ------------------------------------------------------------------------
	// copy
	/**
	 * Copies content of <code>in</code> to <code>out</code>. The streams
	 * do not need to be buffered. Remember to flush and close streams if
	 * neccessary afterward.
	 * 
	 * @throws IOException
	 *             if one occurs while overwriting dst or opening the streams.
	 */
	@ThreadSafe public static final void copy(InputStream in, OutputStream out)
			throws IOException {
		byte[] buffer = getCopyBuffer();
		int count = 0;
		do {
			out.write(buffer, 0, count);
			count = in.read(buffer, 0, buffer.length);
		} while (count != -1);

		releaseCopyBuffer(buffer);
	}
	//very simple buffer caching system where a buffer is
	//provided by getCopyBuffer and released by releaseCopyBuffer.
	//getCopyBuffert returns a cached buffer unless the cached buffer is in use
	//in which case a buffer of size EXTRA_BUFFER_SIZE is created.
	//this is optimized for the case where almost all of the time copyFile is called
	//serially, if more than PARALLEL_THRESHOLD of buffers created require a buffer creation a warning
	//is printed
	private static final int EXTRA_BUFFER_SIZE=1024*2;
	private static final byte[] copyBuffer=new byte[1024*10];
	private static boolean copyBufferInUse=false;
	private static synchronized void releaseCopyBuffer(byte[] buffer) {
		if(buffer==copyBuffer)copyBufferInUse=false;
	}
	private static final float PARALLEL_THRESHOLD=.05f;
	private static final float PARALLEL_MIN=10f;
	private static int copyCount=0,parallelCount=0;
	private static synchronized byte[] getCopyBuffer() {
		copyCount++;
		if (copyBufferInUse) {
			parallelCount++;
			if (parallelCount > PARALLEL_MIN
					&& ((float) parallelCount / (float) copyCount) > PARALLEL_THRESHOLD) {
				log.warning(null, "getCopyBuffer is being used in parallel"
						+ " while optimized for serial access,"
						+ " performance degradation will result");
				//only warn once, after this
				//copyCount < 0 => parallelCount / copyCount < 0 > PARALLEL_THRESHOLD => 
				//parallelCount /  copyCount) > PARALLEL_THRESHOLD == false
				copyCount=Integer.MIN_VALUE;
			} else {
				log.debug("parallel buffer needed to be created for {0}", Thread
					.currentThread());
			}
			return new byte[EXTRA_BUFFER_SIZE];
		} else {
			copyBufferInUse = true;
			return copyBuffer;
		}
	}
	// ------------------------------------------------------------------------
	//close
	/**
	 * Calls <code>im.close()</code> if <code>in!=null</code>.
	 * If an IOException occurs while calling <code>out.close()</code> it is caught and a
	 * warning is printed. This is useful when closing multiple streams in a finally block
	 * since it ensures that they will all be closed.
	 */
	public static final void close(@Nullable InputStream in) {
		try {
			in.close();
		} catch (IOException e) {
			log.warning(null,
				"unexpected IOException while closing input stream={0}", e,
				in);
		}
	}
	
	/**
	 * Calls <code>out.close()</code> if <code>out!=null</code>.
	 * If an IOException occurs while calling <code>out.close()</code> it is caught and a
	 * warning is printed. This is useful when closing multiple streams in a finally block
	 * since it ensures that they will all be closed.
	 */
	public static final void close(@Nullable OutputStream out) {
		try {
			out.close();
		} catch (IOException e) {
			log.warning(null,
				"unexpected IOException while closing output stream={0}", e,
				out);
		}
	}
	/**
	 * @return <code>new IOException(message)</code> with cause already initialized.
	 */
	public static IOException newIOE(String message,@Nullable Throwable cause) {
		LangUtils.checkArgNotNull(message);
		return (IOException)new IOException(message).initCause(cause);
	}
	public static IOException newIOE(Throwable cause) {
		LangUtils.checkArgNotNull(cause);
		return (IOException)new IOException().initCause(cause);
	}
}
