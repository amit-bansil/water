package Intermol3D;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JFrame;
import javax.swing.JMenu;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.KeyStroke;

import java.awt.GridBagLayout;
import java.awt.Image;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.util.Calendar;
import java.util.Hashtable;
public class JPanelEx extends JPanel{
	static{
		Intermol3D.splash.setState("Screen Shot Mechanism");
	}
	private static final Hashtable jPanels= new Hashtable();//list of JPanelEx's
	private static final JMenu tearOffMenu = new JMenu("Windowed View");
	private static final JMenu screenShotMenu = new JMenu("Snap Shot");
	private static final int numPanelsMade=0;
	public static String outputDir="";
	public static String outputFormat=".bmp";
	public static Hashtable getPanels(){
		return jPanels;
	}
	public static JMenu getTearOffMenu(String name, int mod){
		tearOffMenu.setText(name);
		tearOffMenu.setMnemonic(mod);
		return tearOffMenu;
	}
	public static JMenu getScreenShotMenu(String name, int mod){
		screenShotMenu.setText(name);
		screenShotMenu.setMnemonic(mod);
		return screenShotMenu;
	}
	private JMenuItem   takeSnapshot;
	private JCheckBoxMenuItem tearOff;
	private final int mnemonic;
	JPanelEx(String name){
		super();
		super.setName(name);
		jPanels.put(name,this);
		mnemonic = getUniqueMnemonic(name);
		takeSnapshot=new JMenuItem(name,mnemonic);
		takeSnapshot.setAccelerator(KeyStroke.getKeyStroke( 
                  mnemonic, ActionEvent.CTRL_MASK|ActionEvent.SHIFT_MASK));
        takeSnapshot.addActionListener(new ActionListener(){
        	public void actionPerformed(ActionEvent e){
        		screenShot();
        	}
        });
		tearOff=new JCheckBoxMenuItem(name,false);
		tearOff.setMnemonic(mnemonic);
		tearOff.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				setDocked(!((JCheckBoxMenuItem)e.getSource()).getState());
			}
		});
		tearOffMenu.add(tearOff);
		screenShotMenu.add(takeSnapshot);
		setLayout(new GridBagLayout());
	}
	protected void finalize() throws Throwable{
		jPanels.remove(getName());
		tearOffMenu.remove(tearOff);
		screenShotMenu.remove(takeSnapshot);
		usedMnemonics.remove(new Integer(mnemonic));
		dock();
		super.finalize();
	}
	
	public void setName(String s){
		super.setName(s);
		if(s!=null){
			takeSnapshot.setText(s);
			tearOff.setText(s);
		}
	}
	public void setDocked(boolean d){
		if(d!=true)
			tearOff();
		else
			dock();
	}
	JFrame frame;
	public void tearOff(){
		if(frame!=null){
			frame.dispose();
			frame=null;
		}
		frame=new JFrame(getName());
		try{ frame.getContentPane().add((JPanel)this.clone());}
		catch(CloneNotSupportedException e){
			System.err.println("ERROR: Failed to tear off panel:"+e.toString());
		}
		setVisible(false);
		doLayout();
		getParent().doLayout();
	}
	public void dock(){
		if(frame!=null){
			frame.dispose();
			frame=null;
		}
		this.setVisible(true);
	}

	public void screenShot(){
		Image image=createImage(getWidth(),getHeight());
		paint(image.getGraphics());
		double t=Calendar.getInstance().getTime().getTime();
		//AMIT 6/04/03 removed jimi
		throw new UnsupportedOperationException("jimi is gone so forgetabout it");
		/*try{com.sun.jimi.core.Jimi.putImage(image,outputDir+getName()+" "
			+((int)((t-(Math.floor(t/100000000d)*100000000d))/10d))+outputFormat);}
		catch(com.sun.jimi.core.JimiException e){
			System.err.println("Failed to take Picture Exception:\n  "+e.toString());
		}*/
	}
	
	private static final Hashtable usedMnemonics = new Hashtable();
	private int getUniqueMnemonic(String n){
		String name=n.toUpperCase();
		for(int i=0; i<name.length();i++){
			if(!usedMnemonics.containsKey(new Integer((int)name.charAt(i)) )){
				usedMnemonics.put(new Integer((int)name.charAt(i)),new Integer((int)name.charAt(i)));
				
				return (int)name.charAt(i); 
			}
		}
		return KeyEvent.VK_UNDEFINED;
	}	
	
}