/*
 * CREATED ON:    Aug 23, 2005 5:11:42 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.data.value.tools;

import cps.jarch.data.event.GenericLink;
import cps.jarch.data.value.ROValue;
import cps.jarch.util.misc.LangUtils;

import java.util.EventObject;
import java.util.concurrent.locks.Lock;

/**
 * TODO document Flag<br>
 * @version $Id$
 * @author Amit Bansil
 */
//this mostly serves as a shorthand for ROValue<Boolean> with some convenient manipulations
//for performing logical operations, the real work is in the static factory methods
//generally better for methods to take ROValue<Boolean>s and return ROFlags/RWFlags
//OPTIMIZE check isConstant when creating flags & cache results optionally, maybe this
//could be done with a "ValueCache" or such but then we'd have either multiple link lists
//or troubles with firing dependencies
public abstract class ROFlag implements ROValue<Boolean>{
	// ------------------------------------------------------------------------
	//implementation
	
	public final boolean isNullable() {
		return false;
	}
	
	// ------------------------------------------------------------------------
	//common permanently bound lightweight views
	
	/**
	 * create ROValue<Boolean> permanently bound to v true iff v.get()!=null.
	 * note that events will be from v, and thus usually NOT compatible w.
	 * ValueChange<Boolean>
	 */
	@SuppressWarnings("unchecked") public static ROFlag notNull(final ROValue v){
		return new ROFlag() {
			public Boolean get() {
				return v.get()!=null;
			}
			 public void connect(GenericLink<? super EventObject> l) {
				v.connect(l);
			}

			public void disconnect(GenericLink<? super EventObject> l) {
				v.disconnect(l);
			}
			public Lock getLock() {
				return v.getLock();
			}
		};
	}
	
	/**
	 * creates common composition of boolean values.
	 */
	public static final ROFlag not(final ROValue<Boolean> v) {
		return new ROFlag() {
			public Boolean get() {
				return !v.get();
			}
			public void connect(GenericLink<? super EventObject> l) {
				v.connect(l);
			}

			public void disconnect(GenericLink<? super EventObject> l) {
				v.disconnect(l);
			}
			public Lock getLock() {
				return getLock();
			}
		};
	}
	public static final <T> ROFlag equals(ROValue<? extends T> a,ROValue<? extends T> b) {
		return new PairFlag<Object>(a,b) {
			public Boolean get() {
				return LangUtils.equals(a.get(),b.get());//NOTE order
			}
		};
	}
	public static final ROFlag and(ROValue<Boolean> a,ROValue<Boolean> b) {
		return new PairFlag<Boolean>(a,b) {
			public Boolean get() {
				return a.get()&&b.get();//NOTE order
			}
		};
	}
	public static final ROFlag or(ROValue<Boolean> a,ROValue<Boolean> b) {
		return new PairFlag<Boolean>(a,b) {
			public Boolean get() {
				return a.get()||b.get();//NOTE order
			}
		};
	}
	/**
	 * note that a lock cannot be acquired an flag composed from a pair of flags with
	 * different locks.
	 */
	private static abstract class PairFlag<T> extends ROFlag{
		//let children call a.get() or b.get() only if needed
		protected final ROValue<? extends T> a,b;
		
		public PairFlag(ROValue<? extends T> a,ROValue<? extends T> b) {
			this.a=a;
			this.b=b;
		}
		@SuppressWarnings("unchecked") public final void connect(GenericLink l) {
			a.connect(l);
			b.connect(l);
		}

		@SuppressWarnings("unchecked") public final void disconnect(GenericLink l) {
			a.disconnect(l);
			b.disconnect(l);
		}
		public final Lock getLock() {
			final Lock aLock=a.getLock();
			if(aLock!=null) {
				if(!LangUtils.equals(aLock, b.getLock())) {
					throw new Error(
						"cannot obtain lock on flag composed from flags with different locks");
				}else return aLock;
			}else return b.getLock();
		}
	}
	// ------------------------------------------------------------------------
	// convenience methods

	public final ROFlag equals(ROValue<Boolean> v) {
		return equals(this,v);
	}
	public final ROFlag and(ROValue<Boolean> v) {
		return and(this,v);
	}
	public final ROFlag or(ROValue<Boolean> v) {
		return or(this,v);
	}
	public final ROFlag not() {
		return not(this);
	}
}
