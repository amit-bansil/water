package org.cps.framework.core.event.core;

import java.util.EventObject;

/**
 */
public final class ConstraintNotifier<EventType extends EventObject>
		extends BasicNotifier<Constraint<EventType>>{

    public ConstraintNotifier(){
        super();
    }
	public final void checkEvent(final EventType e)throws VetoException {
		final Object[] cache = checkOutListeners();//UNCLEAR cheetah bug
		try{
			for (int i = 0; i < cache.length; i++) {
				((Constraint/* cheetah bug <EventObjectType> */)cache[i]).checkEvent(e);
			}
		}finally{
		    checkInListeners();
		}
	}

}
