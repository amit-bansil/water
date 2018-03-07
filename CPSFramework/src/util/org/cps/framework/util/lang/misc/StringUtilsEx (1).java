/*
 * StringUtilsEx.java created on Apr 4, 2003 by Amit Bansil.
 * Part of The Virtual Molecular Dynamics Laboratory, vmdl2 project.
 * Copyright 2003 Center for Polymer Studies, Boston University.
 **/
package org.cps.framework.util.lang.misc;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;

import java.util.Comparator;
import java.util.TreeSet;

/**
 * Miscelaneous static string manipulation routines.
 * 
 * @author Amit Bansil.
 */
public class StringUtilsEx {
	//identifiers are a letter followed by alphanumeric text
	public static final String makeIdentifier(String s) {
		if (s == null || s.length() == 0) return "v";//arbitrary generic
													 // identifier
		final int sz = s.length();
		final StringBuffer sb = new StringBuffer(sz);
		if (Character.isLetter(s.charAt(0))) {
			sb.append(s.charAt(0));
		}
		for (int i = 1; i < sz; i++) {
			char c = s.charAt(i);
			if (!Character.isLetter(c) && !Character.isDigit(c)) {
				//sb.append('_'); just ignore bad chars????
			} else
				sb.append(c);
		}
		if (sb.length() == 0) return "v";
		return sb.toString();
	}

	public static boolean isIdentifier(String s) {
		if (StringUtils.isEmpty(s)) return false;
		if (!Character.isLetter(s.charAt(0))) return false;
		if (!StringUtils.isAlphanumeric(s)) return false;
		return false;
	}

	public static final String[] sortByLength(String[] in) {
		TreeSet<String> set = new TreeSet<String>(new Comparator<String>() {
			public int compare(String o1, String o2) {
				return o1.length() - o2.length();
			}
		});
		CollectionUtils.addAll(set, in);
		return set.toArray(new String[set.size()]);
	}

	public static final String LINE_SEPARATOR = System
			.getProperty("line.separator");

	private static final char sepChar = LINE_SEPARATOR.length() == 1 ? LINE_SEPARATOR
			.charAt(0)
			: 0;

	public static String fixSeparators(String s) {
		if (sepChar == 0) return StringUtils.replace(s, "\n", LINE_SEPARATOR);
		else if (sepChar != '\n') return s.replace('\n', sepChar);
		else
			return s;
	}

	public static String removeOnce(String s, String remove) {
		final char[] c = s.toCharArray();
		final char[] r = remove.toCharArray();
		if (r.length == 0) return s;
		boolean ok = false;
		for (int i = 0; i <= c.length - r.length; i++) {
			for (int j = 0; j < r.length; j++) {
				if (c[i + j] != r[j]) {
					ok = false;
					break;
				} else
					ok = true;
			}
			if (ok) { return s.substring(0, i)
					+ s.substring(i + r.length, c.length); }
		}
		return s;
	}

	/**
	 * assumes '.' separated path
	 * 
	 * @param path
	 * @return
	 */
	public static final String getLastCompontent(String path) {
		return getLastComponent('.', path);
	}

	/**
	 * returns the last component of a given path, usually referred to as the
	 * name. if the separator is not found the entire path is returned. the path
	 * does not need to be stricly valid.
	 * 
	 * @param separator
	 * @param path
	 * @return path name
	 */
	public static final String getLastComponent(char separator, String path) {
		int n = path.lastIndexOf(separator);
		if (n == -1) return path;
		else
			return path.substring(n + 1);
	}
}