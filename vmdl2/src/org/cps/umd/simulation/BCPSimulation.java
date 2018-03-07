package org.cps.umd.simulation;

import org.cps.vmdl2.mdSimulation.SimulationDisplayData;
import org.cps.vmdl2.mdSimulation.SimulationInputParameterData;
import org.cps.vmdl2.mdSimulation.SimulationParameterData;
import org.cps.vmdl2.mdSimulation.SimulationTypeData;
import org.cps.vmdl2.mdSimulation.UMDSimulation;

//TODO change package and rebuild shared library
public final class BCPSimulation extends UMDSimulation {
	static{
		System.loadLibrary("bcp");
	}
	
	protected final native void close();
	protected final native void save(String name);
	protected final native int load(String name);
	protected final native int call(int fnum,double[] parameters);
	protected final native void abort();
	protected final native int calculateStep(float time);
	protected final native void link(SimulationDisplayData displayData,
			  SimulationParameterData parameterData,
			  SimulationInputParameterData inputParameterData,
			  SimulationTypeData typeData);
	protected final native void unlink();
	protected final native float getInstantTime();
}