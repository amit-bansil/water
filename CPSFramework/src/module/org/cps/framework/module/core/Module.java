/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.event.property.BoundPropertyRW;

/**
 */
public interface Module extends Node{
	//neither group or title or description should ever be null
	//use "" for empty description
	//use "" for top group
	//avoid empty title, trim all three of these
    public BoundPropertyRW<String> group();
    public BoundPropertyRW<String> title();
    public BoundPropertyRW<String> description();
}
