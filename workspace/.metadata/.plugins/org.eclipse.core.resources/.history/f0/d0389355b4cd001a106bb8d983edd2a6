package Intermol3D;
import javax.swing.BorderFactory;
import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.plaf.metal.MetalLookAndFeel;

import java.awt.BorderLayout;
import java.awt.Dimension;

public final class InternalTab extends JComponent{
    private final JPanel contentPane;
    private final TabTitleBar titleBar;
	private final String position;
	private final JPanel xsize;
	
	public InternalTab(String title,String tip,String pos){
		this(title,tip,pos,null);
	}
    public InternalTab(String title,String tip,String pos,JPanel link){
    	position=pos;
        xsize=link;
        
        if(link!=null){
        	contentPane=new JPanel(){
        	public Dimension getPreferredSize(){
        			if(!position.equals(BorderLayout.NORTH)||!position.equals(BorderLayout.SOUTH))
        				return new Dimension(xsize.getPreferredSize().width,
        					super.getPreferredSize().height);
        			else
        				return new Dimension(super.getPreferredSize().width
        					,xsize.getPreferredSize().height);
        		}
        	};
        }else{
        	contentPane=new JPanel();
        }
        
        setLayout(new BorderLayout(0,0));
        setBackground(MetalLookAndFeel.getControl());
        contentPane.setBackground(MetalLookAndFeel.getControl());
        contentPane.setBorder(BorderFactory.createEmptyBorder(6,4,5,5));
        
    	titleBar=new TabTitleBar(this,title,position);    
    	titleBar.setToolTipText(tip);
        add(titleBar,position);
        
        String opp;
        if(position.equals(BorderLayout.EAST))
        	opp=BorderLayout.WEST;
        else if(position.equals(BorderLayout.SOUTH))
        	opp=BorderLayout.NORTH;
        else if(position.equals(BorderLayout.NORTH))
        	opp=BorderLayout.SOUTH;
        else
        	opp=BorderLayout.EAST;
        	
        add(new JPanel(){
        	public Dimension getPreferredSize(){
        		if(position.equals(BorderLayout.NORTH)||position.equals(BorderLayout.SOUTH))
        			return new Dimension(contentPane.getPreferredSize().width,0);
        		else
        			return new Dimension(0,contentPane.getPreferredSize().height);
        	}
        },opp);
        add(contentPane,BorderLayout.CENTER);
        
        contentPane.setVisible(false);
        
        titleBar.setVisible(true);
        active=true; setActive(false);
    }
    private boolean active;
    
    public JPanel getContentPane(){
    	return contentPane;
    }
    
    private void setActive(boolean v){
    	if(active==v) return;
    	active=v;
    	if(!active)
    		setBorder(BorderFactory.createLineBorder(
    			MetalLookAndFeel.getControlDarkShadow(),3));
    	else
    		setBorder(BorderFactory.createLineBorder(
    			MetalLookAndFeel.getPrimaryControlDarkShadow(),3));
    	titleBar.setActive(v);
    }
    
    boolean showing=false;
    public void click(){
    	showing =!showing;

    	if(showing){
    		contentPane.setVisible(true);
    	}else{
    		contentPane.setVisible(false);
    	}

    }
    public void rollIn(){
    	setActive(true);
    }
    public void rollOut(){
    	if(!showing) setActive(false);
    }
    
}
