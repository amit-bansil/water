/*
 * EditorInputDialog.java
 * CREATED:    Aug 19, 2004 11:48:56 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    CPSFramework
 * 
 * Copyright 2004 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package org.cps.framework.core.gui.dialogs;

import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.util.EventUtils;
import org.cps.framework.core.gui.components.Editor;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

/**
 * 
 * @version 0.0
 * @author Amit Bansil
 */
public class EditorInputDialog<T> extends InputDialog<T> {
	private final String initialText;
	private boolean linkedOnce=false;
	private final Editor<T> editor;
	private final ValueChangeListener<T> editorL=new ValueChangeListener<T>(){
		public void eventOccurred(ValueChangeEvent<T> e) {
			if(e.getNewValue()==null)setOKEnabled(false);
			else setOKEnabled(true);
		}
		
	};
	public EditorInputDialog(ResourceAccessor parentRes, String name,
			boolean encourageCancel, Editor<T> editor,String initialText) {
		super(parentRes, name, encourageCancel, true,editor.getComponent());
		this.initialText=initialText;
		this.editor=editor;
	}

	protected T getEditorValue() {
		return editor.value().get();
	}

	protected void link() {
		if(!linkedOnce)editor.setText(initialText);
		linkedOnce=true;
		EventUtils.hookupListener(editor.value(),editorL);
	}

	protected void unlink() {
		EventUtils.unhookListener(editor.value(),editorL);
	}

}
