/*
 * CREATED ON:    May 1, 2006 10:11:31 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.time;

import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.RWFlag;

/**
 * <p>TODO document TimeModel
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class TimeModel {
	private final RWFlag primaryRunning=new RWFlag(false),secondaryRunning=new RWFlag(false);
	private final BoundedValue<Float> stepsPerSecond=new BoundedValue<Float>(16f,1f,300f);
	public static final int STEP_SCALE=10;
	public final RWFlag getRunning(boolean primary) {
		return primary?primaryRunning:secondaryRunning;
	}
	public final BoundedValue<Float> getStepsPerSecond() {
		return stepsPerSecond;
	}	
}