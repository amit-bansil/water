package Intermol3D;

import javax.swing.JButton;
import javax.swing.SwingConstants;

import java.awt.Font;
import java.awt.Insets;

public class ToolbarButtonEx extends JButton{
	ToolbarButtonEx(String name){
		this(name,true);
	}
	ToolbarButtonEx(String name,boolean v){
	  super();
      setIcon(Const.getImage(name+".gif"));
      setPressedIcon(Const.getImage(name+"2.gif"));
      if(!v) setDisabledIcon(Const.getImage(name+".gif"));
      else setDisabledIcon(Const.getImage(name+"D.gif"));
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
