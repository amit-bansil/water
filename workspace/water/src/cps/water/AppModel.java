/*
 * CREATED ON:    Apr 16, 2006 10:22:19 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water;

import javax.swing.SwingUtilities;

import cps.jarch.data.event.tools.Link;
import cps.jarch.simulation.snapshot.Snapshot;
import cps.jarch.simulation.snapshot.SnapshotsModel;
import cps.jarch.util.misc.Worker;
import cps.jarch.util.notes.Constant;
import cps.water.data.DataViewerModel;
import cps.water.moleculedisplay.DisplayModel;
import cps.water.moleculedisplay.GLWorker;
import cps.water.moleculedisplay.RenderScene;
import cps.water.moleculedisplay.SnapshotDisplay;
import cps.water.simulation.SimConfig;
import cps.water.simulation.SimModel;
import cps.water.time.TimeModel;

import java.awt.Graphics;
import java.awt.Image;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * <p>
 * Holds state of entire application. Meant to be accessed by EDT only except
 * where noted. Handles snapshot logic.
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
//TODO IO
public class AppModel extends SnapshotsModel<AppModel.Model>{
	//fields
	private final DataViewerModel dataViewer1Model,dataViewer2Model;
	private final TimeModel timeModel;
	
	//field getters
	public final DataViewerModel getDataViewer1Model() {
		return dataViewer1Model;
	}

	public final DataViewerModel getDataViewer2Model() {
		return dataViewer2Model;
	}

	public final TimeModel getTimeModel() {
		return timeModel;
	}
	// ------------------------------------------------------------------------
	//constructor
	private final Worker simWorker;
	public AppModel(Worker simWorker) {
		this.simWorker=simWorker;
		dataViewer1Model=new DataViewerModel(snapshots());
		dataViewer2Model=new DataViewerModel(snapshots());
		timeModel=new TimeModel();
		snapshots().add(createEmpty());
	}

	@Override public Model createEmpty() {
		return new Model(SimConfig.getIce96());
	}

	public class Model extends Snapshot {
		private final SimModel simModel;
		private final DisplayModel display;
		private final RenderScene renderScene;
		public final RenderScene getRenderScene() {
			return renderScene;
		}
		public Model(SimConfig intialConfig) {
			simModel=new SimModel(intialConfig,simWorker);
			display=new DisplayModel();
			renderScene=new RenderScene();
			connectActive();
		}
		//copy constructor
		private Model(Model orig) {
			//this is not thread safe, we're reading from a model that might be changing...
			simModel=new SimModel(orig.simModel);
			display=new DisplayModel();
			renderScene=new RenderScene();
			renderScene.readScene(simModel.getScene());
			display.read(orig.display);
			//request a redraw of thumbnail when snapshot is hidden
			connectActive();
		}
		private final void connectActive() {
			active().connect(new Link() {
				@Override protected void signal() {
					if(!active().get()) runTake();
				}
			});
		}
		public @Constant final DisplayModel getDisplay() {
			return display;
		}
		public @Constant final SimModel getSimModel() {
			return simModel;
		}
		@Override protected Snapshot createCopy() {
			return new Model(this);
		}
		
		private int width,height;
		private Image img;
		
		@Override public Image getThumbnail() {
			return img;
		}
		@Override public void requestUpdateThumbnail(int width, int height) {
			synchronized(modelsToUpdate) {
				this.width=width;
				this.height=height;
				runTake();
			}
		}
		public void setThumbnail(Image img) {
			this.img=img;
			sendThumbnailChangedEvent();
		}
		private int n=0;
		private final void runTake() {
			synchronized(modelsToUpdate) {
				modelsToUpdate.add(this);
				GLWorker.getInstance().runConditional(100, TimeUnit.MILLISECONDS, takeSnapshot);
			}
		}
	}
	// ------------------------------------------------------------------------
	//snapshot queue
	//TODO put this in snapshot display
	private SnapshotDisplay snapshotDisplay=new SnapshotDisplay(100, 100);
	private final Set<Model> modelsToUpdate=new HashSet<Model>();
	private final Runnable takeSnapshot=new Runnable() {
		public void run() {
			final Model m;
			//pop an element off modelsToUpdate
			int w,h;
			synchronized(modelsToUpdate) {
				if(modelsToUpdate.isEmpty())return;
				Iterator<Model> i=modelsToUpdate.iterator();
				m=i.next();
				i.remove();
				w=m.width;
				h=m.height;
			}
			
			snapshotDisplay.setSize(w, h);
			final Image img=snapshotDisplay.renderSnapshot(m.getDisplay(), m.getRenderScene());
			
			SwingUtilities.invokeLater(new Runnable() {
				public void run() {
					m.setThumbnail(img);
				}
			});
			
			if(!modelsToUpdate.isEmpty())
				GLWorker.getInstance().runConditional(100, TimeUnit.MILLISECONDS, takeSnapshot);
		}
	};
}