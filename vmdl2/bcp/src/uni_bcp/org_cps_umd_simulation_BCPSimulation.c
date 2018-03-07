#include "org_cps_umd_simulation_BCPSimulation.h"
#include "uni.h"
#include "uni_ext.h"
///////////////////////////////////////////////////////////////////////////////////
//close
JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_close
  (JNIEnv *env, jobject obj){
	closeSim();
	
	UNI_check(env,obj);
}
//save
JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_save
  (JNIEnv *env, jobject obj, jstring jname){
  
    const char *fname=_getCStr(jname);
	saveSim(fname,NULL);
	_relCStr(jname,fname);
	
	UNI_check(env,obj);
}
//load
JNIEXPORT jint JNICALL Java_org_cps_umd_simulation_BCPSimulation_load
  (JNIEnv *env, jobject obj, jstring jname){
  
	const char *fname=_getCStr(jname);
  	loadSim(fname,NULL);
  	_relCStr(jname,fname);
  	
  	UNI_check(env,obj);
  	
  	return UNI_update(env,obj);
}
//abort
JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_abort
  (JNIEnv *, jobject ){
	abort();
}

//calcstep
JNIEXPORT jint JNICALL Java_org_cps_umd_simulation_BCPSimulation_calculateStep
  (JNIEnv *env, jobject obj, jfloat time){
  
  step(time);
  
  UNI_check(env,obj);
  
  return UNI_update(env,obj);
}
//call
JNIEXPORT jint JNICALL Java_org_cps_umd_simulation_BCPSimulation_call
  (JNIEnv *env, jobject obj, jint fnum, jdoubleArray parameters){

  jdouble *params=(*env)->GetDoubleArrayElements(env,parameters,NULL);

  call(fnum,(*env)->GetArrayLength(env,parameters),params);
  (*env)->ReleaseDoubleArrayElements(env,parameters,params,JNI_ABORT);
  
  UNI_check(env,obj);
  
  return UNI_update(env,obj);
}
  
extern double timec,timed;
JNIEXPORT jfloat JNICALL Java_org_cps_umd_simulation_BCPSimulation_getInstantTime
  (JNIEnv *, jobject){
  	double d=timec+timed;
	return (jfloat)d;
}
////////////////////////////////////////////////////////////////////////////////////

//link
JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_link
  (JNIEnv *env, jobject obj, jobject display, jobject param, jobject input,jobject types){
    
    linkInput(env,input);
    linkParams(env,param);
    linkDisplay(env,display);
    linkTypes(env,types);
    linkSim(env,obj);	
    
    linkInterpreter();
}

JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_unlink(JNIEnv *env, jobject){
	unlinkDisplay(env);
	unlinkInput(env);
	unlinkParams(env);
	unlinkTypes(env);
	unlinkSim(env);
	
	unlinkInterpreter();
}