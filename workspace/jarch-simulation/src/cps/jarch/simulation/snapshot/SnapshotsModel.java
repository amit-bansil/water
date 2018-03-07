/*
 * CREATED ON:    Apr 16, 2006 10:22:19 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.snapshot;

import ca.odell.glazedlists.BasicEventList;
import ca.odell.glazedlists.EventList;
import ca.odell.glazedlists.event.ListEvent;
import ca.odell.glazedlists.event.ListEventListener;
import cps.jarch.data.event.GenericSource;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.event.tools.Source;
import cps.jarch.data.event.tools.SourceImp;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.tools.RWFlag;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Nullable;

import java.util.ArrayList;

/**
 * <p>
 * Meant to be accessed by EDT only except
 * where noted. TODO document
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
//TODO IO
public abstract class SnapshotsModel<SnapshotType extends Snapshot> {
	//fields
	private final EventList<SnapshotType> snapshots;//possible empty
	//selected from Snapshots
	//primary is null iff Snapshots is empty
	//secondary may be null at any time
	//primary never can be the same as secondary unless both are null
	private final RWValueImp<SnapshotType> primarySelection,secondarySelection;
	//points to either the primary or the secondary selection, if secondary is null
	//always points to primary
	private RWValueImp<SnapshotType> focusedSelection;
	// value of focused item, null only if Snapshots is empty, this is the Snapshot
	// the user is editing
	private final RWValueImp<SnapshotType> focusedItem;
	//if the primary & secondary selection are set points to the one that is not focused,
	//otherwise return null
	private final RWValueImp<SnapshotType> unfocusedItem;
	
	private final RWFlag snapsCheckable=new RWFlag(false);
	public final RWFlag snapsCheckable() {
		return snapsCheckable;
	}
	
	public boolean isPrimarySelected() {
		return focusedSelection==primarySelection;
	}
	private final void update() {
		if(isPrimarySelected()) {
			focusedItem.set(primarySelection.get());
			unfocusedItem.set(secondarySelection.get());
		}else {
			focusedItem.set(secondarySelection.get());
			unfocusedItem.set(primarySelection.get());
		}
		source.sendEvent();
	}
	
	//field getters

	public final @Constant EventList<SnapshotType> snapshots() {
		return snapshots;
	}

	public final @Constant ROValue<SnapshotType> primarySelection() {
		return primarySelection;
	}

	public final @Constant ROValue<SnapshotType> secondarySelection() {
		return secondarySelection;
	}
	
	public final @Constant ROValue<SnapshotType> focusedSelection() {
		return focusedItem;
	}
	
	public final @Constant ROValue<SnapshotType> unFocusedSelection() {
		return unfocusedItem;
	}
	
	// ------------------------------------------------------------------------
	// setters
	public final void setPrimarySnapshot(SnapshotType m) {
		//do nothing if no change,also throws npe on m==null
		if(m.equals(primarySelection))return;
	
		checkSnapshotInThis(m);
		if(secondarySelection.get()==m)throw new IllegalArgumentException("can't set primary to same Snapshot as secondary");

		SnapshotType oldPrimary=primarySelection.get();
		//if(oldPrimary!=null)oldPrimary._setActive(false);
		primarySelection.set(m);
		//m._setActive(true);
		
		update();
	}
	public final void setSecondarySelection(@Nullable SnapshotType m) {
		if(m!=null) {
			checkSnapshotInThis(m);
			if(primarySelection.get()==m)throw new IllegalArgumentException("can't set secondary to same Snapshot as primary");
		}
		
		if(LangUtils.equals(m, secondarySelection.get()))return;
		
		SnapshotType oldSecondary=secondarySelection.get();
		//if(oldSecondary!=null)oldSecondary._setActive(false);
		if(oldSecondary==null) {//if secondary is cleared while selected move focus to primary
			focusedSelection=primarySelection;
		}
		secondarySelection.set(m);
		//if(m!=null) m._setActive(true);
		update();
	}
	public final void selectPrimarySnapshot() {
		if(primarySelection.get()==null)throw new IllegalStateException("can't select null");
		focusedSelection=primarySelection;
		update();
	}
	public final void selectSecondarySnapshot() {
		if(secondarySelection.get()==null)throw new IllegalStateException("can't select null");
		focusedSelection=secondarySelection;
		update();
	}

	private void checkSnapshotInThis(SnapshotType m) {
		if(!snapshots.contains(m))throw new IllegalArgumentException(m+" is not managed by this");
	}
	// ------------------------------------------------------------------------
	//constructor
	public SnapshotsModel() {
		
		snapshots=new BasicEventList<SnapshotType>();
		primarySelection=new RWValueImp<SnapshotType>();
		secondarySelection=new RWValueImp<SnapshotType>();
		

		primarySelection.connect(new Link() {
			SnapshotType old;
			@Override public void signal() {
				if(old!=null)old._setActive(false);
				old=primarySelection.get();
				if(old!=null)old._setActive(true);
			}
		});
		secondarySelection.connect(new Link() {
			SnapshotType old;
			@Override public void signal() {
				if(old!=null)old._setActive(false);
				old=secondarySelection.get();
				if(old!=null)old._setActive(true);
			}
		});
		
		focusedItem=new RWValueImp<SnapshotType>();
		unfocusedItem=new RWValueImp<SnapshotType>();
		focusedSelection=primarySelection;
		snapshots.addListEventListener(new ListEventListener<SnapshotType>() {
			public void listChanged(ListEvent<SnapshotType> listChanges) {
				processSnapshotsChange(listChanges);
				source.sendEvent();
			}
		});
		snapsCheckable.connect(source.getSendEventLink());
	}
	//note that this needs to be registered
	public abstract SnapshotType createEmpty();
	
	// ------------------------------------------------------------------------
	//selection algorithm
	
	//when a first Snapshot is added make it the primary selection
	//when a Snapshot is removed if it is primary (secondary) move the primary (secondary)
	//to the next, unless the next is secondary (primary) in which case try from start
	//if the primary is removed and only the secondary is present point it to the secondary
	//and kill the secondary
	//so if there is 1 it should only be the primary and there should be no secondary
	//iff there are no items the primary should be null
	//the secondary may be null at any time
	private final ArrayList<SnapshotType> oldSnapshots=new ArrayList<SnapshotType>();
	private void processSnapshotsChange(ListEvent<SnapshotType> listChanges) {
		SnapshotType newPrimary,newSecondary;
		int l=snapshots.size();
		if(l==0) {
			focusedSelection=primarySelection;
			newPrimary=newSecondary=null;
		}else if(l==1) {
			focusedSelection=primarySelection;
			newPrimary=snapshots.get(0);
			newSecondary=null;
		}else {
			newPrimary=determineNew(secondarySelection,primarySelection,listChanges);
			newSecondary=determineNew(primarySelection,secondarySelection,listChanges);
			
			if(newPrimary==null) {
				assert newSecondary!=null;//if newSecondary were null the list must be empty
				newPrimary=newSecondary;
				newSecondary=null;
			}
			if(newSecondary==null)focusedSelection=primarySelection;
		}
		
		//empty changes to prevent mem leaks
		while(listChanges.hasNext())listChanges.nextBlock();

		//update old Snapshots
		oldSnapshots.clear();
		oldSnapshots.addAll(snapshots);
		
		secondarySelection.set(newSecondary);
		primarySelection.set(newPrimary);
		
		
		update();
	}
	
	private @Nullable SnapshotType determineNew(ROValue<SnapshotType> oldV, ROValue<SnapshotType> dontRetV,
			ListEvent<SnapshotType> changes) {
		//check that Snapshots.size()>1
		assert snapshots.size() > 1;
		SnapshotType old = oldV.get();
		SnapshotType dontRet = dontRetV.get();

		//if nothing is selected or old wasn't removed don't select anything new
		if (old == null || snapshots.contains(old)) return old;

		//find a new selection for old which is not don't, preferring the element after it
		//but otherwise the element before it
		//if it has neither a before or an after which is don't just scan the list
		//finally return null if nothing is available

		//get old index
		int oldIndex = oldSnapshots.indexOf(old);
		assert oldIndex != -1;
		//clone changes so we don't use up master
		changes = new ListEvent<SnapshotType>(changes);
		//based on changes find index of next
		while (changes.next()) {
			int changeIndex = changes.getIndex();
			int changeType = changes.getType();

			if (changeType == ListEvent.INSERT && changeIndex <= oldIndex) oldIndex++;
			else if (changeType == ListEvent.DELETE && changeIndex < oldIndex)
				oldIndex--;
		}
		
		//if next is after end of list move to previous 
		if (oldIndex == snapshots.size()) oldIndex--;
		//previous can't be -1
		assert oldIndex >= 0 && oldIndex < snapshots.size();

		int newIndex=oldIndex;
		//if this element is not don't we're good
		//otherwise try all the ones before it
		while(newIndex>=0) {
			SnapshotType newSnapshot=snapshots.get(newIndex);
			if(newSnapshot!=dontRet)return newSnapshot;
			newIndex--;
		}
		
		newIndex=oldIndex;
		//now try everything after it
		while(newIndex<snapshots.size()) {
			SnapshotType newSnapshot=snapshots.get(newIndex);
			if(newSnapshot!=dontRet)return newSnapshot;
			newIndex++;
		}
		
		//finally give up
		return null;
	}
	
	// ------------------------------------------------------------------------
	//change source
	private final SourceImp source = new SourceImp(this);

	/**
	 *@return a {@link GenericSource} for observing changes to this.
	 */
	public final Source getSource() {
		return source;
	}



}
