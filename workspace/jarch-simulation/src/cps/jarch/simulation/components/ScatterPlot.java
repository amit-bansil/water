/*
 * MeasurementPlot.java
 * CREATED:    Jan 13, 2005 8:46:22 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.simulation.components;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.DataUtils;
import cps.jarch.gui.components.CELESTLook;
import lt.monarch.chart.AbstractChartDataModel;
import lt.monarch.chart.ChartDataModel2D;
import lt.monarch.chart.ChartObject;
import lt.monarch.chart.chart2D.Axis2D;
import lt.monarch.chart.chart2D.Axis2DX;
import lt.monarch.chart.chart2D.Axis2DY;
import lt.monarch.chart.chart2D.Chart2D;
import lt.monarch.chart.chart2D.ConnectedSeries;
import lt.monarch.chart.chart2D.ScatterSeries;
import lt.monarch.chart.mapper.MathAxisMapper;
import lt.monarch.chart.marker.SquareMarker;
import lt.monarch.chart.swing.JChartPanel;
import lt.monarch.chart.view.ToolTipManager;

import java.awt.Color;
import java.awt.Component;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.List;

/**
 * scatter plot of a series of values. optional regression line can be shown
 * 
 * TODO allow disabling regression and different (pluggable?) regression
 * algorithims TODO don't dot out last 100 <br>
 * 
 * @version 1.1 switched to linreg. <br>
 * @version 1.0
 * @author Amit Bansil
 */
public class ScatterPlot {
    // ------------------------------------------------------------------------
    // members
    // ------------------------------------------------------------------------
    private final MathAxisMapper yMapper, xMapper;

    private final JChartPanel panel;

    private final MeasurementDataModel measurementModel;

    private final RegressionDataModel regressionModel;

    /**
     * @return component holding chart
     */
    public Component getComponent() {
        return panel;
    }

    // ------------------------------------------------------------------------
    // constrcutor
    // ------------------------------------------------------------------------

    // private final double xMax,yMax;
    // TODO too many args here,use res
    private final Axis2DX axisX;

    private final Axis2DY axisY;

    private final Chart2D chart;


    // TODO simplify constructor even more
    public ScatterPlot(double xMax, double yMax) {
        chart = new Chart2D();

        // this.xMax=xMax;
        // this.yMax=yMax;

        measurementModel = new MeasurementDataModel();
        regressionModel = new RegressionDataModel(xMax);

        yMapper = new MathAxisMapper(0, yMax);
        xMapper = new MathAxisMapper(0, xMax);
        // xMapper.getViewRange().setRange (0, 1);
        // yMapper.getViewRange().setRange (0, 1);

        axisX = new Axis2DX(xMapper);
        axisY = new Axis2DY(yMapper);

        ConnectedSeries regressionSeries = new ConnectedSeries(regressionModel, axisX, axisY);
        regressionSeries.setShowNullValues(false);// UNCLEAR what does
        regressionSeries.setFillColor(null);
        ScatterSeries measurementSeries = new ScatterSeries(measurementModel,
            axisX, axisY);

        measurementSeries.showMarkers(new SquareMarker());// TODO scale
        // marker based
        // on plot
        // size...
        measurementSeries.setLineColor(Color.blue);

        chart.setObjects(new ChartObject[]{axisX, axisY, measurementSeries,
                regressionSeries});
        chart.setLeftYAxis(axisY);
        chart.setXAxis(axisX);
        // tooltip inspection of points
        chart.addPlugin(new ToolTipManager());

        axisY.setTitlePosition(Axis2D.TITLE_POSITION_BELOW);
        axisX.setTitlePosition(Axis2D.TITLE_POSITION_BELOW);

        // LabeledChart topChart = new LabeledChart(chart);
        // topChart.setTitle(title);
        final Link backgroundLink = new Link() {
            @Override public void signal(EventObject event) {
                panel.setBackground(CELESTLook.getInstance().getWhiteColor());
            }
        };
        panel = new JChartPanel(chart) {
            @Override
            public synchronized void addNotify() {
                super.addNotify();
                DataUtils.linkAndSync(CELESTLook.getInstance()
                    .getChangeSupport(), backgroundLink);
            }

            @Override
            public synchronized void removeNotify() {
                super.removeNotify();
                CELESTLook.getInstance().getChangeSupport().disconnect(
                    backgroundLink);
            }
        };
        // panel.;
        /*
           * // We have to explicitly assign a hot spot map if we want // the
           * tooltip plugin to work correctly. The default hot // spot map does
           * not gather any hot spot information panel.setHotSpotMap(new
           * SimpleHotSpotMap());
           */
    }

    public final void setTitles(String xTitle, String yTitle) {
        axisX.setTitle(xTitle);
        axisY.setTitle(yTitle);
        panel.revalidate();
        panel.repaint();
    }

    // ------------------------------------------------------------------------
    // record
    // ------------------------------------------------------------------------

    /**
     * removes all measurements, resets regression
     */
    public void reset() {
        measurementModel.reset();
        regressionModel.reset();
    }

    /**
     * records a new measurement on the plot & updates regression
     *
     * @param x
     * @param y
     */
    public void recordMeasurement(Double x, Double y) {
        // OPTIMIZE only fire one event???
        measurementModel.record(x, y);
        regressionModel.record(x, y);
    }

    // ------------------------------------------------------------------------
    // regression
    // ------------------------------------------------------------------------
    public final boolean isRegressionVisible() {
        return regressionModel.isRegressionVisible();
    }

    public final void setRegressionVisible(boolean regressionVisible) {
        regressionModel.setRegressionVisible(regressionVisible);
    }

    public Double getRegressionIntercept() {
        return regressionModel.getRegressionIntercept();
    }

    public boolean isRegressionValid() {
        return regressionModel.isResultsValid();
    }

    public Double getRegressionSlope() {
        return regressionModel.getRegressionSlope();
    }

    // TODO abstract line drawing from regression calc
    // this is a line from 0 to 1
    //TODO lets not delegate so much to this, instead
    //create a simpler interface that we can return.
//    @SuppressWarnings({"ClassWithTooManyFields"})
    private static final class RegressionDataModel extends
            AbstractChartDataModel implements ChartDataModel2D {
        private final Double xMax;

        private boolean regressionVisible;

        public final boolean isRegressionVisible() {
            return regressionVisible;
        }

        public final void setRegressionVisible(boolean regressionVisible) {
            if (this.regressionVisible == regressionVisible) return;
            this.regressionVisible = regressionVisible;
            fireModelChanged();
        }

        public RegressionDataModel(double xMax) {
            this.xMax = xMax;
            reset();
        }

        // ------------------------------------------------------------------------
        // record
        // ------------------------------------------------------------------------
        // regression variables
        private double sumxx, sumyy, sumxy, sumx, sumy;

        private int numberPlotPoints;

        private boolean resultsValid = false;

        private Double yAtXMax, yAtXMin, slopeD, interceptD;


        public void record(Double x, Double y) {
            // update variables
            numberPlotPoints++;
            sumx += x;
            sumy += y;
            sumxx += x * x;
            sumyy += y * y;
            sumxy += x * y;

            // don't try if we only have 1 point
            resultsValid = numberPlotPoints > 1;
            if (!resultsValid) return;

            // recalc results
            //noinspection OverlyComplexArithmeticExpression
            double slope = (sumxy - sumx * sumy / numberPlotPoints)
                    / (sumxx - sumx * sumx / numberPlotPoints);
            double intercept = (sumy - slope * sumx) / numberPlotPoints;
            slopeD = slope;
            interceptD = intercept;
            yAtXMax = intercept + slope * xMax;
            yAtXMin = interceptD;
            fireModelChanged();
        }

        public void reset() {
            numberPlotPoints = 0;
            sumxx = 0;
            sumyy = 0;
            sumxy = 0;
            sumx = 0;
            sumy = 0;
            resultsValid = false;
            fireModelChanged();
        }

        // ------------------------------------------------------------------------
        // results
        // ------------------------------------------------------------------------
        public double getRegressionSlope() {
            checkValid();
            return slopeD;
        }

        public double getRegressionIntercept() {
            checkValid();
            return interceptD;
        }

        public boolean isResultsValid() {
            return resultsValid;
        }

        private final void checkValid() {
            if (!resultsValid)
                throw new IllegalStateException("slope not valid");
        }

        // ------------------------------------------------------------------------
        // values
        // ------------------------------------------------------------------------
        // access to control points used to draw reg. line
        public int getValueCount() {
            //since removeObject causes NPE
            //to make regression invisible we just return 0 here
            if (!resultsValid||!regressionVisible) return 0;
            else return 2;
        }


        public Object getXValueAt(int n) {
            checkValid();// UNCLEAR is it better to return null?
            if (n == 0) return ZEROD;
            else if (n == 1) return xMax;
            else throw new IllegalArgumentException(
                "only 2 points in this regression");
        }

        public Object getYValueAt(int n) {
            checkValid();// UNCLEAR is it better to return null
            if (n == 0) return yAtXMin;
            else if (n == 1) return yAtXMax;
            else throw new IllegalArgumentException(
                "only 2 points in this regression");
        }
    }
    private static final Double ZEROD = (double) 0;
    // ------------------------------------------------------------------------
    // measurements
    // ------------------------------------------------------------------------
    private final class MeasurementDataModel extends AbstractChartDataModel
            implements ChartDataModel2D {
        // OPTIMIZE presize lists
        private final List<Double> xvalues = new ArrayList<Double>(),
                yvalues = new ArrayList<Double>();

        public void record(Double x, Double y) {
            xvalues.add(x);
            yvalues.add(y);

            if (xvalues.isEmpty()) {
                xMapper.setRange(x, x);
                yMapper.setRange(y, y);
            } else {
                xMapper.updateRange(x);
                yMapper.updateRange(y);
            }
            // OPTIMIZE everything isn't changed
            fireModelChanged();
        }

        public void reset() {
            xvalues.clear();
            yvalues.clear();
            xMapper.setRange(0, 1);
            yMapper.setRange(0, 1);
            fireModelChanged();
        }

        public int getValueCount() {
            assert xvalues.size() == yvalues.size();
            return xvalues.size();
        }

        public Object getXValueAt(int n) {
            return xvalues.get(n);
        }

        public Object getYValueAt(int n) {
            return yvalues.get(n);
        }

    }

}
