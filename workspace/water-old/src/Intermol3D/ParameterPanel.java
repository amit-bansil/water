/*
 * ParameterPanel.java
 *
 * Created on September 5, 2000, 5:04 PM
 */

package Intermol3D;
import javax.swing.JPanel;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics;
/**
 *
 * @author  unknown
 * @version 
 */
public final class ParameterPanel extends JPanel {
    private final int lineAdvance;
    private final FontMetrics VALUE_FM;
    private final FontMetrics LABEL_FM;
    private final float[][] values;
    private final String[] names;
    private static final int BREAK=0;
    private final int LLEN;
    private static final String NOTHING="--";
    private final int NILLEN;
    //Serif, Sans-serif, Monospaced, Dialog, and DialogInput
    private static final Font LABEL_FONT=new Font("SansSerif",Font.BOLD,11);
    private static final Font VALUE_FONT=new Font("SansSerif",Font.PLAIN,11);
    private static final Color LABEL_COLOR=new Color(153, 153,153)
        ,VALUE_COLOR=new Color(102, 102,102);//204

    /** Creates new ParameterPanel */
    public ParameterPanel(String[] names,float[][] vs) {
        LABEL_FM=getFontMetrics(LABEL_FONT); 
        VALUE_FM=getFontMetrics(VALUE_FONT);
        values=vs;
        lineAdvance=LABEL_FM.getHeight();
        this.names=names;
        int len=0,l;
        for(int i=0;i<names.length;i++){           
            l=LABEL_FM.stringWidth(names[i]);
            if(l>len) len=l;
        }
        LLEN=len+3;
        NILLEN=VALUE_FM.stringWidth(NOTHING);
        minSize=new Dimension(LLEN+VALUE_FM.stringWidth("XXXXX"),(lineAdvance+BREAK)*names.length);
        minSizeAvg=new Dimension(minSize.width,(lineAdvance*2+BREAK)*names.length);
    }
    private final Dimension minSize,minSizeAvg;
    public Dimension getPreferredSize(){
        if(average) return minSizeAvg; else return minSize;
    }
    public Dimension getMinimumSize(){
        if(average) return minSizeAvg;
        else return minSize;
    }
    public Dimension getMaximumSize(){
        return SwingEx.MAX_DIM;
    }
    private int cval;
    public void rebuild(int current){
        cval=current;
        paintImmediately(LLEN,0,getSize().width-LLEN,getSize().height);
    }
 
    private boolean average=false;
    public void setAverage(boolean v){ average=v; setVisible(false); setVisible(true); }
    
    public void paintComponent(Graphics g){
        int width=getSize().width,height=getSize().height;
        int penAdvance;
        
        if(average) penAdvance=2*lineAdvance+BREAK;
        else penAdvance=lineAdvance+BREAK;
      
        int pen,i;
        String v;
        g.setColor(VALUE_COLOR);
        for(i=0,pen=penAdvance+1;i<names.length;i++,pen+=penAdvance)
        	g.drawLine(0,pen,width-1,pen);
        	
        g.setColor(Color.black);
        g.setFont(LABEL_FONT);
        for(i=0,pen=lineAdvance-3;i<names.length;i++,pen+=penAdvance)
        	g.drawString(names[i],1,pen);
        	
        g.setFont(VALUE_FONT);
        if(cval==-1){
        	for(i=0,pen=lineAdvance-3;i<names.length;i++,pen+=penAdvance)
        		g.drawString(NOTHING,(width-1)-NILLEN,pen);
        	return;
        }
        for(i=0,pen=lineAdvance-3;i<names.length;i++,pen+=penAdvance){
        	v=SwingEx.round(values[i][cval]);
        	g.drawString(v,(width-1)-VALUE_FM.stringWidth(v),pen);
        }
        if(average){
	        for(i=0,pen=(lineAdvance*2)-6;i<names.length;i++,pen+=penAdvance){
	        	v=SwingEx.round(values[i+names.length][cval]);
	        	g.drawString(v,(width-1)-VALUE_FM.stringWidth(v),pen);
	        }
        }
       /* if(!average){
            for(int i=0;i<names.length;i++){
                g.setFont(LABEL_FONT); g.setColor(LABEL_COLOR);
                g.drawString(names[i],0,peny);
                v=determine(i);
                g.setFont(VALUE_FONT); g.setColor(VALUE_COLOR);
                g.drawString(v,width-VALUE_FM.stringWidth(v),peny);
                peny+=lineAdvance+BREAK;
            }
        }else{
            beginColor();
            int advance=2*lineAdvance+BREAK;
            for(int i=0;i<names.length;i++){ 
                g.setFont(LABEL_FONT); g.setColor(getlabelColor());
                g.drawString(names[i],0,peny);
                g.setFont(VALUE_FONT); g.setColor(getvalueColor());
                v=SwingEx.round(values[i][cval]);
                g.drawString(v,width-VALUE_FM.stringWidth(v),peny);
                peny+=advance;
            }
            beginColor();
            peny=advance-BREAK;
            for(int i=0;i<names.length;i++){
                v=SwingEx.round(values[i+names.length][cval]); g.setColor(getvalueColor());
                g.drawString(v,width-VALUE_FM.stringWidth(v),peny); 
                peny+=advance;
            }
        }*/
    }
}