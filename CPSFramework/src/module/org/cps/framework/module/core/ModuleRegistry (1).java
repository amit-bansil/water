/*
 * CREATED: Aug 1, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.module.core;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.BoundListRW;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;
import org.cps.framework.core.event.collection.CollectionListener;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.module.util.LeftoverReferencesException;
import org.cps.framework.util.collections.arrays.ObjectArray;
import org.cps.framework.util.collections.basic.HeirarchyIterator;
import org.cps.framework.util.collections.basic.MapEntry;
import org.cps.framework.util.collections.basic.SafeMap;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;
import java.util.Stack;
import java.util.Map;

/**
 */
public final class ModuleRegistry {

	public ModuleRegistry() {
		//do nothing
	}

	//add module
	public final void addModule(Module m,String name, ModuleBuilder b) {//just
																			   // add
		// top
		//monitorsByModule.put(m,new SimpleConstrainableNotifier(m));
		if (!b.getType().isInstance(m))
				throw new IllegalArgumentException("builder " + b
						+ " is not parent of " + m);
		buildersByModule.put(m, b);

		Stack<String> currentPath = new Stack();
		_addNode(m,name, currentPath);
		Iterator<Node> ni = getAllChildren(m);

		while (ni.hasNext()) {
			Node n = ni.next();
			n.linked(this);
		}
		modules.add(m);
	}

	private final void _addNode(Node n,String name, Stack<String> currentPath) {
		assert name != null && name.trim().length() != 0;
		currentPath.push(name);
		String[] path = currentPath.toArray(new String[currentPath.size()]);
		pathsByNode.put(n, path);
		nodesByPath.put(ObjectArray.create(path), n);
		depNetwork.addNode(n);

		for (Map.Entry<String,Node> e : n.getChildren().entrySet())
			_addNode(e.getValue(),e.getKey(), currentPath);

		currentPath.pop();
	}

	//removal
	public final void clear() {
		for (Module m : new ArrayList<Module>(modules.get()))
			_removeModule(m);
	}

	public final void removeModule(Module m)
			throws LeftoverReferencesException {
		//SimpleConstrainableNotifier monitor=monitorsByModule.get(m);
		//monitor.fireEvent();

		Collection<Dependency> refs = new ArrayList();
		Iterator<Node> ni = getAllChildren(m);
		while (ni.hasNext()) {
			Node n = ni.next();
			Collection<Dependency> d = getReverseDependencies(n);
			if (!d.isEmpty()) for (Dependency cd : d) {
				Module top = getParentModule(cd.getSource());
				if (top != m) refs.add(cd);
			}
		}
		if (!refs.isEmpty())
				throw new LeftoverReferencesException(m, refs, this);

		_removeModule(m);
	}

	private final void _removeModule(Module m) {
		modules.remove(m);
		
		buildersByModule.remove(m);
		//monitorsByModule.remove(m);

		Iterator<Node> nodes = getAllChildren(m);
		while (nodes.hasNext()) {
			Node n = nodes.next();
			String[] path = pathsByNode.remove(n);
			nodesByPath.remove(ObjectArray.create(path), n);
			//this.modules.remove(cm);
			n.unlinked();
			depNetwork.removeNode(n);
		}
	}

	//module access
	/*
	 * private final BoundCollectionRW <Module> modules = BoundListRW
	 * .createArrayList();
	 * 
	 * public BoundCollectionRO <Module> getModules() { return modules; }
	 */

	private final SafeMap<ObjectArray<String>, Node> nodesByPath = new SafeMap();

	private final SafeMap<Node, String[]> pathsByNode = new SafeMap();

	private final SafeMap<Module, ModuleBuilder> buildersByModule = new SafeMap();

	/*
	 * private final SafeMap <DynamicModule,SimpleConstrainableNotifier>
	 * monitorsByModule=new SafeMap(); private final Set <DynamicModule>
	 * topModules = new HashSet(), safeTopModules =
	 * Collections.unmodifiableSet(topModules);
	 */
	private final BoundListRW<Module> modules=BoundListRW.createSet();
	public final BoundCollectionRO<Module> dynamicModules(){
		return modules;
	}
	public final Node getNode(String[] path) {
		return nodesByPath.get(ObjectArray.create(path));
	}
	public final Module getModule(String name) {
		return (Module)getNode(new String[] {name});
	}
	public final String getName(Module m) {
		return getNodePath(m)[0];
	}
	public boolean hasNode(String[] path) {
		return nodesByPath.containsKey(ObjectArray.create(path));
	}
	
	public final String[] getNodePath(Node m) {
		return pathsByNode.get(m);
	}

	/*
	 * public final Set <DynamicModule> getTopModules() { return safeTopModules; }
	 */

	public final Module getParentModule(Node m) {
		Module ret;
		if (m instanceof Module) ret = (Module) m;
		else {
			String[] path = getNodePath(m);
			ret = (Module) getNode(new String[]{path[0]});
		}
		assert modules.get().contains(ret);
		return ret;
	}

	public final ModuleBuilder getModuleBuilder(Module m) {
		return buildersByModule.get(m);
	}
	//includes the dm too
	public final Iterator<Node> getAllChildren(Module m) {
		String[] s=getNodePath(m);
		assert s.length==1;
		final ModuleChildrenIterator i=new ModuleChildrenIterator(s[0],m);
		return new Iterator<Node>() {

			public boolean hasNext() {
				return i.hasNext();
			}

			public Node next() {
				return i.next().getValue();
			}
		    public final void remove(){
		        throw new UnsupportedOperationException();
		    }
		};
	}
	/*
	 * public final Iterator <Map.Entry <String,Module>> getAllChildren(String
	 * moduleName,Module m) { return new ModuleChildrenIterator(moduleName,m); }
	 * 
	 * public final Iterator <Map.Entry <String,Module>> getAllChildren(Iterator
	 * <Map.Entry <String,Module>> m) { return new ModuleChildrenIterator(m); }
	 */
	
	private static final class ModuleChildrenIterator extends
			HeirarchyIterator<Map.Entry<String,Node>> {
		public ModuleChildrenIterator(String moduleName,Node module) {
			super(new MapEntry(moduleName,module));
		}

		public ModuleChildrenIterator(Iterator<Map.Entry<String,Node>> top) {
			super(top);
		}

		protected Iterator<Map.Entry<String,Node>> iterate(
				Map.Entry<String,Node> m) {
			Node t=m.getValue();
			return ((Set<Map.Entry<String,Node>>)t.getChildren().entrySet())
					.iterator();
		}
	}

	//for constraints only, not called on clear
	//public final SimpleConstrainable getModuleRemovalConstraitable(Module m){
	//    return monitorsByModule.get(getTopParent(m));
	//}

	//module name lookup
	public final String getNodeTitle(Node m) {
		Module dm=getParentModule(m);
		return _getGroup(dm.group().get())+dm.title().get() + _getPathTitle(m);

	}
	private static final String _getGroup(String group) {
		return group.equals("")?"":group+" : ";
	}
	private final String _getPathTitle(Node m) {
		String ret = "";
		String[] path = getNodePath(m);
		if (path.length == 1) return ret;

		List<String> pathL = new ArrayList(path.length);
		pathL.add(path[0]);
		for (int i = 1; i < path.length; i++) {
			pathL.add(path[i]);
			Node mi = getNode(pathL.toArray(new String[pathL.size()]));
			if (mi instanceof IdentifiableNode) {
				ret += " - "
						+ ((IdentifiableNode) mi).getDescription().getTitle();
			}
		}
		return ret;
	}

	//remember to unlink property
	public final BoundPropertyRO<String> getNodeTitleProperty(IdentifiableNode m) {
		return new TitleProperty(getParentModule(m), _getPathTitle(m));
	}
	public final BoundPropertyRO<String> getModuleTitleProperty(Module m) {
		return new TitleProperty(getParentModule(m),"");
	}
	private static final class TitleProperty extends
			DefaultBoundPropertyRW<String> {
		private final String pathTitle;

		private final BoundPropertyRO<String> rootTitle,rootGroup;
		
		private final ValueChangeListener l = new ValueChangeListener() {
			public void eventOccurred(Object e) {
				set(_getGroup(rootGroup.get())+rootTitle.get() + pathTitle);
			}
		};

		public TitleProperty(Module dm,
				String pathTitle) {
			super("");
			
			this.rootGroup = dm.group();
			this.rootTitle = dm.title();
			this.pathTitle=pathTitle;
			
			rootTitle.addListener(l);
			rootGroup.addListener(l);
			l.eventOccurred(null);
		}

		public void unlink() {
			rootTitle.removeListener(l);
			rootGroup.removeListener(l);
		}
	}

	//dependencies
	private class DependencyNetwork {
		//lists for each Module the modules which are changed by it and reverse
		private final Map<Node, Collection<Node>> dependencies = new HashMap(),
				reverseDependencies = new HashMap();

		private final Map<Node, Collection<Dependency>> reverseDeps = new HashMap();

		private final CollectionListener<Dependency> dl = new CollectionChangeAdapter<Dependency>() {
			public void elementAdded(Dependency e) {
				addDep(e);
			}

			public void elementRemoved(Dependency e) {
				removeDep(e);
			}
		};

		public void addNode(final Node m) {
			dependencies.put(m, new ArrayList());
			reverseDependencies.put(m, new ArrayList());
			reverseDeps.put(m, new ArrayList());
			for (Dependency d : m.getDependencies().get())
				addDep(d);
			m.getDependencies().addListener(dl);
		}

		public void removeNode(final Node m) {
			for (Dependency d : m.getDependencies().get())
				removeDep(d);
			m.getDependencies().removeListener(dl);
			dependencies.remove(m);
			reverseDependencies.remove(m);
			reverseDeps.remove(m);

		}

		private void addDep(Dependency d) {
			if (d.isTargetChangedBySource())
					addDep(d.getSource(), d.getTarget());
			if (d.isSourceChangedByTarget())
					addDep(d.getTarget(), d.getSource());
			reverseDeps.get(d.getTarget()).add(d);
		}

		private void removeDep(Dependency d) {
			if (d.isTargetChangedBySource())
					removeDep(d.getSource(), d.getTarget());
			if (d.isSourceChangedByTarget())
					removeDep(d.getTarget(), d.getSource());
			reverseDeps.get(d.getTarget()).remove(d);
		}

		private final void addDep(Node changer, Node changed) {
			dependencies.get(changer).add(changed);
			reverseDependencies.get(changed).add(changer);
		}

		private final void removeDep(Node changer, Node changed) {
			dependencies.get(changer).remove(changed);
			reverseDependencies.get(changed).remove(changer);
		}
	}

	private final DependencyNetwork depNetwork = new DependencyNetwork();

	public Set<Node> getNodesChangedBy(Node m) {
		//avoid multiple occurances of the same module
		return new HashSet<Node>(depNetwork.dependencies.get(m));
	}

	public Set<Node> getNodesThatChange(Node m) {
		return new HashSet<Node>(depNetwork.reverseDependencies.get(m));
	}

	public Collection<Dependency> getReverseDependencies(Node m) {
		return Collections
				.unmodifiableCollection(depNetwork.reverseDeps.get(m));
	}

	public Collection<Dependency> getDependencies(Node m) {
		return m.getDependencies().get();
	}
}