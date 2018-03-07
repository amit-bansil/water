package org.cps.umd.display;
import java.awt.Color;
import java.awt.Component;
import java.awt.Graphics;
import java.awt.Image;
import java.io.BufferedInputStream;
import java.io.IOException;
/**
 * Renders a molecular visualization. First the size and colors must be set.
 * Then calls to draw are made to create the geometry. Finally render is called
 * to put the geometry onto a graphics object
 * @author Amit Bansil
 * @version 0.1a
 */
//TODO,see below,cache colors/make color class sett
//also optimize line drawing by inling math calls
/*
 inline caches?
 use drawPolyLine
 set radii of invisible atoms to Int.MIN_VALUE
 do not draw invisible atoms
 do not draw bonds between invisible atoms
 create bondColors object, ir just let -bvalue specify next arg is color, use that color to override c and dc
 */
public class MoleculeRenderer{
	public static final void readByteData(String name,final byte[] data){
		try{
			BufferedInputStream bin=new BufferedInputStream(ClassLoader.getSystemResourceAsStream(name));
			int ret=bin.read(data);
			if(ret!=data.length) throw new IOException(name+" corrupted, read: "+ret);
			bin.close();
		}catch(IOException e){
			throw new Error(e);
		}
	}
	
	public static final float SCALE_FACTOR=.25f,UNSCALE_FACTOR=.5f;
	private final SpriteFactory sprites;/*implement intelligent cache flushing,use int-object hashtables*/
	public MoleculeRenderer(Component target){
		final byte[] data=new byte[256*256];
		readByteData("sphere.raw",data);
		sprites=new SpriteFactory(data,-127,target);
	}
	private int[] indexTable=new int[0],cleanIndexTable=new int[0];

	public final void updateIndexTable(final int[] za,final int[] setSizes,final int[] setCounts){
		int n=0,m=0;

		if(za.length>indexTable.length||za.length/UNSCALE_FACTOR>indexTable.length){
			final int[] t=new int[(int)Math.ceil(za.length*(1+SCALE_FACTOR))];
			indexTable=new int[t.length];
			final int old=cleanIndexTable.length;
			System.arraycopy(cleanIndexTable,0,t,0,Math.min(t.length,old));
			if(old<t.length){
				for(int i=old;i<t.length;i++) t[i]=i;
			}
			cleanIndexTable=t;
		}
		final int[] indexTable=this.indexTable,cleanIndexTable=this.cleanIndexTable;
		for(int i=0;i<setCounts.length;i++){
			System.arraycopy(cleanIndexTable,n,indexTable,m,setCounts[i]);
			m+=setCounts[i];
			n+=setSizes[i];
		}
		Sorter.sort(za,indexTable,m);
	}
	int minZ,maxZ,minX,maxX,minY,maxY;
	public final void setSize(final int minZ,final int maxZ,final int minX,
							 final int maxX,final int minY,final int maxY){
		this.minZ=minZ;
		this.maxZ=maxZ;
		this.maxX=maxX;
		this.maxY=maxY;
		this.minX=minX;
		this.minY=minY;
	}
	private final ObjectCache colorCache=new ObjectCache(1000){
		protected final Object create(int key){
//System.out.println("createColor="+(new Color(key).toString()));
			return new Color(key);
		}
	};
	private final ObjectCache spriteCache=new ObjectCache(200){
		protected final Object create(int key){
			return sprites.create(key|0xff000000,((key|0x00ffffff)>>23)+1);
		}
	};
	//diameter must be 1-256! otherwise floored
	private final void drawSprite(final Graphics gr,final int x,final int y,final int color,final int diameter){
		if(diameter>255) return;
		gr.drawImage(
				(Image)spriteCache.get((color&0x00ffffff)|((diameter-1)<<23)),
				x-(diameter/2),y-(diameter/2),null);
	}
	private int sphereThreshold=0,vecClipThreshold=4;//let user specify
	public final void render2D(final Graphics g,final int[] xa,final int[] ya,
							 final int[] scaledRadii,
							 final int[] colors,final int[] bonds,final int bScanSize,
							 final int[] setCounts,final int[] setStarts,final int[] setSizes){

		final int maxX=this.maxX;
		final int maxY=this.maxY;
		final int minX=this.minX;
		final int minY=this.minY;

		g.setClip(minX,minY,maxX-minX,maxY-minY);
		int curColor=g.getColor().getRGB();
		colorCache.frameElapsed();
		spriteCache.frameElapsed();
		Color tempColor=(Color)colorCache.get(curColor);
		int nextEnd=0;
//System.out.println("STARTING FRAME{");
		for(int mm=0;mm<setStarts.length;mm++){
			nextEnd+=setCounts[mm];
		for(int i=setStarts[mm];i<nextEnd;i++){
//if(new Color(colors[i]).getRed()>200) System.out.print("[atom "+i+" red>200]");
			final int r=scaledRadii[i];
			int bk=i*bScanSize;
			int b=bonds[bk];
			if(r<0&&b==-1) continue;
			final int x=xa[i];
			final int y=ya[i];
			if(x>=maxX||x<=minX) continue;
			if(y>=maxY||y<=minY) continue;

			final int c=colors[i];
			if(r<0){//ignore negative
				//System.out.println("atom "+k+" rad["+r+"]<0");
			}else if(r<2){
				//System.out.println("atom "+k+" rad["+r+"]<2");
				if(c!=curColor){
					curColor=c;
					tempColor=(Color)colorCache.get(c);/*create a color subclass that can be set or a hashtable of colors*/
					g.setColor(tempColor);
				}
				g.drawLine(x,y,x,y);
			}else if(r<sphereThreshold){
				if(c!=curColor){
					curColor=c;
					tempColor=(Color)colorCache.get(c);/*create a color subclass that can be set or a hashtable of colors*/
					g.setColor(tempColor);
				}
				g.fillOval(x,y,r,r);
			}else{
				drawSprite(g,x,y,c,r);
			}
			if(b!=-1){
				int m=0;
				for(;m<setStarts.length;m++) if(i<setStarts[m]) break;//todo optimize
				final int offset=setStarts[m-1];
				for(int n=0;n<bScanSize;n++){
					bk++;
					b+=offset;
					final int dr=scaledRadii[b];
					if(b>i){
						b=bonds[bk];
						if(b==-1) break;
						else continue;
					}
					if(dr<0){
						b=bonds[bk];
						if(b==-1) break;
						else continue;
					}

					final int dc=colors[b];
					if(c!=curColor){
						curColor=c;
						tempColor=(Color)colorCache.get(c);//create a color subclass that can be set or a hashtable of colors
						g.setColor(tempColor);
					}

					final int dx=xa[b];
					final int dy=ya[b];

					if(c==dc){
						if(r<=vecClipThreshold){
							g.drawLine(x,y,dx,dy);
						}else{
							final int cx=dx-x;
							final int cy=dy-y;
							final float kk=(r/2f)/(float)Math.sqrt(cx*cx+cy*cy);
							if(kk<1) g.drawLine(x+(int)(cx*kk),y+(int)(cy*kk),dx,dy);
						}
					}else{
						if(r<=vecClipThreshold){
							final int mx=x+((dx-x)/2);
							final int my=y+((dy-y)/2);
							g.drawLine(x,y,mx,my);

							curColor=dc;
							tempColor=(Color)colorCache.get(dc);//create a color subclass that can be set or a hashtable of colors
							g.setColor(tempColor);

							g.drawLine(dx,dy,mx,my);
						}else{
							final int cx=dx-x;
							final int cy=dy-y;
							final int mx=x+((cx)/2);
							final int my=y+((cy)/2);
							final float kk=(r/2f)/(float)Math.sqrt(cx*cx+cy*cy);
							if(kk<1) g.drawLine(x+(int)(cx*kk),y+(int)(cy*kk),mx,my);

							curColor=dc;
							tempColor=(Color)colorCache.get(dc);//create a color subclass that can be set or a hashtable of colors
							g.setColor(tempColor);

							g.drawLine(mx,my,dx,dy);
						}
					}
					b=bonds[bk];
					if(b==-1) break;
				}
			}
		}}
		//System.out.println("}frameFinished");
	}
	public final void render3D(final Graphics g,final int[] xa,final int[] ya,final int[] za,
							 final int[] scaledRadii,
							 final int[] colors,final int[] bonds,final int bScanSize,
							 final int tableSize,final int[] setStarts,final int[] setSizes){//greater z infront
		final int[] indexTable=this.indexTable;

		final int minZ=this.minZ;
		final int maxZ=this.maxZ;
		final int maxX=this.maxX;
		final int maxY=this.maxY;
		final int minX=this.minX;
		final int minY=this.minY;

		final int sphereThreshold=this.sphereThreshold,vecClipThreshold=this.vecClipThreshold;

		int i=0;

		for(;i<tableSize;i++) if(za[indexTable[i]]<=maxZ)  break;

		g.setClip(minX,minY,maxX-minX,maxY-minY);
		int curColor=g.getColor().getRGB();
		colorCache.frameElapsed();
		spriteCache.frameElapsed();
		Color tempColor=(Color)colorCache.get(curColor);
//System.out.println("i0="+i);
//System.out.println("STARTING FRAME!!");
		for(;i<tableSize;i++){
			final int k=indexTable[i];
//if(new Color(colors[k]).getRed()>200) System.out.println("atom "+k+" red>200");
			final int r=scaledRadii[k];
			int bk=k*bScanSize;
			int b=bonds[bk];
			if(r<0&&b==-1) continue;

			final int z=za[k];
			//if(z>= maxZ) break;
			if(z<= minZ) break;
			final int x=xa[k];
			final int y=ya[k];
			if(x>=maxX||x<=minX) continue;
			if(y>=maxY||y<=minY) continue;

			final int c=colors[k];
			if(r<0){//ignore negative
				//System.out.println("atom "+k+" rad["+r+"]<0");
			}else if(r<2){
				//System.out.println("atom "+k+" rad["+r+"]<2");
				if(c!=curColor){
					curColor=c;
					tempColor=(Color)colorCache.get(c);/*create a color subclass that can be set or a hashtable of colors*/
					g.setColor(tempColor);
				}
				g.drawLine(x,y,x,y);
			}else if(r<sphereThreshold){
				if(c!=curColor){
					curColor=c;
					tempColor=(Color)colorCache.get(c);/*create a color subclass that can be set or a hashtable of colors*/
					g.setColor(tempColor);
				}
				g.fillOval(x,y,r,r);
			}else{
				drawSprite(g,x,y,c,r);
			}

			if(b!=-1){
				int m=0;
				for(;m<setStarts.length;m++) if(k<setStarts[m]) break;
				final int offset=setStarts[m-1];
				for(int n=0;n<bScanSize;n++){
					bk++;
					b+=offset;
					final int dz=za[b];
					if(dz>z){
						b=bonds[bk];
						if(b==-1) break;
						else continue;
					}
					final int dr=scaledRadii[b];
					if(dr<0){
						b=bonds[bk];
						if(b==-1) break;
						else continue;
					}

					final int dc=colors[b];
					if(c!=curColor){
						curColor=c;
						tempColor=(Color)colorCache.get(c);//create a color subclass that can be set or a hashtable of colors
						g.setColor(tempColor);
					}

					final int dx=xa[b];
					final int dy=ya[b];

					if(c==dc){
						if(r<=vecClipThreshold){
							g.drawLine(x,y,dx,dy);
						}else{
							final int cx=dx-x;
							final int cy=dy-y;
							final float kk=(r/2f)/(float)Math.sqrt(cx*cx+cy*cy+(dz-z)*(dz-z));
							if(kk<1) g.drawLine(x+(int)(cx*kk),y+(int)(cy*kk),dx,dy);
						}
					}else{
						if(r<=vecClipThreshold){
							final int mx=x+((dx-x)/2);
							final int my=y+((dy-y)/2);
							g.drawLine(x,y,mx,my);

							curColor=dc;
							tempColor=(Color)colorCache.get(dc);//create a color subclass that can be set or a hashtable of colors
							g.setColor(tempColor);

							g.drawLine(dx,dy,mx,my);
						}else{
							final int cx=dx-x;
							final int cy=dy-y;
							final int mx=x+((cx)/2);
							final int my=y+((cy)/2);
							final float kk=(r/2f)/(float)Math.sqrt(cx*cx+cy*cy+(dz-z)*(dz-z));
							if(kk<1) g.drawLine(x+(int)(cx*kk),y+(int)(cy*kk),mx,my);

							curColor=dc;
							tempColor=(Color)colorCache.get(dc);//create a color subclass that can be set or a hashtable of colors
							g.setColor(tempColor);

							g.drawLine(mx,my,dx,dy);
						}
					}
					b=bonds[bk];
					if(b==-1) break;
				}
			}
		}
	}
}
/*
	A sorting algorithim adapted from java.util.Arrays,sorts and array of indexes,
	where each index has a value from values.
*/
class Sorter{

	public final static void sort(int[] values, int[] indexes,int length){
		rangeCheck(values.length,0,length);
		sort1(values,indexes,0,length);
	}
	private final static void rangeCheck(int arrayLen, int fromIndex, int toIndex) {
		if (fromIndex > toIndex)
			throw new IllegalArgumentException("fromIndex(" + fromIndex +
					   ") > toIndex(" + toIndex+")");
		if (fromIndex < 0)
			throw new ArrayIndexOutOfBoundsException(fromIndex);
		if (toIndex > arrayLen)
			throw new ArrayIndexOutOfBoundsException(toIndex);
	}
	private final static void sort1(final int x[],final int indexes[],final int off,final int len) {
	// Insertion sort on smallest arrays
	if (len < 7) {
		for (int i=off; i<len+off; i++)
		for (int j=i; j>off && x[indexes[j-1]]<x[indexes[j]]; j--)
			swap(indexes, j, j-1);
		return;
	}

	// Choose a partition element, v
	int m = off + (len >> 1);       // Small arrays, middle element
	if (len > 7) {
		int l = off;
		int n = off + len - 1;
		if (len > 40) {        // Big arrays, pseudomedian of 9
			int s = len/8;
			l = med3(x, l,     l+s, l+2*s,indexes);
			m = med3(x, m-s,   m,   m+s,indexes);
			n = med3(x, n-2*s, n-s, n,indexes);
		}
		m = med3(x, l,     m,   n,indexes); // Mid-size, med of 3
	}
	int v = x[indexes[m]];

	// Establish Invariant: v* (<v)* (>v)* v*
	int a = off, b = a, c = off + len - 1, d = c;
	while(true) {
		while (b <= c && x[indexes[b]] >= v) {
		if (x[indexes[b]] == v)
			swap(indexes, a++, b);
		b++;
		}
		while (c >= b && x[indexes[c]] <= v) {
		if (x[indexes[c]] == v)
			swap(indexes, c, d--);
		c--;
		}
		if (b > c)
		break;
		swap(indexes, b++, c--);
	}

	// Swap partition elements back to middle
	int s, n = off + len;
	s = Math.min(a-off, b-a  );  vecswap(indexes, off, b-s, s);
	s = Math.min(d-c,   n-d-1);  vecswap(indexes, b,   n-s, s);

	// Recursively sort non-partition-elements
	if ((s = b-a) > 1)
		sort1(x,indexes, off, s);
	if ((s = d-c) > 1)
		sort1(x,indexes, n-s, s);
	}

	/**
	 * Swaps x[a] with x[b].
	 */
	private final static void swap(int[] indexes,int a, int b) {
	final int t=indexes[a];
	indexes[a]=indexes[b];
	indexes[b]=t;
	}

	/**
	 * Swaps x[a .. (a+n-1)] with x[b .. (b+n-1)].
	 */
	private final  static void vecswap(int[] indexes,int a, int b, int n) {
	for (int i=0; i<n; i++, a++, b++)
		swap(indexes,a, b);
	}

	/**
	 * Returns the index of the median of the three indexed integers.
	 */
	private final static int med3(int x[],int a, int b, int c,int[] indexes) {
	return (x[indexes[a]] > x[indexes[b]] ?
		(x[indexes[b]] > x[indexes[c]] ? b : x[indexes[a]] > x[indexes[c]] ? c : a) :
		(x[indexes[b]] < x[indexes[c]] ? b : x[indexes[a]] < x[indexes[c]] ? c : a));
	}
}