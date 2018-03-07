package Intermol3D;

import javax.swing.Box;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JInternalFrame;
import javax.swing.JLabel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;

class HelpEditorInterface extends JInternalFrame{
	private JButton start=null,finish;
	private final JLabel instructions;
	private final JCheckBox pause;
	private final JTextArea text;
	private final HelpScriptChooser hsct;
	private final HelpScript script;
	private final String name;
	public HelpEditorInterface(HelpScript script,HelpScriptChooser hsc,String name){
		super(Const.trans("helpRecorder.title"));
		hsct=hsc; this.script=script; this.name=name;
		
		instructions=new JLabel(Const.trans("helpRecorder.begin.info"));
		
		pause=new JCheckBox("helpRecorder.pause.label");
		pause.setEnabled(false);
		
		text=new JTextArea(name);
		text.setFont(new Font("Dialog",Font.BOLD|Font.ITALIC,14));
		JScrollPane jscroll=new JScrollPane(text,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
			JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		text.setEditable(true);
		text.setEnabled(true);
		start=new JButton(Const.trans("helpRecorder.start.label"));
		start.addMouseListener(startListener);
		
		finish=new JButton(Const.trans("helpRecorder.finish.label"));
		finish.setEnabled(false);
		
		Box controls=Box.createHorizontalBox();
		controls.add(Box.createRigidArea(new Dimension(5,5)));
		controls.add(start);
		controls.add(Box.createRigidArea(new Dimension(5,5)));
		controls.add(pause);
		controls.add(Box.createRigidArea(new Dimension(5,5)));
		controls.add(instructions);
		controls.add(Box.createHorizontalGlue());
		controls.add(finish);
		controls.add(Box.createRigidArea(new Dimension(5,5)));
		
		Dimension sSize=getToolkit().getScreenSize();
		setLocation(new Point(0,sSize.height-100));
		setSize(new Dimension(sSize.width,100));
		getContentPane().setLayout(new BorderLayout(5,5));
		getContentPane().add(jscroll,BorderLayout.CENTER);
		getContentPane().add(controls,BorderLayout.NORTH);
		setVisible(true);
	}
	private final MouseListener startListener=new MouseAdapter(){
		public void mouseReleased(MouseEvent e){
			System.out.println("Start");
			startRun(e.getX(),e.getY());
		}
	};
	public void startRun(int x,int y){
		System.out.println("Start");
		finish.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				script.stopRecording();
				hsct.finishCreation();
				dispose();
			}
		});
		finish.setEnabled(true);
		start.removeMouseListener(startListener);
		start.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				script.restartRecording();
				start.setEnabled(false);
				instructions.setText(Const.trans("helpInterface.instructions.escape"));
			}
		});
		start.setEnabled(false);
		start.setText(Const.trans("helpRecorder.resume.label"));
		
		instructions.setText(Const.trans("helpInterface.instructions.escape"));
		pause.setEnabled(true);
		script.startRecording(name,new Point(x,y));
	}
	public String getText(){
		return text.getText();
	}
	public boolean getPause(){
		return pause.isSelected();
	}
	public void setPause(boolean v){
		pause.setSelected(v);
	}
	public void recordingStoped(){
		start.setEnabled(true);
		instructions.setText(Const.trans("helpInterface.instructions.resume"));
	}
	
}