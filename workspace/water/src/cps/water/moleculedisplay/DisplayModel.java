/*
 * CREATED ON:    Apr 14, 2006 4:06:39 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import cps.jarch.data.event.GenericSource;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.event.tools.Source;
import cps.jarch.data.event.tools.SourceImp;
import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.RWFlag;

/**
 * <p>TODO document DisplayModel, IO, kill read()
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class DisplayModel {
	
	final Lock lock=new ReentrantLock();
	
	public static enum ColorScheme{
		Type("Type"),KineticEnergy("Kinetic Energy"),PotentialEnergy("Potential Energy");
		private final String title;
		private ColorScheme(String title) {
			this.title=title;
		}
		@Override public String toString() {
			return title;
		}
	}
	
	private final RWFlag shrinkMolecules=new RWFlag(true,lock);
	public DisplayModel() {
		Link l=source.getSendEventLink();
		cameraZoom.connect(l);
		spotSize.connect(l);
		shrinkMolecules.connect(l);
	}
	public final RWFlag shrinkMolecules() {
		return shrinkMolecules;
	}
	private final BoundedValue<Float> cameraZoom=new BoundedValue<Float>(90f,10f,100f,lock);//0 is closest
	public final BoundedValue<Float> cameraZoom(){
		return cameraZoom;
	}
//	0 is spotlight off & normal lighting instead
	private final BoundedValue<Float> spotSize=new BoundedValue<Float>(1f,0f,10f,lock);
	public final BoundedValue<Float> spotSize(){
		return spotSize;
	}
	private float rotateX,rotateY;
	private final float[] translation=new float[3];
	public final void getTranslation(float[] dst) {	
		lock.lock();
		System.arraycopy(translation, 0, dst, 0, 3);
		lock.unlock();
	}
	public final void setTranslation(float[] src) {
		lock.lock();
		System.arraycopy(src, 0, translation, 0, 3);
		source.sendEvent();
		lock.unlock();
	}
	public final float getRotateX() {
		lock.lock();
		float rx=rotateX;
		lock.unlock();
		return rx;
	}
	public final float getRotateY() {
		lock.lock();
		float ry=rotateY;
		lock.unlock();
		return ry;
	}
	public final void setRotation(float x,float y) {//degrees, see GLAccess.rotateCamera
		lock.lock();
		rotateX=x;
		rotateY=y;
		source.sendEvent();
		lock.unlock();
	}
	//read's the state of m into this
	public final void read(DisplayModel m) {
		m.lock.lock();
		lock.lock();
		cameraZoom.setUnchecked(m.cameraZoom.get());
		setRotation(m.rotateX, m.rotateY);
		shrinkMolecules.set(m.shrinkMolecules.get());
		spotSize.setUnchecked(m.spotSize.get());
		setTranslation(m.translation);
		lock.unlock();
		m.lock.unlock();
	}
	//change source
	private final SourceImp source = new SourceImp(this);

	/**
	 *@return a {@link GenericSource} for observing changes to this.
	 */
	public final Source getSource() {
		return source;
	}
}
