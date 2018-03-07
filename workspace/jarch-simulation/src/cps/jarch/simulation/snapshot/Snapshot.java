/*
 * CREATED ON:    May 1, 2006 5:20:14 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.snapshot;

import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.GenericSource;
import cps.jarch.data.event.tools.Source;
import cps.jarch.data.event.tools.SourceImp;
import cps.jarch.data.value.tools.ROFlag;
import cps.jarch.data.value.tools.RWFlag;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.util.notes.Nullable;

import java.awt.Image;
import java.util.EventObject;

/**
 * <p>TODO document Snap
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public abstract class Snapshot implements Source{
	private final RWValueImp<Boolean> checked=new RWValueImp<Boolean>(false,false);
	private final RWValueImp<String> title=new RWValueImp<String>("",false);
	public final RWValueImp<Boolean> getChecked() {
		return checked;
	}
	public final RWValueImp<String> getTitle() {
		return title;
	}
	private final SourceImp thumbnailChangeSource=new SourceImp(this,"thumbnail");
	public final Source getThumbnailChangeSource() {
		return thumbnailChangeSource;
	}
	protected final void sendThumbnailChangedEvent() {
		thumbnailChangeSource.sendEvent();
	}
	//should be fast, impl. should do actual worker on another thread 
	//and when new is read call sendThumbnailChangedEvent
	public abstract @Nullable Image getThumbnail();
	//clients call this, should return fast, actual update of thumbnail can take its time
	public abstract void requestUpdateThumbnail(int width,int height);
	//should return Snapshot of same type as this
	//should be a 'deep copy' of state but don't include links
	protected abstract Snapshot createCopy();
	public final ROFlag active(){
		return active;
	}
	private final RWFlag active=new RWFlag(false);
	protected final void _setActive(boolean v) {
		active.set(v);
	}
	// ------------------------------------------------------------------------
	//change source
	private final GenericSource[] sources=new GenericSource[] {
			checked,title,thumbnailChangeSource,active};
	@SuppressWarnings("unchecked") public void connect(GenericLink<? super EventObject> l) {
		for(GenericSource s:sources)s.connect(l);
	}
	@SuppressWarnings("unchecked") public void disconnect(GenericLink<? super EventObject> l) {
		for(GenericSource s:sources)s.disconnect(l);
	}
}