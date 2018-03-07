/**
 * VMDL2.
 * Created on Jan 25, 2003 by Amit Bansil.
 *
 * Copyright 2002 The Center for Polymer Studies,
 * All rights reserved.
 * 
 */
package org.cps.framework.util.collections.basic;

import java.util.Stack;

public class SafeStack<T> {
	private final Stack<T> stack=new Stack<T>();
	public SafeStack(){
		this(true);
	}
	private final boolean ensureEmpty;
	public SafeStack(boolean ensureEmpty) {
		super();
		this.ensureEmpty=ensureEmpty;
	}
	public final void push(T o){
		stack.push(o);
	}
	public final T peek(){
		return stack.peek();
	}
	public final void pop(T o){
		Object i=stack.pop();
		if(i!=o){
			throw new IllegalArgumentException("expected "+i+" but got "+o);
		}
	}
	public final boolean isEmpty(){return stack.isEmpty();}
	protected void finalize() throws Throwable {
		if(ensureEmpty){
			if(!stack.isEmpty()){
				throw new IllegalStateException("leftover objects in stack "+stack);
			}
		}
		super.finalize();
	}

}
