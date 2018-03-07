/*
 * CREATED:    Aug 1, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.collections.basic;

import java.util.Iterator;
import java.util.NoSuchElementException;
import java.util.Stack;

/**
 */
public abstract class HeirarchyIterator<T> implements Iterator<T>{
    private T current;
    private final Stack<Iterator<T>> iterators=new Stack();
    public HeirarchyIterator(T top){
        current=top;
    }
    public HeirarchyIterator(Iterator<T> top){
        addIterator(top);
    }
    protected abstract Iterator<T> iterate(T t);
    
    public final boolean hasNext(){
        return current!=null;
    }

    public final T next(){
        if(!hasNext())throw new NoSuchElementException();
        T ret=current;
        addIterator(iterate(current));
        return ret;
    }
    private void addIterator(Iterator<T> t){
        if(t!=null&&t.hasNext()){
            iterators.push(t);
        }
        getNext();
    }
    private void getNext(){
        if(iterators.isEmpty()) current=null;
        Iterator<T> iter=iterators.peek();
        if(iter.hasNext()) current=iter.next();
        else{
            iterators.pop();
            getNext();
        }
    }
    public final void remove(){
        throw new UnsupportedOperationException();
    }
    
}
