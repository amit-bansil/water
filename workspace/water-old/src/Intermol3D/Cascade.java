package Intermol3D;
import java.awt.Dimension;
import java.awt.Point;
import java.util.Vector;

public class Cascade{
	private int yTileIncrement = 20;
	private Dimension maxSize;
	private Dimension increment=new Dimension(20,30);
	private final Vector points = new Vector();
	private static final Point nullPoint=new Point(-Integer.MAX_VALUE,-Integer.MAX_VALUE);
	private Point current=new Point(0,0);
	private int highX=0;
	
	public Cascade(Dimension maxSize){
		this.maxSize=maxSize;
	}
	
	public Point getCurrent(){
		return current;
	}
	public int nextPoint(){
		int add=-1;
		if(!points.isEmpty()){
			current=(Point)points.lastElement();
			for(int i=0;i<points.size();i++){
//System.out.println("p"+i+"x"+((Point)points.elementAt(i)).x+"y"+((Point)points.elementAt(i)).x);
				if(((Point)points.elementAt(i)).equals(nullPoint)){
					if(i==0) current=new Point(0,0);  
					else current=(Point)((Point)points.elementAt(i-1)).clone();
					add=i;
					break;
				}
			}
			current.translate(increment.width,increment.height);
			if(current.x>maxSize.width)
				current.x=highX;
			if(current.y>maxSize.height){
				highX+=yTileIncrement;
				if(highX>maxSize.width)
					highX=0;
				current.y=0;
			}
		}
//System.out.println("add="+add);
		if(add==-1){
			points.addElement(current.clone());
			return (points.size()-1);
		}
		else{
			points.setElementAt(current.clone(),add);
			return add;
		}
		
	}
	public Point getNext(){
		nextPoint();
		return getCurrent();
	}
	public void remove(int i){
		points.setElementAt(nullPoint,i);
	}
	public void removeAll(){
		points.removeAllElements();
		highX=0;
	}
	public int getYTileIncrement()
	{
		return yTileIncrement;
	}
	public void setYTileIncrement(int value)
	{
		yTileIncrement = value;
	}
	
	public Dimension getMaxSize()
	{
		return maxSize;
	}
	public void setMaxSize(Dimension value)
	{
		maxSize = value;
	}
	
	public Dimension getIncrement()
	{
		return increment;
	}
	public void setIncrement(Dimension value)
	{
		increment = value;
	}
	
}