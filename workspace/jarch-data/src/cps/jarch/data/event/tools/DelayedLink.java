/*
 * CREATED ON:    Jul 27, 2005 11:29:36 AM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.data.event.tools;

import cps.jarch.data.event.GenericLink;
import cps.jarch.util.misc.Worker;

import java.util.EventObject;
import java.util.concurrent.TimeUnit;
//TODO split into DelayedLink and GenericDelayedLink for easier use
//perhaps add queing of events etc?
/**
 * Abstract super class for links that execute after a certain time delay. Contains
 * factory methods for creating common implementations.<br>
 * ID: $Id$
 */
public abstract class DelayedLink<T extends EventObject> implements GenericLink<T> {
	private long delay;

	public final long getDelay() {
		return delay;
	}

	private TimeUnit unit;

	public final TimeUnit getDelayTimeUnit() {
		return unit;
	}

	public final void setDelay(long delay, TimeUnit unit) {
		this.delay = delay;
		this.unit = unit;
	}

	public DelayedLink(long delay, TimeUnit unit) {
		setDelay(delay, unit);
	}

	// ------------------------------------------------------------------------

	/**
	 * @return a link that passes events to 'out' on 'worker' using a
	 *         conditional run with the given delay. Basically updates are
	 *         slowed to occur no more than once per 'delay' time 'units'. Be
	 *         careful about performing operations on the event since it may be
	 *         accessed simulateously by multiple threads.
	 * @see cps.jarch.util.misc.Worker#runConditional(long, TimeUnit,
	 *      Runnable)
	 */
	public static <E extends EventObject>DelayedLink<E> createConditionalLink(
			final Worker worker, long delay, TimeUnit units,final GenericLink<E> out) {
		return new DelayedLink<E>(delay, units) {
            private E latestEvent = null;

			public void signal(E event) {
				latestEvent = event;
				worker.runConditional(getDelay(), getDelayTimeUnit(),
					new Runnable() {
						public void run() {
							out.signal(latestEvent);
						}
					});
			}
		};
	}

	/**
	 * @return a link that passes events to 'out' on 'worker' using a lazy run
	 *         with the given delay. Basically updates are slowed to occur only
	 *         after none have happend for 'delay' time 'units'. Be careful
	 *         about performing operations on the event since it may be accessed
	 *         simulateously by multiple threads.
	 * @see cps.jarch.util.misc.Worker#runLazy(long, TimeUnit, Runnable)
	 */
	public static <E extends EventObject>DelayedLink<E> createLazyLink(
			final Worker worker, long delay, TimeUnit units,final GenericLink<E> link) {
		return new DelayedLink<E>(delay, units) {
            private E latestEvent = null;

			public void signal(E event) {
				latestEvent = event;
				worker.runLazy(getDelay(), getDelayTimeUnit(), new Runnable() {
					public void run() {
						link.signal(latestEvent);
					}
				});
			}
		};
	}
}
