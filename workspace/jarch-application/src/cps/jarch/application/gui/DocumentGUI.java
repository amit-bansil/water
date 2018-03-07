package cps.jarch.application.gui;

import cps.jarch.application.ApplicationDescription;
import cps.jarch.application.io.DocumentManager;
import cps.jarch.application.io.LocalVirtualFile;
import cps.jarch.application.io.VirtualFile;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.DataUtils;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.gui.builder.CELESTAction;
import cps.jarch.gui.builder.WorkspaceMenu;
import cps.jarch.gui.dialog.ConfirmDialog;
import cps.jarch.gui.dialog.MessageDialog;
import cps.jarch.gui.dialog.WorkspaceDialog;
import cps.jarch.gui.resources.MessageBundle;

import javax.swing.JMenu;
import javax.swing.JOptionPane;

import java.awt.Component;
import java.awt.FileDialog;
import java.awt.Frame;
import java.io.File;
import java.io.IOException;
import java.util.EventObject;

/**
 * Collection of gui actions for loading and saving document. Derived from
 * org.cps.framework.core.application.gui.DocumentActions. <br>
 * TODO only allow reload when changed&readable
 * 
 * @version 1.0
 * @author Amit Bansil
 */
//@SuppressWarnings({"ClassWithTooManyFields"})
public class DocumentGUI {
	private final CELESTAction saveAction, saveAsAction, revertAction,
			newAction, openAction;

	private final RWValue<Boolean> saveable, readable;

	static final MessageBundle res = MessageBundle
			.create(DocumentGUI.class);

	final String typeName, typeExtension;

	private static final String DEFAULT_DOCUMENT_TITLE = res
			.loadString("default_title");

	private final DocumentManager manager;
	private final Component context;
	
	DocumentGUI(final DocumentManager manager, ApplicationDescription app,Component lContext) {
		this.manager = manager;
		this.context=lContext;
		this.typeName = app.getFileTypeName();
		this.typeExtension = app.getFileTypeExtension();

		saveable = new RWValueImp<Boolean>(false);
		readable = new RWValueImp<Boolean>(false);
		DataUtils.linkAndSync(manager.getChangeSupport(),
				new Link() {
					@Override public void signal(EventObject event) {
						updateState();
					}
				});

		saveAction = new CELESTAction("save", saveable) {
			@Override
			protected void doAction() {
				doSave();
			}
		};
		saveAsAction = new CELESTAction("saveAs") {
			@Override
			protected void doAction() {
				doSaveAs();
			}
		};
		revertAction = new CELESTAction("revert", readable) {
			@Override
			protected void doAction() {
				if (confirmClose()) {
					VirtualFile f = manager.getDocumentFile();
					try {
						manager.reloadDocument();
					} catch (IOException e) {
						loadFailed(e, f);
					}
				}
			}
		};
		newAction = new CELESTAction("new") {
			@Override
			protected void doAction() {
				if (confirmClose()) {
					manager.loadBlankDocument();
				}
			}
		};
		openAction = new CELESTAction("open") {
			@Override
			protected void doAction() {
				if (confirmClose()) {
					VirtualFile f = VirtualFileDialog
							.createOpenDialog(typeExtension, typeName).show(context);
					loadDocument(f);
				}
			}
		};

		menu = buildMenu();
	}

	private final RWValueImp<String> title = new RWValueImp<String>(
			DEFAULT_DOCUMENT_TITLE, true);

	final ROValue<String> title() {
		return title;
	}

	/**
	 * internal hook bound to manager changes
	 */
	protected final void updateState() {
		VirtualFile f = manager.getDocumentFile();
		String l_title;
		l_title = f != null ? f.getTitle() : DEFAULT_DOCUMENT_TITLE;
		if (!manager.isStateSaved()) l_title = '*' + l_title;
		this.title.set(l_title);

		saveable.set(!manager.isStateSaved() && f != null
                && f.canWrite());

		readable.set(f != null && f.canRead());
	}

	// TODO do this apple style with rem. my choice & clearer button labels
	private static final ConfirmDialog confirmCloseDialog = new ConfirmDialog(
			"close.confirm", res, true, ConfirmDialog.Type.WARNING,false);

	// private VirtualFile lastIE = null;

	private static final String SAVE_FAILED_PATTERN = res
			.loadString("error.save");

	private static final String LOAD_FAILED_PATTERN = res
			.loadString("error.load");

	// ------------------------------------------------------------------------
	// Package Operations
	// ------------------------------------------------------------------------

	final boolean confirmClose() {
		if (manager.isStateSaved()) return true;
		ConfirmDialog.Choice ret = confirmCloseDialog.show(context);
		if (ret == ConfirmDialog.Choice.CANCEL) {
			return false;
		} else if (ret == ConfirmDialog.Choice.NO) {
			return true;
		} else if (ret == ConfirmDialog.Choice.YES) {
			if (saveable.get()) return doSave();
			return doSaveAs();

		} else
			throw new UnknownError();
	}

	final void saveFailed(IOException e, VirtualFile f) {
		MessageDialog.createErrorDialog(SAVE_FAILED_PATTERN
				.replace("{file}", f.getTitle()), e).show(context);
	}

	final void loadFailed(IOException e, VirtualFile f) {
		MessageDialog.createErrorDialog(LOAD_FAILED_PATTERN
				.replace("{file}", f.getTitle()), e).show(context);

	}

	// ------------------------------------------------------------------------
	// MENU
	// ------------------------------------------------------------------------
	private final WorkspaceMenu<JMenu> menu;

	public final WorkspaceMenu<JMenu> getFileMenu() {
		return menu;
	}

	private final WorkspaceMenu<JMenu> buildMenu() {
		WorkspaceMenu<JMenu> lMenu = WorkspaceMenu.createTopMenu(res, "file");
		lMenu.addAction(newAction);
		lMenu.addAction(openAction);
		lMenu.addSeparator();
		lMenu.addAction(saveAction);
		lMenu.addAction(saveAsAction);
		lMenu.addAction(revertAction);
		lMenu.addSeparator();
		return lMenu;
	}

	// ------------------------------------------------------------------------
	// PUBLIC OPERATIONS
	// ------------------------------------------------------------------------
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

	public final boolean doSave() {
		VirtualFile f = manager.getDocumentFile();
		try {
			manager.saveDocument();
			return true;
		} catch (IOException e) {
			saveFailed(e, f);
			return false;
		}
	}

	public final boolean doSaveAs() {
		VirtualFile old = manager.getDocumentFile();
		VirtualFile f = VirtualFileDialog
				.createSaveAsDialog(typeExtension, typeName, old).show(context);
		return saveDocument(f);
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

	// ------------------------------------------------------------------------
	// File Dialog
	// ------------------------------------------------------------------------
	// TODO prefrences/better default
	public static class VirtualFileDialog extends WorkspaceDialog<VirtualFile> {
		private final Mode mode;

		private final String typeName;

		private final String typeExtension;

		private final VirtualFile initial;

		public static enum Mode {
			OPEN, SAVE
		}

        private static String lastDir = null;

		private static final String SAVE_TITLE = res
				.loadString("fileDialog.save.title"), LOAD_TITLE = res
				.loadString("fileDialog.open.title");

		public VirtualFileDialog(String name, Mode mode, String typeExtension,
				String typeName, VirtualFile initial) {
			super(name, mode == Mode.SAVE ? SAVE_TITLE : LOAD_TITLE, null);
			this.mode = mode;
			this.typeName = typeName;
			this.typeExtension = typeExtension;
			this.initial = initial;
		}

		@Override
		protected VirtualFile _show(Component parent) {
			Frame parentFrame = JOptionPane.getFrameForComponent(parent);

			final FileDialog dialog = new FileDialog(parentFrame);

			// initial
			if (initial != null) {
				dialog.setFile(initial.getName());
				if (initial instanceof LocalVirtualFile) {
					LocalVirtualFile v = (LocalVirtualFile) initial;
					String parentDir = v.getFile().getAbsoluteFile()
							.getParent();
					if (parent != null) lastDir = parentDir;
				}
			}
			if (lastDir != null) dialog.setDirectory(lastDir);
			dialog.setMode(mode == Mode.OPEN ? FileDialog.LOAD
					: FileDialog.SAVE);
			dialog.setTitle(getTitle().replace("{type_name}", typeName));
			dialog.setVisible(true);
			String file = dialog.getFile();
			if (file == null) return null;

			String dir = dialog.getDirectory();

			if (mode == Mode.SAVE && !file.endsWith('.' + typeExtension))
				file = file + '.' + typeExtension;
			File f = new File(dir, file);
			// String lastLastDir=lastDir;
			lastDir = dir;

			// TODO determine what platforms this is neccessary on
			/*
			 * if(f.exists()&&mode==MODE_SAVE){ Object c=new
			 * ConfirmDialog(res.composite(new Object[][]{{
			 * "file_name",file}}),"save.overwrite",false,
			 * ConfirmDialog.WARNING_TYPE)._show(parent);
			 * if(c==ConfirmDialog.CHOICE_NO){ VirtualFile
			 * r=(VirtualFile)_show(parent); if(r==null){ lastDir=lastLastDir;
			 * return null; }else return r; } }
			 */
			return new LocalVirtualFile(f);

		}

		// TODO why no initial???
		public static final VirtualFileDialog createOpenDialog(
				String typeExtension, String typeName) {
			return new VirtualFileDialog("open", Mode.OPEN, typeExtension,
					typeName, null);
		}

		public static VirtualFileDialog createSaveAsDialog(
				String typeExtension, String typeName, VirtualFile initial) {
			return new VirtualFileDialog("save", Mode.SAVE, typeExtension,
					typeName, initial);
		}
	}
}