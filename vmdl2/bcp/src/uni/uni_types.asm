
Function: _linkTypes

; 10: void linkTypes(JNIEnv *env,jobject types){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 11: 	jclass cls=(*env)->GetObjectClass(env,types);

00008: 0013 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0016 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0019 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001E FF 56 7C                    CALL DWORD PTR 0000007C[ESI], 00000008
00008: 0021 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 12: 	typesObj=obj=_getObjGlobal(types);  

00008: 0024 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0027 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 002A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 002D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002F FF 56 54                    CALL DWORD PTR 00000054[ESI], 00000008
00008: 0032 A3 00000000                 MOV DWORD PTR _obj, EAX
00008: 0037 8B 15 00000000              MOV EDX, DWORD PTR _obj
00008: 003D 89 15 00000000              MOV DWORD PTR _typesObj, EDX

; 14: 	atomColorsID=_getFloatArrayID("atomTypeColors");

00008: 0043 68 00000000                 PUSH OFFSET @5
00008: 0048 68 00000000                 PUSH OFFSET @6
00008: 004D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0050 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0053 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0056 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0058 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 005E A3 00000000                 MOV DWORD PTR _atomColorsID, EAX

; 15: 	bondColorsID=_getFloatArrayID("bondTypeColors");

00008: 0063 68 00000000                 PUSH OFFSET @5
00008: 0068 68 00000000                 PUSH OFFSET @7
00008: 006D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0070 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0073 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0076 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0078 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 007E A3 00000000                 MOV DWORD PTR _bondColorsID, EAX

; 16: 	bondOrdersID=_getIntArrayID("bondOrders");

00008: 0083 68 00000000                 PUSH OFFSET @8
00008: 0088 68 00000000                 PUSH OFFSET @9
00008: 008D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0090 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0098 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 009E A3 00000000                 MOV DWORD PTR _bondOrdersID, EAX

; 17: 	atomRadiiID=_getFloatArrayID("atomTypeRadii");

00008: 00A3 68 00000000                 PUSH OFFSET @5
00008: 00A8 68 00000000                 PUSH OFFSET @10
00008: 00AD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00B8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00BE A3 00000000                 MOV DWORD PTR _atomRadiiID, EAX

; 18: 	bondRadiiID=_getFloatArrayID("bondTypeRadii");

00008: 00C3 68 00000000                 PUSH OFFSET @5
00008: 00C8 68 00000000                 PUSH OFFSET @11
00008: 00CD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00D0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00DE A3 00000000                 MOV DWORD PTR _bondRadiiID, EAX

; 19: 	atomElementsID=_getCharArrayID("atomTypeElements");

00008: 00E3 68 00000000                 PUSH OFFSET @12
00008: 00E8 68 00000000                 PUSH OFFSET @13
00008: 00ED FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00F3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00F8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00FE A3 00000000                 MOV DWORD PTR _atomElementsID, EAX

; 20: 	firstAtomChangedID=_getIntID("firstAtomTypeChanged");

00008: 0103 68 00000000                 PUSH OFFSET @14
00008: 0108 68 00000000                 PUSH OFFSET @15
00008: 010D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0110 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0113 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0116 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0118 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 011E A3 00000000                 MOV DWORD PTR _firstAtomChangedID, EAX

; 21: 	firstBondChangedID=_getIntID("firstBondTypeChanged");

00008: 0123 68 00000000                 PUSH OFFSET @14
00008: 0128 68 00000000                 PUSH OFFSET @16
00008: 012D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0130 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0133 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0136 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0138 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 013E A3 00000000                 MOV DWORD PTR _firstBondChangedID, EAX

; 22: 	lastAtomChangedID=_getIntID("lastAtomTypeChanged");

00008: 0143 68 00000000                 PUSH OFFSET @14
00008: 0148 68 00000000                 PUSH OFFSET @17
00008: 014D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0150 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0153 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0156 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0158 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 015E A3 00000000                 MOV DWORD PTR _lastAtomChangedID, EAX

; 23: 	lastBondChangedID=_getIntID("lastBondTypeChanged");

00008: 0163 68 00000000                 PUSH OFFSET @14
00008: 0168 68 00000000                 PUSH OFFSET @18
00008: 016D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0170 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0173 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0176 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0178 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 017E A3 00000000                 MOV DWORD PTR _lastBondChangedID, EAX

; 24: 	atomDescsID=_getStrArrayID("atomTypeDescriptions");

00008: 0183 68 00000000                 PUSH OFFSET @19
00008: 0188 68 00000000                 PUSH OFFSET @20
00008: 018D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0190 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0193 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0196 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0198 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 019E A3 00000000                 MOV DWORD PTR _atomDescsID, EAX

; 25: 	bondTypesID=_getIntArrayID("bondTypes");

00008: 01A3 68 00000000                 PUSH OFFSET @8
00008: 01A8 68 00000000                 PUSH OFFSET @21
00008: 01AD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 01B0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01B6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01B8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 01BE A3 00000000                 MOV DWORD PTR _bondTypesID, EAX

; 26: 	atomTypesID=_getIntArrayID("atomTypes");

00008: 01C3 68 00000000                 PUSH OFFSET @8
00008: 01C8 68 00000000                 PUSH OFFSET @22
00008: 01CD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 01D0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01D6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01D8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 01DE A3 00000000                 MOV DWORD PTR _atomTypesID, EAX

; 27: }

00000: 01E3                     L0000:
00000: 01E3                             epilog 
00000: 01E3 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 01E6 5E                          POP ESI
00000: 01E7 5D                          POP EBP
00000: 01E8 C3                          RETN 

Function: _unlinkTypes

; 28: void unlinkTypes(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 29: 	_relObjGlobal(typesObj);

00008: 0004 A1 00000000                 MOV EAX, DWORD PTR _typesObj
00008: 0009 50                          PUSH EAX
00008: 000A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 000D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0010 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0012 FF 56 58                    CALL DWORD PTR 00000058[ESI], 00000008

; 30: }

00000: 0015                     L0000:
00000: 0015                             epilog 
00000: 0015 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0018 5E                          POP ESI
00000: 0019 5D                          POP EBP
00000: 001A C3                          RETN 

Function: _updateBondTypeDescs

; 32: void updateBondTypeDescs(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 38                    SUB ESP, 00000038
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 B9 0000000E                 MOV ECX, 0000000E
00000: 0017 F3 AB                       REP STOSD 
00000: 0019 5F                          POP EDI
00000: 001A                             prolog 

; 34: 	const int count=getNumBondTypeDescriptions();

00008: 001A E8 00000000                 CALL SHORT _getNumBondTypeDescriptions
00008: 001F 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 35: 	float *colors=malloc(sizeof(float)*count*3),

00008: 0022 8B 5D FFFFFFC8              MOV EBX, DWORD PTR FFFFFFC8[EBP]
00008: 0025 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 002C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 002F 53                          PUSH EBX
00008: 0030 E8 00000000                 CALL SHORT _malloc
00008: 0035 59                          POP ECX
00008: 0036 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX
00008: 0039 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 003C 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0043 52                          PUSH EDX
00008: 0044 E8 00000000                 CALL SHORT _malloc
00008: 0049 59                          POP ECX
00008: 004A 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 37: 	long *orders=malloc(sizeof(long)*count);

00008: 004D 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 0050 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0057 52                          PUSH EDX
00008: 0058 E8 00000000                 CALL SHORT _malloc
00008: 005D 59                          POP ECX
00008: 005E 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 38: 	jfloatArray colorsArray=_newFloatArray(count*3);

00008: 0061 8B 5D FFFFFFC8              MOV EBX, DWORD PTR FFFFFFC8[EBP]
00008: 0064 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0067 53                          PUSH EBX
00008: 0068 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 006B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 006E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0070 FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 0076 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 39: 	jfloatArray radiiArray=_newFloatArray(count);

00008: 0079 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 007C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0082 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0084 FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 008A 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 40: 	jintArray ordersArray=_newIntArray(count);

00008: 008D FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 0090 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0098 FF 96 000002CC              CALL DWORD PTR 000002CC[ESI], 00000008
00008: 009E 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 44: 	for(i=0;i<count;i++){

00008: 00A1 C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 00A8 EB 5A                       JMP L0001
00008: 00AA                     L0002:

; 45: 		b=getBondTypeDescription(i);

00008: 00AA FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 00AD 8D 45 FFFFFFE4              LEA EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00B0 50                          PUSH EAX
00008: 00B1 E8 00000000                 CALL SHORT _getBondTypeDescription
00008: 00B6 59                          POP ECX
00008: 00B7 59                          POP ECX

; 46: 		orders[i]=b.order;

00008: 00B8 8B 5D FFFFFFE4              MOV EBX, DWORD PTR FFFFFFE4[EBP]
00008: 00BB 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 00BE 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 00C1 89 1C 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EBX

; 47: 		colors[i*3]=b.r;

00008: 00C4 8B 5D FFFFFFC4              MOV EBX, DWORD PTR FFFFFFC4[EBP]
00008: 00C7 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00CA 8B 75 FFFFFFE8              MOV ESI, DWORD PTR FFFFFFE8[EBP]
00008: 00CD 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00D0 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 48: 		colors[i*3+1]=b.g;

00008: 00D3 8B 5D FFFFFFC4              MOV EBX, DWORD PTR FFFFFFC4[EBP]
00008: 00D6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00D9 43                          INC EBX
00008: 00DA 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 00DD 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00E0 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 49: 		colors[i*3+2]=b.b;

00008: 00E3 8B 5D FFFFFFC4              MOV EBX, DWORD PTR FFFFFFC4[EBP]
00008: 00E6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00E9 83 C3 02                    ADD EBX, 00000002
00008: 00EC 8B 75 FFFFFFF0              MOV ESI, DWORD PTR FFFFFFF0[EBP]
00008: 00EF 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00F2 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 50: 		radii[i]=b.radius;

00008: 00F5 8B 5D FFFFFFF4              MOV EBX, DWORD PTR FFFFFFF4[EBP]
00008: 00F8 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 00FB 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 00FE 89 1C 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EBX

; 51: 	}

00008: 0101 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 0104                     L0001:
00008: 0104 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0107 3B 45 FFFFFFC8              CMP EAX, DWORD PTR FFFFFFC8[EBP]
00008: 010A 7C FFFFFF9E                 JL L0002

; 52: 	_setFloatArrayElements(colorsArray,colors,count*3);

00008: 010C FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 010F 8B 5D FFFFFFC8              MOV EBX, DWORD PTR FFFFFFC8[EBP]
00008: 0112 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0115 53                          PUSH EBX
00008: 0116 6A 00                       PUSH 00000000
00008: 0118 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 011B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 011E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0121 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0123 FF 96 00000354              CALL DWORD PTR 00000354[ESI], 00000014

; 53: 	_setFloatArrayElements(radiiArray,radii,count);

00008: 0129 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 012C FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 012F 6A 00                       PUSH 00000000
00008: 0131 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 0134 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0137 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 013A 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 013C FF 96 00000354              CALL DWORD PTR 00000354[ESI], 00000014

; 54: 	_setIntArrayElements(ordersArray,orders,count);

00008: 0142 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0145 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 0148 6A 00                       PUSH 00000000
00008: 014A FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 014D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0150 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0153 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0155 FF 96 0000034C              CALL DWORD PTR 0000034C[ESI], 00000014

; 56: 	_setArray(bondOrdersID,ordersArray);

00008: 015B FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 015E A1 00000000                 MOV EAX, DWORD PTR _bondOrdersID
00008: 0163 50                          PUSH EAX
00008: 0164 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0169 50                          PUSH EAX
00008: 016A FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 016D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0170 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0172 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 57: 	_setArray(bondRadiiID,radiiArray);

00008: 0178 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 017B A1 00000000                 MOV EAX, DWORD PTR _bondRadiiID
00008: 0180 50                          PUSH EAX
00008: 0181 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0186 50                          PUSH EAX
00008: 0187 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 018A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 018D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 018F FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 58: 	_setArray(bondColorsID,colorsArray);

00008: 0195 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0198 A1 00000000                 MOV EAX, DWORD PTR _bondColorsID
00008: 019D 50                          PUSH EAX
00008: 019E A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 01A3 50                          PUSH EAX
00008: 01A4 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01A7 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01AA 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01AC FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 60: 	free(colors);

00008: 01B2 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 01B5 E8 00000000                 CALL SHORT _free
00008: 01BA 59                          POP ECX

; 61: 	free(radii);

00008: 01BB FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 01BE E8 00000000                 CALL SHORT _free
00008: 01C3 59                          POP ECX

; 62: 	free(orders);

00008: 01C4 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 01C7 E8 00000000                 CALL SHORT _free
00008: 01CC 59                          POP ECX

; 63: }

00000: 01CD                     L0000:
00000: 01CD                             epilog 
00000: 01CD 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 01D0 5E                          POP ESI
00000: 01D1 5B                          POP EBX
00000: 01D2 5D                          POP EBP
00000: 01D3 C3                          RETN 

Function: _updateAtomTypeDescs

; 64: void updateAtomTypeDescs(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 40                    SUB ESP, 00000040
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 B9 00000010                 MOV ECX, 00000010
00000: 0017 F3 AB                       REP STOSD 
00000: 0019 5F                          POP EDI
00000: 001A                             prolog 

; 65: 	_initStrClass();

00008: 001A 68 00000000                 PUSH OFFSET @45
00008: 001F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0022 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0025 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0027 FF 56 18                    CALL DWORD PTR 00000018[ESI], 00000008
00008: 002A 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 67: 	const int count=getNumAtomTypeDescriptions();

00008: 002D E8 00000000                 CALL SHORT _getNumAtomTypeDescriptions
00008: 0032 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX

; 68: 	float *colors=malloc(sizeof(float)*count*3),

00008: 0035 8B 5D FFFFFFC0              MOV EBX, DWORD PTR FFFFFFC0[EBP]
00008: 0038 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 003F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0042 53                          PUSH EBX
00008: 0043 E8 00000000                 CALL SHORT _malloc
00008: 0048 59                          POP ECX
00008: 0049 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX
00008: 004C 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 004F 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0056 52                          PUSH EDX
00008: 0057 E8 00000000                 CALL SHORT _malloc
00008: 005C 59                          POP ECX
00008: 005D 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 70: 	unsigned short *elements=malloc(sizeof(unsigned short)*count*2);

00008: 0060 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 0063 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 006A 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 0071 52                          PUSH EDX
00008: 0072 E8 00000000                 CALL SHORT _malloc
00008: 0077 59                          POP ECX
00008: 0078 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 73: 	jfloatArray colorsArray=_newFloatArray(count*3);

00008: 007B 8B 5D FFFFFFC0              MOV EBX, DWORD PTR FFFFFFC0[EBP]
00008: 007E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0081 53                          PUSH EBX
00008: 0082 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0085 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0088 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 008A FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 0090 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 74: 	jfloatArray radiiArray=_newFloatArray(count);

00008: 0093 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 0096 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0099 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 009E FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 00A4 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 75: 	jobjectArray descsArray=_newStrArray(count);

00008: 00A7 6A 00                       PUSH 00000000
00008: 00A9 FF 75 FFFFFFB8              PUSH DWORD PTR FFFFFFB8[EBP]
00008: 00AC FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 00AF FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00B2 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B5 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00B7 FF 96 000002B0              CALL DWORD PTR 000002B0[ESI], 00000010
00008: 00BD 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 76: 	jcharArray elementsArray=_newCharArray(count*2);

00008: 00C0 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 00C3 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00CA 52                          PUSH EDX
00008: 00CB FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00CE 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D1 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D3 FF 96 000002C4              CALL DWORD PTR 000002C4[ESI], 00000008
00008: 00D9 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 80: 	for(i=0;i<count;i++){

00008: 00DC C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000
00008: 00E3 E9 000000A0                 JMP L0001
00008: 00E8                     L0002:

; 81: 		b=getAtomTypeDescription(i);

00008: 00E8 FF 75 FFFFFFBC              PUSH DWORD PTR FFFFFFBC[EBP]
00008: 00EB 8D 45 FFFFFFE0              LEA EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00EE 50                          PUSH EAX
00008: 00EF E8 00000000                 CALL SHORT _getAtomTypeDescription
00008: 00F4 59                          POP ECX
00008: 00F5 59                          POP ECX

; 82: 		colors[i*3]=b.r;

00008: 00F6 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 00F9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00FC 8B 75 FFFFFFE0              MOV ESI, DWORD PTR FFFFFFE0[EBP]
00008: 00FF 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0102 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 83: 		colors[i*3+1]=b.g;

00008: 0105 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0108 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 010B 43                          INC EBX
00008: 010C 8B 75 FFFFFFE4              MOV ESI, DWORD PTR FFFFFFE4[EBP]
00008: 010F 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0112 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 84: 		colors[i*3+2]=b.b;

00008: 0115 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0118 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 011B 83 C3 02                    ADD EBX, 00000002
00008: 011E 8B 75 FFFFFFE8              MOV ESI, DWORD PTR FFFFFFE8[EBP]
00008: 0121 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0124 89 34 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ESI

; 85: 		radii[i]=b.radius;

00008: 0127 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 012A 8B 4D FFFFFFBC              MOV ECX, DWORD PTR FFFFFFBC[EBP]
00008: 012D 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0130 89 1C 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EBX

; 86: 		elements[i*2]=b.e1;

00008: 0133 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0136 8D 1C 5D 00000000           LEA EBX, [00000000][EBX*2]
00008: 013D 0F BE 55 FFFFFFEC           MOVSX EDX, BYTE PTR FFFFFFEC[EBP]
00008: 0141 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0144 66 89 14 58                 MOV WORD PTR 00000000[EAX][EBX*2], DX

; 87: 		elements[(i*2)+1]=b.e2;

00008: 0148 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 014B 8D 1C 5D 00000000           LEA EBX, [00000000][EBX*2]
00008: 0152 43                          INC EBX
00008: 0153 0F BE 55 FFFFFFED           MOVSX EDX, BYTE PTR FFFFFFED[EBP]
00008: 0157 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 015A 66 89 14 58                 MOV WORD PTR 00000000[EAX][EBX*2], DX

; 89: 		_setStrArrayElement(descsArray,b.description,i);

00008: 015E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0161 50                          PUSH EAX
00008: 0162 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0165 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0168 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 016A FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 0170 50                          PUSH EAX
00008: 0171 FF 75 FFFFFFBC              PUSH DWORD PTR FFFFFFBC[EBP]
00008: 0174 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0177 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 017A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 017D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 017F FF 96 000002B8              CALL DWORD PTR 000002B8[ESI], 00000010

; 90: 	}

00008: 0185 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0188                     L0001:
00008: 0188 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 018B 3B 45 FFFFFFC0              CMP EAX, DWORD PTR FFFFFFC0[EBP]
00008: 018E 0F 8C FFFFFF54              JL L0002

; 92: 	_setFloatArrayElements(colorsArray,colors,count*3);

00008: 0194 FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 0197 8B 5D FFFFFFC0              MOV EBX, DWORD PTR FFFFFFC0[EBP]
00008: 019A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 019D 53                          PUSH EBX
00008: 019E 6A 00                       PUSH 00000000
00008: 01A0 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 01A3 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01A6 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01A9 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01AB FF 96 00000354              CALL DWORD PTR 00000354[ESI], 00000014

; 93: 	_setFloatArrayElements(radiiArray,radii,count);

00008: 01B1 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 01B4 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 01B7 6A 00                       PUSH 00000000
00008: 01B9 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 01BC FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01BF 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01C2 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01C4 FF 96 00000354              CALL DWORD PTR 00000354[ESI], 00000014

; 94: 	_setCharArrayElements(elementsArray,elements,count*2);

00008: 01CA FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 01CD 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 01D0 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 01D7 52                          PUSH EDX
00008: 01D8 6A 00                       PUSH 00000000
00008: 01DA FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 01DD FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01E0 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01E3 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01E5 FF 96 00000344              CALL DWORD PTR 00000344[ESI], 00000014

; 96: 	_setArray(atomElementsID,elementsArray);

00008: 01EB FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 01EE A1 00000000                 MOV EAX, DWORD PTR _atomElementsID
00008: 01F3 50                          PUSH EAX
00008: 01F4 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 01F9 50                          PUSH EAX
00008: 01FA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01FD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0200 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0202 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 97: 	_setArray(atomColorsID,colorsArray);

00008: 0208 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 020B A1 00000000                 MOV EAX, DWORD PTR _atomColorsID
00008: 0210 50                          PUSH EAX
00008: 0211 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0216 50                          PUSH EAX
00008: 0217 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 021A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 021D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 021F FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 98: 	_setArray(atomRadiiID,radiiArray);

00008: 0225 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0228 A1 00000000                 MOV EAX, DWORD PTR _atomRadiiID
00008: 022D 50                          PUSH EAX
00008: 022E A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0233 50                          PUSH EAX
00008: 0234 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0237 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 023A 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 023C FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 99: 	_setArray(atomDescsID,descsArray);

00008: 0242 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0245 A1 00000000                 MOV EAX, DWORD PTR _atomDescsID
00008: 024A 50                          PUSH EAX
00008: 024B A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0250 50                          PUSH EAX
00008: 0251 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0254 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0257 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0259 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 101: 	free(colors);

00008: 025F FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 0262 E8 00000000                 CALL SHORT _free
00008: 0267 59                          POP ECX

; 102: 	free(radii);

00008: 0268 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 026B E8 00000000                 CALL SHORT _free
00008: 0270 59                          POP ECX

; 103: 	free(elements);

00008: 0271 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0274 E8 00000000                 CALL SHORT _free
00008: 0279 59                          POP ECX

; 104: }

00000: 027A                     L0000:
00000: 027A                             epilog 
00000: 027A 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 027D 5E                          POP ESI
00000: 027E 5B                          POP EBX
00000: 027F 5D                          POP EBP
00000: 0280 C3                          RETN 

Function: _updateBondTypes

; 105: void updateBondTypes(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 10                    SUB ESP, 00000010
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 5F                          POP EDI
00000: 0016                             prolog 

; 106: 	jintArray bonds=_getArray(bondTypesID);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _bondTypesID
00008: 001B 50                          PUSH EAX
00008: 001C A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0021 50                          PUSH EAX
00008: 0022 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0025 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0028 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002A FF 96 0000017C              CALL DWORD PTR 0000017C[ESI], 0000000C
00008: 0030 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 110: 	if(bonds==NULL||isMaxAtomsChanged()){

00008: 0033 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0037 74 0A                       JE L0001
00008: 0039 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003E 83 F8 00                    CMP EAX, 00000000
00008: 0041 74 45                       JE L0002
00008: 0043                     L0001:

; 111: 		bonds=_newIntArray(getMaxAtoms());

00008: 0043 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0048 50                          PUSH EAX
00008: 0049 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 004F 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0051 FF 96 000002CC              CALL DWORD PTR 000002CC[ESI], 00000008
00008: 0057 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 112: 		start=0;

00008: 005A C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 113: 		end=getMaxAtoms();

00008: 0061 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0066 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 114: 		_setArray(bondTypesID,bonds);

00008: 0069 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 006C A1 00000000                 MOV EAX, DWORD PTR _bondTypesID
00008: 0071 50                          PUSH EAX
00008: 0072 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0077 50                          PUSH EAX
00008: 0078 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 007E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0080 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 115: 	}else{

00008: 0086 EB 10                       JMP L0003
00008: 0088                     L0002:

; 116: 		start=getFirstBondNumTypeChanged();

00008: 0088 E8 00000000                 CALL SHORT _getFirstBondNumTypeChanged
00008: 008D 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 117: 		end=getLastBondNumTypeChanged();		

00008: 0090 E8 00000000                 CALL SHORT _getLastBondNumTypeChanged
00008: 0095 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 118: 	}

00008: 0098                     L0003:

; 119: 	buf=_getArrayCrit(bonds);

00008: 0098 6A 00                       PUSH 00000000
00008: 009A FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 009D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A0 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A3 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00A5 FF 96 00000378              CALL DWORD PTR 00000378[ESI], 0000000C
00008: 00AB 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 120: 	getBondTypes(start,end,buf);

00008: 00AE FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00B1 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B4 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00B7 E8 00000000                 CALL SHORT _getBondTypes
00008: 00BC 83 C4 0C                    ADD ESP, 0000000C

; 121: 	_relArrayCrit(bonds,buf);

00008: 00BF 6A 00                       PUSH 00000000
00008: 00C1 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00C4 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00C7 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00CA 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00CD 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00CF FF 96 0000037C              CALL DWORD PTR 0000037C[ESI], 00000010

; 123: 	_setInt(firstBondChangedID,start);

00008: 00D5 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00D8 A1 00000000                 MOV EAX, DWORD PTR _firstBondChangedID
00008: 00DD 50                          PUSH EAX
00008: 00DE A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00E3 50                          PUSH EAX
00008: 00E4 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00E7 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00EA 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00EC FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 124: 	_setInt(lastBondChangedID,end);

00008: 00F2 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F5 A1 00000000                 MOV EAX, DWORD PTR _lastBondChangedID
00008: 00FA 50                          PUSH EAX
00008: 00FB A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0100 50                          PUSH EAX
00008: 0101 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0104 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0107 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0109 FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 125: }

00000: 010F                     L0000:
00000: 010F                             epilog 
00000: 010F 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0112 5E                          POP ESI
00000: 0113 5D                          POP EBP
00000: 0114 C3                          RETN 

Function: _updateAtomTypes

; 126: void updateAtomTypes(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 10                    SUB ESP, 00000010
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 5F                          POP EDI
00000: 0016                             prolog 

; 127: 	jintArray atoms=_getArray(atomTypesID);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _atomTypesID
00008: 001B 50                          PUSH EAX
00008: 001C A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0021 50                          PUSH EAX
00008: 0022 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0025 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0028 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002A FF 96 0000017C              CALL DWORD PTR 0000017C[ESI], 0000000C
00008: 0030 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 131: 	if(atoms==NULL||isMaxAtomsChanged()){

00008: 0033 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0037 74 0A                       JE L0001
00008: 0039 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003E 83 F8 00                    CMP EAX, 00000000
00008: 0041 74 45                       JE L0002
00008: 0043                     L0001:

; 132: 		atoms=_newIntArray(getMaxAtoms());

00008: 0043 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0048 50                          PUSH EAX
00008: 0049 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 004F 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0051 FF 96 000002CC              CALL DWORD PTR 000002CC[ESI], 00000008
00008: 0057 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 133: 		start=0;

00008: 005A C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 134: 		end=getMaxAtoms();

00008: 0061 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0066 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 135: 		_setArray(atomTypesID,atoms);

00008: 0069 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 006C A1 00000000                 MOV EAX, DWORD PTR _atomTypesID
00008: 0071 50                          PUSH EAX
00008: 0072 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0077 50                          PUSH EAX
00008: 0078 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 007E 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0080 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 136: 	}else{

00008: 0086 EB 10                       JMP L0003
00008: 0088                     L0002:

; 137: 		start=getFirstAtomNumTypeChanged();

00008: 0088 E8 00000000                 CALL SHORT _getFirstAtomNumTypeChanged
00008: 008D 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 138: 		end=getLastAtomNumTypeChanged();		

00008: 0090 E8 00000000                 CALL SHORT _getLastAtomNumTypeChanged
00008: 0095 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 139: 	}

00008: 0098                     L0003:

; 140: 	buf=_getArrayCrit(atoms);

00008: 0098 6A 00                       PUSH 00000000
00008: 009A FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 009D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A0 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A3 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00A5 FF 96 00000378              CALL DWORD PTR 00000378[ESI], 0000000C
00008: 00AB 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 141: 	getAtomTypes(start,end,buf);

00008: 00AE FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00B1 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B4 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00B7 E8 00000000                 CALL SHORT _getAtomTypes
00008: 00BC 83 C4 0C                    ADD ESP, 0000000C

; 142: 	_relArrayCrit(atoms,buf);

00008: 00BF 6A 00                       PUSH 00000000
00008: 00C1 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00C4 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00C7 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00CA 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00CD 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00CF FF 96 0000037C              CALL DWORD PTR 0000037C[ESI], 00000010

; 144: 	_setInt(firstAtomChangedID,start);

00008: 00D5 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00D8 A1 00000000                 MOV EAX, DWORD PTR _firstAtomChangedID
00008: 00DD 50                          PUSH EAX
00008: 00DE A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00E3 50                          PUSH EAX
00008: 00E4 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00E7 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00EA 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00EC FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 145: 	_setInt(lastAtomChangedID,end);

00008: 00F2 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F5 A1 00000000                 MOV EAX, DWORD PTR _lastAtomChangedID
00008: 00FA 50                          PUSH EAX
00008: 00FB A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0100 50                          PUSH EAX
00008: 0101 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0104 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0107 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0109 FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 146: }

00000: 010F                     L0000:
00000: 010F                             epilog 
00000: 010F 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0112 5E                          POP ESI
00000: 0113 5D                          POP EBP
00000: 0114 C3                          RETN 

Function: _updateTypes

; 147: void updateTypes(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 148: 	obj=typesObj;

00008: 0003 8B 15 00000000              MOV EDX, DWORD PTR _typesObj
00008: 0009 89 15 00000000              MOV DWORD PTR _obj, EDX

; 149: 	if(isTypeDescriptionsChanged()){

00008: 000F E8 00000000                 CALL SHORT _isTypeDescriptionsChanged
00008: 0014 83 F8 00                    CMP EAX, 00000000
00008: 0017 74 12                       JE L0001

; 150: 		updateAtomTypeDescs(env);

00008: 0019 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001C E8 00000000                 CALL SHORT _updateAtomTypeDescs
00008: 0021 59                          POP ECX

; 151: 		updateBondTypeDescs(env);

00008: 0022 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0025 E8 00000000                 CALL SHORT _updateBondTypeDescs
00008: 002A 59                          POP ECX

; 152: 	}

00008: 002B                     L0001:

; 153: 	if(isAtomTypesChanged()||isMaxAtomsChanged()){

00008: 002B E8 00000000                 CALL SHORT _isAtomTypesChanged
00008: 0030 83 F8 00                    CMP EAX, 00000000
00008: 0033 75 0A                       JNE L0002
00008: 0035 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003A 83 F8 00                    CMP EAX, 00000000
00008: 003D 74 09                       JE L0003
00008: 003F                     L0002:

; 154: 		updateAtomTypes(env);

00008: 003F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0042 E8 00000000                 CALL SHORT _updateAtomTypes
00008: 0047 59                          POP ECX

; 155: 	}

00008: 0048                     L0003:

; 156: 	if(isBondTypesChanged()||isMaxAtomsChanged()){

00008: 0048 E8 00000000                 CALL SHORT _isBondTypesChanged
00008: 004D 83 F8 00                    CMP EAX, 00000000
00008: 0050 75 0A                       JNE L0004
00008: 0052 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 0057 83 F8 00                    CMP EAX, 00000000
00008: 005A 74 09                       JE L0005
00008: 005C                     L0004:

; 157: 		updateBondTypes(env);

00008: 005C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 005F E8 00000000                 CALL SHORT _updateBondTypes
00008: 0064 59                          POP ECX

; 158: 	}

00008: 0065                     L0005:

; 159: }

00000: 0065                     L0000:
00000: 0065                             epilog 
00000: 0065 C9                          LEAVE 
00000: 0066 C3                          RETN 
