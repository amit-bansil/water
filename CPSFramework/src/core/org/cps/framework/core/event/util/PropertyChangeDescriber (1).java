/*
 * PropertyChangeDescriber.java
 * CREATED:    Aug 19, 2003 9:32:05 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.util;

import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.util.collections.basic.SafeMap;

/**
 * since properties often don't provide enough context in there change events
 * this class represents an active listener that can be set to listen to
 * properties providing a specified context.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class PropertyChangeDescriber<contextType, propertyType> {
	private final SafeMap<BoundPropertyRO<propertyType>, contextType> contexts = new SafeMap();

	ValueChangeListener<propertyType> pcl = new ValueChangeListener<propertyType>() {
		public void eventOccurred(ValueChangeEvent<propertyType> evt) {
			_propertyChanged(evt, contexts
					.get((BoundPropertyRO<propertyType>) evt.getSource()));
		}
	};

	public PropertyChangeDescriber() {
		//DO nothing
	}
	public void startListeningTo(final BoundPropertyRO<propertyType> property,
			final contextType context, boolean fireInitialization) {
		contexts.put(property, context);
		property.addListener(pcl);
		if (fireInitialization) {
			_propertyChanged(new ValueChangeEvent<propertyType>(property, null,
					property.get()), context);
		}
	}

	public void stopListeningTo(BoundPropertyRO<propertyType> property,
			boolean fireFinalization) {
		contextType context=contexts.remove(property);
		property.removeListener(pcl);
		if (fireFinalization) {
			_propertyChanged(new ValueChangeEvent<propertyType>(property,
					property.get(), null), context);
		}
	}

	protected abstract void _propertyChanged(
			ValueChangeEvent<propertyType> evt, contextType context);
}