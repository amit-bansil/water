/*
 * CREATED ON:    Jul 21, 2005 6:45:11 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.gui.status;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.event.tools.DelayedLink;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.util.misc.Worker;

import java.util.EventObject;
import java.util.concurrent.TimeUnit;

/**
 * runs a long operation on its own private 'executionWorke'r from a specified
 * 'controllingWorker'. The worker can also monitor progress by observing the
 * 'output','status',&'percentComplete' properties. These are accessible from
 * the EDT only. 'InputType' and 'OutputType' match the
 * LongOperation's 'InputType' and 'OutputType' and should be immutable to
 * maintain threadsafety.<br>
 * ID: $Id: LongOperationExecutor.java 548 2005-09-02 14:25:58Z bansil $
 */
//@SuppressWarnings({"ClassWithTooManyFields"})
public class LongOperationExecutor<InputType, OutputType> {

	private final Worker controllingWorker, executionWorker;

	private final LongOperation<InputType, OutputType> operation;

	/**
	 * creates LongOperationExecutor.
	 * 
	 * @param runPriority
	 *            priority 'executionWorker' runs at.
	 * @throws IllegalStateException
	 *             if not run from controllingWorker
	 */
	public LongOperationExecutor(LongOperation<InputType, OutputType> op,
			Worker controllingWorker, int runPriority) {
		controllingWorker.checkWorkerRunning();
		this.controllingWorker = controllingWorker;
		this.operation = op;

		executionWorker = new Worker("executionWorker");
		executionWorker.setPriority(runPriority);
		// run as a deamon incase this executor is never disposed
		executionWorker.setDaemon(true);

		opLink = DelayedLink.createConditionalLink(controllingWorker, 2,
			TimeUnit.MILLISECONDS, new Link() {
				@Override public void signal(EventObject event) {
					update();
				}
			});

		operation.status().connect(opLink);
		operation.precentComplete().connect(opLink);
		operation.running().connect(opLink);
		operation.output().connect(opLink);
		update();
	}

	/**
	 * kill executionWorker and release operation so this can be gc'd.
	 */
	public final void dispose() {
		executionWorker.retireASAP();
		operation.status().disconnect(opLink);
		operation.precentComplete().disconnect(opLink);
		operation.running().disconnect(opLink);
		operation.output().disconnect(opLink);
	}

	// ------------------------------------------------------------------------
	// run

	private InputType latestInput;

	/**
	 * request that the operation be rerun. These calls are buffered so that
	 * they are exuected no more than once per 'runDelay' timeUnits.
	 * Consequently, many 'input' values may be ignored.
	 */
	public final void requestRun(InputType input) {
		executionWorker.checkWorkerRunning();
		latestInput = input;
		controllingWorker.runConditional(runDelay, runUnits, runner);
	}

	private long runDelay = 2;

	private TimeUnit runUnits = TimeUnit.MILLISECONDS;

	public final long getRunDelay() {
		return runDelay;
	}

	public final TimeUnit getRunUnits() {
		return runUnits;
	}

	public final void setRunDelay(long runDelay, TimeUnit runUnits) {
		this.runDelay = runDelay;
		this.runUnits = runUnits;
	}

	private final Runnable runner = new Runnable() {
		public final void run() {
			operation.doRun(latestInput);
		}
	};

	// ------------------------------------------------------------------------
	// monitoring

	public final long getOutputUpdateDelay() {
		return opLink.getDelay();
	}

	public final TimeUnit getOutputUpdateUnits() {
		return opLink.getDelayTimeUnit();
	}

	public final void setOutputUpdateDelay(long delay, TimeUnit units) {
		opLink.setDelay(delay, units);
	}

	private final RWValue<OutputType> output = new RWValueImp<OutputType>();

	public final ROValue<OutputType> output() {
		return output;
	}

	private final RWValue<String> status = new RWValueImp<String>();

	public final ROValue<String> status() {
		return status;
	}

	private final RWValue<Float> percentComplete = new RWValueImp<Float>();

	public final ROValue<Float> percentComplete() {
		return percentComplete;
	}

	private final RWValue<Boolean> running = new RWValueImp<Boolean>(false);

	public final ROValue<Boolean> running() {
		return running;
	}

	// pulls values from execution thread
	private final DelayedLink<EventObject> opLink;

	private final void update() {
		controllingWorker.checkWorkerRunning();

		percentComplete.set(operation.precentComplete().get());
		output.set(operation.output().get());
		status.set(operation.status().get());
		running.set(operation.running().get());
	}

	public final void abort() {
		controllingWorker.checkWorkerRunning();
		operation.setShouldAbort();
	}
}
