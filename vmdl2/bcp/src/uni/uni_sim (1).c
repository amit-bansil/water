#include <windows.h>
#include "uni.h"
#include "uni_ext.h"


///////////////////////////////////////////////////////////////////////////////////
BOOL WINAPI DllMain( HINSTANCE, DWORD wDataSeg, LPVOID )
{


	switch(wDataSeg)
	{
    	case DLL_PROCESS_ATTACH:
    	    bindDLL();
      		return 1;
	  		break;
		case DLL_PROCESS_DETACH:
		    unbindDLL();
			return 1;
			break;

	  	default:
	  		return 1;
      		break;
   	}
   	return 0;
}
////////////////////////////////////////////////////////////////////////////////////
jfieldID curTimeID,errorStringID,msgStringID;
void linkSim(JNIEnv *env,jobject obj){
	_prepID();
	curTimeID=_getDoubleID("_curTime");
	errorStringID=_getStrID("_errorString");
	msgStringID=_getStrID("_msgString");
}
void unlinkSim(JNIEnv,jobject){
}
typedef struct _strList{
   char* str;
   struct _strList *next;
} strList;

strList *errList,*msgList,*errLast,*msgLast;

void send_message_up(char *str){
	strList* msg=(strList *)malloc(sizeof(strList));
    msg->next=NULL;
    msg->str=str;
    if(msgList==NULL) msgList=msg;
    else msgLast->next=msg;
    
    msgLast=msg;
}
void send_error_up(char *str){
	strList* err=(strList *)malloc(sizeof(strList));
    err->next=NULL;
    err->str=str;
    if(errList==NULL) errList=err;
    else errLast->next=err;
    
    errLast=err;
}


void UNI_check(JNIEnv *env,jobject obj){
	int errlen=0,msglen=0;
	strList *errTemp=errList,*msgTemp=msgList;
	char *cTemp=NULL,*err=NULL,*msg=NULL,*msgB=NULL,*errB=NULL;
	
	if(errList!=NULL){
		while(errTemp!=NULL){
			cTemp=errTemp->str;
			
			while((*cTemp)!='\0'){cTemp++; errlen++;}
			errlen++;
			errTemp=errTemp->next;
		}
		errTemp=NULL; cTemp=NULL;
		
		errB=err=(char*)malloc(errlen*sizeof(char));
		while(errList!=NULL){
			cTemp=errList->str;
			while((*cTemp)!='\0'){ *err= *cTemp;cTemp++; err++;}
			//*err='\n'; err++;
			cTemp=NULL;
			//free(errList->str);
			
			errTemp=errList->next;
			free(errList);
			errList=errTemp;
		}
		*err='\0';
		errList=NULL; cTemp=NULL;
	}
	errLast=NULL;
	
	if(msgList!=NULL){
		while(msgTemp!=NULL){
			cTemp=msgTemp->str;
			
			while((*cTemp)!='\0'){cTemp++; msglen++;}
			msglen++;
			msgTemp=msgTemp->next;
		}
		msgTemp=NULL; cTemp=NULL;
		
		msgB=msg=(char*)malloc(msglen*sizeof(char));
		while(msgList!=NULL){
			
			cTemp=msgList->str;
			while((*cTemp)!='\0'){*msg= *cTemp;cTemp++; msg++;}
			//*msg='\n'; msg++;
			cTemp=NULL;
			//free(msgList->str);
			
			msgTemp=msgList->next;
			free(msgList);
			msgList=msgTemp;
		}
		*msg='\0';
		msgList=NULL; cTemp=NULL;
	}
	msgLast=NULL;
	
	if(err!=NULL){
		_setStr(errorStringID,_newStr(errB));//possible memory leak
		free(errB);
	}
	if(msg!=NULL){
		_setStr(msgStringID,_newStr(msgB));//ditto
		free(msgB);
	}
	
}

#define CHANGE_PARAM_V  		0x0001;
#define CHANGE_PARAM_D	 		0x0002;
#define CHANGE_INPUT_PARAM_V 	0x0004;
#define CHANGE_INPUT_PARAM_D 	0x0008;
#define CHANGE_POSITIONS 		0x0010;
#define CHANGE_VELOCITIES 		0x0020;
#define CHANGE_BONDS 			0x0040;
#define CHANGE_NUM_ATOMS 		0x0080;
#define CHANGE_BONDS_SCAN 		0x0100;
#define CHANGE_TYPES_BONDS 		0x0200;
#define CHANGE_TYPES_ATOMS      0x0400;
#define CHANGE_TYPE_DESCS  		0x0800;
#define CHANGE_TYPE_MAX_ATOMS   0x2000;
#define CHANGE_NUM_DIMS 	   	0x4000;
#define CHANGE_SIZE 			0x8000;

#define CHANGE_NONE			    0x0000;

long getChanged(){
  long l=CHANGE_NONE;
  if(!isChanged()) return l;

  if(isSizeChanged()) l=l|CHANGE_SIZE;
  if(isNumAtomsChanged()) l=l|CHANGE_NUM_ATOMS;
  if(isBScanSizeChanged()) l=l|CHANGE_BONDS_SCAN;
  if(isBondsChanged()) l=l|CHANGE_BONDS;
  if(isPositionsChanged()) l=l|CHANGE_POSITIONS;
  if(isVelocitiesChanged()) l=l|CHANGE_VELOCITIES;
  if(isParameterValuesChanged()) l=l|CHANGE_PARAM_V;

  if(isParametersChanged()) l=l|CHANGE_PARAM_D;
  if(isInputParameterDescriptionsChanged()) l=l|CHANGE_INPUT_PARAM_D;
  if(isBondTypesChanged()) l=l|CHANGE_TYPES_BONDS;
  if(isAtomTypesChanged()) l=l|CHANGE_TYPES_ATOMS;
  if(isTypeDescriptionsChanged()) l=l|CHANGE_TYPE_DESCS;
  if(isMaxAtomsChanged()) l=l|CHANGE_TYPE_MAX_ATOMS;
  if(isNumDimensionsChanged()) l=l|CHANGE_NUM_DIMS;
  
  return l;
}
extern double timec,timed;
long UNI_update(JNIEnv *env,jobject obj){
	long ret=getChanged();
	_setDouble(curTimeID,timec+timed);
	
	if(isChanged()){
		updateTypes(env);
		updateParams(env);
		updateInput(env);
		updateDisplay(env);
	}
	
	reset();
	
	return ret;
}