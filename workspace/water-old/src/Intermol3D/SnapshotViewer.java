package Intermol3D;

import javax.swing.DefaultDesktopManager;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JComponent;
import javax.swing.JDesktopPane;
import javax.swing.JFrame;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.event.InternalFrameEvent;

import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Graphics;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.Rectangle;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ComponentEvent;
import java.awt.print.PageFormat;
import java.awt.print.Printable;
import java.awt.print.PrinterException;
import java.awt.print.PrinterJob;
import java.util.Hashtable;
import java.util.Vector;
//USES SwingEx(project dependent) and Cascade

public final class SnapshotViewer extends JFrame{

    //private final JScrollPane content=new JScrollPane();
    private final JDesktopPane desktop=new JDesktopPane();
    private final Vector snapshots=new Vector();
    private final Cascade positionManager=new Cascade(new Dimension(550,350));
    private boolean hiding=false;
    Snapshot current=null;
    SnapshotViewer(String name){
        super(name);
        setSize(600,400);
        setVisible(false);
        //content.setViewportView(desktop);
        getContentPane().setLayout(new GridBagLayout());
        GridBagConstraints gbc=new GridBagConstraints();
        gbc.gridy=1; gbc.gridwidth=2; gbc.weightx=1.0; gbc.weighty=1.0; gbc.fill=gbc.BOTH;
        getContentPane().add(desktop,gbc);
        setDefaultCloseOperation(DO_NOTHING_ON_CLOSE);
        addWindowListener (new java.awt.event.WindowAdapter () {
            public void windowClosing (java.awt.event.WindowEvent evt) {
                hiding=true;
                setVisible(false);
                hiding=false;
            }
        });
        addComponentListener(new java.awt.event.ComponentAdapter(){
            public void componentResized(ComponentEvent e){
                Rectangle bounds=new Rectangle(0,0,getSize().width-50,getSize().height-50);
                positionManager.setMaxSize(bounds.getSize());
                for(int i=0;i<snapshots.size();i++){
                    if(!bounds.contains(((Snapshot)snapshots.elementAt(i)).getLocation())){
                        positionManager.remove(((Snapshot)snapshots.elementAt(i)).number);
                        ((Snapshot)snapshots.elementAt(i)).number=positionManager.nextPoint();
                        ((Snapshot)snapshots.elementAt(i)).setLocation(positionManager.getCurrent());
                    }
                }
            }
            /*public void componentShown(ComponentEvent e){
            for(int i=0;i<snapshots.size();i++)
            ((JInternalFrame)snapshots.elementAt(i)).show();
            }*/
        });
        createGUI();
    }
    private final JPanel controls=new JPanel();
    private final JPanel windows=new JPanel(new FlowLayout(FlowLayout.LEFT,0,2));
    private JButton printWin=new JButton(), trashWin=new JButton();
    private final void printAction(){
        if(current==null) return;
        current.beginPrint();
    }

    private void createGUI(){
        //printWin.setEnabled(false); trashWin.setEnabled(false);
        SwingEx.createToolbarButton(printWin,"print");
        printWin.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                printAction();
            }
        });

        SwingEx.createToolbarButton(trashWin,"trash");
        trashWin.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                if(current==null) return;
                current.done();
            }
        });
        controls.setLayout(new FlowLayout(FlowLayout.CENTER,2,2));
        controls.add(printWin);
        controls.add(trashWin);
        controls.setBackground(Color.white);

        GridBagConstraints gbc=new GridBagConstraints();
        gbc.weightx=1.0; gbc.fill=gbc.BOTH; gbc.weighty=0.0f;
        gbc.gridy=0; gbc.gridx=0;
        getContentPane().add(windows,gbc);

        gbc=new GridBagConstraints();
        gbc.gridy=0; gbc.gridx=1;gbc.anchor=gbc.NORTHEAST;
        getContentPane().add(controls,gbc);

        desktop.setDesktopManager(new DefaultDesktopManager(){
            public void resizeFrame(JComponent f, int newX, int newY, int newWidth, int newHeight) {
                Snapshot jif=null;
            try{jif=(Snapshot)f;}
            catch(Exception e){System.err.println("WARNING not resizing snapshot:"+e.toString());}
                if(jif!=null){
                    if(newWidth>jif.trueMaxSize.width-2) newWidth=jif.trueMaxSize.width;
                    if(newHeight>jif.trueMaxSize.height-2) newHeight=jif.trueMaxSize.height;
                }
                setBoundsForFrame(f, newX, newY, newWidth, newHeight);
            }
        });
    }
    public void addSnapshot(ImageIcon image){
        addSnapshot(image,null, true);
    }
    public void addSnapshot(ImageIcon image, String name){
        addSnapshot(image,name, true);
    }
    private final Hashtable snapBoxes=new Hashtable();
    private final Hashtable reverseSnapBoxes=new Hashtable();
    public void addSnapshot(ImageIcon image, String origname, boolean prompt){
        final boolean curvis=isVisible();
        setVisible(true);
        String name;
        if(origname==null){
            name = JOptionPane.showInternalInputDialog(desktop,Const.trans("snapshots.create.enter"),
            Const.trans("snapshots.create.title"),JOptionPane.QUESTION_MESSAGE);
        }else if(prompt){
            name = (String)JOptionPane.showInternalInputDialog(desktop,Const.trans("snapshots.create.edit"),
            Const.trans("snapshots.create.title"),JOptionPane.QUESTION_MESSAGE, null, null, origname);
        }else{
            name=origname;
        }
        if(name==null){
            if(!curvis) setVisible(false);
            return;
        }
        Snapshot snap=new Snapshot(image,name,positionManager.nextPoint());
        snapshots.addElement(snap);
        snap.setLocation(positionManager.getCurrent());
        JCheckBox box=new JCheckBox(name);
        windows.add(box);
        snapBoxes.put(snap,box);
        reverseSnapBoxes.put(box,snap);
        box.setSelected(true);
        box.addActionListener(new ActionListener(){
            public void actionPerformed(ActionEvent e){
                if(((JCheckBox)e.getSource()).isSelected())
                ((JInternalFrame)reverseSnapBoxes.get(e.getSource())).setVisible(true);
                else
                ((JInternalFrame)reverseSnapBoxes.get(e.getSource())).setVisible(false);
            }
        });
        box.setVisible(false); box.setVisible(true);
        windows.setSize(windows.getMaximumSize());
    }
    public static void doNothing(JInternalFrame jif){
        jif.setDefaultCloseOperation(JInternalFrame.DO_NOTHING_ON_CLOSE);
    }
    final class Snapshot extends JInternalFrame{
        private PrintableLabel label;
        public int number;
        public final Dimension trueMaxSize;

        Snapshot(ImageIcon image,String name,int num){
            super(name);
            this.number=num;
            getContentPane().setLayout(new BorderLayout());
            label= new PrintableLabel();
            label.setIcon(image);

            /*label.addMouseListener(new MouseAdapter(){
            public void mouseClicked(MouseEvent ev) {
            if(ev.getClickCount() == 2) {
            beginPrint();
            }
            }
            });
            label.setToolTipText(Const.trans("snapshots.tip"));*/

            setResizable(true);
            JScrollPane jsp=new JScrollPane();
            jsp.setViewportView(label);
            getContentPane().add(jsp,BorderLayout.CENTER);
            pack();
            trueMaxSize=getSize();

            setMaximizable(false);
            setIconifiable(false);
            setClosable(false);
            desktop.add(this,new Integer(5));
            addInternalFrameListener (new javax.swing.event.InternalFrameAdapter () {
                public void internalFrameClosing(javax.swing.event.InternalFrameEvent e) {
                    if(!hiding){
                        //setVisible(false);
                        //((JCheckBox)snapBoxes.get(e.getSource())).setSelected(false);
                    }
                }
                public void internalFrameActivated(InternalFrameEvent e){
                    current=(Snapshot)e.getSource();
                    printWin.setEnabled(true);
                    trashWin.setEnabled(true);
                }
                public void internalFrameDeactivated(InternalFrameEvent e){
                    if(current==e.getSource()){
                        current=null;
                        printWin.setEnabled(false);
                        trashWin.setEnabled(false);
                    }
                }
            });
            show();
        }
        private void done(){
            snapshots.remove(this);
            ((JCheckBox)snapBoxes.get(this)).setVisible(false);
            windows.remove((JComponent)snapBoxes.get(this));
            positionManager.remove(number);
            reverseSnapBoxes.remove((JCheckBox)snapBoxes.get(this));
            snapBoxes.remove(this);
            dispose();
        }
        private void beginPrint(){
            PrinterJob printJob = PrinterJob.getPrinterJob();
            printJob.setPrintable(label);
            if (printJob.printDialog()) {
                try {
                    printJob.print();
                } catch (Exception ex) {
                    System.err.println(ex.toString());
                    //ex.printStackTrace();
                }
            }
        }
    }
}
final class PrintableLabel extends JLabel implements Printable{
    PrintableLabel(){
        super();
    }
    public int print(Graphics g, PageFormat pf, int pi) throws PrinterException {
        if (pi >= 1) {
            return Printable.NO_SUCH_PAGE;
        }
        //paintComponent(g);
        getIcon().paintIcon(this,g,144,144);
        return Printable.PAGE_EXISTS;
    }
}