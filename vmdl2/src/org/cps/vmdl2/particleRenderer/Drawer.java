/*
 * Drawer.java
 * CREATED:    Aug 22, 2004 8:54:53 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.particleRenderer;

import org.cps.framework.core.event.simple.SimpleNotifier;
import org.cps.framework.core.event.simple.SimpleObservable;

/**
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class Drawer {

	public Drawer() {
		super();
	}

	public abstract void kill(GLAccess access);

	public abstract void init(GLAccess access);
	public abstract void draw(GLAccess access);
	
	private final SimpleNotifier changeNotifier = new SimpleNotifier(this);
	protected final SimpleNotifier notifier() {
		return changeNotifier;
	}
	public final SimpleObservable observable() {
		return changeNotifier;
	}
}
