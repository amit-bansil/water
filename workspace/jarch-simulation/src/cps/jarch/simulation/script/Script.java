/*
 * CREATED ON:    Aug 24, 2005 2:41:26 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.script;

import cps.jarch.data.event.tools.LinkAdapter;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.misc.Worker;
import cps.jarch.util.notes.Hook;

import java.util.EnumSet;


/**
 * <p>
 * Allows synchronous execution of a series of events. Clients can create a
 * script of actions by implementing <code>run()</code>. The script must
 * first be started from <code>extWorker</code> using <code>start()</code>,
 * which will cause the extWorker to hang until either run completes or the
 * script calls <code>waitFor(EnumSet s, Runnable run)</code>.
 * <code>waitFor(...)</code> frees <code>extWorker</code>, pushes
 * <code>run</code> to the <code>extWorker</code>, and hangs the script
 * until the <code>extWorker</code> calls <code>signal(Enum a)</code> with
 * an <code>Enum</code> <code>a</code> from <code>s</code>, at which
 * point the <code>extWorker</code> is hung again and the script resumes
 * execution with <code>waitFor(...)</code> returning the <code>a</code>.
 * This process of <code>waitFor(...)</code> followed by
 * <code>signal(...)</code> invocations continues until <code>run()</code>
 * completes.
 * </p>
 * 
 * <p>
 * because of the ease with which threading logic likes this gets out of hand,
 * this class takes a very aggressive approach to error checking.
 * </p>
 * 
 * @author Amit Bansil
 * @version $Id$
 */
public abstract class Script {
	private static final LogEx<Script> log = LogEx.createClassLog(Script.class);
	// ------------------------------------------------------------------------
	// members
	
	//worker to execute events on
	private final Worker extWorker;
	//thread to run this script on
	private final Thread scriptThread;
	
	//used to stop/start the extWorker&script respectively.
	private final AgressiveCondition extWorkerCond,scriptCond;
	
	//while waitFor is executing these determine what action will be returned and which
	//actions can be returned
	private EnumSet allowedReturnActions;
	private Enum returnAction; 
	
	// ------------------------------------------------------------------------
	// constructor
	
	/**
	 * creates Script.
	 * 
	 * @param extWorker
	 *            worker to execute events on
	 * @param name
	 *            name of this script for debugging
	 * @param prioirty
	 *            priority to run this script at, defaults to
	 *            Thread.NORMAL_PRIORITY
	 * @param daemon
	 *            whether or not the script is run as a daemon, defaults to true
	 *            so that the script will not keep the program alive if the
	 *            application terminates during its execution. This,however, could cause
	 *            resource loading issues.
	 */
	//TODO too many args
	public Script(Worker extWorker,String name,int prioirty, boolean daemon) {
		log.debugEnter(this, "extWorker, name, priority", extWorker, name, prioirty);
		
		this.extWorker=extWorker;
		scriptThread=new Thread(name) {
			@Override public final void run() {
				Script.this.run();
			}
		};
		scriptThread.setDaemon(daemon);
		scriptThread.setPriority(prioirty);
		
		extWorkerCond=new AgressiveCondition(extWorker);
		scriptCond=new AgressiveCondition(scriptThread);
	}

	//for debugging
	@Override public final String toString() {
		return scriptThread.getName();
	}
	
	// ------------------------------------------------------------------------
	
	private boolean started=false;
	/**
	 * requests that script should be run.
	 * returns immediately but posts an event that blocks <code>extWorker</code>
	 * until either the script completes or calls <code>waitFor()</code>. May be
	 * safely called from any thread.
	 * 
	 * @throws IllegalStateException
	 *             if already started
	 */
	public final void requestStart() {
		requestStart(null);
	}
	//signalOnEnd is used by startAndWaitForFinish
	private final void requestStart(AgressiveCondition signalOnEnd) {
		log.debugEnter(this);
		//preconditions, synchronized to prevent the very
		//unusual case of two thread calling requestStart at once
		
		synchronized(this) {
			if (started) throw new IllegalStateException("already started");
			started = true;
		}

		this.signalOnEnd=signalOnEnd;
		
		extWorker.runASAP(new Runnable() {
			public void run() {
				log.debug(Script.this,"beginning actual script startup");
				
				// start script & hang extWorker
				extWorkerCond.setWaiting();
				
				scriptThread.start();
				
				extWorkerCond.waitFor();
			}
		});
	}
	/**
	 * calls requestStart on a child script and blocks till the child script
	 * runs completely.
	 * @throws IllegalArgumentException if <code>!child.extWorker.equals(extWorker)</code>
	 */
	protected final void startAndWaitForFinish(Script child) {
		if(!child.extWorker.equals(extWorker))
			throw new IllegalArgumentException("child must have same extWorker as this");
		checkScriptThread();
		final AgressiveCondition childSignalOnEnd=new AgressiveCondition(scriptThread);
		
		//block this.scriptThread while allowing child to run by freeing extWorker
		child.requestStart(childSignalOnEnd);
		childSignalOnEnd.setWaiting();
		extWorkerCond.signal();
		childSignalOnEnd.waitFor();
		
		assert child.signalOnEnd==null;
		
		//once complete lock extWorker again
		//childSignalOnEnd is reused to do this synchronously
		childSignalOnEnd.setWaiting();
		extWorker.runASAP(new Runnable() {
			public void run() {
				extWorkerCond.setWaiting();
				childSignalOnEnd.signal();//point B,signals point A
				extWorkerCond.waitFor();//blocks extWorker
			}
		});
		childSignalOnEnd.waitFor();//Point A,waits for point B (reached above)
	}
	private AgressiveCondition signalOnEnd=null;
	private final void run() {
		_run();
		if(signalOnEnd!=null) {
			signalOnEnd.signal();
			signalOnEnd=null;
		}
	}
	/**
	 * clients should implement script here. called on scriptThread.
	 */
	@Hook protected abstract void _run();
	
	/**
	 * posts run to extWorker and then blocks scriptThread until extWorker calls
	 * signal with an element from actions.
	 * 
	 * @param actions
	 *            nonempty set of Enum elements.
	 * @return the Action from actions that the extWorker notified signal with
	 * 
	 * @throws IllegalStateException
	 *             if not called from scriptThread
	 * @throws IllegalArgumentException
	 *             if actions is empty
	 */
	@SuppressWarnings("unchecked") protected final <E extends Enum<E>>E waitFor(
			EnumSet<E> actions, Runnable run) {
		log.debugEnter(this, "actions, run", actions, run);

		// assertions
		assert allowedReturnActions == null;
		assert returnAction == null;
		
		// preconditions
		LangUtils.checkArgNotNull(run, "run");
		if (actions.isEmpty()) throw new IllegalArgumentException("actions is empty");
		
		scriptCond.setWaiting();
		
		allowedReturnActions = actions;
		extWorker.runASAP(run);
		
		extWorkerCond.signal();
		scriptCond.waitFor();
		
		//grab result
		assert returnAction != null;
		E ret;
		try {
			// unchecked conversion
			ret = (E) returnAction;
		} catch (ClassCastException e) {
			throw new Error(e);
		}

		assert allowedReturnActions.contains(ret);

		returnAction = null;
		allowedReturnActions = null;

		return log.debugReturnValue(this,ret);
	}
	/**
	 * call from extWorker while script is locked in waitFor(...) to notify it to
	 * begin executing and hang extWorker.
	 * 
	 * @throws IllegalStateException
	 *             if not called from extWorker
	 * @throws IllegalArgumentException
	 *             if actions is not one of the elements fed to waitFor
	 */
	protected final void action(Enum action) {
		log.debugEnter(this, "action", action);

		//assertions
		assert returnAction==null;
		assert allowedReturnActions!=null;
		
		//preconditions
		extWorker.checkWorkerRunning();
		LangUtils.checkArgNotNull(action);

		if(!allowedReturnActions.contains(action))
			throw new IllegalArgumentException("unexpected signal "+action);
		returnAction=action;		
		
		extWorkerCond.setWaiting();
		
		scriptCond.signal();
		extWorkerCond.waitFor();		
	}
	
	// ------------------------------------------------------------------------
	//utilities
	/**
	 * @return a {@link LinkAdapter} that signals this script with action.
	 */
	public final LinkAdapter createSignaler(final Enum action) {
		return new LinkAdapter() {
			public void run() {
				action(action);
			}
		};
	}
	/**
	 * @throws IllegalStateException currentThread!=script thread.
	 */
	public void checkScriptThread() {
		//TODO pull out this common code by searching for places wheere
		//Thread.currentThread()
		if(!Thread.currentThread().equals(scriptThread)) {
			throw new IllegalStateException(
				"execution from illegal thread "
				+ Thread.currentThread());
		}
	}

	/**
	 * utility to perform waiting and notification, performs very aggressive error checking.
	 */
	private static final class AgressiveCondition{
		public static final LogEx<AgressiveCondition> llog = LogEx
			.createClassLog(AgressiveCondition.class);
		
		private boolean waiting;
		private final Object lock=new Object();
		private final Threadish owner;
		public AgressiveCondition(final Worker worker) {
			this.owner=new Threadish() {
				@Override public String toString() {
					return worker.toString();
				}
				public void checkOnThisThread() {
					worker.checkWorkerRunning();
				}
			};
		}

		public AgressiveCondition(final Thread thread) {
			this.owner=new Threadish() {
				@Override public String toString() {
					return thread.getName();
				}
				public void checkOnThisThread() {
					if(!Thread.currentThread().equals(thread))
						throw new IllegalStateException(
							"execution from illegal thread "
							+ Thread.currentThread());
				}
			};
		}
		@Override public final String toString() {
			return owner.toString();
		}
		
		// call from owner to prepare to wait
		// call first so it can check that thread
		public final void setWaiting() {
			owner.checkOnThisThread();
			assert !waiting;
			waiting = true;
		}
		//call after setWaiting to block owner
		public final void waitFor() {
			llog.debugEnter(this);
			
			synchronized(lock) {
				while(waiting) {
					try {
						lock.wait();
						assert !waiting;
					}catch(InterruptedException e) {
						llog.warning(null,"unexpected interrupt while {0} was waiting", e,owner);
					}
				}
			}
			
			llog.debugReturnVoid(this);
		}
		//call from another thread while waiting to end blocking
		public final void signal() {
			llog.debugEnter(this);
			
			assert waiting;
			waiting=false;
			
			synchronized(lock) {
				lock.notify();
			}
			
			llog.debugReturnVoid(this);
		}
	}
	private static interface Threadish{
		public abstract String toString();
		public abstract void checkOnThisThread();
	}
}