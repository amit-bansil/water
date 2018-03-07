#include "uni.h"
#include "uni_ext.h"

jobject obj,displayObj;
jfieldID firstBondChangedID,firstVelocityChangedID,firstPositionChangedID,
		lastBondChangedID,lastVelocityChangedID,lastPositionChangedID,
		bondsID,positionsID,velocitiesID,numAtomsID,numBondsID,sizeID,numDimensionsID;

void linkDisplay(JNIEnv *env,jobject display){
	jclass cls=(*env)->GetObjectClass(env,display);
	displayObj=obj=_getObjGlobal(display); 
	
	firstBondChangedID=_getIntID("firstChangedBond");
	firstPositionChangedID=_getIntID("firstChangedPosition");
	firstVelocityChangedID=_getIntID("firstChangedVelocity");
	lastBondChangedID=_getIntID("lastChangedBond");
	lastPositionChangedID=_getIntID("lastChangedPosition");
	lastVelocityChangedID=_getIntID("lastChangedVelocity");
	
	bondsID=_getIntArrayID("bonds");
	positionsID=_getFloatArrayID("positions");
	velocitiesID=_getFloatArrayID("velocities");
	numAtomsID=_getIntID("numAtoms");
	numBondsID=_getIntID("bScanSize");
	sizeID=_getFloatArrayID("size");
	numDimensionsID=_getIntID("numDimensions");
}
void unlinkDisplay(JNIEnv *env){
	_relObjGlobal(displayObj);
}
void updatePositions(JNIEnv *env){
	jfloatArray positions=_getArray(positionsID);
	float* buf;
	int start,end;
	if(positions==NULL||isMaxAtomsChanged()){
		positions=_newFloatArray(getMaxAtoms()*3);
		start=0;
		end=getMaxAtoms();
		_setArray(positionsID,positions);
	}else{
		start=getFirstAtomNumChanged();
		end=getLastAtomNumChanged();
	}
	buf=_getArrayCrit(positions);
	getPositions(start,end,buf);
	_relArrayCrit(positions,buf);
	
	_setInt(firstPositionChangedID,start);
	_setInt(lastPositionChangedID,end);
}
void updateVelocities(JNIEnv *env){
	jfloatArray velocities=_getArray(velocitiesID);
	float* buf;
	int start,end;
	if(velocities==NULL||isMaxAtomsChanged()){
		velocities=_newFloatArray(getMaxAtoms()*3);
		start=0;
		end=getMaxAtoms();
		_setArray(velocitiesID,velocities);
	}else{
		start=getFirstAtomNumChanged();
		end=getLastAtomNumChanged();
	}
	buf=_getArrayCrit(velocities);
	getVelocities(start,end,buf);
	_relArrayCrit(velocities,buf);
	
	_setInt(firstVelocityChangedID,start);
	_setInt(lastVelocityChangedID,end);
}
void updateBonds(JNIEnv *env){
	jintArray bonds=_getArray(bondsID);
	long* buf;
	int start,end;
	if(bonds==NULL||isMaxAtomsChanged()||isBScanSizeChanged()){
		bonds=_newIntArray(getMaxAtoms()*getBScanSize());
		start=0;
		end=getMaxAtoms();
		_setArray(bondsID,bonds);
	}else{
		start=getFirstBondNumChanged();
		end=getLastBondNumChanged();
	}
	buf=_getArrayCrit(bonds);
	getBonds(start,end,buf);
	_relArrayCrit(bonds,buf);
	
	_setInt(firstBondChangedID,start);
	//_setInt(lastBondChangedID,end);
}

void updateSize(JNIEnv *env){
	jfloatArray size=_newFloatArray(3);
	_setFloatArrayElements(size,getSize(),3);
	_setArray(sizeID,size);
}
void updateDisplay(JNIEnv *env){
	obj=displayObj;
	
	if(isPositionsChanged()||isMaxAtomsChanged()){
		updatePositions(env);
	}
	if(isBondsChanged()||isMaxBondsChanged()){
		updateBonds(env);
	}
	if(isVelocitiesChanged()||isMaxAtomsChanged()){
		updateVelocities(env);
	}
	if(isSizeChanged()){
		updateSize(env);
	}
	if(isNumAtomsChanged()){
		_setInt(numAtomsID,getNumAtoms());
	}
	if(isBScanSizeChanged()){
		_setInt(numBondsID,getBScanSize());
	}
	if(isNumDimensionsChanged()){
		_setInt(numDimensionsID,getNumDimensions());
	}
}