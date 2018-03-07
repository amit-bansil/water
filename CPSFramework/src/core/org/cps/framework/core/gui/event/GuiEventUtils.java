/**
 * VMDL2.
 * Created on Feb 1, 2003 by Amit Bansil.
 *
 * Copyright 2002 The Center for Polymer Studies,
 * All rights reserved.
 *
 */
package org.cps.framework.core.gui.event;

import org.cps.framework.core.event.core.GenericListener;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.queue.RunnableEx;

import javax.swing.Icon;
import javax.swing.SwingUtilities;
import javax.swing.Timer;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.lang.reflect.InvocationTargetException;
import java.util.HashSet;
import java.util.Set;

public final class GuiEventUtils {
	//TODO add unlink,RO,name,concat
	public static final <T> BoundPropertyRW<T> toSwing(final BoundPropertyRW<T> p){
		CPSQueue.getInstance().checkThread();
		final BoundPropertyRW<T> ret=new DefaultBoundPropertyRW(p.allowsNull(),p.get());
		ret.addListener((GenericListener)new SwingToCPSAdapter<T>("",true) {
			protected T getContext(Object evt,T oldContext){
				return ret.get();
			}
			public void CPSRun(T context) {
				p.set(context);
			}
		});
		p.addListener((GenericListener)new CPSToSwingAdapter<T>("",true) {
			protected T getContext(Object evt,T oldContext){
				return p.get();
			}
			public void swingRun(T context) {
				ret.set(context);
			}
		});
		return ret;
	}
	/**
	 * ensures execution on EDT. TEST works with rerouting
	 */
	public static final void checkThread() {
		if (!SwingUtilities.isEventDispatchThread())
				throw new Error("cannot access ui from non swing event thread:"
						+ Thread.currentThread());
	}

	/**
	 * @param r
	 *            runnable to execute executes runnabble ex on EDT, just runs it
	 *            if already on
	 * @return r's value
	 * @throws InvocationTargetException
	 *             if r failed
	 */
	public static final <T> T invokeAndWait(RunnableEx<T> r)
			throws InvocationTargetException {
		//just run it if we're on
		if (SwingUtilities.isEventDispatchThread()) {
			try {
				return r.run();
			} catch (Exception e) {
				throw new InvocationTargetException(e);
			}
		}
		//otherwise queue
		RunnableEx.RunnableExAdapter<T> ra = new RunnableEx.RunnableExAdapter<T>(
				r);

		try {
			SwingUtilities.invokeAndWait(ra);
		} catch (InterruptedException e) {
			//should not happen
			throw new Error(e);
		} catch (InvocationTargetException e) {
			//should not happen
			throw new Error(e);
		}

		return ra.done();

	}
	//OPTIMIZE use cps queue instead for better performance???
	private static final Set currentlyPendingRunnables=new HashSet();
	public static final void invokeAfterDelay(boolean concatenate,
			int delay,final Runnable r) {
		checkThread();
		if(currentlyPendingRunnables.add(r)) {
			final Timer t=new Timer(delay,new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					currentlyPendingRunnables.remove(r);
					r.run();
				}
			});
			t.setRepeats(false);
			t.start();
		}
	}

	/**
	 * TODO move this elsewhere sticks a foreground icon over a background icon
	 * centering both, maxing size
	 * 
	 * @param background
	 * @param foregroud
	 * @return
	 */
	public static final Icon compositeIcon(final Icon background,
			final Icon foreground) {
		return new Icon() {
			public void paintIcon(Component c, Graphics g, int x, int y) {
				int w = getIconWidth(), h = getIconHeight();

				background.paintIcon(c, g, x + (w - background.getIconWidth())
						/ 2, y + (h - background.getIconHeight()) / 2);
				foreground.paintIcon(c, g, x + (w - foreground.getIconWidth())
						/ 2, y + (h - foreground.getIconHeight()) / 2);
			}

			public int getIconWidth() {
				return Math.max(background.getIconWidth(), foreground
						.getIconWidth());
			}

			public int getIconHeight() {
				return Math.max(background.getIconHeight(), foreground
						.getIconHeight());
			}

		};
	}
}