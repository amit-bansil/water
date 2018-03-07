/*
 * CREATED ON:    Apr 16, 2006 10:10:25 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.data;

import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JPanel;

import java.awt.Color;
import java.awt.Dimension;

/**
 * <p>TODO document DataViewer
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class DataViewer {
	private final JComponent panel;
	//private final JCheckBox recordEnabled;
	//private final JComboBox snapshotCombo;
	
	
	public DataViewer(DataViewerModel dataViewer1Model) {
		panel=new JPanel();
		panel.setBackground(Color.BLACK);
		panel.setPreferredSize(new Dimension(300,300));
		panel.setMinimumSize(new Dimension(200,200));
		panel.setMaximumSize(new Dimension(1000,1000));
	}

	public JComponent getComponent() {
		return panel;
	}

	public void shutdown() {
	}

}