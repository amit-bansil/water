/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

/**
 * immutable structure describing the
 * dependence between a source and target node.
 */
public class Dependency{
    private final Node target,src;
    private final boolean targetChangedBySource,sourceChangedByTarget;
    public Dependency(Node src,Node target,boolean targetChangedBySource,
            boolean sourceChangedByTarget){
        assert src!=target;
        
        this.target=target;
        this.src=src;
        this.targetChangedBySource=targetChangedBySource;
        this.sourceChangedByTarget=sourceChangedByTarget;
    }

    public final boolean isSourceChangedByTarget(){
        return sourceChangedByTarget;
    }
    public final Node getTarget(){
        return target;
    }
    public final Node getSource(){
        return src;
    }
    public final boolean isTargetChangedBySource(){
        return targetChangedBySource;
    }
    public void remove() {
    	throw 
			new UnsupportedOperationException("module does not implement remove");
    }
}
