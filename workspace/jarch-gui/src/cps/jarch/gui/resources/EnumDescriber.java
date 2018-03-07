/*
 * EnumLocalizer.java
 * CREATED:    Jun 14, 2005 10:26:45 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.resources;

import cps.jarch.util.misc.LangUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * <p>
 * A lookup table of {@link cps.jarch.gui.resources.Described} elements
 * keyed by the elements of an enum. Clients should create a .properties file
 * for the enumeration listing titles and optional descriptions&icons for each
 * constant. Normally the <code>enum</code> would implement
 * {@link cps.jarch.gui.resources.DescribedProxy} and delegate
 * to a static <code>EnumDescriber</code> as follows:
 * </p>
 * <pre>

 	//see DescribedProxy#getDescription()
 	
	private static final ResourceAccessor res = ResourceAccessor
		.loadResources(ResultColumn.class);
	private static final EnumDescriber&lt;ResultColumn&gt; describer=
		new EnumDescriber&lt;ResultColumn&gt;(res);
	public Described getDescription() {
	    return describer.getDescription(this);
	}
	
 * </pre>
 * @author Amit Bansil
 * @version $Id: EnumDescriber.java 498 2005-08-23 22:47:55Z bansil $
 */
public class EnumDescriber<T extends Enum> {
	private final MessageBundle res;
	private final Map<T, Described> descriptionCache
		= new HashMap<T, Described>();

	/**
	 * create <code>EnumDescriber</code> in which <code>Described</code>
	 * objects will be loaded using <code>res</code> either on the first
	 * request or now if preload is set to <code>true</code>.
	 * 
	 * @throws Error
	 *             if <code>preload</code> and
	 */
	public EnumDescriber(MessageBundle res) {
		LangUtils.checkArgNotNull(res);
		this.res=res;
	}
	/**
	 * get Described object associated with e. OPTIMIZE lookup by ordinal.
	 */
	public final Described getDescription(T e) {
		Described ret = descriptionCache.get(e);
		if (ret == null) descriptionCache.put(e, ret = new DescribedImpl(res, e.name()));
		return ret;
	}
}