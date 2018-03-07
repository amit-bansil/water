package org.cps.umd.display;


import gnu.trove.TIntObjectHashMap;
import gnu.trove.TIntObjectProcedure;
/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */

public abstract class ObjectCache {

	private final TIntObjectHashMap cache=new TIntObjectHashMap();

	private static final class ObjectEntry{
		private final Object obj;
		private int count;
		public ObjectEntry(Object obj){
			this.obj=obj;
			count=1;
		}
		public final boolean checkCount(){
			if(count>0){count=0;return true;}
			else return false;
		}
		public final Object get(){count++;return obj;}
	}

	private int resetTime,curTime;
    public final void setResetTime(final int t){
		resetTime=t;
		if(curTime>=resetTime) reset();
	}
	public final int getResetTime(){return resetTime;}

	public ObjectCache(int resetTime) {
		curTime=0; this.resetTime=resetTime;
    }
	public void frameElapsed(){
		curTime++;
		if(curTime>=resetTime) reset();
	}
	private final void reset(){
		cache.retainEntries(new TIntObjectProcedure(){
			public final boolean execute(int a,Object b){
				return ((ObjectEntry)b).checkCount();
			}
		});
	}
	public void clear(){
		cache.clear();
	}
	public Object get(int key){
		final Object r=cache.get(key);
		if(r==null){
			final Object o=create(key);
			cache.put(key,new ObjectEntry(o));//recycle objectEntries?
			return o;
		}
		else return ((ObjectEntry)r).get();
	}
	protected abstract Object create(int key);
}