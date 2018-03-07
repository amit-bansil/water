/*
 * CREATED ON:    Apr 14, 2006 4:05:59 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import static cps.water.ControlFactory.MED_SPACE;
import static cps.water.ControlFactory.SMALL_SPACE;
import static cps.water.ControlFactory.bindPanelEnabled;
import static cps.water.ControlFactory.createEnumCombo;
import static cps.water.ControlFactory.createFloatSpinner;
import static cps.water.ControlFactory.createToggleButton;
import static cps.water.ControlFactory.createToolbarButton;
import static cps.water.ControlFactory.hSpace;
import cps.jarch.data.DataUtils;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.ROFlag;
import cps.jarch.data.value.tools.RWFlag;
import cps.jarch.data.value.tools.RWValueImp;
import cps.jarch.gui.util.ComponentProxy;
import cps.water.ControlFactory;
import cps.water.AppModel.Model;
import cps.water.moleculedisplay.DisplayModel.ColorScheme;

import javax.swing.Box;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * <p>A {@link ComponentProxy} that edits a {@link DisplayModel}.
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public final class DisplayControls implements ComponentProxy{
	private final JComponent panel;
	public final JComponent getComponent() {
		return panel;
	}
	private DisplayModel target;
	private final Link zoomToTargetL=new Link() {
		@Override public void signal() {
			if(target!=null)target.cameraZoom().setUnchecked(zoom.get());
		}
	};
	private final Link zoomToGUIL=new Link() {
		@Override public void signal() {
			if(target!=null)zoom.setUnchecked(target.cameraZoom().get());
		}
	};
	
	private final void unlink() {
		assert target!=null;		
		target.cameraZoom().disconnect(zoomToGUIL);
		target=null;
	}
	private final void link(DisplayModel m) {
		target=m;
		DataUtils.linkAndSync(target.cameraZoom(),zoomToGUIL);
	}
	public DisplayControls(final ROValue<Model> controlledModel) {
		// components
		// layout
		panel = new JPanel(new BorderLayout(0, 0));
		Box left = Box.createHorizontalBox();
		Box right = Box.createHorizontalBox();

		
		left.add(new JLabel("Zoom"));
		left.add(hSpace(SMALL_SPACE));
		left.add(createFloatSpinner(5f, zoom));
		left.add(hSpace(MED_SPACE));
		
		left.add(new JLabel("Color By:"));
		left.add(hSpace(SMALL_SPACE));
		left.add(createEnumCombo(colorScheme,DisplayModel.ColorScheme.values()));
		left.add(hSpace(MED_SPACE));
		
		left.add(ControlFactory
			.stickTogether(
				createToggleButton(shrinkAtoms, "Shrink Atoms"),
				createToggleButton(spinDisplay, "Spin Display")));
		//left.add(hSpace(MED_SPACE));
		
		right.add(createToolbarButton("Recenter", new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				recenter();
			}		
		}));
		
		panel.add(left,BorderLayout.EAST);
		panel.add(right,BorderLayout.WEST);
		
		bindPanelEnabled(ROFlag.notNull(controlledModel),panel);
		zoom.connect(zoomToTargetL);
		DataUtils.linkAndSync(controlledModel,new Link() {
			@Override public void signal() {
				if(target!=null)unlink();
				Model m=controlledModel.get();
				if(m!=null) {
					link(m.getDisplay());
				}
			}
		});
	}
	// ------------------------------------------------------------------------

	private final RWFlag shrinkAtoms=new RWFlag(true),
		spinDisplay=new RWFlag(false);
	private final BoundedValue<Float> zoom=new BoundedValue<Float>(50f,10f,100f);
	private final RWValue<DisplayModel.ColorScheme> colorScheme=new RWValueImp<DisplayModel.ColorScheme>(
			ColorScheme.Type,false);
	private final void recenter() {
		
	}
}
