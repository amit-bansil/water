/*
 * @(#)BorderLayout.java	1.56 04/05/18
 *
 * Copyright 2004 Sun Microsystems, Inc. All rights reserved.
 * SUN PROPRIETARY/CONFIDENTIAL. Use is subject to license terms.
 */

package cps.jarch.simulation.components;

import cps.jarch.util.misc.LangUtils;
import cps.jarch.util.notes.Nullable;

import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Insets;
import java.awt.LayoutManager2;

//TODO test, proper docs, RTL support (do this with a RelPosition constraint and a "Position to Rel."  method)

// a border layout that fixes the aspect ratio of the main component
//tries to arrange components so that the center (even if it doesen't exist)
//has aspect ratio within (aspectRatio-aspectRange,aspectRatio+aspectRange) after taking
//away aspectInstets
//this is done by distributing free space using the xWeight & yWeight parameters
//such that if xWeight=1 all free space is give to the bottom, if xWeight=0 all free space
//is given to the top, if xWeight=0.5 free space if split evenly etc. and similarly
//for yWeight. 

//note constraints is now an enum
//also note that, in keeping with the original border layout imp. this manager cannot
//be reused across multiple containers

//aspectratio=width/height
public class AspectLayout implements LayoutManager2,
				     java.io.Serializable {

	private Component north,west,east,south,center;

    public static enum Position{North,South,East,West,Center};
    // ------------------------------------------------------------------------
    //members
    
    private float minAspect=2f/3f,maxAspect=3f/2f;
    private Insets aspectInsets=new Insets(0,0,0,0);
    private float xWeight=0,yWeight=0;
    
    public final float getXWeight() {
    	return xWeight;
    }
    public final float getYWeight() {
    	return yWeight;
    }
    
    public final void setAspectRange(float min,float max) {
		if (min > max || min <= 0)
			throw new IllegalArgumentException("aspect range [" + min+","+max
					+ " not a valid range with min>0)");
		
		minAspect=min;
		maxAspect=max;
    }
    //sets aspect range to accept all ratios
	public void setAspectRangeAll() {
		setAspectRange(Float.MIN_VALUE, Float.MAX_VALUE);
	}
    public final Insets getAspectInsets() {
    	return (Insets) aspectInsets.clone();
    }
    public final void setAspectInsets(Insets insets) {
    	LangUtils.checkArgNotNull(insets);
    	aspectInsets=insets;
    }
    public final float getMinAspectRatio() {
    	return minAspect;
    }
    public final float getMaxApsectRatio() {
    	return maxAspect;
    }
    
    public final void setXWeight(float w) {
		if (w < 0 || w > 1)
			throw new IllegalArgumentException("weight " + w + " not in [0,1]");
		xWeight=w;
    }
    public final void setYWeight(float w) {
		if (w < 0 || w > 1)
			throw new IllegalArgumentException("weight " + w + " not in [0,1]");
		yWeight=w;
    }
    
    public AspectLayout() {
    	//does nothing
	}

    /**
	 * Adds the specified component to the layout, using the specified
	 * constraint object. For border layouts, the constraint must be one of the
	 * {@link Position} constants, or null which defaults to Center.
	 * <p>
	 * Most applications do not call this method directly. This method is called
	 * when a component is added to a container using the
	 * <code>Container.add</code> method with the same argument types.
	 * 
	 * @throws IllegalArgumentException
	 *             if constaints is not one of Position contants or <code>null</code>.
	 */
	public void addLayoutComponent(Component comp,@Nullable Object constraints) {
		synchronized (comp.getTreeLock()) {
			if ((constraints == null)) {
				//special case
				center=comp;
			} else if(constraints instanceof Position) {
				switch((Position)constraints) {
					case Center:
						center=comp;
						break;
					case North:
						north=comp;
						break;
					case South:
						south=comp;
						break;
					case East:
						east=comp;
						break;
					case West:
						west=comp;
						break;
				}
			}else {
				throw new IllegalArgumentException(
					"cannot add to layout: constraint must be a ApsectLayout.Position (or null)");
			}
		}
	}

    /**
	 * @deprecated replaced by
	 *             <code>addLayoutComponent(Component, Object)</code>. Will generally
	 *             result in {@link IllegalArgumentException}.
	 */
	@Deprecated public void addLayoutComponent(String position, Component comp) {
		addLayoutComponent(comp, position);
	}

    /**
	 * Removes the specified component from this border layout. This method is
	 * called when a container calls its <code>remove</code> or
	 * <code>removeAll</code> methods. Most applications do not call this
	 * method directly.
	 * 
	 * @param comp
	 *            the component to be removed.
	 * @see java.awt.Container#remove(java.awt.Component)
	 * @see java.awt.Container#removeAll()
	 */
	public void removeLayoutComponent(Component comp) {
		synchronized (comp.getTreeLock()) {
			if (comp == center) {
				center = null;
			} else if (comp == north) {
				north = null;
			} else if (comp == south) {
				south = null;
			} else if (comp == east) {
				east = null;
			} else if (comp == west) {
				west = null;
			}
		}
	}

    /**
     * Gets the component that was added using the given constraint
     *
     * @return  the component at the given location, or </code>null</code> if
     *          the location is empty
     * @exception   IllegalArgumentException  if the constraint object is
     *              not one of the Position constants
     * @see     #addLayoutComponent(java.awt.Component, java.lang.Object)
     */
    public Component getLayoutComponent(Object constraints) {
    	if(constraints instanceof Position) {
			switch((Position)constraints) {
				case Center:
					return center;
				case North:
					return north;
				case South:
					return south;
				case East:
					return east;
				case West:
					return west;
			}
		}
		throw new IllegalArgumentException(
			"cannot add to layout: constraint must be a ApsectLayout.Position (or null)");
		
    }


    /**
     * @see     #getLayoutComponent(java.lang.Object)
     */
    public Component getLayoutComponent(Container target, Object constraints) {
        return getLayoutComponent(constraints);
    }


    /**
	 * Gets the constraints for the specified component or null if it was not
	 * added.
	 */
    public Position getConstraints(Component comp) {
		if (comp == center) {
		    return Position.Center;
		} else if (comp == north) {
		    return Position.North;
		} else if (comp == south) {
		    return Position.South;
		} else if (comp == west) {
		    return Position.West;
		} else if (comp == east) {
		    return Position.East;
		}else return null;
    }

    /**
	 * Determines the minimum size of the <code>target</code> container using
	 * this layout manager.
	 * <p>
	 * This method is called when a container calls its
	 * <code>getMinimumSize</code> method. Most applications do not call this
	 * method directly.
	 * 
	 * @param target
	 *            the container in which to do the layout.
	 * @return the minimum dimensions needed to lay out the subcomponents of the
	 *         specified container.
	 * @see java.awt.Container
	 * @see java.awt.BorderLayout#preferredLayoutSize
	 * @see java.awt.Container#getMinimumSize()
	 */
	public Dimension minimumLayoutSize(Container target) {
		synchronized (target.getTreeLock()) {
			Dimension dim = new Dimension(0, 0);

			Component c = null;

			if ((c = getChild(Position.East)) != null) {
				Dimension d = c.getMinimumSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.West)) != null) {
				Dimension d = c.getMinimumSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.Center)) != null) {
				Dimension d = c.getMinimumSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.North)) != null) {
				Dimension d = c.getMinimumSize();
				dim.width = Math.max(d.width, dim.width);
				dim.height += d.height;
			}
			if ((c = getChild(Position.South)) != null) {
				Dimension d = c.getMinimumSize();
				dim.width = Math.max(d.width, dim.width);
				dim.height += d.height;
			}

			Insets insets = target.getInsets();
			dim.width += insets.left + insets.right;
			dim.height += insets.top + insets.bottom;

			return dim;
		}
	}

    /**
	 * Determines the preferred size of the <code>target</code> container
	 * using this layout manager, based on the components in the container.
	 * <p>
	 * Most applications do not call this method directly. This method is called
	 * when a container calls its <code>getPreferredSize</code> method.
	 * 
	 * @param target
	 *            the container in which to do the layout.
	 * @return the preferred dimensions to lay out the subcomponents of the
	 *         specified container.
	 * @see java.awt.Container
	 * @see java.awt.BorderLayout#minimumLayoutSize
	 * @see java.awt.Container#getPreferredSize()
	 */
	public Dimension preferredLayoutSize(Container target) {
		synchronized (target.getTreeLock()) {
			Dimension dim = new Dimension(0, 0);

			Component c = null;

			if ((c = getChild(Position.East)) != null) {
				Dimension d = c.getPreferredSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.West)) != null) {
				Dimension d = c.getPreferredSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.Center)) != null) {
				Dimension d = c.getPreferredSize();
				dim.width += d.width;
				dim.height = Math.max(d.height, dim.height);
			}
			if ((c = getChild(Position.North)) != null) {
				Dimension d = c.getPreferredSize();
				dim.width = Math.max(d.width, dim.width);
				dim.height += d.height;
			}
			if ((c = getChild(Position.South)) != null) {
				Dimension d = c.getPreferredSize();
				dim.width = Math.max(d.width, dim.width);
				dim.height += d.height;
			}

			Insets insets = target.getInsets();
			dim.width += insets.left + insets.right;
			dim.height += insets.top + insets.bottom;
			System.out.println("ph"+dim.height);
			return dim;
		}
	}

    /**
     * Returns the maximum dimensions for this layout given the components
     * in the specified target container.
     * @param target the component which needs to be laid out
     * @see Container
     * @see #minimumLayoutSize
     * @see #preferredLayoutSize
     */
    public Dimension maximumLayoutSize(Container target) {
	return new Dimension(Integer.MAX_VALUE, Integer.MAX_VALUE);
    }

    /**
     * Returns the alignment along the x axis.  This specifies how
     * the component would like to be aligned relative to other
     * components.  The value should be a number between 0 and 1
     * where 0 represents alignment along the origin, 1 is aligned
     * the furthest away from the origin, 0.5 is centered, etc.
     */
    public float getLayoutAlignmentX(Container parent) {
	return 0.5f;
    }

    /**
     * Returns the alignment along the y axis.  This specifies how
     * the component would like to be aligned relative to other
     * components.  The value should be a number between 0 and 1
     * where 0 represents alignment along the origin, 1 is aligned
     * the furthest away from the origin, 0.5 is centered, etc.
     */
    public float getLayoutAlignmentY(Container parent) {
	return 0.5f;
    }

    /**
     * Invalidates the layout, indicating that if the layout manager
     * has cached information it should be discarded.
     */
    public void invalidateLayout(Container target) {
    	//do nothing???
    }

    /**
	 * Lays out the container argument using this border layout.
	 * <p>
	 * This method actually reshapes the components in the specified container
	 * in order to satisfy the constraints of this <code>BorderLayout</code>
	 * object. The <code>NORTH</code> and <code>SOUTH</code> components, if
	 * any, are placed at the top and bottom of the container, respectively. The
	 * <code>WEST</code> and <code>EAST</code> components are then placed on
	 * the left and right, respectively. Finally, the <code>CENTER</code>
	 * object is placed in any remaining space in the middle.
	 * <p>
	 * Most applications do not call this method directly. This method is called
	 * when a container calls its <code>doLayout</code> method.
	 * 
	 * @param target
	 *            the container in which to do the layout.
	 * @see java.awt.Container
	 * @see java.awt.Container#doLayout()
	 */
	public void layoutContainer(Container target) {
		System.out.println("th"+target.getHeight());
		synchronized (target.getTreeLock()) {
			Insets insets = target.getInsets();

			int targetTop = insets.top;
			int targetBottom = target.getHeight() - insets.bottom;
			int targetLeft = insets.left;
			int targetRight = target.getWidth() - insets.right;

			int centerTop = targetTop;
			int centerBottom = targetBottom;
			int centerLeft = targetLeft;
			int centerRight = targetRight;

			// determine size of center
			centerTop += getPref(Position.North).height;
			centerBottom -= getPref(Position.South).height;
			centerRight -= getPref(Position.East).width;
			centerLeft += getPref(Position.West).width;

			int xAspectInsets = (aspectInsets.left + aspectInsets.right);
			int yAspectInsets = (aspectInsets.top + aspectInsets.bottom);

			// incase preferred sizes are such that we don't have enough space
			if (centerTop + yAspectInsets >= centerBottom)
				centerBottom = centerTop + yAspectInsets + 1;
			if (centerLeft + xAspectInsets >= centerRight)
				centerRight = centerLeft + xAspectInsets + 1;

			// shrink if needed
			int centerWidth = (centerRight - centerLeft) - xAspectInsets;
			int centerHeight = (centerBottom - centerTop) - yAspectInsets;
			assert centerHeight > 0 && centerWidth > 0;

			float aspect = centerWidth / centerHeight;
			if (aspect > maxAspect) {// shrink width
				int newWidth = (int) Math.floor(centerHeight * maxAspect);
				assert newWidth <= centerWidth;
				int shrink = centerWidth - newWidth;
				int shrinkLeft = Math.round(xWeight * shrink);
				centerRight -= shrink - shrinkLeft;
				// need to do it like this so that everything adds up
				centerLeft += shrinkLeft;
			} else if (aspect < minAspect) {// shrink height
				int newHeight = (int) Math.floor(centerWidth / minAspect);
				assert newHeight <= centerHeight;
				int shrink = centerHeight - newHeight;
				int shrinkBottom = Math.round(yWeight * shrink);
				centerBottom -= shrinkBottom;
				centerTop += shrink - shrinkBottom;
			}
			// if we don't have a east/west keep north/south from expanding past
			// left/right
			// edges of center
			int eastRight, westLeft;
			if (getChild(Position.East) == null) eastRight = centerRight;
			else eastRight = targetRight;
			if (getChild(Position.West) == null) westLeft = centerLeft;
			else westLeft = targetLeft;

			// layout components
			setBounds(Position.North, westLeft, eastRight, targetTop, centerTop);
			setBounds(Position.South, westLeft, eastRight, centerBottom, targetBottom);
			setBounds(Position.West, westLeft, centerLeft, centerTop, centerBottom);
			setBounds(Position.East, centerRight, eastRight, centerTop, centerBottom);

			if (center != null)
				center.setBounds(centerLeft, centerTop, centerRight - centerLeft,
					centerBottom - centerTop);

		}
	}
	private static final Dimension zeroZero=new Dimension(0,0);
	private Dimension getPref(Position key) {
		Component c=getChild(key);
		if(c==null) return zeroZero;
		else return c.getPreferredSize();
	}
	private final void setBounds(Position key,int left,int right,int top,int bottom) {
		Component c=getChild(key);
		if(c!=null)
			c.setBounds(left, top, right-left, bottom-top);
	}
    /**
     * Get the component that corresponds to the given constraint
     */
    private @Nullable Component getChild(Position key) {
    	LangUtils.checkArgNotNull(key);
    	
        Component result = getLayoutComponent(key);
        
        if (result != null && !result.isVisible()) {
            result = null;
        }
        return result;
    }
}
