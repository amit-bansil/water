/*
 * Parameter.java
 * CREATED:    Aug 19, 2004 12:59:49 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.simple.SimpleNotifier;
import org.cps.framework.core.event.simple.SimpleObservable;

/**
 * TODO units,(time for output), toString(),(max/min,actual,desired for input)
 * @version 0.0
 * @author Amit Bansil
 */
//used by SimulationInputParameterData&ParameterData to provide interface to
//measurements and input values
public class Parameter {
	private double value;
	public double getValue() {
		return value;
	}
	public void setValue(double v) {
		if(value!=v) {
			this.value=v;
			changeNotifier.fireEvent();
		}
	}
	private final SimpleNotifier changeNotifier=new SimpleNotifier(this);
	public SimpleObservable observable() {
		return changeNotifier;
	}
	private final String name,group;
	private final int id;
	public final int getID() {
		return id;
	}
	public String getGroup() {
		return group;
	}
	public String getName() {
		return name;
	}
	public String getFullName() {
		return getFullName(group,name);
	}
	public static final String getFullName(String group,String name) {
		return group+"."+name;
	}
	public Parameter(String group,String name,double initialV,int id) {
		this.name=name;
		this.group=group;
		this.id=id;
		value=initialV;
	}
}
