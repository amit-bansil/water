/*
 * SimpleLink.java
 * CREATED:    Jun 19, 2005 11:09:48 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event.tools;



import cps.jarch.data.event.GenericLink;
import cps.jarch.util.misc.NotImplementedException;

import java.util.EventObject;
//TODO create a MethodLink extends Link object class that can be built reflectivly
//typical use will be to create private final MethodLink fields for all methods
//that need to be exposed. have a createExpected factory func for this purpose.
//this way the target method can stay private
//a don'tobfuscate tag might help here aswell, remove @Reflect and replace with this
//code should like like
//...
//private final MethodLink myMethodLink=MethodLink.createExpected(this,"myMethod");
//@Export private final void myMethod(); //(note no args, exceptions, otherwise OK)
//...
//have a template for this
//placement of MethodLink field should help keep it from being broken
//on further examination it seems that myMethod needs to be public
/**
 * Shorthand for <code>GenericLink<EventObject></code>. can optionally have a name
 * which is used for debugging. Name should be the target of the
 * <code>Link</code>, i.e. what it updates, not what it is connected to.
 * Usually this is not needed since inner classes pickup a class name from there
 * parents.
 */
public abstract class Link implements GenericLink<EventObject> {
	public Link() {
		name=null;
	}
	private final String name;
	public Link(String name) {
		this.name=name;
	}
	public void signal(EventObject event) {
		signal();
	}
	//TODO doc, this is here as a shorthand
	protected void signal() {
		throw new NotImplementedException(Link.class, "signal");
	}
	@Override
	public String toString() {
		return getClass().getSimpleName()+name==null?"": (':' +name);
	}
}
