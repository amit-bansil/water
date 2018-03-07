/*
 * ParameterMap.java
 * CREATED:    Aug 19, 2004 1:15:11 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.collection.BoundMapRO;
import org.cps.framework.core.event.collection.BoundMapRW;
import org.cps.framework.core.event.property.BoundPropertyRW;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
//utility to manage parameters
public class ParameterMapHolder {
	
	private final BoundMapRW<String, Parameter> map = BoundMapRW.create();

	public BoundMapRO<String, Parameter> get() {
		return map;
	}
	private Parameter[] currentParameters=new Parameter[0];
	public void updateValues(double[] values) {
		if(values.length!=currentParameters.length)
			throw new IllegalArgumentException("improper value count");
		for(int i=0;i<values.length;i++) {
			currentParameters[i].setValue(values[i]);
		}
	}
	//recreates parameteres except those with matching name,group&index
	//TODO check that removed parameters don't have any listeners
	public void updateParameters(String[] groups, String[] names,
			double[] initialValues) {
		final int l=names.length,ol=currentParameters.length;
		if((groups.length!=l)||(l!=initialValues.length))
			throw new IllegalArgumentException("improper parameter lengths");
		Parameter[] newParameters=new Parameter[l];
		int i=0;
		for(;i<l;i++) {
			final String group=groups[i],name=names[i];
			final double v=initialValues[i];
			Parameter p=null;
			if(i<ol) {
				p=currentParameters[i];
				if(!p.getFullName().equals(Parameter.getFullName(group,name))) {
					map.safeRemove(p.getFullName(),p);
				}else {
					p.setValue(v);
				}
			}
			if(p==null) {
				p=new Parameter(group,name,v,i);
				map.safePut(p.getFullName(),p);
			}
			newParameters[i]=p;
		}
		//kill leftovers
		for(;i<ol;i++) {
			Parameter p=currentParameters[i];
			map.safeRemove(p.getFullName(),p);
		}
		currentParameters=newParameters;
	}
	//ERROR this was hacked in...
	public void set(String name, BoundPropertyRW<Double> p,float c) {
		Parameter out=map.getMap().get(name);
		if(out!=null) {
			out.setValue(p.get().doubleValue()/c);
		}
	}
	public void get(String name, BoundPropertyRW<Double> p,float c) {
		Parameter out=map.getMap().get(name);
		if(out==null)p.set(null);
		else p.set(new Double(out.getValue()*c));
	}
}