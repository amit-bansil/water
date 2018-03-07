/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.event.collection.BoundCollectionRO;

import java.util.Map;

/**
 */
public interface Node{
    //TODO rename to dependencies
    //may not be null
    public BoundCollectionRO<Dependency> getDependencies();
    //readonly..
    public Map<String,Node> getChildren();
    //all dependencies of this object on others must be killed
    //don't call
    public void unlinked();
    public void linked(ModuleRegistry r);
}
