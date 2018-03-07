/*
 * StreamCopier.java
 * CREATED:    Aug 19, 2004 4:41:44 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class StreamCopier {
	private static final byte[] copyBuffer = new byte[8 * 1024];

	public static final void copy(final InputStream in, final OutputStream out)
			throws IOException {
		copy(in, out, -1);
	}

	public static final void copy(final InputStream in, final OutputStream out,
			final long lenL) throws IOException {
		synchronized (copyBuffer) {
			final int len = (int) lenL;
			if (len != lenL)
					throw new IllegalArgumentException(
							"stream Length must be less than "
									+ Integer.MAX_VALUE + " bytes");
			final int lenb = (int) Math.floor((double) len
					/ (double) copyBuffer.length)
					* copyBuffer.length;
			if (len > 0) {
				for (int i = copyBuffer.length; i <= lenb; i += copyBuffer.length) {
					int n = 0, c;
					while (n < copyBuffer.length) {
						c = in.read(copyBuffer, n, copyBuffer.length - n);
						out.write(copyBuffer, n, c);
						n += c;
					}
				}
				int k;
				for (int i = 0; i < len - lenb;) {
					k = in.read(copyBuffer, i, (len - lenb) - i);
					out.write(copyBuffer, i, k);
					i += k;
				}
			} else {
				int k = 0;
				while (true) {
					for (int i = 0; i < copyBuffer.length;) {
						k = in.read(copyBuffer, i, copyBuffer.length - i);
						if (k == -1) break;
						out.write(copyBuffer, i, k);
						i += k;
					}
					if (k == -1) break;
				}
			}
		}
	}
}