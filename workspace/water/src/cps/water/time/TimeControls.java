/*
 * CREATED ON:    May 1, 2006 10:11:39 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.time;

import cps.jarch.data.event.GenericLink;
import cps.jarch.data.event.tools.DelayedLink;
import cps.jarch.data.event.tools.Link;
import cps.jarch.data.value.tools.RWFlag;
import cps.jarch.gui.util.EDTWorker;
import cps.water.AppModel;
import cps.water.ControlFactory;

import javax.swing.Box;
import javax.swing.Icon;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JPanel;

import java.awt.CardLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.EventObject;
import java.util.concurrent.TimeUnit;

/**
 * <p>TODO document TimeControls
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class TimeControls {
	private static final Icon playIcon=ControlFactory.loadIcon("play.png");
	private static final Icon pauseIcon=ControlFactory.loadIcon("pause.png");
	private static final String playTitle="Start",pauseTitle="Stop";
	private final JComponent c;
	private final TimeModel time;
	private final AppModel model;
	public final JButton playButton,pauseButton;
	public TimeControls(final AppModel model) {
		time = model.getTimeModel();
		this.model = model;
		playButton = ControlFactory.createImportantButton(playTitle, playIcon,
			new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					running().set(true);
				}
			});
		pauseButton = ControlFactory.createImportantButton(pauseTitle, pauseIcon,
			new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					running().set(false);
				}
			});

		final CardLayout playPanelLayout = new CardLayout();
		final JPanel playPausePanel = new JPanel(playPanelLayout);
		playPausePanel.add(playButton, playTitle);
		playPausePanel.add(pauseButton, pauseTitle);

		c = Box.createHorizontalBox();
		c.add(playPausePanel);
		//TODO add back step control
		//it was causing focus problems
		//c.add(LayoutUtils.mediumPad());
		//c.add(ControlFactory.createFloatSpinner(1f, time.getStepsPerSecond()));
		
		GenericLink<EventObject> playPauseLink = DelayedLink.createConditionalLink(
			EDTWorker.getInstance(), 0, TimeUnit.MILLISECONDS, new Link() {
				@Override public void signal() {
					playPanelLayout.show(playPausePanel, running().get() ? pauseTitle
							: playTitle);
					if(running().get()) {
						pauseButton.requestFocusInWindow();
					}else
						playButton.requestFocusInWindow();
				}
			});
		time.getRunning(false).connect(playPauseLink);
		time.getRunning(true).connect(playPauseLink);
		model.focusedSelection().connect(playPauseLink);
		playButton.setDefaultCapable(true);
		pauseButton.setDefaultCapable(true);
	
		playPauseLink.signal(null);
		
	}
	
	private final RWFlag running() {
		return time.getRunning(model.isPrimarySelected());
	}
	
	public final JComponent getComponent() {
		return c;
	}
}