/*
 * DependantModule.java
 * CREATED:    Jul 5, 2004 6:02:04 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.core.io.SaveableData;
import org.cps.framework.core.io.SaveableDataHolder;
import org.cps.framework.module.core.Dependency;
import org.cps.framework.module.core.Node;
import org.cps.framework.util.collections.basic.SafeMap;

import java.io.IOException;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * a more complete module that can also have children and a state composed of
 * properties.
 * 
 * note once added to registry it is not possible to add/remove children or
 * properties
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class AbstractSaveableModule extends AbstractModule implements
		SaveableData {
	/**
	 * creates ComplexModule.
	 * 
	 * @param type
	 * @param name
	 */
	public AbstractSaveableModule(String name) {
		super(name);
		tempChildren=new SafeMap();
		children = tempChildren.getMap();
	}

	private boolean doneRegistering = false;
	private SafeMap<String,Node> tempChildren;
	private Map<String,Node> children;

	//prevents children/saveabledata names from clashing with eachother when
	//overrident
	private String namespace;

	private final Set<String> usedNamespaces = new HashSet();

	protected final void startNamespace(String namespace) {
		if (this.namespace == null)
				throw new IllegalStateException(
						"can't start new namespace before closing current");
		this.namespace = namespace;
		if (!usedNamespaces.add(namespace))
				throw new IllegalArgumentException("namespace " + namespace
						+ " already used");
	}

	private final void checkInNamespace() {
		if (namespace == null)
				throw new IllegalStateException("must be in namespace");
	}

	protected final void closeNamespace() {
		checkInNamespace();
		namespace = null;
	}

	protected final void registerChild(Node m, boolean childChangedByParent,
			boolean parentChangedByChild,String name) {
		checkInNamespace();
		if (doneRegistering)
				throw new IllegalStateException(
						"already finished registering children");
		tempChildren.put(name,m);
		getDependenciesRW().add(
				new Dependency(this, m, childChangedByParent,
						parentChangedByChild));
	}

	private SaveableDataHolder dataHolder = null;

	protected final void registerData(String name, SaveableData data) {
		checkInNamespace();
		if (dataHolder == null) {
			dataHolder = new SaveableDataHolder();
		}
		dataHolder.registerData(namespace+"."+name, data);
	}

	public final Map<String,Node> getChildren() {
		if (!doneRegistering) {
			doneRegistering = true;
			dataHolder.finishedRegisteringData();
		}
		return children;
	}

	public final void write(ObjectOutputStreamEx out) throws IOException {
		if (dataHolder != null) {
			out.writeBoolean(true);
			dataHolder.write(out);
		} else {
			out.writeBoolean(false);
		}
	}

	public final void read(ObjectInputStreamEx in) throws IOException {
		if (dataHolder != null) {
			if (in.readBoolean()) {
				dataHolder.read(in);
			}
		}
	}

	public final void initialize() {
		if (dataHolder != null) dataHolder.initialize();
	}

	public final BoundCollectionRO<GenericObservable< ? >> getStateObjects() {
		return dataHolder.stateObservables();
	}
}