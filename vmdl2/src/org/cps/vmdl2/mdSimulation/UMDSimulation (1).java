package org.cps.vmdl2.mdSimulation;

/**
 * Title:        Universal Molecular Dynamics
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      Boston University
 * @author Amit Bansil
 * @version 0.0a
 */
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.simple.SimpleNotifier;
import org.cps.framework.core.event.simple.SimpleObservable;
import org.cps.framework.core.io.StreamCopier;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

public abstract class UMDSimulation implements Timed {
	public static final double STEP_SCALE=.1;
	protected UMDSimulation() {
		displayData = new SimulationDisplayData();
		parameterData = new SimulationParameterData();
		inputParameterData = new SimulationInputParameterData(this);
		typeData = new SimulationTypeData();

		link(displayData, parameterData, inputParameterData, typeData);
	}

	private boolean firstLoad = true;//todo,make this unneccessary

	private final void checkFirstLoad() {
		if (!firstLoad) return;
		firstLoad = false;
	}

	//data
	private final SimulationDisplayData displayData;

	public final SimulationDisplayData getDisplayData() {
		return displayData;
	}

	private final SimulationParameterData parameterData;

	public final SimulationParameterData getParameterData() {
		return parameterData;
	}

	private final SimulationInputParameterData inputParameterData;

	public final SimulationInputParameterData getInputParameterData() {
		return inputParameterData;
	}

	private final SimulationTypeData typeData;

	public final SimulationTypeData getTypeData() {
		return typeData;
	}

	//control/time
	public final double getCurrentTime() {
		return _curTime/STEP_SCALE;
	}
	public final double getTimeDuringAdvance() {
		return getInstantTime()/STEP_SCALE;
	}

	public final void abortAdvance() {
		System.err.println("ERROR:BCP did not correctly reset next");
		abort();
	}

	public final void advanceTime(final double stepSize) 
			throws SimulationException {
//System.out.println("updating");
		CPSQueue.getInstance().checkThread();
		
		int flag=calculateStep((float)(stepSize*STEP_SCALE));
		
		setChanged(flag);
		//??? order???
		String s = processMessages();
		if (s != null)throw new SimulationException(s);
	} //change support

	private final SimpleNotifier changeNotifier = new SimpleNotifier(this);

	public SimpleObservable observable() {
		return changeNotifier;
	}

	//change
	private final SimulationFlags flags = new SimulationFlags();

	private final void setChanged(int flagsInt) {
		flags.setFlag(flagsInt);
		if (!flags.isChanged()) return;

		displayData.setChangeFlag(flags);
		inputParameterData.setChangeFlag(flags);
		parameterData.setChangeFlag(flags);
		typeData.setChangeFlag(flags);

		changeNotifier.fireEvent();
		
		displayData.reset();
		typeData.reset();
	}
	//finish
	public final void finish() {
		if (open) close();
	}

	private boolean open = false;

	public final void load(InputStream in) throws IOException {
		if (open) close();
		File f = File.createTempFile("umdIn", "txt");
		FileOutputStream out = new FileOutputStream(f);
		try {
			StreamCopier.copy(in, out);
			out.flush();
			setChanged(load(f.getAbsolutePath()));
			open = true;

			String s = processMessages();
			if (s != null) throw new IOException(s);
		} finally {
			if (out != null) out.close();
			f.delete();
		}
		checkFirstLoad();
	}

	public final void save(OutputStream d) throws IOException {
		if (!open) throw new IllegalStateException("no file open");

		File f = File.createTempFile("umdOut", "txt");
		FileInputStream in = null;
		try {
			save(f.getAbsolutePath());
			String s = processMessages();
			if (s != null) throw new IOException(s);
			in = new FileInputStream(f);
			StreamCopier.copy(in, d);
			//???flush
		} finally {
			if (in != null) in.close();
			f.delete();
			//todo log delete fail (don't throw ex since this will go over
			//more pertinent exceptions
		}

	}
	private final String processMessages() {
		if (_msgString != null)//todo log msgString or remove altogether
				System.out.println(_msgString);

		if (_errorString != null) {
			String e = _errorString;
			_errorString = null;
			return e;
		} else
			return null;
	}

	public final void callFunction(int fnum, double[] values)
			throws IllegalArgumentException {

		CPSQueue.getInstance().checkThread();
		setChanged(call(fnum, values));
		String s = processMessages();
		if (s != null) throw new IllegalArgumentException(s);
	}

	//hooks
	protected abstract int call(int fnum, double[] value);

	protected abstract void close();

	protected abstract void save(String name);

	protected abstract int load(String name);

	protected abstract void abort();

	protected abstract void unlink();

	protected abstract int calculateStep(float time);

	protected abstract void link(SimulationDisplayData displayData,
			SimulationParameterData parameterData,
			SimulationInputParameterData inputParameterData,
			SimulationTypeData typeData);

	protected abstract float getInstantTime();

	protected double _curTime = 0;

	protected String _errorString = null;

	protected String _msgString = null;
}