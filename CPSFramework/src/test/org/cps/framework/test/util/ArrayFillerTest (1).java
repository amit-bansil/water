/*
 * Created on Apr 4, 2003
 */
package org.cps.framework.test.util;

import junit.framework.*;

import org.cps.framework.util.collections.arrays.*;

/**
 * @author Amit Bansil
 *
 * To change the template for this generated type comment go to
 * Window>Preferences>Java>Code Generation>Code and Comments
 */
public class ArrayFillerTest extends TestCase {

	/*
	 * Test for void fill(Object, Object, int, int)
	 */
	public void testFillObjectObjectintint() {
		
		int l=42,k=10,a=6,b=7;
		
		int[] test=new int[l];
		for(int i=0;i<l;i++)assert(test[i]==0);
		
		ArrayFiller.fill(test,new Integer(a),0,k);
		for(int i=0;i<k;i++) assert test[i]==a;
		for(int i=k;i<l;i++) assert test[i]==0;
		
		ArrayFiller.fill(test,new Integer(b),k,l-k);
		for(int i=0;i<k;i++) assert test[i]==a;
		for(int i=k;i<l;i++) assert test[i]==b;
	}

}
