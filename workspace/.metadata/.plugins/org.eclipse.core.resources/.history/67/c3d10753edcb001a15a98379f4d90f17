/*
 * CREATED ON:    Dec 29, 2005 2:27:41 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.util.collections;

import cps.jarch.util.misc.LangUtils;

import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * <p>TODO document CollectionsEx
 * </p>
 * @version $Id: CollectionsEx.java 83 2005-12-29 23:45:28Z bansil $
 * @author Amit Bansil
 */
public class CollectionsEx {
	public static final <K,V> List<K> findKeys(Map<K,V> map,V value){
		LangUtils.checkArgNotNull(value,"value");
		List<K> ret=new LinkedList<K>();
		for(Map.Entry<K, V> e:map.entrySet()) 
			if(value.equals(e.getValue()))ret.add(e.getKey());
		
		return ret;
	}
}
