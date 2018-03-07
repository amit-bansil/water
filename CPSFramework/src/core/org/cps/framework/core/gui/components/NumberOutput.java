/*
 * NumberOutput.java
 * CREATED:    Aug 21, 2004 6:24:20 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.util.lang.misc.ScientificFormat;

import javax.swing.JLabel;

/**
 * TODO rewrite in factory
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class NumberOutput extends JLabel {

	public NumberOutput(final BoundPropertyRO< ? extends Number> p,int sigFigs,int maxWidth) {
		final ScientificFormat f=new ScientificFormat(sigFigs,maxWidth,false);
		p.addListener(new ValueChangeListener() {
			public void eventOccurred(Object e) {
				Number n=p.get();
				if(n==null)setText("--");
				else setText(f.format(n.doubleValue()));
			}
		});
	}

}