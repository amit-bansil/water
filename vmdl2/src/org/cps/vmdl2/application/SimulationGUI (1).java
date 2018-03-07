/*
 * SimulationGUI.java
 * CREATED:    Aug 20, 2004 10:10:23 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.application;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.application.gui.ApplicationGUI;
import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.gui.components.NumberOutput;
import org.cps.framework.core.gui.components.WorkspaceMenu;
import org.cps.framework.util.resources.accessor.ResourceAccessor;
import org.cps.umd.display.UMDDisplay;
import org.cps.vmdl2.mdSimulation.Clock;
import org.cps.vmdl2.plot.VariablePlot;

import com.jgoodies.forms.builder.DefaultFormBuilder;
import com.jgoodies.forms.layout.FormLayout;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSplitPane;
import javax.swing.SwingUtilities;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class SimulationGUI {
	private static final ResourceAccessor res = ResourceAccessor
			.load(SimulationGUI.class);

	private final ApplicationGUI gui;

	private final DefaultFormBuilder formBuilder;

	public SimulationGUI(Application app, final SimulationManager sim,
			final UMDDisplay renderer) {
		gui = app.getGUI();
		final FormLayout layout = new FormLayout(
				"right:pref, 3dlu,right:pref, 1dlu,pref", "");
		formBuilder = new DefaultFormBuilder(layout);

		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				JSplitPane split = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT);
				gui.setContentPane(split);

				setupTimeControl(sim.getClock(), sim.getOutputs().realTime());

				//temperature controls
				setupTemperatureControls(sim);

				JComponent chart = new JPanel(new BorderLayout());
				chart.setBackground(Color.WHITE);
				chart.setMaximumSize(new Dimension(500, 500));
				chart.setPreferredSize(new Dimension(200, 200));
				chart.setMinimumSize(new Dimension(50, 50));
				chart.setAlignmentX(1);

				final VariablePlot tempPlot = new VariablePlot(1000, "",
						"", "Temperature", "Temperature v Time");
				sim.getOutputs().realTime().addListener(new GenericListener() {
					public void eventOccurred(Object arg0) {
						tempPlot.addValue(sim.getOutputs().temperature()
								.get().doubleValue(),sim.getOutputs().realTime().get()
								.doubleValue());
					}
				});
				/*tempPlot.addValue(sim.getOutputs().realTime().get()
						.doubleValue(), sim.getOutputs().temperature()
						.get().doubleValue());*/
				chart.add(tempPlot.getComponent());
				
				Container form = formBuilder.getContainer();

				JComponent left = new JPanel(new BorderLayout(0, 0));
				left.add(form, BorderLayout.NORTH);
				left.add(chart, BorderLayout.SOUTH);
				left.setBorder(BorderFactory.createEmptyBorder(6, 6, 6, 3));

				split.setLeftComponent(left);

				JComponent displayHolder = new JPanel(new BorderLayout());
				Component display = renderer.getCanvas();
				display.setPreferredSize(new Dimension(500, 500));
				display.setMinimumSize(new Dimension(200, 200));
				displayHolder.setBorder(BorderFactory.createEmptyBorder(6, 3,
						6, 6));
				displayHolder.add(display, BorderLayout.CENTER);

				split.setRightComponent(displayHolder);

				split.resetToPreferredSizes();
			}
		});
	}

	private Double oldEx;

	private final void setupTemperatureControls(SimulationManager sim) {
		final NumberOutput tempOut = new NumberOutput(sim.getOutputs()
				.temperature(), 4, 6);
		final SimpleSpinner tempIn = new SimpleSpinner(sim.getInputs()
				.temperature(), new double[]{0f, 1f, 2f, 5f, 10f, 20f, 50f,
				100f, 200f});
		final SimpleSpinner tempEx = new SimpleSpinner(sim.getInputs()
				.exchange(), new double[]{0f, 1f, 5f, 10f, 20f, 50f, 100f});
		final JCheckBox desired = new JCheckBox("Desired", true);
		desired.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent evt) {
				boolean e = desired.isSelected();
				tempIn.setEnabled(e);
				tempEx.setEnabled(e);
				if (e) {
					tempEx.setValue(oldEx);
				} else {
					oldEx = (Double) tempEx.getValue();
					tempEx.setValue(new Double(0));
				}
			}
		});
		oldEx = (Double) tempEx.getValue();
		tempEx.setValue(new Double(0));
		desired.setSelected(false);
		tempIn.setEnabled(false);
		tempEx.setEnabled(false);

		formBuilder.appendSeparator("Temperature");
		formBuilder.append("Current", tempOut, new JLabel(" "));
		formBuilder.nextLine();
		formBuilder.append(desired, 1);
		formBuilder.append(tempIn, 1);
		formBuilder.append(new JLabel(" "), 1);
		formBuilder.nextLine();
		formBuilder.append("Exchange Rate", tempEx, new JLabel("%"));
		formBuilder.nextLine();
	}

	private final void setupTimeControl(Clock clock,
			BoundPropertyRO<Double> realTime) {
		clock.setGUI(gui.getContentPane());
		//menu
		WorkspaceMenu simMenu = new WorkspaceMenu(res.getChild("simulation"));
		simMenu.addMenuItem(clock.getStartAction());
		simMenu.addMenuItem(clock.getStepAction());
		simMenu.addMenuItem(clock.getStopAction());
		simMenu.addMenuItem(clock.getBigStepAction());
		simMenu.initialize();
		gui.addMenu(simMenu);
		//controls
		formBuilder.appendSeparator("Time");
		start = new ActionButton(clock.getStartAction());
		stop = new ActionButton(clock.getStopAction());
		step = new ActionButton(clock.getStepAction());
		//ERROR hack
		gui.setPrimaryButton(start);
		start.setText("");
		stop.setText("");
		step.setText("");
		JPanel controlButtons = new JPanel(new GridLayout(1, 3, 6, 6));
		controlButtons.add(start);
		controlButtons.add(step);
		controlButtons.add(stop);
		formBuilder.append(controlButtons, formBuilder.getLayout()
				.getColumnCount());
		formBuilder.nextLine();
		formBuilder.append("Time", new NumberOutput(clock.swingTime(), 4, 7),
				new JLabel("steps"));
		/*
		 * formBuilder.append("Internal Time", new NumberOutput(realTime, 4, 7),
		 * new JLabel("")); formBuilder.nextLine();
		 */
		formBuilder.append("Current Scale", new NumberOutput(clock
				.swingActualTimeScale(), 2, 3), new JLabel("steps/sec"));
		formBuilder.nextLine();
		formBuilder.append("Desired Scale", new SimpleSpinner(clock
				.swingDesiredTimeScale(), new double[]{1f, 2f, 5f, 10f, 20f,
				50f, 100f, 200f, 500f, 1000f, 2000f, 5000f, 10000f}),
				new JLabel("steps/sec"));
		formBuilder.nextLine();
	}

	//this is to put the focus in the right place when started/stopped etc
	//ERROR this is just plain wrong,should be done abstractly by the window
	//which iterates the component tree for enabled components
	//marked as "primary focus recievers" or such
	static JButton start, stop, step;

	public static final void resetFocus() {
		if (start != null && start.isEnabled()) start.grabFocus();
		else if (stop != null && stop.isEnabled()) stop.grabFocus();
	}
}