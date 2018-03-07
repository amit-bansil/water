/*
 * CompositeResourceAccessor.java
 * CREATED:    Aug 10, 2003 5:53:37 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resource.reader.ObjectReader;


/**
 * combines two resource accessors by replacing all instances of '{key}' in string values from a
 * with b.get(key)
 * if a does not contain a key, b will be checked
 * @version 0.1
 * @author Amit Bansil
 */
public class CompositeResourceAccessor extends ResourceAccessor {
	protected final ResourceAccessor a,b;
	public CompositeResourceAccessor(ResourceAccessor a,ResourceAccessor b){
		this(a,b,b.getResourceName()+"->"+a.getResourceName());
	}
	public CompositeResourceAccessor(ResourceAccessor a,ResourceAccessor b,String resName) {
		super(resName);
		if(a==null||b==null)throw new NullPointerException();
		this.a=a;
		this.b=b;
	}
	public final boolean hasKey(String key) {
		if(!a.hasKey(key)) return b.hasKey(key);
		else return true;
	}
	protected Object _get(String key,ObjectReader resReader) {
		Object ret=a.getObject(key,(ObjectReader<?>)resReader);
		if(ret!=null){
			if(ret instanceof String){
				return replacer.proccess((String)ret);
			}else return ret;
		}else return b.getObject(key);
	}
	private final Replacer replacer=new Replacer() {
		public String lookup(String key) {
			return b.getString(key);
		}
	};
}
