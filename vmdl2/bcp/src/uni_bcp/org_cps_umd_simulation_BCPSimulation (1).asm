
Function: _Java_org_cps_umd_simulation_BCPSimulation_close@8

; 7:   (JNIEnv *env, jobject obj){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 8: 	closeSim();

00008: 0003 E8 00000000                 CALL SHORT _closeSim

; 10: 	UNI_check(env,obj);

00008: 0008 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 000B 50                          PUSH EAX
00008: 000C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 000F 50                          PUSH EAX
00008: 0010 E8 00000000                 CALL SHORT _UNI_check
00008: 0015 59                          POP ECX
00008: 0016 59                          POP ECX

; 11: }

00000: 0017                     L0000:
00000: 0017                             epilog 
00000: 0017 C9                          LEAVE 
00000: 0018 C2 0008                     RETN 0008

Function: _Java_org_cps_umd_simulation_BCPSimulation_save@12

; 14:   (JNIEnv *env, jobject obj, jstring jname){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 16:     const char *fname=_getCStr(jname);

00008: 0013 6A 00                       PUSH 00000000
00008: 0015 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 0018 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0020 FF 96 000002A4              CALL DWORD PTR 000002A4[ESI], 0000000C
00008: 0026 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 17: 	saveSim(fname,NULL);

00008: 0029 6A 00                       PUSH 00000000
00008: 002B FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 002E E8 00000000                 CALL SHORT _saveSim
00008: 0033 59                          POP ECX
00008: 0034 59                          POP ECX

; 18: 	_relCStr(jname,fname);

00008: 0035 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0038 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 003B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 003E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0041 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0043 FF 96 000002A8              CALL DWORD PTR 000002A8[ESI], 0000000C

; 20: 	UNI_check(env,obj);

00008: 0049 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 004C 50                          PUSH EAX
00008: 004D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0050 E8 00000000                 CALL SHORT _UNI_check
00008: 0055 59                          POP ECX
00008: 0056 59                          POP ECX

; 21: }

00000: 0057                     L0000:
00000: 0057                             epilog 
00000: 0057 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 005A 5E                          POP ESI
00000: 005B 5D                          POP EBP
00000: 005C C2 000C                     RETN 000C

Function: _Java_org_cps_umd_simulation_BCPSimulation_load@12

; 24:   (JNIEnv *env, jobject obj, jstring jname){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 26: 	const char *fname=_getCStr(jname);

00008: 0013 6A 00                       PUSH 00000000
00008: 0015 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 0018 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0020 FF 96 000002A4              CALL DWORD PTR 000002A4[ESI], 0000000C
00008: 0026 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 27:   	loadSim(fname,NULL);

00008: 0029 6A 00                       PUSH 00000000
00008: 002B FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 002E E8 00000000                 CALL SHORT _loadSim
00008: 0033 59                          POP ECX
00008: 0034 59                          POP ECX

; 28:   	_relCStr(jname,fname);

00008: 0035 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0038 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 003B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 003E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0041 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0043 FF 96 000002A8              CALL DWORD PTR 000002A8[ESI], 0000000C

; 30:   	UNI_check(env,obj);

00008: 0049 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 004C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004F E8 00000000                 CALL SHORT _UNI_check
00008: 0054 59                          POP ECX
00008: 0055 59                          POP ECX

; 32:   	return UNI_update(env,obj);

00008: 0056 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0059 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 005C E8 00000000                 CALL SHORT _UNI_update
00008: 0061 59                          POP ECX
00008: 0062 59                          POP ECX
00008: 0063 89 C0                       MOV EAX, EAX
00000: 0065                     L0000:
00000: 0065                             epilog 
00000: 0065 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0068 5E                          POP ESI
00000: 0069 5D                          POP EBP
00000: 006A C2 000C                     RETN 000C

Function: _Java_org_cps_umd_simulation_BCPSimulation_abort@8

; 36:   (JNIEnv *, jobject ){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 37: 	abort();

00008: 0003 E8 00000000                 CALL SHORT _abort

; 38: }

00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C2 0008                     RETN 0008

Function: _Java_org_cps_umd_simulation_BCPSimulation_calculateStep@12

; 42:   (JNIEnv *env, jobject obj, jfloat time){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 44:   step(time);

00008: 0003 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 0006 E8 00000000                 CALL SHORT _step
00008: 000B 59                          POP ECX

; 46:   UNI_check(env,obj);

00008: 000C FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 000F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0012 E8 00000000                 CALL SHORT _UNI_check
00008: 0017 59                          POP ECX
00008: 0018 59                          POP ECX

; 48:   return UNI_update(env,obj);

00008: 0019 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 001C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001F E8 00000000                 CALL SHORT _UNI_update
00008: 0024 59                          POP ECX
00008: 0025 59                          POP ECX
00008: 0026 89 C0                       MOV EAX, EAX
00000: 0028                     L0000:
00000: 0028                             epilog 
00000: 0028 C9                          LEAVE 
00000: 0029 C2 000C                     RETN 000C

Function: _Java_org_cps_umd_simulation_BCPSimulation_call@16

; 52:   (JNIEnv *env, jobject obj, jint fnum, jdoubleArray parameters){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 54:   jdouble *params=(*env)->GetDoubleArrayElements(env,parameters,NULL);

00008: 0013 6A 00                       PUSH 00000000
00008: 0015 FF 75 14                    PUSH DWORD PTR 00000014[EBP]
00008: 0018 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0020 FF 96 000002F8              CALL DWORD PTR 000002F8[ESI], 0000000C
00008: 0026 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 56:   call(fnum,(*env)->GetArrayLength(env,parameters),params);

00008: 0029 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 002C FF 75 14                    PUSH DWORD PTR 00000014[EBP]
00008: 002F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0032 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0035 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0037 FF 96 000002AC              CALL DWORD PTR 000002AC[ESI], 00000008
00008: 003D 50                          PUSH EAX
00008: 003E 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0041 50                          PUSH EAX
00008: 0042 E8 00000000                 CALL SHORT _call
00008: 0047 83 C4 0C                    ADD ESP, 0000000C

; 57:   (*env)->ReleaseDoubleArrayElements(env,parameters,params,JNI_ABORT);

00008: 004A 6A 02                       PUSH 00000002
00008: 004C FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 004F FF 75 14                    PUSH DWORD PTR 00000014[EBP]
00008: 0052 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0055 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0058 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 005A FF 96 00000318              CALL DWORD PTR 00000318[ESI], 00000010

; 59:   UNI_check(env,obj);

00008: 0060 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0063 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0066 E8 00000000                 CALL SHORT _UNI_check
00008: 006B 59                          POP ECX
00008: 006C 59                          POP ECX

; 61:   return UNI_update(env,obj);

00008: 006D FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0070 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0073 E8 00000000                 CALL SHORT _UNI_update
00008: 0078 59                          POP ECX
00008: 0079 59                          POP ECX
00008: 007A 89 C0                       MOV EAX, EAX
00000: 007C                     L0000:
00000: 007C                             epilog 
00000: 007C 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 007F 5E                          POP ESI
00000: 0080 5D                          POP EBP
00000: 0081 C2 0010                     RETN 0010

Function: _Java_org_cps_umd_simulation_BCPSimulation_getInstantTime@8

; 66:   (JNIEnv *, jobject){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 10                    SUB ESP, 00000010
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 AB                          STOSD 
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 5F                          POP EDI
00000: 0015                             prolog 

; 67:   	double d=timec+timed;

00008: 0015 DD 05 00000000              FLD QWORD PTR _timec
00007: 001B DC 05 00000000              FADD QWORD PTR _timed
00007: 0021 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 68: 	return (jfloat)d;

00008: 0024 DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 0027 D9 5D FFFFFFF8              FSTP DWORD PTR FFFFFFF8[EBP]
00008: 002A D9 45 FFFFFFF8              FLD DWORD PTR FFFFFFF8[EBP]
00000: 002D                     L0000:
00000: 002D                             epilog 
00000: 002D C9                          LEAVE 
00000: 002E C2 0008                     RETN 0008

Function: _Java_org_cps_umd_simulation_BCPSimulation_link@24

; 74:   (JNIEnv *env, jobject obj, jobject display, jobject param, jobject input,jobject types){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 76:     linkInput(env,input);

00008: 0003 8B 45 18                    MOV EAX, DWORD PTR 00000018[EBP]
00008: 0006 50                          PUSH EAX
00008: 0007 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 000A E8 00000000                 CALL SHORT _linkInput
00008: 000F 59                          POP ECX
00008: 0010 59                          POP ECX

; 77:     linkParams(env,param);

00008: 0011 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 0014 50                          PUSH EAX
00008: 0015 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0018 E8 00000000                 CALL SHORT _linkParams
00008: 001D 59                          POP ECX
00008: 001E 59                          POP ECX

; 78:     linkDisplay(env,display);

00008: 001F 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0022 50                          PUSH EAX
00008: 0023 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0026 E8 00000000                 CALL SHORT _linkDisplay
00008: 002B 59                          POP ECX
00008: 002C 59                          POP ECX

; 79:     linkTypes(env,types);

00008: 002D 8B 45 1C                    MOV EAX, DWORD PTR 0000001C[EBP]
00008: 0030 50                          PUSH EAX
00008: 0031 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0034 E8 00000000                 CALL SHORT _linkTypes
00008: 0039 59                          POP ECX
00008: 003A 59                          POP ECX

; 80:     linkSim(env,obj);	

00008: 003B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 003E 50                          PUSH EAX
00008: 003F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0042 E8 00000000                 CALL SHORT _linkSim
00008: 0047 59                          POP ECX
00008: 0048 59                          POP ECX

; 82:     linkInterpreter();

00008: 0049 E8 00000000                 CALL SHORT _linkInterpreter

; 83: }

00000: 004E                     L0000:
00000: 004E                             epilog 
00000: 004E C9                          LEAVE 
00000: 004F C2 0018                     RETN 0018

Function: _Java_org_cps_umd_simulation_BCPSimulation_unlink@8

; 85: JNIEXPORT void JNICALL Java_org_cps_umd_simulation_BCPSimulation_unlink(JNIEnv *env, jobject){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 86: 	unlinkDisplay(env);

00008: 0003 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0006 E8 00000000                 CALL SHORT _unlinkDisplay
00008: 000B 59                          POP ECX

; 87: 	unlinkInput(env);

00008: 000C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 000F E8 00000000                 CALL SHORT _unlinkInput
00008: 0014 59                          POP ECX

; 88: 	unlinkParams(env);

00008: 0015 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0018 E8 00000000                 CALL SHORT _unlinkParams
00008: 001D 59                          POP ECX

; 89: 	unlinkTypes(env);

00008: 001E FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0021 E8 00000000                 CALL SHORT _unlinkTypes
00008: 0026 59                          POP ECX

; 90: 	unlinkSim(env);

00008: 0027 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 002A E8 00000000                 CALL SHORT _unlinkSim
00008: 002F 59                          POP ECX

; 92: 	unlinkInterpreter();

00008: 0030 E8 00000000                 CALL SHORT _unlinkInterpreter

; 93: }

00000: 0035                     L0000:
00000: 0035                             epilog 
00000: 0035 C9                          LEAVE 
00000: 0036 C2 0008                     RETN 0008
