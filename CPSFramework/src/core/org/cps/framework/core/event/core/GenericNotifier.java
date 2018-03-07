package org.cps.framework.core.event.core;

import java.util.EventObject;

/**
 * Notifier for GenericListeners
 * 
 * @version 0.2
 * @author Amit Bansil
 */
public final class GenericNotifier<EventObjectType extends EventObject> 
	extends BasicNotifier<GenericListener<EventObjectType>>{

	//OPTIMIZE could be better to let listeners by null sometimes??
    public GenericNotifier() {
        //empty
	}
	/**
     * Notifies listeners that event e occured.
     * 
     * @param e
     */
	public final void fireEvent(final EventObjectType e) {
		final Object[] cache =
		    checkOutListeners();//UNCLEAR cheetah bug
		try{
			for (int i = 0; i < cache.length; i++) {
				((GenericListener/* cheetah bug <EventObjectType> */)cache[i]).eventOccurred(e);
			}
		}finally{
		    checkInListeners();
		}
	}
}