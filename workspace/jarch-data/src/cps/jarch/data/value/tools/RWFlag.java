/*
 * CREATED ON:    Aug 23, 2005 5:39:42 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.data.value.tools;
import cps.jarch.data.event.GenericLink;
import cps.jarch.data.io.SaveableData;
import cps.jarch.data.io.SaveableDataProxy;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.RejectedValueException;
import cps.jarch.util.notes.Nullable;

import java.util.EventObject;
import java.util.concurrent.locks.Lock;

/**
 * TODO document RWFlag<br>
 * @version $Id$
 * @author Amit Bansil
 */
//all this is an trivial impl. of RWValue<Boolean> using RWValyeImp,
//but that's ok cuz we need to extend ROFlag
public class RWFlag extends ROFlag implements SaveableDataProxy,RWValue<Boolean>{
	private final RWValueImp<Boolean> rwvs;
	
	public RWFlag(boolean v) {
		this(v,null);
	}
	public RWFlag(boolean v,@Nullable Lock lock) {
		rwvs=new RWValueImp<Boolean>(v,false,lock);
	}
	
	//io code removed
	public SaveableData getData() {
		return rwvs.getData();
	}
	
	public void checkedSet(Boolean newValue) throws RejectedValueException {
		set(newValue);
	}
	public void set(Boolean newValue) {
		rwvs.set(newValue);
	}

	public Boolean get() {
		return rwvs.get();
	}

	public void connect(GenericLink<? super EventObject> l) {
		rwvs.connect(l);
	}

	public void disconnect(GenericLink<? super EventObject> l) {
		rwvs.disconnect(l);
	}
	public Lock getLock() {
		return rwvs.getLock();
	}

	
}