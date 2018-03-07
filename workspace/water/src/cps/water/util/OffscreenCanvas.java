package cps.water.util;

import com.sun.opengl.impl.GLContextImpl;
import com.sun.opengl.impl.GLDrawableFactoryImpl;
import com.sun.opengl.impl.GLDrawableHelper;
import com.sun.opengl.impl.GLDrawableImpl;

import cps.jarch.util.notes.Nullable;

import javax.media.opengl.ComponentEvents;
import javax.media.opengl.DefaultGLCapabilitiesChooser;
import javax.media.opengl.GL;
import javax.media.opengl.GLAutoDrawable;
import javax.media.opengl.GLCapabilities;
import javax.media.opengl.GLCapabilitiesChooser;
import javax.media.opengl.GLContext;
import javax.media.opengl.GLEventListener;
import javax.media.opengl.GLException;

import java.awt.event.ComponentListener;
import java.awt.event.FocusListener;
import java.awt.event.HierarchyBoundsListener;
import java.awt.event.HierarchyListener;
import java.awt.event.InputMethodListener;
import java.awt.event.KeyListener;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.awt.event.MouseWheelListener;
import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.awt.image.DataBufferInt;
import java.beans.PropertyChangeListener;
import java.nio.ByteBuffer;
import java.nio.IntBuffer;

// a ripoff of GLJPanel without the JPanel, pbuffer & hardware ogl rendering have been stripped
//note that this class makes no effort to deal with threading
//probably ok since we're in software
public final class OffscreenCanvas extends EmptyComponentEvents implements GLAutoDrawable {
	private static final boolean DEBUG = false;

	//private static final boolean VERBOSE = false;

	private GLDrawableHelper drawableHelper = new GLDrawableHelper();

	private volatile boolean isInitialized;

	private volatile boolean shouldInitialize = false;

	// Data used for either pbuffers or pixmap-based offscreen surfaces
	private GLCapabilities offscreenCaps;

	private GLCapabilitiesChooser chooser;

	private GLContext shareWith;

	// This image is exactly the correct size to render into the panel
	private BufferedImage offscreenImage;
	public @Nullable BufferedImage getOffscreenImage() {
		return offscreenImage;
	}
	//lots of potential concurrency problems here...
	//also setting offscreenImage=null might result in leaking
	//need something like a useOffscreenImage() and releaseOffscreenImage pair
	//where if the offscreenImage is in use it won't be overwritten but if its not
	//leave it or flush if needed
	public final void useNewOffscreenBuffer() {
		offscreenImage=null;
		reshape(x, y, width, height);
	}
	// One of these is used to store the read back pixels before storing
	// in the BufferedImage
	private ByteBuffer readBackBytes;

	private IntBuffer readBackInts;

	private int readBackWidthInPixels;

	private int readBackHeightInPixels;

	// Width of the actual GLJPanel
	private int panelWidth = 0;

	private int panelHeight = 0;

	private Updater updater;

	//private int awtFormat;

	private int glFormat;

	private int glType;

	// Lazy reshape notification
	private boolean handleReshape = false;

	private boolean sendReshape = true;

	// Implementation using software rendering
	private GLDrawableImpl offscreenDrawable;

	private GLContextImpl offscreenContext;

	// For handling reshape events lazily
	//private int reshapeX;

	//private int reshapeY;

	private int reshapeWidth;

	private int reshapeHeight;

	// For saving/restoring of OpenGL state during ReadPixels
	private int[] swapbytes = new int[1];

	private int[] rowlength = new int[1];

	private int[] skiprows = new int[1];

	private int[] skippixels = new int[1];

	private int[] alignment = new int[1];

	// These are always set to (0, 0) except when the Java2D / OpenGL
	// pipeline is active (which is never for this hack)
	private int viewportX;

	private int viewportY;

	/**
	 * Creates a new GLJPanel component with a default set of OpenGL
	 * capabilities and using the default OpenGL capabilities selection
	 * mechanism.
	 */
	public OffscreenCanvas() {
		this(null);
	}

	/**
	 * Creates a new GLJPanel component with the requested set of OpenGL
	 * capabilities, using the default OpenGL capabilities selection mechanism.
	 */
	public OffscreenCanvas(GLCapabilities capabilities) {
		this(capabilities, null, null);
	}

	/**
	 * Creates a new GLJPanel component. The passed GLCapabilities specifies the
	 * OpenGL capabilities for the component; if null, a default set of
	 * capabilities is used. The GLCapabilitiesChooser specifies the algorithm
	 * for selecting one of the available GLCapabilities for the component; a
	 * DefaultGLCapabilitesChooser is used if null is passed for this argument.
	 * The passed GLContext specifies an OpenGL context with which to share
	 * textures, display lists and other OpenGL state, and may be null if
	 * sharing is not desired. See the note in the overview documentation on <a
	 * href="../../../overview-summary.html#SHARING">context sharing</a>.
	 */
	public OffscreenCanvas(GLCapabilities capabilities, GLCapabilitiesChooser chooser,
			GLContext shareWith) {
		super();

		// Works around problems on many vendors' cards; we don't need a
		// back buffer for the offscreen surface anyway
		if (capabilities != null) {
			offscreenCaps = (GLCapabilities) capabilities.clone();
		} else {
			offscreenCaps = new GLCapabilities();
		}
		offscreenCaps.setDoubleBuffered(false);
		this.chooser = ((chooser != null) ? chooser : new DefaultGLCapabilitiesChooser());
		this.shareWith = shareWith;
		shouldInitialize = true;
	}

	public void display() {
		paintComponent();
	}

	public void repaint() {
		paintComponent();
	}

	/**
	 * Overridden to cause OpenGL rendering to be performed during repaint
	 * cycles. Subclasses which override this method must call
	 * super.paintComponent() in their paintComponent() method in order to
	 * function properly.
	 * <P>
	 * 
	 * <B>Overrides:</B>
	 * <DL>
	 * <DD><CODE>paintComponent</CODE> in class <CODE>javax.swing.JComponent</CODE></DD>
	 * </DL>
	 */
	protected void paintComponent() {
		if (shouldInitialize) {
			initialize();
		}

		if (!isInitialized) { return; }

		// NOTE: must do this when the context is not current as it may
		// involve destroying the pbuffer (current context) and
		// re-creating it -- tricky to do properly while the context is
		// current
		if (handleReshape) {
			handleReshape();
		}

		drawableHelper.invokeGL(offscreenDrawable, offscreenContext, displayAction,
			initAction);
	}

	/**
	 * Overridden to track when this component is removed from a container.
	 * Subclasses which override this method must call super.removeNotify() in
	 * their removeNotify() method in order to function properly.
	 * <P>
	 * 
	 * <B>Overrides:</B>
	 * <DL>
	 * <DD><CODE>removeNotify</CODE> in class <CODE>java.awt.Component</CODE></DD>
	 * </DL>
	 */
	public void removeNotify() {
		if (DEBUG) {
			System.err.println("GLJPanel.removeNotify()");
		}
		if (offscreenContext != null) {
			offscreenContext.destroy();
			offscreenContext = null;
		}
		if (offscreenDrawable != null) {
			offscreenDrawable.destroy();
			offscreenDrawable = null;
		}
		isInitialized = false;
	}

	/**
	 * Overridden to cause {@link GLDrawableHelper#reshape} to be called on all
	 * registered {@link GLEventListener}s. Subclasses which override this
	 * method must call super.reshape() in their reshape() method in order to
	 * function properly.
	 * <P>
	 * 
	 * <B>Overrides:</B>
	 * <DL>
	 * <DD><CODE>reshape</CODE> in class <CODE>java.awt.Component</CODE></DD>
	 * </DL>
	 */
	public void reshape(int x, int y, int width, int height) {
		this.x=/*reshapeX =*/ x;
		this.y=/*reshapeY =*/ y;
		this.width = reshapeWidth = width;
		this.height = reshapeHeight = height;
		handleReshape = true;
	}
	//added for implementation's sake
	public void setRealized(boolean realized) {
		// do nothing
	}

	//added for implementation's sake
	public void setSize(int width, int height) {
		reshape(x,y,width,height);
	}

	//added for implementation's sake
	int width, height,x,y;

	//added for implementation's sake
	public int getWidth() {
		return width;
	}

	//added for implementation's sake
	public int getHeight() {
		return height;
	}

	private boolean opaque = false;

	public boolean isOpaque() {
		return opaque;
	}

	public void setOpaque(boolean opaque) {
	    if (opaque != isOpaque()) {
	      if (offscreenImage != null) {
	        offscreenImage.flush();
	        offscreenImage = null;
	      
	      this.opaque=opaque;
	    }
	  }
	}

	public void addGLEventListener(GLEventListener listener) {
		drawableHelper.addGLEventListener(listener);
	}

	public void removeGLEventListener(GLEventListener listener) {
		drawableHelper.removeGLEventListener(listener);
	}

	public GLContext createContext(GLContext shareWith) {
		return offscreenDrawable.createContext(shareWith);
	}

	public GLContext getContext() {
		return offscreenContext;
	}

	public GL getGL() {
		GLContext context = getContext();
		return (context == null) ? null : context.getGL();
	}

	public void setGL(GL gl) {
		GLContext context = getContext();
		if (context != null) {
			context.setGL(gl);
		}
	}

	public void setAutoSwapBufferMode(boolean onOrOff) {
		drawableHelper.setAutoSwapBufferMode(onOrOff);
	}

	public boolean getAutoSwapBufferMode() {
		return drawableHelper.getAutoSwapBufferMode();
	}

	public void swapBuffers() {
		drawableHelper.invokeGL(offscreenDrawable, offscreenContext, swapBuffersAction,
			initAction);
	}

	// ----------------------------------------------------------------------
	// Internals only below this point
	//

	private void initialize() {
		if (panelWidth == 0 || panelHeight == 0) {
			// See whether we have a non-zero size yet and can go ahead with
			// initialization
			if (reshapeWidth == 0 || reshapeHeight == 0) { return; }

			// Pull down reshapeWidth and reshapeHeight into panelWidth and
			// panelHeight eagerly in order to complete initialization, and
			// force a reshape later
			panelWidth = reshapeWidth;
			panelHeight = reshapeHeight;
		}

		// Fall-through path: create an offscreen context instead
		offscreenDrawable = GLDrawableFactoryImpl.getFactoryImpl()
			.createOffscreenDrawable(offscreenCaps, chooser);
		offscreenDrawable.setSize(Math.max(1, panelWidth), Math.max(1, panelHeight));
		offscreenContext = (GLContextImpl) offscreenDrawable.createContext(shareWith);
		offscreenContext.setSynchronized(true);

		updater = new Updater();
		shouldInitialize = false;
		isInitialized = true;
	}

	private void handleReshape() {
		readBackWidthInPixels = 0;
		readBackHeightInPixels = 0;

		panelWidth = reshapeWidth;
		panelHeight = reshapeHeight;

		if (DEBUG) {
			System.err.println("GLJPanel.handleReshape: (w,h) = (" + panelWidth + ","
					+ panelHeight + ")");
		}

		sendReshape = true;

		offscreenContext.destroy();
		offscreenDrawable.setSize(Math.max(1, panelWidth), Math.max(1, panelHeight));
		readBackWidthInPixels = Math.max(1, panelWidth);
		readBackHeightInPixels = Math.max(1, panelHeight);

		if (offscreenImage != null) {
			offscreenImage.flush();
			offscreenImage = null;
		}

		handleReshape = false;
	}

	// FIXME: it isn't clear whether this works any more given that
	// we're accessing the GLDrawable inside of the GLPbuffer directly
	// up in reshape() -- need to rethink and clean this up
	class Updater implements GLEventListener {
		public void init(GLAutoDrawable drawable) {
			drawableHelper.init(OffscreenCanvas.this);
		}

		public void display(GLAutoDrawable drawable) {

			// setting viewportX&Y to zero??
			if (sendReshape) {
				if (DEBUG) {
					System.err.println("glViewport(" + viewportX + ", " + viewportY
							+ ", " + panelWidth + ", " + panelHeight + ")");
				}
				getGL().glViewport(viewportX, viewportY, panelWidth, panelHeight);
				drawableHelper.reshape(OffscreenCanvas.this, viewportX, viewportY, panelWidth,
					panelHeight);
				sendReshape = false;
			}

			drawableHelper.display(OffscreenCanvas.this);

			// Must now copy pixels from offscreen context into surface
			if (offscreenImage == null) {
				if (panelWidth > 0 && panelHeight > 0) {
					// It looks like NVidia's drivers (at least the ones on
					// my
					// notebook) are buggy and don't allow a sub-rectangle
					// to be
					// read from a pbuffer...this doesn't really matter
					// because
					// it's the Graphics.drawImage() calls that are the
					// bottleneck

					int awtFormat = 0;
					//int hwGLFormat = 0;

					// Should be more flexible in these BufferedImage
					// formats;
					// perhaps see what the preferred image types are on the
					// given platform
					if (isOpaque()) {
						awtFormat = BufferedImage.TYPE_INT_RGB;
					} else {
						awtFormat = BufferedImage.TYPE_INT_ARGB;
					}

					offscreenImage = new BufferedImage(panelWidth, panelHeight,
						awtFormat);
					switch (awtFormat) {
						case BufferedImage.TYPE_3BYTE_BGR:
							glFormat = GL.GL_BGR;
							glType = GL.GL_UNSIGNED_BYTE;
							readBackBytes = ByteBuffer.allocate(readBackWidthInPixels
									* readBackHeightInPixels * 3);
							break;

						case BufferedImage.TYPE_INT_RGB:
						case BufferedImage.TYPE_INT_ARGB:
							glFormat = GL.GL_BGRA;
							glType = offscreenContext
								.getOffscreenContextPixelDataType();
							readBackInts = IntBuffer.allocate(readBackWidthInPixels
									* readBackHeightInPixels);
							break;

						default:
							// FIXME: Support more off-screen image types
							// (current
							// offscreen context implementations don't use
							// others, and
							// some of the OpenGL formats aren't supported
							// in the 1.1
							// headers, which we're currently using)
							throw new GLException("Unsupported offscreen image type "
									+ awtFormat);
					}
				}

				if (offscreenImage != null) {
					GL gl = getGL();
					// Save current modes
					gl.glGetIntegerv(GL.GL_PACK_SWAP_BYTES, swapbytes, 0);
					gl.glGetIntegerv(GL.GL_PACK_ROW_LENGTH, rowlength, 0);
					gl.glGetIntegerv(GL.GL_PACK_SKIP_ROWS, skiprows, 0);
					gl.glGetIntegerv(GL.GL_PACK_SKIP_PIXELS, skippixels, 0);
					gl.glGetIntegerv(GL.GL_PACK_ALIGNMENT, alignment, 0);

					gl.glPixelStorei(GL.GL_PACK_SWAP_BYTES, GL.GL_FALSE);
					gl.glPixelStorei(GL.GL_PACK_ROW_LENGTH, readBackWidthInPixels);
					gl.glPixelStorei(GL.GL_PACK_SKIP_ROWS, 0);
					gl.glPixelStorei(GL.GL_PACK_SKIP_PIXELS, 0);
					gl.glPixelStorei(GL.GL_PACK_ALIGNMENT, 1);

					// Actually read the pixels.
					gl.glReadBuffer(GL.GL_FRONT);
					if (readBackBytes != null) {
						gl.glReadPixels(0, 0, readBackWidthInPixels,
							readBackHeightInPixels, glFormat, glType, readBackBytes);
					} else if (readBackInts != null) {
						gl.glReadPixels(0, 0, readBackWidthInPixels,
							readBackHeightInPixels, glFormat, glType, readBackInts);
					}

					// Restore saved modes.
					gl.glPixelStorei(GL.GL_PACK_SWAP_BYTES, swapbytes[0]);
					gl.glPixelStorei(GL.GL_PACK_ROW_LENGTH, rowlength[0]);
					gl.glPixelStorei(GL.GL_PACK_SKIP_ROWS, skiprows[0]);
					gl.glPixelStorei(GL.GL_PACK_SKIP_PIXELS, skippixels[0]);
					gl.glPixelStorei(GL.GL_PACK_ALIGNMENT, alignment[0]);

					if (readBackBytes != null || readBackInts != null) {
						// Copy temporary data into raster of BufferedImage for
						// faster
						// blitting Note that we could avoid this copy in the
						// cases
						// where
						// !offscreenContext.offscreenImageNeedsVerticalFlip(),
						// but that's the software rendering path which is very
						// slow
						// anyway
						Object src = null;
						Object dest = null;
						int srcIncr = 0;
						int destIncr = 0;

						if (readBackBytes != null) {
							src = readBackBytes.array();
							dest = ((DataBufferByte) offscreenImage.getRaster()
								.getDataBuffer()).getData();
							srcIncr = readBackWidthInPixels * 3;
							destIncr = offscreenImage.getWidth() * 3;
						} else {
							src = readBackInts.array();
							dest = ((DataBufferInt) offscreenImage.getRaster()
								.getDataBuffer()).getData();
							srcIncr = readBackWidthInPixels;
							destIncr = offscreenImage.getWidth();
						}

						int srcPos = 0;
						int destEnd = destIncr * offscreenImage.getHeight();
						for (int destPos = 0; destPos < destEnd; srcPos += srcIncr, destPos += destIncr) {
							System.arraycopy(src, srcPos, dest, destPos, destIncr);
						}
					

						// Draw resulting image in one shot
						//g.drawImage(offscreenImage, 0, 0, offscreenImage.getWidth(),
						//	offscreenImage.getHeight(), GLJPanel.this);
					}
				}
			} else {
				// Cause OpenGL pipeline to flush its results because
				// otherwise it's possible we will buffer up multiple frames'
				// rendering results, resulting in apparent mouse lag
				GL gl = getGL();
				gl.glFinish();

				//postGL(g);
			}
		}

		public void reshape(GLAutoDrawable drawable, int x, int y, int width, int height) {
			// This is handled above and dispatched directly to the appropriate
			// context
		}

		public void displayChanged(GLAutoDrawable drawable, boolean modeChanged,
				boolean deviceChanged) {
			//do nothing
		}
	}

	class InitAction implements Runnable {
		public void run() {
			updater.init(OffscreenCanvas.this);
		}
	}

	private InitAction initAction = new InitAction();

	class DisplayAction implements Runnable {
		public void run() {
			updater.display(OffscreenCanvas.this);
		}
	}

	private DisplayAction displayAction = new DisplayAction();

	// This one is used exclusively in the non-hardware-accelerated case
	class SwapBuffersAction implements Runnable {
		public void run() {
			offscreenDrawable.swapBuffers();
		}
	}

	private SwapBuffersAction swapBuffersAction = new SwapBuffersAction();


}

class EmptyComponentEvents implements ComponentEvents {

	public void addComponentListener(ComponentListener l) {
		throw new UnsupportedOperationException();
	}

	public void addFocusListener(FocusListener l) {
		throw new UnsupportedOperationException();
	}

	public void addHierarchyBoundsListener(HierarchyBoundsListener l) {
		throw new UnsupportedOperationException();
	}

	public void addHierarchyListener(HierarchyListener l) {
		throw new UnsupportedOperationException();
	}

	public void addInputMethodListener(InputMethodListener l) {
		throw new UnsupportedOperationException();
	}

	public void addKeyListener(KeyListener l) {
		throw new UnsupportedOperationException();
	}

	public void addMouseListener(MouseListener l) {
		throw new UnsupportedOperationException();
	}

	public void addMouseMotionListener(MouseMotionListener l) {
		throw new UnsupportedOperationException();
	}

	public void addMouseWheelListener(MouseWheelListener l) {
		throw new UnsupportedOperationException();
	}

	public void addPropertyChangeListener(PropertyChangeListener listener) {
		throw new UnsupportedOperationException();
	}

	public void addPropertyChangeListener(String propertyName,
			PropertyChangeListener listener) {
		throw new UnsupportedOperationException();
	}

	public void removeComponentListener(ComponentListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeFocusListener(FocusListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeHierarchyBoundsListener(HierarchyBoundsListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeHierarchyListener(HierarchyListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeInputMethodListener(InputMethodListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeKeyListener(KeyListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeMouseListener(MouseListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeMouseMotionListener(MouseMotionListener l) {
		throw new UnsupportedOperationException();
	}

	public void removeMouseWheelListener(MouseWheelListener l) {
		throw new UnsupportedOperationException();
	}

	public void removePropertyChangeListener(PropertyChangeListener listener) {
		throw new UnsupportedOperationException();
	}

	public void removePropertyChangeListener(String propertyName,
			PropertyChangeListener listener) {
		throw new UnsupportedOperationException();
	}
}