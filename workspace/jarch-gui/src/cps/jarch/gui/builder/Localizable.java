/*
 * CREATED ON:    Aug 15, 2005 6:58:44 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.builder;

import cps.jarch.gui.resources.MessageBundle;
import cps.jarch.util.notes.Constant;

/**
 * <p>
 * decorates an object that can be localized. good when the resources an object
 * is bound to are either not available until after it is created or may be
 * changed.
 * </p>
 * @version $Id: LocalizableComponent.java 449 2005-08-16 02:43:08Z bansil $
 * 
 * @author Amit Bansil
 */
public interface Localizable<T>{
	/**
	 * get the object being decorated. may be called multiple times before and
	 * after setResources.
	 * 
	 * @return the object that is being localized.
	 */
	@Constant
	public T getTarget();
	
	/**
	 * localize target using res. May be called multiple times with different
	 * arguments before and after getTarget.
	 */
	public void localize(MessageBundle res);
}
