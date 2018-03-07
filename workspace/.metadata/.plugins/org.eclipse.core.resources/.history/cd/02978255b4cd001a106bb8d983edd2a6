package Intermol3D;

import java.awt.AWTEvent;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Point;
import java.awt.Robot;
import java.awt.event.AWTEventListener;
import java.awt.event.ComponentEvent;
import java.awt.event.KeyEvent;
import java.awt.event.MouseEvent;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

class HelpScript{
	private int mx,my;
	private static final byte 
		KEY_PRESS_FLAG=Byte.MIN_VALUE,
		KEY_RELEASE_FLAG=Byte.MIN_VALUE+1,
		MOUSE_PRESS_FLAG=Byte.MIN_VALUE+2,
		MOUSE_RELEASE_FLAG=Byte.MIN_VALUE+3,
		TEXT_CHANGE_FLAG=Byte.MIN_VALUE+4,
		WAIT_FLAG=Byte.MIN_VALUE+5,
		LAST_FLAG=WAIT_FLAG;//must update
	public static final int
		STOP_FLAG= KeyEvent.VK_ESCAPE;
	private static final long helpScriptKey=74687001;
	private Robot bot;
	public Robot getBot(){
		return bot;
	}
	private final int THREAD_PRIORITY=Thread.MIN_PRIORITY+1;
	private final long THREAD_DELAY=50;
	private boolean playRuner=false;
	private final Thread runer;

	private DataInputStream data=null; private DataOutputStream dataOut=null;
	private int numValues;
	private final Container gui;
	private HelpInterface face=null;
	private HelpEditorInterface edit=null;
	public HelpScript(Container guit){
		this.gui=guit; 
		runer=new Thread(new Runnable(){
			public void run(){
				byte cur,next;
				int i;
				try{
					while(playRuner){
						if(notStoped){
							cur=data.readByte();
							switch(cur){
								case KEY_PRESS_FLAG:
									i=data.readInt();
									bot.keyPress(i);
									break;
								case KEY_RELEASE_FLAG:
									i=data.readInt();
									bot.keyRelease(i);
									break;
								case MOUSE_PRESS_FLAG:
									i=data.readInt();
									bot.mousePress(i);
									break;
								case MOUSE_RELEASE_FLAG:
									i=data.readInt();
									bot.mouseRelease(i);
									break;
								case TEXT_CHANGE_FLAG:
									face.setText(data.readUTF());
									break;
								case WAIT_FLAG:
									gui.getToolkit().removeAWTEventListener(escListener);
									winLoc=(Point)gui.getLocation().clone();
									winDim=(Dimension)gui.getSize().clone();
									notStoped=false;
									face.scriptPaused();
									break;
								default:
									next=data.readByte();
									mx+=cur;
									my+=next;
									System.out.println("mouse move"+mx+","+my+","+cur+","+next);
									bot.mouseMove(mx,my);
									break;
							}
							try{ sleep(); }
							catch(Exception e){
							}
						}
					}
				}catch(Exception e){
					e.printStackTrace();
				}
				try{
					data.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				data=null;
				face.scriptDone();
			}
		});
		runer.setPriority(THREAD_PRIORITY);
		escListener=new AWTEventListener(){
			public void eventDispatched(AWTEvent e){
				if(((KeyEvent)e).getID()==KeyEvent.KEY_RELEASED&&
				((KeyEvent)e).getKeyCode()==STOP_FLAG){
					if(!notStoped) throw new IllegalStateException("Cannot exit playing script");
					gui.getToolkit().removeAWTEventListener(escListener);
					winLoc=(Point)gui.getLocation().clone();
					winDim=(Dimension)gui.getSize().clone();
					notStoped=false;
					face.scriptPaused();
				}
			}		
		};
		recorder=new AWTEventListener(){
					
			int x,y,x1,y1;
			public void eventDispatched(AWTEvent e){
				try{ System.out.println("recorded event:"+e.getID()+","+MouseEvent.MOUSE_MOVED+",");
					switch(e.getID()){
						case KeyEvent.KEY_RELEASED:
							if(((KeyEvent)e).getKeyCode()==STOP_FLAG){
								winLocRec=(Point)gui.getLocation().clone();
								winDimRec=(Dimension)gui.getSize().clone();
								recordingOn=false;
								removeRecorder();
								edit.recordingStoped();
								break;
							}
							dataOut.writeByte(KEY_RELEASE_FLAG);
							dataOut.writeInt(((KeyEvent)e).getKeyCode());
							break;
						case KeyEvent.KEY_PRESSED:
							dataOut.writeByte(KEY_PRESS_FLAG);
							dataOut.writeInt(((KeyEvent)e).getKeyCode());
							break;
						case MouseEvent.MOUSE_PRESSED:
							dataOut.writeByte(MOUSE_PRESS_FLAG);
							dataOut.writeInt(((MouseEvent)e).getModifiers());
							break;
						case MouseEvent.MOUSE_RELEASED:
							dataOut.writeByte(MOUSE_RELEASE_FLAG);
							dataOut.writeInt(((MouseEvent)e).getModifiers());
							break;
						case MouseEvent.MOUSE_MOVED:
						case MouseEvent.MOUSE_DRAGGED:
							x1=x=(((MouseEvent)e).getX())+((ComponentEvent)e).getComponent().getLocationOnScreen().x;
							y1=y=(((MouseEvent)e).getY())+((ComponentEvent)e).getComponent().getLocationOnScreen().y;
							x-=rx; y-=ry;
							rx=x1;ry=y1;
							if(x>Byte.MAX_VALUE||x<=LAST_FLAG||
							  y>Byte.MAX_VALUE|| x<=LAST_FLAG){
								boolean b=true,b2=true;
								while(b||b2){
									System.out.println("mouse moveP"+x+","+y+","+rx+","+ry);
									if(x>Byte.MAX_VALUE){
										dataOut.writeByte(Byte.MAX_VALUE);
										x-=Byte.MAX_VALUE;
									}else if(x<=LAST_FLAG){
										dataOut.writeByte(LAST_FLAG+1);
										x-=LAST_FLAG+1;
									}else{
										dataOut.writeByte((byte)x);
										x-=x;
										b=false;
									}
									
									if(y>Byte.MAX_VALUE){
										dataOut.writeByte(Byte.MAX_VALUE);
										y-=Byte.MAX_VALUE;
									}else if(y<=LAST_FLAG){
										dataOut.writeByte(LAST_FLAG+1);
										y-=LAST_FLAG+1;
									}else{
										dataOut.writeByte((byte)y);
										y-=y;
										b2=false;
									}
								}
							}else{
								System.out.println("mouse move"+x+","+y+","+rx+","+ry+","+x1+","+y1);
								dataOut.writeByte((byte)x);
								dataOut.writeByte((byte)y);
							}
							break; 
					}
				}catch(Exception exc){
					exc.printStackTrace();
				}
			}		
		};
		try{bot=new Robot();}
		catch(Exception e){
			e.printStackTrace();
		}
	}
	private void sleep() throws InterruptedException{ runer.sleep(THREAD_DELAY); }
	private void removeRecorder(){ gui.getToolkit().removeAWTEventListener(recorder); }
	public void setInterface(HelpInterface face){
		this.face=face;
	}
	public void setInterface(HelpEditorInterface edit){
		this.edit=edit;
	}
	private boolean notStoped=true;
	
	private Point winLoc; private Dimension winDim;
	AWTEventListener escListener;

	public void restartPlaying(){
		if(notStoped) throw new IllegalStateException("Cannot restart playing script!");
		bot.mouseMove(mx,my);
		gui.setLocation(winLoc);
		gui.setSize(winDim);
		
		notStoped=true;
		gui.getToolkit().addAWTEventListener(escListener,AWTEvent.KEY_EVENT_MASK);
	}
	public void startPlaying(String name){
		if(playRuner) throw new IllegalStateException("Cannot open a new script while one is running");
		try{
			data=new DataInputStream(new BufferedInputStream(new FileInputStream(name)) );
			
			if(data.readLong()!=helpScriptKey)
				throw new IllegalArgumentException("Unknown file type:"+name);
			mx=data.readInt();
			my=data.readInt();
			bot.mouseMove(mx,my);
			gui.setLocation(new Point(data.readInt(),data.readInt()));
			gui.setSize(new Dimension(data.readInt(),data.readInt()));
		}catch(Exception e){
			e.printStackTrace();
		}
		gui.getToolkit().addAWTEventListener(escListener,AWTEvent.KEY_EVENT_MASK);
		
		notStoped=true;
		playRuner=true;
		runer.start();	
	}
	public void stopPlaying(){
		gui.getToolkit().removeAWTEventListener(escListener);
		playRuner=false;
		notStoped=false;
	}
	
	private int rx,ry; String recCaption;
	private Point winLocRec;
	private Dimension winDimRec;
	private final AWTEventListener recorder;
	private boolean recordingOn=false;
	public void restartRecording(){
		if(recordingOn) throw new IllegalStateException( "Cannot restart running recorder!" );
		gui.setSize(winDimRec);
		gui.setLocation(winLocRec);
		bot.mouseMove(rx,ry);
		try{
			if(!edit.getText().equals(recCaption)){
				dataOut.writeByte(TEXT_CHANGE_FLAG);
				dataOut.writeUTF(edit.getText());
				recCaption=edit.getText();
			}
			if(edit.getPause()){
				edit.setPause(false);
				dataOut.writeByte(WAIT_FLAG);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		recordingOn=true;
		gui.getToolkit().addAWTEventListener(recorder,AWTEvent.KEY_EVENT_MASK|AWTEvent.MOUSE_EVENT_MASK|AWTEvent.MOUSE_MOTION_EVENT_MASK);
		
	}
	public void startRecording(String name,Point e){
		System.out.println("startrecording"+rx+","+ry);
		try{
			File file=new File(name);
			FileOutputStream fos=new FileOutputStream(file);
			BufferedOutputStream bi=new BufferedOutputStream(fos);
			dataOut=new DataOutputStream(bi);
			dataOut.writeLong(helpScriptKey);
			dataOut.writeInt(e.x); rx=e.x;
			dataOut.writeInt(e.y); ry=e.y;
			dataOut.writeInt(gui.getLocation().x);
			dataOut.writeInt(gui.getLocation().y);
			dataOut.writeInt(gui.getSize().width);
			dataOut.writeInt(gui.getSize().height);

			recCaption=edit.getText();
			dataOut.writeByte(TEXT_CHANGE_FLAG);
			dataOut.writeUTF(recCaption);
		}catch(Exception exc){
			exc.printStackTrace();
		}
		recordingOn=true;
		gui.getToolkit().addAWTEventListener(recorder,AWTEvent.KEY_EVENT_MASK|AWTEvent.MOUSE_EVENT_MASK|AWTEvent.MOUSE_MOTION_EVENT_MASK);
	}
	public void stopRecording(){
		System.out.println(dataOut.toString());
		if(!recordingOn) gui.getToolkit().removeAWTEventListener(recorder);
		try{
			dataOut.writeByte(WAIT_FLAG);
			dataOut.flush();
			dataOut.close();
			dataOut=null;
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}

