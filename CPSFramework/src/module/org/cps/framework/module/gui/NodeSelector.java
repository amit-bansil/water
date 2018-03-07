/*
 * ModuleSelector.java
 * CREATED:    Jul 9, 2004 4:53:02 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.gui;

import org.apache.commons.lang.ArrayUtils;
import org.apache.commons.lang.StringUtils;
import org.cps.framework.core.event.collection.CollectionChangeAdapter;
import org.cps.framework.core.event.collection.CollectionListener;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.components.BasicDescriptionCellRenderer;
import org.cps.framework.core.gui.event.CPSToSwingAdapter;
import org.cps.framework.core.gui.event.CPSToSwingChangeAdapter;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.module.core.IdentifiableNode;
import org.cps.framework.module.core.Module;
import org.cps.framework.module.core.ModuleRegistry;
import org.cps.framework.module.core.Node;

import javax.swing.JScrollPane;
import javax.swing.JTree;
import javax.swing.ScrollPaneConstants;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.event.TreeSelectionListener;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;
import javax.swing.tree.DefaultTreeSelectionModel;
import javax.swing.tree.MutableTreeNode;
import javax.swing.tree.TreeNode;
import javax.swing.tree.TreePath;
import javax.swing.tree.TreeSelectionModel;

import java.awt.Component;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class NodeSelector<T extends Node> {
	private final ModuleRegistry moduleRegistry;

	private final Class<T> typeC;
	private final boolean checkNode(Node n) {
		return typeC.isInstance(n);
	}
	
	//ui stuff
	private final DefaultMutableTreeNode rootNode;

	private final DefaultTreeModel model;
	
	private final TreeSelectionModel selectionModel;
	/**
	 * creates ModuleSelector.
	 * 
	 * @param moduleRegistry
	 */
	public NodeSelector(final ModuleRegistry moduleRegistry, Class<T> typeC) {
		CPSQueue.getInstance().checkThread();

		this.moduleRegistry = moduleRegistry;
		this.typeC = typeC;

		rootNode = new DefaultMutableTreeNode("Instruments");//TODO externalize string
		model = new DefaultTreeModel(rootNode);

		//registry hookup
		EventUtils.hookupListener(moduleRegistry.dynamicModules(), dmL);
		//TODO selection hookup&update on tree change
		selectionModel=new DefaultTreeSelectionModel();
		selectionModel.setSelectionMode(TreeSelectionModel.SINGLE_TREE_SELECTION);
		selectionModel.addTreeSelectionListener(new TreeSelectionListener() {
			public void valueChanged(TreeSelectionEvent e) {
				TreePath path=selectionModel.getSelectionPath();
				Node target=null;
				if(path!=null) target=getNode((TreeNode)path.getLastPathComponent());
				if(target!=null&&!checkNode(target))target=null;
				EventUtils.setExt(selection,(T)target);
			}
		});
		selection.addListener(new CPSToSwingChangeAdapter<T>("update selection") {
			protected void swingRun(T oldValue, T newValue) {
				if(newValue!=null) {
					Enumeration e=rootNode.depthFirstEnumeration();
					while(e.hasMoreElements()) {
						TreeNode tn=(TreeNode)e.nextElement();
						Node n=getNode(tn);
						if(newValue==n) {
							selectNode(tn);
							return;
						}
					}
					throw new Error("could not find "+newValue+" in tree");
				}else selectionModel.setSelectionPath(null);
			}
		});
	}
	private static final Node getNode(TreeNode src) {
		if(src instanceof NodeTreeNode)return((NodeTreeNode)src).getNode();
		else if(src instanceof ModuleTreeNode)return((ModuleTreeNode)src).getModule();
		else return null;
	}
	private final void selectNode(TreeNode n) {
		selectionModel.setSelectionPath(new TreePath(model.getPathToRoot(n)));
	}
	//access
	private JScrollPane scrollView = null;
	private JTree tree=null;
	public Component getComponent() {
		GuiEventUtils.checkThread();
		if (tree == null) {
			tree = new JTree(model);//??? is this safe???
			tree.setCellRenderer(new BasicDescriptionCellRenderer());
			scrollView = new JScrollPane(tree,
					ScrollPaneConstants.HORIZONTAL_SCROLLBAR_AS_NEEDED,
					ScrollPaneConstants.VERTICAL_SCROLLBAR_AS_NEEDED);
			tree.setEditable(false);
			tree.setExpandsSelectedPaths(true);
			tree.setRootVisible(false);
			tree.setScrollsOnExpand(true);
			tree.setSelectionModel(selectionModel);
			
		}
		return scrollView;
	}

	private final BoundPropertyRW<T> selection = new DefaultBoundPropertyRW();

	public final BoundPropertyRW<T> selection() {
		CPSQueue.getInstance().checkThread();
		return selection;
	}

	//add/remove dynamic modules
	private final Map<Module, ModuleTreeNode> nodes = new HashMap();

	private final CollectionListener dmL = new CollectionChangeAdapter<Module>() {
		public void elementAdded(Module m) {
			ModuleTreeNode node = createDMNode(m);
			if (node != null) {
				nodes.put(m, node);
			}
		}

		public void elementRemoved(Module m) {
			ModuleTreeNode node = nodes.remove(m);
			if (node != null) {
				node.unlink();
			}
		}
	};

	public final void unlink() {
		CPSQueue.getInstance().checkThread();
		EventUtils.unhookListener(moduleRegistry.dynamicModules(), dmL);
	}

	//add/remove groups
	private final GenericListener groupChangeL = new CPSToSwingAdapter<List<GroupChange>>(
			"group updater", true) {
		protected void swingRun(List<GroupChange> context) {
			synchronized (groupChangeL) {
				for (GroupChange c : context) {
					String newName = c.getNewGroupName();
					String oldName= c.getOldGroupName();
					ModuleTreeNode node = c.getNode();
					DefaultMutableTreeNode parent=null;
					TreePath selection=selectionModel.getSelectionPath();
					boolean updateSelection=false;
					if(oldName!=null) {
						parent=getGroup(oldName);
						if(parent==null)
							throw new Error("can't remove from group "+
									oldName+" that was never added");
						
						
						if(selection!=null&&ArrayUtils.contains
								(selection.getPath(),node)) {
							if(newName==null) {
								selection=null;
							}else {
								updateSelection=true;
							}
						}
						
						int n=parent.getIndex(node);
						parent.remove(n);
						if(parent.getChildCount()==0&&parent!=rootNode) {						
							n=rootNode.getIndex(parent);
							rootNode.remove(n);
							model.nodesWereRemoved(rootNode,new int[] {n},
									new TreeNode[] {parent});
						}else {
							model.nodesWereRemoved(parent,new int[] {n},
									new TreeNode[] {node});
						}
					}
					if (newName!=null) {
						parent=getGroup(newName);
						if(parent==null) {
							parent=new DefaultMutableTreeNode(newName);
							parent.add(node);
							rootNode.add(parent);
							model.nodesWereInserted(rootNode,
									new int[] {rootNode.getIndex(parent)});
						}else {
							parent.add(node);
							model.nodesWereInserted(parent,
									new int[] {parent.getIndex(node)});
						}
						if(updateSelection) {
							assert selection!=null;
							selectNode(
									(TreeNode)selection.getLastPathComponent());
						}else selectionModel.setSelectionPath(selection);
					} 
				}
			}
		}
		private final DefaultMutableTreeNode getGroup(String groupName) {
			if (StringUtils.isBlank(groupName)) return rootNode;
			
			Enumeration e = rootNode.children();
			while (e.hasMoreElements()) {
				DefaultMutableTreeNode p = (DefaultMutableTreeNode) e
						.nextElement();
				if (p.getUserObject().equals(groupName)) {
					return p;
				}
			}
			return null;
		}
		protected List<GroupChange> getContext(Object evt,
				List<GroupChange> context) {
			if (context == null) context = new ArrayList();
			context.add((GroupChange) evt);
			return context;
		}
	};

	private static final class GroupChange {
		public String getOldGroupName() {
			return oldName;
		}
		public String getNewGroupName() {
			return newName;
		}
		public ModuleTreeNode getNode() {
			return node;
		}
		public GroupChange(final String oldGroupName,
				String newGroupName,
				final ModuleTreeNode node) {
			this.oldName = oldGroupName;
			this.newName = newGroupName;
			this.node = node;
		}

		private final String oldName;

		private final String newName;

		private final ModuleTreeNode node;
	}

	//create/unlink dmnodes
	private final ModuleTreeNode createDMNode(Module m) {
		List<MutableTreeNode> children = createHeirarchy(m);
		if (children == null && !checkNode(m)) return null;
		ModuleTreeNode ret = new ModuleTreeNode(m);
		for (MutableTreeNode n : children)
			ret.add(n);
		return ret;
	}

	private final List<MutableTreeNode> createHeirarchy(Node parentModule) {
		List<MutableTreeNode> ret = null;
		for (Node childModule : parentModule.getChildren().values()) {
			//recursively find children
			List<MutableTreeNode> childChildren = createHeirarchy(childModule);
			MutableTreeNode currentNode = null;
			//create&link cm if we need to & can
			if ((childModule instanceof IdentifiableNode)
					&& (checkNode(childModule) || childChildren != null)) {
				if (ret == null) ret = new ArrayList();
				currentNode = new NodeTreeNode(
						((IdentifiableNode) childModule));
				ret.add(currentNode);
			}
			//add children to
			if (childChildren != null) {
				if (currentNode == null) {
					if (ret == null) ret = new ArrayList();
					ret.addAll(childChildren);
				} else {
					for (MutableTreeNode n : childChildren)
						ret.add(n);
				}
			}
		}
		return ret;
	}
	private static final class NodeTreeNode extends DefaultMutableTreeNode{
		public NodeTreeNode(IdentifiableNode n) {
			super(n.getDescription());
			this.n=n;
		}
		private final IdentifiableNode n;
		public IdentifiableNode getNode() {
			return n;
		}
	}
	private final class ModuleTreeNode extends DefaultMutableTreeNode {
		private final Module m;
		public final Module getModule() {
			return m;
		}
		private final BasicDescription parentDesc;

		private final String name;

		private final ValueChangeListener<String> groupL = new ValueChangeListener<String>() {
			public void eventOccurred(ValueChangeEvent<String> e) {
				groupChangeL.eventOccurred(new GroupChange(e.getOldValue(),
						e.getNewValue(),ModuleTreeNode.this));
			}
		};

		private final GenericListener descL = new CPSToSwingAdapter(
				"update description", true) {
			protected void swingRun(Object context) {
				updateDesc();
				model.nodeChanged(ModuleTreeNode.this);
			}
		};

		public ModuleTreeNode(Module m) {
			this.m = m;
			groupChangeL.eventOccurred(new GroupChange(null,
					m.group().get(),ModuleTreeNode.this));
			m.group().addListener(groupL);
			parentDesc = moduleRegistry.getModuleBuilder(m).getDescription();
			name = moduleRegistry.getNodePath(m)[0];
			updateDesc();//not yet hooked up so OK
			m.description().addListener(descL);
			m.title().addListener(descL);
		}

		public void unlink() {
			groupChangeL.eventOccurred(new GroupChange(m.group().get(),
					null,ModuleTreeNode.this));
			m.group().removeListener(groupL);
			m.description().removeListener(descL);
			m.title().removeListener(descL);
		}

		private final void updateDesc() {
			setUserObject(parentDesc.overrideName(name, m.title().get(), m
					.description().get()));
		}
	};
}