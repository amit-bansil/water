package Intermol3D;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JInternalFrame;
import javax.swing.JPanel;
import javax.swing.JTextField;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Component;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

class RawMovieRecorder{
	private final String l;
	private final I3DDisplay t;
	private final JInternalFrame face;
	private final JTextField captionA;
	public RawMovieRecorder(Component target,String loc){
		
		t=(I3DDisplay)target;
		t.setOffScreen(true);
		if(loc.indexOf("SAA")!=-1) t.setHighQuality(true);
		l=loc;
		face=new JInternalFrame("Recorder Controls");
        JPanel ui=new JPanel();
        ui.setLayout(new BoxLayout(ui,BoxLayout.X_AXIS));
        JButton killB=new JButton("Kill Caption");
        killB.addActionListener(new ActionListener(){
        	public void actionPerformed(ActionEvent e){
        		killCaption();
        	}
        });
        captionA=new JTextField();
        captionA.setText("Click Set Capion to fade this text in, click Kill to fade it out");
        captionA.setEditable(true);
        JButton addB=new JButton("Set Caption");
        addB.addActionListener(new ActionListener(){
        	public void actionPerformed(ActionEvent e){
        		startCaption(captionA.getText());
        	}
        });
        ui.add(captionA);
        ui.add(addB);
        ui.add(killB);
        face.setContentPane(ui);
        face.pack();
        Intermol3D.background.getDesktop().add(face);
        Intermol3D.background.getDesktop().moveToFront(face);
        face.setVisible(true);
	}
	private int tn=0; 
	public void step(){
		t.renderOff();
		
		String app="";
		if(tn<10) app="0000";
		else if(tn<100) app="000";
		else if(tn<1000) app="00";
		else if(tn<10000) app="0";
		Graphics g=t.getOffScreenImage().getGraphics();
		drawCaption((Graphics2D)g);
//		AMIT 6/04/03 removed jimi
			  throw new UnsupportedOperationException("jimi is gone so forgetabout it");
		/*try{com.sun.jimi.core.Jimi.putImage(t.getOffScreenImage(),l+"_"
			+app+tn+".bmp");}
		catch(com.sun.jimi.core.JimiException e){
			System.err.println("Failed to take Picture Exception:\n  "+e.toString());
		}
		tn++;*/
	}
	public void finish(){
		t.setHighQuality(false);
		t.setOffScreen(false);
		face.setVisible(false);
		face.dispose();
	}
	private boolean kill=false;
	private String caption=null;
	private float cA=0;
	private final Font cF=new Font("SansSerif",Font.BOLD,18);
	private final Color cC=Color.blue;
	
	private void drawCaption(Graphics2D g){
		if(kill&&(caption!=null)){
			if(cA>0) cA-=0.2f;
		}
		else if((cA<1)&&(caption!=null)){
			cA+=0.2f;
		}
		if(cA<=0) return;
		
		g.setColor(cC);
		g.setFont(cF);
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
			RenderingHints.VALUE_ANTIALIAS_ON);
		g.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER,cA));
		

		g.drawString(caption,2,
			20);
	}
	private void startCaption(String str){
		cA=0;
		caption=str;
		kill=false;
	}
	private void killCaption(){
		kill=true;
	} 
}