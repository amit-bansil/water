package Intermol3D;

import javax.swing.JWindow;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.Rectangle;
import java.awt.Toolkit;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public final class IAboutScreen extends JWindow{
    Image splash;
    public IAboutScreen(){
        super(Intermol3D.background);
        splash = Const.getImage("Intermol3D.gif").getImage();

        setSize(splash.getWidth(this)+getInsets().left+getInsets().right
        ,(splash.getHeight(this))+getInsets().top+getInsets().bottom);

        Dimension screenDim = Toolkit.getDefaultToolkit().getScreenSize();
        Rectangle winDim = getBounds();
        setLocation((screenDim.width - winDim.width) / 2,
        (screenDim.height - winDim.height) / 2);
        addMouseListener(new MouseAdapter(){
            public void mousePressed(MouseEvent e){
                dispose();
            }
        });
        setVisible(true);
        Graphics g = getGraphics(); paint(g);
    }
    
    public void dispose(){
        super.dispose();
    }
    public void paint(Graphics g){
        g.drawImage(splash,0,0,this);
        int width=getSize().width;
        int height=getSize().height;
        g.setColor(Color.darkGray);
        g.drawLine(0,0,0,height-1);
        g.drawLine(0,0,width-1,0);
        g.drawLine(0,height-1,width-1,height-1);
        g.drawLine(width-1,0,width-1,height);
    }
    public String toString(){
        return "IAboutScreen\n";
    }
}