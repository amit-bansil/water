#include "uni.h"
#include "uni_ext.h"

jobject obj,paramsObj;
jfieldID namesID,valuesID,outgroupsID;
jdoubleArray valuesArray=NULL;

void linkParams(JNIEnv *env,jobject params){
	jclass cls=(*env)->GetObjectClass(env,params);
	paramsObj=obj=_getObjGlobal(params);    
    
    namesID=_getStrArrayID("parameterNames");
    valuesID=_getDoubleArrayID("parameterValues");
    outgroupsID=_getStrArrayID("parameterGroups");
       
}
void unlinkParams(JNIEnv *env){
	_relObjGlobal(paramsObj);
	if(valuesArray) _relObjGlobal(valuesArray);
}
int paramCount=-1;
void updateDescriptions(JNIEnv *env){
	_initStrClass();
	int i;
	char** names;
	char** groups;
	
	jobjectArray namesArray=_newStrArray(paramCount);
	jobjectArray groupsArray=_newStrArray(paramCount);
	
	if(valuesArray) _relObjGlobal(valuesArray); 
	valuesArray=_getObjGlobal(_newDoubleArray(paramCount));
	
	names=getParameterNames();
	groups=getParameterGroups();
	
	for(i=0;i<paramCount;i++){
	    _setStrArrayElement(namesArray,names[i],i);
	    _setStrArrayElement(groupsArray,groups[i],i);
	}
	_setArray(namesID,namesArray);
	_setArray(outgroupsID,groupsArray);
}
//this will cause array index out of bounds crash if parameterValues
//not changed on first time through
void updateParams(JNIEnv *env){
	obj=paramsObj;
	if(isParametersChanged()){
		paramCount=getNumParameters();
		updateDescriptions(env);
	}
	if(isParameterValuesChanged()){
	    _setDoubleArrayElements(
	    	valuesArray,getParameterValues(),paramCount);
	    _setArray(valuesID,valuesArray);
	 }
	
}
