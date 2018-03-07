package Intermol3D;
import javax.swing.JDesktopPane;
import javax.swing.JWindow;

import java.awt.Color;

public final class BlackWindow extends JWindow{
	private final JDesktopPane desktop=new JDesktopPane();
	public BlackWindow(){
		super();
		setBackground(Color.black);
		setLocation(0,0);
		setSize(getToolkit().getScreenSize().width,getToolkit().getScreenSize().height);
		//setTrueVisibility(true);
		setVisible(true);
		desktop.setBackground(Color.black);
		desktop.putClientProperty("JDesktopPane.dragMode", "outline");
		setContentPane(desktop);
	}
	
	
	private boolean trueVisibility=true;
	public void setTrueVisibility(boolean v){
		trueVisibility=v;
		setVisible(v);
	}
	/*public void show(){
		setVisible(true);
	}*/
	/*public void setVisible(boolean v){
		if(trueVisibility) super.setVisible(v);
		else super.setVisible(false);
	}*/
	
	public JDesktopPane getDesktop(){
		return desktop;
	}
}