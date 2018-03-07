/*
 * CREATED ON:    Apr 23, 2006 11:25:28 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.moleculedisplay;

import com.sun.opengl.util.BufferUtil;

import cps.water.util.Transform3D;

import javax.media.opengl.GL;
import javax.media.opengl.glu.GLU;
import javax.media.opengl.glu.GLUquadric;
import javax.vecmath.Color3f;
import javax.vecmath.Tuple3f;

import java.nio.DoubleBuffer;
import java.nio.FloatBuffer;

/**
 * <p>TODO document GLAccess
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
//TODO integrate this with GLEventListener, what we need
//is something like a GLScene class with various methods
//that take GLGraphics objects which have most of the code here
class GLAccess {
	private GL gl;
	private static final GLU glu=new GLU();
	final void setup(GL gl) {
		this.gl=gl;
	}
	final void release() {
		gl=null;
	}

	GLAccess() {
		initCamera();
	}
	
	// ------------------------------------------------------------------------
	
	final void setColor(Color3f color) {
		gl.glColor3f(color.x,color.y,color.z);
	}

	// ------------------------------------------------------------------------
	
	void rotate(float degrees,float x, float y, float z) {
		gl.glRotatef(degrees,x,y,z);
	}
	void scale(float x, float y, float z) {
		gl.glScalef(x,y,z);
	}
	final void translate(Tuple3f t) {
		translate(t.x,t.y,t.z);
	}
	final void translate(double x,double y,double z) {
		gl.glTranslated(x,y,z);
	}
	final void translate(float[] f,int offset) {
		translate(f[offset],f[offset+1],f[offset+2]);
	}
	private final DoubleBuffer matrixBuffer=BufferUtil.newDoubleBuffer(16);
	private final double[] matrixArray=new double[16];
	private final Transform3D tempTransform=new Transform3D();
	final void transform(Transform3D transform) {
		matrixBuffer.rewind();
		tempTransform.transpose(transform);
		tempTransform.get(matrixArray);
		matrixBuffer.put(matrixArray);
		gl.glMultMatrixd(matrixBuffer);
	}
	final void pushMatrix() {
		gl.glPushMatrix();
	}
	final void popMatrix() {
		gl.glPopMatrix();
	}
	// ------------------------------------------------------------------------
	
	private static enum DisplayListState{NEW,LIVE,DEAD}
	//note that for this to work it must be called using the same glaccess as created it
	final class DisplayList{
		private final int listNum;
		private DisplayListState state=DisplayListState.NEW;
		private DisplayList() {
			listNum=gl.glGenLists(1);
			gl.glNewList(listNum, GL.GL_COMPILE);
		}
		final void end() {
			if(state!=DisplayListState.NEW)throw new IllegalStateException();
			gl.glEndList();
			state=DisplayListState.LIVE;
		}
		final void call() {
			if(state!=DisplayListState.LIVE)throw new IllegalStateException();
			gl.glCallList(listNum);
		}
		final void kill() {
			if(state!=DisplayListState.LIVE)throw new IllegalStateException();
			gl.glDeleteLists(listNum, 1);
		}
	}
	final DisplayList beginList() {
		return new DisplayList();
	}
	// ------------------------------------------------------------------------
	
	final Quadrics createQuadrics() {
		return new Quadrics();
	}
	final class Quadrics{
		private final GLUquadric quadric;
		private boolean alive=true;
		Quadrics(){
			quadric = glu.gluNewQuadric();
			glu.gluQuadricOrientation(quadric, GLU.GLU_OUTSIDE);
		}
		final void sphere(float radius,int slices,int stacks) {
			if(!alive)throw new IllegalStateException();
			glu.gluSphere(quadric, radius, slices, stacks);
		}
		final void cylinder(float radius,float height,int slices) {
			if(!alive)throw new IllegalStateException();
			glu.gluCylinder(quadric,radius,radius,
				height,slices, slices);
		}
		final void kill() {
			if(!alive)throw new IllegalStateException();
			alive=false;
			glu.gluDeleteQuadric(quadric);
		}
	}

	// ------------------------------------------------------------------------
	private float curWidth=1;
	final LineDrawer beginLines(float weight) {
		return new LineDrawer(weight);
	}
	final class LineDrawer{
		private boolean alive=true;
		LineDrawer(float weight) {
			if(curWidth!=weight)gl.glLineWidth(weight);
			gl.glBegin(GL.GL_LINES);
		}
		final void drawLine(float[] coords, int offset) {
			drawLine(coords[offset], coords[offset + 1], coords[offset + 2],
				coords[offset + 3], coords[offset + 4], coords[offset + 5]);
		}
		final void drawLine(float sx,float sy,float sz,float dx,float dy,float dz) {
			if(!alive)throw new IllegalStateException();
			gl.glVertex3f(sx,sy,sz);
			gl.glVertex3f(dx,dy,dz);
		}
		final void end() {
			if(!alive)throw new IllegalStateException();
			alive=false;
			gl.glEnd();
		}
	}
	//positions are packed in the same format at Renderer.hBondPositions
	final void drawLines(float[] positions,final int offset,final int count,float weight,float[] boxSize) {
		setLightingEnabled(false);
		LineDrawer l=beginLines(weight);
		for(int i=offset;i<count*6;i+=6) {
			//break if longer than boxSize/2
			boolean skip=false;
			for (int j = 0; j < 3; j++)
				if (Math.abs(positions[i+j]
						- positions[i+j+3]) * 2 > boxSize[j]) skip=true;
			if(!skip)l.drawLine(positions,i);
		}
		l.end();
	}
	// ------------------------------------------------------------------------
	//call during before preDraw
	final void init() {

	   //System.err.println("INIT GL IS: " + gl.getClass().getName());

	    //gl.setSwapInterval(1);
		
		gl.glLightfv(GL.GL_LIGHT0, GL.GL_POSITION, new float[] {20.0f, 10.0f, 20.0f, 0.0f},0);
		
		gl.glColorMaterial(GL.GL_FRONT, GL.GL_AMBIENT);
		gl.glColorMaterial(GL.GL_FRONT, GL.GL_DIFFUSE);
		
		gl.glEnable(GL.GL_COLOR_MATERIAL);
		
		gl.glEnable(GL.GL_LIGHTING);
		gl.glEnable(GL.GL_LIGHT0);
		
		gl.glEnable(GL.GL_CULL_FACE);
		gl.glEnable(GL.GL_DEPTH_TEST);
		//OPTIMIZE GL_NORMALIZE would be enough for all but cylinders
		//GL_RESCALE_NORMAL may cause problems when microsoft rendering
		gl.glEnable(GL.GL_NORMALIZE);
		gl.glEnable(GL.GL_LINE_SMOOTH);
		

		setBrighness(1f);
		
		lightingEnabled=true;
		
	}
	final void setBrighness(float brightness) {
		gl.glLightModelfv(GL.GL_LIGHT_MODEL_AMBIENT, new float[] {
			0.2f*brightness, 0.2f*brightness,0.2f*brightness, 1.0f},0);
		
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_SPECULAR, new float[] {
			0.1f*brightness, 0.1f*brightness, 0.1f*brightness, 1.0f},0);
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_SHININESS, new float[] {100f*brightness},0);//needs just 1 parameter

		gl.glMaterialfv(GL.GL_FRONT, GL.GL_AMBIENT, new float[] {
			0.4f*brightness, 0.4f*brightness, 0.4f*brightness, 1.0f},0);
		gl.glMaterialfv(GL.GL_FRONT, GL.GL_DIFFUSE, new float[] {
			0.0f*brightness, 0.0f*brightness, 0.0f*brightness, 1.0f},0);
	}
	boolean lightingEnabled=false;
	final void setLightingEnabled(boolean lightingEnabled) {
		if(lightingEnabled==this.lightingEnabled)return;
		this.lightingEnabled=lightingEnabled;
		if(lightingEnabled) {
			gl.glEnable(GL.GL_LIGHTING);
		}else {
			gl.glDisable(GL.GL_LIGHTING);
		}
	}
	//note that the result of this method must be used immediately
	private final FloatBuffer tempFloat4=BufferUtil.newFloatBuffer(4);
	private final FloatBuffer float4(float x,float y,float z,float w) {
		tempFloat4.rewind();
		tempFloat4.put(x);
		tempFloat4.put(y);
		tempFloat4.put(z);
		tempFloat4.put(w);
		return tempFloat4;
	}
	
	// ------------------------------------------------------------------------
	//rx,ry are in degrees

	//places camera on surface of sphere centered at (cx,cy,cz)
	//at latitude specified by ry, longitude specified by cx
	//rotated such that up is towards the north pole
	//orientation such that cx=cy=cz=rx=ry=0 puts camera (1,0,0) pointing to (0,0,0) with (1,0,0) being up
	//call after preDraw to setup view
	final void setupCamera(float rx,float ry,float cx,float cy,float cz,float zoom) {
		//gl.glMatrixMode(GL.GL_MODELVIEW);
		gl.glLoadIdentity();
		gl.glTranslatef(0.0f, 0.0f, -35.0f*(((100-zoom)+75)/100)+20);
		
		/*temp.cross(dir, up);
		temp2.set(dir);
		rotateVector(temp,cross,Math.toRadians(rx));
		rotateVector(temp2,up,Math.toRadians(ry));
		temp2.normalize();*/

		rotate(ry,1,0,0);
		rotate(rx,0,1,0);
		//translate(cx+(zoom*Math.sin(rx)*Math.sin(ry)),
	    //    cy+(zoom*Math.cos(rx)*Math.sin(ry)),
	    //    cz+(zoom*Math.cos(ry)));
	}
	//call before doing any drawing every time
	final void preDraw() {
		gl.glClear(
			GL.GL_COLOR_BUFFER_BIT | GL.GL_DEPTH_BUFFER_BIT);
	}
	//call first on init or size change
	final void reshape(int x,int y,int width,int height,float nearClipZ,float farClipZ) {
		gl.glMatrixMode(GL.GL_PROJECTION);
		float h = (float) height / (float) width;
		gl.glLoadIdentity();
		gl.glFrustum(-1.0f, 1.0f, -h, h, nearClipZ, farClipZ);
		gl.glMatrixMode(GL.GL_MODELVIEW);
		gl.glLoadIdentity();
	}
	/*
	//rotates a vector
	private static final void rotateVector( Vector3d v,Vector3d axis, double angleRads )
	{
	    final double cosAngle = Math.cos( angleRads );
	    final double sinAngle = Math.sin( angleRads );

	    normAxis.set(axis);
	    normAxis.normalize();

	    cross.cross( v, normAxis );
	    cross2.cross( cross, normAxis );
	    cross2.scale( (1.0 - cosAngle) );
	    cross.scale( sinAngle );
	    cross2.sub(cross);
	    v.add(cross2);
	}
	
	private final Vector3d dir=new Vector3d(0,1,-.1f),
		up=new Vector3d(0,0,1),temp=new Vector3d(),temp2=new Vector3d();*/
	private void initCamera() {
	/*	dir.normalize();
		up.normalize();
		dir.cross(dir, up);
		dir.cross(up,dir);*/
	}
	/*private static final Vector3d normAxis=new Vector3d(),cross=new Vector3d(),cross2=new Vector3d();*/
}
