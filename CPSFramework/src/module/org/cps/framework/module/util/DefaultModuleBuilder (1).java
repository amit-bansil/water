/*
 * DefaultModuleBuilder.java
 * CREATED:    Jul 9, 2004 1:46:57 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.module.core.Module;
import org.cps.framework.module.core.ModuleBuilder;
import org.cps.framework.module.core.ModuleRegistry;

import java.io.IOException;
import java.util.UUID;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class DefaultModuleBuilder<T extends Module> extends ModuleBuilder<T> {

	/**
	 * creates DefaultModuleBuilder.
	 * @param type
	 * @param desc
	 */
	public DefaultModuleBuilder(Class<T> type, BasicDescription desc) {
		super(type, desc);
	}

	public T createModule(ModuleRegistry r) {
		T ret = _createModule(
					getDescription().getName() + " " + UUID.randomUUID(),r);
		return ret;
	}
	

	public void writeCreationData(T m,
			ObjectOutputStreamEx out) throws IOException{
		//do nothing
	}

	public T recreateModule(ObjectInputStreamEx in,
			String name,ModuleRegistry r) throws IOException{
		return _createModule(name,r);
	}
	protected T _createModule(String name,ModuleRegistry r) {
		T ret;
		try {
			ret = getType().newInstance();
		} catch (InstantiationException e1) {
			//should not happen
			throw new Error(e1);
		} catch (IllegalAccessException e1) {
			//should not happen
			throw new Error(e1);
		}
		r.addModule(ret,name,this);
		return ret;
	}

}
