/*
 * CREATED ON:    Apr 24, 2006 4:27:43 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import cps.water.util.OffscreenCanvas;

import java.awt.Image;

/**
 * <p>
 * TODO document SnapshotRenderer
 * </p>
 * 
 * @version $Id$
 * @author Amit Bansil
 */
public class SnapshotDisplay {
	/*public static interface RenderHook {
		// note that his may be called by an arbitrary thread
		public void finishedRendering(Image image);
	}*/

	private final OffscreenCanvas canvas;

	private final Renderer renderer;

	public final void shutdown() {
		synchronized(renderer){
			canvas.removeNotify();
		}
	}

	/*public final void renderSnapshot(final DisplayModel d, final SimModel m,
			final RenderHook hook) {
		//should be OK to ignore threading since the offscreencanvas runs in software
		if (Threading.isSingleThreaded() && !Threading.isOpenGLThread()) {
			Threading.invokeOnOpenGLThread(new Runnable() {
				public void run() {
					_renderSnapshot(d, m, hook);
				}
			});
		} else _renderSnapshot(d, m, hook);
	}*/

	public Image renderSnapshot(final DisplayModel d, final RenderScene s/*,
			final RenderHook hook*/) {
		//if (!Threading.isOpenGLThread()) throw new Error("should not happen");

		//synchronized (renderer) {
			renderer.read(s,d);
			//canvas.useNewOffscreenBuffer();
			canvas.display();
			return canvas.getOffscreenImage();
			//hook.finishedRendering(canvas.getOffscreenImage());
		//}
	}

	public final void setSize(int width, int height) {
		//synchronized (renderer) {
			if (width < 1 || height < 1) throw new IllegalArgumentException();
			canvas.setSize(width, height);
		//}
	}

	public final int getWidth() {
		synchronized (renderer) {
			return canvas.getWidth();
		}
	}

	public final int getHeight() {
		synchronized (renderer) {
			return canvas.getHeight();
		}
	}

	public SnapshotDisplay(int width, int height) {
		canvas = new OffscreenCanvas();
		renderer = new Renderer();
		canvas.addGLEventListener(renderer);
		setSize(width, height);
	}
}
