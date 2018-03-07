/*
 * ModuleIOManager.java
 * CREATED:    Jul 8, 2004 6:56:52 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.core;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.util.CompositeCollectionRW;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.io.DocumentData;
import org.cps.framework.core.io.DocumentManager;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class ModuleIOManager {

	private final ModuleRegistry moduleRegistry;

	private final ModuleBuilderRegistry builderRegistry;

	public ModuleIOManager(ModuleBuilderRegistry lbuilderRegistry,
			ModuleRegistry lmoduleRegistry, DocumentManager doc) {
		this.builderRegistry = lbuilderRegistry;
		this.moduleRegistry = lmoduleRegistry;
		stateObservables = new CompositeCollectionRW();
		EventUtils.hookupListener(moduleRegistry.dynamicModules(),
				new CollectionChangeAdapter<Module>() {
					public void elementAdded(Module m) {
						Iterator<Node> i=moduleRegistry.getAllChildren(m);
						while(i.hasNext()) {
							Node n=i.next();
							if (n instanceof SaveableNode) {
								stateObservables.removeCollection(
										(BoundCollectionRO<GenericObservable>)
										((SaveableNode) n).getStateObjects());
							}
						
						}
					}
					public void elementRemoved(Module m) {
						Iterator<Node> i=moduleRegistry.getAllChildren(m);
						while(i.hasNext()) {
							Node n=i.next();
							if (n instanceof SaveableNode) {
								stateObservables.addCollection(
										(BoundCollectionRO<GenericObservable>)
										((SaveableNode) n).getStateObjects());
							}
						}
					}
				});
		doc.registerDocumentData("modules", new DocumentData() {
			public void loadBlank() {
				moduleRegistry.clear();
			}

			public void write(ObjectOutputStreamEx out) throws IOException {
				saveModules(moduleRegistry.dynamicModules().get().toArray(
								new Module[moduleRegistry
										.dynamicModules().get().size()]), out);
			}

			List<SaveableNode> readNodes = null;

			public void read(ObjectInputStreamEx in) throws IOException {
				assert readNodes == null;
				readNodes = loadNodes(in);
			}

			public void initialize() {
				assert readNodes != null;
				initializeNodes(readNodes);
				readNodes = null;
			}

			public BoundCollectionRO<GenericObservable< ? >> getStateObjects() {
				return (BoundCollectionRO<GenericObservable< ? >>) stateObservables;
			}
		});
	}

	//	io
	private final CompositeCollectionRW<GenericObservable> stateObservables;

	public Set<Module> getExternalDependencies(Module m) {
		Set<Module> ret = new HashSet();

		Iterator<Node> mi = moduleRegistry.getAllChildren(m);
		while (mi.hasNext()) {
			Node n = mi.next();
			Collection<Dependency> d = moduleRegistry.getDependencies(n);
			if (!d.isEmpty())
					for (Dependency cd : d) {
						Module top = moduleRegistry.getParentModule(cd
								.getTarget());
						if (top != m) ret.add(top);
					}
		}

		return ret;
	}

	private static final String MODULES_IO_KEY = "modules";

	private static final int MODULES_IO_VERSION = 1;

	public List<SaveableNode> loadNodes(ObjectInputStreamEx in)
			throws IOException {
		in.beginSection(MODULES_IO_KEY, MODULES_IO_VERSION);
		int n = in.readInt();
		for (int i = 0; i < n; i++) {
			String[] bn = in.readUTFArray();
			//only recreate modules not created
			String name = in.readUTF();
			if (!moduleRegistry.hasNode(new String[] {name}))
				builderRegistry.getModuleBuilder(bn).recreateModule(in, name,
						moduleRegistry);
		}
		List<SaveableNode> nodes = new ArrayList();
		while (in.readBoolean()) {
			String[] mpath = in.readUTFArray();
			SaveableNode m = (SaveableNode)moduleRegistry.getNode(mpath);
			nodes.add(m);
			m.read(in);
		}
		return nodes;
	}

	public void initializeNodes(List<SaveableNode> nodes) {
		for (SaveableNode n : nodes)
			n.initialize();
	}

	public void saveModules(Module[] ma, ObjectOutputStreamEx out)
			throws IOException {
		out.beginSection(MODULES_IO_KEY, MODULES_IO_VERSION);
		out.writeInt(ma.length);
		for (Module m:ma) {
			ModuleBuilder b = moduleRegistry.getModuleBuilder(m);
			out.writeUTFArray(builderRegistry.getFullName(b));
			String[] n=moduleRegistry.getNodePath(m);
			assert n.length==1;
			out.writeUTF(n[0]);
			b.writeCreationData(m, out);
		}
		for(Module m:ma) {
			Iterator<Node> iter = moduleRegistry.getAllChildren(m);
			while (iter.hasNext()) {
				Node n = iter.next();
				if (n instanceof SaveableNode) {
					out.writeBoolean(true);
					out.writeUTFArray(moduleRegistry.getNodePath(n));
					((SaveableNode) n).write(out);
				}
			}
		}
		out.writeBoolean(false);

		out.endSection(MODULES_IO_KEY);
	}
}