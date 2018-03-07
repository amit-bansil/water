/*
 * ModuleBuilderRegistry.java
 * CREATED:    Jul 8, 2004 6:53:51 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.util.collections.arrays.ObjectArray;
import org.cps.framework.util.collections.basic.SafeMap;

import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ModuleBuilderRegistry {
	public ModuleBuilderRegistry() {
		//do nothing
	}

	//module builders
	private boolean finishedRegisteringModuleBuilders = false;

	private final void checkFinishedRegistering() {
		if (!finishedRegisteringModuleBuilders)
				throw new IllegalStateException("!finished registering");
	}

	private final void checkRegistering() {
		if (finishedRegisteringModuleBuilders)
				throw new IllegalStateException("finished registering");
	}

	private final SafeMap<ObjectArray<String>, ModuleBuilder> moduleBuildersByName = new SafeMap();

	private final SafeMap<ModuleBuilder, String> builderPackages = new SafeMap();

	private final Set<ModuleBuilder> moduleBuilders = new HashSet();

	private final Set<ModuleBuilderGroup> rootGroups = new HashSet(),
		safeRootGroups=Collections.unmodifiableSet(rootGroups);

	private final Set<ModuleBuilderGroup> allGroups = new HashSet();

	public final void registerModuleBuilder(ModuleBuilderGroup group,
			ModuleBuilder b, String builderPackage) {
		checkRegistering();
		if (!allGroups.contains(group))
				throw new Error("group " + group + " not yet registered");
		group.addChildBuilder(b);
		builderPackages.put(b, builderPackage);
		moduleBuildersByName.put(ObjectArray.create(builderPackage, b
				.getDescription().getName()), b);
		if (!moduleBuilders.add(b))
				throw new Error("builder " + b + "already registered");
	}

	public final void registerBuilderGroup(ModuleBuilderGroup parent,
			ModuleBuilderGroup builderGroup) {
		checkRegistering();
		if (parent != null && !allGroups.contains(parent))
				throw new Error("parent " + parent + " not yet registered");
		if (allGroups.contains(builderGroup))
				throw new Error("builder " + builderGroup
						+ " already registered");
		if (!allGroups.add(builderGroup)) throw new UnknownError();

		if (parent != null) parent.addChildGroup(builderGroup);
		else if (!rootGroups.add(builderGroup)) throw new UnknownError();

	}
	public final void finishedRegistering() {
		checkRegistering();
		finishedRegisteringModuleBuilders = true;
		for(ModuleBuilderGroup group:allGroups)
			group.finishedRegisteringBuilders();
	}


	public Set<ModuleBuilderGroup> getRootGroups() {
		checkFinishedRegistering();
		return safeRootGroups;
	}
	public final String[] getFullName(ModuleBuilder b) {
		checkFinishedRegistering();
		return new String[]{b.getDescription().getName(),
				builderPackages.get(b)};
	}

	public final ModuleBuilder getModuleBuilder(String[] fullName) {
		checkFinishedRegistering();
		return moduleBuildersByName.get(ObjectArray.create(fullName));
	}
}