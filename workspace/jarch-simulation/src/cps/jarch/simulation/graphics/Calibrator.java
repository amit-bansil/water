/*
 * Calibrator.java
 * CREATED:    Jun 16, 2005 3:29:09 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-brightness
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.simulation.graphics;

import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.ConvertedValue;
import cps.jarch.data.value.tools.Converter;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.gui.data.PreferenceBinder;

import java.awt.Color;

/**
 * Converts floats representing intensities to colors based on properties of
 * screen. State is bound to preferences. Singleton. extra care must be taken
 * when listening to this objects properties since they are static and thus
 * unremoved listeners will never be gc'd.
 *
 *
 * @author Amit Bansil
 */
//TODO move CalibrationEditor here and ref it
// @see edu.bu.cps.celest.brightness.canvas.CalibrationEditor
public class Calibrator {
	public static Calibrator getInstance() {
		return INSTANCE;
	}

	private static final Calibrator INSTANCE = new Calibrator();

	private Calibrator() {
		PreferenceBinder prefs = PreferenceBinder
			.createSystemBinder(Calibrator.class);
		prefs.bind(ConvertedValue.floatToString(gamma()), "gamma");
		// binds black level converting from color->int->string
		prefs.bind(ConvertedValue.create(
			Converter.createCompositeConverter(new Converter<Color, Integer>(
				false, true, true) {
				@Override
				protected Integer _convert(Color in) throws ConversionException {
					return in.getRGB();
				}

				@Override
				protected Color _unconvert(Integer out)
						throws ConversionException {
					return new Color(out);
				}
			}, Converter.createReflectiveStringConverter(Integer.class, false)),
			blackLevel()), "blackLevel");
		prefs.bind(ConvertedValue.booleanToString(calibrationSet()),
			"calibrationSet");
	}

	/**
	 * determines the color corresponding to a particular intensity represented
	 * by a float in [0,100] given the curren calibration settings.
	 */
	// OPTIMIZE could reduce to just an array lookup,
	// setting the array to null whenever blacklevel or gamma changes
	// and lazily recalculating on get color
    public Color toColor(float intensity) {

		// get intensity in [0,1]
		float v = intensity / 100.0f;

		// apply gamma correction first
		// since blacklevel is determined for uncorrected colors
        //noinspection NonReproducibleMathCall
        v = (float) Math.pow(v, 1 / gamma.get());

		// scale to [blackevel,1]
		float blacklevel = getBlackLevelFloat();
		v *= 1 - blacklevel;// first [0,1-blacklevel]
		v += blacklevel;// now [blacklevel,1]

		return new Color(v, v, v);
	}

	// represents black level as a float in [0,1], lazily cached.
	private Color oldBlackLevelColor = null;

	private float oldBlackLevelFloat = -1;

	private final float getBlackLevelFloat() {
		// lazy cache, intentionally uses == for speed
		if (oldBlackLevelColor == blackLevel.get()) return oldBlackLevelFloat;

		oldBlackLevelColor = blackLevel.get();

		return oldBlackLevelFloat = (oldBlackLevelColor.getBlue()
				+ oldBlackLevelColor.getRed() + oldBlackLevelColor.getGreen())
				/ (255.0f * 3.0f);
	}

	// TODO vary default according to platform
	public static final float DEFAULT_GAMMA = 2.2f;

	public static final Color DEFAULT_BLACK_LEVEL = new Color(0.05f, 0.05f, 0.05f);

	private final RWValueImp<Float> gamma = new RWValueImp<Float>(
		DEFAULT_GAMMA, false);

	private final RWValueImp<Color> blackLevel = new RWValueImp<Color>(
		DEFAULT_BLACK_LEVEL, false);

	private final RWValueImp<Boolean> calibrationSet = new RWValueImp<Boolean>(
		Boolean.FALSE);

	/**
	 * this is the error the monitor is making.
	 */
	public final RWValue<Float> gamma() {
		return gamma;
	}

	/**
	 * The brightest uncorrected color intensity not disginuishable from
	 * Color.BLACK. Should be a shade of gray.
	 */
	public final RWValue<Color> blackLevel() {
		return blackLevel;
	}

	/**
	 * should be set true iff the user has chosen gamm&blacklevel.
	 */
	public final RWValue<Boolean> calibrationSet() {
		return calibrationSet;
	}
}
