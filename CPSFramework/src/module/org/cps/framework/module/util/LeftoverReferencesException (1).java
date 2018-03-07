/*
 * LeftoverReferencesVeto.java
 * CREATED:    Jul 5, 2004 12:33:04 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.module.util;

import org.cps.framework.core.gui.dialogs.ConfirmDialog;
import org.cps.framework.core.gui.dialogs.MessageDialog;
import org.cps.framework.module.core.Dependency;
import org.cps.framework.module.core.Module;
import org.cps.framework.module.core.ModuleRegistry;
import org.cps.framework.module.core.Node;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Component;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class LeftoverReferencesException extends Exception {
	private static final ResourceAccessor res = ResourceAccessor
			.load(LeftoverReferencesException.class);

	private final String getNames(Collection<Dependency> deps) {
		String ret = "";
		Set<Node> mods=new HashSet();
		
		for (Dependency dep:deps) {
			assert dep.getTarget()==m;
			mods.add(dep.getSource());
		}
		
		assert !mods.isEmpty();
		
		for (Node mod:mods)
			ret += r.getNodeTitle(mod) + "<br>";
		
		return ret;
	}

	/**
	 * creates LeftoverReferencesVeto.
	 * 
	 * @param event
	 * @param message
	 * @param localizedMessage
	 * @param cause
	 */
	private final Collection<Dependency> refs;

	private final Module m;

	private final ModuleRegistry r;
	
	private final Map<String,String> data;
	
	public LeftoverReferencesException(Module m, Collection<Dependency> refs,
			ModuleRegistry r) {
		super("module "+m+" has leftover references");
		this.r=r;
		this.refs=refs;
		this.m=m;
		data=new HashMap();
		data.put("module_name",r.getNodeTitle(m));
		data.put("ref_names",getNames(refs));
	}

	//prompts user about leftovers then removes them if possible
	//returns whether or not fixed
	//(if fixed removeModule will have been called again)
	public boolean attemptFix(Component parent) {
		if(new ConfirmDialog(res.composite(data),"confirmFix",false,
				ConfirmDialog.WARNING_TYPE,true).show(parent)
				==ConfirmDialog.CHOICE_YES) {
			Collection<Dependency> failed=new ArrayList();
			for(Dependency d:refs) {
				try {
					d.remove();
				}catch(UnsupportedOperationException e) {
					failed.add(d);
				}
			}
			if(failed.isEmpty()) {
				try {
					r.removeModule(m);
				} catch (LeftoverReferencesException e) {
					//should not happen
					throw new Error(e);
				}
				return true;
			}else{
				data.put("failed_ref_names",getNames(failed));
				new MessageDialog(res.composite(data),"fixFailed",
						MessageDialog.ERROR_TYPE).show(parent);
				return false;
			}
		}else return false;
	}

}