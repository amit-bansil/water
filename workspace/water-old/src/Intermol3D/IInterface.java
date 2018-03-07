/* 
    SMDInterface.java

    Author:			ab
    Description:	
*/
package Intermol3D;
import javax.swing.Box;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JCheckBoxMenuItem;
import javax.swing.JComboBox;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;
import javax.swing.JPanel;
import javax.swing.JPopupMenu;
import javax.swing.JRadioButtonMenuItem;
import javax.swing.JScrollPane;
import javax.swing.JTabbedPane;
import javax.swing.JTextArea;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.Insets;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentAdapter;
import java.awt.event.ComponentEvent;

public final class IInterface extends JInternalFrame
{
    static{
            Intermol3D.splash.setState("Interface Core");
    }
    private IAboutScreen about;	
    private final IData data;
    private final InternalTab optionsTab,dataTab;
    private final JPanel optionsP,dataP;
    IInterface(IData dat){
        super(Const.trans("app.title"),true,true,true,false);
        data=dat;
        JPopupMenu.setDefaultLightWeightPopupEnabled(false);
                setTitle (Const.trans("app.title"));
        setResizable(true);
        setMaximizable(false);
        setIconifiable(false);
        
        setContentPane(contentPanel);
        //primary controls
        primaryControls.setLayout(new BoxLayout(primaryControls,BoxLayout.X_AXIS));
        //time control
        optionsButton =new ToggleButtonEx("options");
        optionsButton.setSelected(true);
        playButton = new ToolbarButtonEx ("play");
        pauseButton = new ToolbarButtonEx ("pause");
        stepButton = new ToolbarButtonEx("step");
        Box timeControl=Box.createHorizontalBox();
        timeControl.add(Box.createRigidArea(new Dimension(0,0)));
        //timeControl.add(optionsButton);
        //timeControl.add(Box.createRigidArea(new Dimension(5,5)));
        timeControl.add(playButton);
        timeControl.add(Box.createRigidArea(new Dimension(2,2)));
        timeControl.add(pauseButton);
        timeControl.add(Box.createRigidArea(new Dimension(2,2)));
        timeControl.add(stepButton);
        timeControl.add(Box.createRigidArea(new Dimension(0,0)));

        primaryControls.add(timeControl);
        primaryControls.add(Box.createRigidArea(new Dimension(5,5)));
        primaryControls.add(screenControls);
        
        //Options Tab
        optionsTab=new InternalTab(Const.trans("optionsTab.title"),Const.trans("optionsTab.tip"),BorderLayout.WEST);
        optionsP=optionsTab.getContentPane();
        optionsP.setLayout(new BoxLayout(optionsP,BoxLayout.Y_AXIS));
        optionsP.add(Box.createRigidArea(new Dimension(0,0)));
       
        //energy
        JPanel energyBox=new JPanel();
        energyBox.setLayout(new BorderLayout());
        energyBox.add(SwingEx.wrapSpace(new JLabel(Const.trans("energy.label")),0,0,0,2),BorderLayout.WEST);
        energyBox.add(energyCombo);
        //SwingEx.lockYSize(energyBox);
        optionsP.add(energyBox);
        optionsP.add(Box.createRigidArea(new Dimension(11,11)));
        //movie mode
        movieModeCombo=new ComboGroupEx("movieMode.label");
        value1=new SliderGroupEx("junk");
        value2=new SliderGroupEx("junk");
        simControls.add(movieModeCombo.getPanel());
        simControls.add(Box.createRigidArea(new Dimension(5,5)));
        simControls.add(value1.getPanel());
        simControls.add(Box.createRigidArea(new Dimension(5,5)));
        simControls.add(value2.getPanel());
        simControls.add(Box.createRigidArea(new Dimension(11,11)));
        //add/remove particle
        Box particleP=Box.createHorizontalBox();
        addIon=new JButton(Const.trans("addIon.label"));
        addIon.setToolTipText(Const.trans("addIon.tip"));
        //addIon.setFont(new Font("Dialog", 0, 10));
        //addIon.setMargin (new Insets(0, 0, 0, 0));	
        removeIon=new JButton(Const.trans("removeIon.label"));
        removeIon.setToolTipText(Const.trans("removeIon.tip"));
        //removeIon.setFont(new Font("Dialog", 0, 10));
        //removeIon.setMargin (new Insets(0, 0, 0, 0));
        addH2O=new JButton(Const.trans("addh2o.label"));
        addH2O.setToolTipText(Const.trans("addh2o.tip"));
        addH2O.setFont(new Font("Dialog", 0, 10));
        addH2O.setMargin (new Insets(0, 0, 0, 0));	
        removeH2O=new JButton(Const.trans("removeh2o.label"));
        removeH2O.setToolTipText(Const.trans("removeh2o.tip"));
        removeH2O.setFont(new Font("Dialog", 0, 10));
        removeH2O.setMargin (new Insets(0, 0, 0, 0));
        particleP.add(Box.createRigidArea(new Dimension(0,0)));
        particleP.add(addIon);
        particleP.add(Box.createHorizontalGlue());
        //particleP.add(addH2O);
        //particleP.add(Box.createHorizontalGlue());
        particleP.add(removeIon);
        //particleP.add(Box.createHorizontalGlue());
        //particleP.add(removeH2O);
        particleP.add(Box.createRigidArea(new Dimension(0,0)));
        simControls.add(particleP);
        simControls.add(Box.createRigidArea(new Dimension(0,0)));        
        SwingEx.lockYSize(simControls);
        optionsP.add(Box.createRigidArea(new Dimension(0,0)));
        optionsP.add(simControls);
        optionsP.add(Box.createRigidArea(new Dimension(0,0)));
        //time line
        Box timelineP=Box.createHorizontalBox();
        timeline=new SliderGroupEx("timeline");
        rememberFrame=new JButton(Const.trans("rememberFrame.label"));
        rememberFrame.setToolTipText(Const.trans("rememberFrame.tip"));
        rememberFrame.setFont(new Font("Dialog", 0, 10));
        rememberFrame.setMargin (new Insets(0, 0, 0, 0));	
        trashFrame=new JButton(Const.trans("trashFrame.label"));
        trashFrame.setToolTipText(Const.trans("trashFrame.tip"));
        trashFrame.setFont(new Font("Dialog", 0, 10));
        trashFrame.setMargin (new Insets(0, 0, 0, 0));
        timelineP.add(Box.createRigidArea(new Dimension(0,0)));
        timelineP.add(rememberFrame);
        timelineP.add(Box.createHorizontalGlue());
        timelineP.add(trashFrame);
        timelineP.add(Box.createRigidArea(new Dimension(0,0)));
        crtControls.add(timeline.getPanel());
        crtControls.add(Box.createRigidArea(new Dimension(5,5)));
        crtControls.add(timelineP);
        crtControls.add(Box.createRigidArea(new Dimension(11,11)));
        SwingEx.lockYSize(crtControls);
        crtControls.setMaximumSize(new Dimension(crtControls.getMaximumSize().height,Integer.MAX_VALUE));
        //optionsP.add(crtControls);
        //optionsP.add(Box.createRigidArea(new Dimension(0,0)));
        
        //Data Tab
        dataTab=new InternalTab(Const.trans("dataTab.title"),Const.trans("dataTab.tip"),
        	BorderLayout.WEST,optionsP);
        dataP=dataTab.getContentPane();
        dataP.setLayout(new BoxLayout(dataP,BoxLayout.Y_AXIS));
        dataP.add(Box.createRigidArea(new Dimension(0,0)));
        
        //data pane        
        resetData=new JButton(Const.trans("graphs.refresh"));
        resetData.setFont(new Font("Dialog", 0, 10));
        resetData.setMargin (new Insets(0, 0, 0, 0));	
        avgData=new JCheckBox(Const.trans("graphs.average"));
        avgData.setFont(new Font("Dialog", 0, 10));
        avgData.setMargin (new Insets(0, 0, 0, 0));	
        //Amit 6/04/03 removed controls 
        /*Box dcc=new Box(BoxLayout.X_AXIS);
        dcc.add(avgData);
        dcc.add(Box.createHorizontalGlue());
        dcc.add(resetData);*/
        graphPanel.setMinimumSize(new Dimension(100,50));
        graphPanel.setPreferredSize(new Dimension(100,50));
        JPanel graphHolder=new JPanel(new BorderLayout());
        graphHolder.add(graphMode,BorderLayout.NORTH);
        graphHolder.add(graphPanel);                
        dataView.addTab(Const.trans("graph.tab"),graphHolder);
        dataView.setSelectedIndex(0);
        dataView.addTab(Const.trans("parameters.tab"),parametersPanel);
        dataPane.setLayout(new BorderLayout());
        dataPane.add(dataView);
       // dataPane.add(dcc,BorderLayout.NORTH);
        dataPane.setMaximumSize(new Dimension(Integer.MAX_VALUE,Integer.MAX_VALUE));
        dataP.add(dataPane);
        dataP.add(Box.createRigidArea(new Dimension(0,0)));
        //caption
        captionPane = new javax.swing.JScrollPane ();
        Caption = new javax.swing.JTextArea(Const.trans("initialcaption"));
        /*Caption.setText (Const.trans("initialcaption"));
        Caption.setFont (new java.awt.Font ("Dialog", 0, 10));
        Caption.setLineWrap(true);
        Caption.setEditable(false);
        Caption.setWrapStyleWord(true);
        captionPane.setViewportView (Caption);
        captionPane.setHorizontalScrollBarPolicy (JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
        captionPane.setVerticalScrollBarPolicy (JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);
        dataP.add(SwingEx.wrapSpace(captionPane,5,0,0,0));
        dataP.add(Box.createRigidArea(new Dimension(0,0)));*/
        
        //primary controls
        GridBagConstraints gridBagConstraints1 = new GridBagConstraints ();
        gridBagConstraints1.gridx=1;
        gridBagConstraints1.gridy=0;
        gridBagConstraints1.gridwidth=1;
        gridBagConstraints1.fill=gridBagConstraints1.VERTICAL;
        gridBagConstraints1.weightx=0.0f;
        gridBagConstraints1.weighty=0.0f;
        gridBagConstraints1.insets = new Insets (6, 6, 5, 5);
        gridBagConstraints1.anchor=gridBagConstraints1.NORTHWEST;
        contentPanel.add(primaryControls,gridBagConstraints1);
        
        //control panel
        /*gridBagConstraints1 = new GridBagConstraints ();
        gridBagConstraints1.gridx=0;
        gridBagConstraints1.gridy=0;
        gridBagConstraints1.gridheight=2;
        gridBagConstraints1.fill=gridBagConstraints1.BOTH;
        gridBagConstraints1.weightx=0.0f;
        gridBagConstraints1.weighty=1.0f;
        gridBagConstraints1.insets = new Insets (6, 6, 5, 0);
        gridBagConstraints1.anchor=gridBagConstraints1.NORTH;
        controlPanel.setAlignmentX(0.0f);
        contentPanel.add(controlPanel,gridBagConstraints1);*/
        
        //screen panel
        screenPanel.setBackground (Color.black);
        screenPanel.setMinimumSize(new Dimension(500,350));
        screenPanel.setPreferredSize(new Dimension(500,350));
        screenPanel.setLayout(new BorderLayout());
        gridBagConstraints1 = new GridBagConstraints ();
        gridBagConstraints1.gridwidth=1;
        gridBagConstraints1.fill=gridBagConstraints1.BOTH;
        gridBagConstraints1.weightx=1.0f;
        gridBagConstraints1.weighty=1.0f;
        gridBagConstraints1.gridx = 1;
        gridBagConstraints1.gridy = 1;
        gridBagConstraints1.insets = new Insets (0, 6, 6, 6);
        contentPanel.add (screenPanel, gridBagConstraints1);    
        
        createMenus();

        Intermol3D.background.getDesktop().add(this);
        Intermol3D.background.getDesktop().moveToFront(this);
    	createDesktopManager();
    }	
    private boolean internalUpdate=false;
    private void createDesktopManager(){
    	Intermol3D.background.getDesktop().add(optionsTab);
		Intermol3D.background.getDesktop().moveToBack(optionsTab);
        Intermol3D.background.getDesktop().add(dataTab);
        Intermol3D.background.getDesktop().moveToBack(dataTab);  
        
        optionsP.addComponentListener(new ComponentAdapter(){
        	public void componentShown(ComponentEvent e){
        		optionsOn=true;
        		updateDesktopLayout();	
        	}
        	public void componentHidden(ComponentEvent e){
        		optionsOn=false;
        		updateDesktopLayout();
        	}
        });
        dataP.addComponentListener(new ComponentAdapter(){
        	public void componentShown(ComponentEvent e){
        		dataOn=true;
        		updateDesktopLayout();	
        	}
        	public void componentHidden(ComponentEvent e){
        		dataOn=false;
        		updateDesktopLayout();
        		internalUpdate=false;
        	}
        });
    	addComponentListener(new java.awt.event.ComponentAdapter(){
            public void componentResized(ComponentEvent e){
                setLocation(((getToolkit().getScreenSize().width/2)-(
                	(getSize().width+Math.max(getLocation().x-optionsTab.getLocation().x,
                	getLocation().x-dataTab.getLocation().x))/2))+
                	Math.max(getLocation().x-optionsTab.getLocation().x,
                	getLocation().x-dataTab.getLocation().x),
                	(getToolkit().getScreenSize().height/2)-(
                	(getSize().height)/2));
                updateDesktopLayout();
            }
            public void componentMoved(ComponentEvent e){
            	updateDesktopLayout();
            }
        });
        
    }

	public void hideAll(){
		internalUpdate=true;
		setVisible(false);
		optionsTab.setVisible(false);
		dataTab.setVisible(false);
	}

	public void showAll(){
		internalUpdate=true;
		setVisible(true);
		optionsTab.setVisible(true);
		dataTab.setVisible(true);
	}
    
    private static final int TAB_BREAK=3,MAIN_OVERLAP=3,DATA_MAX=300;
    private boolean optionsOn=false,dataOn=false;
    public void updateDesktopLayout(){
    	if(internalUpdate) return;
    	setVisible(true);
    	optionsTab.setVisible(false);
        dataTab.setVisible(false);
        
    	optionsTab.setSize(optionsTab.getPreferredSize());
		
		Point ml=getLocation(),cl=getContentPane().getLocationOnScreen();
		Dimension ms=getSize(),cs=getContentPane().getSize(),os=optionsTab.getSize();
		
		optionsTab.setLocation((ml.x+MAIN_OVERLAP)-os.width,cl.y);
		Point op=optionsTab.getLocation();
		
		int n;
		if(optionsOn&&dataOn) n=os.width;
		else n=dataTab.getPreferredSize().width;
		dataTab.setSize(n,Math.min(DATA_MAX,cs.height-(TAB_BREAK+os.height)) );
		Dimension ds=dataTab.getSize();
		dataTab.setLocation((ml.x+MAIN_OVERLAP)-ds.width,op.y+TAB_BREAK+os.height);
		Point dl=dataTab.getLocation();
		
		if(ml.y<0){ setLocation(ml.x,0); updateDesktopLayout(); }
		if(Math.min(op.x,dl.x)<0){ 
			setLocation(Math.max(ml.x-op.x,ml.x-dl.x),ml.y); updateDesktopLayout(); 
		}
		if(ml.y+ms.height>getToolkit().getScreenSize().height){
			if(ml.y==0) 
				setSize(ms.width,(ms.height-((ml.y+ms.height)-getToolkit().getScreenSize().height))-1);
			else setLocation(ml.x,ml.y-((ml.y+ms.height)-(getToolkit().getScreenSize().height)));
			updateDesktopLayout();
		}
		if(ml.x+ms.width>getToolkit().getScreenSize().width){
			if(Math.min(op.x,dl.x)==0) 
				setSize((ms.width-((ml.x+ms.width)-getToolkit().getScreenSize().width))-1,ms.height);
			else setLocation(ml.x-((ml.x+ms.width)-(getToolkit().getScreenSize().width)),ml.y);
			updateDesktopLayout();
		}		
    	optionsTab.setVisible(true);
        dataTab.setVisible(true);
    }
    private final JPanelEx contentPanel=new JPanelEx("Main Window");
    
    public final JPanelEx screenPanel=new JPanelEx("Screen Panel");
    
    public final JPanelEx primaryControls=new JPanelEx("Primary Controls");
    private final ToolbarButtonEx playButton,pauseButton,stepButton;
    private final ToggleButtonEx optionsButton;
    public final JPanel screenControls=new JPanel();
    
    public final JPanelEx controlPanel=new JPanelEx("Content Panel");
    public final JPanel simControls=new JPanel();
    {simControls.setLayout(new BoxLayout(simControls,BoxLayout.Y_AXIS));}
    public final JComboBox  energyCombo=new JComboBox();
    public final ComboGroupEx movieModeCombo;
    public final SliderGroupEx value1,value2;
    public final JButton addIon,removeIon,addH2O,removeH2O;
    
    public final JPanel crtControls=new JPanel();
    {crtControls.setLayout(new BoxLayout(crtControls,BoxLayout.Y_AXIS));}
    public final SliderGroupEx timeline;
    public final JButton rememberFrame,trashFrame;
    
    public final JTextArea Caption;
    public final JScrollPane captionPane;
    
    public final JCheckBox avgData;
    public final JButton   resetData;
    public final JTabbedPane dataView=new JTabbedPane();
    public final JPanelEx parametersPanel=new JPanelEx("Parameters");
    public final JPanelEx graphPanel=new JPanelEx("Graph Panel");
    public final JComboBox graphMode=new JComboBox();
    public final JPanel dataPane=new JPanel();

    //menus
    private final JMenuBar menuBar=new JMenuBar();
    public JMenuItem
        fileLoad,fileSave,fileCreateMovie,fileSaveMovie,fileReset,fileQuit,
        editScene,editMovie,editCaption,editParameters,
        snapshotMovie,snapshotGraph,snapshotAverage,
        helpAbout;
    public JCheckBoxMenuItem 
        snapshotShow,
        trackingOn,velocityOn,
        helpTooltips;
    public JMenu 
        fileMenu, exportPictureSub, filePresets,
        editMenu,
        optionsMenu, 
        speedSub,updateSub,floatSub,
        snapshotMenu,
        viewMenu,updateRate,
        helpMenu,lessonList;
    private JLabel TEMPLABEL=new JLabel();
    private void createMenus(){
        fileMenu=new JMenu(Const.trans("file.label"));
        exportPictureSub=new JMenu(Const.trans("file.exportPicture"));
        filePresets=new JMenu(Const.trans("file.presets"));
        editMenu=new JMenu(Const.trans("edit.label"));
        optionsMenu=new JMenu(Const.trans("options.label"));
        speedSub=new JMenu(Const.trans("options.speed"));
        floatSub=new JMenu(Const.trans("options.float"));
        //trackingOn=new JCheckBoxMenuItem(Const.trans("options.track"));
        //velocityOn=new JCheckBoxMenuItem(Const.trans("options.velocity"));
        snapshotMenu=new JMenu(Const.trans("snapshot.label"));
        updateRate=new JMenu(Const.trans("updateRate.label"));
        helpMenu=new JMenu(Const.trans("help.label"));
        lessonList=new JMenu(Const.trans("help.lessonList"));
        fileLoad=new JMenuItem(Const.trans("file.load")); 
        fileSave=new JMenuItem(Const.trans("file.save"));  
        fileReset=new JMenuItem(Const.trans("reset.label"));
        fileCreateMovie=new JMenuItem(Const.trans("file.createMovie"));  
        fileSaveMovie=new JMenuItem(Const.trans("file.saveMovie"));  
        fileQuit=new JMenuItem(Const.trans("file.quit"));  
        editScene=new JMenuItem(Const.trans("edit.scene"));
        editMovie=new JMenuItem(Const.trans("edit.movie"));
        editCaption=new JMenuItem(Const.trans("edit.caption"));
        editParameters=new JMenuItem(Const.trans("edit.parameters"));
        //snapshotAverage=new JMenuItem(Const.trans("snapshot.average"));
        //snapshotMovie=new JMenuItem(Const.trans("snapshot.movie"));
        //snapshotGraph=new JMenuItem(Const.trans("snapshot.graph"));
        snapshotShow=new JCheckBoxMenuItem(Const.trans("snapshot.show")); 
        helpTooltips=new JCheckBoxMenuItem(Const.trans("help.tooltips"));
        helpTooltips.setSelected(true);
        helpAbout=new JMenuItem(Const.trans("help.about"));

        menuBar.add(fileMenu);
        //menuBar.add(editMenu);
        //menuBar.add(optionsMenu);
        menuBar.add(updateRate);
        //menuBar.add(snapshotMenu);
        //menuBar.add(helpMenu);
        fileMenu.add(fileLoad);
        fileMenu.add(filePresets);
        fileMenu.add(fileSave);
        //fileMenu.add(fileReset);
        //fileMenu.addSeparator();
        //fileMenu.add(fileCreateMovie);
        //fileMenu.add(fileSaveMovie);
        //fileMenu.addSeparator();
        //fileMenu.add(exportPictureSub);
        fileMenu.addSeparator();
        fileMenu.add(fileQuit);
        editMenu.add(editScene);
        editMenu.add(editMovie);
        editMenu.add(editCaption);
        editMenu.add(editParameters);
        optionsMenu.add(speedSub);
        optionsMenu.add(floatSub);
        helpMenu.add(helpTooltips);
        helpMenu.add(lessonList);
        helpMenu.addSeparator();
        helpMenu.add(helpAbout);
        setJMenuBar(menuBar);
    }
    //SwingUtilities.updateComponentTreeUI(frame);
    public void initComponentsL(Intermol3D app){
        addInternalFrameListener(new javax.swing.event.InternalFrameAdapter() {
            public void internalFrameClosing(javax.swing.event.InternalFrameEvent e) {
                thisWindowClosing();
            }
        });
        fileQuit.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                thisWindowClosing();
            }
        });
        helpAbout.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                about=new IAboutScreen();
            }
        });
        optionsButton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                if(optionsButton.isSelected())
                    controlPanel.setVisible(true);
                else
                    controlPanel.setVisible(false);
            }
        });
        playButton.setEnabled(true);
        pauseButton.setEnabled(false);
        stepButton.setEnabled(true);
        addButtonActionListeners(app);

    }
    Intermol3D app;
    ButtonGroup bg1=new ButtonGroup();
    private void addButtonActionListeners(final Intermol3D apsp){
        this.app=apsp;
        playButton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                app.start();
            }
        });

        pauseButton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                app.stop();
            }
        });
        stepButton.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                app.fullStep();
            }
        });
        ActionListener URA=new ActionListener(){
            public void actionPerformed(ActionEvent e){
                String s=((JMenuItem)e.getSource()).getText();
                if(s.equals(Const.trans("UPDATE_1")))
                    data.setStep(1);
                else if(s.equals(Const.trans("UPDATE_2")))
                    data.setStep(2);
                else if(s.equals(Const.trans("UPDATE_4")))
                    data.setStep(4);
                else if(s.equals(Const.trans("UPDATE_8")))
                    data.setStep(8);
                else if(s.equals(Const.trans("UPDATE_16")))
                    data.setStep(16);
                else if(s.equals(Const.trans("UPDATE_32")))
                    data.setStep(32);
                else if(s.equals(Const.trans("UPDATE_64")))
                    data.setStep(64);    
                else
                    throw new IllegalArgumentException("Unrecognized menu item: "+s);
            }
        };
        /*updateRate.add(Const.trans("UPDATE_1")).addActionListener(URA);;
        updateRate.add(Const.trans("UPDATE_2")).addActionListener(URA);
        updateRate.add(Const.trans("UPDATE_4")).addActionListener(URA);
        updateRate.add(Const.trans("UPDATE_8")).addActionListener(URA);
        updateRate.add(Const.trans("UPDATE_16")).addActionListener(URA);
        updateRate.add(Const.trans("UPDATE_32")).addActionListener(URA);
        updateRate.add(Const.trans("UPDATE_64")).addActionListener(URA);*/
        boolean fst=false;
        for(int i=0;i<8;i++){
            JRadioButtonMenuItem r=new JRadioButtonMenuItem(Const.trans("UPDATE_"+(1<<i)) );
            r.addActionListener(URA);
            bg1.add(r);
            if(!fst){ fst=true; r.setSelected(true); }
            updateRate.add(r);
        }
        fileReset.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                app.clear();
            }
        });
    }
    private boolean mShown = false;

    void thisWindowClosing(){
        setVisible(false);
        dispose();
        System.exit(0);
    }
    private boolean addIonEnabled=true,removeIonEnabled=false;
    public void start(){
        updateRate.setEnabled(false);
        playButton.setEnabled(false);
        fileReset.setEnabled(false);
        pauseButton.setEnabled(true);
        stepButton.setEnabled(false);
        fileSave.setEnabled(false);
        fileLoad.setEnabled(false);
        //AMIT 6/04/03-another hack
        filePresets.setEnabled(false);
        addIonEnabled=addIon.isEnabled();
        removeIonEnabled=removeIon.isEnabled();
        addIon.setEnabled(false);
        removeIon.setEnabled(false);
    }
    public void stop(){
        updateRate.setEnabled(true);
        playButton.setEnabled(true);
        pauseButton.setEnabled(false);
        fileReset.setEnabled(true);
        stepButton.setEnabled(true);
        fileSave.setEnabled(true);
        fileLoad.setEnabled(true);
//		AMIT 6/04/03
		filePresets.setEnabled(true);
		addIon.setEnabled(addIonEnabled);
		removeIon.setEnabled(removeIonEnabled);
    }
    public void clear(){
        fileReset.setEnabled(false);
        fileSave.setEnabled(true);
        fileSave.setEnabled(true);
    }
    public void step(){
    }
}
