/*
 * CREATED ON:    Jun 29, 2005 9:18:24 AM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.data.collections;

import ca.odell.glazedlists.EventList;
import ca.odell.glazedlists.event.ListEvent;
import ca.odell.glazedlists.event.ListEventListener;
import cps.jarch.data.event.Unlinker;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * Transforms an {@link ca.odell.glazedlists.EventList} of elements of type
 * InType to a list of elements of OutType. All add/remove operations must be
 * performed on the input list, although it is possible to manually update an
 * element of the input list with an output value. Changes in the input list are
 * automatically propagated to the output list using the provided hooks.<br>
 * 
 * @version $Id$
 */
public abstract class ListView<InType, OutType> implements Unlinker {
	// ------------------------------------------------------------------------
	// constructor
	
	/**
	 * creates ListView from event driven list <code>in</code>. Elements are
	 * converted using <code>converter</code>, which must be able to convert
	 * and unConvert any element passed to it.
	 */
	public ListView(EventList<InType> in) {

		this.in = in;

		// create array lists backing out
		out = new ArrayList<OutType>(in.size());
		outRO = Collections.unmodifiableList(out);

		// add initial elements from src->dst
		for (int i = 0; i < in.size(); i++) {
			add(i);
		}

		// bind listener to in
		in.addListEventListener(inListener);
	}
	/**
	 * disconnect this from in and remove all elements from out.
	 * @see cps.jarch.data.event.Unlinker#unlink()
	 */
	public void unlink() {
		in.removeListEventListener(inListener);
		for (int i = 0; i < in.size(); i++) {
			remove(i);
		}
	}
	// ------------------------------------------------------------------------
	// fields
	private final EventList<InType> in;

	private final List<OutType> out;

	// read only access to out
	private final List<OutType> outRO;


	/**
	 * provides read only access to out.
	 */
	public final List<OutType> getOut() {
		return outRO;
	}
	
	// ------------------------------------------------------------------------
	// src->dst biding
	// delegates notification of changes to src to hooks below
	private final ListEventListener<InType> inListener = new ListEventListener<InType>() {
		public void listChanged(ListEvent<InType> listChanges) {
			while (listChanges.next()) {
				int n = listChanges.getIndex();
				switch (listChanges.getType()) {
					case ListEvent.DELETE:
						remove(n);
						break;
					case ListEvent.INSERT:
						add(n);
						break;
					case ListEvent.UPDATE:
						update(n);
						break;
					default:
						throw new UnknownError();
				}
			}
		}
	};

	// notification that an element at index has been added to 'in'
	private void add(int index) {
		InType inToAdd;
		inToAdd = in.get(index);
		out.add(index, create(inToAdd, index));

	}

	// notification that an element at index has been removed from 'in'
	private void remove(int index) {
		OutType old = out.remove(index);
		deleted(old, index);
	}

	// notification that an element at index has been updated in 'in'
	private void update(int index) {
		InType newIn;
		newIn = in.get(index);
		OutType oldOut = out.get(index);
		
		//should be fine
		out.set(index,update(newIn, oldOut,index));
	}
	
	// ------------------------------------------------------------------------
	// implementation hooks

	/**
	 * hook called to create a new outType element from in for addition at index.
	 * called when a new element is added to <code>in</code> or the view is
	 * being created. Any element(s) after index will be shifted to the right
	 * to make space for the value returned by _create.
	 */
	protected abstract OutType create(InType newIn, int index);

	/**
	 * hook called to get rid of an old <code>OutType</code> element. Called when the
	 * corresponding <code>InType</code> element been removed from 'in' at
	 * index or the view is being unbound. oldOut has been removed from the
	 * out list when this method is called and any elements after it shifted to
	 * the left to fill the space.
	 */
	protected abstract  void deleted(OutType oldOut, int index);
	
	/**
	 * hook called to create a new outType corresponding to newInput to replace
	 * element <code>oldOutput</code> in the out list at <code>index</code>.
	 * The input list has already been updated with <code>newInput</code> at
	 * index.
	 */
	protected abstract OutType update(InType newInput,OutType oldOutput,int index);
}