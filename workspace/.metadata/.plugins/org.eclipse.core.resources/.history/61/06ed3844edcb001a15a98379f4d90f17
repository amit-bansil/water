/*
 * ConditionCheck.java
 * CREATED:    Jun 19, 2005 11:28:40 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event.tools;

import java.util.ArrayList;
import java.util.List;

public class ConditionChecker {
	private final List<Condition> conditions;
    private Condition[] cache = null;
	public ConditionChecker() {
		conditions=new ArrayList<Condition>();
	}
	
	public final void addCondition(Condition c) {
		if(conditions.contains(c))throw new Error("duplication condition");
		conditions.add(c);
		cache=null;
		
	}
	public final void removeCondition(Condition c) {
		if(!conditions.remove(c))
			throw new Error("condition not added");
		cache=null;
	}
	//true iff all conditions true
	public final boolean checkConditions() {
		if(cache==null)cache=conditions.toArray(new Condition[conditions.size()]);
		//must iterate over cache to allow removal during iteration
		for(Condition c:cache) {
			if(!c.check())return false;
		}
		return true;
	}
}
