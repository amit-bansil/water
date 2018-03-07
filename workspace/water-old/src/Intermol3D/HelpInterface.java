package Intermol3D;

import javax.swing.Box;
import javax.swing.JButton;
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

class HelpInterface extends JInternalFrame{
	private final JButton start,finish;
	private final JLabel instructions;
	private final JTextArea text= new JTextArea();
	private final HelpScript script;
	private final String name;
	private final HelpScriptChooser hsc;
	public HelpInterface(HelpScript scrip,HelpScriptChooser par,String n){
		super(n,false,false,false,false);
		script=scrip; name=n; hsc=par;
		start=new JButton(Const.trans("helpInterface.start.label"));
		finish=new JButton(Const.trans("helpInterface.finish.label"));
		instructions=new JLabel(Const.trans("helpInterface.instructions.start"));
		finish.setEnabled(false);
		finish.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent e){
				script.stopPlaying();
				/*hsc.done();
				dispose();*/
			}
		});
		
		start.addActionListener(startListener);
		text.setFont(new Font("Dialog",Font.BOLD|Font.ITALIC,14));
		JScrollPane jscroll=new JScrollPane(text,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
			JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		text.setEditable(false);
		
		Box controls=Box.createHorizontalBox();
		controls.add(Box.createRigidArea(new Dimension(5,5)));
		controls.add(start);
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
	ActionListener startListener=new ActionListener(){
		public void actionPerformed(ActionEvent e){
			start();
		}
	};
	public void setText(String t){
		text.setText(t);
	}

	public void start(){
		instructions.setText(Const.trans("helpInterface.instructions.escape"));
		start.setText(Const.trans("helpInterface.continue.label"));
		start.removeActionListener(startListener);
		start.addActionListener(continueListener);
		start.setEnabled(false);
		finish.setEnabled(true);
		script.startPlaying(name);
	}
	ActionListener continueListener=new ActionListener(){
		public void actionPerformed(ActionEvent e){
			resume();
		}
	};
	public void resume(){
		instructions.setText(Const.trans("helpInterface.instructions.escape"));
		script.restartPlaying();
		start.setEnabled(false);
	}
	public void scriptPaused(){
		instructions.setText(Const.trans("helpInterface.instructions.resume"));
		script.getBot().mouseMove(start.getLocationOnScreen().x+(start.getSize().width/2),
			start.getLocationOnScreen().y+(start.getSize().height/2));
		start.setEnabled(true);
	}
	public void scriptDone(){
		setVisible(false);
		hsc.done();
		dispose();
	}
	
}