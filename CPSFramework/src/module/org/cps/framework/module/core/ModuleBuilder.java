/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.core.util.BasicDescription;

import java.io.IOException;

/**
 */
public abstract class ModuleBuilder<T extends Module> {
	private final BasicDescription desc;

	private final Class<T> type;
	//requires description
	public ModuleBuilder(Class<T> type, BasicDescription desc) {
		this.desc = desc;
		this.type = type;
		desc.getDescription();//will throw mre if no description
	}

	public final BasicDescription getDescription() {
		return desc;
	}

	public final Class<T> getType() {
		return type;
	}
	
	public abstract T createModule(ModuleRegistry r);

	public abstract void writeCreationData(T m,
			ObjectOutputStreamEx out) throws IOException;

	public abstract T recreateModule(ObjectInputStreamEx in,
			String name,ModuleRegistry r) throws IOException;
}