/*
 * NumberEditorFactory.java
 * CREATED:    Jun 19, 2005 10:59:06 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.builder;

import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.gui.data.NumberBinder;

import javax.swing.JSlider;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerNumberModel;
import javax.swing.SwingConstants;

public class NumberEditorFactory {

	/**
	 * a light slider is horizontal slider which lacks any labels ticks etc.
	 * bound to source spinner.
	 * 
	 * @see NumberBinder#bindSlider
	 */
	public static JSlider createLightSlider(JSpinner source, float minimumStep) {
		JSlider ret = new JSlider(SwingConstants.HORIZONTAL);
		ret.setPaintTrack(true);
		ret.setPaintLabels(false);
		ret.setPaintTicks(false);

		NumberBinder.bindSlider(source, ret, minimumStep);

		return ret;
	}
	
	public static JSlider createLightSliderVert(JSpinner source, float minimumStep) {
		JSlider ret = new JSlider(SwingConstants.VERTICAL);
		ret.setPaintTrack(true);
		ret.setPaintLabels(true);
		ret.setPaintTicks(true);
		//ret.setMajorTickSpacing(10);

		NumberBinder.bindSlider(source, ret, minimumStep);

		return ret;
	}

	/**
	 * TODO comments
	 */
	public static JSpinner createFloatSpinner(float step,
			BoundedValue<Float> source) {
		return createFloatSpinner(step,source,DEFAULT_SPINNER_SIZE);
	}
	public static JSpinner createFloatSpinner(float step,
			BoundedValue<Float> source,int size) {
		JSpinner ret = createNumberSpinner(source.getMin(), source.getMax(),
			step,size);
		NumberBinder.bindFloatSpinner(source, ret);
		return ret;
	}

	public static JSpinner createFloatSpinner(float min, float max, float step,
			RWValue<Float> source) {
		return createFloatSpinner(min,max,step,source,DEFAULT_SPINNER_SIZE);
	}
	public static JSpinner createFloatSpinner(float min, float max, float step,
			RWValue<Float> source,int size) {
		JSpinner ret = createNumberSpinner(min, max, step,size);
		NumberBinder.bindFloatSpinner(source, ret);
		return ret;
	}
	private static final int DEFAULT_SPINNER_SIZE=4;
	public static JSpinner createIntSpinner(int step,
			BoundedValue<Integer> source) {
		return createIntSpinner(step,source,DEFAULT_SPINNER_SIZE);
	}

	public static JSpinner createIntSpinner(int step,
			BoundedValue<Integer> source,int size) {
		JSpinner ret = createNumberSpinner(source.getMin(), source.getMax(),
			step,size);
		NumberBinder.bindIntSpinner(source, ret);
		return ret;
	}

	public static JSpinner createIntSpinner(int min, int max, int step,
			RWValue<Integer> source) {
		JSpinner ret = createNumberSpinner(min, max, step);
		NumberBinder.bindIntSpinner(source, ret);
		return ret;
	}

	/**
	 * a 4 digit wide spinner that accepts decimal values.
	 * 
	 * TODO option to not allow decimals, customize to allow more than just 4
	 * digits TODO type the return object (int vs float spinner) so
	 * ControlBinder can be stricter? Or (better) just use a BoundProperty as
	 * the data model TODO don't allow negatives. (all this filtering has to be
	 * done through the formatted textfield, probably by setting the editor to a
	 * numberEditor with the correct decimalformat pattern, but there are lots
	 * of potential localization problems so it might be better to rebuild the
	 * editor from scratch.
	 * 
	 * all this checkching can also be implemented through the status bar in the
	 * data binding
	 * 
	 */
	public static JSpinner createNumberSpinner(float min, float max, float step) {
		return createNumberSpinner(min,max,step,DEFAULT_SPINNER_SIZE);
	}
	public static JSpinner createNumberSpinner(float min, float max, float step,int size) {
		JSpinner ret = new JSpinner(new SpinnerNumberModel(min, min, max, step));
		JTextField field = ((JSpinner.DefaultEditor) ret.getEditor())
			.getTextField();
		field.setColumns(size);
		return ret;
	}
	//create spinner with trivial initial values
	public static JSpinner createNumberSpinner(float step) {
		return createNumberSpinner(0, 10, 1);
	}
}
