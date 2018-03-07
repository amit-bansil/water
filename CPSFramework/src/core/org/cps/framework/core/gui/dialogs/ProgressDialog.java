/*
 * ProgressDialog.java
 * CREATED:    Aug 20, 2004 1:57:46 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.dialogs;

import org.apache.commons.lang.StringUtils;

import javax.swing.ProgressMonitor;
import javax.swing.SwingUtilities;
import javax.swing.Timer;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Date;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public abstract class ProgressDialog {
	private ProgressMonitor pm;

	private final Timer t;

	private static final int RATE = 500;//update frequency

	private static final int MIN_TIME = 400;//min time to show for

	private static final int SCALE=100;
	private static final int MAX=100*SCALE;
	//min=0,range=max
	
	private final long startTime;

	private final String title;

	private final Component parent;
	
	public ProgressDialog(String title, int timeToDecide, Component parent) {
		startTime = System.currentTimeMillis();
		this.parent = parent;
		this.title = title;

		t = new Timer(RATE, al);
		t.setRepeats(true);
		t.setCoalesce(true);
		t.setInitialDelay(timeToDecide);
		t.start();
	}

	private boolean done = false;
	//TODO figure out why it takes so long to popup
	private final ActionListener al = new ActionListener() {
		public void actionPerformed(ActionEvent e) {
			if (done) return;
			final double prog = getPercentComplete();
			if(prog<0)throw new IllegalStateException("progress<0");
			if(prog>=100) {
				done();
				return;
			}
			
			long timeDone=System.currentTimeMillis()-startTime;
			long predictedTime=Math.round((timeDone)/(prog/100d));

			if(predictedTime<=MIN_TIME)return;

			String timeLeft=timeToString(predictedTime-timeDone)+" remaining";
			
			if (pm == null) {
				//need some junk note for the layout
				pm = new ProgressMonitor(parent, title, "--", 0, MAX);
				pm.setMillisToPopup(0);
				pm.setMillisToDecideToPopup(0);
			}
			
			int iprog=(int)Math.round(prog*SCALE);
			if(iprog>=MAX) {//prevent rounding up to MAX and closing
				iprog=MAX-1;
			}
			
			pm.setProgress(iprog);
			
			if (pm.isCanceled()) {
				abort();
				//TODO externalize
				pm.setNote("aborting...");
			}else {
				String status=getStatus();
				if(StringUtils.isBlank(status)) {
					pm.setNote(timeLeft);
				}else {
					pm.setNote(getStatus()+" ("+timeLeft+")");
				}
			}
		}
	};

	private final void _done() {
		t.stop();
		done = true;
		if (pm != null) {
			pm.close();
			pm = null;
		}
	}

	public void done() {
		if (SwingUtilities.isEventDispatchThread()) _done();
		else {
			SwingUtilities.invokeLater(new Runnable() {
				public void run() {
					_done();
				}
			});
		}
	}

	//called from EDT
	public abstract void abort();

	//must be 0-100
	public abstract double getPercentComplete();

	public abstract String getStatus();
	
	private static final String timeToString(long time) {
		time=((long)Math.floor(time/1000)*1000);
		Date date=new Date(time);
		int seconds=date.getSeconds();
		int min=date.getMinutes();
		int hours=(int)Math.floor(time/(3600*1000));
		return pad(hours)+":"+pad(min)+":"+pad(seconds);
	}
	private static final String pad(int n) {
		if(n<10)return "0"+n;
		else return n+"";
	}
}