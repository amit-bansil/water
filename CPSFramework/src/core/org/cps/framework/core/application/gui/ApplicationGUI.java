/*
 * ApplicationGUI.java CREATED: Jan 1, 2004 10:40:19 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework Copyright 2004 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.application.gui;

import org.cps.framework.core.application.core.Application;
import org.cps.framework.core.event.core.Constraint;
import org.cps.framework.core.event.core.VetoException;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.event.queue.RunnableEx;
import org.cps.framework.core.event.simple.SimpleConstraint;
import org.cps.framework.core.gui.core.LaFLoader;
import org.cps.framework.core.gui.core.MainFrame;
import org.cps.framework.core.gui.dialogs.WorkspaceDialog;
import org.cps.framework.core.gui.event.CPSToSwingAdapter;
import org.cps.framework.core.gui.event.CPSToSwingChangeAdapter;
import org.cps.framework.core.gui.event.GuiEventUtils;

import javax.swing.JButton;
import javax.swing.JMenu;
import javax.swing.SwingUtilities;

import java.awt.Container;
import java.lang.reflect.InvocationTargetException;
import java.util.EventObject;
import java.util.prefs.Preferences;

/**
 * @version 0.0
 * @author Amit Bansil
 */
public final class ApplicationGUI {
	//ERROR hack
	public final void setPrimaryButton(JButton  b) {
		frame.setDefaultButton(b);
	}
	private final MainFrame frame;

	private final Preferences prefs;

	private final Application app;
	private final DocumentActions docActions;
	public ApplicationGUI(final Application app) {
		CPSQueue.getInstance().checkThread();
		this.app = app;
		prefs = app.getPrefrences().node("gui");
		docActions = new DocumentActions(app
				.getDocumentManager(), this);
		
		final SimpleConstraint closeListener=
		    new SimpleConstraint() {
			public void checkEvent(EventObject e)throws VetoException {
				CPSQueue.getInstance().postRunnableExt(new Runnable(){
	                public void run(){
					    app.getShutdownManager().shutdown();
	                }
				});
				//veto everything,let shutdown handle dipose
				throw new VetoException(e,"veto all");
			}
		};
		
		try {
			final String curTitle=docActions.title().get();
			final MainFrame l_frame = GuiEventUtils
					.invokeAndWait(new RunnableEx<MainFrame>() {
						public MainFrame run() {
							//setup gui
							LaFLoader.getInstance().setupUI();
							final MainFrame ll_frame = new MainFrame(app
									.getDescription(), getPrefrences());
							//close shutdown
							ll_frame.closeEvent().addConstraint(
									closeListener);
							//add file menu first
							ll_frame.getMenuBar()
									.add(new FileMenu(getDocumentActions(), app
													.getShutdownManager()));
							ll_frame.setTitle(curTitle);
							return ll_frame;
						}
					});

			//dispose close
			app.getShutdownManager().addShutdownHook(
					new CPSToSwingAdapter("dispose workspace",false) {
						public void swingRun(Object context) {
							l_frame.closeEvent().removeConstraint(closeListener);
							l_frame.dispose();
						}
					});
			this.frame = l_frame;

			//don't allow close
			app.getShutdownManager().shutdownBegun().addConstraint(
					new Constraint<ValueChangeEvent<Boolean>>() {
						public void checkEvent(ValueChangeEvent<Boolean> evt)
								throws VetoException {
							if (!getDocumentActions().confirmClose())
									throw new VetoException(evt,
											"user canceled close");
						}
					});

			//update title
			docActions.title().addListener(
					new CPSToSwingChangeAdapter<String>("update title") {
						protected void swingRun(String old,String newV) {
							l_frame.setTitle(newV);
						}
					});
		} catch (InvocationTargetException e) {
			//should not happen
			throw new Error(e);
		}
	}

	private boolean started = false;

	public void startup() {
		CPSQueue.getInstance().checkThread();
		SwingUtilities.invokeLater(new Runnable() {
			public void run() {
				_startup();
			}
		});
	}

	protected final void _startup() {
		GuiEventUtils.checkThread();
		if (started) throw new IllegalStateException("already initialized");
		//help menu last
		addMenu(new HelpMenu(app.getDescription(), frame.getFrame()));
		frame.show();
		started = true;
	}

	//threadsafe actions
	public final <T> T showDialog(WorkspaceDialog<T> d) {
		return d.show(frame.getFrame());
	}

	//GUI ONLY actions delegated to frame
	//TODO replace direct access to content pane
	//with splitter desktop access
	public void setContentPane(Container p) {
		GuiEventUtils.checkThread();
		frame.setContent(p);
	}

	public Container getContentPane() {
		GuiEventUtils.checkThread();
		return frame.getContent();
	}

	public void addMenu(JMenu m) {
		GuiEventUtils.checkThread();
		if (started)
				throw new IllegalStateException("can't add menus after started");
		frame.getMenuBar().add(m);
	}

	public Preferences getPrefrences() {
		GuiEventUtils.checkThread();
		return prefs;
	}
	
	public final DocumentActions getDocumentActions() {
		return docActions;
	}
}
