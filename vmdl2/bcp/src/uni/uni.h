#include<jni.h>
#include<stdlib.h>
#include<stdio.h>

void linkDisplay(JNIEnv *env,jobject obj);
void linkTypes(JNIEnv *env,jobject obj);
void linkParams(JNIEnv *env,jobject obj);
void linkInput(JNIEnv *env,jobject obj);
void unlinkDisplay(JNIEnv *env);
void unlinkTypes(JNIEnv *env);
void unlinkParams(JNIEnv *env);
void unlinkInput(JNIEnv *env);

void updateInput(JNIEnv *env);
void updateDisplay(JNIEnv *env);
void updateParams(JNIEnv *env);
void updateTypes(JNIEnv *env);
///////////////////////////////////////////////////////////////////////////////////
void UNI_check(JNIEnv* env, jobject obj);
long UNI_update(JNIEnv* env, jobject obj);
///////////////////////////////////////////////////////////////////////////////////
#define _getCStr(jstr) (*env)->GetStringUTFChars(env,jstr,0)
#define _relCStr(jstr,cstr) (*env)->ReleaseStringUTFChars(env,jstr,cstr)
#define _newStr(cstr) (*env)->NewStringUTF(env,cstr)

#define _getObj(fid) (*env)->GetObjectField(env,obj,fid)
#define _getObjGlobal(o) (*env)->NewGlobalRef(env,o)
#define _relObjGlobal(o) (*env)->DeleteGlobalRef(env,o)

#define _getArrayCrit(aobj) (*env)->GetPrimitiveArrayCritical(env,aobj,0)
#define _killArrayCrit(aobj,array) (*env)->ReleasePrimitiveArrayCritical(env,aobj,array, JNI_ABORT )
#define _relArrayCrit(aobj,array) (*env)->ReleasePrimitiveArrayCritical(env,aobj,array, 0 )

#define _setInt(fid,v) (*env)->SetIntField(env,obj,fid,v)
#define _setFloat(fid,v) (*env)->SetFloatField(env,obj,fid,v)
#define _setBoolean(fid,v) (*env)->SetBooleanField(env,obj,fid,v)
#define _setDouble(fid,v) (*env)->SetDoubleField(env,obj,fid,v)
#define _setLong(fid,v) (*env)->SetLongField(env,obj,fid,v)
#define _setChar(fid,v) (*env)->SetCharField(env,obj,fid,v)
#define _setShort(fid,v) (*env)->SetShortField(env,obj,fid,v)
#define _setByte(fid,v) (*env)->SetByteField(env,obj,fid,v)
#define _setStr(fid,v) (*env)->SetObjectField(env,obj,fid,v)

#define _prepID() jclass cls=(*env)->GetObjectClass(env,obj)
#define _getIntID(name) (*env)->GetFieldID(env,cls,name,"I")
#define _getFloatID(name) (*env)->GetFieldID(env,cls,name,"F")
#define _getIntArrayID(name) (*env)->GetFieldID(env,cls,name,"[I")
#define _getDoubleArrayID(name) (*env)->GetFieldID(env,cls,name,"[D")
#define _getFloatArrayID(name) (*env)->GetFieldID(env,cls,name,"[F")
#define _getCharArrayID(name) (*env)->GetFieldID(env,cls,name,"[C")
#define _getDoubleID(name) (*env)->GetFieldID(env,cls,name,"D")
#define _getStrID(name) (*env)->GetFieldID(env,cls,name,"Ljava/lang/String;")
#define _getStrArrayID(name) (*env)->GetFieldID(env,cls,name,"[Ljava/lang/String;")

#define _setDoubleArrayElements(dst,src,len) (*env)->SetDoubleArrayRegion(env,dst,0,len,src)
#define _setDoubleArrayElementsRegion(dst,src,len,start) (*env)->SetDoubleArrayRegion(env,dst,start,len,src)
#define _setFloatArrayElements(dst,src,len) (*env)->SetFloatArrayRegion(env,dst,0,len,src)
#define _setIntArrayElements(dst,src,len) (*env)->SetIntArrayRegion(env,dst,0,len,src)
#define _setCharArrayElements(dst,src,len) (*env)->SetCharArrayRegion(env,dst,0,len,src)
#define _setFloatArrayElementsRegion(dst,src,start,len) (*env)->SetDoubleArrayRegion(env,dst,start,len,src)
#define _setStrArrayElement(dst,cstr,elem) (*env)->SetObjectArrayElement(env,dst,elem,_newStr(cstr))

#define _setStrArray(fid,v) (*env)->SetObjectField(env,obj,fid,v)
#define _setArray(fid,v) (*env)->SetObjectField(env,obj,fid,v)
#define _setStrArray(fid,v) (*env)->SetObjectField(env,obj,fid,v)
#define _setStrArray(fid,v) (*env)->SetObjectField(env,obj,fid,v)
#define _getArray(fid) (*env)->GetObjectField(env,obj,fid)
#define _newDoubleArray(len) (*env)->NewDoubleArray(env,len)
#define _newFloatArray(len) (*env)->NewFloatArray(env,len)
#define _newCharArray(len) (*env)->NewCharArray(env,len)
#define _newIntArray(len) (*env)->NewIntArray(env,len)
#define _initStrClass() jclass strClass=(*env)->FindClass(env,"java/lang/String")
#define _newStrArray(len) (*env)->NewObjectArray(env,len,strClass,NULL)