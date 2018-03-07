/*
 * ImageLoader.java CREATED: Aug 12, 2003 9:17:33 AM AUTHOR: Amit Bansil
 * PROJECT: vmdl2
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.util.resources.loader;

import org.cps.framework.util.collections.basic.LazyCache;

import javax.swing.Icon;
import javax.swing.ImageIcon;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.Image;

/**
 * Utility class to load images from the Resourceloader. thread safe???
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public abstract class IconLoader {
    //default instance
    /**
     * image must not yet be cached. get image and puts in in cache. if not
     * found failed image is foud if image is bad throws ResourceError returns
     * what was put in cache
     */
    private static final IconLoader DEFAULT_IMAGE_LOADER = new IconLoader() {
        public boolean _hasIcon(String name) {
            return ResourceLoader.getInstance().hasResource(name);
        }

        public Icon _getIcon(String name) {
            return new ImageIcon(ResourceLoader.getInstance().getResource(name));
        }
    };

    //global instance
    public static final IconLoader getInstance() {
        return (IconLoader) ResourceManager.getLoader(IconLoader.class,
                DEFAULT_IMAGE_LOADER);
    }

    //hooks
    protected abstract boolean _hasIcon(String name);

    protected abstract Icon _getIcon(String name);

    //constant for load failed...
    protected static final Icon FAILED_IMAGE = new Icon() {
		public void paintIcon(Component c, Graphics g, int x, int y) {
		}
		public int getIconWidth() {
			return 0;
		}

		public int getIconHeight() {
			return 0;
		}
	};

    //cache/load
    protected static final String[] imageExtensions = new String[]{"", ".gif",
            ".jpg", ".jpeg", ".png"};

    private static final LazyCache<String,Icon> icons = new LazyCache<String,Icon>() {
        public Icon load(String nameO, Object context) {
            String name = nameO;
            IconLoader instance = getInstance();
            for (int i = 0; i < imageExtensions.length; i++) {
                String key = name + imageExtensions[i];
                if (instance._hasIcon(key)) { return instance._getIcon(key); }
            }
            return FAILED_IMAGE;
        }
    };

    //access
    /**
     * gets imageicon from [c's package]/images/name
     */
    public static final String IMAGES_DIR = "images"
            + ResourceManager.JAR_SEPARATOR;

    public static final Icon getIcon(Class c, String name) throws ResourceError {
        return getIcon(ResourceManager.resolveName(c.getPackage(), IMAGES_DIR
                + name));
    }

    public static final Icon getIcon(String name) throws ResourceError {
        Icon ret = icons.get(name);
        if (ret == FAILED_IMAGE)
                throw new ResourceError("could not load image ", name);
        return ret;
    }

    // returns if getImage is possible

    public static final boolean hasImageIcon(String name) throws ResourceError {
        Object ret = getIcon(name);
        return ret != FAILED_IMAGE;
    }

    // convers a icon to an image either ramming through if its an imageicon or
    // by
    // taking a snapshot.
    public static final Image toImage(Icon i, Component c) {
        if (i instanceof ImageIcon) return ((ImageIcon) i).getImage();
        Image ret = c.createImage(i.getIconWidth(), i.getIconHeight());
        Graphics g = ret.getGraphics();
        i.paintIcon(c, g, 0, 0);
        g.dispose();
        return ret;
    }

    //a blank icon
    public static final Icon getBlankIcon(final int size) {
        return new Icon() {
            public int getIconHeight() {
                return size;
            }

            public int getIconWidth() {
                return size;
            }

            public void paintIcon(Component c, Graphics g, int x, int y) {
                //do nothing
            }
        };
    }
}
