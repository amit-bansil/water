/*
 * CREATED ON:    May 2, 2006 6:46:25 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import cps.jarch.gui.util.EDTWorker;
import cps.jarch.util.misc.Worker;
import cps.jarch.util.notes.Singleton;
import cps.jarch.util.notes.ThreadSafe;

/**
 * <p>TODO document GLWorker, put some checks with Threading
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public @Singleton final class GLWorker extends Worker{
    private static Worker worker;

    @ThreadSafe public static final Worker getInstance() {
    	/*Threading.
        // lazy worker creation
        // first quick test for performance
        if (worker == null) {
            synchronized (GLWorker.class) {
                // now synchronously do a real check.
                if (worker == null) 
                    worker = new GLWorker();
            }
        }
        return worker;*/
    	//TODO use a speratate thread of ogl work
    	return EDTWorker.getInstance();
    }
   /* private final ReentrantLock lock=new ReentrantLock();
    private Condition condition=lock.newCondition();
    private boolean locked=false;
    
    private GLWorker() {
    	super("GLWorker");
        // initialize worker
        setDaemon(true);
        setPriority(Thread.MIN_PRIORITY + 1);
        start();
    }
    
    
    @Override protected void _run(final Runnable r) {
    	//intentionally hold lock 'forever'
    	if(!locked) {
    		lock.lock();
    		locked=true;
    	}
		// execute r synchronously
		Threading.invokeOnOpenGLThread(new Runnable() {
			public void run() {
				superRun(r);
				lock.lock();
				try {
					condition.signal();
				} finally {
					lock.unlock();
				}
			}
		});
		condition.awaitUninterruptibly();
	}

    // needed to work around inner class access restrictions
    final void superRun(Runnable r) {
        super._run(r);
    }
    
    @Override public void checkWorkerRunning() {
		if (!Threading.isOpenGLThread())
			throw new IllegalStateException("in"
					+ Thread.currentThread().getName()
					+ " not GL Rendering thread or " + this);
	}*/
}
