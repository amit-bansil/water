/*
 * CREATED ON:    Aug 31, 2005 6:50:15 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.resources;

import cps.jarch.util.misc.LogEx;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * TODO document Pattern
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class Pattern {
	private static final LogEx<Pattern> log = LogEx.createClassLog(Pattern.class);
	//alternating list of text followed by keys derived from pattern, starts
	//with text, text parts may be empty strings
	private final String[] brokenPattern;
	private final Map<String,String> keys;
	private final int estLength;
	public Pattern(String pattern) {
		this.keys=new HashMap<String, String>();
		
		estLength=pattern.length();
		
		List<String> brokenPattern=new ArrayList<String>();
		boolean inKey=false;
		int lastSnipIndex=0;
		for(int i=0;i<pattern.length();i++) {
			char c=pattern.charAt(i);
			if(c==(inKey?'}':'{')) {
				String snippet=pattern.substring(lastSnipIndex, i);
				brokenPattern.add(snippet);
				lastSnipIndex=i+1;
				inKey=(!inKey);
			}
		}
		if(inKey) {
			//does not use preface by this b/c of conflict with toString
			log.warning(null, "final key in pattern {0} is unclosed", pattern);
		}
		this.brokenPattern=brokenPattern.toArray(new String[brokenPattern.size()]);
	}
	
	private String calculatedResult;
	
	public final void put(String key,Object value) {
		String valueS=value.toString();
	
		keys.put(key, valueS);
		
		//OPTIMIZE only clear if key is different and in use
		calculatedResult=null;
	}
	@Override public final String toString() {
		if (calculatedResult == null) {

			boolean inKey = false;

			StringBuilder result = new StringBuilder(estLength);

			for (String s : brokenPattern) {
				if (inKey) {
					String v = keys.get(s);

					if (v == null) {
						// does not use preface by this b/c of conflict with
						// toString
						log.warning(null, "undefined no value for key {0} in {1}", s,
							Arrays.toString(brokenPattern));
						v = '<' + s + '>';
					}

					result.append(v);
				} else {
					result.append(s);
				}
				inKey = (!inKey);
			}

			calculatedResult = result.toString();
		}
		return calculatedResult;
	}
}
