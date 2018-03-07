/*
 * CREATED ON:    Jul 28, 2005 3:53:13 PM
 * CREATED BY:     Amit Bansil 
 */
package cps.jarch.simulation.components;

import cps.jarch.data.io.CompositeDataBuilder;
import cps.jarch.data.io.SaveableData;
import cps.jarch.data.io.SaveableDataProxy;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.gui.builder.EditorPanelBuilder;
import cps.jarch.gui.components.CELESTLook;
import cps.jarch.gui.data.BooleanBinder;
import cps.jarch.gui.util.ComponentProxy;
import cps.jarch.util.misc.LangUtils;

import javax.swing.JComponent;
import javax.swing.JPanel;

import java.awt.BorderLayout;

/**
 * A panel, or 'room' of a simulation's gui. call build when done registering
 * editors before getData() or getComponent(). maintains a property for
 * showing/hiding all editors.<br>
 * ID: $Id$
 */
public class SimulationPanel implements SaveableDataProxy, ComponentProxy {
	// ------------------------------------------------------------------------
    public SimulationPanel(ComponentProxy canvas){
        this(canvas.getComponent());
    }
    public SimulationPanel(JComponent canvas) {
		LangUtils.checkArgNotNull(canvas, "canvas");
		// layout
		panel = new JPanel(new BorderLayout(CELESTLook.getInstance()
			.getLargePadSize(), 0));
		// data
		dataBuilder = new CompositeDataBuilder(4);
		dataBuilder.regChild(editorsVisible,"editorsVisible");
		registerData(dataBuilder);
		//editors
		editors=new EditorPanelBuilder();
	}
//	@SuppressWarnings({"MethodMayBeStatic"})
    protected void registerData(CompositeDataBuilder ldata) {
        throw new UnsupportedOperationException();
        //hook for subclasses
	}
	// ------------------------------------------------------------------------

	public final void build() {
		if (built) throw new IllegalStateException("built");
		editors.build();
		
		dataBuilder.regChild(editors,"editors");
		
		JComponent  ep=editors.getComponent();
		BooleanBinder.bindVisible(editorsVisible,ep);
		panel.add(ep,BorderLayout.WEST);
		
		data = dataBuilder.create();
		built = true;
	}

	// ------------------------------------------------------------------------
	// editors- panels stacked vertically on right of screen
	private final EditorPanelBuilder editors;

	public final void addEditor(EditorPanelBuilder.Editor e) {
		editors.addEditor(e);
	}
	//editorsVisible
	private final RWValueImp<Boolean> editorsVisible = new RWValueImp<Boolean>(
		true);

	/**
	 * whether or not to show the editors.<br>
	 * It is a non-null object of type: Boolean.<br>
	 * Initial Value: true<br>
	 *
	 * @return RWValue access to editorsVisible, constant.
	 */
	public final RWValue<Boolean> editorsVisible() {
		return editorsVisible;
	}
	// ------------------------------------------------------------------------
	private boolean built = false;

	private final CompositeDataBuilder dataBuilder;

	private SaveableData data;

	public SaveableData getData() {
		if (!built) throw new IllegalStateException("!built");
		return data;
	}

	private final JComponent panel;

	public JComponent getComponent() {
		if (!built) throw new IllegalStateException("!built");
		return panel;
	}

}
