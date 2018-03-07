/*
 * SaveableData.java
 * CREATED:    Jan 26, 2005 7:59:37 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-event
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.io;

import cps.jarch.data.event.tools.Source;

import java.io.IOException;

/**
 * generic interface for all data that wishes to allow itself to be
 * saved/loaded.
 * 
 * note read/write/load initial must completely overwrite saveable state, since
 * no they may be called in any order, with any operations on the client state
 * inbetween
 * 
 * TODO create a std. implementation that delegates to some source and
 * begins/ends section automatically, using some accepted set of versions.
 * TODO create a std. implementation for collections
 * @author Amit Bansil
 */
public interface SaveableData extends Source {
	//TODO create std. impl/
	//that uses section version & number + source that it proxies through
	/**
	 * save state
	 * 
	 * @param out
	 * @throws IOException
	 */
	public void write(ObjectOutputStreamEx out) throws IOException;

	/**
	 * read saved state
	 * 
	 * @param in
	 * @throws IOException
	 */
	public void read(ObjectInputStreamEx in) throws IOException;

	/**
	 * restore initial state. usually called after failed/imcomplete load or
	 * when initializing
	 */
	public void loadInitial();
}
