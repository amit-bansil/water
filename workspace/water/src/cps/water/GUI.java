/*
 * CREATED ON:    Apr 14, 2006 4:03:14 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.tools.ROFlag;
import cps.jarch.gui.components.LayoutUtils;
import cps.jarch.gui.data.BooleanBinder;
import cps.jarch.simulation.snapshot.SnapshotChooser;
import cps.water.AppModel.Model;
import cps.water.data.DataViewer;
import cps.water.moleculedisplay.DisplayControls;
import cps.water.moleculedisplay.DisplayPanel;
import cps.water.simulation.SimControls;
import cps.water.time.TimeControls;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JComponent;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JToggleButton;
import javax.swing.WindowConstants;
import javax.swing.border.Border;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;

/**
 * <p>TODO document GUI
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
//TODO io for GUI state
public class GUI {
	private final JFrame background;
	private final JDialog frame;
	//TODO remove these controllers and move them into the app?
	private final SimControls simControls;
	final DataViewer dataViewer1,dataViewer2;
	final DisplayPanel primaryDisplay,secondaryDisplay;
	private final JComponent mainSplit,snapshotsSplit,dataSplit,displaySplit;
	public GUI(final Application app) {		
		// disable lightweight popus so they don't conflict with heavyweight
		// components
		JPopupMenu.setDefaultLightWeightPopupEnabled(false);
		
		// setup alloy
		// WARNING this may cause prolems on OSX
		JFrame.setDefaultLookAndFeelDecorated(true);
		JDialog.setDefaultLookAndFeelDecorated(true);
		// register
		/*com.incors.plaf.alloy.AlloyLookAndFeel.setProperty("alloy.licenseCode",
			"u#Amit_Bansil#i30hb#d7jx00");
		// install alloy
		try {
			UIManager.setLookAndFeel(new AlloyLookAndFeel(new BedouinTheme()));
		} catch (UnsupportedLookAndFeelException e) {
			// should not happen
			throw new Error(e);
		}*/
		
		// create black background
		//TODO don't change value of setDefaultLookAndFeelDecorated
		JFrame.setDefaultLookAndFeelDecorated(false);
		background = new JFrame();
		background.setUndecorated(true);
		background.setContentPane(new StripedPane());
		background.setLocation(0, 0);
		background.setSize(Toolkit.getDefaultToolkit().getScreenSize());
		
		// create main frame
		frame=new JDialog(background,"Water",false);
		//frame.setAlwaysOnTop(true);
		frame.setJMenuBar(buildMenuBar());
		
		
		// create components
		dataViewer1=new DataViewer(app.getModel().getDataViewer1Model());
		dataViewer2=new DataViewer(app.getModel().getDataViewer2Model());
		SnapshotChooser<Model> snapshotChooser=new SnapshotChooser<Model>(app.getModel());
		primaryDisplay=new DisplayPanel(app.getModel().primarySelection());
		secondaryDisplay=new DisplayPanel(app.getModel().secondarySelection());
		DisplayControls displayControls=new DisplayControls(app.getModel().focusedSelection());
		simControls=new SimControls(app.getModel().focusedSelection());
		
		setupFocusBinding(primaryDisplay,secondaryDisplay,app.getModel());
		
		// create layout
		JPanel mainPanel=new JPanel(new BorderLayout(0,0));
		JPanel topPanel=new JPanel(new BorderLayout(0,0));
		Box topLeft=Box.createHorizontalBox();
		
		
		/*displaySplit=hSplit(primaryDisplay.getComponent(),
			secondaryDisplay.getComponent());
		dataSplit=vSplit(dataViewer1.getComponent(),
			dataViewer2.getComponent());
		mainSplit=hSplit(dataSplit,mainPanel);
		snapshotsSplit=vSplit(mainSplit,
			snapshotChooser.getComponent());*/
		
		displaySplit=Box.createHorizontalBox();
		displaySplit.add(primaryDisplay.getComponent());
		displaySplit.add(secondaryDisplay.getComponent());
		
		dataSplit=Box.createVerticalBox();
		dataSplit.add(dataViewer1.getComponent());
		dataSplit.add(LayoutUtils.largePad());
		dataSplit.add(dataViewer2.getComponent());
		
		mainSplit=new JPanel(new BorderLayout(12,12));
		mainSplit.add(dataSplit,BorderLayout.WEST);
		mainSplit.add(mainPanel,BorderLayout.CENTER);
		
		snapshotsSplit=new JPanel(new BorderLayout(12,12));
		snapshotsSplit.add(mainSplit,BorderLayout.CENTER);
		snapshotsSplit.add(snapshotChooser.getComponent(),BorderLayout.SOUTH);
		
		
		topLeft.add(new TimeControls(app.getModel()).getComponent());
		topLeft.add(LayoutUtils.largePad());
		topLeft.add(simControls.getComponent());
		topPanel.add(topLeft,BorderLayout.WEST);
		
		mainPanel.add(topPanel,BorderLayout.NORTH);
		mainPanel.add(displayControls.getComponent(),BorderLayout.SOUTH);
		mainPanel.add(displaySplit);
		
		displaySplit.setBorder(BorderFactory.createEmptyBorder(12, 0, 12, 0));
		
		// bindings
		new RotationBinding(primaryDisplay,app.getModel().primarySelection());
		new RotationBinding(secondaryDisplay,app.getModel().secondarySelection());
		// selected display
		BooleanBinder.bindVisibleDown(
			ROFlag.notNull(app.getModel().secondarySelection()), secondaryDisplay.getComponent());
		
		// data/snapshots visible
		dataSplit.setVisible(false);
		snapshotChooser.getComponent().setVisible(false);
		JToggleButton chartsVis=ControlFactory.createVisibilityToggle(dataSplit, "Charts","table.png");
		JToggleButton snapshotsVis=ControlFactory.createVisibilityToggle(snapshotChooser.getComponent(), "Snapshots","snapshots.png");
		topPanel.add(ControlFactory.stickTogether(chartsVis, snapshotsVis),BorderLayout.EAST);
		
		snapshotsSplit.setBorder(BorderFactory.createEmptyBorder(12, 10, 12, 12));
		
		frame.setContentPane(snapshotsSplit);
		
		// TODO proper quit
		frame.setDefaultCloseOperation(WindowConstants.DISPOSE_ON_CLOSE);
		frame.addWindowListener(new WindowAdapter() {
			@Override public void windowClosed(WindowEvent e) {
				background.dispose();
				app.shutdown();
				primaryDisplay.shutdown();
				secondaryDisplay.shutdown();
				dataViewer1.shutdown();
				dataViewer2.shutdown();
				ControlFactory.shutdown();
				//TODO real shutdown
				System.exit(0);
			}
		});
	}
	private static final Border normBorder=BorderFactory.createLineBorder(Color.BLACK,7);
	private static final Border focusBorder=BorderFactory.createLineBorder(Color.orange.darker(),7);
	private void setupFocusBinding(final DisplayPanel primaryDisplay,
			final DisplayPanel secondaryDisplay,final AppModel model) {
		Link selL=new Link() {
			@Override public void signal() {
				Border pb=normBorder,sb=normBorder;
				if(model.unFocusedSelection().get()==null) {
					//both borders normal
				}else if(model.isPrimarySelected()) {
					pb=focusBorder;
				}else {
					sb=focusBorder;
				}
				primaryDisplay.getComponent().setBorder(pb);
				secondaryDisplay.getComponent().setBorder(sb);
			}
		};
		
		model.focusedSelection().connect(selL);
		model.unFocusedSelection().connect(selL);
		
		primaryDisplay.addMouseListener(new MouseAdapter() {
			@Override public void mouseClicked(MouseEvent e) {
				model.selectPrimarySnapshot();
			}
		});
		secondaryDisplay.addMouseListener(new MouseAdapter() {
			@Override public void mouseClicked(MouseEvent e) {
				model.selectSecondarySnapshot();
			}
		});	
	}
	private final String[][] menus = new String[][]{{"File", "Open", "Save", "Save As",
			"Revert", "-", "Import...", "Export...", "-", "Exit"},
			{"Display","#Shrink Molecules","#Show Traces","Recenter","#Spin","-","Options..."},
			{"Simulate","Start/Stop","Run For...","Add Ion","-","Options..."},
			{"View","#Charts","#Snapshots","#Comparison"},
			{"Help","User Guide","Water Online","-","About"}};
	//TODO real file menu
	private JMenuBar buildMenuBar() {
		final JMenuBar ret=new JMenuBar();
		for(int i=0;i<menus.length;i++) {
			String[] items=menus[i];
			JMenu menu=new JMenu(items[0]);
			for(int j=1;j<items.length;j++) {
				String n=items[j];
				if(n.startsWith("#")) {
					n.substring(1);
					menu.add(new JCheckBoxMenuItem(n));
				}else if(n.equals("-")){
					menu.addSeparator();
				}else {
					menu.add(new JMenuItem(n));
				}
			}
			ret.add(menu);
		}
		return ret;
	}

	public void show() {
		frame.pack();
		//TODO find out why min size is tweaking
		frame.setMinimumSize(new Dimension(50,50));
		frame.setSize(new Dimension(1000,700));
		//centerframe on screen
		frame.setLocationRelativeTo(null);
		//displaySplit.setDividerLocation(0.5f);
		background.setVisible(true);
		frame.setVisible(true);
		frame.toFront();
	}
}