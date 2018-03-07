/*
 * Created on Mar 2, 2003
 */
package org.cps.framework.util.lang.misc;

import java.text.ParseException;
import java.util.StringTokenizer;

/**
 * @author Amit Bansil
 */
public class VersionNumber implements Comparable {
	public static final VersionNumber EMPTY_VERSION_NUMBER =
		new VersionNumber(new int[0]);
	public static final VersionNumber parse(String s) throws ParseException {
		if (s == null || s.length() == 0)
			return EMPTY_VERSION_NUMBER;
		if (s.startsWith(".") || s.endsWith("."))
			throw new ParseException(
				"version '" + s + "' starts/ends with '.'",
				-1);
		if (s.indexOf("..") != -1)
			throw new ParseException(
				"version " + s + " contains undefined '..'",
				-1);
		StringTokenizer st = new StringTokenizer(s, ".");
		int[] v = new int[st.countTokens()];
		int i = 0;
		try {
			while (st.hasMoreTokens()) {
				v[i] = Integer.parseInt(st.nextToken());
				if(v[i]<0)throw new ParseException("arg "+i+"<0",-1);
				i++;
			}
		} catch (NumberFormatException e) {
			throw new ParseException(
				"version '" + s + "' contains non numbers",
				-1);
		}
		return new VersionNumber(v);
	}
	private final int[] v;
	public VersionNumber(int[] v) {
		this.v = (int[]) v.clone();
	}
	public String toString() {
		StringBuffer ret = new StringBuffer();
		if (v.length == 0)
			return "";
		for (int i = 0; i < v.length; i++) {
			ret.append(v[i]);
			ret.append('.');
		}
		ret.deleteCharAt(ret.length() - 1);
		return ret.toString();
	}
	//TODO buggy 2.0 is < 2.0.0 by this algorithom
	public int compareTo(Object o) {
		VersionNumber c=(VersionNumber)o;
		for(int i=0;i<Math.min(v.length,c.v.length);i++){
			if(c.v[i]>v[i]) return 1;//greater
			else if(c.v[i]<v[i])return -1;//less
		}
		if(c.v.length>v.length) return 1;
		else if(c.v.length<v.length) return -1;
		else return 0;
	}
}
