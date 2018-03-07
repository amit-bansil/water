/*
 * Combiner.java
 * CREATED:    Aug 10, 2003 5:11:01 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

/**
 * A combiner fills each occurence of {VALUE} with lookup(VALUE) except {{} which turns into {
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class Replacer {

	/**
	 * 
	 */
	public Replacer() {
		super();
		// TODO Auto-generated constructor stub
	}
	//OPTIMIZE use char[]s instead of StringBuffers..
	public final String proccess(String s){
		//OPTIMIZE just return s if no '{' or '}',pass in buffers etc.
		final char[] c=s.toCharArray();
		StringBuffer ret=new StringBuffer(c.length);
		StringBuffer look=new StringBuffer(12);
		boolean inLook=false;
		for(int i=0;i<c.length;i++){
			if(inLook){
				if(c[i]=='}'){
					if(look.charAt(0)=='{'&&look.length()==1){
						ret.append('{');
					}else {
						ret.append(lookup(look.toString()));
						inLook=false;
					}
					look.setLength(0);
				}else{
					look.append(c[i]);
				}
			}else{
				if(c[i]=='{'){
					inLook=true;
				}else{
					ret.append(c[i]);
				}
			}
		}
		if(inLook) throw new IllegalArgumentException("unclosed '{' in '"+s+"'");
		
		return ret.toString();
	}
	public abstract String lookup(String key);
}
