/*
 * DefaultPropertiesLoader.java
 * CREATED:    Dec 20, 2003 6:19:44 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2003 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.util.resources.accessor;

import org.cps.framework.util.resources.loader.ResourceError;
import org.cps.framework.util.resources.loader.ResourceManager;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.MissingResourceException;
import java.util.ResourceBundle;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class DefaultAccessorLoader extends AccessorLoader {
	//prefix will be clipped from all elements
	//	platform
	public static final String[] PLATFORMS = new String[] { "WIN", "MAC", "X" };
	public static final int CURRENT_PLATFORM;
	public static final int PLATFORM_WIN = 0, PLATFORM_MAC = 1, PLATFORM_X = 2;
	static {
		String os = System.getProperty("os.name").toLowerCase();
		if (os.startsWith("win")) {
			CURRENT_PLATFORM = PLATFORM_WIN;
		} else if (os.startsWith("mac")) {
			CURRENT_PLATFORM = PLATFORM_MAC;
		} else
			CURRENT_PLATFORM = PLATFORM_X;
	}
	private static final String[] excludedPrefixes =
		new String[PLATFORMS.length - 1];
	private static final String CURRENT_PREFIX = "{" + CURRENT_PLATFORM + "}";
	static {
		int k = 0;
		for (int i = 0; i < PLATFORMS.length; i++) {
			if (i != CURRENT_PLATFORM) {
				excludedPrefixes[k] = "{" + PLATFORMS[i] + "}";
				k++;
			}
		}
	}
	public ResourceAccessor loadAccessor(String name) {
		ResourceBundle bundle =
			ResourceBundle.getBundle(
				name,
				ResourceManager.getLocale(),
				ResourceManager.getClassLoader());

		Map<String,Object> data = new HashMap<String,Object>();
		Enumeration<String> keys = bundle.getKeys();

		try {
			while (keys.hasMoreElements()) {
				String key = keys.nextElement();
				Object value = bundle.getObject(key);
				if (value == null)
					throw new ResourceError(
						"null value for key " + key + " in " + bundle,name);
				if (key.length() < 1)
					throw new Error("bad key");
				if (key.charAt(0) == '{') {
					//prefix handling-skip excluded
					boolean done = false;
					for (int i = 0; i < excludedPrefixes.length; i++) {
						if (key.startsWith(excludedPrefixes[i])) {
							done = true;
							break;
						}
					}
					if (done)
						continue;
					//cut current
					if (key.startsWith(CURRENT_PREFIX))
						key = key.substring(CURRENT_PREFIX.length());
				}
				data.put(key, value);
			}
		} catch (MissingResourceException e) {
			//keys should be there since b gave them to us...
			throw new UnknownError();
		}

		return new MapResourceAccessor(
			name,
			data,
			name.substring(
				0,
				name.lastIndexOf(ResourceManager.JAR_SEPARATOR) + 1));
	}
}
