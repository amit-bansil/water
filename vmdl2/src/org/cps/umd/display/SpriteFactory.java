package org.cps.umd.display;
import java.awt.*;
import java.awt.image.*;
import java.util.*;
/**
 * <p>Title: Universal Molecular Dynamics</p>
 * <p>Description: A Universal Interface for Molecular Dynamics Simulations</p>
 * <p>Copyright: Copyright (c) 2002</p>
 * <p>Company: Boston University</p>
 * @author Amit Bansil
 * @version 0.1a
 */
/** @todo implement fast MemoryImageSource to improve performance,also cache LUTs?,implement more efficient sprite cache*/
public final class SpriteFactory {
	private final Component targetComponent;
	public SpriteFactory(byte[] data,Component targetComponent) {
		this(data,(int)Math.sqrt(data.length),1,targetComponent);
	}
	public SpriteFactory(byte[] data,int transparentIndex,Component targetComponent) {
		this(data,(int)Math.sqrt(data.length),transparentIndex,targetComponent);
	}
	public SpriteFactory(byte[] data,int width,int transparentIndex,Component targetComponent) {
		this(data,width,width,0,transparentIndex,targetComponent);
	}
	public SpriteFactory(byte[] data,int width,int scanSize,int offset,int transparentIndex,Component targetComponent) {
		this.data=data;
		this.scanSize=scanSize;
		this.offset=offset;
		this.width=width;
		this.targetComponent=targetComponent;

		this.transparentIndex=transparentIndex;

		emptyImage=targetComponent.createImage(1,1);

	}
	//lut
	private static final int LUT_SIZE=256;
	private int lastColor=0x00000000;//transparent
	private final int[] LUT=new int[LUT_SIZE];//also presumably initialized to all transparent
	private final int transparentIndex;//the transparent pixel index

	private final void updateLUT(int color){//optimize
		if(color==lastColor) return;
//System.out.println("lutColor="+(new Color(color).toString()));
		float cr,cb,cg;
		final float dr,db,dg;

		cr=cb=cg=0;
		final float r=((color>> 16) & 0x000000ff);
		final float g=((color>>  8) & 0x000000ff);
		final float b=((color>>  0) & 0x000000ff);

		dr=r/255f;
		dg=g/255f;
		db=b/255f;
		int n=128;
		for(int i=0;i<LUT_SIZE;i++){
			//System.out.println("["+i+"]="+(new Color((((int)cr)<<16)|(((int)cb)<<8)|((int)cg)|0xff000000).toString()));
			LUT[n]=(((int)cr)<<16)|(((int)cg)<<8)|((int)cb)|0xff000000;
			if(n==LUT_SIZE-1)n=0;
			else n++;
			cr+=dr;
			cg+=dg;
			cb+=db;
		}
		LUT[128]=0x00000000;
		lastColor=color;

		return;
	}
	//private final int convert(int i){return i<=128 ? i+127 : i-128;}
	//scaling
	private final byte[] data;
	private final int scanSize,offset,width;
	private final int[] buildSprite(final int diameter){
		final int[] temp=new int[diameter*diameter];
		int i=0;
		final double length=scanSize;
		final double increment=scanSize/(double)diameter;
		final double start=increment/2d;
		for(double y=start;y<length;y+=increment){
			for(double x=start;x<length;x+=increment){
				temp[i]=LUT[data[(int)Math.round(y)*scanSize+(int)Math.round(x)]+128];

				i++;
			}
		}
		return temp;
	}
	private final Image emptyImage;

	public final Image create(final int color,final int diameter){
		if(diameter>=width) return emptyImage;//clip too big, maby floor instead?

		updateLUT(color);

		final MemoryImageSource src=new MemoryImageSource(diameter,diameter,buildSprite(diameter),0,diameter);

		final Image tmpImg=targetComponent.createImage(src);

		final Image cImg=targetComponent.getGraphicsConfiguration()
				  .createCompatibleImage(diameter,diameter,Transparency.BITMASK);

		final Graphics g=cImg.getGraphics();
		g.drawImage(tmpImg,0,0,null);
		//g.setColor(new Color(color));
		//g.drawOval(0,0,diameter,diameter);
		g.dispose();

		tmpImg.flush();

		return cImg;
	}
}