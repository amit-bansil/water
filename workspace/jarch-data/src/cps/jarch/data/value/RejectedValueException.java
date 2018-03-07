/*
 * ValueRejectedException.java
 * CREATED:    Jun 19, 2005 1:20:04 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-data
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data.value;

import cps.jarch.util.notes.Nullable;

public class RejectedValueException extends Exception {
	private final Object value;
	public RejectedValueException(Object value,String reason) {
		this(value,null,reason);
	}
	public RejectedValueException(Object value,@Nullable Throwable cause,String reason) {
		super("Rejected Value:"+value+" reason:"+reason,cause);
		this.value=value;
	}
	public RejectedValueException(Object value,@Nullable Throwable cause) {
		super("Rejected Value:"+value,cause);
		this.value=value;
	}
	public final Object getValue() {
		return value;
	}
}