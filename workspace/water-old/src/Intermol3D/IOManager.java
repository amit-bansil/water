/*
 * IOManager.java
 *
 * Created on August 7, 2000, 10:03 AM
 */

package Intermol3D;

/**
 *
 * @author  unknown
 * @version
 */
import javax.swing.JComponent;
import javax.swing.JFileChooser;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;
import javax.swing.JPanel;

import java.awt.Component;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.MissingResourceException;
public class IOManager extends Object {

    /** Creates new IOManager */
    private final Intermol3D application;
    private final IInternalData data;
   // private QTMovieRecorder rec;
    private final Component display;
    private final JMenuItem fileSaveMovie,fileCreateMovie;
    private final JComponent controls;
    private static File lastF=new File(Const.ioRoot+"untitled.icf");
    private static int findex=0;
    private RawMovieRecorder rmv=null;
    public IOManager(Component disp,JMenuItem fileSave,JMenuItem fileLoad, JMenu presets,
        JMenuItem fileCreateMov,JMenuItem fileSaveMov,JPanel cts, IData dat,Intermol3D app) {
        application=app; data=(IInternalData)dat; display=disp; controls=cts;
        
        ActionListener ma=new ActionListener(){
        	public void actionPerformed(ActionEvent e){
        		String fname;
        		try{
				    fname=Const.configs.getString(Const.SPCTo_(((JMenuItem)e.getSource()).getText()));
				}catch(MissingResourceException ex){
				    System.err.println("Unexpected Error: Key has no value");
				    ex.printStackTrace();
				    return;
				}
        		load(ClassLoader.getSystemResourceAsStream(Const.configDir+fname),fname);
        	}
        };
        Enumeration e=Const.configs.getKeys();
        while(e.hasMoreElements()){
        	String n=(String)e.nextElement();
        	JMenuItem m=new JMenuItem(Const._ToSPC(n));
        	m.addActionListener(ma);
        	presets.add(m);     	
        }
        
        controls.setVisible(false);
        
        fileSaveMovie=fileSaveMov; fileCreateMovie=fileCreateMov;
        fileSave.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
            	if(data.isIonPresent()){
					JOptionPane.showMessageDialog(
						Intermol3D.background,
						"All ions must be removed before saving.",
						Const.trans("save.error.title"),
						JOptionPane.ERROR_MESSAGE);
					return;
            	}
                for(;findex<10000;findex++){
                	if(!lastF.exists()) break;
                    lastF=new File(Const.ioRoot+"untitled"+findex+".icf");
                }
                JFileChooser chooser=new javax.swing.JFileChooser(lastF);
                chooser.addChoosableFileFilter(IConfigFilter.FILTER_TXT);
                chooser.addChoosableFileFilter(IConfigFilter.FILTER_ICF);
                
                int returnVal = chooser.showSaveDialog(Intermol3D.background);
                if(returnVal == JFileChooser.APPROVE_OPTION) {
                    try{
                        String name=chooser.getSelectedFile().getAbsolutePath();
                        if(chooser.getFileFilter()==IConfigFilter.FILTER_TXT)
                        	name+=".itx";
                        else
                        	name+=".icf";
                        	
                        lastF=new java.io.File(name);
                    	if(!lastF.exists()){lastF.createNewFile();}
                        OutputStream os=new BufferedOutputStream(new FileOutputStream(lastF));
                        
                        if(chooser.getFileFilter()==IConfigFilter.FILTER_TXT)
                        	data.save(os);
                        else
                        	data.fullSave(os);
                        
                        os.flush(); os.close();
                    }catch(Exception ex){
                        ex.printStackTrace();
                        JOptionPane.showMessageDialog(Intermol3D.background,Const.trans("save.error.message"),Const.trans("save.error.title"),
                        JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });
        fileLoad.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                JFileChooser chooser=new javax.swing.JFileChooser(new File(Const.ioRoot));
                chooser.addChoosableFileFilter(IConfigFilter.FILTER_ALL);
  
                int returnVal = chooser.showOpenDialog(Intermol3D.background);
                if(returnVal == JFileChooser.APPROVE_OPTION) {
            	  	try{
            	  		load(new FileInputStream(chooser.getSelectedFile()),chooser.getSelectedFile().getName());
            	  	}catch(Exception ex){
			            ex.printStackTrace();
			            JOptionPane.showMessageDialog(Intermol3D.background,Const.trans("load.error.message"),Const.trans("load.error.title"),
			            JOptionPane.ERROR_MESSAGE);
        			}			
                }
            }
        });
        fileCreateMovie.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                JFileChooser chooser=new javax.swing.JFileChooser();
                chooser.addChoosableFileFilter(IConfigFilter.FILTER_IMV);
                //chooser.addChoosableFileFilter(new javax.swing.plaf.basic.BasicFileChooserUI.AcceptAllFileFilter());
                int returnVal = chooser.showSaveDialog(Intermol3D.background);
                if(returnVal == JFileChooser.APPROVE_OPTION) {
                    try{
                        String name=chooser.getSelectedFile().getAbsolutePath();
                        rmv=new RawMovieRecorder(display,name);
                        fileCreateMovie.setEnabled(false);
                        fileSaveMovie.setEnabled(true);
                        controls.setVisible(true);
                    }catch(Exception ex){
                        ex.printStackTrace();
                        JOptionPane.showMessageDialog(Intermol3D.background,Const.trans("save.error.message"),Const.trans("save.error.title"),
                        JOptionPane.ERROR_MESSAGE);
                    }
                }
            }
        });
        fileSaveMovie.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                rmv.finish();
                rmv=null;
                fileCreateMovie.setEnabled(true);
                fileSaveMovie.setEnabled(false);
                controls.setVisible(false);
            }
        });
        fileCreateMovie.setEnabled(true);
        fileSaveMovie.setEnabled(false);
    }
    public void step(){
    	if(rmv!=null) rmv.step();
    }
    public void clear(){
        step();
    }
    private final void load(final InputStream is,final String name){
    	try{
    		Const.config.finished();
            if(IConfigFilter.isICF(name))
            	Const.config=new FullIconfig(is);
            else
            	Const.config=new IConfig(is);
           
        }catch(Exception ex){
            ex.printStackTrace();
            JOptionPane.showMessageDialog(Intermol3D.background,Const.trans("load.error.message"),Const.trans("load.error.title"),
            JOptionPane.ERROR_MESSAGE);
        }
        application.clear();
    }
    
}