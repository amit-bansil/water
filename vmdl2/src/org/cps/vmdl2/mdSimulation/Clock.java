/*
 * Clock.java
 * CREATED:    Aug 19, 2004 7:47:57 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.mdSimulation;

import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.core.GenericObservable;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.action.CPSWorkspaceAction;
import org.cps.framework.core.gui.components.Editor;
import org.cps.framework.core.gui.dialogs.EditorInputDialog;
import org.cps.framework.core.gui.dialogs.MessageDialog;
import org.cps.framework.core.gui.dialogs.ProgressDialog;
import org.cps.framework.core.gui.event.GuiEventUtils;
import org.cps.framework.core.io.DocumentData;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.framework.util.lang.misc.CircularFloatArray;
import org.cps.framework.util.lang.misc.ScientificFormat;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import java.awt.Component;
import java.io.IOException;

/**
 * rewrite for multiple targets,async execution add progress,breakup
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class Clock implements DocumentData {
	//a hack to prevent crashing when dragging mose
	public static boolean runningHack=false;
	
	//TODO unlink...
	private final Timed target;

	//run delay is ms, desiredTimeScale in steps per sec
	private final double initialDesiredTimeScale;

	public Clock(Timed ltarget, int priority, double runDelay,
			double desiredTimeScale) {
		CPSQueue.getInstance().checkThread();
		initialDesiredTimeScale = desiredTimeScale;
		this.target = ltarget;
		this.desiredTimeScale = new DefaultBoundPropertyRW(new Double(
				desiredTimeScale));
		actualTimeScale = new DefaultBoundPropertyRW();
		time = new DefaultBoundPropertyRW<Double>(new Double(target
				.getCurrentTime()));
		this.runDelay = Math.round(runDelay * (1000d * 1000d));
		this.priority = priority;

		updateRunStepSize();

		setupUI();

		target.observable().addListener(new GenericListener() {
			public void eventOccurred(Object e) {
				time.set(new Double(target.getCurrentTime()));
			}
		});

		stateObjects = EventUtils.constantCollection(new GenericObservable[]{
				running, this.desiredTimeScale});
	}

	//------------------------------------------------------------------------
	//public timing parameters
	private final BoundPropertyRW<Double> desiredTimeScale;

	public BoundPropertyRO<Double> actualTimeScale() {
		CPSQueue.getInstance().checkThread();
		return actualTimeScale;
	}

	private final BoundPropertyRW<Double> time;

	public BoundPropertyRO<Double> time() {
		CPSQueue.getInstance().checkThread();
		return time;
	}

	//------------------------------------------------------------------------
	//internal timing parameters
	private final long runDelay;//nanoseconds

	private final int priority;

	private double runStepSize;

	private final void updateRunStepSize() {
		double stepsPerS = desiredTimeScale.get().doubleValue();
		runStepSize = runDelay * (stepsPerS / (1000d*1000d*1000d));
		timeScaleChanged();
	}

	private final Runnable runner = new Runnable() {
		public void run() {
			if (!running.get().booleanValue()) return;
			CPSQueue.getInstance().postRunnableCPSLater(runner,
					CPSQueue.getInstance().getFrameTime() + runDelay, priority);
			if (!simulate(runStepSize)) running.set(Boolean.FALSE);
			updateActualTimeScale();
		}
	};

	//------------------------------------------------------------------------
	//simulate
	private boolean simulate(double amount) {
		try {
			target.advanceTime(amount);
			return true;
		} catch (SimulationException e) {
			new MessageDialog(res.composite(new Object[]{"message",
					e.getMessage()}), "simulation_error",
					MessageDialog.ERROR_TYPE).show(gui);
			return false;
		}
	}

	//------------------------------------------------------------------------
	//actual time scale calculations
	private final void timeScaleChanged() {
		actualTimeScale.set(null);
		runTimes.clear();
		lastRealTimeAccurate = false;
	}

	private final CircularFloatArray runTimes = new CircularFloatArray(10);

	private boolean lastRealTimeAccurate = false;

	private double lastRealTime;

	private double lastSimTime;

	private final void updateActualTimeScale() {
		double realTime = CPSQueue.getInstance().getTrueTime()
				/ (1000d * 1000d * 1000d);
		double simTime = time.get().doubleValue();
		if (lastRealTimeAccurate) {
			float elapsed =(float)( (simTime - lastSimTime)
					/ (realTime - lastRealTime));
			if(!Float.isNaN(elapsed)) {
				runTimes.add(elapsed);
				//TODO instead of just averaging come up with better calculation
				double actualTimeScaleD = (double)runTimes.sum() / runTimes.getCount();
				actualTimeScale.set(new Double(ScientificFormat.roundSigFigs(
						actualTimeScaleD, 2)));
			}

		} else
			lastRealTimeAccurate = true;
		lastRealTime = realTime;
		lastSimTime = simTime;
	}

	private final BoundPropertyRW<Double> actualTimeScale;

	//------------------------------------------------------------------------
	//UI Access
	private static final ResourceAccessor res = ResourceAccessor
			.load(Clock.class);

	private Component gui;

	public void setGUI(Component c) {
		gui = c;
	}

	public final void bigStep(final double amount) {
		CPSQueue.getInstance().checkThread();
		final double currentTime = target.getCurrentTime();
		assert currentTime == time.get().doubleValue();
		//ERROR SCIENTIFIC FORMAT DOES NOT WORK
		ProgressDialog pd = new ProgressDialog("Simulation to time "
				+ Double.toString(Math.round(currentTime + amount)),
				200, gui) {
			public void abort() {
				target.abortAdvance();
			}

			double it = currentTime;

			public double getPercentComplete() {
				it = target.getTimeDuringAdvance();
				double ret = ((it - currentTime) / amount) * 100d;
				return ret;
			}

			public String getStatus() {
				return "Time =" + ScientificFormat.SHORT_INSTANCE.format(it);
			}
		};
		simulate(amount);
		pd.done();
		//TODO log abort
	}

	private final BoundPropertyRW<Boolean> running = new DefaultBoundPropertyRW<Boolean>(
			Boolean.FALSE);

	public BoundPropertyRW<Boolean> running() {
		CPSQueue.getInstance().checkThread();
		return running;
	}

	public BoundPropertyRW<Double> desiredTimeScale() {
		CPSQueue.getInstance().checkThread();
		return desiredTimeScale;
	}

	public CPSWorkspaceAction getBigStepAction() {
		return bigStepAction;
	}

	public CPSWorkspaceAction getStartAction() {
		return startAction;
	}

	public CPSWorkspaceAction getStepAction() {
		return stepAction;
	}

	public CPSWorkspaceAction getStopAction() {
		return stopAction;
	}

	//------------------------------------------------------------------------
	//actions TODO seperate out
	private CPSWorkspaceAction startAction, stopAction, stepAction,
			bigStepAction;

	private BoundPropertyRW<Double> swingTime, swingDesiredTimeScale,
			swingActualTimeScale;

	private final void setupUI() {
		final BoundPropertyRO<Boolean> notRunning = EventUtils.not(running);

		startAction = new CPSWorkspaceAction(res, "start", notRunning) {
			protected void _cpsPerform() {
				running.set(Boolean.TRUE);
			}
		};
		stopAction = new CPSWorkspaceAction(res, "pause", running) {
			protected void _cpsPerform() {
				running.set(Boolean.FALSE);
			}
		};
		stepAction = new CPSWorkspaceAction(res, "step", notRunning) {
			protected void _cpsPerform() {
				simulate(runStepSize);
			}
		};
		//TODO name consitently
		bigStepAction = new CPSWorkspaceAction(res, "advance", notRunning) {
			protected void _cpsPerform() {
				//ERROR scientific format is not working
				//String initial = ScientificFormat.LONG_INSTANCE
				//		.format(runStepSize * 100);
				String initial=Integer.toString((int)Math.round(runStepSize*1000));
				
				Editor<Double> editor = new Editor.DoubleEditor(0, false,
						Double.MAX_VALUE, false);
				Double l = new EditorInputDialog<Double>(res, "stepSizePrompt",
						true, editor, initial).show(gui);
				if (l == null) return;
				bigStep(l.doubleValue());
			}
		};

		swingTime = GuiEventUtils.toSwing(time);
		swingActualTimeScale = GuiEventUtils.toSwing(actualTimeScale);
		swingDesiredTimeScale = GuiEventUtils.toSwing(desiredTimeScale);

		running.addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> e) {
				runningHack=e.getNewValue().booleanValue();
				CPSQueue.getInstance().checkThread();
				updateActualTimeScale();
				runner.run();
			}
		});
		desiredTimeScale.addListener(new ValueChangeListener<Double>() {
			public void eventOccurred(ValueChangeEvent<Double> e) {
				CPSQueue.getInstance().checkThread();
				updateRunStepSize();
			}
		});
	}

	public BoundPropertyRO<Double> swingTime() {
		return swingTime;
	}

	public BoundPropertyRW<Double> swingDesiredTimeScale() {
		return swingDesiredTimeScale;
	}

	public BoundPropertyRO<Double> swingActualTimeScale() {
		return swingActualTimeScale;
	}

	//------------------------------------------------------------------------
	//io
	//TODO versioning
	private final BoundCollectionRO stateObjects;

	public void loadBlank() {
		running.set(Boolean.FALSE);
		desiredTimeScale().set(new Double(initialDesiredTimeScale));
	}

	public void write(ObjectOutputStreamEx out) throws IOException {
		out.writeBoolean(running.get().booleanValue());
		out.writeDouble(desiredTimeScale.get().doubleValue());
	}

	private boolean lrunning;

	public void read(ObjectInputStreamEx in) throws IOException {
		lrunning = in.readBoolean();
		desiredTimeScale.set(new Double(in.readDouble()));
	}

	public void initialize() {
		running.set(new Boolean(lrunning));
	}

	public BoundCollectionRO getStateObjects() {
		return stateObjects;
	}

}