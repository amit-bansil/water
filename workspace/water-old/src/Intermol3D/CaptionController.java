package Intermol3D;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JComponent;

import java.awt.Component;
import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Enumeration;
import java.util.Hashtable;

final class CaptionController{
	private final Container root;
	private final Hashtable elements=new Hashtable();
	boolean state;
	public CaptionController(final Container rt,final JCheckBoxMenuItem enable){
		this.root=rt;
		state=true;
		check(enable.isSelected());
		enable.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				check(((JCheckBoxMenuItem)e.getSource()).isSelected());
			}
		});			
	} 
	private final void check(final boolean v){
		if(state==v) return;
		state=v;
		if(state){
			final Enumeration comps=elements.keys();
			while(comps.hasMoreElements()){
				JComponent comp=(JComponent)comps.nextElement();
				comp.setToolTipText((String)elements.get(comp));
			}
		}else{
			parse(root.getComponents());
		}
	}
	private final void parse(final Component[] comps){
		for(int i=0;i<comps.length;i++){
			if(comps[i] instanceof Container){
				if(comps[i] instanceof JComponent){
					if( ((JComponent)comps[i]).getToolTipText()!=null )
						elements.put((JComponent)comps[i],((JComponent)comps[i]).getToolTipText());
					((JComponent)comps[i]).setToolTipText(null);
				}
				parse(((Container)comps[i]).getComponents());
			}
		}
	}
}