package Intermol3D;

import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.SwingUtilities;

import java.awt.Cursor;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public final class IonManager{
    private final I3DDisplay display;
    private final IInternalData data;
    private final IInterface gui;
    private AddIonDialog addIonDialog;
	private boolean ret;
	private boolean finished;
	private Thread thread;
	private JInternalFrame face;
	private JButton kill;
    IonManager(I3DDisplay disp, IInterface gu, IData dat){
        display=disp;data=(IInternalData)dat; gui=gu;
        gui.addIon.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
            	gui.setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
                addIonDialog=new AddIonDialog(data,gui);
                addIonDialog.addIon();
                if(addIonDialog.getSimple()&&(addIonDialog.getIonPosition()!=null)){
                	face=new JInternalFrame("Adding Ion",false,false,false,false);
        			JPanel ui=new JPanel();
        			ui.setBorder(BorderFactory.createEmptyBorder(6,6,5,5));
        			ui.setLayout(new BoxLayout(ui,BoxLayout.X_AXIS));
        			ui.add(new JLabel("Locating a place to add the ion (may take a few minutes)..."));
        			ui.add(javax.swing.Box.createRigidArea(new Dimension(5,5)));
        			kill=new JButton("Cancel");
        			finished=true;
        			kill.addActionListener(new ActionListener(){
        				public void actionPerformed(ActionEvent e){
        					finish();
        				}
        			});
        			ui.add(kill);
        			face.setContentPane(ui);
        			face.pack();
        			Intermol3D.background.getDesktop().add(face);        			
        			Intermol3D.background.getDesktop().setLayer(face,25);
        			Intermol3D.background.getDesktop().moveToFront(face);
        			gui.hideAll();
        			face.setVisible(true);
        			face.setLocation( (face.getToolkit().getScreenSize().width/2)-
	                	(face.getSize().width/2),
	                	(face.getToolkit().getScreenSize().height/2)-(
	                	(face.getSize().height)/2));
					thread=new Thread(new Runnable(){
						public void run(){
							System.out.println("running");
							thread.setPriority(Thread.MAX_PRIORITY-1);
							ret=data.addIon(addIonDialog.getIonData());
							finished=false;
							System.out.println("running2");
							SwingUtilities.invokeLater(new Runnable(){
								public void run(){
									finish();
								}
							});
						}
					});
					thread.start();
                }else{
                    data.addIon(addIonDialog.getIonData(),addIonDialog.getIonPosition());
                    for(int i=0;i<data.ions.length;i++) display.addIon(data.ions[i]);
                    gui.removeIon.setEnabled(true);
                    gui.addIon.setEnabled(false);
                    addIonDialog.dispose(); addIonDialog=null;
                }
                
            }
        });
        gui.removeIon.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                if(data.ions!=null){
                    for(int i=0;i<data.ions.length;i++){
                        //display.removeIon(i);
                        display.removeIons();
                    }
                    data.removeIons();
                    gui.addIon.setEnabled(true);
                    gui.removeIon.setEnabled(false);
                }
            }
        });
        gui.removeIon.setEnabled(false);
    }
    public void clear(){
        gui.removeIon.setEnabled(false);
        gui.addIon.setEnabled(true);
    }
    public void finish(){
    	System.out.println("finished");
    	//this is a design flaw:
    	//stop is used to cause an unchecked thread death error
    	//that stops the ion from being added when the user hits cancel.
         thread.stop();
         thread=null;
         face.setVisible(false);
         gui.showAll();
		 face.dispose();
         face=null;
         System.out.println("finished2");
         if(finished) return;
         System.out.println("finished3");
         if(ret){
            for(int i=0;i<data.ions.length;i++) display.addIon(data.ions[i]);
            gui.removeIon.setEnabled(true);
            gui.addIon.setEnabled(false);
        }else{
        	JOptionPane.showMessageDialog(null, "The ion not could be fit into the solution.", "Error", JOptionPane.ERROR_MESSAGE);
        }
        addIonDialog.dispose(); addIonDialog=null;
    }
}


