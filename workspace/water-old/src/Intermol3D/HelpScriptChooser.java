package Intermol3D;

import javax.swing.JDialog;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JOptionPane;

import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.File;
import java.io.FilenameFilter;
import java.util.Hashtable;

//TO DO ADD INTERNATIONALIZED TEXT
class HelpScriptChooser extends JDialog{
	private final JMenu helpMenu;
	private JMenuItem crtScript=null;
	private HelpScript script;
	private HelpEditorInterface edit;
	private HelpInterface face;
	private Hashtable fileLUT=new Hashtable();
	private final Container gui;
	public HelpScriptChooser(JMenu menu,Container gi){
		helpMenu=menu; gui=gi;
		if(true/*Const.createScript*/){
			crtScript=new JMenuItem("Create Lesson");
			crtScript.addActionListener(new ActionListener(){
				public void actionPerformed(ActionEvent e){
					helpMenu.setEnabled(false);
					String name = JOptionPane.showInputDialog("Please enter a valid movie name:");
					name+=".ihs"; 
					
					script=new HelpScript(gui);
					edit=new HelpEditorInterface(script,getChooser(),name);
					edit.setOpaque(false);
					edit.getContentPane().setBackground(gui.getBackground());
					script.setInterface(edit);
					Intermol3D.background.getDesktop().add(edit);
				}
			});
			menu.add(crtScript);
			menu.addSeparator();
		}
		FilenameFilter fileFilter = new FilenameFilter(){
			public boolean accept(File dir, String name){
				if(name.indexOf(".ihs") != -1) 
					return true;
				return false;
			}
		};
		File directory=new File(Const.helpDir);
		File[] names = directory.listFiles(fileFilter);
		if(names!=null){
			for(int i=0;i<names.length;i++){
				JMenuItem item=new JMenuItem(names[i].getName());
				fileLUT.put(names[i].getName(),names[i]);
				menu.add(item);
				item.addActionListener(new ActionListener(){
					public void actionPerformed(ActionEvent e){
						helpMenu.setEnabled(false);
						
						script=new HelpScript(gui);
						face=new HelpInterface(script,getChooser(),((File)fileLUT.get(
							((JMenuItem)e.getSource()).getText())).getAbsolutePath() );
						script.setInterface(face);
						face.setBackground(gui.getBackground());
						Intermol3D.background.getDesktop().add(face);
					}
				});
			}
		}
	}
	public void done(){
		helpMenu.setEnabled(true);
		edit=null;
		script=null;
		Intermol3D.background.getDesktop().remove(face);
		face=null;
	}
	public HelpScriptChooser getChooser(){
		return this;
	}
	public void finishCreation(){
		if(true/*Const.createScript*/){
			helpMenu.setEnabled(true);
			face=null;
			script=null;
			Intermol3D.background.getDesktop().remove(edit);
			edit=null;
		}else
			throw new IllegalStateException("Help Creation not Enabled!");
	}
}