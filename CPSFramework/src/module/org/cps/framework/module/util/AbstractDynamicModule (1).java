/*
 * AbstractDynamicModule.java
 * CREATED:    Jul 8, 2004 11:53:36 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.module.core.Module;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class AbstractDynamicModule extends AbstractSaveableModule
		implements Module {

	public AbstractDynamicModule(String name) {
		super(name);
		description = new DefaultBoundPropertyRW(false, "");
		title = new DefaultBoundPropertyRW(false, "");
		group = new DefaultBoundPropertyRW(false, "");
		startNamespace("ADM");
		registerData("description", description);
		registerData("title", title);
		registerData("group", group);
		closeNamespace();
	}

	public void unlinked() {
		//do nothing
	}

	private final DefaultBoundPropertyRW<String> title,description,group;

	public final BoundPropertyRW<String> title() {
		return title;
	}
	public final BoundPropertyRW<String> group() {
		return group;
	}
	public final BoundPropertyRW<String> description() {
		return description;
	}
}