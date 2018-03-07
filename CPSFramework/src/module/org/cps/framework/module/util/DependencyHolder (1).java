/*
 * DependencyHolder.java
 * CREATED:    Jul 6, 2004 10:26:46 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.BoundListRW;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.module.core.Dependency;
import org.cps.framework.module.core.ModuleRegistry;
import org.cps.framework.module.core.Node;
import org.cps.framework.module.core.SaveableNode;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.EventObject;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class DependencyHolder<T extends Node> extends AbstractModule implements
		SaveableNode {
	/**
	 * creates DependencyHolder.
	 * 
	 * @param name
	 */
	public DependencyHolder(String name, Class<T> targetType) {
		super(name);
		this.targetType = targetType;
		targets.addListener(new CollectionChangeAdapter<T>() {
			public void elementAdded(T t) {
				getDependenciesRW().add(new DynamicDependency(t));
			}

			public void elementRemoved(T e) {
				for (Dependency d : getDependenciesRW().get())
					if (d.getTarget() == e) {
						getDependenciesRW().remove(d);
						return;
					}
				throw new Error("target " + e + "not added");
			}
		});
	}

	private final Class<T> targetType;

	public final Class<T> getTargetType() {
		return targetType;
	}

	public final void unlinked() {
		for (Dependency d : new ArrayList<Dependency>(super.getDependenciesRW()
				.get()))
			d.remove();
	}

	private ModuleRegistry r;

	public final void linked(ModuleRegistry r) {
		this.r = r;
	}

	private final class DynamicDependency extends Dependency {

		public DynamicDependency(T target) {
			super(DependencyHolder.this, target, true, true);
		}

		public void remove() {
			targets.remove((T) getTarget());
		}
	}

	private final BoundListRW<T> targets = BoundListRW.createSet();

	protected final BoundListRW<T> targetsRW() {
		return targets;
	}

	// io
	private static final int IO_VERSION = 1;

	private static final String IO_KEY = "dependencies";

	public final void write(ObjectOutputStreamEx out) throws IOException {
		out.beginSection(IO_KEY, IO_VERSION);
		if (r == null) throw new IllegalStateException("not yet linked");
		out.write(targets.get().size());
		for (T t : targets.getList())
			out.writeUTFArray(r.getNodePath(t));
		out.endSection(IO_KEY);
	}

	private String[][] paths = null;

	public final void read(ObjectInputStreamEx in) throws IOException {
		in.beginSection(IO_KEY, IO_VERSION);
		assert paths == null;
		paths = new String[in.readInt()][];
		for (int i = 0; i < paths.length; i++)
			paths[i] = in.readUTFArray();
		in.endSection(IO_KEY);
	}

	public final void initialize() {
		if (r == null) throw new IllegalStateException("not yet linked");
		assert paths != null;
		for (int i = 0; i < paths.length; i++)
			targets.add((T) r.getNode(paths[i]));
		paths = null;
	}

	private final BoundCollectionRO<GenericObservable<T>> stateOb = EventUtils
			.singletonCollection((GenericObservable<T>) targets);

	public final BoundCollectionRO<GenericObservable<?>> getStateObjects() {
		throw new UnsupportedOperationException();
		//return stateOb;
	}

	// helper methods for gui

	// dependency checking
	// if creating adding this target creates a circular dependency this method
	// returns the circular path, starting at the changed Module and returning
	// to
	// the changer, otherwise null
	// this is used to prevent the user from creating circularities
	// it allows the programmer to
	public final List<Node> checkTarget(T target) {
		if (r == null) throw new IllegalStateException("not yet linked");
		return findCircularity(new Dependency(this, target, true, true));
	}

	private List<Node> findCircularity(Dependency d) {
		List<Node> ret = null;
		if (d.isSourceChangedByTarget())
			ret = findCircularity(d.getTarget(), d.getSource(), new HashSet());

		if (ret == null && d.isTargetChangedBySource())
			ret = findCircularity(d.getSource(), d.getTarget(), new HashSet());
		if (ret != null) Collections.reverse(ret);
		return ret;
	}

	// return circ backward
	private final List<Node> findCircularity(Node changer, Node changed,
			Set<Node> checked) {
		if (changer == changed) {
			ArrayList ret = new ArrayList();
			ret.add(changer);
			return ret;
		}
		if (!checked.add(changed)) return null;

		for (Node n : r.getNodesChangedBy(changed)) {
			List<Node> ret = findCircularity(changer, n, checked);
			if (ret != null) {
				ret.add(changed);
				return ret;
			}
		}
		return null;
	}

	// single dep
	public static final class Single<ST extends Node> extends
			DependencyHolder<ST> {
		/*
		 * creates SingleDependencyHolder. @param name @param targetType
		 */
		public Single(String name, Class<ST> targetType) {
			super(name, targetType);
			target = EventUtils.asProperty(targetsRW());
		}

		private final BoundPropertyRW<ST> target;

		public BoundPropertyRW<ST> target() {
			return target;
		}
	}

	// multiple
	public static final class Multiple<MT extends Node> extends
			DependencyHolder<MT> {
		public Multiple(String name, Class<MT> type) {
			super(name, type);
		}

		public BoundListRW<MT> targets() {
			return targetsRW();
		}
	}

}