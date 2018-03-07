#include "uni.h"
#include "uni_ext.h"

jobject obj,typesObj;
jfieldID atomColorsID,bondColorsID,atomRadiiID,bondRadiiID,
	bondOrdersID,atomElementsID,firstAtomChangedID,firstBondChangedID,
	lastAtomChangedID,lastBondChangedID,
	atomDescsID,bondTypesID,atomTypesID;

void linkTypes(JNIEnv *env,jobject types){
	jclass cls=(*env)->GetObjectClass(env,types);
	typesObj=obj=_getObjGlobal(types);  
	
	atomColorsID=_getFloatArrayID("atomTypeColors");
	bondColorsID=_getFloatArrayID("bondTypeColors");
	bondOrdersID=_getIntArrayID("bondOrders");
	atomRadiiID=_getFloatArrayID("atomTypeRadii");
	bondRadiiID=_getFloatArrayID("bondTypeRadii");
	atomElementsID=_getCharArrayID("atomTypeElements");
	firstAtomChangedID=_getIntID("firstAtomTypeChanged");
	firstBondChangedID=_getIntID("firstBondTypeChanged");
	lastAtomChangedID=_getIntID("lastAtomTypeChanged");
	lastBondChangedID=_getIntID("lastBondTypeChanged");
	atomDescsID=_getStrArrayID("atomTypeDescriptions");
	bondTypesID=_getIntArrayID("bondTypes");
	atomTypesID=_getIntArrayID("atomTypes");
}
void unlinkTypes(JNIEnv *env){
	_relObjGlobal(typesObj);
}

void updateBondTypeDescs(JNIEnv *env){
	int i;
	const int count=getNumBondTypeDescriptions();
	float *colors=malloc(sizeof(float)*count*3),
		*radii=malloc(sizeof(float)*count);
	long *orders=malloc(sizeof(long)*count);
	jfloatArray colorsArray=_newFloatArray(count*3);
	jfloatArray radiiArray=_newFloatArray(count);
	jintArray ordersArray=_newIntArray(count);
	
	BOND_TYPE_DESCRIPTION b;
	
	for(i=0;i<count;i++){
		b=getBondTypeDescription(i);
		orders[i]=b.order;
		colors[i*3]=b.r;
		colors[i*3+1]=b.g;
		colors[i*3+2]=b.b;
		radii[i]=b.radius;
	}
	_setFloatArrayElements(colorsArray,colors,count*3);
	_setFloatArrayElements(radiiArray,radii,count);
	_setIntArrayElements(ordersArray,orders,count);
	
	_setArray(bondOrdersID,ordersArray);
	_setArray(bondRadiiID,radiiArray);
	_setArray(bondColorsID,colorsArray);
	
	free(colors);
	free(radii);
	free(orders);
}
void updateAtomTypeDescs(JNIEnv *env){
	_initStrClass();
	int i;
	const int count=getNumAtomTypeDescriptions();
	float *colors=malloc(sizeof(float)*count*3),
		*radii=malloc(sizeof(float)*count);
	unsigned short *elements=malloc(sizeof(unsigned short)*count*2);
	ATOM_TYPE_DESCRIPTION b;
	
	jfloatArray colorsArray=_newFloatArray(count*3);
	jfloatArray radiiArray=_newFloatArray(count);
	jobjectArray descsArray=_newStrArray(count);
	jcharArray elementsArray=_newCharArray(count*2);
	
	
	
	for(i=0;i<count;i++){
		b=getAtomTypeDescription(i);
		colors[i*3]=b.r;
		colors[i*3+1]=b.g;
		colors[i*3+2]=b.b;
		radii[i]=b.radius;
		elements[i*2]=b.e1;
		elements[(i*2)+1]=b.e2;
		
		_setStrArrayElement(descsArray,b.description,i);
	}
	
	_setFloatArrayElements(colorsArray,colors,count*3);
	_setFloatArrayElements(radiiArray,radii,count);
	_setCharArrayElements(elementsArray,elements,count*2);
	
	_setArray(atomElementsID,elementsArray);
	_setArray(atomColorsID,colorsArray);
	_setArray(atomRadiiID,radiiArray);
	_setArray(atomDescsID,descsArray);
	
	free(colors);
	free(radii);
	free(elements);
}
void updateBondTypes(JNIEnv *env){
	jintArray bonds=_getArray(bondTypesID);
	long *buf;
	int start,end;
	
	if(bonds==NULL||isMaxAtomsChanged()){
		bonds=_newIntArray(getMaxAtoms());
		start=0;
		end=getMaxAtoms();
		_setArray(bondTypesID,bonds);
	}else{
		start=getFirstBondNumTypeChanged();
		end=getLastBondNumTypeChanged();		
	}
	buf=_getArrayCrit(bonds);
	getBondTypes(start,end,buf);
	_relArrayCrit(bonds,buf);
	
	_setInt(firstBondChangedID,start);
	_setInt(lastBondChangedID,end);
}
void updateAtomTypes(JNIEnv *env){
	jintArray atoms=_getArray(atomTypesID);
	long *buf;
	int start,end;
	
	if(atoms==NULL||isMaxAtomsChanged()){
		atoms=_newIntArray(getMaxAtoms());
		start=0;
		end=getMaxAtoms();
		_setArray(atomTypesID,atoms);
	}else{
		start=getFirstAtomNumTypeChanged();
		end=getLastAtomNumTypeChanged();		
	}
	buf=_getArrayCrit(atoms);
	getAtomTypes(start,end,buf);
	_relArrayCrit(atoms,buf);
	
	_setInt(firstAtomChangedID,start);
	_setInt(lastAtomChangedID,end);
}
void updateTypes(JNIEnv *env){
	obj=typesObj;
	if(isTypeDescriptionsChanged()){
		updateAtomTypeDescs(env);
		updateBondTypeDescs(env);
	}
	if(isAtomTypesChanged()||isMaxAtomsChanged()){
		updateAtomTypes(env);
	}
	if(isBondTypesChanged()||isMaxAtomsChanged()){
		updateBondTypes(env);
	}
}