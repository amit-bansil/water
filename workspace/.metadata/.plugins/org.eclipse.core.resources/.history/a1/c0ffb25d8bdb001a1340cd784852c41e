/*
 * CREATED ON:    Apr 28, 2006 4:28:48 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.resources;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.notes.Nullable;

import javax.swing.Icon;
import javax.swing.ImageIcon;

import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.MediaTracker;
import java.awt.image.BufferedImage;
import java.net.URL;

/**
 * <p>Loads images through a ResourceLoader. Images are searched for in an 'images' folder
 * inside the parent Resourceloader's root. Extensions do not need to be specified although
 * it does not hurt if they are. Images ending in .gif, .jpg, .jpeg, and .png will have that
 * ending appended automatically.
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class ImageLoader {
	private static final LogEx<ImageLoader> log = LogEx.createClassLog(ImageLoader.class);
	
	private static final String IMAGE_DIR="images";
	
	private final ResourceLoader loader;
	
	public static ImageLoader create(Class owner) {
		return new ImageLoader(ResourceLoader.create(owner));
	}
	
	public ImageLoader(ResourceLoader l) {
		this.loader=l.deriveChild(IMAGE_DIR);
	}
	
	protected static final String[] imageExtensions = new String[]{"", ".gif", ".jpg",
		".jpeg", ".png"};

	// note that this is expensive...
	// TODO allow a 'Blank{w,h}" code to just create a blank image
	// so other locales can change graphics without overwriting
	/**
	 * @return <code>Icon</code> associated with <code>key</code>. If
	 *         none can be found a warning will be printed an a dummy will be
	 *         found.
	 */
	public final Icon loadIcon(String name) {
		Icon ret = tryLoadIcon(name);
		if (ret == null) {
			log.warning(this,"image:''{0}'' not found",name);
			return DUMMY_ICON;
		}
		return ret;
	}
	private static final Icon DUMMY_ICON=new Icon() {
		public void paintIcon(Component c, Graphics g, int x, int y) {
			Color color=g.getColor();
			g.setColor(Color.blue);
			g.fillRect(x,y,x+16,y+16);
			g.setColor(color);
		}
		public int getIconWidth() {
			return 16;
		}
	
		public int getIconHeight() {
			return 16;
		}
		
	};

	/**
	 * @return <code>Icon</code> associated with <code>key</code> or
	 *         <code>null</code> if no such icon has been defined.
	 */
	public @Nullable Icon tryLoadIcon(String name) {
		LangUtils.checkArgNotNull(name);
		for (String imageExtension : imageExtensions) {
			URL ret =  loader.tryFindResource(name + imageExtension);
			if (ret != null) {
				ImageIcon retimage = new ImageIcon(ret);
				if (retimage.getImageLoadStatus() != MediaTracker.COMPLETE) {
					log.warning(null, "image:''{0}'' corrupt", name);
					return null;
				}
				return retimage;
			}
		}
		return null;
	}
	public Icon loadExpectedIcon(String name) {
		Icon ret=tryLoadIcon(name);
		if(ret==null)throw new Error("icon not found "+name);
		return ret;
	}
	// 
	/**
	 * Utility method to convert an icon to an image either casting through if
	 * its an ImageIcon or by taking a snapshot. Expensive.
	 * 
	 * @param component
	 *            required to create snapshot image.
	 */
	public static final Image toImage(Icon icon, Component component) {
		return toImage(icon,component,false);
	}
	public static final BufferedImage toBufferedImage(Icon icon, Component component) {
		return (BufferedImage)toImage(icon,component,true);
	}
	private static final Image toImage(Icon icon, Component component,boolean requireBuffered) {
		log.debugEnterStatic("image, component", icon, component);
		if (icon instanceof ImageIcon) {
			Image image=((ImageIcon) icon).getImage();
			if(image instanceof BufferedImage||!requireBuffered)return image;
		}
		int w=icon.getIconWidth();
		int h=icon.getIconHeight();
		Image ret = requireBuffered?
				component.getGraphicsConfiguration().createCompatibleImage(w, h):
				component.createImage(w,h);
		if (ret == null) {
			log.warning(null, "component '{0}' could not create image, "
					+ "it is probably not connected to a peer, "
					+ "ARGB buffered image used instead", component);
			ret = new BufferedImage(icon.getIconWidth(), icon.getIconHeight(),
				BufferedImage.TYPE_INT_ARGB);
		}
		Graphics g = ret.getGraphics();
		icon.paintIcon(component, g, 0, 0);
		g.dispose();
		return ret;
	}
	@Override public String toString() {
		return "Images:"+loader.toString();
	}
}
