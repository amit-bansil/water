/*
 * SaveableDataHolder.java
 * CREATED:    Aug 22, 2003 3:33:30 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.io;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.util.CompositeCollectionRW;
import org.cps.framework.util.collections.basic.SafeMap;

/**
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public final class SaveableDataHolder {
	//data access
	private final SafeMap<String,SaveableData> data = new SafeMap<String,SaveableData>();
	/**
	 * @return unmodifiable map
	 */
	public final Map<String,SaveableData> getData() {
		return data.getMap();
	}
	private boolean registeringDocumentData = true;
	

	private final CompositeCollectionRW<GenericObservable> stateObservables
		= new CompositeCollectionRW<GenericObservable>();
	public final BoundCollectionRO<GenericObservable<?>> stateObservables(){
	    return stateObservables;
	}
	
	public final void registerData(String name, SaveableData d) {
		if (!registeringDocumentData)
			throw new IllegalStateException("not registering document data");
		data.put(name, d);
		stateObservables.addCollection((BoundCollectionRO<GenericObservable>)d.getStateObjects());
	}
	public final void finishedRegisteringData() {
		if (!registeringDocumentData)
			throw new IllegalStateException("not registering document data");
		registeringDocumentData = false;
	}
	//will cause add+remove
	public final void renameData(SaveableData d,String oldName,String newName){
		data.remove(oldName,d);
		data.put(newName,d);
	}
	//io
	private static final int DATA01_KEY = 1;
	private static final String DATA_NAME = "saveableData";
	public final void read(ObjectInputStreamEx in) throws IOException {
		//read data
		in.beginSection(DATA_NAME, DATA01_KEY);

		int n = in.readInt();
		for (int i = 0; i < n; i++) {
			String name = in.readUTF();
			getData().get(name).read(in);
		}
		in.endSection(DATA_NAME);

	}
	public final void write(ObjectOutputStreamEx out) throws IOException {
		//write data
		out.beginSection(DATA_NAME, DATA01_KEY);

		final Iterator iter = getData().entrySet().iterator();
		final int n = getData().size();
		out.writeInt(n);
		for (int i = 0; i < n; i++) {
			Map.Entry entry = (Map.Entry) iter.next();
			SaveableData d = (SaveableData) entry.getValue();
			String name = (String) entry.getKey();
			out.writeUTF(name);
			d.write(out);
		}
		out.endSection(DATA_NAME);

	}
	public final void initialize() {
		final Iterator iter = getData().values().iterator();
		while (iter.hasNext()) {
			((SaveableData) iter.next()).initialize();
		}
	}
}
