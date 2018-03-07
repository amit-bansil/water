package Intermol3D;
import javax.swing.JPanel;

import java.awt.Color;
import java.awt.Container;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Image;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseMotionAdapter;
public final class RTGraph extends JPanel{
	
	//CONSTANTS
		//mathematical
	private static final byte aStep2rStep[] = 
			 {2,2,2,2,5,5,5,5,10,10,10};
	private static final float Log10 = (float)Math.log(10);
		//axis
	private static final Font LABELFONT = new Font("Dialogue",Font.PLAIN,10);	
	
	private static final float YROUND = 100, XROUND = 100;
	private static final int YPIXELS_PER_STEP = 30;
	
	private static final int PIXELS_PER_MAJOR = 50;
	private static final int LABEL_WIDTH=30,LABEL_HEIGHT=12;
		//graphical
	private static final int XOFFSET=30,YOFFSET=20;
	private static final int TITLESPACE=20;
	
	private static final int LOCATIONSPACE = 100;
	
	private final int width,height, aWidth, aHeight;
		//memory
	public static final int BUFFERSIZE = 1000;
	
	//convience class represting self scaling Y AXIS	
	private final class YAxis{
		public double aMin, aMax, rMin, rMax, step;
		
		public boolean valid, redraw;
		private int numTicks;	
		YAxis(){
			numTicks = aHeight/YPIXELS_PER_STEP;			
		}
		public void init(){
			aMin=-Float.MIN_VALUE;
			aMax=+Float.MIN_VALUE;
			rMin = aMin;
			rMax = aMax;
			step = 0;
			conversion = (double)0;
			valid = false;
			redraw = true;
			validate();
		}
		public boolean setAMin(double a){
			aMin = a;
			valid = false; redraw = true;
			return true;
		}
		public boolean setAMax(double a){
			aMax = a;
			valid = false; redraw = true;
			return true;
		}	
		public boolean validate(){
			if(valid) return false;
			
			redraw = true;
			double aStep = (aMax-aMin)/numTicks;
			double e = (double)Math.pow(10,Math.floor(Math.log(aStep)/Log10) );
			step = aStep2rStep[(int)Math.round( aStep/e )]*e;
			rMin = Math.floor(aMin/(step))*step;
			rMax = Math.ceil(aMax/(step))*step;	
			conversion = aHeight/(rMax-rMin);

			valid = true;	

			return true;	
		} 
		public boolean draw(){
			if(!redraw) return false;
			
			backg.clearRect(0,0,XOFFSET,height);
			backg.clearRect(0,0,XOFFSET+14,TITLESPACE);
			double exp = Math.floor(Math.log(rMax)/Log10);
			if(Math.floor(Math.log(Math.abs(rMin))/Log10)>exp)
				exp = Math.floor(Math.log(Math.abs(rMin))/Log10);
			
			double pow = Math.pow(10,exp);
			double eStep = step/pow;

			double pStep = conversion*step;
			double yp = aHeight+TITLESPACE;
			
			float roundedLabel;
			backg.setFont(LABELFONT);
			backg.drawLine(XOFFSET, aHeight+TITLESPACE, XOFFSET, TITLESPACE);// axis line
			if((int)exp!=0) backg.drawString("x10^ "+(int)exp,2,TITLESPACE/2);
			for(double label = rMin/pow; label<=rMax/pow; label+=eStep){
				backg.drawLine(XOFFSET, (int)yp, XOFFSET-3, (int)yp);
				roundedLabel=(float)Math.round(label*YROUND)/YROUND;
				backg.drawString(Float.toString(roundedLabel),2, (int)yp+4);
				yp -= pStep;	
			}				
			redraw=false; //no longer need to redraw
			return true;
		}
		public String value2String(int v){
			return Float.toString(Math.round( (rMax-((v-TITLESPACE)/conversion))*1000 )/1000f );
		}
	}
	private final class XAxis{
		public double timeStep;
		
		public int majorStep;
		
		private int pointStart, pointOffset, numPoints;
		private short[] points;
		private double oldConversion,oldRMax;
		
		private int oldPointStart;
		private Image[] labels;
		private int firstPoint;
		private int firstLabel;
		private Container parent;
		private boolean firstTime;
		
		private int fix;
		
		public XAxis(double ts,Container p){
			timeStep = ts;		
			majorStep = PIXELS_PER_MAJOR;
			labels=new Image[aWidth/majorStep];
			parent=p;
			for(int i=0;i<labels.length;i++){
				labels[i]=Const.getImage(LABEL_WIDTH,LABEL_HEIGHT);
			}
		}
		public void init(){
			pointStart = 0; oldPointStart=0; firstTime=true;
			points = new short[BUFFERSIZE]; //the points
			numPoints=0;
			pointOffset =0;
			oldConversion=0; oldRMax=0;
			Graphics tg;
			for(int i=0; i<labels.length;i++){
				tg=labels[i].getGraphics();
				tg.setFont(LABELFONT);
				tg.clearRect(0,0,LABEL_WIDTH,LABEL_HEIGHT);
                                tg.setColor(Color.white);
				//Quick fix for bad labels, AMIT 6/04/03, user has no perception of time anyway
				//tg.drawString(Float.toString((float)(i*majorStep*timeStep)),3,(LABEL_HEIGHT/2)+3);
				tg.drawLine(1,1,1,3);
			}
			firstPoint=XOFFSET; firstLabel = 0; fix=0;
		}
		public void addPoints(float[] values, int start, int newValues){
			if(conversion!=oldConversion) //reset the points if its a new conversion
				recalc();
			else if(y.rMax != oldRMax)
				recalc();
					
			numPoints+=newValues;
		
			if(numPoints-pointOffset >= points.length){//if the array is full translate
				short[] newPoints = new short[BUFFERSIZE];
				System.arraycopy(points, points.length/2,
					newPoints, 0, points.length-(points.length/2));
				points = null;
				points = newPoints;
				pointOffset+=points.length/2;
			}
			
			int n=start;
			for(int i = (numPoints-newValues)-pointOffset; i<numPoints-pointOffset;i++){
				points[i] = (short)( ((y.rMax-(values[n]))*conversion)+TITLESPACE ); //tack it on the end
				n++;
			}	
		}
		public int getValue(int y){
			if(y<XOFFSET) return -1;
			if(pointStart+(y-XOFFSET)>=numPoints) return -1;
			else return (int)points[(pointStart+(y-XOFFSET))-pointOffset];
		}
		private void recalc(){
			int i=pointStart-pointOffset;
			if(i<0) i=0;
			for(;i<numPoints-pointOffset;i++){
				points[i]= (short)( ((y.rMax-(oldRMax-((points[i]-TITLESPACE)/oldConversion)))*conversion)+TITLESPACE );
			}
			oldConversion = conversion;
			oldRMax = y.rMax;
		}
		
		public void draw(){
		
			backg.drawLine(XOFFSET, aHeight+TITLESPACE, width, aHeight+TITLESPACE);
		
			if(numPoints>=aWidth){ x.pointStart=numPoints-aWidth; }
			else x.pointStart=0;
		
			int xp=XOFFSET;
			for(int i = x.pointStart-pointOffset; i+1<numPoints-pointOffset; i++){ 
                            backg.drawLine(xp,points[i],xp+1,points[i+1]);
				xp++;
			}
			if(pointStart!=oldPointStart||firstTime){ //may create bug?
				firstTime=false;
				backg.clearRect(XOFFSET,aHeight+TITLESPACE+1,aWidth,YOFFSET);
				int i=firstPoint-(pointStart-oldPointStart); //more for that bug
				if(i<XOFFSET){
					Graphics tg = labels[firstLabel].getGraphics();
					tg.setFont(LABELFONT);
					tg.clearRect(0,0,LABEL_WIDTH,LABEL_HEIGHT);
                                        tg.setColor(Color.white);
					//Quick fix for bad labels, AMIT 6/04/03, user has no perception of time anyway
					//tg.drawString(Float.toString((float)(((((oldPointStart-fix)))+(majorStep*(labels.length)))*timeStep))
					//	,3,(LABEL_HEIGHT/2)+3); fix++;
					tg.drawLine(1,1,1,3);
					firstLabel++;
					if(firstLabel>=labels.length) firstLabel=0;
					firstPoint+=majorStep;
				}else firstPoint=i;
				int inum=firstLabel;
					//fix repairs offset bug additional timestep needed to correct for tick position
				for(int j=(int)(firstPoint-(fix+timeStep));j<(width-LABEL_WIDTH)-10;j+=majorStep){
					if(j>=XOFFSET) //also needed for fix bug
						backg.drawImage(labels[inum],j,aHeight+TITLESPACE+1,LABEL_WIDTH,LABEL_HEIGHT,parent);
//System.out.print("\t"+value2String(j));	
					inum++; if(inum>=labels.length) inum=0;
				}
//System.out.println(" ");
				oldPointStart=pointStart;	
			}
		}
		public String value2String(int v){
			return Float.toString(Math.round(((oldPointStart)+(v-XOFFSET))*timeStep*XROUND)/XROUND);
		}
	}
	private class PointFinder{
		private MouseAdapter ma;
		private MouseMotionAdapter mma;
		private Container target;
		int ox,oy;
		
		PointFinder(Container t){
			target = t;
			ox=-1;oy=-1;
			mma=new MouseMotionAdapter(){
				public void mouseDragged(MouseEvent e){
					moveTo(e);
				}
			};
			ma=new MouseAdapter(){
				public void mousePressed(MouseEvent e){
					moveTo(e);
				}
				public void mouseReleased(MouseEvent e){
                                        frontG=getGraphics();
					frontG.setColor(Color.red);
					frontG.setXORMode(Color.white);
					
					if(oy != -1){
						frontG.drawLine(ox,oy-5,ox,oy+5);
						frontG.drawLine(ox-5,oy,ox+5,oy);
						ox=-1;oy=-1;
						frontG.clearRect(width-100,0,100,TITLESPACE);
					}
					
					frontG.setColor(Color.black);
					frontG.setXORMode(Color.black);	
                                        frontG.dispose();
                                }
			};	
		}
		private void moveTo(MouseEvent e){
			String lble=null;
			
			frontG = getGraphics();
			frontG.setColor(Color.red);
			frontG.setXORMode(Color.white);
			
			if(oy != -1){
				frontG.drawLine(ox,oy-5,ox,oy+5);
				frontG.drawLine(ox-5,oy,ox+5,oy);
                                //((Graphics2D)frontG).setBackground(Color.white);
				frontG.clearRect(width-LOCATIONSPACE,0,LOCATIONSPACE,TITLESPACE);
				ox=-1;oy=-1;
			}
			
			int px=e.getX();
			int py=x.getValue(px);
			
			if(px>XOFFSET&&px<aWidth+XOFFSET
					&&py>=TITLESPACE&&py<TITLESPACE+aHeight){
				frontG.drawLine(px,py-5,px,py+5);
				frontG.drawLine(px-5,py,px+5,py);
				ox=px;oy=py;
				lble= "("+x.value2String(px)+","+y.value2String(py)+")";
			}
			frontG.setColor(Color.white);
			frontG.setPaintMode();
			if(lble!=null) frontG.drawString(lble,width-LOCATIONSPACE,(TITLESPACE/2));
                        frontG.dispose();
		}
		public void enable(){
			ox=-1;oy=-1;
			target.addMouseListener(ma);
			target.addMouseMotionListener(mma);
		}
		public void disable(){
			ox=-1;oy=-1;
			target.removeMouseListener(ma);
			target.removeMouseMotionListener(mma);
		}
	}
			
	private boolean running,drawable, bufferReady;
	
	private YAxis y;
	private XAxis x;
	
	private PointFinder pf;
	
	private final Graphics backg; private Graphics frontG;
	private final Image back;
	
	//private int oldX=-1,oldY=-1;
	//MouseMotionListener pointFinder;
	
	private double conversion;
	
	private String title; private boolean titleGood;
	
	RTGraph(String t, int w,int h, double tS, Container parent){
		setSize(w,h); //set size
               
		drawable = false; //init state	
		
		width=w; height=h; //init size
		aWidth = width-XOFFSET; aHeight = (height-YOFFSET)-TITLESPACE; //init axis size
		
		title =t;
		
		y= new YAxis(); //init axis
		x= new XAxis(tS,parent); 
		
		pf = new PointFinder(this);
		
		back = Const.getImage(width,height); //init the graphics
		backg = back.getGraphics();
                
                backg.setColor(Color.white);
                //((Graphics2D)backg).setBackground(Color.lightGray);
		running=true; stop();
		flush(); //kill everything
	}
	
	public/* synchronized */void start(){
		//if(running)
		//	throw new IllegalStateException("The Graph is already started");
		running = true;
		pf.disable();
	}		
			
	public/* synchronized */void drawGraph(){
		
		if(!drawable)
			throw new IllegalStateException(
				"The Graph is not drawable, data must be delivered");
				
		if(!titleGood){
			backg.drawString(title,XOFFSET+15, TITLESPACE/2); //draw title
			titleGood = true;
		}
		
		backg.clearRect(XOFFSET+1, TITLESPACE, aWidth, aHeight);
		
		y.draw();
		x.draw();
			
		bufferReady = true;
        paintImmediately(0,0,width,height);
        //        Graphics g=getGraphics();
        //        if(g!=null) g.drawImage(back,0,0,width,height,this);
	}
	public void recieveData( float Newdata[],int start, int newValues){
		for(int i = start; i<start+newValues;i++){ //check to see if we need to rescale
			if(Newdata[i] < y.aMin) y.setAMin(Newdata[i]);
			if(Newdata[i] > y.aMax) y.setAMax(Newdata[i]);
		}
		y.validate(); //now rescale if neccessary
		x.addPoints(Newdata, start, newValues);
		drawable = true;		
	}
	public/* synchronized*/ void stop(){
		//if(!running)
		//	throw new IllegalStateException("The Graph is already stoped");	
		pf.enable();
		running = false;
	}
	public boolean running(){
            return running;
        }
	public/* synchronized*/ void flush(){
		if(running)
			throw new IllegalStateException("The Graph cannot be flushed while running");
		drawable = false; //tell everyone that we can't draw
		
		titleGood=false;
		
		y.init(); //initialize axes
		x.init();
		
		bufferReady= false;
		backg.clearRect(0,0,width,height);//clear the graphics
		//backg.setColor(Color.white);
                repaint();
	}
	
	/*public void update(Graphics g){
		paint(g);
	}*/
	
	public void paintComponent(Graphics g){
		if(bufferReady)
			g.drawImage(back,0,0,width,height,this);
		else{ //clear
			g.clearRect(0,0,width,height);
		}
	}
}
