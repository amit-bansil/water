/*
 * SimulationManager.java
 * CREATED:    Aug 20, 2004 7:49:28 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.application;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.application.gui.DocumentActions;
import org.cps.framework.core.event.collection.BoundCollectionRO;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.io.DocumentData;
import org.cps.framework.core.io.ObjectInputStreamEx;
import org.cps.framework.core.io.ObjectOutputStreamEx;
import org.cps.umd.display.UMDDisplay;
import org.cps.umd.simulation.BCPSimulation;
import org.cps.umd.simulation.FastDrawer;
import org.cps.vmdl2.mdSimulation.Clock;
import org.cps.vmdl2.mdSimulation.SimulationDisplayData;
import org.cps.vmdl2.mdSimulation.SimulationInputParameterData;
import org.cps.vmdl2.mdSimulation.SimulationParameterData;
import org.cps.vmdl2.mdSimulation.SimulationTypeData;
import org.cps.vmdl2.mdSimulation.UMDSimulation;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class SimulationManager {
	private final Clock clock;

	private static final double DEFAULT_DESIRED_TIME_SCALE = 10;

	public final Clock getClock() {
		return clock;
	}
	public SimulationInputParameterData getInputs() {
		return sim.getInputParameterData();
	}
	public SimulationParameterData getOutputs() {
		return sim.getParameterData();
	}
	final UMDSimulation sim;
	FastDrawer drawer;
	public SimulationManager(Application app,final UMDDisplay display) {
		sim= new BCPSimulation();

		clock = new Clock(sim, 1, 100, DEFAULT_DESIRED_TIME_SCALE);

		app.getDocumentManager().registerDocumentData("clock", clock);

		//final BoxDrawer boxDrawer=new BoxDrawer();
		drawer=new FastDrawer(display,sim);
		display.drawers.add(drawer);
		//renderer.addDrawer(new AtomDrawer(sim,9));
		sim.observable().addListener(new GenericListener(){
			public void eventOccurred(Object arg0) {
				final SimulationDisplayData displayData=sim.getDisplayData();
				final SimulationTypeData typeData=sim.getTypeData();
				if(displayData.isSizeChanged()) {
					float[] size=displayData.getSize();
					/*boxDrawer.setSize(size[0],size[1],size[2]);
					boxDrawer.setOrigin(-size[0]/2f,-size[1]/2f,-size[2]/2f);
					//TODO only rescale at start???
					//TODO ad auto scaling option
					renderer.getCamera().setZoom((1d/size[0])*2d);*/
					display.boxDrawer.setSize(size[0],size[1],size[2]);
				}
				if(displayData.isChanged()) {
					drawer.update(typeData.isChanged());
				}
				display.postredraw();
			}
		});
		
		final BoundCollectionRO simObservables = EventUtils
				.singletonCollection(sim.observable());
		app.getGUI().getDocumentActions().setFileHook(new DocumentActions.FileHook() {
			public void importFile(InputStream in) throws IOException {
				sim.load(in);
			}

			public String getTypeName() {
				return "BCP Simulation";
			}

			public String getExtension() {
				return "txt";
			}

			public void exportFile(OutputStream out) throws IOException {
				sim.save(out);
			}
		});
		app.getDocumentManager().registerDocumentData("simulation",
				new DocumentData() {
					public void loadBlank() {
						InputStream in = null;
						try {
							in = new BufferedInputStream(new FileInputStream(
									"bcp_defaultConfig.txt"));
							sim.load(in);
						} catch (IOException e) {
							throw new Error(e);
						} finally {
							if (in != null) try {
								in.close();
							} catch (IOException e1) {
								//should not happen
								}
						}
					}

					//TODO version IO
					public void write(ObjectOutputStreamEx out)
							throws IOException {
						sim.save(out);
					}

					public void read(ObjectInputStreamEx in) throws IOException {
						sim.load(in);
					}

					public void initialize() {
						//do nothing
					}

					public BoundCollectionRO getStateObjects() {
						return simObservables;
					}

				});
	}
}