/*
 * CREATED ON:    Apr 23, 2006 5:47:37 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.simulation;

import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.util.collections.ArrayFinal;
import cps.jarch.util.collections.CursorableLinkedList;
import cps.jarch.util.notes.Constant;

import java.util.Iterator;
import java.util.concurrent.locks.ReentrantLock;

/**
 * <p>TODO document OutputParameters
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class Output {
	private final ReentrantLock lock;

	private final BoundedValue<Integer> recordStepSize;
	private final BoundedValue<Integer> maxRecordingCount;

	private int recordStep=-1,recordCount=-1,frameNumber=-1;
	public Output(ReentrantLock lock) {
		this.lock=lock;
		recordStepSize=new BoundedValue<Integer>(5,1,500,lock);
		maxRecordingCount=new BoundedValue<Integer>(200,50,500,lock);
	}
	
	
	void preStep() {
		if(!lock.isHeldByCurrentThread())throw new IllegalThreadStateException();
		
		recordStep = recordStepSize.get();
		recordCount = maxRecordingCount.get();
	}
	
	void step(Engine raw) {
		assert recordStep!=-1&&frameNumber!=-1;
		
		frameNumber++;
		if (frameNumber == nextRecord) {
			ArrayFinal.Builder<Float> recordingBuilder = new ArrayFinal.Builder<Float>(
					dataSets.getLength());
			
			recordingBuilder.add((float)raw.temp);
			recordingBuilder.add((float)raw.rho);
			recordingBuilder.add((float)raw.pres);
			recordingBuilder.add((float)raw.epot);
			recordingBuilder.add((float)raw.ekin);
			recordingBuilder.add((float)raw.eges);
			recordingBuilder.add((float)(raw.bx*raw.by*raw.bz));
			recordingBuilder.add((float)frameNumber);
				
			recordingData.addLast(recordingBuilder.create());
			nextRecord += recordStep;
		}
	}
	
	void clear() {
		if(!lock.isHeldByCurrentThread())throw new IllegalThreadStateException();
		//clear data
		nextRecord=frameNumber=0;
		recordingData.clear();
		maxRecordingCount.getData().loadInitial();
		recordStepSize.getData().loadInitial();
	}
	void postStep() {
		for (int excessRecordings = recordings.getCount()-recordCount; excessRecordings > 0;
		excessRecordings--)  recordingData.removeFirst();
	}

	
	private int nextRecord;

	private final CursorableLinkedList recordingData=new CursorableLinkedList();
	
	private static final ArrayFinal<String> dataSets = ArrayFinal.create(
		new String[] {"Temperature",
				"Density",
				"Pressure",
				"Potential Energy",
				"Kinetic Energy",
				"Total Energy",
				"Volume",
				"Time"});
	
	final Options options=new Options();
	public class Options{
		public final @Constant BoundedValue<Integer> maxRecordingCount(){
			return maxRecordingCount;
		}
		public final @Constant BoundedValue<Integer> recordStepSize(){
			return recordStepSize;
		}
	}
	
	final Recordings recordings=new Recordings();
	public class Recordings{
		@SuppressWarnings("unchecked") public final Iterator<ArrayFinal<Float>> get(){
			return recordingData.listIterator();
		}
		public final int getCount() {	
			return recordingData.size();
		}
		
		public final @Constant ArrayFinal<String> getRecordingElementNames(){
			return dataSets;
		}
	}
	public void read(Output output) {
		recordingData.addAll(output.recordingData);
		recordStepSize.setUnchecked(output.recordStepSize.get());
		maxRecordingCount.setUnchecked(output.maxRecordingCount.get());
	}
}
