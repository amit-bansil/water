/*
 * CREATED ON:    Apr 16, 2006 10:14:36 PM
 * CREATED BY:    Amit Bansil 
 */
package cps.water.data;

import ca.odell.glazedlists.BasicEventList;
import ca.odell.glazedlists.EventList;
import cps.jarch.data.value.tools.BoundedValue;
import cps.jarch.data.value.tools.RWFlag;
import cps.water.AppModel.Model;

/**
 * <p>TODO document DataViewerModel
 * </p>
 * @version $Id$
 * @author Amit Bansil
 */
public class DataViewerModel {

	public DataViewerModel(EventList<Model> simModels) {
	}
	private final RWFlag showAllParameterHistories=new RWFlag(false);
	private final BoundedValue<Float> historyLength=new BoundedValue<Float>(500f,200f,100000f);
	private final EventList<Model> displayedModels=new BasicEventList<Model>();
	//private final RWValue<DataSet> xDataSet=new RWValueImp<DataSet>();//null for all
	//private final RWValue<DataSet> yDataSet=new RWValueImp<DataSet>();//null for time,ignored when showing all
	//public static final ArrayFinal<DataSet> getDataSets(){
	//	return dataSets; 
	//}
}
