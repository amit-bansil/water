/*
 * CREATED: Jul 22, 2004 AUTHOR: Amit Bansil Copyright 2004 The Center for
 * Polymer Studies, Boston University, all rights reserved.
 */
package org.cps.framework.core.event.collection;

import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

/**
 * TODO extend collection change event to give list information OPTIMIZE don't
 * lookup objects when no listeners (only really helps for sequentiallist?)
 */
public class BoundListRW<E> extends AbstractBoundCollectionRO<E>
		implements BoundCollectionRW<E>,BoundListRO{
    private final List<E> col,scol;
    
    public static final BoundListRW createArrayList(int size){
        return new BoundListRW(new ArrayList(size),null);
    }
    public static final BoundListRW createArrayList(){
        return new BoundListRW(new ArrayList(),null);
    }
    //set will throw exception if null or repeated elements
    public static final BoundListRW createSet(){
        return new BoundListRW(new ArrayList(),new HashSet());
    }
    public static final BoundListRW createSequentialList(){
        return new BoundListRW(new LinkedList(),null);
    }
    
    private final Set<E> set;
    public final boolean isSet() {
    	return set!=null;
    }
    
    protected BoundListRW(List<E> list,Set<E> set){
        this.col=list;
        scol=Collections.unmodifiableList(col);
        this.set=set;
    }
    public final Collection<E> get(){//TODO should be alist
        return scol;
    }
    public final List<E> getList(){
        return scol;
    }
    public void add(E e){
        add(col.size(),e);
    }
    public void add(int index,E e){
    	if(isSet()) {
    		_setAdd(e);
    	}
        col.add(index,e);
        fire_add(e);
    }
    public E remove(int index){
       E ret=col.get(index);
       remove(ret,index);
       return ret;
    }
    public final int safeGetIndex(E e){
        int n=col.indexOf(e);
        if(n==-1)throw new IllegalArgumentException("Object "+e+" not found in "+this);
        return n;
    }
    public void remove(E e){
        remove(e,safeGetIndex(e));
    }
    protected void remove(E e,int index){
        col.remove(index);
        fire_remove(e);
    }
    public E replace(int index,E newE){
        E ret=col.get(index);
        replace(index,ret,newE);
        return ret;
    }
    public void replace(E oldE,E newE){
        replace(safeGetIndex(oldE),oldE,newE);
    }
    protected void replace(int index,E oldE,E newE){
    	if(isSet()) {
    		if(!set.remove(oldE))throw new Error();
    		_setAdd(newE);
    	}
        col.set(index,newE);
        fire_replace(oldE,newE);
    }
    
    public void change(Collection<? extends E> remove,Collection<? extends E> add){
    	Object[] old=null;
        if(isSet()) old=col.toArray(new Object[col.size()]);
        
    	if(remove!=null){
            if(!col.containsAll(remove))
            throw new IllegalArgumentException(
            		"all elements of "+remove+" are not contained in "+this);
            col.removeAll(remove);
            set.removeAll(remove);
        }
        if(add!=null) {
        	if(isSet()) {
        		for(E e:add) {
        			try {
        				_setAdd(e);
        			}catch(RuntimeException ex) {
        				col.clear();
        				set.clear();
        				for(int i=0;i<old.length;i++) {
        					col.add((E)old[i]);
        					set.add((E)old[i]);
        				}
        				throw ex;
        			}
        			col.add(e);
        		}
        	}else {
        		col.addAll(add);
        	}
        }
        fire_change(add,remove);
    } 
    private final void _setAdd(E e) {
    	assert isSet();
    	if(!set.add(e))throw new IllegalArgumentException(
    			"set cannot contain repeated element "+e);
    }
    public void clear(){
        Collection<E> old=new ArrayList<E>(col);
        col.clear();
        fire_clear(old);
    }
    

	//io
	public final void write(ObjectOutputStreamEx out) throws IOException {
		if(!isSaveable())throw new Error(this+" not saveable");
		out.writeObject(get());
	}
	public final void read(ObjectInputStreamEx in) throws IOException {
		if(isSaveable()) {
			try {
				Collection<E> c=(Collection<E>)in.readObject();
				change(new ArrayList<E>(col),c);
			}catch (ClassNotFoundException e) {
				//should not happen
				throw new Error(e);
			}
		}
	}
	public final void initialize() {
		//do nothing???
	}
	private BoundCollectionRO<GenericObservable<?>> tcol=null;
	public final BoundCollectionRO<GenericObservable<?>> getStateObjects() {
		if(tcol==null) {
			tcol=EventUtils.singletonCollection((GenericObservable<?>)this);
		}
		return tcol;
	}
	//override to prevent save
	public boolean isSaveable() {
		return true;
	}
}
