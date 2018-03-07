package Intermol3D;

import javax.swing.JComponent;
import javax.swing.plaf.metal.MetalLookAndFeel;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.Insets;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public final class TabTitleBar extends JComponent{
    private final InternalTab p;
    MetalBumps activeBumps 
        = new MetalBumps( 0, 0,
                          MetalLookAndFeel.getPrimaryControlHighlight(),
                          MetalLookAndFeel.getPrimaryControlDarkShadow(),
                          MetalLookAndFeel.getPrimaryControl() );
    MetalBumps inactiveBumps 
        = new MetalBumps( 0, 0,
                          MetalLookAndFeel.getControlHighlight(),
                          MetalLookAndFeel.getControlDarkShadow(),
                          MetalLookAndFeel.getControl() );
                          
    private final Insets insets;
    private static final int SPACER=2;
    private static final int BOTTOM=3;
    private final String title;
    private final int tH,tW;
    private static final Font TITLE_FONT=new Font("SansSerif",Font.BOLD,12);
    private final String position;
    private final boolean horizontal;
    //constructor
    public TabTitleBar(InternalTab parent,String name,String pos){
        p=parent;
        position=pos;
        insets=new Insets(2,3,2,2);
        if(position.equals(BorderLayout.NORTH)||position.equals(BorderLayout.SOUTH))
        	horizontal=true;
        else
        	horizontal=false;
        		
        addMouseListener(new MouseAdapter(){
            public void mouseReleased(MouseEvent e){
                p.click();
            }
            public void mouseEntered(MouseEvent e){
                p.rollIn();
            }
            public void mouseExited(MouseEvent e){
                p.rollOut();
            }
        });
        title=name;
        tH=getFontMetrics(TITLE_FONT).getHeight()-6;
        tW=getFontMetrics(TITLE_FONT).stringWidth(title);
    }
    //active
    boolean active;
    public void setActive(boolean v){
        if(v==active) return;
        active=v;
        this.paintImmediately(0,0,getSize().width,getSize().height);
    }
    public boolean getActive(){
        return active;
    }
    //size
    public Dimension getPreferredSize(){
    	Dimension d=getMinimumSize();
    	if(d.width<getSize().width) d.width=getSize().width;
    	if(d.height<getSize().height) d.height=getSize().height;
    	
        if(horizontal)
        	return new Dimension(d.width,tH+insets.top+insets.bottom+BOTTOM);
        else
        	return new Dimension(tH+insets.left+insets.right+BOTTOM,d.height);
    }
    public Dimension getMinimumSize(){
        if(horizontal)
        	return new Dimension(tW+insets.left+insets.right+SPACER+2,tH+insets.top+insets.bottom+BOTTOM);
        else
        	return new Dimension(tH+insets.left+insets.right+BOTTOM,tW+insets.top+insets.bottom+SPACER+2);
    }
    
    public void paintComponent(Graphics g){
    
        Graphics2D g2=(Graphics2D)g;
        Dimension sze=getSize();
        
        //offset for bottom
        if(position.equals(BorderLayout.EAST))
        	g2.translate(BOTTOM,0);
        else if(position.equals(BorderLayout.SOUTH))
        	g2.translate(0,BOTTOM);
        
        //draw background	
        if(active) g2.setColor(MetalLookAndFeel.getPrimaryControl());
        else g2.setColor(MetalLookAndFeel.getControl());
        
        if(horizontal) g2.fillRect(0,0,sze.width,sze.height-BOTTOM);
        else g2.fillRect(0,0,sze.width-BOTTOM,sze.height);
        
        g2.setColor(MetalLookAndFeel.getControl());
        if(horizontal) g2.fillRect(0,sze.height-BOTTOM,sze.width,BOTTOM);
        else g2.fillRect(sze.width-BOTTOM,0,BOTTOM,sze.height);
        
        //draw bumps
        MetalBumps current;
        if(active)
        	current=activeBumps;
        else
        	current=inactiveBumps;
		
		if(horizontal){
			current.setBumpArea( sze.width-(SPACER+tW+insets.left+insets.right),
				sze.height-(BOTTOM+insets.top+insets.bottom));
			current.paintIcon(this,g,tW+SPACER+insets.left,insets.top);
		}else{
			current.setBumpArea( sze.width-(BOTTOM+insets.left+insets.right),
				sze.height-(SPACER+tW+insets.top+insets.bottom));
			current.paintIcon( this, g, insets.left, tW+SPACER+insets.top);
		}
		//draw line
		if(active)
			g2.setColor(MetalLookAndFeel.getPrimaryControlDarkShadow());
		else
			g2.setColor(MetalLookAndFeel.getControlDarkShadow());
		
        if(position.equals(BorderLayout.EAST))
        	g2.drawLine(0,0,0,sze.height);
        else if(position.equals(BorderLayout.SOUTH))
        	g2.drawLine(0,0,sze.width,0);
        else if(position.equals(BorderLayout.NORTH))
        	g2.drawLine(0,sze.height-BOTTOM,sze.width,sze.height-BOTTOM);
        else
        	g2.drawLine(sze.width-BOTTOM,0,sze.width-BOTTOM,sze.height);
        	
        //draw text
        g2.setColor(Color.black);
        g2.setFont(TITLE_FONT);
        if(!horizontal){
        	g2.rotate(Math.PI/2d);
        	g2.drawString(title,insets.top,-insets.right);
        }
        else g2.drawString(title,insets.left,insets.top+tH);
        
    }
}