/*
 * CREATED ON:    Apr 20, 2006 1:17:24 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water;

import com.incors.plaf.alloy.AlloyCommonUtilities;

import cps.jarch.data.event.Unlinker;
import cps.jarch.data.value.ROValue;
import cps.jarch.data.value.RWValue;
import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.RWFlag;
import cps.jarch.gui.builder.NumberEditorFactory;
import cps.jarch.gui.data.BooleanBinder;
import cps.jarch.gui.data.MiscBinder;
import cps.jarch.gui.data.NumberBinder;
import cps.jarch.gui.resources.ImageLoader;

import javax.swing.BorderFactory;
import javax.swing.Box;
import javax.swing.Icon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComboBox;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.JSpinner;
import javax.swing.JToggleButton;
import javax.swing.JWindow;
import javax.swing.SwingConstants;
import javax.swing.border.LineBorder;
import javax.swing.text.JTextComponent;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.Point;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.event.ComponentListener;
import java.awt.event.FocusEvent;
import java.awt.event.FocusListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

/**
 * <p>TODO document ControlFactory
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
//TODO build icons right in here, add tooltips later
public class ControlFactory {
	public static final JToggleButton createVisibilityToggle(Component c,String name,String iconName) {
		RWValue<Boolean> visprop=new RWFlag(c.isVisible());
		BooleanBinder.bindVisible(visprop, c);
		JToggleButton ret=createToggleButton(visprop,name);
		ret.setIcon(loadIcon(iconName));
		ret.setMargin(new Insets(0,10,0,16));
		return ret;
	}
	//private static final Border toggleBorder=AlloyCommonBorderFactory.createAlternativeToolBarButtonBorder();
	public static final JToggleButton createToggleButton(RWValue<Boolean> src,String name) {
		JToggleButton ret=new JToggleButton(name);
		BooleanBinder.bindToggleButton(src, ret);
		//ret.setBorder(toggleBorder);
		return ret;
	}
	//private static final Border smallBorder=AlloyCommonBorderFactory.createSmallButtonBorder();
	public static final JButton createToolbarButton(String name,ActionListener al) {
		JButton ret=new JButton(name);
		ret.addActionListener(al);
		return ret;
	}
	//TODO hack these buttons together in photoshop so they look like itunes buttons
	public static final JButton createImportantButton(String name,Icon icon, ActionListener al) {
		JButton ret=createToolbarButton(name, al);
		ret.setIcon(icon);
		ret.setMargin(new Insets(0,10,0,16));
		//ret.setBorder(smallBorder);
		AlloyCommonUtilities.set3DBackground(ret, Color.WHITE);
		return ret;
	}
	public static final JCheckBox createCheckBox(String title,RWValue<Boolean> target) {
		JCheckBox ret=new JCheckBox(title);
		BooleanBinder.bindCheckBox(target,ret);
		return ret;
	}

	public static final void shutdown() {
		sliderPopup.shutdown();
	}
	private static final class SliderPopup{
		private static final void updatePosition(Component target,Component popup) {
			Rectangle targetBounds=new Rectangle(target.getLocationOnScreen(),target.getSize());
			Dimension popupSize=popup.getSize();
			Rectangle screenBounds=target.getGraphicsConfiguration().getBounds();
			
			// add some space around the target
			//targetBounds.width+=SMALL_SPACE;
			targetBounds.height+=MED_SPACE*2;
			//targetBounds.x-=SMALL_SPACE;
			targetBounds.y-=MED_SPACE;

			boolean leftAlign=true;//otherwise right
			boolean bottomAlign=true;//otherwise top
			//if right edge offscreen right align
			if(targetBounds.x+popupSize.getWidth()>screenBounds.width+screenBounds.x)leftAlign=false;
			//if bottom edge offscreen top align
			if(targetBounds.y+targetBounds.getHeight()+popupSize.height>screenBounds.height+screenBounds.y)bottomAlign=false;
			
			Point popupLocation=new Point();
			if(leftAlign)popupLocation.x=targetBounds.x;
			else popupLocation.x=(targetBounds.x+targetBounds.width)-popupSize.width;
			
			if(bottomAlign)popupLocation.y=targetBounds.y+targetBounds.height;
			else popupLocation.y=targetBounds.y-popupSize.height;
			
			popup.setLocation(popupLocation);
		}
		
		private final JWindow window=new JWindow();
		private final JSlider slider = new JSlider(SwingConstants.HORIZONTAL);
		public final void shutdown() {
			window.dispose();
		}
		public SliderPopup() {
			slider.setPaintTrack(true);
			slider.setPaintLabels(false);
			slider.setPaintTicks(false);
			slider.setFocusable(false);

			final JButton sliderButton=new JButton(loadIcon("ok"));
			sliderButton.setRolloverEnabled(true);
			sliderButton.setMargin(new Insets(0,0,0,0));
			sliderButton.setBorderPainted(false);
			sliderButton.setBackground(null);
			sliderButton.setOpaque(false);
			sliderButton.addMouseListener(new MouseAdapter() {
				@Override public void mouseExited(MouseEvent e) {
					sliderButton.setBorderPainted(false);
				}
				@Override public void mouseEntered(MouseEvent e) {
					sliderButton.setBorderPainted(true);
				}
			});
			//sliderButton.setBorder(AlloyCommonBorderFactory.createSmallButtonBorder());
			sliderButton.setFocusable(false);
			
			window.setAlwaysOnTop(true);
			window.setFocusable(false);
			window.setFocusableWindowState(false);
			JComponent content=new JPanel(new BorderLayout(0,0));
			content.add(slider,BorderLayout.CENTER);
			content.add(sliderButton,BorderLayout.EAST);
			content.setBorder(
				BorderFactory.createCompoundBorder(LineBorder.createGrayLineBorder(),
					BorderFactory.createEmptyBorder(SMALL_SPACE, SMALL_SPACE, SMALL_SPACE, SMALL_SPACE))
				);
			window.setContentPane(content);
			
			window.pack();
			
			sliderButton.addActionListener(new ActionListener() {
				public void actionPerformed(ActionEvent e) {
					window.setVisible(false);
					currentTarget=null;
				}
			});
		}
		private JSpinner currentTarget;
		private Unlinker targetLink;
		private final void show() {
			if(!window.isVisible()) {
				updatePosition();
				window.setVisible(true);
				if(targetLink!=null)targetLink.unlink();
				targetLink=NumberBinder.bindSlider(currentTarget, slider, 
					((Float)currentTarget.getClientProperty(STEP_PROPERTY_KEY)).doubleValue());
			}
		}
		private final void hide() {
			System.err.println("hide");
			window.setVisible(false);
			if(targetLink!=null) {
				targetLink.unlink();
				targetLink=null;
			}
		}
		private final void updatePosition() {
			updatePosition(currentTarget,window);
		}
		private final Object STEP_PROPERTY_KEY=new Object();
		public final void connect(JSpinner s,float step) {
			s.addComponentListener(componentListener);
			((JSpinner.DefaultEditor)s.getEditor())
			.getTextField().addFocusListener(focusListener);
			s.addPropertyChangeListener("enabled",enabledListener);
			s.putClientProperty(STEP_PROPERTY_KEY, step);
		}
		public final void changeStep(JSpinner s, float step) {
			if (s.getClientProperty(STEP_PROPERTY_KEY) == null)
				throw new IllegalArgumentException("can't change step for Slider " + s
						+ " because it is not connected to " + this);
			s.putClientProperty(STEP_PROPERTY_KEY, step);
			// rebind if we're showing
			if (currentTarget == s && targetLink != null) {
				targetLink.unlink();
				targetLink=NumberBinder.bindSlider(currentTarget, slider, step);
			}
		}
		public final void disconnect(JSpinner s) {
			s.removeComponentListener(componentListener);
			((JSpinner.DefaultEditor)s.getEditor())
			.getTextField().removeFocusListener(focusListener);
			s.removePropertyChangeListener("enabled",enabledListener);
			s.putClientProperty(STEP_PROPERTY_KEY, null);
			if(currentTarget==s) {
				hide();
				currentTarget=null;
			}
		}
		private final PropertyChangeListener enabledListener=new PropertyChangeListener() {
			public void propertyChange(PropertyChangeEvent evt) {
				if(currentTarget==evt.getSource()) {
					if(currentTarget.isEnabled()&&currentTarget.isShowing()) {
						show();
					}else {
						hide();
					}
				}
			}
		};
		private final ComponentListener componentListener=new ComponentListener() {
		
			public void componentShown(ComponentEvent e) {
				if(currentTarget==e.getComponent()&&e.getComponent().isEnabled()) {
					show();
				}
			}
		
			public void componentResized(ComponentEvent e) {
				if(currentTarget==e.getComponent())
					updatePosition();
			}
		
			public void componentMoved(ComponentEvent e) {
				if(currentTarget==e.getComponent())
					updatePosition();
			}
		
			public void componentHidden(ComponentEvent e) {
				if(currentTarget==e.getComponent()) {
					hide();
				}
			}
		};
		
		private final FocusListener focusListener=new FocusListener() {
			public void focusGained(FocusEvent e) {
				//this is a hack to get the spinner from its textfield
				currentTarget=(JSpinner)e.getComponent().getParent().getParent();
				if(e.getComponent().isShowing()&&e.getComponent().isEnabled()) {
					show();
				}else {
					hide();
				}
			}

			public void focusLost(FocusEvent e) {
				Component topParentOfNewFocus=e.getOppositeComponent();
				while(topParentOfNewFocus!=null) {
					//ignore focus lost when new focus is this
					if(topParentOfNewFocus==window)return;
					topParentOfNewFocus=topParentOfNewFocus.getParent();
				}
				if(currentTarget==e.getComponent().getParent().getParent()) {
					hide();
					currentTarget=null;
				}
			}
		};
	}
	private static final SliderPopup sliderPopup=new SliderPopup();

	public static final JSpinner createFloatSpinner(float step,BoundedValue<Float> source) {
		final JSpinner ret=NumberEditorFactory.createFloatSpinner(step, source);
		//increase number of steps by 10x;
		sliderPopup.connect(ret,step/10);
		return ret;
	}
	public static final JSlider createFloatSlider(JSpinner s,float minStep) {
		return NumberEditorFactory.createLightSlider(s, minStep);
	}
	public static final <T extends Enum> JComboBox createEnumCombo(RWValue<T> src,T[] values) {
		JComboBox ret=new JComboBox(values);
		MiscBinder.bindComboBox(src, ret, values);
		return ret;
	}
	
	public static final void bindPanelEnabled(ROValue<Boolean> source,JComponent target) {
		BooleanBinder.bindPanelEnabled(source, target);
	}
	public static final void bindEnabled(ROValue<Boolean> source,JComponent target) {
		BooleanBinder.bindControlEnabled(source, target);
	}
	public static final JComponent stickTogether(JComponent... cs) {
		JComponent result=new JPanel(new GridLayout(1,cs.length,MED_SPACE,0));
		for(Component c:cs)result.add(c);
		return result;
	}
	public static final int SMALL_SPACE=2,MED_SPACE=6,LARGE_SPACE=12;
	public static final Component vSpace(int s) {
		return Box.createRigidArea(new Dimension(0,s));
	}
	public static final Component hSpace(int s) {
		return Box.createRigidArea(new Dimension(s,0));
	}

	private static ImageLoader icons;

	public static final Unlinker bindText(RWValue<String> value,JTextComponent f) {
		return MiscBinder.bindText(value, f);
	}
	
	public static final Icon loadIcon(String name) {
		if(icons==null)icons=ImageLoader.create(ControlFactory.class);
		return icons.loadIcon(name);
	}
}
