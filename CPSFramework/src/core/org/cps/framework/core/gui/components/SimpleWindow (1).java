/*
 * FormDialog.java CREATED: Sep 10, 2003 5:15:21 PM AUTHOR: Amit Bansil PROJECT:
 * vmdl2 Copyright 2003 The Center for Polymer Studies, Boston University, all
 * rights reserved.
 */
package org.cps.framework.core.gui.components;

import org.cps.framework.core.event.core.VetoException;
import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.simple.SimpleConstrainable;
import org.cps.framework.core.event.simple.SimpleConstrainableNotifier;
import org.cps.framework.core.gui.event.GuiEventUtils;

import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JRootPane;
import javax.swing.JWindow;
import javax.swing.WindowConstants;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dialog;
import java.awt.Frame;
import java.awt.Window;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

/**
 * TODO prefrences keyed by desc.getName remembering windowposition/splitter
 * position etc. all these prefrences options cause problems in schools where
 * consistency is paramount so adding such features is not critical.
 * 
 * TODO add progress and focus support to this window:
 * 
 * components should be able traverse up the graph to get the window,
 * then inform it of errors, warning,info,stuff todo etc.
 * 
 * when editors gain the focus they should post additional info
 * 
 * the window should manage the focus, knowing where to send as components are
 * enabled/disabled
 * 
 * the user should be able to choose where the status should be shown
 * at the top wizban style or on the bottom as a status bar, or hidden,
 * or in a seperate dialog or in a label (depending on which are appropriate
 * for the window subclass)
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class SimpleWindow {

	/**
	 * @param p
	 * @return top level Window above component or genericFrame.
	 */
	public static Window getContainingWindow(Component p) {
		while(p.getParent() != null) p = p.getParent();
		if(p instanceof Window) return (Window)p;
		else return getGenericFrame();
	}
	/**
	 * @return generic frame.
	 * TODO implement
	 */
	public static final Dialog getGenericFrame() {
		throw new UnsupportedOperationException();
	}
	
	
	protected final Window dialog;
	private final JRootPane root;
	public final void setContent(Container content) {
		root.setContentPane(content);
	}
	public final Container getContent() {
		return root.getContentPane();
	}
	public final void setDefaultButton(JButton b) {
		root.setDefaultButton(b);
	}
	public static final SimpleWindow createDialog(
		final String title,
		final Component parent,
		boolean modal,
		boolean disposeOnHide) {
		Window parentWindow = getContainingWindow(parent);

		final JDialog dialog;
		if (parentWindow instanceof Frame) {
			dialog = new JDialog((Frame) parentWindow);
		} else if (parentWindow instanceof Dialog) {
			dialog = new JDialog((Dialog) parentWindow);
		} else
			dialog= new JDialog(getGenericFrame());

		dialog.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
		dialog.setModal(modal);
		dialog.setTitle(title);

		SimpleWindow ret =
			new SimpleWindow(
				dialog,
				disposeOnHide,
				dialog.getRootPane());
		ret.shown().addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				dialog.setLocationRelativeTo(parent);
			}
		});
		return ret;
	}
	public static final SimpleWindow createWindow(
		boolean disposeOnHide,
		final Container parent) {
		final Window parentWindow = getContainingWindow(parent);

		final JWindow window = new JWindow(parentWindow);
		SimpleWindow ret =
			new SimpleWindow(
				window,
				disposeOnHide,
				window.getRootPane());
		ret.shown().addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				window.setLocationRelativeTo(parent);
			}
		});
		return ret;
	}
	protected SimpleWindow(
		JFrame f,
		boolean disposeOnHide){
		this(f,disposeOnHide,f.getRootPane());
		//??redundant
		f.setDefaultCloseOperation(WindowConstants.DO_NOTHING_ON_CLOSE);
	}
	private SimpleWindow(
		Window window,
		boolean disposeOnHide,
		JRootPane root) {
		GuiEventUtils.checkThread();
		this.root = root;
		this.dialog = window;
		this.disposeOnHide = disposeOnHide;
		dialog.setVisible(false);

		visible =
			new DefaultBoundPropertyRW<Boolean>(false, Boolean.FALSE);
		disposed =
			new DefaultBoundPropertyRW<Boolean>(false, Boolean.FALSE);
		shown = new DefaultBoundPropertyRW<Boolean>(false, Boolean.FALSE);
		hidden =
			new DefaultBoundPropertyRW<Boolean>(false, Boolean.FALSE);
		closeEvent=new SimpleConstrainableNotifier(this);
		//close
		dialog.addWindowListener(new WindowAdapter() {
			public void windowClosing(WindowEvent e) {
				GuiEventUtils.checkThread();
				try{
                    closeEvent.fireEvent();
    				hide();
                }catch(VetoException e1){
                    //TODO log veto
                }
			}
		});
		//autoclose
		visible.addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				GuiEventUtils.checkThread();

				final boolean visible_l = evt.getNewValue().booleanValue();

				if (visible_l && shown.get().equals(Boolean.FALSE))
					shown.set(Boolean.TRUE);
				else if (!visible_l && hidden.get().equals(Boolean.FALSE))
					hidden.set(Boolean.TRUE);
				//avoid recursion here since the dialog will block
				//if (dialog.isVisible() != visible_l)
				//	dialog.setVisible(visible_l);
			}
		});
		hidden.addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				assert evt.getNewValue().equals(Boolean.TRUE)
					&& evt.getOldValue().equals(Boolean.FALSE);
				if (isDisposeOnHide())
					dispose();
			}
		});
		shown().addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent<Boolean> evt) {
				dialog.toFront();
				dialog.pack();
			}
		});
	}
	//PROPERTIES
	//visible
	private final BoundPropertyRW<Boolean> visible;
	public final BoundPropertyRO<Boolean> visible() {
		return visible;
	}
	//neccessary since dialog blocks
	public final void show() {
		visible.set(Boolean.TRUE);
		if (!dialog.isVisible())
			dialog.setVisible(true);
	}
	public final void hide() {
		if (dialog.isVisible())
			dialog.setVisible(false);
		visible.set(Boolean.FALSE);
	}
	//close notification
	private final SimpleConstrainableNotifier closeEvent;
	public final SimpleConstrainable closeEvent(){
	    return closeEvent;
	}
	//dispose
	public void dispose() {
		GuiEventUtils.checkThread();
		if (disposed.get().equals(Boolean.TRUE))
			return;
		disposed.set(Boolean.TRUE);
		if (visible.get().equals(Boolean.TRUE))
			visible.set(Boolean.FALSE);

		//might have recursivly dispose on close
		//TEST called only once
		dialog.dispose();//call earlier???
		
	}
	private final boolean disposeOnHide;
	public boolean isDisposeOnHide() {
		return disposeOnHide;
	}
	//TODO rearchitecture around new properties, move to util and use in
	// workspace
	//also finish writing UI for FormContentsUI
	protected final BoundPropertyRW<Boolean> disposed, shown, hidden;
	public BoundPropertyRO<Boolean> shown() {
		return shown;
	}
	// a window will only be hidden if it is shown...
	public BoundPropertyRO<Boolean> hidden() {
		return hidden;
	}
	public BoundPropertyRO<Boolean> disposed() {
		return disposed;
	}
}