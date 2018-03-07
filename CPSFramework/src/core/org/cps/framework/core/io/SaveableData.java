/*
 * SaveableData.java
 * CREATED:    Aug 20, 2003 10:44:52 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import java.io.IOException;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericObservable;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public interface SaveableData {
	/**
	 * save state
	 * @param out
	 * @throws IOException
	 */
	public void write(ObjectOutputStreamEx out)throws IOException;
	/**
	 * read saved state
	 * @param in
	 * @param version value passed when writer registered.
	 * @throws IOException
	 */
	public void read(ObjectInputStreamEx in)throws IOException;
	/**
	 * called after all datas read to initialize
	 */
	public void initialize();
	
	//OPTIMIZE create a getStateObject hook and allow null rets for both these
	//(but is error if more than 1 is null)
	/**
	 * a collection of Observables that encapsulate the state of this object
	 * whenever this object changes one of these must fire.
	 */
	public BoundCollectionRO<GenericObservable<?>> getStateObjects(); 
}
