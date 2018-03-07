/*
 * SimpleModule.java
 * CREATED:    Jul 6, 2004 6:40:19 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.BoundCollectionRW;
import org.cps.framework.core.event.collection.BoundListRW;
import org.cps.framework.module.core.Dependency;
import org.cps.framework.module.core.ModuleRegistry;
import org.cps.framework.module.core.Node;

import java.util.Collections;
import java.util.Map;

/**
 * a very basic module that just has dependencies
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class AbstractModule implements Node {
	private final String name;
	public AbstractModule(String name) {
		this.name=name;
	}
    public final String getName() {
    	return name;
    }
	private final BoundCollectionRW<Dependency> deps=
		BoundListRW.createArrayList();
	protected BoundCollectionRW<Dependency> getDependenciesRW(){
		return deps;
	}
    public final BoundCollectionRO<Dependency> getDependencies(){
    	return deps;
    }
    public Map<String,Node> getChildren(){
    	return Collections.emptyMap();
    }
    public void linked(ModuleRegistry r) {
    	//do nothing
    }
}
