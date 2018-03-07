/*
 * CELESTLookAndFeel.java
 * CREATED:    Jan 22, 2005 6:38:46 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELEST-Framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.components;

import cps.jarch.data.event.tools.Source;
import cps.jarch.data.event.tools.SourceImp;
import cps.jarch.gui.resources.ImageLoader;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;

import javax.swing.AbstractButton;
import javax.swing.BorderFactory;
import javax.swing.Icon;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;
import javax.swing.plaf.UIResource;

import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.util.ArrayList;
import java.util.List;

/**
 * Manages the appearance of custom components. Uses either Alloy behind the
 * scenes or native look. This is a singleton which delegates its behavior to a
 * CELESTLook implementation that is setup for the current look and feel.<br>
 * Instead of returning font and color UIResources which are automatically
 * uninstalled/reinstalled by the LNF as it changes, the CELESTLook returns
 * standard Color and Font objects whose changes can be observed through
 * getColorChangeSupport(). Note that only colors and icons change dynamically.<BR>
 * TODO a lot of this functionality would do better in the ControlPanelBuilder
 * etc. classes which could delegate their behavior to L&F specific
 * implementations.
 * 
 * @author Amit Bansil
 */

// TODO binding changes is very awakard right now
// a better way would be to auto spider the component heirarchy, fixing borders
// and colors
// as you go, and marking components that will need to be updated when the
// colorscheme changes.
//@SuppressWarnings({"ClassWithTooManyFields", "ClassWithTooManyMethods"})
public abstract class CELESTLook {
	private static final LogEx<CELESTLook> log = LogEx
		.createClassLog(CELESTLook.class);

	private static final ImageLoader images=ImageLoader.create(CELESTLook.class);
	/**
	 * returns the current CELESTLook, a constant non-null singleton.
	 * 
	 * @throws IllegalStateException
	 *             if setup has not yet been called.
	 */
	public static final CELESTLook getInstance() {
		if (currentLook == null)
			throw new IllegalStateException("look not yet setup");
		return currentLook;
	}

	/**
	 * try to install AlloyLook if it is prefered and avabile, otherwise go
	 * native.
	 */
	public static final void setup() {
		if (preferredType == LookType.ALLOY) {
			try {
				currentLook = new AlloyLook();
				return;
			} catch (Throwable t) {
				log.warning(null,"alloy look could not be setup", t);
			}
		}
		currentLook = new NativeLook();
	}

	private static CELESTLook currentLook = null;

	/**
	 * sets the preferred type of Look that will be setup. This look will be
	 * installed if possible, but no gaurantees are made.
	 * 
	 * @throws IllegalStateException
	 *             if setup has already been called
	 */
	public static final void setPreferredType(LookType type) {
		LangUtils.checkArgNotNull(type);
		if (currentLook != null)
			throw new IllegalStateException("look already setup");
		log.debug("preferred type set:{0}", type);
		preferredType = type;
	}

	// the type of this LNF. purposely not reported since
	// clients should not depend on this info
	private static LookType preferredType = LookType.ALLOY;

	private static enum LookType {
		ALLOY, NATIVE
	}

	/**
	 * @return constant source that will send notification of any changes to
	 *         this object.
	 */
	public Source getChangeSupport() {
		return changeSupport;
	}

//	@SuppressWarnings({"ThisEscapedInObjectConstruction"})
    final SourceImp changeSupport = new SourceImp(this);

	/**
	 * Internal hook called when the UIDefaults table is changed. Implementors
	 * should clear any values that they have cached from that table and then
	 * call super.notifyUIDefaultsChanged(). The final action of this method is
	 * to notify any links connected to change support of the change.
	 */
	protected void notifyUIDefaultsChanged() {
		backgroundColor = null;
		paleSelectionColor = null;
		titleFont = null;
		updateOrphanUIs();
		changeSupport.sendEvent();
	}

	// ------------------------------------------------------------------------
	// Fonts & Colors
	// ------------------------------------------------------------------------
	private Font titleFont = null;

	public Font getTitleFont() {
		if (titleFont == null) titleFont = unResource(loadTitleFont());
		return titleFont;
	}

	protected abstract Font loadTitleFont();

	public abstract Color getWhiteColor();

	private Color backgroundColor;

	public Color getBackgroundColor() {
		// don't return UIResources since they are lost on change
		if (backgroundColor == null) {
			backgroundColor = getColor("Label.background");
		}
		return backgroundColor;
	}

	private Color paleSelectionColor = null;

	public Color getPaleSelectionColor() {
		if (paleSelectionColor == null) {
			paleSelectionColor = ColorUtils.mix(
				getColor("MenuItem.selectionBackground"), getWhiteColor(), 0.5f);
		}
		return paleSelectionColor;
	}

	// ------------------------------------------------------------------------
	// dimming
	public abstract boolean isDimmed();

	/**
	 * tries to set dimmed to v, and update c's heirarchy. nothing is done if
	 * v==isDimmed. check isDimmed to see if successfull. currently only
	 * alloyLook supports dimming.
	 */
	public abstract void trySetDimmed(boolean v);
	
	private final List<Component> orphans=new ArrayList<Component>();
	protected final void updateOrphanUIs() {
		for(Component c:orphans)SwingUtilities.updateComponentTreeUI(c);
	}
	/**
	 * marks c as an orphan; a component that is not part of an apps Component
	 * heirarchy but may be added to it later on. Does nothing if c is already
	 * an orphan. Used solely for L&F updates.
	 */
	public final void markOrphan(Component c) {
		orphans.add(c);
	}

	// TODO use weak references here so that orphans will be garbage collected.
	// TODO warn on uneccessary use
	// auto unmark orphan on add.
	/**
	 * removes orphan status from c because it HAS ALREADY BEEN added to the
	 * component heirarchy. Does nothing if c was not an orphan. Used solely for
	 * L&F updates.
	 */
	public final void unmarkOrphan(Component c) {
		orphans.remove(c);
	}

	// ------------------------------------------------------------------------
	// icons
	// ------------------------------------------------------------------------
	public static enum IconType {
		OPEN_HANDLE, CLOSE_HANDLE, PLUS, MINUS
	}

	// TODO change icons for different looks, use simple back icons
//	@SuppressWarnings({"MethodMayBeStatic"})
    public Icon getIcon(IconType type) {
		return images.loadIcon(type.name());
	}

	// ------------------------------------------------------------------------
	// Borders & Insets
	// ------------------------------------------------------------------------
	// TODO change for different looks
	// TODO this should make all components visually
	// seem to have a 1 pixel border around
	// them although, in reality, components with specular highlights have no
	// border, when this is the case the padding constants can be shrunk
	// may need to spider subtree here, and mark fixed components as fixed
	// so that we don'd di it twice
	/**
	 * corrects a components border
	 */
//	@SuppressWarnings({"MethodMayBeStatic"})
	public Component fixBorder(Component c) {
		// only consider JComponents
		if (!(c instanceof JComponent)) { return c; }
		JComponent jc = (JComponent) c;

		// fix components only once
		if (jc.getClientProperty(FIXED) != null) return c;
		jc.putClientProperty(FIXED, FIXED);

        //noinspection ChainOfInstanceofChecks
        if (jc instanceof JCheckBox || jc instanceof JRadioButton) {
            jc.setBorder(BorderFactory.createEmptyBorder(0, 0, 0, 2));
        } else if (jc instanceof JPanel) {
            // spider subtree for jpanels
            for (Component child : jc.getComponents())
                fixBorder(child);
        }
        return c;
	}

	private static final Object FIXED = new Object();

	/**
	 * for strongly related components in the same subgroup.
	 */
//	@SuppressWarnings({"MethodMayBeStatic"})
    public int getSmallPadSize() {
		return 2;
	}

	/**
	 * for components in the same group but different subgroups.
	 */
//	@SuppressWarnings({"MethodMayBeStatic"})
    public int getMediumPadSize() {
		return 6;
	}

	/**
	 * to separate groups.
	 */
//	@SuppressWarnings({"MethodMayBeStatic"})
    public int getLargePadSize() {
		return 12;
	}

	// ------------------------------------------------------------------------
	// components
	// ------------------------------------------------------------------------

	public void makeToolbarStyle(AbstractButton b) {
		b.setOpaque(false);
		b.setRolloverEnabled(true);
	}

	// ------------------------------------------------------------------------
	// Implementations
	// ------------------------------------------------------------------------

	// ------------------------------------------------------------------------
	// native
	private static final class NativeLook extends CELESTLook {
		// TODO implement seperate native looks for windows,osx,&gtk
		public NativeLook() {
			try {
				UIManager.setLookAndFeel(UIManager
					.getSystemLookAndFeelClassName());
				log.info("installed native look and feel");
			} catch (ClassNotFoundException e) {
				// should not happen
				throw new Error(e);
			} catch (InstantiationException e) {
				// should not happen
				throw new Error(e);
			} catch (IllegalAccessException e) {
				// should not happen
				throw new Error(e);
			} catch (UnsupportedLookAndFeelException e) {
				// should not happen
				throw new Error(e);
			}
		}

		@Override
		public Color getWhiteColor() {
			return Color.WHITE;
		}

		@Override
		public Font loadTitleFont() {
			return UIManager.getFont("InternalFrame.titleFont");
		}

		@Override
		public boolean isDimmed() {
			return false;
		}

		@Override
		public void trySetDimmed(boolean v) {
			// do nothing
		}
	}

	// ------------------------------------------------------------------------
	// utilities
	// ------------------------------------------------------------------------
	// used to turn uiresources into normal objects
	private static Font unResource(Font font) {
		if (font instanceof UIResource) return new Font(font.getFamily(), font
			.getStyle(), font.getSize());
		else return font;
	}

	private static Color getColor(String name) {
		return unResource(UIManager.getColor(name));
	}

	private static Color unResource(Color c) {
		if (c instanceof UIResource) return new Color(c.getRGB());
		else return c;
	}
	// ------------------------------------------------------------------------
	//os detection
	// ------------------------------------------------------------------------
	//TODO this belongs in its own sysinfo class used by logging.
	public static enum OS{
		LINUX,OSX,WINDOWS,SOLARIS,OTHER
	}
	private static final OS curOS;
	static {
		String osName=System.getProperty("os.name").toLowerCase();
		if(osName.contains("mac")) {
			//NOTE this will match MacOS Classic as well
			curOS=OS.OSX;
		}else if(osName.contains("solaris")){
			curOS=OS.SOLARIS;
		}else if(osName.contains("linux")) {
			curOS=OS.LINUX;
		}else if(osName.contains("windows")){
			curOS=OS.WINDOWS;
		}else {
			curOS=OS.OTHER;
		}
		log.config("currentOS={0} ({1} {2})",curOS,osName,
			System.getProperty("os.version"));
	}
	public static OS getOS() {
		return curOS;
	}
}
