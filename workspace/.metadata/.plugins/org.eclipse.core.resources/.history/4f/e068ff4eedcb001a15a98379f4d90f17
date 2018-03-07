/*
 * CREATED ON:    Jul 21, 2005 6:44:50 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.gui.status;

import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;

// TODO
// implement thread level progress reporting, and have progress hooks in here
// just call that
// create a progressmonitor component that ineracts with threadlevel progress
// information.
// TODO deal with out of memory exceptions...

/**
 * Encapsulats an operation that might take a long time. While running progress
 * can be monitored, partial results viewed, and the run can be exited. Can only
 * be run from execution thread. Usually run by a LongOperationExecutor.
 * InputType and OutputType should be immutable to maintain threadsafety.<br>
 * ID: $Id: LongOperation.java 545 2005-09-02 12:24:18Z bansil $
 */
public abstract class LongOperation<InputType, OutputType> {
	private static final LogEx<LongOperation> log = LogEx
		.createClassLog(LongOperation.class);

	/**
	 * thread run should be called by.
	 */
	private final Thread executionThread;

	// ensures on exection thread
	private final void checkExecutionThread() {
		if (!Thread.currentThread().equals(executionThread))
			throw new IllegalStateException("illegal access from thread "
					+ Thread.currentThread() + " not " + executionThread);
	}

	/**
	 * creates LongOperation.
	 * 
	 */
	public LongOperation(Thread executionThread) {
		LangUtils.checkArgNotNull(executionThread);
		this.executionThread = executionThread;
		log.debug(this, "long operation created by thread '{0}'", Thread
			.currentThread());
	}

	// ------------------------------------------------------------------------
	// hooks for executor to call, public

	/**
	 * set to false before running and marked true while running if the run
	 * should be aborted.
	 */
	private boolean shouldAbort;

	/**
	 * abort current run. does nothing if not running or already aborting.
	 */
	public final void setShouldAbort() {
		if (!running.get()) {
			log.debug(this,
				"abort requested from thread '{0}' ignored, !running", Thread
					.currentThread());
			return;
		}
		log.debug(this, "abort requested from thread '{0}'", Thread
			.currentThread());
		if (shouldAbort) {
			log.warning(this, "abort requested while aborting by thread '{0}'",
				Thread.currentThread());
		}
		shouldAbort = true;
	}

	private final RWValue<String> status = new RWValueImp<String>();

	/**
	 * @return status of current run. null when not running or undetermined.
	 */
	public final ROValue<String> status() {
		return status;
	}

	private final RWValue<Float> percentComplete = new RWValueImp<Float>();

	/**
	 * @return percent of current run completed, a float in [0,1] or null when
	 *         not running or undermined.
	 */
	public final ROValue<Float> precentComplete() {
		return percentComplete;
	}

	private final RWValue<Boolean> running = new RWValueImp<Boolean>(
		Boolean.FALSE);

	/**
	 * @return if operation is being run.
	 */
	public final ROValue<Boolean> running() {
		return running;
	}

	private final RWValue<OutputType> output = new RWValueImp<OutputType>();

	/**
	 * @return ouput of last run. usually changes during a run. cleared at the
	 *         start of each run to null.
	 */
	public final ROValue<OutputType> output() {
		return output;
	}

	// internal hook to throw IllegalStateException if !running
	private final void checkRunning() {
		if (!running.get()) throw new IllegalStateException("!running");
	}

	public final void doRun(InputType in) {
		checkExecutionThread();

		// clear everything
		shouldAbort = false;
		percentComplete.set(null);
		output.set(null);
		status.set(null);

		running.set(true);
		_run(in);
		running.set(false);
	}

	// ------------------------------------------------------------------------
	// hooks for implementations to call, protected
	/**
	 * while running implementations should query shouldAbortRun frequently
	 * (approx every millisecond) and abort running if true.
	 */
	protected final boolean shouldAbortRun() {
		checkExecutionThread();
		checkRunning();
		return shouldAbort;
	}

	/**
	 * while running implementations should call setAmountRunCompletedUnknown
	 * whenever the AmountRunCompleted changes to unknown.
	 */
	protected final void setAmountRunCompletedUnknown() {
		checkExecutionThread();
		checkRunning();
		percentComplete.set(null);
	}

	/**
	 * while running imementations should setAmountRunCompleted to a float in
	 * [0,1] represting either the amount of the whole operation they've
	 * completed or the percent of the current step their on. Update only every
	 * few milliseconds.
	 */
	protected final void setAmountRunCompleted(float f) {
		if (f < 0 || f > 1.0f)
			throw new IllegalArgumentException("percentComplete not in [0,1]");
		checkExecutionThread();
		percentComplete.set(f);
	}

	/**
	 * sets the status of this operation. whenever possible specifiy which step
	 * this is of the total. Update only every few milliseconds.
	 */
	protected final void setStatus(String s) {
		checkExecutionThread();
		checkRunning();
		status.set(s);
	}

	/**
	 * set/update operation output. Update only every few milliseconds, or
	 * perhaps just at end.
	 */
	protected final void updateOutput(OutputType out) {
		checkExecutionThread();
		checkRunning();
		output.set(out);
	}

	/**
	 * perform actual operation. should call hooks above to report progress. use
	 * updatedOutput to specify/update results.
	 */
	protected abstract void _run(InputType in);
}
