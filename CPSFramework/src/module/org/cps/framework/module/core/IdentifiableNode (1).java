/*
 * IdentifiableModule.java
 * CREATED:    Jul 6, 2004 6:42:28 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.util.BasicDescription;

/**
 * a node with a constant description (i.e. not a module)
 * @version 0.0
 * @author Amit Bansil
 */
public interface IdentifiableNode extends Node{
	public BasicDescription getDescription();//constant
}
