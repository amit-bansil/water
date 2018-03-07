/*
 * ConstrainedPropertyRW.java
 * CREATED: Aug 9, 2003 11:06:10 AM 
 * AUTHOR: Amit Bansil
 * PROJECT: vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.core.event.property;

/**
 * A constrained property that can be set. Set should usually first check the
 * veto listeners then change the property,then tell the regular listeners This
 * should be used when the accepable values for set are difficult to describe
 * at design time.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public interface ConstrainablePropertyRW<T> extends ConstrainablePropertyRO<T>,
		ConstrainedPropertyRW<T> {
    //just a marker...
}
