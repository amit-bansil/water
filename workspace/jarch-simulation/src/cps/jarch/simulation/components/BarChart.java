/*
 * CREATED ON:    Aug 23, 2005 7:35:16 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.components;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.DataUtils;
import cps.jarch.gui.components.CELESTLook;
import cps.jarch.gui.util.ComponentProxy;

import javax.swing.JComponent;

import java.awt.Color;
import java.util.EventObject;

import lt.monarch.chart.ChartObject;
import lt.monarch.chart.SimpleChartDataModel2D;
import lt.monarch.chart.chart2D.Axis2D;
import lt.monarch.chart.chart2D.Axis2DX;
import lt.monarch.chart.chart2D.Axis2DY;
import lt.monarch.chart.chart2D.BarSeries;
import lt.monarch.chart.chart2D.Chart2D;
import lt.monarch.chart.mapper.LabelAxisMapper;
import lt.monarch.chart.mapper.MathAxisMapper;
import lt.monarch.chart.swing.JChartPanel;
import lt.monarch.chart.view.ToolTipManager;

/**
 * TODO document BarChart, take a ResourceAccessor for localization either here
 * or higher up<br>
 * 
 * @author Amit Bansil
 * @version $Id$
 */
public class BarChart implements ComponentProxy{
    // ------------------------------------------------------------------------
    // members
    // ------------------------------------------------------------------------
    private final MathAxisMapper yMapper;
    private final LabelAxisMapper xMapper;

    private final JChartPanel panel;

    private final Axis2DX axisX;

    private final Axis2DY axisY;

    private final Chart2D chart;
    private final SimpleChartDataModel2D barModel;

    /**
     * @return component holding chart
     */
    public JComponent getComponent() {
        return panel;
    }

    // ------------------------------------------------------------------------
	// constrcutor
	// ------------------------------------------------------------------------
	public BarChart() {
		chart = new Chart2D();
		// OPTIMIZE use a custom data model
		barModel = new SimpleChartDataModel2D();

		yMapper = new MathAxisMapper(0,0);
		xMapper = new LabelAxisMapper();

		axisX = new Axis2DX(xMapper);
		axisY = new Axis2DY(yMapper);

		BarSeries barSeries = new BarSeries(barModel, axisX, axisY);

		barSeries.setFillColor(Color.blue);

		chart.setObjects(new ChartObject[]{axisX, axisY, barSeries});
		chart.setLeftYAxis(axisY);
		chart.setXAxis(axisX);
		
		// tooltip inspection of points
		chart.addPlugin(new ToolTipManager());

		axisY.setTitlePosition(Axis2D.TITLE_POSITION_BELOW);
		axisX.setTitlePosition(Axis2D.TITLE_POSITION_BELOW);

		final Link backgroundLink = new Link() {
			@Override public void signal(EventObject event) {
				panel.setBackground(CELESTLook.getInstance().getWhiteColor());
			}
		};
		panel = new JChartPanel(chart) {
			@Override public synchronized void addNotify() {
				super.addNotify();
				DataUtils.linkAndSync(CELESTLook.getInstance().getChangeSupport(),
					backgroundLink);
			}

			@Override public synchronized void removeNotify() {
				super.removeNotify();
				CELESTLook.getInstance().getChangeSupport().disconnect(backgroundLink);
			}
		};
	}

    public final void setTitles(String xTitle, String yTitle) {
        axisX.setTitle(xTitle);
        axisY.setTitle(yTitle);
        panel.revalidate();
        panel.repaint();
    }
    private boolean yAuto;
    public final void setYAuto(boolean v) {
		if (yAuto == v) return;
		this.yAuto = v;
		recomputeRange();
	}
    private float yMin,yMax;
    public final void setYRange(float yMin,float yMax) {
        boolean update = !yAuto && ( yMax != this.yMax || yMin != this.yMin);
    	    this.yMax = yMax;
    	    this.yMin = yMin;
    	    if (update) recomputeRange();
    }
    private final void recomputeRange() {
    	    if(yAuto) {
    	    	    float min=Float.MAX_VALUE,max=Float.MIN_VALUE;
		    //OPTIMIZE move computation into simpler data model
		    final int n=barModel.getValueCount();
		    if(n==0) {
		    	    yMapper.setRange(0, 0);
			    return;
		    }
		    for(int i=0;i<n;i++) {
			    float v=((Number)barModel.getYValueAt(n)).floatValue();
			    if(v<min)min=v;
			    if(v>max)max=v;
		    }
		    yMapper.setRange(min, max);
	    } else {
		    yMapper.setRange(yMin, yMax);
	    }
    }

   	/**
	 * @throws IllegalArgumentException
	 *             if <code>xValues.length!=yValues.length</code>
	 */
    public void setData(String[] xLabels,Number[] yValues) {
        if(xLabels.length!=yValues.length)
		    throw new IllegalArgumentException("xLabels.length!=yValues.length");

    	    barModel.removeAll();
    	    xMapper.unregisterAll();
    	    barModel.addAll(xLabels, yValues);
    	    xMapper.registerKeys(xLabels);
    	
    	    if (yAuto) recomputeRange();
    }

}
