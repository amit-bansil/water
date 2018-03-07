package org.cps.umd.display;

import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.vmdl2.particleRenderer.Camera;

import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.Graphics;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * Title: Universal Molecular Dynamics
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2001
 * </p>
 * <p>
 * Company: Boston University
 * </p>
 * 
 * @author Amit Bansil
 * @version 0.0a
 */

public final class UMDDisplay {
	public final Component getCanvas() {
		return canvas;
	}

	public List<Drawer> drawers = new ArrayList();

	public CameraData camera = new Camera3D(0.5f);

	public BoxDrawer boxDrawer = new BoxDrawer3D();

	private final OffScreenCanvas canvas;

	private final MoleculeRenderer renderer;

	private final MouseBinding mouse;

	public final MouseBinding getMouseBinding() {
		return mouse;
	}

	public UMDDisplay() {
		canvas = new OffScreenCanvas();

		renderer = new MoleculeRenderer(canvas);
		mouse = new MouseBinding(canvas, this);
	}

	/* to do: optimize runner to return fast when no change */
	public final void run() {
		redraw();
	}

	/* to do imlement real clipping here and inside the canvas */
	private boolean wasDrawing = false;
	boolean shown=false;
	private final void redraw() {
		if (!canvas.isShowing()) {
			shown=true;
			CPSQueue.getInstance().postRunnableCPSLater(new Runnable() {
				public void run() {
					redraw();
				}
			}, 500, 0);
			return;
		}
		boolean newDrawing = true;
		if (camera == null) newDrawing = false;
		final Drawer[] drawers = this.drawers.toArray(new Drawer[this.drawers
				.size()]);
		;
		if (drawers == null || drawers.length == 0) newDrawing = false;
		if (!canvas.isDrawable()) newDrawing = false;

		if (!newDrawing) {
			if (wasDrawing) {
				wasDrawing = false;
				xa = new int[0];
				ya = new int[0];
				za = new int[0];
				radii = new int[0];
				colors = new int[0];
				bonds = new int[0];
				setSizes = new int[0];
				setStarts = new int[0];
				setCounts = new int[0];
				numSets = 0;
				bScanSize = 0;
				tableSize = 0;
				total = 0;
				canvas.finish();
			}
			return;
		}
		wasDrawing = true;

		final BoxDrawer box = boxDrawer;
		mouse.update();

		boolean resize = canvas.needsResize();
		final Dimension sze = canvas.getSize();
		if (resize) {
			canvas.resizeOffscreen();

			camera.setSize(sze);
		}
		camera.checkSpin();
		boolean cameraPrepared = camera.prepared;
		if (!cameraPrepared) {
			camera.setSize(sze);
			camera.prepare();
			renderer.setSize(camera.getZMin(), camera.getZMax(), 0,
					(int) sze.width, 0, (int) sze.height);
		}

		final boolean changed = resize || !cameraPrepared;

		final boolean is3D = camera.getDimensions() == 3;

		boolean drawersChanged = fullUpdateDrawers(drawers, changed);

		if (is3D && drawersChanged) {
			renderer.updateIndexTable(za, setSizes, setCounts);
		}
		if (skipped | drawersChanged || canvas.needsRedraw() || (box != null)) {
			//cut frame rate when time is short, to do make setting editable
			//if(drawMod<3&&!getCore().getKernel().hasTimeRemaining()){drawMod++;
			// skipped=true; return; }
			//drawMod=0;
			skipped = false;///this is no good, instead the kernel should
							// detect when it is taking to long and drop fps
							// limit

			final Graphics g = canvas.getOffGraphics();
			g.setColor(Color.black);/*
									 * todo allow this to be set, optimize clip
									 * area
									 */
			//g.getClipBounds(tempRect);
			g.fillRect(0, 0, sze.width, sze.height);
			if (box != null) box.drawRearFace(camera, g);
			if (is3D) renderer.render3D(g, xa, ya, za, radii, colors, bonds,
					bScanSize, tableSize, setStarts, setSizes);
			else
				renderer.render2D(g, xa, ya, radii, colors, bonds, bScanSize,
						setCounts, setStarts, setSizes);
			if (box != null) box.drawFrontFace(camera, g);
			canvas.doRepaint();
			canvas.noteRedrawn();
		}
	}

	int drawMod;

	boolean skipped;

	private int[] xa = new int[0], ya = new int[0], za = new int[0],
			radii = new int[0], colors = new int[0], bonds = new int[0],
			setSizes = new int[0], setStarts = new int[0],
			setCounts = new int[0];

	private int numSets = 0;

	private int bScanSize = 0, tableSize = 0, total = 0;

	/* optimize this for only one set */
	private final boolean fullUpdateDrawers(final Drawer[] d,
			boolean forceUpdate) {
		if (!forceUpdate) {
			boolean changed = false;
			for (int i = 0; i < d.length; i++) {
				if (!d[i].needsRedraw() && !d[i].needsInit()) continue;
				changed = true;
				break;
			}
			if (!changed && d.length == setSizes.length) { return false; }
		}

		if (d.length != setSizes.length) {
			//all these arrays are filled with zeros in empty spaces
			final int ml = Math.min(d.length, setSizes.length);
			int[] t = new int[d.length];
			System.arraycopy(setSizes, 0, t, 0, ml);
			setSizes = t;
			t = new int[d.length];
			System.arraycopy(setStarts, 0, t, 0, ml);
			setStarts = t;
			t = new int[d.length];
			System.arraycopy(setCounts, 0, t, 0, ml);
			setCounts = t;
			for (int i = 0; i < d.length; i++) {
				d[i].bScanSizeChanged(bScanSize);
			}
			forceUpdate = true;
		}

		if (forceUpdate) for (int i = 0; i < d.length; i++)
			d[i].positionsAndRadiiLost();

		final int ob = bScanSize;/* todo allow bScansize==0 */
		bScanSize = 1;
		for (int i = 0; i < d.length; i++)
			if (d[i].getMinBScanSize() > bScanSize)
					bScanSize = d[i].getMinBScanSize();
		if (ob != bScanSize) {
			for (int i = 0; i < d.length; i++) {
				d[i].bScanSizeChanged(bScanSize);
				d[i].bondsLost();
			}
			bonds = null;
			/* don't bother allocating bonds if we have to do it again later */
			if (d[0].getSize() == setSizes[0])
					bonds = new int[bScanSize * total];
		}

		int i = 0;
		int newTotal = total;
		tableSize = 0;
		for (; i < d.length; i++) {
			if (d[i].needsInit()) {
				d[i].init(setStarts[i], bScanSize);
			}
			if (d[i].needsRedraw()) {
				if (d[i].getSize() != setSizes[i]) {
					newTotal = setStarts[i];
					break;
				}
				setCounts[i] = d[i].redraw(camera, xa, ya, za, radii, colors,
						bonds);
			}
			tableSize += setCounts[i];
		}

		for (int m = i; m < d.length; m++) {
			setStarts[m] = newTotal;
			setSizes[m] = d[m].getSize();
			newTotal += setSizes[m];
		}
		if (newTotal != total) {
			final int ml = Math.min(newTotal, total);
			total = newTotal;
			int[] t = new int[total];
			System.arraycopy(xa, 0, t, 0, ml);
			xa = t;
			t = new int[total];
			System.arraycopy(ya, 0, t, 0, ml);
			ya = t;
			t = new int[total];
			System.arraycopy(za, 0, t, 0, ml);
			za = t;
			t = new int[total];
			System.arraycopy(colors, 0, t, 0, ml);
			colors = t;
			t = new int[total];
			System.arraycopy(radii, 0, t, 0, ml);
			radii = t;
			t = new int[total];
			System.arraycopy(xa, 0, t, 0, ml);
			xa = t;
			if (bonds != null) {
				t = new int[total * bScanSize];
				System.arraycopy(bonds, 0, t, 0, ml * bScanSize);
				bonds = t;
			} else
				bonds = new int[total * bScanSize];
		}
		for (; i < d.length; i++) {
			if (d[i].needsInit()) {
				d[i].init(setStarts[i], bScanSize);
			}

			d[i].offsetChanged(setStarts[i]);
			d[i].positionsAndRadiiLost();
			d[i].colorsLost();
			d[i].bondsLost();
			setCounts[i] = d[i]
					.redraw(camera, xa, ya, za, radii, colors, bonds);

			tableSize += setCounts[i];
		}

		return true;
	}

	boolean redrawPosted = false;
	public int redrawCount=0;
	public void postredraw() {
		redrawCount++;
		CPSQueue.getInstance().checkThread();
		if (redrawPosted) return;
		CPSQueue.getInstance().postRunnableCPSNow(new Runnable() {
			public void run() {
				redrawPosted = false;
				redraw();
			}
		});
	}
}