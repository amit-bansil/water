/*
 * CREATED ON:    Aug 24, 2005 8:20:40 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.components;
/**
 * TODO document HorizontalPanel<br>
 * 
 * should have an inner class called Builder,w. getCenter,getLeft,&getRight
 * providing access to three lazily crated instances of it that add components
 * to the resp. parts. have a create() method at end which then sticks the
 * results of the three together. Have an enum of common buttons, specialized
 * methods for creating the different types of components
 * button,commonButton,JComboBox,JCheckBox,spinner,field etc. have two inner
 * subclasses for SmallSize & RegSize & DoubleSize (or maybe just a flag will do
 * it) (might be able to make do w. 2 out of three of these styles. Have ability
 * to create groups that can be enabled/disabled or shown/hidden with a
 * checkbox, or flipped between using a JComboBox. Obviously support translation.
 * no need to ever make translation optional, it is a flat out better way of
 * holding those resources.
 * 
 * 
 * @author Amit Bansil
 * @version $Id$
 */
public class HorizontalPanel {
	//TODO
}
