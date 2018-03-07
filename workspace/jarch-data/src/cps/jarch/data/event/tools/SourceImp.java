/*
 * SimplePublisher.java
 * CREATED:    Jun 19, 2005 11:09:33 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.event.tools;


import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.GenericPublisher;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.util.EventObject;
/**
 * Trivial source backed by a
 * {@link cps.jarch.data.event.tools.SerialPublisher}. <code>name</code> is
 * for debugging. @{link Link}s are sent eventOjects when <code>sendEvent<code> with the
 * <code>source</code> passed in the constructor.
 */
public class SourceImp implements Source{
	private final EventObject event;
	private final GenericPublisher<EventObject> publisher;
	private final String name;
	public SourceImp(Object source) {
		this(source,null);
	}
	public SourceImp(Object source,@Nullable String name) {
		this.name=name;
		event=new EventObject(source);
		publisher=new SerialPublisher<EventObject>();
	}
	public void sendEvent() {
		publisher.sendEvent(event);
	}

	public void connect(GenericLink<? super EventObject> l) {
		publisher.connect(l);
	}

	public void disconnect(GenericLink<? super EventObject> l) {
		publisher.disconnect(l);
	}
	@Override
	public String toString() {
		return getClass().getSimpleName()+name==null?"": ':' +name;
	}
	
	//cache of link used by listenTo
	private Link sendEventLink;
	/**
	 * Convenience method.
	 * @return a {@link GenericLink} that causes this SimpleSourceImp to {@link #sendEvent()}
	 * whenever it recieve's an event.
	 */
	public final @Constant Link getSendEventLink() {
		if(sendEventLink==null) {
			sendEventLink=new Link() {
				@Override public void signal(EventObject event) {
					sendEvent();
				}
			};
		}
		return sendEventLink;
	}
}
