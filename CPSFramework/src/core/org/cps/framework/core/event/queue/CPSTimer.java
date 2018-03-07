/*
 * QueueTimer.java
 * CREATED:    Dec 30, 2003 10:12:10 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.queue;

/**
 * a simple timer.
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class CPSTimer {
	/**
	 * creates Timer marked now. 
	 */
	public CPSTimer() {
		setMark();
	}
	private long mark;
	public void setMark() {
		mark=getTime();
	}
	public long getMark() {
		return mark;
	}
	public long getTimeSinceMark() {
		return getTime()-mark;
	}
	public abstract long getTime();
}
