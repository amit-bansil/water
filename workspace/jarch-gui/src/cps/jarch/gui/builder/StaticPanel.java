/*
 * CREATED ON:    Aug 12, 2005 4:13:06 AM
 * CREATED BY:    Amit Bansil 
 */
package cps.jarch.gui.builder;

import cps.jarch.gui.resources.Described;
import cps.jarch.gui.resources.DescribedImpl;
import cps.jarch.gui.resources.DescribedProxy;
import cps.jarch.gui.resources.MessageBundle;
import cps.jarch.gui.util.ComponentProxy;
import cps.jarch.util.notes.Constant;
import cps.jarch.util.notes.Hook;

import javax.swing.JComponent;

/**
 * A fairly discrete piece of a UI that the user can identify by means of a
 * {@link cps.jarch.gui.resources.Described} object.
 * <code>StaticPanels</code> are fairly constant in that both their
 * description and component are immutable. Typically a subsystem will create a
 * StaticPanel which the GUI then adds to the main frame with some representation
 * of its description. When the panel is made enabled/visible setActive(true) is
 * called and when it is hidden/disabled setActive(false) is called.
 * 
 * @version $Id: StaticPanel.java 526 2005-08-31 21:07:46Z bansil $
 * @author Amit Bansil
 */
public class StaticPanel implements DescribedProxy,
		ComponentProxy {
	private final JComponent c;

	private final DescribedImpl description;

	public final @Constant JComponent getComponent() {
		return c;
	}

	public final @Constant Described getDescription() {
		return description;
	}

	public StaticPanel(JComponent c, MessageBundle res, String name) {
		this.c = c;
		this.description = new DescribedImpl(res, name);
	}
	
	private boolean active=false;
	/**
	 * Used by clients to notify implementations if they need to keep this
	 * <code>StaticPanel</code> updated. Ignored if <code>setActive</code>
	 * is called with the same value as <code>isActive()</code>. Initially
	 * <code>false</code>. Since no harm is done by updating even when not
	 * active, this is meant as an optimization. Consequently, clients should
	 * not break if a subpanel's contents are updated even when it is not
	 * active. Similarly, clients are not required to ever call
	 * <code>setActive(false)</code>.
	 */
	public final void setActive(boolean v) {
		if(active!=v) {
			active=v;
			_setActive(v);
		}
	}
	public final boolean isActive() {
		return active;
	}
	/**
	 * Hook to notify implementation that it should start/stop updating the
	 * contents of the component. Only called when isActive changes.
	 * Implementations may ignore this message and just always update their
	 * contents. Clients are not required to ever call
	 * <code>setActive(false)</code>, so that should not be used for cleanup.
	 */
	@Hook protected void _setActive(boolean v) {
		//empty
	}
}