package org.cps.framework.core.gui.action;

import org.cps.framework.core.util.BasicDescription;
import org.cps.framework.util.resource.reader.DefaultReader;
import org.cps.framework.util.resource.reader.IconReader;
import org.cps.framework.util.resource.reader.IntReader;
import org.cps.framework.util.resource.reader.ObjectReader;
import org.cps.framework.util.resources.accessor.ResourceAccessor;

import javax.swing.Icon;
import javax.swing.KeyStroke;

import java.awt.Toolkit;
import java.awt.event.KeyEvent;

/**
 * @version 0.1
 * @author Amit Bansil
 */
public class ActionDescription extends BasicDescription {
	public ActionDescription(ResourceAccessor parentRes, String name) {
		super(parentRes, name);
	}

	//keys
	private static final String MNEMONIC_KEY = "mnem";

	private static final String MNEMONIC_INDEX_KEY = "mnemIndex";

	private static final String ACCELERATOR_KEY = "accel";

	private static final String DISABLED_ICON_KEY = "icon_disabled";

	//readers
	private static final ObjectReader<KeyStroke> AcceleratorReader = new DefaultReader<KeyStroke>() {
		private final String CMD = "CMD";

		private final int mod = Toolkit.getDefaultToolkit()
				.getMenuShortcutKeyMask();

		protected KeyStroke _read(String data, String currentDirectory) {
			if (data.startsWith(CMD)) {
				data = data.substring(CMD.length()).trim();
				KeyStroke i = KeyStroke.getKeyStroke(data);
				return KeyStroke.getKeyStroke(i.getKeyCode(), i.getModifiers()
						| mod);
			} else {
				return KeyStroke.getKeyStroke(data);
			}
		}
	};

	private static final ObjectReader<Integer> MnemonicReader = new DefaultReader<Integer>() {
		protected Integer _read(String data, String currentDirectory)
				throws Exception {
			try {
				return (Integer) KeyEvent.class.getField(
						"VK_" + data.toUpperCase()).get(null);
			} catch (IllegalAccessException e) {
				throw new UnknownError();
			} catch (NoSuchFieldException e) {
				throw new Error("expected KeyEvent VK code, instead:" + data, e);
			}
		}
	};

	//access
	public final Icon getDisabledIcon() {
		return getData().getObject(DISABLED_ICON_KEY, IconReader.INSTANCE);
	}
	public final boolean hasDisabledIcon() {
		return getData().hasKey(DISABLED_ICON_KEY);
	}
	public final KeyStroke getAccelerator() {
		return getData().getObject(ACCELERATOR_KEY, AcceleratorReader);
	}

	public final int getMnemonicKeyCode() {
		return (getData().getObject(MNEMONIC_KEY, MnemonicReader)).intValue();
	}

	public final int getMnemonicIndex() {
		return (getData().getObject(MNEMONIC_INDEX_KEY, new IntReader(0,
				getTitle().length() - 1))).intValue();
	}

	public final boolean hasAccelerator() {
		return getData().hasKey(ACCELERATOR_KEY);
	}

	public final boolean hasMnemonic() {
		return hasMnemonicKeyCode() || hasMnemonicIndex();
	}

	public final boolean hasMnemonicKeyCode() {
		return getData().hasKey(MNEMONIC_KEY);
	}

	public final boolean hasMnemonicIndex() {
		return getData().hasKey(MNEMONIC_INDEX_KEY);
	}
}