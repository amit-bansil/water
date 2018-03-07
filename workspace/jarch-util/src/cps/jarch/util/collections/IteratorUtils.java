/*
 * CREATED ON:    Dec 21, 2005 1:12:32 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.collections;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Nullable;

import java.util.Iterator;
import java.util.NoSuchElementException;

/**
 * <p>Common utilities for creating & working with
 * {@link java.util.Iterator} & {@link java.lang.Iterable}.
 * </p>
 * @version $Id: IteratorUtils.java 42 2005-12-22 21:17:20Z bansil $
 * @see java.util.Arrays java's array utilities
 * @see java.util.Collections java's collection utilities
 * @author Amit Bansil
 */
public class IteratorUtils {
	// ------------------------------------------------------------------------
	// empty/single iterator & iterable
	
	public static final <T> Iterable<T> singleInterable(final @Nullable T t){
		return new Iterable<T>(){
			public Iterator<T> iterator() {
				return singleIterator(t);
			}
		};
	}
	/**
	 * Iterator with one element, <code>t</code>. Remove not supported.
	 */
	public static final <T> Iterator<T> singleIterator(final @Nullable T t){
		return new Iterator<T>() {
			private boolean done=false;
			public boolean hasNext() {
				return done;
			}
			public T next() {
				if(done)throw new NoSuchElementException();
				else {
					done=true;
					return t;
				}
			}
			public void remove() {
				throw new UnsupportedOperationException();
			}
		};
	}
	private static final Iterable emptyIterable=new Iterable() {
		public Iterator iterator() {
			return emtpyIterator();
		}
	};
	@SuppressWarnings("unchecked") public static final <T> Iterable<T> emptyIterable(){
		return emptyIterable;
	}
	private static final Iterator emptyIterator=new Iterator() {
		public boolean hasNext() {
			return false;
		}

		public Object next() {
			throw new NoSuchElementException();
		}

		public void remove() {
			throw new IllegalStateException();
		}
	};
	@SuppressWarnings("unchecked") public static final <T> Iterator<T> emtpyIterator(){
		return emptyIterator;
	}
	
	// ------------------------------------------------------------------------
	// combining iterator/iterable

	@SuppressWarnings("unchecked") public static final <T>Iterable<T> compose(
			final Iterable<? extends T> first, final Iterable<? extends T> second) {

		//degenerate cases
		if (!first.iterator().hasNext()) return (Iterable<T>) second;
		if (!second.iterator().hasNext()) return (Iterable<T>) first;

		return new Iterable<T>() {
			public Iterator<T> iterator() {
				return compose(first.iterator(), second.iterator());
			}
		};
	}
	
	/**
	 * @return new Iterator that first returns all the elements of
	 *         <code>first</code> then <code>second</code>. Remove is
	 *         unsupported.
	 */
	@SuppressWarnings("unchecked") public static final <T>Iterator<T> compose(
			Iterator<? extends T> first, Iterator<? extends T> second) {
		//degenerate cases
		if (!first.hasNext()) return (Iterator<T>) second;
		if (!second.hasNext()) return (Iterator<T>) first;

		return new CompositeIterator<T>(first, second);
	}
	private static class CompositeIterator<T> implements Iterator<T>{
		private final Iterator<? extends T> first,second;
		public CompositeIterator(Iterator<? extends T> first,
				Iterator<? extends T> second) {
			LangUtils.checkArgNotNull(first);
			LangUtils.checkArgNotNull(second);
			this.first=first;
			this.second=second;
		}
		public boolean hasNext() {
			return first.hasNext()||second.hasNext();
		}
		public @Nullable T next() {
			if(first.hasNext())return first.next();
			else return second.next();
		}
		public void remove() {
			throw new UnsupportedOperationException();
		}
	}
	// ------------------------------------------------------------------------
	//array->iterable/iterator
	public static final <T> Iterable<T> toIterable(final T[] array){
		return new Iterable<T>() {
			public Iterator<T> iterator() {
				return createIterator(array);
			}
		};
	}
	/*
	 * @return Iterator backed by an array. Often used to provide read only
	 *         access to an array. Changing the contents of the underlying array
	 *         is allowed but generally not advised.
	 * 
	 */
	public static final <T> Iterator<T> createIterator(T[] array){
		return new ArrayIterator<T>(array);
	}
	private static class ArrayIterator<T> implements Iterator<T>{
		private final T[] t;
		public ArrayIterator(T[] t) {
			LangUtils.checkArgNotNull(t);
			this.t=t;
		}
		private int i=0;
		public boolean hasNext() {
			assert i<t.length;
			return i!=t.length;
		}

		public @Nullable T next() {
			if(i==t.length) {
				NoSuchElementException e=new NoSuchElementException();
				e.initCause(new ArrayIndexOutOfBoundsException(i));
				throw e;
			}
			assert i<t.length;
			T ret=t[i];
			i++;
			return ret;
		}
		public void remove() {
			throw new UnsupportedOperationException();
		}
	}
}
