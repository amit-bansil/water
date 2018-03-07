/*
 * LaFManager.java
 * CREATED:    Sep 10, 2003 4:17:18 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.core;

import org.cps.framework.core.gui.event.GuiEventUtils;

import com.incors.plaf.alloy.AlloyLookAndFeel;
import com.incors.plaf.alloy.AlloyTheme;
import com.incors.plaf.alloy.themes.glass.GlassTheme;

import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JPopupMenu;
import javax.swing.LookAndFeel;
import javax.swing.ToolTipManager;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

import java.util.Date;
import java.util.GregorianCalendar;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class DefaultLaFLoader extends LaFLoader {
	private boolean loaded = false;

	public void setupUI() {
		GuiEventUtils.checkThread();
		//only allow one call??
		if (loaded) return;
		loaded = true;

		if (new Date(System.currentTimeMillis()).before(new GregorianCalendar(
				2004, 9, 17).getTime())) {
			//load AlloyL&F-note that this will die in september
			com.incors.plaf.alloy.AlloyLookAndFeel.setProperty(
					"alloy.licenseCode",
					"2004/09/18#bansil@argento.bu.edu#1hklvhx#1cjoe0");
			try {
				AlloyTheme theme = new GlassTheme();
				LookAndFeel alloyLnF = new AlloyLookAndFeel(
						theme);
				UIManager.setLookAndFeel(alloyLnF);
			} catch (UnsupportedLookAndFeelException ex) {
				//should not happen
				throw new Error(ex);
			}
		} else {
			//todo log
			System.err.println("alloy l&f liscence expired, using native");
			try {
				//native lookandfeel
				UIManager.setLookAndFeel(UIManager
						.getSystemLookAndFeelClassName());
			} catch (Exception e) {
				//should not happen
				throw new Error(e);
			}
		}
		//make popups heavwheight
		JPopupMenu.setDefaultLightWeightPopupEnabled(false);
		ToolTipManager.sharedInstance().setLightWeightPopupEnabled(false);
		//decorate frames TODO this should only be for VMDL2
		JFrame.setDefaultLookAndFeelDecorated(true);
		JDialog.setDefaultLookAndFeelDecorated(true);

		/*
		 * mpt used... ////change splitter UI borders to be invisible--use
		 * object array???? UIManager.put("SplitPaneUI",
		 * BasicSplitPaneUI.class.getName());
		 * UIManager.put("SplitPaneDivider.border", EMPTY_BORDER);
		 * UIManager.put("SplitPane.border", EMPTY_BORDER); //UIClasses //ui
		 * defaults Color textBack = UIManager.getColor("TextPane.background"),
		 * textFore = UIManager.getColor("Label.foreground"); Font textFont =
		 * UIManager.getFont("Label.font"); //install deafult for form contentUI
		 * //UIManager.put("FormDialogContentUI",
		 * FormContentUI.class.getName());
		 * UIManager.put("FormContentUI.content.border", LARGE_BORDER);
		 * UIManager.put("FormContentUI.basebar.border", LARGE_BORDER);
		 * 
		 * //UIManager.put("FormHeaderUI", FormHeaderUI.class.getName());
		 * UIManager.put( "FormHeaderUI.border",
		 * BorderFactory.createEmptyBorder(0, -2, 0, -2));
		 * UIManager.put("FormHeaderUI.background", textBack);
		 * UIManager.put("FormHeaderUI.foreground", textFore);
		 * UIManager.put("FormHeaderUI.font", textFont);
		 * UIManager.put("FormHeaderUI.note.background", textBack);
		 * UIManager.put("FormHeaderUI.note.foreground", textFore);
		 * UIManager.put("FormHeaderUI.note.font", textFont);
		 * UIManager.put("FormHeaderUI.note.border", MED_BORDER);-
		 */
	}
	//ui defaults
	/*
	 * private static final int MED_GAP = 6, LARGE_GAP = 12; private static
	 * final Border EMPTY_BORDER = createBorder(0), MED_BORDER =
	 * createBorder(MED_GAP), LARGE_BORDER = createBorder(LARGE_GAP); private
	 * static final Border createBorder(int borderSize) { return
	 * BorderFactory.createEmptyBorder( borderSize, borderSize, borderSize,
	 * borderSize); }
	 */

}