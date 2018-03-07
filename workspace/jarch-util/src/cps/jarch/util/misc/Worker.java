/*
 * CREATED ON:    Jul 22, 2005 6:34:32 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.util.misc;

import cps.jarch.util.notes.Hook;
import cps.jarch.util.notes.NotThreadSafe;
import cps.jarch.util.notes.Nullable;
import cps.jarch.util.notes.ThreadSafe;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.DelayQueue;
import java.util.concurrent.Delayed;
import java.util.concurrent.TimeUnit;

/**
 * Wraps a thread that executes {@link Runnable}'s submitted to it. Usually an
 * instance will first be created, then the priority & daemon status are set.
 * Next <code>start</code> must be called to begin executing work. Jobs are
 * submitted using the runXXX methods and the worker executes them serially in
 * the order specified by the corresponding runXXX methods, logging any
 * exceptions and clearing the interrupt status after each job is executed as
 * needed. Finally one of the retire methods may be called, although this is not
 * strictly necessary if the worker is a daemon, and the worker releases the
 * underlying thread. After this point no methods may be called on the Worker
 * and it should be disposed of.
 * 
 * @version $Id: Worker.java 563 2005-09-08 12:53:50Z bansil $
 * 
 * @author Amit Bansil
 */
public class Worker{
	private static final LogEx<Worker> log = LogEx.createClassLog(Worker.class);

    // ------------------------------------------------------------------------
    // constructor

    /* For auto numbering anonymous workers. */
    private static int threadInitNumber;
    private static synchronized String nextWorkerName() {
    	return "Worker-"+threadInitNumber++;
    }
    
    public Worker() {
        this(nextWorkerName());
    }

    public Worker(String name) {
        this(name,null);
    }

    public Worker(String name,@Nullable ThreadGroup group) {
    	LangUtils.checkArgNotNull(name);
        thread=new Thread(group,name) {
        	@Override public void run() {
        		Worker.this.run();
        	}
        };
    }
    // ------------------------------------------------------------------------
    // thread
    
    private final Thread thread;
    /**
	 * @see java.lang.Thread#start()
	 * @throws IllegalStateException
	 *             if thread already already retired
	 */
	@NotThreadSafe public void start() {
		checkAlive();
		thread.start();
	}
	/**
	 * @see Thread#setPriority(int)
	 * @throws IllegalStateException
	 *             if thread already already retired
	 */
	@NotThreadSafe public void setPriority(int n) {
		checkAlive();
		thread.setPriority(n);
	}
	/**
	 * @see Thread#setDaemon(boolean)
	 * @throws IllegalStateException
	 *             if thread already already retired
	 */
	@NotThreadSafe public void setDaemon(boolean v) {
		checkAlive();
		thread.setDaemon(v);
	}
	@ThreadSafe public boolean isDaemon() {
		checkAlive();
		return thread.isDaemon();
	}
	/**
	 * @see java.lang.Thread#getName()
	 */
	@Override public String toString() {
		return thread.getName();
	}

    // ------------------------------------------------------------------------
    // submit
	/**
	 * Run <code>r</code> on this thread ASAP. <code>r</code> will execute
	 * next, unless other <code>Runnable</code>'s are waiting to be <code>runASAP</code>,
	 * in which case <code>r</code> will execute after them.
	 * 
	 * @throws IllegalStateException
	 *             if thread already already retired
	 */
    @ThreadSafe public final void runASAP(Runnable r) {
        checkAlive();
        log.debugEnter(this, "r", r);

        // use nanoseconds so that we won't overflow independent of what unit
        // we're converted to
        _runLater(r, (Long.MIN_VALUE / 2), TimeUnit.NANOSECONDS);
    }

    /**
	 * Run <code>r</code> on this worker after
	 * <code>delay</code> <code>units</code> have passed.
	 * 
	 * @throws IllegalStateException
	 *             if worker already already retired
	 * @throws IllegalArgumentException
	 *             if <code>delay<=0</code>
	 */
    @ThreadSafe public final void runLater(long delay, TimeUnit units, Runnable r) {
        checkAlive();
        log.debugEnter(this, "delay, units, r", delay, units, r);

        if (delay <= 0) throw new IllegalArgumentException("delay " + delay+" <= 0");
        _runLater(r, delay, units);
    }
    // execute r after possibly negative delay units
    @ThreadSafe private void _runLater(Runnable r, long delay, TimeUnit units) {
        log.debugEnter(this, "r, delay, units", r, delay, units);

        LangUtils.checkArgNotNull(r, "r");
        DefaultDelayed t = new DefaultDelayed(delay, units, r);
        queue.add(t);
    }

    // multi-map of Runnable objects that need to be executed and the corresponding
    // default delayed objects
    private final Map<Runnable, DefaultDelayed> pendingLazyRunables
    	= new HashMap<Runnable, DefaultDelayed>();

    /**
	 * Run <code>r</code> on this worker after
	 * <code>delay</code> <code>units</code> have passed, clearing any
	 * existing instance of <code>r</code> that was previously
	 * <code>runLazy</code> or <code>runConditional</code> and is waiting to
	 * run.
	 * 
	 * @throws IllegalStateException
	 *             if worker already already retired
	 * @throws IllegalArgumentException
	 *             if <code>delay<=0</code>
	 */
    @ThreadSafe public final void runLazy(long delay, TimeUnit units, Runnable r) {
        log.debugEnter(this, "delay, units, r", delay, units, r);

        synchronized (pendingLazyRunables) {
            // OPTIMIZE common case will be that r's default delayed is at the head of the
            // queue could just change the time on it now+delay assuming that
            // nothing else expires before it
            DefaultDelayed newDD = new DefaultDelayed(delay, units, r);
            DefaultDelayed oldDD = pendingLazyRunables.put(r, newDD);
            if (oldDD != null) {
                log.debug("removing pending default delayed: {0}", oldDD);
                queue.remove(oldDD);
            }
            log.debug("adding default delayed: {0}", newDD);
            queue.add(newDD);
        }
    }

    /**
	 * Run <code>r</code> on this worker after
	 * <code>delay</code> <code>units</code> have passed, assuming that no
	 * existing instance of <code>r</code> was <code>runConditional</code>
	 * or <code>runLazy</code> and is waiting to run. Otherwise no action is
	 * taken and the previous instance of <code>r</code> will be executed as
	 * scheduled.
	 * 
	 * @throws IllegalStateException
	 *             if worker already already retired
	 * @throws IllegalArgumentException
	 *             if <code>delay<=0</code>
	 */
    @ThreadSafe public final void runConditional(long delay, TimeUnit units, Runnable r) {
        log.debugEnter(this, "delay, units, r", delay, units, r);

        synchronized (pendingLazyRunables) {

            if (pendingLazyRunables.containsKey(r)) return;

            // OPTIMIZE common case will be that r's DefaultDelayed is at the head of the
            // queue could just change the time on it now+delay assuming that
            // nothing else expires before it
            DefaultDelayed newDD = new DefaultDelayed(delay, units, r);
            pendingLazyRunables.put(r, newDD);
            log.debug("adding default delayed: {0}", newDD);
            queue.add(newDD);
        }
    }

    // ------------------------------------------------------------------------
    // run

    private final DelayQueue<DefaultDelayed> queue = new DelayQueue<DefaultDelayed>();

    private boolean run = false;

    private final void run() {
		if (run) throw new IllegalStateException("already run once");

		if (!Thread.currentThread().equals(thread))
			throw new IllegalStateException("run called from unexpected thread "
					+ Thread.currentThread());

		log.debugEnter(this);
		run = true;
		checkAlive();
		while (alive || !queue.isEmpty()) {
			try {
				Runnable r;
				//clear interrupt status before taking & log
				if(Thread.interrupted()) {
					log.debug(this, "interrupt cleared");
				}
				r = queue.take().getRunnable();
				synchronized (pendingLazyRunables) {
					// remove r from pendingLazyRunnables
					// does nothing if r is not in that set
					pendingLazyRunables.remove(r);
				}
				_run(r);
			} catch (InterruptedException e) {
				log.error(this, "unexpected interrupt", e);
			}
			if (killNow) {
				log.debugReturnVoid(this,"killed");
				return;
			}
		}
		log.debugReturnVoid(this,"normal");
	}
	/**
	 * Override this if _run delegates to another thread, like the EDT.
	 * @throws IllegalStateException
	 *             if called from outside of a runnable being executed by this Worker.
	 */
	 @ThreadSafe public void checkWorkerRunning() {
        if (!Thread.currentThread().equals(thread))
			throw new IllegalStateException("running on unexpected thread "
				+ Thread.currentThread()+" not "+thread);
    }

    /**
	 * Hook called by <code>run</code> to execute a <code>Runnable</code>.
	 * Implementors should call super.run(r) to execute r so that execution is
	 * logged and uncaught exceptions are handled. Also, when delegating to
	 * another thread such as the EDT, do not return until <code>r</code> is
	 * actually finished or <code>runLazy</code> may post repeat events. Also,
	 * override <code>checkWorkerRunning</code> to test that run is being
	 * performed on the proper thread, i.e. the EDT.
	 */
    @Hook protected void _run(Runnable r) {
        log.debug(this, "executing {0}", r);

        try {
        	running=true;
            r.run();
        } catch (Exception e) {
        	
            log.error(this, "unexpected exception", e);
        }finally {
        	running=false;
        }
    }
    private boolean running=false;
    /**
     * @return if worker is executing a runnable
     */
    @ThreadSafe public final boolean isRunning() {
    	return running;
    }
    // ------------------------------------------------------------------------
    // Life cycle

    // flags to stop running, alive is false once retired
    private boolean alive = true,killNow = false;

    /**
     * @throws IllegalStateException if already already retired
     */
    private void checkAlive() {
        if (!alive) throw new IllegalStateException("already retired");
    }

    /**
	 * Retire worker immediately and terminate after all pending
	 * <code>Runnable</code>s are done.
	 * 
	 * @throws IllegalStateException
	 *             if already already retired
	 */
    @NotThreadSafe public final void retireWhenDone() {
        log.debugEnter(this);
        checkAlive();
        alive = false;
        // post an empty runnable so that queue wakes up
        _runLater(new Runnable() {
            public void run() {
                // do nothing
            }
        }, 0, TimeUnit.NANOSECONDS);

    }

    /**
     * Retire worker immediately and terminate after any runnable currently
     * executing is done.
     *
     * @throws IllegalStateException if already already retired
     */
    @NotThreadSafe public final void retireASAP() {
        log.debugEnter(this);
        checkAlive();
        killNow = true;
        retireWhenDone();
    }

    // ------------------------------------------------------------------------
    // OPTIMIZE always use nanoseconds internally, create directly when running
    // after...

    /**
     * DefaultDelayed implementation that holds a runnable to be run after a
     * specified time.<br>
     */
    private static final class DefaultDelayed implements Delayed {
        private final long runAfter;

        private final TimeUnit unit;

        private final Runnable runnable;

        DefaultDelayed(long delay, TimeUnit unit, Runnable runnable) {
            this.unit = unit;
            // must record time to run after so that delay will 'count down'
            this.runAfter = unit.convert(System.nanoTime(),
                    TimeUnit.NANOSECONDS)
                    + delay;
            this.runnable = runnable;
        }
        public int compareTo(Delayed d) {
            long j = d.getDelay(unit);
            long i = getDelay(unit);
            if (i < j) return -1;
            if (i > j) return 1;
            return 0;
        }

        @Override
        public boolean equals(Object obj) {
            if (obj instanceof DefaultDelayed) {
                DefaultDelayed d = (DefaultDelayed) obj;
                return unit.convert(d.runAfter, d.unit) == runAfter && d.runnable.equals(runnable);
            } else return false;
        }

        @Override
        public int hashCode() {
            return runnable.hashCode()*(int)TimeUnit.NANOSECONDS.convert(runAfter,unit);
        }

        public long getDelay(TimeUnit retunit) {
            return retunit.convert(runAfter, this.unit)
                    - retunit.convert(System.nanoTime(), TimeUnit.NANOSECONDS);
        }

        @Override
        public String toString() {
            return getClass().getSimpleName() + "[ time=" + runAfter + ' '
                    + unit + ", execute=" + runnable + ']';
        }

        public final Runnable getRunnable() {
            return runnable;
        }
    }

    // ------------------------------------------------------------------------
    // test

    private static final int TEST_LAZY_DELAY = 1000;
    private static final int TEST_LATER_DELAY = 500;
    private static final int TEST_LAZY2_DELAY = 250;
    //TODO move into unit tests
    public static void main(String[] args) {
        log.enableDebug();
        log.debugEnterStatic();
        Worker test = new Worker("test");
        test.start();

        Runnable lazy = new Runnable() {
            public void run() {
                log.info("lazy run");
            }

            @Override
            public String toString() {
                return "lazy";
            }
        };
        test.runLazy(TEST_LAZY_DELAY, TimeUnit.MILLISECONDS, lazy);
        test.runLater(TEST_LATER_DELAY, TimeUnit.MILLISECONDS, new Runnable() {
            public void run() {
                log.info("later run");
            }

            @Override
            public String toString() {
                return "later";
            }
        });
        test.runASAP(new Runnable() {
            public void run() {
                log.info("asap run");
            }

            @Override
            public String toString() {
                return "asap";
            }
        });
        test.runLazy(TEST_LAZY2_DELAY, TimeUnit.MILLISECONDS, lazy);

        test.retireWhenDone();
    }
}