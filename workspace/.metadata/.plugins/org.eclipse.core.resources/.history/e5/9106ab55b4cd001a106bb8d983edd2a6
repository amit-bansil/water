package Intermol3D;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

public class SliderGroupEx extends JSlider{
    private final JLabel name, value;
    public SliderGroupEx(String nae){
        super();
        this.name=new JLabel(Const.trans(nae+".label"));	
        setToolTipText(Const.trans(nae+".tip"));
        value=new JLabel("--");

        SwingEx.lockSize(value);
        value.setForeground (java.awt.Color.black);
        addChangeListener(new ChangeListener(){
            public void stateChanged(ChangeEvent e) {
                value.setText(SwingEx.round(getRealValue()));
            }
        });
        addPropertyChangeListener("enabled",new PropertyChangeListener(){
            public void propertyChange(PropertyChangeEvent evt){
                name.setEnabled(isEnabled());
                value.setEnabled(isEnabled());
            }
        });

    }
    public void setLabel(String l){
        name.setText(l);
    }
	private double conversion=1,translation=0;
	private final int realToInternal(double v){
		return (int)Math.round((v+translation)*conversion);
	}
	private final double internalToReal(int v){
		return (((double)v)/conversion)-translation;
	}
	private final int scaleInternal(int r){
		if(r>getMaximum()) return getMaximum();
		else if(r<getMinimum()) return getMinimum();
		else return r;
	}
	private final double getRealMinimum(){
		return internalToReal(getMinimum());
	}
	private final double getRealMaximum(){
		return internalToReal(getMaximum());
	}
	private final double scaleReal(double r){
		if(r>getRealMaximum())return getRealMaximum();
		else if(r<getRealMinimum())return getRealMinimum();
		else return r;
	}
	public void setRealValue(double v){
		super.setValue(scaleInternal(realToInternal(v)));
		value.setText(SwingEx.round(v));
	}
	public double getRealValue(){
		return internalToReal(getValue());
	}
    public void setRealBounds(double max,double min,double conversion){
    	this.conversion=conversion;
    	this.translation=min<0?-min:0;
    	setMaximum(realToInternal(max));
    	setMinimum(realToInternal(min));
    	if(getRealMaximum()<=getRealMinimum())throw new IllegalArgumentException("invalid range:"+getRealMaximum()+"<="+getRealMinimum());
    }
    public JPanel getPanel(){
        JPanel sliderPanel= new JPanel();
        sliderPanel.setLayout(new GridBagLayout());
        GridBagConstraints gridBagConstraints2 = new java.awt.GridBagConstraints ();
        gridBagConstraints2.gridx = 0;
        gridBagConstraints2.gridy = 1;
        gridBagConstraints2.gridwidth = 2;
        gridBagConstraints2.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints2.anchor = java.awt.GridBagConstraints.NORTHEAST;
        gridBagConstraints2.weightx = 1.0;
        gridBagConstraints2.weighty = 1.0;
        sliderPanel.add(this, gridBagConstraints2);

        gridBagConstraints2 = new java.awt.GridBagConstraints ();
        gridBagConstraints2.gridx = 0;
        gridBagConstraints2.gridy = 0;
        gridBagConstraints2.insets = new java.awt.Insets (0, 6, 0, 6);
        gridBagConstraints2.weightx = 0.0;
        gridBagConstraints2.anchor = java.awt.GridBagConstraints.NORTHWEST;	      
        sliderPanel.add (name, gridBagConstraints2);

        gridBagConstraints2 = new java.awt.GridBagConstraints ();
        gridBagConstraints2.gridx =1;
        gridBagConstraints2.gridy = 0;
        gridBagConstraints2.weightx = 1.0;
        gridBagConstraints2.fill = java.awt.GridBagConstraints.NONE;
        gridBagConstraints2.insets = new java.awt.Insets (0, 6, 0, 12);
        gridBagConstraints2.anchor = java.awt.GridBagConstraints.NORTHEAST;
        sliderPanel.add (value, gridBagConstraints2);

        return sliderPanel;
    }
}