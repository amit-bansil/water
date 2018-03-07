
Function: _linkParams

; 8: void linkParams(JNIEnv *env,jobject params){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 9: 	jclass cls=(*env)->GetObjectClass(env,params);

00008: 0013 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0016 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0019 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001E FF 56 7C                    CALL DWORD PTR 0000007C[ESI], 00000008
00008: 0021 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 10: 	paramsObj=obj=_getObjGlobal(params);    

00008: 0024 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0027 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 002A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 002D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002F FF 56 54                    CALL DWORD PTR 00000054[ESI], 00000008
00008: 0032 A3 00000000                 MOV DWORD PTR _obj, EAX
00008: 0037 8B 15 00000000              MOV EDX, DWORD PTR _obj
00008: 003D 89 15 00000000              MOV DWORD PTR _paramsObj, EDX

; 12:     namesID=_getStrArrayID("parameterNames");

00008: 0043 68 00000000                 PUSH OFFSET @5
00008: 0048 68 00000000                 PUSH OFFSET @6
00008: 004D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0050 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0053 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0056 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0058 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 005E A3 00000000                 MOV DWORD PTR _namesID, EAX

; 13:     valuesID=_getDoubleArrayID("parameterValues");

00008: 0063 68 00000000                 PUSH OFFSET @7
00008: 0068 68 00000000                 PUSH OFFSET @8
00008: 006D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0070 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0073 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0076 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0078 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 007E A3 00000000                 MOV DWORD PTR _valuesID, EAX

; 14:     outgroupsID=_getStrArrayID("parameterGroups");

00008: 0083 68 00000000                 PUSH OFFSET @5
00008: 0088 68 00000000                 PUSH OFFSET @9
00008: 008D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0090 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0098 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 009E A3 00000000                 MOV DWORD PTR _outgroupsID, EAX

; 16: }

00000: 00A3                     L0000:
00000: 00A3                             epilog 
00000: 00A3 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00A6 5E                          POP ESI
00000: 00A7 5D                          POP EBP
00000: 00A8 C3                          RETN 

Function: _unlinkParams

; 17: void unlinkParams(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 18: 	_relObjGlobal(paramsObj);

00008: 0004 A1 00000000                 MOV EAX, DWORD PTR _paramsObj
00008: 0009 50                          PUSH EAX
00008: 000A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 000D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0010 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0012 FF 56 58                    CALL DWORD PTR 00000058[ESI], 00000008

; 19: 	if(valuesArray) _relObjGlobal(valuesArray);

00008: 0015 83 3D 00000000 00           CMP DWORD PTR _valuesArray, 00000000
00008: 001C 74 11                       JE L0001
00008: 001E A1 00000000                 MOV EAX, DWORD PTR _valuesArray
00008: 0023 50                          PUSH EAX
00008: 0024 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0027 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 002A 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002C FF 56 58                    CALL DWORD PTR 00000058[ESI], 00000008
00008: 002F                     L0001:

; 20: }

00000: 002F                     L0000:
00000: 002F                             epilog 
00000: 002F 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0032 5E                          POP ESI
00000: 0033 5D                          POP EBP
00000: 0034 C3                          RETN 

Function: _updateDescriptions

; 22: void updateDescriptions(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 18                    SUB ESP, 00000018
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 AB                          STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 23: 	_initStrClass();

00008: 0018 68 00000000                 PUSH OFFSET @27
00008: 001D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0020 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0023 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0025 FF 56 18                    CALL DWORD PTR 00000018[ESI], 00000008
00008: 0028 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 28: 	jobjectArray namesArray=_newStrArray(paramCount);

00008: 002B 6A 00                       PUSH 00000000
00008: 002D FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 0030 A1 00000000                 MOV EAX, DWORD PTR _paramCount
00008: 0035 50                          PUSH EAX
00008: 0036 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0039 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 003C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 003E FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 0044 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 29: 	jobjectArray groupsArray=_newStrArray(paramCount);

00008: 0047 6A 00                       PUSH 00000000
00008: 0049 FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 004C A1 00000000                 MOV EAX, DWORD PTR _paramCount
00008: 0051 50                          PUSH EAX
00008: 0052 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0055 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0058 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 005A FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 0060 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 31: 	if(valuesArray) _relObjGlobal(valuesArray); 

00008: 0063 83 3D 00000000 00           CMP DWORD PTR _valuesArray, 00000000
00008: 006A 74 11                       JE L0001
00008: 006C A1 00000000                 MOV EAX, DWORD PTR _valuesArray
00008: 0071 50                          PUSH EAX
00008: 0072 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0075 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0078 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 007A FF 56 58                    CALL DWORD PTR 00000058[ESI], 00000008
00008: 007D                     L0001:

; 32: 	valuesArray=_getObjGlobal(_newDoubleArray(paramCount));

00008: 007D A1 00000000                 MOV EAX, DWORD PTR _paramCount
00008: 0082 50                          PUSH EAX
00008: 0083 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0086 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0089 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 008B FF 96 000002D8              CALL DWORD PTR 000002D8[ESI], 00000008
00008: 0091 50                          PUSH EAX
00008: 0092 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0095 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0098 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 009A FF 56 54                    CALL DWORD PTR 00000054[ESI], 00000008
00008: 009D A3 00000000                 MOV DWORD PTR _valuesArray, EAX

; 34: 	names=getParameterNames();

00008: 00A2 E8 00000000                 CALL SHORT _getParameterNames
00008: 00A7 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 35: 	groups=getParameterGroups();

00008: 00AA E8 00000000                 CALL SHORT _getParameterGroups
00008: 00AF 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 37: 	for(i=0;i<paramCount;i++){

00008: 00B2 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 00B9 EB 5D                       JMP L0002
00008: 00BB                     L0003:

; 38: 	    _setStrArrayElement(namesArray,names[i],i);

00008: 00BB 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 00BE 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00C1 8B 04 88                    MOV EAX, DWORD PTR 00000000[EAX][ECX*4]
00008: 00C4 50                          PUSH EAX
00008: 00C5 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00C8 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00CB 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00CD FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 00D3 50                          PUSH EAX
00008: 00D4 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 00D7 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00DA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00DD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00E0 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00E2 FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 39: 	    _setStrArrayElement(groupsArray,groups[i],i);

00008: 00E8 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 00EB 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00EE 8B 04 88                    MOV EAX, DWORD PTR 00000000[EAX][ECX*4]
00008: 00F1 50                          PUSH EAX
00008: 00F2 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00F5 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F8 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00FA FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 0100 50                          PUSH EAX
00008: 0101 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0104 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0107 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 010A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 010D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 010F FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 40: 	}

00008: 0115 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 0118                     L0002:
00008: 0118 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 011B 3B 05 00000000              CMP EAX, DWORD PTR _paramCount
00008: 0121 7C FFFFFF98                 JL L0003

; 41: 	_setArray(namesID,namesArray);

00008: 0123 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0126 A1 00000000                 MOV EAX, DWORD PTR _namesID
00008: 012B 50                          PUSH EAX
00008: 012C A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0131 50                          PUSH EAX
00008: 0132 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0135 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0138 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 013A FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 42: 	_setArray(outgroupsID,groupsArray);

00008: 0140 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0143 A1 00000000                 MOV EAX, DWORD PTR _outgroupsID
00008: 0148 50                          PUSH EAX
00008: 0149 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 014E 50                          PUSH EAX
00008: 014F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0152 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0155 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0157 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 43: }

00000: 015D                     L0000:
00000: 015D                             epilog 
00000: 015D 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0160 5E                          POP ESI
00000: 0161 5D                          POP EBP
00000: 0162 C3                          RETN 

Function: _updateParams

; 46: void updateParams(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 47: 	obj=paramsObj;

00008: 0004 8B 15 00000000              MOV EDX, DWORD PTR _paramsObj
00008: 000A 89 15 00000000              MOV DWORD PTR _obj, EDX

; 48: 	if(isParametersChanged()){

00008: 0010 E8 00000000                 CALL SHORT _isParametersChanged
00008: 0015 83 F8 00                    CMP EAX, 00000000
00008: 0018 74 13                       JE L0001

; 49: 		paramCount=getNumParameters();

00008: 001A E8 00000000                 CALL SHORT _getNumParameters
00008: 001F A3 00000000                 MOV DWORD PTR _paramCount, EAX

; 50: 		updateDescriptions(env);

00008: 0024 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0027 E8 00000000                 CALL SHORT _updateDescriptions
00008: 002C 59                          POP ECX

; 51: 	}

00008: 002D                     L0001:

; 52: 	if(isParameterValuesChanged()){

00008: 002D E8 00000000                 CALL SHORT _isParameterValuesChanged
00008: 0032 83 F8 00                    CMP EAX, 00000000
00008: 0035 74 42                       JE L0002

; 54: 	    	valuesArray,getParameterValues(),paramCount);

00008: 0037 E8 00000000                 CALL SHORT _getParameterValues
00008: 003C 50                          PUSH EAX
00008: 003D A1 00000000                 MOV EAX, DWORD PTR _paramCount
00008: 0042 50                          PUSH EAX
00008: 0043 6A 00                       PUSH 00000000
00008: 0045 A1 00000000                 MOV EAX, DWORD PTR _valuesArray
00008: 004A 50                          PUSH EAX
00008: 004B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0051 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0053 FF 96 00000358              CALL DWORD PTR 00000358[ESI], 00000014

; 55: 	    _setArray(valuesID,valuesArray);

00008: 0059 A1 00000000                 MOV EAX, DWORD PTR _valuesArray
00008: 005E 50                          PUSH EAX
00008: 005F A1 00000000                 MOV EAX, DWORD PTR _valuesID
00008: 0064 50                          PUSH EAX
00008: 0065 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 006A 50                          PUSH EAX
00008: 006B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 006E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0071 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0073 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 56: 	 }

00008: 0079                     L0002:

; 58: }

00000: 0079                     L0000:
00000: 0079                             epilog 
00000: 0079 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 007C 5E                          POP ESI
00000: 007D 5D                          POP EBP
00000: 007E C3                          RETN 
