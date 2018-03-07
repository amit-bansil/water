/*
 * CREATED ON:    Jul 23, 2005 10:09:39 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.gui.util;

import cps.jarch.util.misc.Worker;
import cps.jarch.util.notes.Singleton;
import cps.jarch.util.notes.ThreadSafe;

import javax.swing.SwingUtilities;

import java.lang.reflect.InvocationTargetException;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * Worker proxy that executes jobs on the EDT. Note that a separate low priority
 * daemon thread is created for the worker to post tasks to the EDT. All methods
 * are thread-safe.
 * </p>
 * ID: $Id: EDTWorker.java 539 2005-09-02 11:57:23Z bansil $
 */
//TODO why doesn't this just directly extend Worker???
//it should, and get rid of all these silly static methods
@Singleton public final class EDTWorker {
//    @SuppressWarnings({"FieldAccessedSynchronizedAndUnsynchronized"})
    private static Worker worker;
    private static final Object lock = new Object();

    @ThreadSafe public static final Worker getInstance() {
        // lazy worker creation
        // first quick test for performance
        if (worker == null) {
            synchronized (lock) {
                // now synchronously do a real check.
                if (worker == null) {
                    worker = new Worker("EDTWorker") {
                        @Override
                        protected void _run(final Runnable r) {
                            try {
                                // execute r synchronously
                                SwingUtilities.invokeAndWait(new Runnable() {
                                    public void run() {
                                        superRun(r);
                                    }
                                });
                            } catch (InterruptedException e) {
                                // should not happen
                                throw new Error(e);
                            } catch (InvocationTargetException e) {
                                // should not happen
                                throw new Error(e);
                            }
                        }

                        // needed to work around inner class access restrictions
                        final void superRun(Runnable r) {
                            super._run(r);
                        }
                        
                        @Override public void checkWorkerRunning() {
							if (!SwingUtilities.isEventDispatchThread())
								throw new IllegalStateException("in"
										+ Thread.currentThread().getName()
										+ " not EDT or " + this);
						}
                    };
                    // initialize worker
                    worker.setDaemon(true);
                    worker.setPriority(Thread.MIN_PRIORITY + 1);
                    worker.start();
                }
            }
        }
        return worker;
    }

    // ------------------------------------------------------------------------
	// delegate methods

	/**
	 * @see cps.jarch.util.misc.Worker#runASAP(Runnable)
	 */
    @ThreadSafe public static final void runASAP(Runnable r) {
		getInstance().runASAP(r);
	}

    /**
	 * @see cps.jarch.util.misc.Worker#runLater(long, TimeUnit, Runnable)
	 */
    @ThreadSafe public static final void runLater(long delay, TimeUnit units, Runnable r) {
        getInstance().runLater(delay, units, r);
    }

    /**
     * @see cps.jarch.util.misc.Worker#runLazy(long, TimeUnit, Runnable)
     */
    @ThreadSafe public static final void runLazy(long delay, TimeUnit units, Runnable r) {
        getInstance().runLazy(delay, units, r);
    }

    /**
     * @see cps.jarch.util.misc.Worker#runConditional(long, TimeUnit, Runnable)
     */
    @ThreadSafe public static final void runConditional(long delay, TimeUnit units, Runnable r) {
        getInstance().runConditional(delay, units, r);
    }

    /**
     * utility method to ensure executing from EDT.
     *
     * @throws IllegalStateException if run from non EDT.
     */
    @ThreadSafe public static final void checkThread() {
    	getInstance().checkWorkerRunning();
    }
}
