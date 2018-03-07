package org.cps.vmdl2.application;

import org.apache.commons.lang.ArrayUtils;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;

import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.SpinnerNumberModel;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import java.awt.Color;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.util.Arrays;

/**
 * TODO rewrite,create a factory of editors
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class SimpleSpinner extends JSpinner {

	public SimpleSpinner(final BoundPropertyRW<Double> target, double[] values) {
		super();
		double curV = target.get().doubleValue();
		setModel(new SpinnerFloatArrayModel(values, curV, calcMax(values),
				calcMin(values)));
		setEditor(new CSpinnerNumberEditor(this));
		target.addListener(new ValueChangeListener<Double>() {
			public void eventOccurred(ValueChangeEvent<Double> e) {
				setValue(e.getNewValue());
			}
		});
		final JTextField f = ((JSpinner.DefaultEditor) getEditor())
				.getTextField();
		f.setColumns(5);
		addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				f.getCaret().setVisible(false);
				SimulationGUI.resetFocus();
				f.setForeground(Color.black);

				target.set((Double) getValue());
			}
		});
	}

	private static final double calcMax(double[] values) {
		double ret = Double.MIN_VALUE;
		for (int i = 0; i < values.length; i++)
			if (values[i] > ret) ret = values[i];
		return ret;
	}

	private static final double calcMin(double[] values) {
		double ret = Double.MAX_VALUE;
		for (int i = 0; i < values.length; i++)
			if (values[i] < ret) ret = values[i];
		return ret;
	}

	private static class SpinnerFloatArrayModel extends SpinnerNumberModel {
		public void setMinimum(Comparable minimum) {
			throw new IllegalArgumentException("op not supported");
		}

		public void setMaximum(Comparable minimum) {
			throw new IllegalArgumentException("op not supported");
		}

		public void setStepSize(Number stepSize) {
			throw new IllegalArgumentException("op not supported");
		}

		public Number getNumber() {
			return (Number) getValue();
		}

		private final double[] values;

		private final int len;

		private final int determineCur() {
			final double value = getNumber().doubleValue();
			for (int i = 0; i < values.length; i++)
				if (value <= values[i]) return i;
			return values.length - 1;
		}

		public SpinnerFloatArrayModel(double[] values, double value,
				double max, double min) {
			super(value, min, max, (max - min) / values.length);
			len = values.length;
			this.values = ArrayUtils.clone(values);
			Arrays.sort(this.values);
			determineCur();
		}

		public Object getNextValue() {

			int cur = determineCur();
			if (values[cur] == getNumber().doubleValue()) {
				cur++;
				if (cur >= len) return null;
			}
			return new Double(values[cur]);
		}

		public Object getPreviousValue() {
			int cur = determineCur();
			cur--;
			if (cur < 0) return null;
			else
				return new Double(values[cur]);
		}
	}

	//retrofit editor to hook up to windows status bar
	//which might be a top pane or just some label...
	private static class CSpinnerNumberEditor extends JSpinner.NumberEditor {

		public CSpinnerNumberEditor(JSpinner spinner) {
			super(spinner, "#######0.########");
			final JTextField f = getTextField();
			f.addMouseListener(new MouseAdapter() {
				public void mouseClicked(MouseEvent e) {
					//???? is this really a good idea?
					//better to select on focus,
					/* if (e.getClickCount() == 2) */f.selectAll();
				}
			});

			f.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					f.getCaret().setVisible(false);
					SimulationGUI.resetFocus();
					f.setForeground(Color.black);
				}
			});

		}
	}
}