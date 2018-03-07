package Intermol3D;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;
import javax.vecmath.Point3f;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Insets;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;

public final class AddIonDialog extends JDialog{
	private final JButton okButton,cancelButton,simpleButton;
	private final JLabel invalidPositionWarning;
	private final JComboBox ionTypeCombo1,ionTypeCombo2,modeCombo;
	private final JLabel ion1Label,ion2Label,modeLabel;
	private final SliderGroupEx xSlider,ySlider,zSlider;
	private final JPanel displayPanel=new JPanel();
	private final ComboGroupEx energyCombo;
	private Point3f ionPosition=new Point3f(0.0f,0.0f,0.0f);
	private int[] ionType=new int[]{2,0}; private IonData ionData;
	private I3DDisplay display;
	private final IInterface frame;
	private final IData data;
	private IonGrid grid;
	private PEView PEPanel;
	private int latRes=16,cutoff=250;
	private final JPanel PEHolder=new JPanel();
	private static final JFrame parent=new JFrame(); 
	private final JPanel view3D=new JPanel(),controls3D=new JPanel();
	private final javax.swing.Box bottomPanel;
	private final ItemListener typeComboListener=new ItemListener(){
		public void itemStateChanged(ItemEvent e){
			if(e.getStateChange()==e.SELECTED){
	   			createIonData();
	   			updateIon();
	   		}
	   	} 
	}; 
	AddIonDialog(IData dat,IInterface gui){
		super(parent, Const.trans("ionEditor.title.add"),true);
		data=dat; frame=gui;
		setVisible(false);
		setResizable(false);
		
		//init controls
		okButton=new JButton(Const.trans("ionEditor.okButton.label"));
		okButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				accept();
			}
		});
		
		cancelButton=new JButton(Const.trans("ionEditor.cancelButton.label"));
		cancelButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				ionPosition=null;
				accept();
			}
		});
		simpleButton=new JButton(Const.trans("ionEditor.simple.label"));
		simpleButton.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				flipSimple();
			}
		});
		invalidPositionWarning=new JLabel(Const.trans("ionEditor.warning.label"));
		//TO DO: implement in html invalidPositionWarning.setTextColor(Color.red);
		modeLabel=new JLabel(Const.trans("ionEditor.modeCombo.label"));
		modeCombo=new JComboBox();
		modeCombo.addItem(Const.trans("ionEditor.typeSalt"));
		modeCombo.addItem(Const.trans("ionEditor.typeGas"));
		modeCombo.addItemListener(new ItemListener(){
   			public void itemStateChanged(ItemEvent e){
   				if(e.getStateChange()==e.SELECTED){
   					if(((JComboBox)(e.getSource())).getSelectedIndex()==0)
		   				setSalt(true);
		   			else
		   				setSalt(false);
		   			updateIon();
		   		}
		   	} 
   		}); 
   		
   		ionTypeCombo1=new JComboBox();
		ion1Label=new JLabel(Const.trans("ionEditor.ionType1.label"));
   		ionTypeCombo2=new JComboBox();
	    ion2Label=new JLabel(Const.trans("ionEditor.ionType2.label"));
	    
	    ionTypeCombo1.addItemListener(typeComboListener);
	    ionTypeCombo2.addItemListener(typeComboListener);    
	    
	    xSlider=new SliderGroupEx(Const.trans("ionEditor.xSlider.label"));
	    xSlider.setRealBounds(1,0,100);
	    xSlider.setRealValue(ionPosition.x);
	    xSlider.addChangeListener(new ChangeListener(){
	    	public void stateChanged(ChangeEvent e){
	    		SliderGroupEx src=((SliderGroupEx)e.getSource());
	    		ionPosition.x=1-(float)src.getRealValue();
	    		grid.updateGrid(ionPosition.x*ObjLib.boundsSize.x);
	    		PEPanel.setX(1-(float)src.getRealValue());
	    	}
	    });
	    
	    ySlider=new SliderGroupEx(Const.trans("ionEditor.ySlider.label"));
	    ySlider.setRealBounds(1,0,100);
	    ySlider.setRealValue(ionPosition.y);
	    ySlider.setOrientation(JSlider.VERTICAL);
	    ySlider.addChangeListener(new ChangeListener(){
	    	public void stateChanged(ChangeEvent e){
	    		SliderGroupEx src=((SliderGroupEx)e.getSource());
	    		ionPosition.y=(float)src.getRealValue();
	    		if(src.getValueIsAdjusting()) PEPanel.update();
	    		grid.updateIonPos(ionPosition.y*ObjLib.boundsSize.y,ionPosition.z*ObjLib.boundsSize.z);
	    	}
	    });
	    
	    zSlider=new SliderGroupEx(Const.trans("ionEditor.zSlider.label"));
	    zSlider.setRealBounds(1,0,100);
		zSlider.setRealValue(ionPosition.z);
		zSlider.addChangeListener(new ChangeListener(){
	    	public void stateChanged(ChangeEvent e){
	    		SliderGroupEx src=((SliderGroupEx)e.getSource());
	    		ionPosition.z=(float)src.getRealValue();
	    		if(src.getValueIsAdjusting()) PEPanel.update();
	    		grid.updateIonPos(ionPosition.y*ObjLib.boundsSize.y,ionPosition.z*ObjLib.boundsSize.z);
	    	}
	    });
	    
	    energyCombo=new ComboGroupEx("energy.label");
		//layout controls
		
		getContentPane().setLayout(new GridBagLayout());
		
		javax.swing.Box topToolbar=javax.swing.Box.createHorizontalBox();
		GridBagConstraints g=new GridBagConstraints();
		g.gridx=     0; 
		g.gridy=     0; 
		g.weightx=   0;
		g.weighty=   0;
		g.gridwidth= 3; 
		g.fill=    g.NONE;
		g.anchor=  g.WEST; 
		g.insets=new Insets(6,6,5,5);
		getContentPane().add( topToolbar ,g);
		topToolbar.add(okButton);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(2));
		topToolbar.add(cancelButton);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(5));
		topToolbar.add(modeLabel);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(2));
		topToolbar.add(modeCombo);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(5));
		topToolbar.add(ion1Label);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(2));		
		topToolbar.add(ionTypeCombo1);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(5));
		topToolbar.add(ion2Label);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(2));		
		topToolbar.add(ionTypeCombo2);
		topToolbar.add(javax.swing.Box.createHorizontalStrut(5));
		topToolbar.add(simpleButton);		
		//topToolbar.add(invalidPositionWarning);
		//topToolbar.add(javax.swing.Box.createHorizontalStrut(5));
		//topToolbar.add(advancedButton);
		
		ionData=new IonData(ionType,2,data);
		PEPanel = new PEFlatView(ySlider,zSlider,ionData,latRes,cutoff);
		
		/*g=new GridBagConstraints();
		g.gridx=     2; 
		g.gridy=     1; 
		g.weightx=   0.0f;
		g.weighty=   0;
		g.gridwidth= 1; 
		g.fill=    g.BOTH;
		g.anchor=  g.CENTER; 
		g.insets=new Insets(6,-5,5,-2);
		getContentPane().add( xSlider ,g);
		
		g=new GridBagConstraints();
		g.gridx=     1; 
		g.gridy=     1; 
		g.weightx=   0.0f;
		g.weighty=   0;
		g.gridwidth= 1; 
		g.fill=    g.BOTH;
		g.anchor=  g.CENTER; 
		g.insets=new Insets(6,-5,5,-2);
		getContentPane().add( zSlider ,g);
		
		g=new GridBagConstraints();
		g.gridx=     0; 
		g.gridy=     2; 
		g.weightx=   0.0f; 
		g.weighty=   0.0f;
		g.gridwidth= 1; 
		g.fill=    g.BOTH;
		g.anchor=  g.CENTER; 
		g.insets=new Insets(-5,6,-2,5);
		getContentPane().add( ySlider ,g);
		*/
		PEHolder.setLayout(new GridBagLayout());
		PEPanel.setPreferredSize(new Dimension(250,250));
		SwingEx.lockSize(PEPanel);
		
		PEPanel.setBackground(Color.black);
		g=new GridBagConstraints();
		g.gridx=     1; 
		g.gridy=     2; 
		g.weightx=   0.0f;
		g.weighty=   1.0f;
		g.gridwidth= 1; 
		g.fill=    g.NONE;
		g.anchor=  g.NORTHWEST;  
		g.insets=new Insets(0,0,0,0);
		getContentPane().add( PEHolder ,g);
		
		//ySlider.setBorder(BorderFactory.createEmptyBorder(0,0,0,0));
		ySlider.setOpaque(false);
		zSlider.setOpaque(false);
		g=new GridBagConstraints();
		g.gridx= 2; g.gridy= 2; 
		g.weightx= 1.0f; g.weighty= 1.0f;
		g.fill= g.NONE; g.anchor= g.CENTER; 
		g.insets=new Insets(0,0,6,6);
		PEHolder.add( PEPanel ,g);
		g=new GridBagConstraints();
		g.gridx= 1; g.gridy= 0; g.gridheight=2; g.gridwidth=2;
		g.weightx= 1.0f; g.weighty= 0.0f;
		g.fill= g.BOTH; g.anchor= g.WEST; 
		g.insets=new Insets(0,2,1,0);
		PEHolder.add( zSlider ,g);		
		g=new GridBagConstraints();
		g.gridx= 0; g.gridy= 1; g.gridheight=2; g.gridwidth=2;
		g.weightx= 0.0f; g.weighty= 1.0f;
		g.fill= g.BOTH; g.anchor= g.EAST; 
		g.insets=new Insets(9,0,0,1);
		PEHolder.add( ySlider ,g);
				
		zSlider.setBorder(BorderFactory.createEmptyBorder(0,8,0,0));
		//PEPanel.setBorder(BorderFactory.createEmptyBorder(0,0,25,25));
		//PEHolder.add(ySlider,BorderLayout.WEST);
		//PEHolder.add(zSlider,BorderLayout.NORTH);
		
		//displayPanel.setPreferredSize(new Dimension(300,300));
		view3D.setPreferredSize(new Dimension(250,250));
		displayPanel.setBackground(Color.black);
		displayPanel.setLayout(new BorderLayout());
		g=new GridBagConstraints();
		g.gridx=     2; 
		g.gridy=     2; 
		g.weightx=   1.0f;
		g.weighty=   1.0f;
		g.gridwidth= 1; 
		g.fill=    g.BOTH;
		g.anchor=  g.CENTER; 
		g.insets=new Insets(0,0,6,6);
		getContentPane().add( displayPanel ,g);
		displayPanel.add(xSlider,BorderLayout.NORTH);
		pack();
		setResizable(false);	
		
		bottomPanel=javax.swing.Box.createHorizontalBox();
		bottomPanel.add(controls3D);
		bottomPanel.add(javax.swing.Box.createHorizontalStrut(5));
		bottomPanel.add(energyCombo.getPanel());
		g=new GridBagConstraints();
		g.gridx=     0; 
		g.gridy=     3; 
		g.weightx=   1.0f;
		g.weighty=   0.0f;
		g.gridwidth= 3; 
		g.fill=    g.NONE;
		g.anchor=  g.WEST; 
		g.insets=new Insets(6,6,5,5);
		getContentPane().add( bottomPanel ,g);
		
		/*PEHolder.addComponentListener(new ComponentAdapter(){
			public void componentResize(ComponentEvent e){
				int w=PEPanel.getSize().width;  int w1=PEHolder.getSize().width;
				int h=PEPanel.getSize().height; int h1=PEHolder.getSize().height;
				if(w==h) return;
				int sz=w; if(sz>h) sz=h;
System.out.println("resizing"+h+","+w);
				PEPanel.setSize(sz,sz);
				PEHolder.setSize(new Dimension(w1-(w-sz),h1-(h-sz)));
				doLayout();
			}
		});*/
		simple=false;
		flipSimple();
	}
	private boolean simple;
	private final void flipSimple(){
		simple=!simple;
		boolean vis=isVisible();
		setVisible(false);
		if(simple){
			PEHolder.setVisible(false);
			view3D.setVisible(false);
			controls3D.setVisible(false);
			xSlider.setVisible(false);
			bottomPanel.setVisible(false);
			simpleButton.setText(Const.trans("ionEditor.simple.label"));
		}else{
			PEHolder.setVisible(true);
			view3D.setVisible(true);
			controls3D.setVisible(true);
			bottomPanel.setVisible(true);
			xSlider.setVisible(true);	 
			simpleButton.setText(Const.trans("ionEditor.advanced.label"));
		}
		pack();
		setVisible(vis);
		        			
		setLocation( (getToolkit().getScreenSize().width/2)-
        	(getSize().width/2),
        	(getToolkit().getScreenSize().height/2)-(
        	(getSize().height)/2));
	}
	public boolean getSimple(){
		return simple;
	}
	boolean peResizing=false;
	private void updateIon(){
		PEPanel.setIon(ionData,ionPosition.x);
		grid.updateIon(ionData);
	}
	private void accept(){
		displayPanel.remove(view3D);
		displayPanel.remove(controls3D);
		display.removeIonGrid();
		display=null;
		setVisible(false);
	}

	public void addIon(){
		setSalt(true);
		display=new I3DDisplay(view3D,controls3D,data,energyCombo);
		displayPanel.add(view3D,BorderLayout.CENTER);
		grid =new IonGrid(xSlider,latRes,display,ionData);
		display.addIonGrid(grid);
		display.clear();
		updateIon();
		setVisible(true);
		pack();
		setLocation( (getToolkit().getScreenSize().width/2)-
        	(getSize().width/2),
        	(getToolkit().getScreenSize().height/2)-(
        	(getSize().height)/2));
	}
	
	public Point3f getIonPosition(){
		return ionPosition; 
	}
	public IonData getIonData(){ //TO DO: support for custom ion selection
		return ionData;
	}
	private boolean saltOn=false;
	private void setSalt(boolean v){
		if(saltOn==v) return;
		saltOn=v;
		ionTypeCombo1.removeAllItems();
		ionTypeCombo2.removeAllItems();
		if(saltOn){
			for(int ipon=0;ipon<IonData.minusSaltNames.length;ipon++){
				ionTypeCombo2.insertItemAt(new DeadObj(IonData.minusSaltNames[ipon]),ipon); 
			}for(int ipol=0;ipol<IonData.plusSaltNames.length;ipol++){
				ionTypeCombo1.insertItemAt(new DeadObj(IonData.plusSaltNames[ipol]),ipol);
			}
		}else{
			ionTypeCombo2.insertItemAt(Const.trans("ionEditor.type13.name"),0);
			for(int ipont=1;ipont<IonData.nobleGasNames.length+1;ipont++){
				ionTypeCombo1.insertItemAt(new DeadObj(IonData.nobleGasNames[ipont-1]),ipont-1);
				ionTypeCombo2.insertItemAt(new DeadObj(IonData.nobleGasNames[ipont-1]),ipont);
			}	
		}
		ionTypeCombo1.removeItemListener(typeComboListener);
		ionTypeCombo2.removeItemListener(typeComboListener);
		ionTypeCombo2.setSelectedIndex(0);
		ionTypeCombo1.setSelectedIndex(0);
		createIonData();
		ionTypeCombo1.addItemListener(typeComboListener);
		ionTypeCombo2.addItemListener(typeComboListener);
		
	}
	private void createIonData(){
		if(saltOn){
			ionType[0]=IonData.plusSaltType[ionTypeCombo1.getSelectedIndex()];
			ionType[1]=IonData.minusSaltType[ionTypeCombo2.getSelectedIndex()];
			ionData=new IonData(ionType,2,data);
		}else{
			ionType[0]=IonData.nobleGasType[ionTypeCombo1.getSelectedIndex()];
			int n=ionTypeCombo2.getSelectedIndex();
			if(n==0){
				ionType[1]=13;
				ionData=new IonData(ionType,1,data);
			}else{
				ionType[1]=IonData.nobleGasType[n-1];
				ionData=new IonData(ionType,2,data);
			}
		}
	}
}