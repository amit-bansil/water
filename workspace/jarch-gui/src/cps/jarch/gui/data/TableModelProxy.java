/*
 * TableModelProxy.java
 * CREATED:    May 30, 2005 4:46:12 PM
 * AUTHOR:     Amit Bansil
 * PROJECT:    celest-framework-gui
 * 
 * Copyright 2005 The Center for Polymer Studies,
 * Boston University, all rights reserved.
 * */
package cps.jarch.gui.data;

import javax.swing.event.TableModelListener;
import javax.swing.table.TableModel;

public class TableModelProxy implements TableModel {
	public TableModelProxy(TableModel tableModel) {
		this.tableModel=tableModel;
	}
	private final TableModel tableModel;
	public final TableModel getModel() {
		return tableModel;
	}
	
	public int getRowCount() {
		return tableModel.getRowCount();
	}

	public int getColumnCount() {
		return tableModel.getColumnCount();
	}

	public String getColumnName(int columnIndex) {
		return tableModel.getColumnName(columnIndex);
	}

	public Class< ? > getColumnClass(int columnIndex) {
		return tableModel.getColumnClass(columnIndex);
	}

	public boolean isCellEditable(int rowIndex, int columnIndex) {
		return tableModel.isCellEditable(rowIndex, columnIndex);
	}

	public Object getValueAt(int rowIndex, int columnIndex) {
		return tableModel.getValueAt(rowIndex, columnIndex);
	}

	public void setValueAt(Object aValue, int rowIndex, int columnIndex) {
		tableModel.setValueAt(aValue, rowIndex, columnIndex);
	}

	public void addTableModelListener(TableModelListener l) {
		tableModel.addTableModelListener(l);

	}

	public void removeTableModelListener(TableModelListener l) {
		tableModel.removeTableModelListener(l);
	}
}
