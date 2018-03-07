/*
 * CREATED ON:    Apr 23, 2006 5:30:28 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.simulation;

import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.RWFlag;

import java.util.concurrent.locks.ReentrantLock;

/**
 * <p>TODO document InputParameters
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
class InputParameters {
	final ReentrantLock lock;
	InputParameters(ReentrantLock lock){
		this.lock=lock;
		kTemp=new RWFlag(true,lock);
		kPres=new RWFlag(true,lock);
		desiredTemperature=new BoundedValue<Float>(1f,1f,1000f,lock);
		desiredPressure=new BoundedValue<Float>(1f,-1000f,1000f,lock);
		desiredDensity=new BoundedValue<Float>(.5f,.001f,1.2f,lock);
	}
	final RWFlag kTemp,kPres;
	
	public static final float PRESSURE_STEP=50f;
	public static final float DENSITY_STEP=.05f;
	public static final float TEMPERATURE_STEP=20f;
	
	final BoundedValue<Float> desiredTemperature;
	final BoundedValue<Float> desiredPressure;
	final BoundedValue<Float> desiredDensity;

	private float oldTemp,oldPres,oldDens;
	
	final void apply(Engine raw) {
		if(!lock.isHeldByCurrentThread())throw new IllegalThreadStateException();
		
		raw.ktemp=kTemp.get();
		raw.kpres=kPres.get();
			
		if (raw.ktemp) {
			if (oldTemp != desiredTemperature.get()) {
				oldTemp = desiredTemperature.get();
				raw.setemperature(oldTemp);
			}
		}
		if (raw.kpres) {
			if (oldPres != desiredPressure.get()) {
				oldPres = desiredPressure.get();
				raw.setpressure(oldPres);
			}
		} else {// kdens
			if (oldDens != desiredDensity.get()) {
				oldDens = desiredDensity.get();
				raw.setdensity(oldDens);
			}
		}
	}

	void clear(Engine raw) {
		if(!lock.isHeldByCurrentThread())throw new IllegalThreadStateException();
		
		oldTemp=(float)raw.etemp;desiredTemperature.setUnchecked(oldTemp);
		oldPres=(float)raw.epres;desiredPressure.setUnchecked(oldPres);
		oldDens=(float)raw.erho;desiredDensity.setUnchecked(oldDens);
		kTemp.set(raw.ktemp);
		kPres.set(raw.kpres);
	}

	void read(InputParameters orig) {
		kTemp.set(orig.kTemp.get());
		kPres.set(orig.kPres.get());
		desiredTemperature.setUnchecked(orig.desiredTemperature.get());
		desiredPressure.setUnchecked(orig.desiredPressure.get());
		desiredDensity.setUnchecked(orig.desiredDensity.get());
	}


}
