/*
 * CREATED ON:    Aug 12, 2005 6:12:16 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.resources;

import java.awt.Component;
import java.awt.Graphics;

import javax.swing.Icon;

import cps.jarch.util.misc.NotImplementedException;

/**
 * TODO document<br>
 * @version $Id: DescribedImpl.java 548 2005-09-02 14:25:58Z bansil $
 * @author Amit Bansil
 */
public class DescribedImpl implements Described{
	private final String title,description;
	private final String name;
	public String getName() {
		return name;
	}
	public String getTitle() {
		return title;
	}
	/**
	 * description, may be null.
	 * @see cps.jarch.gui.resources.Described#getDescription()
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * 
	 * creates DescribedImpl.
	 * 
	 * @throws IllegalArgumentException
	 *             is <code>name</code> does not specify a {@link Name}
	 */
	public DescribedImpl(MessageBundle res,String name) {
		this.res=res.deriveChild(name);
		this.name = name;
		
		this.title = res.loadString(name+".title");
		this.description = res.tryLoadString(DESCRIPTION_KEY_POSTFIX);
	}
	private final MessageBundle res;
	
	private Icon icon;
	//load icon lazy
	public Icon getIcon() {
		if(icon==UNLOADED) {
			icon=res.tryLoadIcon(ICON_KEY_POSTFIX);
		}
		return icon;
	}
	private static final Icon UNLOADED=new Icon(){
	
		public int getIconHeight() {
			//TODO implement getIconHeight
			throw new NotImplementedException("getIconHeight");
		}
	
		public int getIconWidth() {
			//TODO implement getIconWidth
			throw new NotImplementedException("getIconWidth");
		}
	
		public void paintIcon(Component c, Graphics g, int x, int y) {
			//TODO implement paintIcon
			throw new NotImplementedException("paintIcon");
		}
	
	};
}