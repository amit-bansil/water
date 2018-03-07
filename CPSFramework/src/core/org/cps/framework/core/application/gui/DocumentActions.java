/*
 * FileActions.java CREATED: Dec 28, 2003 10:39:23 PM AUTHOR: Amit Bansil
 * PROJECT: CPSFramework Copyright 2003 The Center for Polymer Studies, Boston
 * University, all rights reserved.
 */
package org.cps.framework.core.application.gui;

import org.cps.framework.core.event.property.BoundPropertyRO;
import org.cps.framework.core.event.property.BoundPropertyRW;
import org.cps.framework.core.event.property.DefaultBoundPropertyRW;
import org.cps.framework.core.event.property.ValueChangeEvent;
import org.cps.framework.core.event.property.ValueChangeListener;
import org.cps.framework.core.event.queue.CPSQueue;
import org.cps.framework.core.gui.action.CPSWorkspaceAction;
import org.cps.framework.core.gui.dialogs.ConfirmDialog;
import org.cps.framework.core.gui.dialogs.ErrorDialog;
import org.cps.framework.core.gui.dialogs.VirtualFileDialog;
import org.cps.framework.core.io.DocumentManager;
import org.cps.framework.core.io.VirtualFile;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * Collection of gui actions for loading and saving document.
 * 
 * @version 0.1
 * @author Amit Bansil
 */
public class DocumentActions {
	private final CPSWorkspaceAction saveAction, saveAsAction, revertAction,
			newAction, openAction, importAction, exportAction;

	private final BoundPropertyRW<Boolean> saveable, readable;

	private static final org.cps.framework.util.resources.accessor.ResourceAccessor res = org.cps.framework.util.resources.accessor.ResourceAccessor
			.load(DocumentActions.class);

	static final String TYPE_NAME = res.getString("type.name");

	static final String TYPE_EXTENSION = res.getString("type.extension"),
			DEFAULT_DOCUMENT_TITLE = res.getString("default_title");

	private final DocumentManager manager;

	private final ApplicationGUI gui;

	//ERROR hack, figure out a better way,use document manger
	//allow multiple import/export types
	//don't show these menu items if we don't have to
	public static interface FileHook {
		public void importFile(InputStream in) throws IOException;
		public String getTypeName();
		public String getExtension();
		public void exportFile(OutputStream out) throws IOException;
	}

	private FileHook fileHook;

	public final void setFileHook(FileHook f) {
		if (fileHook != null)
				throw new IllegalStateException("can't set file hook twice");
		fileHook = f;
	} //action access

	final CPSWorkspaceAction getNewAction() {
		return newAction;
	}

	final CPSWorkspaceAction getOpenAction() {
		return openAction;
	}

	final CPSWorkspaceAction getRevertAction() {
		return revertAction;
	}

	final CPSWorkspaceAction getSaveAction() {
		return saveAction;
	}

	final CPSWorkspaceAction getSaveAsAction() {
		return saveAsAction;
	}

	final CPSWorkspaceAction getImportAction() {
		return importAction;
	}

	final CPSWorkspaceAction getExportAction() {
		return exportAction;
	}

	DocumentActions(final DocumentManager manager, final ApplicationGUI gui) {
		this.manager = manager;
		this.gui = gui;

		saveable = new DefaultBoundPropertyRW<Boolean>(Boolean.FALSE);
		readable = new DefaultBoundPropertyRW<Boolean>(Boolean.FALSE);
		manager.stateSaved().addListener(new ValueChangeListener<Boolean>() {
			public void eventOccurred(ValueChangeEvent evt) {
				updateSaveable();
				updateTitle();
			}
		});
		manager.documentFile().addListener(
				new ValueChangeListener<VirtualFile>() {
					public void eventOccurred(ValueChangeEvent evt) {
						updateSaveable();
						updateReadable();
						updateTitle();
					}
				});

		updateSaveable();
		updateReadable();
		updateTitle();

		saveAction = new CPSWorkspaceAction(res, "save", saveable) {
			protected void _cpsPerform() {
				doSave();
			}
		};
		saveAsAction = new CPSWorkspaceAction(res, "saveAs", null) {
			protected void _cpsPerform() {
				doSaveAs();
			}
		};
		revertAction = new CPSWorkspaceAction(res, "revert", readable) {
			protected void _cpsPerform() {
				if (confirmClose()) {
					VirtualFile f = manager.documentFile().get();
					try {
						manager.reloadDocument();
					} catch (IOException e) {
						loadFailed(e, f);
					}
				}
			}
		};
		newAction = new CPSWorkspaceAction(res, "new", null) {
			protected void _cpsPerform() {
				if (confirmClose()) {
					manager.loadBlankDocument();
				}
			}
		};
		openAction = new CPSWorkspaceAction(res, "open", null) {
			protected void _cpsPerform() {
				if (confirmClose()) {
					VirtualFile f = gui.showDialog(VirtualFileDialog
							.createOpenDialog(TYPE_EXTENSION, TYPE_NAME));
					loadDocument(f);
				}
			}
		};
		importAction = new CPSWorkspaceAction(res, "import", null) {
			protected void _cpsPerform() {
				doImport();
			}
		};
		exportAction = new CPSWorkspaceAction(res, "export", null) {
			protected void _cpsPerform() {
				doExport();
			}
		};
		//update title
	}

	private final DefaultBoundPropertyRW<String> title = new DefaultBoundPropertyRW<String>(
			true, DEFAULT_DOCUMENT_TITLE);

	final BoundPropertyRO<String> title() {
		return title;
	}

	final void updateTitle() {
		VirtualFile f = manager.documentFile().get();
		String l_title;
		l_title = f != null ? f.getTitle() : DEFAULT_DOCUMENT_TITLE;
		if (!manager.stateSaved().get().booleanValue())
				l_title = "*" + l_title;
		this.title.set(l_title);
	}

	protected final void updateSaveable() {
		VirtualFile f = manager.documentFile().get();
		saveable.set(new Boolean(!manager.stateSaved().get().booleanValue()
				&& f != null && f.canWrite()));
	}

	protected final void updateReadable() {
		VirtualFile f = manager.documentFile().get();
		readable.set(new Boolean(f != null && f.canRead()));
	}

	private static final ConfirmDialog confirmCloseDialog = new ConfirmDialog(
			res, "close.confirm", true, ConfirmDialog.WARNING_TYPE);

	final boolean confirmClose() {
		CPSQueue.getInstance().checkThread();
		if (manager.stateSaved().get().booleanValue()) return true;
		Object ret = gui.showDialog(confirmCloseDialog);
		if (ret == ConfirmDialog.CHOICE_CANCEL) {
			return false;
		} else if (ret == ConfirmDialog.CHOICE_NO) {
			return true;
		} else if (ret == ConfirmDialog.CHOICE_YES) {
			if (saveable.get().booleanValue()) return doSave();
			return doSaveAs();

		} else
			throw new UnknownError();
	}

	private VirtualFile lastIE = null;
	//TODO proper fail messages, import message,move to docmanager
	public final boolean doImport() {
		if (fileHook == null) throw new UnsupportedOperationException();
		VirtualFile f = gui.showDialog(VirtualFileDialog.createOpenDialog(
				fileHook.getExtension(), fileHook.getTypeName()));
		if (f == null) return false;
		lastIE = f;
		try {
			InputStream in = null;
			try {
				in = new BufferedInputStream(f.getInputStream());
				fileHook.importFile(in);
				return true;
			} finally {
				if (in != null) in.close();
			}
		} catch (IOException e) {
			loadFailed(e, f);
			return false;
		}
	}

	public final boolean doExport() {
		if (fileHook == null) throw new UnsupportedOperationException();
		VirtualFile f = gui.showDialog(VirtualFileDialog.createSaveAsDialog(
				fileHook.getExtension(), fileHook.getTypeName(), lastIE));
		if (f == null) return false;
		lastIE = f;
		try {
			OutputStream out = null;
			try {
				out = new BufferedOutputStream(f.getOutputStream());
				fileHook.exportFile(out);
				out.flush();
				return true;
			} finally {
				if (out != null) out.close();
			}
		} catch (IOException e) {
			saveFailed(e, f);
			return false;
		}
	}

	public final boolean doSave() {
		VirtualFile f = manager.documentFile().get();
		try {
			manager.saveDocument();
			return true;
		} catch (IOException e) {
			saveFailed(e, f);
			return false;
		}
	}

	public final boolean doSaveAs() {
		VirtualFile old = manager.documentFile().get();
		VirtualFile f = gui.showDialog(VirtualFileDialog.createSaveAsDialog(
				TYPE_EXTENSION, TYPE_NAME, old));
		return saveDocument(f);
	}

	private static final String SAVE_FAILED_PATTERN = res
			.getString("error.save");

	private static final String LOAD_FAILED_PATTERN = res
			.getString("error.load");

	final void saveFailed(IOException e, VirtualFile f) {
		gui.showDialog(ErrorDialog.createErrorDialog(SAVE_FAILED_PATTERN
				.replace("{file}", f.getTitle()), e));
	}

	final void loadFailed(IOException e, VirtualFile f) {
		gui.showDialog(ErrorDialog.createErrorDialog(LOAD_FAILED_PATTERN
				.replace("{file}", f.getTitle()), e));

	}

	//------------------------------------------------------------------------
	//PUBLIC OPERATIONS
	//------------------------------------------------------------------------
	/**
	 * loads a document from a virtual file. avoids throwing exceptions, instead
	 * just returns false. informs user of errors. if (f == null) returns false.
	 * 
	 * @param f
	 * @return success
	 */
	public final boolean loadDocument(VirtualFile f) {
		if (f == null) return false;
		try {
			manager.loadDocument(f);
			return true;
		} catch (IOException e) {
			loadFailed(e, f);
			return false;
		}
	}

	/**
	 * saves a document to a virtual file, and updates the current file to that
	 * document. avoids throwing exceptions, instead just returns false. informs
	 * user of errors. if(f==null) returns false.
	 * 
	 * @param f
	 * @return success
	 */
	public final boolean saveDocument(VirtualFile f) {
		if (f == null) return false;
		try {
			manager.saveDocument(f);
			return true;
		} catch (IOException e) {
			saveFailed(e, f);
			return false;
		}
	}
}