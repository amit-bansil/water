package Intermol3D;

import javax.swing.JWindow;
import javax.swing.Timer;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public final class ISplashScreen extends JWindow{
	Image splash;
	String state;
        private static final int CLIP=0;
	private static final Font stateFont=new Font("Sans Serif",Font.PLAIN,10);
	boolean justText=false;
	public ISplashScreen(){ 
		splash = Const.getImage("Intermol3D.gif").getImage();
		int w=splash.getWidth(this),h=splash.getHeight(this);
		setSize(w,(h+12)-CLIP);
		
		state=" ";
		
		Dimension screenDim = Toolkit.getDefaultToolkit().getScreenSize();
        Rectangle winDim = getBounds();
        setLocation((screenDim.width - winDim.width) / 2,
               (screenDim.height - winDim.height) / 2);	
        setVisible(true);
        Graphics g = getGraphics(); paint(g);
        
	}
	
	public void dispose(){
		Timer remove=new Timer(1000,new ActionListener(){
			public void actionPerformed(ActionEvent e){
				kill();
			}
		});
		remove.setRepeats(false);
		remove.start();
	}
	public void kill(){
		super.dispose();
	}
	public void update(Graphics g){
		paint(g);
	}
	public void paint(Graphics g){
		if(!justText)
			g.drawImage(splash,0,0,this);
		justText=false;
                int width=getSize().width;
                int height=getSize().height;
                
		g.setFont(stateFont);
                g.setColor(Color.darkGray);
		g.drawLine(0,0,0,height);
                g.drawLine(0,0,width,0);
                g.drawLine(width-1,0,width-1,height);
                g.fillRect(0,height-13,width,13);
		g.setColor(Color.lightGray);
		g.drawString(state,2,height-4);
	}
	public void setState(String s){
		state = "Initializing: "+s+"...";
		justText = true;
		Graphics g = getGraphics(); paint(g);
	}
	public String toString(){
		return "ISplashScreen\n";
	}
}