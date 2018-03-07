/*
 * DataUtils.java
 * CREATED:    Jan 26, 2005 3:09:55 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-event
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.data;

import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.GenericSource;
import cps.jarch.data.event.Unlinker;
import cps.jarch.data.value.ROValue;

import java.util.EventObject;
import java.util.concurrent.locks.Lock;

/**
 * Common utility methods for working with objects in this package.
 * 
 * @author Amit Bansil
 * @version $Id: DataUtils.java 512 2005-08-25 02:45:09Z bansil $
 */
public class DataUtils {

	/**
	 * as above except here only an <code>EventObject</code> whose source is
	 * <code>s</code> is sent.
	 */
	public static final void linkAndSync(GenericSource<?> s, GenericLink<EventObject> l) {
		s.connect(l);
		l.signal(new EventObject(s));
	}

	/**
	 * create & return very common <code>Unlinker</code> that simply disconnects
	 * <code>l</code> from <code>s</code>.
	 */
	public static <T extends EventObject>Unlinker createUnlinker(final GenericSource<T> s,
			final GenericLink<? super T> l) {
		return new Unlinker() {
			public void unlink() {
				s.disconnect(l);
			}
		};
	}
	// ------------------------------------------------------------------------
	// common values
	// ------------------------------------------------------------------------
	/**
	 * creates a fast value that keeps a constant value. v may be null.
	 */
	public static <T>ROValue<T> constantValue(final T v) {
		return new ConstantValue<T>(v);
	}

	// these are needed to fix trouble with autoboxing&optimize
	public static ROValue<Boolean> constantValue(final boolean v) {
		return v ? TRUE : FALSE;
	}
	private static final ROValue<Boolean> TRUE=constantValue(Boolean.TRUE),
		FALSE=constantValue(Boolean.FALSE);
	/**
	 * test if a value is a constant that was created by constantProperty.
	 */
	public static final boolean isConstant(ROValue b) {
        return b instanceof ConstantValue;
    }
	
	private static final class ConstantValue<T> implements ROValue<T> {
		private final T v;

		// null constructor
		public ConstantValue() {
			v = null;
		}

		public ConstantValue(T v) {
			this.v = v;
		}

		public final T get() {
			return v;
		}

		public boolean isNullable() {
			return v == null;
		}

		public void connect(GenericLink<? super EventObject> l) {
			// do nothing
		}

		public void disconnect(GenericLink<? super EventObject> l) {
			// do nothing
		}

		
		public Lock getLock() {
			return null;//don't need a lock since ConstantValue can never be written.
		}
	}
}
