
/*
 * CREATED ON:    Sep 8, 2005 9:25:48 AM
 * CREATED BY:    Amit Bansil  
 */
package cps.jarch.simulation.components;

import cps.jarch.data.event.tools.Link;
import cps.jarch.data.DataUtils;
import cps.jarch.gui.components.CELESTLook;
import cps.jarch.gui.components.LayoutUtils;

import javax.swing.JComponent;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSeparator;
import javax.swing.JTable;
import javax.swing.JViewport;
import javax.swing.ListSelectionModel;
import javax.swing.Scrollable;
import javax.swing.UIManager;
import javax.swing.border.Border;
import javax.swing.plaf.UIResource;
import javax.swing.table.TableCellRenderer;
import javax.swing.table.TableColumnModel;
import javax.swing.table.TableModel;
import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Component;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Rectangle;
import java.util.ArrayList;
import java.util.EventObject;
import java.util.List;
import java.util.Map;
import java.util.WeakHashMap;

// TODO have a fixed number of columns for the pref. size
// make selected cell more visible with an excel style fat black
// border, possibly will require increasing gap & decreasing border around
// renderer
//@SuppressWarnings({"ClassTooDeepInInheritanceTree"})
/**
 * <p>
 * </p>
 * @version $Id: StripedTable.java 565 2005-09-08 13:18:30Z bansil $
 * @author Amit Bansil
 */

public class StripedTable extends JTable {
	// colors are kept static and updated automatically on a ui change
	// the components pickup these new colors because the holder add/removes
	// them.
	// for this to work it is essential to add the holder, not the table.
	private static Color evenRowsColor, oddRowsColor, backgroundColor;

	// update colors
	private static final void updateColors() {
		evenRowsColor = CELESTLook.getInstance().getWhiteColor();
		oddRowsColor = CELESTLook.getInstance().getBackgroundColor();
		backgroundColor = CELESTLook.getInstance().getBackgroundColor();
	}

	private static final List<Holder> activeHolders = new ArrayList<Holder>();
	static {
		DataUtils.linkAndSync(CELESTLook.getInstance().getChangeSupport(),
			new Link() {
				@Override public void signal(EventObject event) {
					updateColors();
					for (Holder h : activeHolders) {
						h.uiChange();
					}
				}
			});
	}

	public StripedTable(TableModel dm, TableColumnModel cm,
			ListSelectionModel sm) {
		super(dm, cm, sm);
		setShowHorizontalLines(false);
	}

	public StripedTable(TableModel dm, TableColumnModel cm) {
		super(dm, cm);
		setShowHorizontalLines(false);
	}

	public StripedTable(TableModel dm) {
		super(dm);
		setShowHorizontalLines(false);
	}

	// have the scrollpanel just fit the table
	@Override
	public Dimension getPreferredScrollableViewportSize() {
		return getPreferredSize();
	}

	// TODO create SimulationLookAndFeel that calls back to CELESTLookAndFeel
	@Override
	public TableCellRenderer getCellRenderer(int row, int column) {
		TableCellRenderer ret = super.getCellRenderer(row, column);
		assert ret != null;
		if (ret instanceof StripedTableCellRenderer) return ret;
		
		// return associated stripedTableCellRenderer from cache
		TableCellRenderer striped = renderCache.get(ret);
		if (striped == null) {
			// create and cache if not found
			striped = new StripedTableCellRenderer(ret);
			renderCache.put(ret, striped);
		}
		return striped;
	}

	private final Map<TableCellRenderer, TableCellRenderer> renderCache = new WeakHashMap<TableCellRenderer, TableCellRenderer>();

	private static class StripedTableCellRenderer implements TableCellRenderer {

		/** the renderer to perform the initial rendering, may be null */
		private TableCellRenderer baseRenderer = null;

		/**
		 * Create a new StripedRowsTableRenderer that alternates between the
		 * specified colours in rendering cells. This uses the renderer as
		 * specified to do the initial rendering.
		 */
		public StripedTableCellRenderer(TableCellRenderer baseRenderer) {
			this.baseRenderer = baseRenderer;
		}

		/**
		 * Returns the component used for drawing the cell.
		 */
		public Component getTableCellRendererComponent(JTable table,
				Object value, boolean isSelected, boolean hasFocus, int row,
				int column) {
			// get the renderer to use for this cell
			TableCellRenderer renderer;
			if (baseRenderer == null) {
				Class rendererClass = Object.class;
				if (value != null) rendererClass = value.getClass();
				renderer = table.getDefaultRenderer(rendererClass);
			} else {
				renderer = baseRenderer;
			}

			// do the initial rendering with no striping
			Component rendered = renderer.getTableCellRendererComponent(table,
				value, isSelected, hasFocus, row, column);

			// skip striping if there's a selection
			if (isSelected) return rendered;
			// do the striping
			if (row % 2 == 0) {
				rendered.setBackground(evenRowsColor);
			} else {
				rendered.setBackground(oddRowsColor);
			}

			return rendered;
		}
	}

	private Holder holder = null;

	public Component getHolder() {
		if (holder == null) {
			holder = new Holder(new BorderLayout(0, 0));
			holder.add(this, BorderLayout.NORTH);
			// have to do this since using a box layout for holder
			// causes the table to tweak, probably since it compresses
			// the table to the left
			JComponent bottom = new JPanel(new BorderLayout(0, 0));
			bottom.add(new JSeparator(), BorderLayout.NORTH);
			holder.add(bottom, BorderLayout.CENTER);
			// a little extra space below the bottom makes the table look nicer
			holder.add(LayoutUtils.mediumPad(), BorderLayout.SOUTH);

		}
		return holder;
	}

//	@SuppressWarnings({"ClassTooDeepInInheritanceTree"})
    private final class Holder extends JPanel implements Scrollable {
		// causes table to rerender itself on a ui change as well as
		// updateing the enclosing viewport if there is one
		public void uiChange() {
			if (getComponents().length != 0) {
				StripedTable.this.invalidate();
				configureEnclosingScrollPane();
			}
		}

		public Holder(BorderLayout layout) {
			super(layout);
		}

		public Dimension getPreferredScrollableViewportSize() {
			return getPreferredSize();
		}

		public int getScrollableUnitIncrement(Rectangle visibleRect,
				int orientation, int direction) {
			return StripedTable.this.getScrollableUnitIncrement(visibleRect,
				orientation, direction);
		}

		public int getScrollableBlockIncrement(Rectangle visibleRect,
				int orientation, int direction) {
			return StripedTable.this.getScrollableBlockIncrement(visibleRect,
				orientation, direction);
		}

		public boolean getScrollableTracksViewportWidth() {
			return StripedTable.this.getScrollableTracksViewportWidth();
		}

		public boolean getScrollableTracksViewportHeight() {
			return StripedTable.this.getScrollableTracksViewportHeight();
		}

		/**
		 * Calls the <code>configureEnclosingScrollPane</code> method.
		 * 
		 * @see #configureEnclosingScrollPane
		 */
		@Override
		public void addNotify() {
			super.addNotify();
			configureEnclosingScrollPane();
			activeHolders.add(this);
		}

		/**
		 * If this <code>JTable</code> is the <code>viewportView</code> of
		 * an enclosing <code>JScrollPane</code> (the usual situation),
		 * configure this <code>ScrollPane</code> by, amongst other things,
		 * installing the table's <code>tableHeader</code> as the
		 * <code>columnHeaderView</code> of the scroll pane. When a
		 * <code>JTable</code> is added to a <code>JScrollPane</code> in the
		 * usual way, using <code>new JScrollPane(myTable)</code>,
		 * <code>addNotify</code> is called in the <code>JTable</code> (when
		 * the table is added to the viewport). <code>JTable</code>'s
		 * <code>addNotify</code> method in turn calls this method, which is
		 * protected so that this default installation procedure can be
		 * overridden by a subclass.
		 * 
		 * @see #addNotify
		 */
		protected void configureEnclosingScrollPane() {
			Container p = getParent();
			if (p instanceof JViewport) {
				Container gp = p.getParent();
				if (gp instanceof JScrollPane) {
					JScrollPane scrollPane = (JScrollPane) gp;
					// Make certain we are the viewPort's view and not, for
					// example, the rowHeaderView of the scrollPane -
					// an implementor of fixed columns might do this.
					JViewport viewport = scrollPane.getViewport();
					// added to make things match better
					viewport.setBackground(backgroundColor);
					if (viewport.getView() != this) { return; }
					scrollPane.setColumnHeaderView(getTableHeader());
					// scrollPane.getViewport().setBackingStoreEnabled(true);
					Border border = scrollPane.getBorder();
					if (border == null || border instanceof UIResource) {
						scrollPane.setBorder(UIManager
							.getBorder("Table.scrollPaneBorder"));
					}
				}
			}
		}

		/**
		 * Calls the <code>unconfigureEnclosingScrollPane</code> method.
		 * 
		 * @see #unconfigureEnclosingScrollPane
		 */
		@Override
		public void removeNotify() {
			unconfigureEnclosingScrollPane();
			activeHolders.remove(this);
			super.removeNotify();
		}

		/**
		 * Reverses the effect of <code>configureEnclosingScrollPane</code> by
		 * replacing the <code>columnHeaderView</code> of the enclosing scroll
		 * pane with <code>null</code>. <code>JTable</code>'s
		 * <code>removeNotify</code> method calls this method, which is
		 * protected so that this default uninstallation procedure can be
		 * overridden by a subclass.
		 * 
		 * @see #removeNotify
		 * @see #configureEnclosingScrollPane
		 */
		protected void unconfigureEnclosingScrollPane() {
			Container p = getParent();
			if (p instanceof JViewport) {
				Container gp = p.getParent();
				if (gp instanceof JScrollPane) {
					JScrollPane scrollPane = (JScrollPane) gp;
					// Make certain we are the viewPort's view and not, for
					// example, the rowHeaderView of the scrollPane -
					// an implementor of fixed columns might do this.
					JViewport viewport = scrollPane.getViewport();
					if (viewport == null || viewport.getView() != this) { return; }
					scrollPane.setColumnHeaderView(null);
				}
			}
		}

	}

	// ------------------------------------------------------------------------
	// using large fonts

	private boolean usingLargeFonts = false;

	/**
	 * largefonts is an unbound display property that when set enlarges all text
	 * and headers in the table. Good for tables that are taking up a
	 * significant percentage of the entire screen. Defaults to false.
	 */
//	@SuppressWarnings({"MethodMayBeStatic"})
    public void setUsingLargeFonts(boolean v) {
		//if (v == usingLargeFonts)
        //TODO implement
        throw new UnsupportedOperationException();
    }

	public boolean isUsingLargeFonts() {
		return usingLargeFonts;
	}
}