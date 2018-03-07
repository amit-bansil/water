/*
 * AlloyLook.java
 * CREATED:    Jun 26, 2005 1:00:12 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.components;

import com.incors.plaf.alloy.AlloyCommonBorderFactory;
import com.incors.plaf.alloy.AlloyLookAndFeel;
import com.incors.plaf.alloy.AlloyTheme;
import com.incors.plaf.alloy.themes.bedouin.BedouinTheme;
import com.incors.plaf.alloy.themes.custom.CustomThemeFactory;
import com.incors.plaf.alloy.themes.glass.GlassTheme;

import cps.jarch.util.misc.LogEx;

import javax.swing.AbstractButton;
import javax.swing.BorderFactory;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import java.awt.Color;
import java.awt.Font;

/**
 * ecapsulates the alloy look&feel. may throw classnotfoundexception on access
 * if alloy library is not present.
 */
final class AlloyLook extends CELESTLook{
	private static final LogEx<AlloyLook> log = LogEx
		.createClassLog(AlloyLook.class);

	private final AlloyLookAndFeel alloyLNF;

	@SuppressWarnings("unused")
	public AlloyLook(){
		//use native dialogs on os x only
		if(CELESTLook.getOS()!=CELESTLook.OS.OSX) {
			JFrame.setDefaultLookAndFeelDecorated(true);
			JDialog.setDefaultLookAndFeelDecorated(true);
		}
		// register
		com.incors.plaf.alloy.AlloyLookAndFeel.setProperty("alloy.licenseCode",
			"u#Amit_Bansil#i30hb#d7jx00");

		// needed to make JWS work properly
		javax.swing.UIManager.getLookAndFeelDefaults().put("ClassLoader",
			CELESTLook.class.getClassLoader());
		// install alloy
		alloyLNF = new AlloyLookAndFeel(getTheme());
		try {
			UIManager.setLookAndFeel(alloyLNF);
		} catch (UnsupportedLookAndFeelException e) {
			// should not happen
			throw new Error(e);
		}
	}

	@Override
	protected Font loadTitleFont() {
		return AlloyLookAndFeel.getWindowTitleFont();
	}

	@Override
	public Color getWhiteColor() {
		if (isDimmed) return DIM_WHITE;
		else return Color.WHITE;
	}

	@Override
	public void makeToolbarStyle(AbstractButton b) {
		b.setBorder(BorderFactory.createCompoundBorder(AlloyCommonBorderFactory
			.createStandardComponentBorder(), BorderFactory.createEmptyBorder(
			0, 1, 0, 0)));
		super.makeToolbarStyle(b);
	}

	// ------------------------------------------------------------------------
	// dimming
	boolean isDimmed = false;

	private static final Color DIM_WHITE = new Color(140, 140, 140);

	// creates a muted alloytheme
	private AlloyTheme dimTheme = null, glassTheme = null;

	private final AlloyTheme getTheme() {
		/*if (isDimmed) {
			if (dimTheme == null) {
				// define colors
				Color contrast = new Color(31, 31, 31);
				Color standard = new Color(60, 60, 60);
				Color desktop = new Color(31, 31, 31);
				Color selection = new Color(0, 70, 144);
				Color rollover = new Color(0, 70, 144);
				Color highlight = new Color(0, 70, 144);

				// create custom theme
				dimTheme = CustomThemeFactory.createTheme(contrast, standard,
					desktop, selection, rollover, highlight);
			}
			return dimTheme;
		} else {
			if (glassTheme == null) {
				glassTheme = new GlassTheme();
			}
			return glassTheme;
		}*/
		return new BedouinTheme();
	}

	@Override
	public boolean isDimmed() {
		return isDimmed;
	}

	/**
	 * sets the L&F to use dimming and applies to all components below root as
	 * well as any new components/registered listenres.
	 */
	@Override
	public void trySetDimmed(boolean v) {
		if (isDimmed == v) return;
		isDimmed = v;
		alloyLNF.setTheme(getTheme(), true);
		log.info("dimmed set:value={0}", v);
		notifyUIDefaultsChanged();
	}
}