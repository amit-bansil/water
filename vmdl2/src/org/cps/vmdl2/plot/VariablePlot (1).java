/*
 * VariablePlot.java
 * CREATED:    Aug 27, 2004 9:53:52 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.vmdl2.plot;

import org.cps.framework.core.gui.event.GuiEventUtils;

import com.kataba.coll.GapListRW;

import java.awt.Color;
import java.awt.Component;

import lt.monarch.chart.AbstractChartDataModel;
import lt.monarch.chart.ChartDataModel2D;
import lt.monarch.chart.ChartDataModelAnnotations;
import lt.monarch.chart.ChartObject;
import lt.monarch.chart.SimpleHotSpotMap;
import lt.monarch.chart.chart2D.Axis2D;
import lt.monarch.chart.chart2D.Axis2DX;
import lt.monarch.chart.chart2D.Axis2DY;
import lt.monarch.chart.chart2D.BoxZoomer;
import lt.monarch.chart.chart2D.Chart2D;
import lt.monarch.chart.chart2D.ConnectedSeries;
import lt.monarch.chart.chart2D.HorizontalMarkerLine;
import lt.monarch.chart.chart2D.MarkerLine;
import lt.monarch.chart.chart2D.ScrollableAxis2DX;
import lt.monarch.chart.chart2D.ScrollableAxis2DY;
import lt.monarch.chart.mapper.ScrollableMathAxisMapper;
import lt.monarch.chart.swing.JChartPanel;
import lt.monarch.chart.view.LabeledChart;
import lt.monarch.chart.view.ToolTipManager;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class VariablePlot {
	private final ScrollableMathAxisMapper yMapper, xMapper;

	private final JChartPanel panel;

	private final MarkerLine line;

	private final MathChartDataModel2D model;

	public VariablePlot(int maxSize, String xTitle, String yTitle,
			String pName, String title) {
		GuiEventUtils.checkThread();
		Chart2D chart = new Chart2D();

		model = new MathChartDataModel2D(maxSize);

		yMapper = new ScrollableMathAxisMapper(0, 1);
		xMapper = new ScrollableMathAxisMapper(0, 1);
		//xMapper.getViewRange().setRange (0, 1);
		//yMapper.getViewRange().setRange (0, 1);

		Axis2DX axisX = new ScrollableAxis2DX(xMapper);
		Axis2DY axisY = new ScrollableAxis2DY(yMapper);

		axisX.setTitle(xTitle);
		axisY.setTitle(yTitle);

		BoxZoomer zoomer = new BoxZoomer(xMapper, yMapper);
		zoomer.enableDigitization(axisX, null);
		chart.addPlugin(zoomer);

		//ConnectedSeries bspline=new SplineSeries (splineModel, axisX,
		// axisYL);
		ConnectedSeries connect = new ConnectedSeries(model, axisX, axisY);
		connect.setShowNullValues(false);
		//connect.showMarkers(new LabeledMarker(new SquareMarker()));

		//Grid grid = new Grid(new PlaneMapper2D(), xMapper, yMapper);

		line = new HorizontalMarkerLine(axisY);
		line.setLabel("Avg.");
		line.setLevel(new Double(0));
		line.setColor(Color.red);
		/*line.style.setFlag("label", "alignment",
				StylesheetConstants.ALIGN_RIGHT);
		line.style.setFlag("label", "orientation",
				StylesheetConstants.ORIENTATION_VERTICAL);*/

		//bspline.setLineColor (Color.red);
		//bspline.setFillColor (Color.lightGray);
		connect.setLineColor(Color.blue);
		//connect.setFillColor (Color.lightGray);

		chart.setObjects(new ChartObject[]{line, axisX, axisY, connect});
		chart.setLeftYAxis(axisY);
		chart.setXAxis(axisX);
		//chart.addPlugin (new MarkerSelector ());
		chart.addPlugin(new ToolTipManager());

		connect.setName(pName);
		//bspline.setName ("Spline");
		axisY.setTitlePosition(Axis2D.TITLE_POSITION_BELOW);

		//chart.style.setFlag ("zoomModifiers", InputEvent.BUTTON1_MASK);
		//chart.style.setFlag ("scrollModifiers", InputEvent.SHIFT_MASK |
		// InputEvent.BUTTON1_MASK);

		LabeledChart topChart = new LabeledChart(chart);
		topChart.setTitle(yTitle);

		/*
		 * Legend legend = new Legend(chart); legend.setMaxColumns(10);
		 * topChart.setBottomView(legend);
		 */

		panel = new JChartPanel(topChart);

		// We have to explicitly assign a hot spot map if we want
		// the tooltip plugin to work correctly. The default hot
		// spot map does not gather any hot spot information
		panel.setHotSpotMap(new SimpleHotSpotMap());
	}

	public Component getComponent() {
		GuiEventUtils.checkThread();
		return panel;
	}

	private double xMin = Double.MAX_VALUE, xMax = Double.MIN_VALUE,
			yMin = Double.MAX_VALUE, yMax = Double.MIN_VALUE;

	private double avg = 0, lastTime=0;

	public void addValue(double v, double time) {
		if(time<lastTime||time==0) {
			//reset hack
			model.clear();
			avg=lastTime=0;
			xMax=yMax=Double.MIN_VALUE;
			xMin=yMin=Double.MAX_VALUE;
		}
		model.addValue(time,v);
		
		boolean updateY = false, updateX = false;
		if (v > yMax) {
			yMax = v;
			updateY = true;
		}
		if (v < yMin) {
			yMin = v;
			updateY = true;
		}
		if (time > xMax) {
			xMax = time;
			updateX = true;
		}
		if (time < xMin) {
			xMin = time;
			updateX = true;
		}
		double x0=model.getX0();
		if(x0>xMin) {
			xMin=x0;
			updateX = true;
		}
		if (updateY) {
			yMapper.setRange(Math.min(yMin,yMax-1),Math.max(yMin+1,yMax));
		}
		if (updateX) {
			xMapper.setRange(Math.min(xMin,xMax+1),Math.max(xMax,yMin+1));
		}
		if(time-lastTime!=0) {
			avg = ((avg * lastTime) + (v*(time-lastTime))) / time;
			lastTime = time;
			//System.out.println(time+","+avg);
			line.setLevel(new Double(avg));
		}
		GuiEventUtils.checkThread();
	}

	private static final class MathChartDataModel2D extends
			AbstractChartDataModel implements ChartDataModel2D,
			ChartDataModelAnnotations {

		private final GapListRW dataX;

		private final GapListRW dataY;

		private int l = 0;

		private final int max_size;

		public MathChartDataModel2D(int max_size) {
			this.max_size = max_size;
			dataX = new GapListRW(max_size);
			dataY = new GapListRW(max_size);
		}
		public void clear() {
			l=0;
			dataX.clear();
			dataY.clear();
			fireModelChanged();
		}
		public int getValueCount() {
			return l;
		}
		public double getX0() {
			return ((Number)dataX.get(0)).doubleValue();
		}
		public Object getXValueAt(int pos) {
			return dataX.get(pos);
		}

		public Object getYValueAt(int pos) {
			return dataY.get(pos);
		}

		public String getDescriptionAt(int i) {
			return "(" + getXValueAt(i) + ", " + getYValueAt(i) + ")";
		}

		public final void addValue(double x, double y) {
			if (l < max_size) {
				l++;
			} else {
				dataX.remove(0);
				dataY.remove(0);
				/*fireModelChanged(new IndexedDataModelChangeEvent(this,
						IndexedDataModelChangeEvent.DELETED, 0, 0));*/
			}
			dataX.add(new Float(x));
			dataY.add(new Float(y));
			fireModelChanged(/*new IndexedDataModelChangeEvent(this,
					IndexedDataModelChangeEvent.INSERTED, l - 1, l - 1)*/);
		}

		public String getLabelAt(int i) {
			return null;
		}
	}
}