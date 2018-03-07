/*
 * ModuleBuilderGroup.java
 * CREATED:    Jul 8, 2004 6:18:18 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.util.BasicDescription;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public final class ModuleBuilderGroup {
	private final BasicDescription description;
	public ModuleBuilderGroup(BasicDescription description) {
		this.description=description;
	}

	private boolean finishedRegisteringModuleBuilders = false;
	private final void checkNotRegistering() {
		if (!finishedRegisteringModuleBuilders)
				throw new IllegalStateException("!finished registering");
	}
	private final void checkRegistering() {
		if (finishedRegisteringModuleBuilders)
				throw new IllegalStateException("finished registering");
	}
	
	public final void addChildBuilder(ModuleBuilder builder) {
		checkRegistering();
		if(!childBuilders.add(builder))throw new Error();
	}
	public final void addChildGroup(ModuleBuilderGroup group) {
		checkRegistering();
		if(!childGroups.add(group))throw new Error();
	}
	
	public final void finishedRegisteringBuilders() {
		checkRegistering();
		finishedRegisteringModuleBuilders = true;
		childGroups=Collections.unmodifiableSet(childGroups);
		childBuilders=Collections.unmodifiableSet(childBuilders);	
	}
	
	public final BasicDescription getDescription() {
		checkNotRegistering();
		return description;
	}
	private Set<ModuleBuilderGroup> childGroups=new HashSet();
	public final Set<ModuleBuilderGroup> getChildGroups(){
		checkNotRegistering();
		return childGroups;
	}
	private Set<ModuleBuilder> childBuilders=new HashSet();
	public final Set<ModuleBuilder> getChildBuilders(){
		checkNotRegistering();
		return childBuilders;
	}
}
