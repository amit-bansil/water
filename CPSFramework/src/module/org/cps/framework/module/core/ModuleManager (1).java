/*
 * ModuleManager.java
 * CREATED:    Jul 8, 2004 6:54:35 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.io.DocumentManager;


/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public final class ModuleManager {

	private final ModuleBuilderRegistry moduleBuilderRegistry;
	private final ModuleRegistry moduleRegistry;
	private final ModuleIOManager moduleIOManager;
	public ModuleManager(DocumentManager doc) {
		moduleBuilderRegistry=new ModuleBuilderRegistry();
		moduleRegistry=new ModuleRegistry();
		moduleIOManager=new ModuleIOManager(moduleBuilderRegistry,moduleRegistry,
				doc);
	}
	
	private boolean registering=true;
	private void checkRegistering() {
		if(!registering)
			throw new IllegalStateException("finished registering modules");
	}
	private void checkNotRegistering() {
		if(registering)
			throw new IllegalStateException("registering modules");
	}
	
	public ModuleBuilderRegistry getBuilderRegistry() {
		return moduleBuilderRegistry;
	}
	
	public final void finishedRegistering() {
		checkRegistering();
		registering=false;
		moduleBuilderRegistry.finishedRegistering();
	}

	public ModuleIOManager getModuleIOManager() {
		checkNotRegistering();
		return moduleIOManager;
	}
	public ModuleRegistry getModuleRegistry() {
		checkNotRegistering();
		return moduleRegistry;
	}
}
