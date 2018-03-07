/*
 * CREATED ON:    Aug 15, 2005 8:52:51 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.builder;

import cps.jarch.gui.resources.Described;
import cps.jarch.gui.resources.DescribedImpl;
import cps.jarch.gui.resources.MessageBundle;

import javax.swing.Icon;
import javax.swing.JComponent;
import java.awt.Font;

/**
 * TODO document AbstractLocalizableComponent<br>
 * @version $Id: AbstractLocalizableComponent.java 548 2005-09-02 14:25:58Z bansil $
 * 
 * @author Amit Bansil
 */
public abstract class AbstractLocalizableComponent<T extends JComponent> implements
		Localizable<T> {

	private final String name;

	private final T c;

	public AbstractLocalizableComponent(String name, T c) {
		this.name = name;
		this.c = c;
	}

	public T getTarget() {
		return c;
	}
	private boolean initialized=false;

	public final void localize(MessageBundle res) {
		if(initialized)throw new IllegalStateException("already initialized"); 
		initialized=true;
		
		Described d=new DescribedImpl(res, name);
		setText(c,d.getTitle());
		if(d.getIcon()!=null)setIcon(c,d.getIcon());
		if(d.getDescription()!=null)setTooltip(c, d.getDescription());
	}

	protected abstract void setText(T c,String text);
	protected void setIcon(T c,Icon i) {
		throw new UnsupportedOperationException();
	}
	protected void setTooltip(T c,String text) {
		c.setToolTipText(text);
	}
	protected abstract void setEnabled(T c,boolean b);
	protected void setFont(T c,Font f) {
		c.setFont(f);
	}
	
}