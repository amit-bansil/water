/*
 * ShowURL.java CREATED: Jan 2, 2004 5:38:28 PM AUTHOR: Amit Bansil PROJECT:
 * CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.util;

import org.cps.framework.util.lang.misc.LocalizedException;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.io.IOException;
import java.net.URL;

/**
 * @version 0.0
 * @author Amit Bansil
 */
public final class WebBrowser {
	protected static final ResourceAccessor res = ResourceAccessor
			.load(WebBrowser.class);

	//TODO use JNLP when possible
	public static final void showURL(URL l) throws BrowserException {
		try {
			BrowserLauncher.openURL(l.toExternalForm());
		} catch (IOException e) {
			throw new BrowserException(l, e);
		}
	}

	public static final class BrowserException extends Exception implements
			LocalizedException {
		final URL l;

		public BrowserException(URL l, Throwable cause) {
			super("could not launch browser", cause);
			this.l = l;
		}

		public String getLocalizedMessage() {
			return res.getString("BrowserException.message").replace("{url}",
					l.toExternalForm());
		}
	}
}
