#include "uni.h"
#include "uni_ext.h"

jobject obj,inputObj;
jfieldID inNamesID,inGroupsID,parameterCountsID,inputParameterNamesID,inputParameterValuesID;

void linkInput(JNIEnv *env,jobject input){
	jclass cls=(*env)->GetObjectClass(env,input);
	inputObj=obj=_getObjGlobal(input);    
    
    inNamesID=_getStrArrayID("parameterNames");
    inGroupsID=_getStrArrayID("parameterGroups");
    parameterCountsID=_getIntArrayID("parameterCounts");
    inputParameterNamesID=_getStrArrayID("inputParameterNames");
    inputParameterValuesID=_getDoubleArrayID("parameterValues");
}
void unlinkInput(JNIEnv *env){
	_relObjGlobal(inputObj);
}
int inputParamCount=99999,parameterNamesCount=99999;
void updateInputDescriptions(JNIEnv *env){
	_initStrClass();
	int i;
	char** names;
	char** groups;
	char** parameterNames;
	
	jobjectArray namesArray=_newStrArray(inputParamCount);
	jobjectArray groupsArray=_newStrArray(inputParamCount);
	jintArray parameterCountArray=_newIntArray(inputParamCount);
	jobjectArray parameterNamesArray=_newStrArray(parameterNamesCount);
	jdoubleArray parameterValuesArray=_newDoubleArray(parameterNamesCount);
	
	parameterNames=getInputParameterNames();
	names=getInputNames();
	groups=getInputGroups();
	
	for(i=0;i<inputParamCount;i++){
	    _setStrArrayElement(namesArray,names[i],i);
	    _setStrArrayElement(groupsArray,groups[i],i);

	}
	for(i=0;i<parameterNamesCount;i++){
		_setStrArrayElement(parameterNamesArray,parameterNames[i],i);
	}
	
	_setIntArrayElements(parameterCountArray,getInputCounts(),inputParamCount);
	_setDoubleArrayElements(parameterValuesArray,getInputParameterValues(),parameterNamesCount);
	
	_setArray(inputParameterNamesID,parameterNamesArray);
	_setArray(inNamesID,namesArray);
	_setArray(inGroupsID,groupsArray);
	_setArray(parameterCountsID,parameterCountArray);
	_setArray(inputParameterValuesID,parameterValuesArray);
	
}

void updateInput(JNIEnv *env){
	jfloatArray parameterValuesArray;
	obj=inputObj;
	if(isInputParameterDescriptionsChanged()){
		inputParamCount=getNumInput();
		parameterNamesCount=getInputParameterNamesCount();
		updateInputDescriptions(env);
	}else if(isParameterValuesChanged()){//optimize,new flag and const element
		parameterValuesArray=_newDoubleArray(parameterNamesCount);
		_setDoubleArrayElements(parameterValuesArray,getInputParameterValues(),parameterNamesCount);
		_setArray(inputParameterValuesID,parameterValuesArray);
	}
}