/*
 * Timed.java
 * CREATED:    Aug 19, 2004 7:01:46 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.simple.SimpleObservable;


/**
 * TODO allow async execution by having advance time return immediatly
 * while notifying monitor
 * @version 0.0
 * @author Amit Bansil
 */
public interface Timed {
	public void advanceTime(final double stepSize)throws SimulationException;
	public double getTimeDuringAdvance();
	public void abortAdvance();
	public double getCurrentTime();
	public SimpleObservable observable();
}
