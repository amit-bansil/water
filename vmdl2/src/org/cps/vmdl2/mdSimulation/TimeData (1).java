package org.cps.vmdl2.mdSimulation;


/**
 * Title:        Universal Molecular Dynamics
 * Description:
 * Copyright:    Copyright (c) 2001
 * Company:      Boston University
 * @author Amit Bansil
 * @version 0.0a
 */
/**public final class TimeData extends DataModel{//abort to make stop faster,show a calculating dialog during long steps
	private static final float CONVERSION=1;
	public final float getActElapsedTime(){return elapsedTime.getFloatValue()*CONVERSION;}
	public final float getElapsedTime(){return elapsedTime.getFloatValue();}
	public static final String RUNNING="running",TIME_STEP="timeStep",
	FRAME_RATES="frameRates",ELAPSED_TIME="elapsedTime";

	private final BooleanProperty running;
	private final FloatProperty.Bound timeStep;
	private final FloatArrayProperty frameRates;
	private final FloatProperty elapsedTime;

	private final PromptDescription customStepSizePrompt,bigStepPrompt;
	private final UMDSimulation target;


	public TimeData(UMDSimulation target){
		super(target,"Time Data");
		this.target=target;

		actRunning=false;
		running=new BooleanProperty(this,RUNNING,actRunning);
		timeStep=new FloatProperty.Bound(this,TIME_STEP,SimulationDefaults.getDefaultStepSize(),
				SimulationDefaults.getMaxStep(),SimulationDefaults.getMinStep());
		customStepSizePrompt=new PromptDescription.NumberPrompt(CPSText.trans("customStep title"),
				CPSText.trans("customStep prompt"),timeStep.getMax(),timeStep.getMin());
		frameRates=new FloatArrayProperty(this,
				FRAME_RATES,SimulationDefaults.getDefaultStepSizes());
		bigStepPrompt=new PromptDescription.NumberPrompt(CPSText.trans("bigStep prompt"),
				CPSText.trans("bigStep title"),timeStep.getMax(),timeStep.getMin());

		elapsedTime=new FloatProperty(this,ELAPSED_TIME,(float)target.getCurrentTime());
		elapsedTime.setReadOnly(true);

		running.getChange().addListener(new ChangeListener(){
			public final void targetChanged(){
				if(running.getBooleanValue())startRunning();
				else stopRunning();
			}
		});
	}
	public static final String PROMPT_STEP="promptStep",STEP="step",PROMPT_TIME_STEP="promptTimeStep";
	static{
		MethodRegistry.registerMethod(TimeData.class,PROMPT_STEP,"prompts user to advance time");
		MethodRegistry.registerMethod(TimeData.class,PROMPT_TIME_STEP,"prompts user to change step size");
		MethodRegistry.registerMethod(TimeData.class,STEP,"advances time",float.class);
	}

	public static void classFinalize() throws Throwable {
		MethodRegistry.unregisterMethod(STEP);
		MethodRegistry.unregisterMethod(PROMPT_STEP);
		MethodRegistry.unregisterMethod(PROMPT_TIME_STEP);
	}

	private final Runnable updater=new Runnable(){
		public final void run(){
			processStep(timeStep.getFloatValue());
		}
	};
	public final void promptStep(){
		Float s=(Float)getCore().getUI().prompt(bigStepPrompt);
		if(s!=null) step(s.floatValue());
	}
	public final void step(float f){
		final ProgressDescription pd=new ProgressDescription(//make this smarter
				CPSText.trans("advancing time")+" "+f+
				" "+CPSText.trans("time units")+".",
				target.getProgressListener(),
				(float)target.getCurrentTime()+f);
		getCore().getUI().addProgressMonitor(pd);
		processStep(f);//probably process another tiny little step afterward to avoid BCP problems, or fix
		getCore().getUI().removeProgressMonitor(pd);
	}
	public final void promptTimeStep(){
		Float s=(Float)getCore().getUI().prompt(customStepSizePrompt);
		if(s!=null) timeStep.setFloatValue(s.floatValue());
	}
	private final void processStep(float stepSize){
		try{
			target.step(stepSize/CONVERSION);
			elapsedTime.setFloatValue((float)target.getCurrentTime());
		}catch(SimulationException e){
			if(CPSErrors.simulationException(e)==CPSErrors.SIMULATION_ERROR_RESET){
				target.reset();
			}else running.setBooleanValue(false);
		}
	}
	private boolean actRunning=false;
	private final void startRunning(){
		if(actRunning) return;
		getCore().getKernel().startRunning(updater);
		actRunning=true;
	}
	private final void stopRunning(){
		if(!actRunning) return;
		getCore().getKernel().stopRunning(updater);
		actRunning=false;
	}
	public final void finish(){
		if(actRunning) getCore().getKernel().stopRunning(updater);
		super.finish();
	}
}*/