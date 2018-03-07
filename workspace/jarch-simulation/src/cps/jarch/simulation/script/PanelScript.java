/*
 * CREATED ON:    Aug 24, 2005 6:47:32 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.simulation.script;

import cps.jarch.gui.builder.StaticPanel;
import cps.jarch.gui.components.MainPanel;
import cps.jarch.gui.util.ComponentProxy;
import cps.jarch.gui.util.EDTWorker;
import cps.jarch.util.misc.LogEx;
import cps.jarch.util.misc.NotImplementedException;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Hook;
import cps.jarch.util.notes.Reflect;

import javax.swing.JButton;
import javax.swing.JComponent;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.EnumSet;
import java.util.Stack;

/**
 * A {@link Script} which shows a series of
 * {@link cps.jarch.gui.builder.StaticPanel}s. The user can exit or
 * restart the series at any time.
 * 
 * @author Amit Bansil
 * @version $Id$
 */
public abstract class PanelScript implements ComponentProxy{
	private static final int THREAD_PRIORITY = Thread.MIN_PRIORITY+2;
	//TODO finish implementing restart & exit
	private static final LogEx<PanelScript> log = LogEx.createClassLog(PanelScript.class);
	// ------------------------------------------------------------------------

	private boolean aborted=false;
	private boolean exit=false;
	private boolean running;
	//private boolean started_run=false;
	
	
	/**
	 * Creates PanelScript.
	 */
	public PanelScript(String name,String title) {
		log.debugEnter(this, "name", name);
		script=new Script(EDTWorker.getInstance(),name,THREAD_PRIORITY,false) {
			@Override protected void _run() {
				while(!exit) {
					aborted=false;
					
					lastShownPanelNumber.push(0);
					lastResult=null;
					PanelScript.log.debug(PanelScript.this, "calling _run");
					/*started_run=*/running=true;
					_run();
					running=false;
					PanelScript.log.debug(PanelScript.this, "_run complete");
					
					lastShownPanelNumber.pop();
				}
			}
		};
		signalNextRunnable=script.createSignaler(Action.next);
		
		//layout
		//TODO use HorizontalPanel for top buttons,create a 'confirmed button' in
		//Button factory.
		//maybe use buttons description in dialog, i.e.
		//Title: Confirm <Button Title>
		//Text: <Button ToolTip>?
		//i.e. Confirm Restart Phase / Return to start of phase? / yes,no
		
		final JButton exitButton=new JButton("Exit");
		restartButton=new JButton("Restart");
		exitButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(_confirmExit()) {
					script.action(Action.exit);
				}
			}
		});
		restartButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(_confirmRestart()) {
					script.action(Action.restart);
				}
			}
		});
		
		top=new MainPanel.Horizontal();
		top.setRight(exitButton);
		holder=new MainPanel.Vertical();
		holder.setTop(top);
	}

	/**
	 * @see Script#requestStart()
	 */
	public final void requestStart() {
		script.requestStart();
	}
	
	private final Script script;
	
	private static enum Action{
		next,exit,restart
	};
	
	@Reflect
	private static final EnumSet<Action> allActions=EnumSet.allOf(Action.class);
	
	/**
	 * @return if current _run invocation should be aborted.
	 * @throws IllegalStateException if called from Thread other than script
	 * @throws IllegalStateException if called when not in _run.
	 */
	protected final boolean isAborted() {
		if(!running)throw new IllegalStateException("!running");
		script.checkScriptThread();
		
		return aborted;
	}
	
	/**
	 * meant to be called from script. blocks till the panel executes the
	 * Runnable to perform the 'next' action or the user hits cancel/restart.
	 * after executing waitForPanel clients should query isAborted and return
	 * from _run if aborted.
	 * 
	 * @see Script#waitFor(EnumSet, Runnable)
	 * @throws IllegalStateException
	 *             if p is already active
	 */
	protected final void waitForPanel(final StaticPanel p) {
		if(aborted)throw new IllegalStateException("already aborted");
		if(p.isActive())throw new IllegalStateException("p already active");
		Action result=script.waitFor(allActions, new Runnable() {
			public void run() {
				p.setActive(true);
				setContent(p);
			}
		});
		setContent(null);
		p.setActive(false);
		
		switch(result) {
			case exit:
				exit=true;
				aborted=true;
				break;
			case restart:
				aborted=true;
				break;
			case next:
				//do nothing
		}
		
		//update last stuff
		int last=lastShownPanelNumber.pop();
		lastShownPanelNumber.push(last+1);
		lastResult=result;
	}
	//#of last panel shown, set to 0 before every _run
	//and increased after each show panel
	//the parent 
	private Stack<Integer> lastShownPanelNumber=new Stack<Integer>();
	//result returned by last panel shown, set to null at start of every _run
	private Action lastResult=null;
	protected final void runChild(Runnable r) {
		if (aborted) throw new IllegalStateException("already aborted");
		if (!running) throw new IllegalStateException("!running");
		script.checkScriptThread();
		lastShownPanelNumber.push(0);
		boolean done = false;
		while (!done) {
			r.run();
			switch (lastResult) {
				case restart:
					int n = lastShownPanelNumber.peek();
					// at least 1 panel should have been shown.
					if (n < 0)
						throw new Error("script " + r
								+ " should have shown at least 1 panel");

					assert aborted == true && exit == false;
					if (n == 1) {
						// if user hit restart on first panel let runChild
						// return and let caller abort
						done = true;
					} else {
						// otherwise restart and go again
						aborted = false;
					}
					break;
				case exit:
					// if user hit exit return and let caller abort
					assert aborted == true && exit == true;
					done = true;
					break;
				case next:
					// if last panel ended with next user clicking next return
					// normally.
					assert aborted == false && exit == false;
					done = true;
					break;
			}
		}

		lastShownPanelNumber.pop();
	}
	
	private final Runnable signalNextRunnable;
	/**
	 * @return Runnable that panels should execute to signal that next panel
	 *         should be shown.
	 */
	public final @Constant Runnable getNextSignal() {
		return signalNextRunnable;
	}
	// ------------------------------------------------------------------------
	// hooks
	/**
	 * implementations should show a series of panels. may be called repeatedly
	 * but never while already executing.
	 */
	@Hook protected abstract void _run();

	private boolean _confirmRestart() {
		//TODO  implement
		return true;
	}
	
	@Hook protected abstract boolean _confirmExit();
	
	public final void requestExit() {
		//TODO implement PanelScript.requestExit
		throw new NotImplementedException(PanelScript.class, "requestExit");
	}
	public final void requestNext() {
		//TODO implement PanelScript.requestNext
		throw new NotImplementedException(PanelScript.class, "requestNext");
	}
	public final void requestAbort() {
		//TODO implement PanelScript.requestAbort
		throw new NotImplementedException(PanelScript.class, "requestAbort");
	}
	// ------------------------------------------------------------------------
	// GUI
	private final MainPanel.Horizontal top;
	private final MainPanel.Vertical holder;
	private final JButton restartButton;
	private void setContent(StaticPanel p) {
		holder.setMiddle(p);
		/*topLeft.removeAll();
		if(p!=null) {
			topLeft.add(p.getHeader());
			//don't allow restart for very first panel
			if(lastResult==null) {
				topLeft.add(LayoutUtils.mediumPad());
				topLeft.add(restartButton);
			}
		}*/
	}
	
	/**
	 * @see cps.jarch.gui.util.ComponentProxy#getComponent()
	 */
	public final JComponent getComponent() {
		return holder.getComponent();
	}
}