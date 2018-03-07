
Function: _linkInput

; 7: void linkInput(JNIEnv *env,jobject input){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 8: 	jclass cls=(*env)->GetObjectClass(env,input);

00008: 0013 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0016 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0019 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001E FF 56 7C                    CALL DWORD PTR 0000007C[ESI], 00000008
00008: 0021 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 9: 	inputObj=obj=_getObjGlobal(input);    

00008: 0024 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0027 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 002A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 002D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002F FF 56 54                    CALL DWORD PTR 00000054[ESI], 00000008
00008: 0032 A3 00000000                 MOV DWORD PTR _obj, EAX
00008: 0037 8B 15 00000000              MOV EDX, DWORD PTR _obj
00008: 003D 89 15 00000000              MOV DWORD PTR _inputObj, EDX

; 11:     inNamesID=_getStrArrayID("parameterNames");

00008: 0043 68 00000000                 PUSH OFFSET @5
00008: 0048 68 00000000                 PUSH OFFSET @6
00008: 004D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0050 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0053 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0056 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0058 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 005E A3 00000000                 MOV DWORD PTR _inNamesID, EAX

; 12:     inGroupsID=_getStrArrayID("parameterGroups");

00008: 0063 68 00000000                 PUSH OFFSET @5
00008: 0068 68 00000000                 PUSH OFFSET @7
00008: 006D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0070 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0073 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0076 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0078 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 007E A3 00000000                 MOV DWORD PTR _inGroupsID, EAX

; 13:     parameterCountsID=_getIntArrayID("parameterCounts");

00008: 0083 68 00000000                 PUSH OFFSET @8
00008: 0088 68 00000000                 PUSH OFFSET @9
00008: 008D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0090 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0098 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 009E A3 00000000                 MOV DWORD PTR _parameterCountsID, EAX

; 14:     inputParameterNamesID=_getStrArrayID("inputParameterNames");

00008: 00A3 68 00000000                 PUSH OFFSET @5
00008: 00A8 68 00000000                 PUSH OFFSET @10
00008: 00AD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00B8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00BE A3 00000000                 MOV DWORD PTR _inputParameterNamesID, EAX

; 15:     inputParameterValuesID=_getDoubleArrayID("parameterValues");

00008: 00C3 68 00000000                 PUSH OFFSET @11
00008: 00C8 68 00000000                 PUSH OFFSET @12
00008: 00CD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00D0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00DE A3 00000000                 MOV DWORD PTR _inputParameterValuesID, EAX

; 16: }

00000: 00E3                     L0000:
00000: 00E3                             epilog 
00000: 00E3 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00E6 5E                          POP ESI
00000: 00E7 5D                          POP EBP
00000: 00E8 C3                          RETN 

Function: _unlinkInput

; 17: void unlinkInput(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 18: 	_relObjGlobal(inputObj);

00008: 0004 A1 00000000                 MOV EAX, DWORD PTR _inputObj
00008: 0009 50                          PUSH EAX
00008: 000A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 000D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0010 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0012 FF 56 58                    CALL DWORD PTR 00000058[ESI], 00000008

; 19: }

00000: 0015                     L0000:
00000: 0015                             epilog 
00000: 0015 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0018 5E                          POP ESI
00000: 0019 5D                          POP EBP
00000: 001A C3                          RETN 

Function: _updateInputDescriptions

; 21: void updateInputDescriptions(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 28                    SUB ESP, 00000028
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 B9 0000000A                 MOV ECX, 0000000A
00000: 0016 F3 AB                       REP STOSD 
00000: 0018 5F                          POP EDI
00000: 0019                             prolog 

; 22: 	_initStrClass();

00008: 0019 68 00000000                 PUSH OFFSET @31
00008: 001E FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0021 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0024 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0026 FF 56 18                    CALL DWORD PTR 00000018[ESI], 00000008
00008: 0029 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 28: 	jobjectArray namesArray=_newStrArray(inputParamCount);

00008: 002C 6A 00                       PUSH 00000000
00008: 002E FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0031 A1 00000000                 MOV EAX, DWORD PTR _inputParamCount
00008: 0036 50                          PUSH EAX
00008: 0037 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 003A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 003D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 003F FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 0045 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 29: 	jobjectArray groupsArray=_newStrArray(inputParamCount);

00008: 0048 6A 00                       PUSH 00000000
00008: 004A FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 004D A1 00000000                 MOV EAX, DWORD PTR _inputParamCount
00008: 0052 50                          PUSH EAX
00008: 0053 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0056 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0059 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 005B FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 0061 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 30: 	jintArray parameterCountArray=_newIntArray(inputParamCount);

00008: 0064 A1 00000000                 MOV EAX, DWORD PTR _inputParamCount
00008: 0069 50                          PUSH EAX
00008: 006A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 006D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0070 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0072 FF 96 000002CC              CALL DWORD PTR 000002CC[ESI], 00000008
00008: 0078 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 31: 	jobjectArray parameterNamesArray=_newStrArray(parameterNamesCount);

00008: 007B 6A 00                       PUSH 00000000
00008: 007D FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0080 A1 00000000                 MOV EAX, DWORD PTR _parameterNamesCount
00008: 0085 50                          PUSH EAX
00008: 0086 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0089 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 008C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 008E FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 0094 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 32: 	jdoubleArray parameterValuesArray=_newDoubleArray(parameterNamesCount);

00008: 0097 A1 00000000                 MOV EAX, DWORD PTR _parameterNamesCount
00008: 009C 50                          PUSH EAX
00008: 009D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A0 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A3 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00A5 FF 96 000002D8              CALL DWORD PTR 000002D8[ESI], 00000008
00008: 00AB 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 34: 	parameterNames=getInputParameterNames();

00008: 00AE E8 00000000                 CALL SHORT _getInputParameterNames
00008: 00B3 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 35: 	names=getInputNames();

00008: 00B6 E8 00000000                 CALL SHORT _getInputNames
00008: 00BB 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 36: 	groups=getInputGroups();

00008: 00BE E8 00000000                 CALL SHORT _getInputGroups
00008: 00C3 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 38: 	for(i=0;i<inputParamCount;i++){

00008: 00C6 C7 45 FFFFFFD8 00000000     MOV DWORD PTR FFFFFFD8[EBP], 00000000
00008: 00CD EB 5D                       JMP L0001
00008: 00CF                     L0002:

; 39: 	    _setStrArrayElement(namesArray,names[i],i);

00008: 00CF 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 00D2 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 00D5 8B 04 88                    MOV EAX, DWORD PTR 00000000[EAX][ECX*4]
00008: 00D8 50                          PUSH EAX
00008: 00D9 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00DC 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00DF 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00E1 FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 00E7 50                          PUSH EAX
00008: 00E8 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 00EB FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 00EE FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00F1 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F4 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00F6 FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 40: 	    _setStrArrayElement(groupsArray,groups[i],i);

00008: 00FC 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 00FF 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0102 8B 04 88                    MOV EAX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0105 50                          PUSH EAX
00008: 0106 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0109 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 010C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 010E FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 0114 50                          PUSH EAX
00008: 0115 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0118 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 011B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 011E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0121 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0123 FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 42: 	}

00008: 0129 FF 45 FFFFFFD8              INC DWORD PTR FFFFFFD8[EBP]
00008: 012C                     L0001:
00008: 012C 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 012F 3B 05 00000000              CMP EAX, DWORD PTR _inputParamCount
00008: 0135 7C FFFFFF98                 JL L0002

; 43: 	for(i=0;i<parameterNamesCount;i++){

00008: 0137 C7 45 FFFFFFD8 00000000     MOV DWORD PTR FFFFFFD8[EBP], 00000000
00008: 013E EB 30                       JMP L0003
00008: 0140                     L0004:

; 44: 		_setStrArrayElement(parameterNamesArray,parameterNames[i],i);

00008: 0140 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 0143 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0146 8B 04 88                    MOV EAX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0149 50                          PUSH EAX
00008: 014A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 014D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0150 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0152 FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 0158 50                          PUSH EAX
00008: 0159 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 015C FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 015F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0162 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0165 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0167 FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 45: 	}

00008: 016D FF 45 FFFFFFD8              INC DWORD PTR FFFFFFD8[EBP]
00008: 0170                     L0003:
00008: 0170 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0173 3B 05 00000000              CMP EAX, DWORD PTR _parameterNamesCount
00008: 0179 7C FFFFFFC5                 JL L0004

; 47: 	_setIntArrayElements(parameterCountArray,getInputCounts(),inputParamCount);

00008: 017B E8 00000000                 CALL SHORT _getInputCounts
00008: 0180 50                          PUSH EAX
00008: 0181 A1 00000000                 MOV EAX, DWORD PTR _inputParamCount
00008: 0186 50                          PUSH EAX
00008: 0187 6A 00                       PUSH 00000000
00008: 0189 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 018C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 018F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0192 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0194 FF 96 0000034C              CALL DWORD PTR 0000034C[ESI], 00000014

; 48: 	_setDoubleArrayElements(parameterValuesArray,getInputParameterValues(),parameterNamesCount);

00008: 019A E8 00000000                 CALL SHORT _getInputParameterValues
00008: 019F 50                          PUSH EAX
00008: 01A0 A1 00000000                 MOV EAX, DWORD PTR _parameterNamesCount
00008: 01A5 50                          PUSH EAX
00008: 01A6 6A 00                       PUSH 00000000
00008: 01A8 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 01AB FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01AE 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01B1 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01B3 FF 96 00000358              CALL DWORD PTR 00000358[ESI], 00000014

; 50: 	_setArray(inputParameterNamesID,parameterNamesArray);

00008: 01B9 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 01BC A1 00000000                 MOV EAX, DWORD PTR _inputParameterNamesID
00008: 01C1 50                          PUSH EAX
00008: 01C2 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 01C7 50                          PUSH EAX
00008: 01C8 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01CB 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01CE 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01D0 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 51: 	_setArray(inNamesID,namesArray);

00008: 01D6 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 01D9 A1 00000000                 MOV EAX, DWORD PTR _inNamesID
00008: 01DE 50                          PUSH EAX
00008: 01DF A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 01E4 50                          PUSH EAX
00008: 01E5 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01E8 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01EB 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01ED FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 52: 	_setArray(inGroupsID,groupsArray);

00008: 01F3 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 01F6 A1 00000000                 MOV EAX, DWORD PTR _inGroupsID
00008: 01FB 50                          PUSH EAX
00008: 01FC A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0201 50                          PUSH EAX
00008: 0202 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0205 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0208 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 020A FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 53: 	_setArray(parameterCountsID,parameterCountArray);

00008: 0210 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0213 A1 00000000                 MOV EAX, DWORD PTR _parameterCountsID
00008: 0218 50                          PUSH EAX
00008: 0219 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 021E 50                          PUSH EAX
00008: 021F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0222 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0225 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0227 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 54: 	_setArray(inputParameterValuesID,parameterValuesArray);

00008: 022D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0230 A1 00000000                 MOV EAX, DWORD PTR _inputParameterValuesID
00008: 0235 50                          PUSH EAX
00008: 0236 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 023B 50                          PUSH EAX
00008: 023C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 023F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0242 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0244 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 56: }

00000: 024A                     L0000:
00000: 024A                             epilog 
00000: 024A 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 024D 5E                          POP ESI
00000: 024E 5D                          POP EBP
00000: 024F C3                          RETN 

Function: _updateInput

; 58: void updateInput(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 60: 	obj=inputObj;

00008: 0013 8B 15 00000000              MOV EDX, DWORD PTR _inputObj
00008: 0019 89 15 00000000              MOV DWORD PTR _obj, EDX

; 61: 	if(isInputParameterDescriptionsChanged()){

00008: 001F E8 00000000                 CALL SHORT _isInputParameterDescriptionsChanged
00008: 0024 83 F8 00                    CMP EAX, 00000000
00008: 0027 74 1F                       JE L0001

; 62: 		inputParamCount=getNumInput();

00008: 0029 E8 00000000                 CALL SHORT _getNumInput
00008: 002E A3 00000000                 MOV DWORD PTR _inputParamCount, EAX

; 63: 		parameterNamesCount=getInputParameterNamesCount();

00008: 0033 E8 00000000                 CALL SHORT _getInputParameterNamesCount
00008: 0038 A3 00000000                 MOV DWORD PTR _parameterNamesCount, EAX

; 64: 		updateInputDescriptions(env);

00008: 003D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0040 E8 00000000                 CALL SHORT _updateInputDescriptions
00008: 0045 59                          POP ECX

; 65: 	}else if(isParameterValuesChanged()){//optimize,new flag and const element

00008: 0046 EB 5D                       JMP L0002
00008: 0048                     L0001:
00008: 0048 E8 00000000                 CALL SHORT _isParameterValuesChanged
00008: 004D 83 F8 00                    CMP EAX, 00000000
00008: 0050 74 53                       JE L0003

; 66: 		parameterValuesArray=_newDoubleArray(parameterNamesCount);

00008: 0052 A1 00000000                 MOV EAX, DWORD PTR _parameterNamesCount
00008: 0057 50                          PUSH EAX
00008: 0058 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 005B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 005E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0060 FF 96 000002D8              CALL DWORD PTR 000002D8[ESI], 00000008
00008: 0066 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 67: 		_setDoubleArrayElements(parameterValuesArray,getInputParameterValues(),parameterNamesCount);

00008: 0069 E8 00000000                 CALL SHORT _getInputParameterValues
00008: 006E 50                          PUSH EAX
00008: 006F A1 00000000                 MOV EAX, DWORD PTR _parameterNamesCount
00008: 0074 50                          PUSH EAX
00008: 0075 6A 00                       PUSH 00000000
00008: 0077 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 007A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0080 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0082 FF 96 00000358              CALL DWORD PTR 00000358[ESI], 00000014

; 68: 		_setArray(inputParameterValuesID,parameterValuesArray);

00008: 0088 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 008B A1 00000000                 MOV EAX, DWORD PTR _inputParameterValuesID
00008: 0090 50                          PUSH EAX
00008: 0091 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0096 50                          PUSH EAX
00008: 0097 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 009A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 009F FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 69: 	}

00008: 00A5                     L0003:
00008: 00A5                     L0002:

; 70: }

00000: 00A5                     L0000:
00000: 00A5                             epilog 
00000: 00A5 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00A8 5E                          POP ESI
00000: 00A9 5D                          POP EBP
00000: 00AA C3                          RETN 
