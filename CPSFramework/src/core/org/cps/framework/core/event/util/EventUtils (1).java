/*
 * CREATED:    Jul 30, 2004
 * AUTHOR:     Amit Bansil
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.event.util;

import org.apache.commons.lang.ObjectUtils;
import org.cps.framework.core.event.collection.AbstractBoundCollectionRO;
import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.collection.BoundCollectionRW;
import org.cps.framework.core.event.collection.BoundListRO;
import org.cps.framework.core.event.collection.BoundMapRO;
import org.cps.framework.core.event.collection.CollectionListener;
import org.cps.framework.core.event.collection.DefaultCollectionChangeEvent;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.property.AbstractBoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 */
public class EventUtils{
    public static final <T> BoundCollectionRO<T> constantCollection(T[] elements){
        List<T> l=new ArrayList();
        Collections.addAll(l,elements);
    	return new ConstantBoundCollectionRO<T>(l);
    }
    public static final <T> BoundCollectionRO<T> singletonCollection(T element){
        return new ConstantBoundCollectionRO<T>(
        		Collections.singletonList(element));
    }
    public static final <T> BoundCollectionRO<T> emptyCollection(){
    	return new ConstantBoundCollectionRO<T>();
    }
    // event is not passed since some would be dropped
    public static final GenericListener<?> asLazyListener(
    		final GenericListener l){
    	return new GenericListener(){
    		boolean dirty=false;
    		private final Runnable r=new Runnable() {
				public void run() {
					if(dirty) {
						dirty=false;
						l.eventOccurred(null);
					}
				}
    		};
    		public void eventOccurred(Object e) {
// no need for syncs since this is all cps only
    			if(!dirty) {
    				dirty=true;
    				CPSQueue.getInstance().postRunnableCPSNow(r);
    			}
    		}
    	};
    }
    
    // a map that is null if the source lengths are diffrent otherwise
    // composed from both lists,key list must be a set
    // listens to keys&values till unlinked
    public static final <K,V> BoundPropertyRO<Map<K,V>> listMap(
    		final BoundListRO<K> keys,final BoundListRO<V> values){
    	return new ListMap<K,V>(keys,values);
    }
    private static final class ListMap<K,V> extends DefaultBoundPropertyRW{
    	GenericListener l=asLazyListener(new GenericListener() {
    		public void eventOccurred(Object e) {
    			List<K> keyCol=keys.getList();
    			List<V> valCol=values.getList();
    			final int l=keyCol.size();
    			
    			if(l!=valCol.size()) set(null);
    			else{
    				Map<K,V> map=new HashMap(l);
    				for(int i=0;i<l;i++)map.put(keyCol.get(i),valCol.get(i));
    				set(map);
    			}
    		}
    	});
    	private final BoundListRO<K> keys;
    	private final BoundListRO<V> values;
    	
		public ListMap(BoundListRO<K> keys,BoundListRO<V> values){
			super();
			this.keys=keys;
			this.values=values;
			if(!keys.isSet())throw new IllegalArgumentException("key!set");    	    	
	    	
	    	keys.addListener(l);
	    	values.addListener(l);

	    	l.eventOccurred(null);
		}
		public void unlink() {
			keys.removeListener(l);
			values.removeListener(l);
		}
		public final boolean isSaveable() {
			return false;
		}
    }
    
    private static class  ConstantBoundCollectionRO<T> extends AbstractBoundCollectionRO<T>{
        private final Collection<T> col;
        public ConstantBoundCollectionRO(T[] src) {
    		this(Arrays.asList(src));
    	}
    	public ConstantBoundCollectionRO(Collection<T> src) {
    		this.col=Collections.unmodifiableCollection(src);
    	}
    	// empty
    	public ConstantBoundCollectionRO() {
    		this.col=(Set<T>)Collections.emptySet();
    	}
    	public Collection<T> get() {
    		return col;
    	}
    }
    private static class ConstantBoundMapRO<K,V> extends ConstantBoundCollectionRO<Map.Entry<K,V>> implements BoundMapRO<K,V>{
    	private final Map<K,V> map;
        public ConstantBoundMapRO(Map<K,V> map) {
    		super(map.entrySet());
    		this.map=Collections.unmodifiableMap(map);
    	}
    	
    	public Map<K,V> getMap() {
    		return map;
    	}
    	
    	public V safeGet(K key) {
    		V ret=map.get(key);
    		if(ret==null)throw new IllegalArgumentException("key "+key+" not found in map "+this);
    		return ret;
    	}
    }
    public static final <T> BoundPropertyRW<T> asProperty(BoundCollectionRW<T> col){
    	return new CollectionProperty<T>(col);
    }
    private static class CollectionProperty<T> extends AbstractBoundPropertyRO<T>
		implements BoundPropertyRW<T> {
    	private final BoundCollectionRW<T> col;
    	private final GenericListener l=new GenericListener() {
			public void eventOccurred(Object o) {
				Iterator<T> i=col.get().iterator();
				if(!i.hasNext())set(null);
				else {
					set(i.next());
					if(i.hasNext())throw new Error("too many elements in"+col);
				}
			}
		};
    	public CollectionProperty(BoundCollectionRW<T> c) {
    		super(true);
    		this.col=c;
    		col.addListener(l);
    	}
    	
		public void set(T v) {
			if(ObjectUtils.equals(cur,v))return;
			T old=cur;
			cur=v;
			if(old!=null&&v!=null) {
				col.replace(old,v);
			}else if(old==null) {
				col.add(v);
			}else {
				assert v==null;
				col.remove(v);
			}
			fireChange(old,cur);
		}
		public void unlink() {
			col.removeListener(l);
		}
			
		private T cur=null;
		public T get() {
			return cur;
		}
    }
	/**
	 * adds a listener and sends current elements through it
	 */
	public static <T> void hookupListener(BoundCollectionRO<T> col,
			CollectionListener<T> l) {
		col.addListener(l);
		if(!col.get().isEmpty())
			l.eventOccurred(new DefaultCollectionChangeEvent<T>(col,col.get(),null));
	}
	public static <T> void unhookListener(BoundCollectionRO<T> col,
			CollectionListener<T> l) {
		col.removeListener(l);
		if(!col.get().isEmpty())
			l.eventOccurred(new DefaultCollectionChangeEvent<T>(col,null,col.get()));
	}
	public static <T> void hookupListener(BoundPropertyRO<T> p,
			ValueChangeListener<T> l) {
		p.addListener(l);
		if(p.get()!=null)
			l.eventOccurred(new ValueChangeEvent<T>(p,null,p.get()));
	}
	public static <T> void unhookListener(BoundPropertyRO<T> p,
			ValueChangeListener<T> l) {
		p.removeListener(l);
		if(p.get()!=null)
			l.eventOccurred(new ValueChangeEvent<T>(p,p.get(),null));
	}
	
	public static <T> void setExt(final BoundPropertyRW<T> prop,final T newValue) {
		CPSQueue.getInstance().postRunnableExt(new Runnable() {
			public void run() {
				prop.set(newValue);
			}
			public final String toString() {
				return "setting "+prop+" to "+newValue;
			}
		});
	}
	public static BoundPropertyRO<Boolean> not(BoundPropertyRO<Boolean> running) {
		return new DerivedPropertyRO<Boolean>(false,(BoundPropertyRO)running,_not(running)) {
			protected Boolean update(ValueChangeEvent e) {
				return _not(((BoundPropertyRO<Boolean>)e.getSource()));
			}
			
		};
	}
	private static final Boolean _not(BoundPropertyRO<Boolean> b) {
		return b.get().equals(Boolean.TRUE)?Boolean.FALSE:Boolean.TRUE;
	}
}
