/*
 * StringUtilsExTest.java created on Apr 5, 2003 by Amit Bansil.
 * Part of The Virtual Molecular Dynamics Laboratory, vmdl2 project.
 * Copyright 2003 Center for Polymer Studies, Boston University.
 **/
package org.cps.framework.test.util;

import junit.framework.*;

import org.cps.framework.util.lang.misc.*;

/**
 * @author Amit Bansil.
 */
public class StringUtilsExTest extends TestCase {
	public void testSortByLength() {
		String[] unsorted=new String[]{
			"aba",
			"zaba",
			"amita",
			"1",
			""
		};
		String[] sorted=StringUtilsEx.sortByLength(unsorted);
		String[] correct=new String[]{
			"",
			"1",
			"aba",
			"zaba",
			"amita"
		};
		assert sorted.length==correct.length;
		for(int i=0;i<correct.length;i++){
			assert sorted[i].equals(correct[i]);
		}
	}
	public void testIsIdentifier(){
		assert !Character.isJavaIdentifierPart('.');
		assert !Character.isJavaIdentifierPart(',');
		assert !Character.isJavaIdentifierPart('/');
	}
	public void testRemoveOnce(){
		assert StringUtilsEx.removeOnce("amitbansil","bansil").equals("amit");
		assert StringUtilsEx.removeOnce("amitbansil","amit").equals("bansil");
		assert StringUtilsEx.removeOnce("amitbansil","a").equals("mitbansil");
		assert StringUtilsEx.removeOnce("amitbansil","l").equals("amitbansi");
		assert StringUtilsEx.removeOnce("amit","bansil").equals("amit");
		assert StringUtilsEx.removeOnce("123","1234").equals("123");
		assert StringUtilsEx.removeOnce("bam1bam2bam3","bam").equals("1bam2bam3");
		assert StringUtilsEx.removeOnce("","bam").equals("");
		assert StringUtilsEx.removeOnce("","").equals("");
		assert StringUtilsEx.removeOnce("bam","").equals("bam");
	}
}
