package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.collection.BoundMapRO;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.gui.event.GuiEventUtils;

/**
 * Title: Universal Molecular Dynamics Description: Copyright: Copyright (c)
 * 2001 Company: Boston University
 * 
 * @author Amit Bansil
 * @version 0.0a
 */
//interface to output measurements from simulation from simulation
public class SimulationParameterData {

	//these are public for native access only
	public String[] parameterNames;

	public double[] parameterValues;

	public String[] parameterGroups;

	private final ParameterMapHolder parameters = new ParameterMapHolder();

	public BoundMapRO<String, Parameter> parameters() {
		return parameters.get();
	}

	private boolean ok = false;

	public void setChangeFlag(SimulationFlags flag) {
		if (flag.isParameterValuesChanged()) {
			if (flag.isParameterDataChanged()||!ok) {
				parameters.updateParameters(parameterGroups, parameterNames,
						parameterValues);
				ok=true;
			}
			parameters.updateValues(parameterValues);
		}
		parameters.get("time.mesTime", _realTime,
				1f / (float) UMDSimulation.STEP_SCALE);
		parameters.get("system.temperature", _temperature, 1f);
	}

	public SimulationParameterData() {
		_temperature = new DefaultBoundPropertyRW<Double>();
		_realTime = new DefaultBoundPropertyRW<Double>();
		realTime = GuiEventUtils.toSwing(_realTime);
		temperature = GuiEventUtils.toSwing(_temperature);
	}

	private final BoundPropertyRW<Double> temperature, realTime, _temperature,
			_realTime;

	//ERROR hacked these ontop
	public final BoundPropertyRO<Double> temperature() {
		return temperature;
	}

	public final BoundPropertyRO<Double> realTime() {
		return realTime;
	}
}