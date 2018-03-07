package Intermol3D;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSeparator;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Insets;
import java.util.StringTokenizer;

public final class SwingEx{
        public static final Dimension MAX_DIM=new Dimension(Integer.MAX_VALUE,Integer.MAX_VALUE);
	public static final void lockSize(JComponent c){
		Dimension size = c.getPreferredSize();
		c.setMaximumSize(size);
		c.setMinimumSize(size);
	}
	public static final void lockYSize(JComponent c){
		Dimension size = c.getPreferredSize();
                c.setMinimumSize((Dimension)size.clone());
                size.width=MAX_DIM.width;
                c.setMaximumSize((Dimension)size.clone());
	}
	public static final void disableValue(JLabel l){
		l.setText("--");
		l.setEnabled(false);
	}
        public static final JComponent wrapSpace(JComponent c,int top,int left,int bottom,int right){
            c.setBorder(BorderFactory.createCompoundBorder(BorderFactory.createEmptyBorder(top,bottom,left,right),c.getBorder()));
            return c;
        }
        public static final Container wrapSeparator(Container c, String name){
            JPanel wrap=new JPanel();
            wrap.setLayout(new BorderLayout());
            wrap.add(c);
            JPanel space=new JPanel();
            space.setLayout(new BorderLayout());
            space.add(new JSeparator(),BorderLayout.CENTER);
            space.add(new JLabel(name),BorderLayout.NORTH);
            wrap.add(space,BorderLayout.NORTH);
            return wrap;
        }
	private static final float Log10=(float)(Math.log(10));
	public static final String round(float f){
		int e=(int)Math.floor(Math.log(Math.abs(f))/Log10);
		if(e>9999||e<-9999){ 
			if(e>9999) 
				return ">1E9999"; 
			else 
				return "0.000";
		}
		String r;
		if(e>3||e<-3){
			r=Float.toString(Math.round((f/Math.pow(10,e))*100)/100f);
			if(f<0){
				if(r.length()==5) return r+"E"+e;
				return r+"0E"+e;
			}				
			if(r.length()==4) return r+"E"+e;
			return r+"0E"+e;
		}
		r=(Math.round(f*1000)/1000f)+"00";
		return r.substring(0,r.indexOf(".")+4);
	}
	public static final String round(double f){
		int e=(int)Math.floor(Math.log(Math.abs(f))/Log10);
		if(e>9999||e<-9999){ 
			if(e>9999) 
				return ">1E9999"; 
			else 
				return "0.000";
		}
		String r;
		if(e>3||e<-3){
			r=Float.toString(Math.round((f/Math.pow(10,e))*100)/100f);
			if(f<0){
				if(r.length()==5) return r+"E"+e;
				return r+"0E"+e;
			}
			if(r.length()==4) return r+"E"+e;
			return r+"0E"+e;
		}
		r=(Math.round(f*1000)/1000f)+"00";
		return r.substring(0,r.indexOf(".")+4);
	}
	public static final String removeSpaces(String s){
		StringTokenizer st=new StringTokenizer(s," ");
		String r=st.nextToken();
		while(st.hasMoreTokens()){
			r+="_"+st.nextToken();
		}
		return r;
	}	
	public static final String removeLineBreaks(String s){
		StringTokenizer st=new StringTokenizer(s,"\n");
		String r=st.nextToken();
		while(st.hasMoreTokens()){
			r+=" "+st.nextToken();
		}
		return r;
	}
	public static final void createToolbarButton(JButton b,String iconBaseName){
		b.setBorderPainted(false);
		b.setMargin(new Insets(0,0,0,0));
		b.setBackground(Color.white);
		b.setIcon(Const.getImage(iconBaseName+"2.gif"));
		b.setRolloverIcon(Const.getImage(iconBaseName+".gif"));
		b.setRolloverEnabled(true);
		b.setToolTipText(Const.trans(iconBaseName+".tip"));
	}
}