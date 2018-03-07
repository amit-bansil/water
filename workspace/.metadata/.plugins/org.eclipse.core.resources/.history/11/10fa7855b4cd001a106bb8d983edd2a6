package Intermol3D;

import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JPanel;

import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
public class ComboGroupEx extends JComboBox{
    private final JLabel name;
    public ComboGroupEx(String nae){
        super();
        this.name = new JLabel(Const.trans(nae)); 

        addPropertyChangeListener("enabled",new PropertyChangeListener(){
            public void propertyChange(PropertyChangeEvent evt){
                name.setEnabled(isEnabled());
            }
        });
    }
    public JPanel getPanel(){
        JPanel x=new JPanel(new GridBagLayout());

        GridBagConstraints gridBagConstraints3 = new GridBagConstraints ();
        gridBagConstraints3.gridx = 0;
        gridBagConstraints3.gridy = 0;
        gridBagConstraints3.fill = java.awt.GridBagConstraints.HORIZONTAL;
        gridBagConstraints3.insets = new java.awt.Insets (0, 0, 2, 2);
        gridBagConstraints3.anchor = GridBagConstraints.WEST;
        gridBagConstraints3.weightx = 0.0;
        x.add (name, gridBagConstraints3);
		
		gridBagConstraints3 = new GridBagConstraints ();
        gridBagConstraints3.gridx = 0;
        gridBagConstraints3.gridy = 1;
        gridBagConstraints3.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints3.insets = new java.awt.Insets (0, 0, 0, 0);
        gridBagConstraints3.anchor = GridBagConstraints.WEST;
        gridBagConstraints3.weightx = 1.0;
        gridBagConstraints3.weighty = 1.0;
        x.add (this, gridBagConstraints3);
       // x.setAlignmentX(0.0f);
        return x;
    }
    public JPanel getHorizontalPanel(){
        JPanel x=new JPanel(new GridBagLayout());

        GridBagConstraints gridBagConstraints3 = new GridBagConstraints ();
        gridBagConstraints3.gridx = 0;
        gridBagConstraints3.gridy = 0;
        gridBagConstraints3.fill = java.awt.GridBagConstraints.VERTICAL;
        gridBagConstraints3.insets = new java.awt.Insets (0, 0, 0, 2);
        gridBagConstraints3.anchor = GridBagConstraints.WEST;
        gridBagConstraints3.weightx = 0.0;
        x.add (name, gridBagConstraints3);
		
		gridBagConstraints3 = new GridBagConstraints ();
        gridBagConstraints3.gridx = 1;
        gridBagConstraints3.gridy = 0;
        gridBagConstraints3.fill = java.awt.GridBagConstraints.BOTH;
        gridBagConstraints3.insets = new java.awt.Insets (0, 0, 0, 0);
        gridBagConstraints3.anchor = GridBagConstraints.WEST;
        gridBagConstraints3.weightx = 0.0;
        gridBagConstraints3.weighty = 1.0;
        x.add (this, gridBagConstraints3);
        
        return x;
    }
}