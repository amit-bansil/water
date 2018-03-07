package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.collection.BoundMapRO;
import org.cps.framework.core.event.collection.MapChangeAdapter;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.simple.SimpleListener;
import org.cps.framework.core.gui.event.GuiEventUtils;

import java.util.Arrays;
import java.util.EventObject;

/**
 * Title: Universal Molecular Dynamics Description: Copyright: Copyright (c)
 * 2001 Company: Boston University
 * 
 * @author Amit Bansil
 * @version 0.0a
 */
//provides interface for numerical changes to simulation
public class SimulationInputParameterData {
	//input parameters are grouped twice
	//(once by group and then again by parameter)
	//changes are pushed out using callExt for all the inputs in a parameter at
	//once if any are changed
	//this is very hacky, should be diteched for
	//individual functions should be created and this whole class dumped
	/*SimpleListener inputParameterListener = new SimpleListener() {
		public void eventOccurred(EventObject e) {
			_call((Parameter) e.getSource());
		}
	};*/
	private final void _call(Parameter inputParameter) {
		/*CPSQueue.getInstance().checkThread();
		int parameterNumber = parameterNumbers[inputParameter.getID()];
		double[] parameterValue = new double[parameterCounts[parameterNumber]];
		int offset = inputParameterNumbers[parameterNumber];
		for (int i = 0; i < parameterValue.length; i++) {
			System.out.println("finding:"+inputParameterGroups[i] + "."
					+ fullInputParameterNames[i]);
			Parameter p=parameters.get().getMap().get(
					inputParameterGroups[i] + "."
					+ fullInputParameterNames[i]);
			parameterValue[i] = p.getValue();
		}
		System.out.println("call:" + parameterNumber + ","
				+ Arrays.toString(parameterValues));
		sim.callFunction(parameterNumber, parameterValues);*/
	}
	//these are public for native access only
	//name&group of each parameter,name of each input parameter
	public String[] parameterNames, parameterGroups, inputParameterNames;

	//number of input parameters for each parameter
	public int[] parameterCounts;

	//value for each inputParameter
	public double[] parameterValues;//add change flag,mods

//	private final ParameterMapHolder parameters;
/*
	public BoundMapRO<String, Parameter> getParameters() {
		return parameters.get();
	}

	//parameter number for each input parameter
	private int[] parameterNumbers = new int[0];

	//first inputparameter number for each parameter
	private int[] inputParameterNumbers = new int[0];

	private String[] inputParameterGroups = new String[0],
			fullInputParameterNames = new String[0];
*/
	private final UMDSimulation sim;

	public SimulationInputParameterData(UMDSimulation lsim) {
	//	parameters = new ParameterMapHolder();
		this.sim = lsim;
	/*	parameters.get().addListener(new MapChangeAdapter<String, Parameter>() {
			protected void mappingAdded(String name, Parameter p) {
				p.observable().addListener(inputParameterListener);
			}

			protected void mappingRemoved(String name, Parameter p) {
				p.observable().removeListener(inputParameterListener);
			}

		});
*/
		_bathCo = new DefaultBoundPropertyRW<Double>(new Double(100f));
		_bathTemp = new DefaultBoundPropertyRW<Double>(new Double(1f));
		bathCo = GuiEventUtils.toSwing(_bathCo);
		bathTemp = GuiEventUtils.toSwing(_bathTemp);
		_bathCo.addListener(new GenericListener() {
			public void eventOccurred(Object arg0) {
				update();
			}
		});
		_bathTemp.addListener(new GenericListener() {
			public void eventOccurred(Object arg0) {
				update();
			}
		});
	}
	private final void update() {
		sim.callFunction(2,new double[] {_bathCo.get().doubleValue()/100f});
		double rt=_bathTemp.get().doubleValue();
		if(rt==0)rt=.0001d;
		sim.callFunction(1,new double[] {rt});
	}
	public void setChangeFlag(SimulationFlags flag) {//fix
		/*if (flag.isInputParameterDataChanged()) {

			final int inputParameterCount = parameterValues.length;
			final int parameterCount = parameterNames.length;

			assert parameterCount == parameterGroups.length;
			assert parameterCount == parameterCounts.length;
			assert inputParameterCount == inputParameterNames.length;
			assert inputParameterCount >= parameterCount;

			//parameter groups for each input parameter
			inputParameterGroups = new String[inputParameterCount];
			//parameter name+input parameter name for each input paremeter
			fullInputParameterNames = new String[inputParameterCount];

			parameterNumbers = new int[inputParameterCount];
			inputParameterNumbers = new int[parameterCount];

			int currentInputParameter = 0;
			for (int currentParameter = 0; currentParameter < parameterCount; currentParameter++) {
				inputParameterNumbers[currentParameter] = currentInputParameter;
				for (int i = 0; i < parameterCounts[currentParameter]; i++) {
					inputParameterGroups[currentInputParameter] = parameterGroups[currentParameter];
					fullInputParameterNames[currentInputParameter] = parameterNames[currentParameter]
							+ "." + inputParameterNames[currentInputParameter];
					parameterNumbers[i] = currentParameter;
					currentInputParameter++;
				}
			}

			assert currentInputParameter == inputParameterCount;

			parameters.updateParameters(inputParameterGroups,
					fullInputParameterNames, parameterValues);

		} else if (flag.isParameterValuesChanged()) {
			//parameters.updateValues(parameterValues);
		}
		parameters.set("heat bath.coefficient.value", _bathCo, .01f);
		parameters.set("heat bath.temperature.value", _bathTemp, 1f);*/
		
	}

	//ERROR hacked these in on top, remove
	private final BoundPropertyRW<Double> bathTemp, bathCo, _bathTemp, _bathCo;

	//ERROR hacked these ontop
	public final BoundPropertyRW<Double> temperature() {
		return bathTemp;
	}

	public final BoundPropertyRW<Double> exchange() {
		return bathCo;
	}
}