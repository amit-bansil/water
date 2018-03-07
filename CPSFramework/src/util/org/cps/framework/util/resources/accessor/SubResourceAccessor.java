/*
 * SubResourceAccessor.java
 * CREATED:    Dec 18, 2003 2:12:03 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resource.reader.ObjectReader;

import java.util.MissingResourceException;

/**
 * a resource accessor that looks up resource first in the sub accessor then the super accessor.
 * @version 0.1
 * @author Amit Bansil
 */
public class SubResourceAccessor extends ResourceAccessor {
	private final ResourceAccessor superAccessor;
	private final ResourceAccessor subAccessor;
	public SubResourceAccessor(
		ResourceAccessor superAccessor,
		ResourceAccessor subAccessor) {
		this(
			superAccessor,
			subAccessor,
			superAccessor.getResourceName()
				+ "::"
				+ subAccessor.getResourceName());

	}
	public SubResourceAccessor(
		ResourceAccessor superAccessor,
		ResourceAccessor subAccessor,
		String resName) {
		super(resName);
		this.superAccessor = superAccessor;
		this.subAccessor = subAccessor;
	}
	protected Object _get(String key, ObjectReader resReader)
		throws MissingResourceException {
		try {
			return subAccessor.hasKey(key)
				? subAccessor._get(key, resReader)
				: superAccessor._get(key, resReader);
		} catch (MissingResourceException superMissing) {
			throw new UnknownError();
		}
	}

	public boolean hasKey(String key) {
		return subAccessor.hasKey(key) || superAccessor.hasKey(key);
	}

}
