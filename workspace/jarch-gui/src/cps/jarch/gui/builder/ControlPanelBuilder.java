/*
 * ControlPanelBuilder.java
 * CREATED:    Jan 14, 2005 2:35:11 AM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CELESTFramework
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.builder;

import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.gui.components.CELESTLook;
import cps.jarch.gui.components.CustomBoxLayout;
import cps.jarch.gui.components.LayoutUtils;
import cps.jarch.gui.data.BooleanBinder;
import cps.jarch.gui.resources.MessageBundle;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Nullable;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;

/**
 * Builds a control panel. Basically a vertical box of components with the
 * following elements:
 * 
 * -Sections are groups of components that can be hidden/shown by a header and
 * are separated by big gaps section components are moderately spaced <br>
 * -Sub Sections have a section component level title sub section components are
 * pretty close <br>
 * 
 * 
 * the resource bundle is used for looking up any strings <BR>
 * 
 * TODO rewrite using GroupLayout, need visibility, sections, sub sections, translation,
 * 	and variable column alignments per component. Need a cleaner API.
 * 
 * also: do actual layout in PLAF, create baseline and visual insets tables for
 * all looks supported, create an app that does this by putting regular text
 * into components and then making measurements, allow switch between
 * components on top or left w/ different justify, UI abstraction,
 * abstract into 1 column layout, create a custom layout manager instead of
 * just nesting boxes, auto determine borders from constants table instead
 * of is3D stuff <BR>
 * 
 * also: change resource accessor for each section or such, basically allow
 * different classes to use, intengrate with component factory/binder <br>
 * 
 * also: optimized saveabledata without boolean property <br>
 * 
 * also: use something like forms to get everything to lineup better. <br>
 * 
 * @author Amit Bansil
 */
public class ControlPanelBuilder {
	private final CELESTLook look;
	private final MessageBundle res;
	
	public ControlPanelBuilder(MessageBundle res) {
		this.res=res;
		target = new JPanel();
		target.setLayout(new CustomBoxLayout(target, BoxLayout.Y_AXIS));
		look = CELESTLook.getInstance();
	}

	private boolean inSubSection = false;

	// needs .title and .description
	public void beginSubSection(String headerKey) {
		beginSubSection(MiscControlFactory.createTitle(headerKey));
	}

	// subSection w/o title
	public void beginSubSection() {
		beginSubSection((Localizable<? extends JComponent>) null);
	}

	// subsection w/ checkbox title that enables/disables sub componets
	private RWValue<Boolean> subSectionEnabled = null;

	public void beginSubSection(String headerKey,
			RWValue<Boolean> lSubSectionEnabled) {
		beginSubSection(ButtonFactory.createHeaderCheckBox(headerKey,
			lSubSectionEnabled));
		this.subSectionEnabled = lSubSectionEnabled;
	}

	// header==null allowed
	public void beginSubSection(Localizable<? extends JComponent> header) {
		if (inSubSection) throw new IllegalStateException("in subSection");

		// OPTIMIZE better to use a box and pad or just inline
		JPanel p = new JPanel();

		p.setLayout(new BoxLayout(p, BoxLayout.Y_AXIS));
		// OPTIMIZE use common border object,save one pad by including top
		p.setBorder(BorderFactory.createEmptyBorder(0, look.getLargePadSize(),
			0, 0));

		if (header != null) {
			_add(localize(header));
			pad(look.getSmallPadSize());
		}
		_add(p);
		inSubSection = true;
		subSecTarget = p;
	}

	public void endSubSection() {
		if (!inSubSection) throw new IllegalStateException("!in subSection");
		inSubSection = false;
		subSecTarget = null;
		subSectionEnabled = null;
		pad(look.getSmallPadSize());
	}

	// adds vertical padding
	private final void pad(int amount) {
		_add(Box.createRigidArea(new Dimension(amount, amount)));
	}

	// adds a component
	private final JPanel target;

	public final JComponent getPanel() {
		return target;
	}

	private Container subSecTarget;

	public void addLeft(String label, Component c) {
		addLeft(MiscControlFactory.createLabel(label), c);
	}

	public void addLeft(Object label,Object c) {
		Box b = Box.createHorizontalBox();
		b.add(toComponent(label));
		b.add(LayoutUtils.smallPad());
		b.add(toComponent(c));
		JPanel p = new JPanel(new BorderLayout(0, 0));
		p.add(b, BorderLayout.WEST);
		addLeft(p);
	}
	public void addRight(Object label,
			Object c) {
		add(label,c,null);
	}
	public void add(Object label,
			Object c,Object m) {
		JPanel p = new JPanel(new BorderLayout(0, 0));
		// UNCLEAR need a strut in here??
		p.add(toComponent(label), BorderLayout.WEST);
		if (m != null) p.add(toComponent(m), BorderLayout.CENTER);
		p.add(toComponent(c), BorderLayout.EAST);
		addLeft(p);
	}

	private boolean dontPadNext = true;

	public void addLeft(Object c) {
		if (dontPadNext) {
			dontPadNext = false;
		} else {
			if (!inSubSection) {
				pad(look.getMediumPadSize());
			} else {
				pad(look.getSmallPadSize());
			}
		}
		_add(toComponent(c));
	}
	
	private final Component toComponent(Object c){
		// OPTIMIZE cast first, check later after exception
		//but need to handle Strings before
		LangUtils.checkArgNotNull(c);
		if(c instanceof Component)return (Component)c;
		if(c instanceof Localizable) {
			Object o=((Localizable<?>)c).getTarget();
			if(o instanceof Component)return (Component)o;
		}if(c instanceof String)return new JLabel((String)c);
		throw new IllegalArgumentException(
			"Object "+c+" cannot be converted to a component");
	}
	
	private ROValue<Boolean> visFlag;
	public final void setVisibiltyFlag(@Nullable ROValue<Boolean> flag) {
		visFlag=flag;
	}
	
	private final void _add(Component c) {
		look.fixBorder(c);
		if(visFlag!=null)BooleanBinder.bindVisibleDown(visFlag, c);
		// left justify
		if (c instanceof JComponent) ((JComponent) c).setAlignmentX(0.0f);
		if (!inSubSection) {
			assert subSectionEnabled==null;
			target.add(c);
		} else {
			subSecTarget.add(c);
			if (subSectionEnabled != null&&c instanceof JComponent)
				BooleanBinder.bindPanelEnabled(subSectionEnabled, (JComponent)c);
		}
	}
	
	private final Component localize(Localizable<? extends JComponent> c) {
		if(c==null)return null;
		c.localize(res);
		return c.getTarget();
	}
}