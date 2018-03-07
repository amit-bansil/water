/*
 * ResourceManager.java CREATED: Dec 18, 2003 4:17:08 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies, Boston University, all rights
 * reserved.
 */
package org.cps.framework.util.resources.loader;

import org.cps.framework.util.collections.basic.LazyCache;

import java.util.Locale;

/**
 * Low Level manager of assorted loaders. Startup Object can overide loader by
 * calling setLoader with custom subclasses
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class ResourceManager {
    private static final LazyCache<Class,Object> loaders = new LazyCache<Class,Object>() {
        public Object load(Class key, Object context) {
            if (!key.isInstance(context))
                    throw new ClassCastException("loader " + context + " not "
                            + key);
            return context;
        }
    };

    public static final Object getLoader(Class type, Object def) {
        return loaders.get(type, def);
    }

    public static final void setLoader(Class type, Object loader) {
        if (!loaders.set(type, loader))
                throw new IllegalStateException("loader for " + type
                        + " already set");
    }

    //resource naming
    public static final char JAR_SEPARATOR_CHAR = '/';

    public static final String JAR_SEPARATOR = "/";

    public static final String resolveName(Class c) {
        return c.getName().replace('.', JAR_SEPARATOR_CHAR);
    }

    //resolves a resourcename,used for package specific resources,like images
    public static final String resolveName(Package p, String resName) {
        return p.getName().replace('.', JAR_SEPARATOR_CHAR)
                + JAR_SEPARATOR_CHAR + resName;
    }

    //default locale and class loader
    private static final ClassLoader DEFAULT_CLASSLOADER = ResourceManager.class
            .getClassLoader();

    private static final Locale DEFAULT_LOCALE = Locale.getDefault();

    public static ClassLoader getClassLoader() {
        return (ClassLoader) getLoader(ClassLoader.class, DEFAULT_CLASSLOADER);
    }

    public static Locale getLocale() {
        return (Locale) getLoader(Locale.class, DEFAULT_LOCALE);
    }
}
