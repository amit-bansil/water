/*
 * CREATED ON:    Aug 11, 2005 10:02:07 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.graphics;

import cps.jarch.data.io.CompositeDataBuilder;
import cps.jarch.data.io.SaveableData;
import cps.jarch.data.io.SaveableDataProxy;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;

import java.awt.Color;
import java.awt.Font;

/**
 * A {link cps.jarch.simulation.graphics.GraphicsConfiguration) backed
 * by bound properties.<br>
 * @version $Id: FullGraphicsModel.java 523 2005-08-30 21:31:54Z bansil $
 * 
 * @author Amit Bansil
 */

//THIS IS GETTING ULGY FAST
//better way is to have a table and string keys (for easy extensibility)
//THE idea of table driven data models is really really good...
public class FullGraphicsModel implements GraphicsConfiguration,SaveableDataProxy {
	public FullGraphicsModel() {
		CompositeDataBuilder dataBuilder=new CompositeDataBuilder(8);
		dataBuilder.regChild(titleFont,"titleFont");
		dataBuilder.regChild(labelFont,"labelFont");
		dataBuilder.regChild(thinStrokeWidth,"thinStrokeWidth");
		dataBuilder.regChild(stdStrokeWidth,"stdStrokeWidth");
		dataBuilder.regChild(thickStrokeWidth,"thickStrokeWidth");
		dataBuilder.regChild(exThickStrokeWidth,"exThickStrokeWidth");
		dataBuilder.regChild(smallHandleSize,"smallHandleSize");
		dataBuilder.regChild(largeHandleSize,"largeHandleSize");
		dataBuilder.regChild(backgroundColor,"backgroundColor");
		dataBuilder.regChild(foregroundColor,"foregroundColor");
		dataBuilder.regChild(disabledColor,"disabledColor");
		dataBuilder.regChild(activeColor,"activeColor");
		data=dataBuilder.create();
	}
	private final SaveableData data;
	public SaveableData getData() {
		return data;
	}
	// ------------------------------------------------------------------------
	// font
	
	// titleFont
	private final RWValueImp<Font> titleFont = new RWValueImp<Font>(null);

	/**
	 * Font to use for drawing titles.<br>
	 * It is a nullable object of type: Font.<br>
	 * Initial Value: null<br>
	 * 
	 * @return RWValue access to titleFont, constant.
	 */
	public final RWValue<Font> titleFont() {
		return titleFont;
	}

	// labelFont
	private final RWValueImp<Font> labelFont = new RWValueImp<Font>(null);

	// ------------------------------------------------------------------------
	// strokeWidth
	
	/**
	 * Font to use for drawing labels.<br>
	 * It is a non-null object of type: Font.<br>
	 * Initial Value: null<br>
	 * 
	 * @return RWValue access to labelFont, constant.
	 */
	public final RWValue<Font> labelFont() {
		return labelFont;
	}

	// thinStrokeWidth
	private final RWValueImp<Double> thinStrokeWidth = new RWValueImp<Double>(.5);

	/**
	 * width of hair line strokes.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: .5f<br>
	 * 
	 * @return RWValue access to thinStrokeWidth, constant.
	 */
	public final RWValue<Double> thinStrokeWidth() {
		return thinStrokeWidth;
	}

	// stdStrokeWidth
	private final RWValueImp<Double> stdStrokeWidth = new RWValueImp<Double>(1d);

	/**
	 * width of standard strokes.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: 1<br>
	 * 
	 * @return RWValue access to stdStrokeWidth, constant.
	 */
	public final RWValue<Double> stdStrokeWidth() {
		return stdStrokeWidth;
	}

	// thickStrokeWidth
	private final RWValueImp<Double> thickStrokeWidth = new RWValueImp<Double>(2d);

	/**
	 * width of thick strokes.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: 2<br>
	 * 
	 * @return RWValue access to thickStrokeWidth, constant.
	 */
	public final RWValue<Double> thickStrokeWidth() {
		return thickStrokeWidth;
	}

	// exThickStrokeWidth
	private final RWValueImp<Double> exThickStrokeWidth 
		= new RWValueImp<Double>(2d);

	// ------------------------------------------------------------------------
	// handle size
	
	/**
	 * Stroke width of extra thick lines. Usually for selected objects.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: 2d<br>
	 * 
	 * @return RWValue access to exThickStrokeWidth, constant.
	 */
	public final RWValue<Double> exThickStrokeWidth() {
		return exThickStrokeWidth;
	}
	// smallHandleSize
	private final RWValueImp<Double> smallHandleSize = new RWValueImp<Double>(4d);

	/**
	 * size of small Handles.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: 4d<br>
	 *
	 * @return RWValue access to smallHandleSize, constant.
	 */
	public final RWValue<Double> smallHandleSize() {
		return smallHandleSize;
	}
	// largeHandleSize
	private final RWValueImp<Double> largeHandleSize = new RWValueImp<Double>(8d);

	/**
	 * size of large Handles.<br>
	 * It is a non-null object of type: Double.<br>
	 * Initial Value: 8d<br>
	 *
	 * @return RWValue access to largeHandleSize, constant.
	 */
	public final RWValue<Double> largeHandleSize() {
		return largeHandleSize;
	}
	
	// ------------------------------------------------------------------------
	// colors
	
	//backgroundColor
	private final RWValueImp<Color> backgroundColor = new RWValueImp<Color>(null);

	/**
	 * background color.<br>
	 * It is a non-null object of type: Color.<br>
	 * Initial Value: null<br>
	 *
	 * @return RWValue access to backgroundColor, constant.
	 */
	public final RWValue<Color> backgroundColor() {
		return backgroundColor;
	}
	//foregroundColor
	private final RWValueImp<Color> foregroundColor = new RWValueImp<Color>(null);

	/**
	 * foreground color. usually black.<br>
	 * It is a non-null object of type: Color.<br>
	 * Initial Value: null<br>
	 *
	 * @return RWValue access to foregroundColor, constant.
	 */
	public final RWValue<Color> foregroundColor() {
		return foregroundColor;
	}
	//disabledColor
	private final RWValueImp<Color> disabledColor = new RWValueImp<Color>(null);

	/**
	 * color of disabled objects. good default is average of
	 * background&foreground color.<br>
	 * It is a nullable object of type: Color.<br>
	 * Initial Value: null<br>
	 * 
	 * @return RWValue access to disabledColor, constant.
	 */
	public final RWValue<Color> disabledColor() {
		return disabledColor;
	}
	//activeColor
	private final RWValueImp<Color> activeColor = new RWValueImp<Color>(null);
	/**
	 * Color for objects that are active, or significant.<br>
	 * It is a nullable object of type: Color.<br>
	 * Initial Value: null<br>
	 *
	 * @return RWValue access to activeColor, constant.
	 */
	public final RWValue<Color> activeColor() {
		return activeColor;
	}
	// ------------------------------------------------------------------------
	//GraphicsConfiguration implementation
	
	public Font getTitleFont() {
		return titleFont.get();
	}
	public Font getLabelFont() {
		return labelFont.get();
	}
	public Double getThinStrokeWidth() {
		return thinStrokeWidth.get();
	}
	public Double getThickStrokeWidth() {
		return thickStrokeWidth.get();
	}
	public Double getExtraThickStrokeWidth() {
		return exThickStrokeWidth.get();
	}
	public Double getStdStrokeWidth() {
		return stdStrokeWidth.get();
	}
	public Double getSmallHandleSize() {
		return smallHandleSize.get();
	}
	public Double getLargeHandleSize() {
		return largeHandleSize.get();
	}
	public Color getBackgroundColor() {
		return backgroundColor.get();
	}
	public Color getForegroundColor() {
		return foregroundColor.get();
	}
	public Color getDisabledColor() {
		return disabledColor.get();
	}
	public Color getActiveColor() {
		return activeColor.get();
	}	
}
