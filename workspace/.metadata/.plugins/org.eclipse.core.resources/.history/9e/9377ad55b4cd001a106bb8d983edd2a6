package Intermol3D;

import javax.swing.JToggleButton;
import javax.swing.SwingConstants;

import java.awt.Font;
import java.awt.Insets;

public class ToggleButtonEx extends JToggleButton{
	ToggleButtonEx(String name){
	  super();
      setIcon(Const.getImage(name+".gif"));
      setPressedIcon(Const.getImage(name+"2.gif"));
      setSelectedIcon(Const.getImage(name+"2.gif"));
      setDisabledIcon(Const.getImage(name+".gif"));
      setToolTipText (Const.trans(name+".tip"));
      setMargin (new Insets(0, 0, 0, 0));
      setPreferredSize (Const.buttonSize);
      setMaximumSize(Const.buttonSize);
      setMinimumSize(Const.buttonSize);
      setText(Const.trans(name+".label"));
      setFont(new Font("Dialog", 0, 10));   
      setHorizontalTextPosition(SwingConstants.CENTER);
      setVerticalAlignment(SwingConstants.TOP);
      setVerticalTextPosition(SwingConstants.BOTTOM);
	}
}
