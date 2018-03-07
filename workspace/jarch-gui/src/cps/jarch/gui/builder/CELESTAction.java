/*
 * CELESTAction.java
 * CREATED:    Mar 12, 2005 2:59:59 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.builder;

import cps.jarch.data.DataUtils;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.tools.RWValueImp;

/**
 * represents something the user can do. <br>
 * TODO allow undo/logging/help/icon
 * 
 * @author Amit Bansil
 */
public abstract class CELESTAction {
	/**
	 * calls to perform will be ignored if not enabled.
	 */
	private final ROValue<Boolean> enabled;

	public ROValue<Boolean> enabled() {
		return enabled;
	}

	private final String name;
	/**
	 * name used to identify action programatically.
	 */
	public final String getName() {
		return name;
	}

	// ------------------------------------------------------------------------
	// Constructors
	// ------------------------------------------------------------------------
	/**
	 * create CELESTAction that is always enabled
	 */
	public CELESTAction(String name) {
		this(name, DataUtils.constantValue(true));
	}

	/**
	 * creates CELESTAction loading title and (optional) description from res.
	 * description is loaded from name+".desc".note that only description may be
	 * null.
	 */
	public CELESTAction(String name,
			ROValue<Boolean> enabled) {
		if (name == null || enabled == null)
			throw new NullPointerException("name&title&description");

		this.name = name;
		this.enabled = enabled;
	}

	/**
	 * a basic implementation of a CELESTAction where the enabled property is a
	 * DefaultBoundPropertyRW.
	 */
	public static abstract class Simple extends CELESTAction {
		@Override
		public final RWValueImp<Boolean> enabled() {
			return (RWValueImp<Boolean>) super.enabled();
		}

		public Simple(String name, boolean enabled) {
			super(name, new RWValueImp<Boolean>(enabled));
		}

	}
	
	// ------------------------------------------------------------------------
	// perform
	// ------------------------------------------------------------------------
	/**
	 * external method clients call to perform action.
	 */
	public final void perform() {
		if (enabled.get()) doAction();
	}

	/**
	 * internal hook that subclasses implement to perform action. Do not call
	 * directly. only called when enabled.
	 */
	protected abstract void doAction();

}
