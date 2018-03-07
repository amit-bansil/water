package Intermol3D;
import javax.swing.JOptionPane;
import javax.swing.Timer;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
public final class Intermol3D implements ActionListener
{
    public static ISplashScreen splash;
    public static final BlackWindow background;
    static{
        background=new BlackWindow();
        splash=new ISplashScreen();
        splash.setState("Intermol3D Core");
    }
    private final IInterface        gui;
    private final I3DDisplay        display;
    private final SystemParameters  sysParams;
    private final IonManager        ions;
    private final IData		    data;
    private final GraphManager      graphs;
    private final IOManager         io;
    
    private boolean running=false;
    private final Timer timer;
    private final HelpScriptChooser helpSupport;
    private final CaptionController captions;
    
    private int fps = 16;
    
    // Main entry point
    public static void main(String[] args){
        
        Const.init(args);
        new Intermol3D();
    }

    protected void finalize(){
        background.dispose();
    }
    public Intermol3D() //CONSTRUCTOR
    {
        data = new IInternalData();
        gui=new IInterface(data);

        display = new I3DDisplay(gui.screenPanel,gui.screenControls,data,gui.energyCombo);

        sysParams=new SystemParameters(gui.value1,gui.value2,gui.movieModeCombo,data);
        ions=new IonManager(display,gui,data);
        helpSupport=new HelpScriptChooser(gui.lessonList,gui);
        io=new IOManager(display,gui.fileSave,gui.fileLoad,gui.filePresets,
            gui.fileCreateMovie,gui.fileSaveMovie,gui.crtControls,data,this);        
        
        gui.pack();
        clear();
        enableActionListeners();
        gui.setLocation((gui.getToolkit().getScreenSize().width/2)-(gui.getSize().width/2),
        (gui.getToolkit().getScreenSize().height/2)-(gui.getSize().height/2));
        
        graphs=new GraphManager(data,gui.graphMode,gui.graphPanel,gui.parametersPanel,gui.resetData,gui.avgData);
        captions=new CaptionController(background.getDesktop(),gui.helpTooltips);
        gui.setVisible(true);
    	gui.updateDesktopLayout();
        try{
        	gui.setSelected(true);
        }catch(Exception e){
        	e.printStackTrace();
        }
        timer = new Timer(1000/fps,this);
        timer.setCoalesce(true);
        splash.dispose(); splash=null;
    }

    public void clear(){ //CALLED TO RESET THE APP
        if(running){ //DEBUG
            System.err.println("WARNING: App could"
            +"not be cleared because it is running");
            return;
        }
        data.clear();
        display.clear();
        gui.clear();
        sysParams.step();
        ions.clear();
        io.clear();
        if(graphs!=null) graphs.clear();
    }
    public void start(){ //CALLLED TO START SIMULATION
        if(running){ //DEBUG
            System.err.println("WARNING: App could"
            +"not be started because it is already running");
            return;
        } running =true;
        data.start();
        gui.start();
        display.start();
        sysParams.start();
        graphs.start();

        timer.restart();
    }
    public void stop(){ //CALLED TO STOP SIMULATION
        if(!running){ //DEBUG
            System.err.println("WARNING: App could"
            +"not be stopped because it is already stopped");
            return;
        }running=false;
        data.stop();
        gui.stop();
        display.stop();
        sysParams.stop();
        graphs.stop();

        timer.stop();
    }
    private static final String shakeFailString=
    "The Molecule Positions could not be computed\n"+
    "Because of invalid positions or velocities.\n"+
    "Please pause and reposition the molecules or reset";

    public void fullStep(){
        if(running){ //DEBUG
            System.err.println("WARNING: App could"
            +"not be started because it is already running");
            return;
        }
        int c=-1;
        data.start();
        gui.start();
        display.start();
        sysParams.start();
        try{
            data.step();
            gui.step();
            display.step();
            sysParams.step();
            graphs.step();
            io.step();

        }catch(ShakeFailException e){
        Object[] options = { "Reset", "Pause" };
            c=JOptionPane.showOptionDialog(null, shakeFailString, "Simulation Error",
            JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE,
            null, options, options[0]);
            //if(c==1)
            //	data.restoreLast();
        }
        data.stop();
        gui.stop();
        display.stop();
        sysParams.stop();
        if(c==0) clear();
    }
    public void actionPerformed(ActionEvent e){ //CALLED EVERY TIMESTEP
        //TIMER CODE TO PREVENT EVENT OVERFLOWS
        if(running){
            try{
                data.step();
                display.step();
                gui.step();
                sysParams.step();
                graphs.step();
                io.step();
            }catch(ShakeFailException x){
            Object[] options = { "Reset", "Pause" };
                int c=JOptionPane.showOptionDialog(null, shakeFailString, "Simulation Error",
                JOptionPane.DEFAULT_OPTION, JOptionPane.WARNING_MESSAGE,
                null, options, options[0]);
                if(c==0){
                    stop();
                    clear();
                }else if(c==1){
                    stop();
                }
            }
        }else
        System.err.println("WARNING: step could not be performed while stoped");
    }
    private void enableActionListeners(){
        gui.initComponentsL(this);
    }
}