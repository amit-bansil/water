
Function: _linkDisplay

; 9: void linkDisplay(JNIEnv *env,jobject display){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 10: 	jclass cls=(*env)->GetObjectClass(env,display);

00008: 0013 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0016 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0019 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001E FF 56 7C                    CALL DWORD PTR 0000007C[ESI], 00000008
00008: 0021 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 11: 	displayObj=obj=_getObjGlobal(display); 

00008: 0024 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0027 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 002A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 002D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002F FF 56 54                    CALL DWORD PTR 00000054[ESI], 00000008
00008: 0032 A3 00000000                 MOV DWORD PTR _obj, EAX
00008: 0037 8B 15 00000000              MOV EDX, DWORD PTR _obj
00008: 003D 89 15 00000000              MOV DWORD PTR _displayObj, EDX

; 13: 	firstBondChangedID=_getIntID("firstChangedBond");

00008: 0043 68 00000000                 PUSH OFFSET @5
00008: 0048 68 00000000                 PUSH OFFSET @6
00008: 004D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0050 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0053 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0056 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0058 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 005E A3 00000000                 MOV DWORD PTR _firstBondChangedID, EAX

; 14: 	firstPositionChangedID=_getIntID("firstChangedPosition");

00008: 0063 68 00000000                 PUSH OFFSET @5
00008: 0068 68 00000000                 PUSH OFFSET @7
00008: 006D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0070 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0073 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0076 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0078 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 007E A3 00000000                 MOV DWORD PTR _firstPositionChangedID, EAX

; 15: 	firstVelocityChangedID=_getIntID("firstChangedVelocity");

00008: 0083 68 00000000                 PUSH OFFSET @5
00008: 0088 68 00000000                 PUSH OFFSET @8
00008: 008D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0090 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0098 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 009E A3 00000000                 MOV DWORD PTR _firstVelocityChangedID, EAX

; 16: 	lastBondChangedID=_getIntID("lastChangedBond");

00008: 00A3 68 00000000                 PUSH OFFSET @5
00008: 00A8 68 00000000                 PUSH OFFSET @9
00008: 00AD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00B8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00BE A3 00000000                 MOV DWORD PTR _lastBondChangedID, EAX

; 17: 	lastPositionChangedID=_getIntID("lastChangedPosition");

00008: 00C3 68 00000000                 PUSH OFFSET @5
00008: 00C8 68 00000000                 PUSH OFFSET @10
00008: 00CD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00D0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00DE A3 00000000                 MOV DWORD PTR _lastPositionChangedID, EAX

; 18: 	lastVelocityChangedID=_getIntID("lastChangedVelocity");

00008: 00E3 68 00000000                 PUSH OFFSET @5
00008: 00E8 68 00000000                 PUSH OFFSET @11
00008: 00ED FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00F3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00F8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 00FE A3 00000000                 MOV DWORD PTR _lastVelocityChangedID, EAX

; 20: 	bondsID=_getIntArrayID("bonds");

00008: 0103 68 00000000                 PUSH OFFSET @12
00008: 0108 68 00000000                 PUSH OFFSET @13
00008: 010D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0110 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0113 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0116 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0118 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 011E A3 00000000                 MOV DWORD PTR _bondsID, EAX

; 21: 	positionsID=_getFloatArrayID("positions");

00008: 0123 68 00000000                 PUSH OFFSET @14
00008: 0128 68 00000000                 PUSH OFFSET @15
00008: 012D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0130 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0133 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0136 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0138 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 013E A3 00000000                 MOV DWORD PTR _positionsID, EAX

; 22: 	velocitiesID=_getFloatArrayID("velocities");

00008: 0143 68 00000000                 PUSH OFFSET @14
00008: 0148 68 00000000                 PUSH OFFSET @16
00008: 014D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0150 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0153 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0156 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0158 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 015E A3 00000000                 MOV DWORD PTR _velocitiesID, EAX

; 23: 	numAtomsID=_getIntID("numAtoms");

00008: 0163 68 00000000                 PUSH OFFSET @5
00008: 0168 68 00000000                 PUSH OFFSET @17
00008: 016D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0170 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0173 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0176 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0178 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 017E A3 00000000                 MOV DWORD PTR _numAtomsID, EAX

; 24: 	numBondsID=_getIntID("bScanSize");

00008: 0183 68 00000000                 PUSH OFFSET @5
00008: 0188 68 00000000                 PUSH OFFSET @18
00008: 018D FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0190 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0193 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0196 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0198 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 019E A3 00000000                 MOV DWORD PTR _numBondsID, EAX

; 25: 	sizeID=_getFloatArrayID("size");

00008: 01A3 68 00000000                 PUSH OFFSET @14
00008: 01A8 68 00000000                 PUSH OFFSET @19
00008: 01AD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 01B0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01B6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01B8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 01BE A3 00000000                 MOV DWORD PTR _sizeID, EAX

; 26: 	numDimensionsID=_getIntID("numDimensions");

00008: 01C3 68 00000000                 PUSH OFFSET @5
00008: 01C8 68 00000000                 PUSH OFFSET @20
00008: 01CD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 01D0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01D6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 01D8 FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 01DE A3 00000000                 MOV DWORD PTR _numDimensionsID, EAX

; 27: }

00000: 01E3                     L0000:
00000: 01E3                             epilog 
00000: 01E3 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 01E6 5E                          POP ESI
00000: 01E7 5D                          POP EBP
00000: 01E8 C3                          RETN 

Function: _unlinkDisplay

; 28: void unlinkDisplay(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 29: 	_relObjGlobal(displayObj);

00008: 0004 A1 00000000                 MOV EAX, DWORD PTR _displayObj
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

Function: _updatePositions

; 31: void updatePositions(JNIEnv *env){

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

; 32: 	jfloatArray positions=_getArray(positionsID);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _positionsID
00008: 001B 50                          PUSH EAX
00008: 001C A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0021 50                          PUSH EAX
00008: 0022 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0025 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0028 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002A FF 96 0000017C              CALL DWORD PTR 0000017C[ESI], 0000000C
00008: 0030 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 35: 	if(positions==NULL||isMaxAtomsChanged()){

00008: 0033 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0037 74 0A                       JE L0001
00008: 0039 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003E 83 F8 00                    CMP EAX, 00000000
00008: 0041 74 48                       JE L0002
00008: 0043                     L0001:

; 36: 		positions=_newFloatArray(getMaxAtoms()*3);

00008: 0043 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0048 8D 04 40                    LEA EAX, DWORD PTR 00000000[EAX][EAX*2]
00008: 004B 50                          PUSH EAX
00008: 004C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0052 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0054 FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 005A 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 37: 		start=0;

00008: 005D C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 38: 		end=getMaxAtoms();

00008: 0064 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0069 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 39: 		_setArray(positionsID,positions);

00008: 006C FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 006F A1 00000000                 MOV EAX, DWORD PTR _positionsID
00008: 0074 50                          PUSH EAX
00008: 0075 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 007A 50                          PUSH EAX
00008: 007B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0081 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0083 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 40: 	}else{

00008: 0089 EB 10                       JMP L0003
00008: 008B                     L0002:

; 41: 		start=getFirstAtomNumChanged();

00008: 008B E8 00000000                 CALL SHORT _getFirstAtomNumChanged
00008: 0090 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 42: 		end=getLastAtomNumChanged();

00008: 0093 E8 00000000                 CALL SHORT _getLastAtomNumChanged
00008: 0098 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 43: 	}

00008: 009B                     L0003:

; 44: 	buf=_getArrayCrit(positions);

00008: 009B 6A 00                       PUSH 00000000
00008: 009D FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00A0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00A8 FF 96 00000378              CALL DWORD PTR 00000378[ESI], 0000000C
00008: 00AE 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 45: 	getPositions(start,end,buf);

00008: 00B1 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00B4 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B7 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00BA E8 00000000                 CALL SHORT _getPositions
00008: 00BF 83 C4 0C                    ADD ESP, 0000000C

; 46: 	_relArrayCrit(positions,buf);

00008: 00C2 6A 00                       PUSH 00000000
00008: 00C4 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00C7 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00CA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00CD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D0 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D2 FF 96 0000037C              CALL DWORD PTR 0000037C[ESI], 00000010

; 48: 	_setInt(firstPositionChangedID,start);

00008: 00D8 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00DB A1 00000000                 MOV EAX, DWORD PTR _firstPositionChangedID
00008: 00E0 50                          PUSH EAX
00008: 00E1 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00E6 50                          PUSH EAX
00008: 00E7 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00EA 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00ED 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00EF FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 49: 	_setInt(lastPositionChangedID,end);

00008: 00F5 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F8 A1 00000000                 MOV EAX, DWORD PTR _lastPositionChangedID
00008: 00FD 50                          PUSH EAX
00008: 00FE A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0103 50                          PUSH EAX
00008: 0104 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0107 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 010A 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 010C FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 50: }

00000: 0112                     L0000:
00000: 0112                             epilog 
00000: 0112 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0115 5E                          POP ESI
00000: 0116 5D                          POP EBP
00000: 0117 C3                          RETN 

Function: _updateVelocities

; 51: void updateVelocities(JNIEnv *env){

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

; 52: 	jfloatArray velocities=_getArray(velocitiesID);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _velocitiesID
00008: 001B 50                          PUSH EAX
00008: 001C A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0021 50                          PUSH EAX
00008: 0022 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0025 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0028 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002A FF 96 0000017C              CALL DWORD PTR 0000017C[ESI], 0000000C
00008: 0030 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 55: 	if(velocities==NULL||isMaxAtomsChanged()){

00008: 0033 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0037 74 0A                       JE L0001
00008: 0039 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003E 83 F8 00                    CMP EAX, 00000000
00008: 0041 74 48                       JE L0002
00008: 0043                     L0001:

; 56: 		velocities=_newFloatArray(getMaxAtoms()*3);

00008: 0043 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0048 8D 04 40                    LEA EAX, DWORD PTR 00000000[EAX][EAX*2]
00008: 004B 50                          PUSH EAX
00008: 004C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 004F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0052 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0054 FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 005A 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 57: 		start=0;

00008: 005D C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 58: 		end=getMaxAtoms();

00008: 0064 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 0069 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 59: 		_setArray(velocitiesID,velocities);

00008: 006C FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 006F A1 00000000                 MOV EAX, DWORD PTR _velocitiesID
00008: 0074 50                          PUSH EAX
00008: 0075 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 007A 50                          PUSH EAX
00008: 007B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 007E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0081 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0083 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 60: 	}else{

00008: 0089 EB 10                       JMP L0003
00008: 008B                     L0002:

; 61: 		start=getFirstAtomNumChanged();

00008: 008B E8 00000000                 CALL SHORT _getFirstAtomNumChanged
00008: 0090 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 62: 		end=getLastAtomNumChanged();

00008: 0093 E8 00000000                 CALL SHORT _getLastAtomNumChanged
00008: 0098 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 63: 	}

00008: 009B                     L0003:

; 64: 	buf=_getArrayCrit(velocities);

00008: 009B 6A 00                       PUSH 00000000
00008: 009D FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00A0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00A8 FF 96 00000378              CALL DWORD PTR 00000378[ESI], 0000000C
00008: 00AE 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 65: 	getVelocities(start,end,buf);

00008: 00B1 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00B4 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00B7 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00BA E8 00000000                 CALL SHORT _getVelocities
00008: 00BF 83 C4 0C                    ADD ESP, 0000000C

; 66: 	_relArrayCrit(velocities,buf);

00008: 00C2 6A 00                       PUSH 00000000
00008: 00C4 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00C7 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00CA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00CD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00D0 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00D2 FF 96 0000037C              CALL DWORD PTR 0000037C[ESI], 00000010

; 68: 	_setInt(firstVelocityChangedID,start);

00008: 00D8 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00DB A1 00000000                 MOV EAX, DWORD PTR _firstVelocityChangedID
00008: 00E0 50                          PUSH EAX
00008: 00E1 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00E6 50                          PUSH EAX
00008: 00E7 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00EA 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00ED 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00EF FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 69: 	_setInt(lastVelocityChangedID,end);

00008: 00F5 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00F8 A1 00000000                 MOV EAX, DWORD PTR _lastVelocityChangedID
00008: 00FD 50                          PUSH EAX
00008: 00FE A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0103 50                          PUSH EAX
00008: 0104 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0107 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 010A 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 010C FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 70: }

00000: 0112                     L0000:
00000: 0112                             epilog 
00000: 0112 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0115 5E                          POP ESI
00000: 0116 5D                          POP EBP
00000: 0117 C3                          RETN 

Function: _updateBonds

; 71: void updateBonds(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 10                    SUB ESP, 00000010
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 5F                          POP EDI
00000: 0017                             prolog 

; 72: 	jintArray bonds=_getArray(bondsID);

00008: 0017 A1 00000000                 MOV EAX, DWORD PTR _bondsID
00008: 001C 50                          PUSH EAX
00008: 001D A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0022 50                          PUSH EAX
00008: 0023 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0026 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0029 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 002B FF 96 0000017C              CALL DWORD PTR 0000017C[ESI], 0000000C
00008: 0031 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 75: 	if(bonds==NULL||isMaxAtomsChanged()||isBScanSizeChanged()){

00008: 0034 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0038 74 14                       JE L0001
00008: 003A E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 003F 83 F8 00                    CMP EAX, 00000000
00008: 0042 75 0A                       JNE L0001
00008: 0044 E8 00000000                 CALL SHORT _isBScanSizeChanged
00008: 0049 83 F8 00                    CMP EAX, 00000000
00008: 004C 74 4F                       JE L0002
00008: 004E                     L0001:

; 76: 		bonds=_newIntArray(getMaxAtoms()*getBScanSize());

00008: 004E E8 00000000                 CALL SHORT _getBScanSize
00008: 0053 89 C3                       MOV EBX, EAX
00008: 0055 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 005A 0F AF D8                    IMUL EBX, EAX
00008: 005D 53                          PUSH EBX
00008: 005E FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0061 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0064 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0066 FF 96 000002CC              CALL DWORD PTR 000002CC[ESI], 00000008
00008: 006C 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 77: 		start=0;

00008: 006F C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 78: 		end=getMaxAtoms();

00008: 0076 E8 00000000                 CALL SHORT _getMaxAtoms
00008: 007B 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 79: 		_setArray(bondsID,bonds);

00008: 007E FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0081 A1 00000000                 MOV EAX, DWORD PTR _bondsID
00008: 0086 50                          PUSH EAX
00008: 0087 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 008C 50                          PUSH EAX
00008: 008D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0090 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0093 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0095 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 80: 	}else{

00008: 009B EB 10                       JMP L0003
00008: 009D                     L0002:

; 81: 		start=getFirstBondNumChanged();

00008: 009D E8 00000000                 CALL SHORT _getFirstBondNumChanged
00008: 00A2 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 82: 		end=getLastBondNumChanged();

00008: 00A5 E8 00000000                 CALL SHORT _getLastBondNumChanged
00008: 00AA 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 83: 	}

00008: 00AD                     L0003:

; 84: 	buf=_getArrayCrit(bonds);

00008: 00AD 6A 00                       PUSH 00000000
00008: 00AF FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 00B2 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00B5 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B8 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00BA FF 96 00000378              CALL DWORD PTR 00000378[ESI], 0000000C
00008: 00C0 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 85: 	getBonds(start,end,buf);

00008: 00C3 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00C6 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00C9 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00CC E8 00000000                 CALL SHORT _getBonds
00008: 00D1 83 C4 0C                    ADD ESP, 0000000C

; 86: 	_relArrayCrit(bonds,buf);

00008: 00D4 6A 00                       PUSH 00000000
00008: 00D6 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00D9 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 00DC FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00DF 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00E2 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00E4 FF 96 0000037C              CALL DWORD PTR 0000037C[ESI], 00000010

; 88: 	_setInt(firstBondChangedID,start);

00008: 00EA FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00ED A1 00000000                 MOV EAX, DWORD PTR _firstBondChangedID
00008: 00F2 50                          PUSH EAX
00008: 00F3 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00F8 50                          PUSH EAX
00008: 00F9 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00FC 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00FF 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0101 FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 90: }

00000: 0107                     L0000:
00000: 0107                             epilog 
00000: 0107 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 010A 5E                          POP ESI
00000: 010B 5B                          POP EBX
00000: 010C 5D                          POP EBP
00000: 010D C3                          RETN 

Function: _updateSize

; 92: void updateSize(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 93: 	jfloatArray size=_newFloatArray(3);

00008: 0013 6A 03                       PUSH 00000003
00008: 0015 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0018 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001B 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001D FF 96 000002D4              CALL DWORD PTR 000002D4[ESI], 00000008
00008: 0023 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 94: 	_setFloatArrayElements(size,getSize(),3);

00008: 0026 E8 00000000                 CALL SHORT _getSize
00008: 002B 50                          PUSH EAX
00008: 002C 6A 03                       PUSH 00000003
00008: 002E 6A 00                       PUSH 00000000
00008: 0030 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0033 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0036 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0039 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 003B FF 96 00000354              CALL DWORD PTR 00000354[ESI], 00000014

; 95: 	_setArray(sizeID,size);

00008: 0041 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0044 A1 00000000                 MOV EAX, DWORD PTR _sizeID
00008: 0049 50                          PUSH EAX
00008: 004A A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 004F 50                          PUSH EAX
00008: 0050 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0053 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0056 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0058 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 96: }

00000: 005E                     L0000:
00000: 005E                             epilog 
00000: 005E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0061 5E                          POP ESI
00000: 0062 5D                          POP EBP
00000: 0063 C3                          RETN 

Function: _updateDisplay

; 97: void updateDisplay(JNIEnv *env){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004                             prolog 

; 98: 	obj=displayObj;

00008: 0004 8B 15 00000000              MOV EDX, DWORD PTR _displayObj
00008: 000A 89 15 00000000              MOV DWORD PTR _obj, EDX

; 100: 	if(isPositionsChanged()||isMaxAtomsChanged()){

00008: 0010 E8 00000000                 CALL SHORT _isPositionsChanged
00008: 0015 83 F8 00                    CMP EAX, 00000000
00008: 0018 75 0A                       JNE L0001
00008: 001A E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 001F 83 F8 00                    CMP EAX, 00000000
00008: 0022 74 09                       JE L0002
00008: 0024                     L0001:

; 101: 		updatePositions(env);

00008: 0024 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0027 E8 00000000                 CALL SHORT _updatePositions
00008: 002C 59                          POP ECX

; 102: 	}

00008: 002D                     L0002:

; 103: 	if(isBondsChanged()||isMaxBondsChanged()){

00008: 002D E8 00000000                 CALL SHORT _isBondsChanged
00008: 0032 83 F8 00                    CMP EAX, 00000000
00008: 0035 75 0A                       JNE L0003
00008: 0037 E8 00000000                 CALL SHORT _isMaxBondsChanged
00008: 003C 83 F8 00                    CMP EAX, 00000000
00008: 003F 74 09                       JE L0004
00008: 0041                     L0003:

; 104: 		updateBonds(env);

00008: 0041 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0044 E8 00000000                 CALL SHORT _updateBonds
00008: 0049 59                          POP ECX

; 105: 	}

00008: 004A                     L0004:

; 106: 	if(isVelocitiesChanged()||isMaxAtomsChanged()){

00008: 004A E8 00000000                 CALL SHORT _isVelocitiesChanged
00008: 004F 83 F8 00                    CMP EAX, 00000000
00008: 0052 75 0A                       JNE L0005
00008: 0054 E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 0059 83 F8 00                    CMP EAX, 00000000
00008: 005C 74 09                       JE L0006
00008: 005E                     L0005:

; 107: 		updateVelocities(env);

00008: 005E FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0061 E8 00000000                 CALL SHORT _updateVelocities
00008: 0066 59                          POP ECX

; 108: 	}

00008: 0067                     L0006:

; 109: 	if(isSizeChanged()){

00008: 0067 E8 00000000                 CALL SHORT _isSizeChanged
00008: 006C 83 F8 00                    CMP EAX, 00000000
00008: 006F 74 09                       JE L0007

; 110: 		updateSize(env);

00008: 0071 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0074 E8 00000000                 CALL SHORT _updateSize
00008: 0079 59                          POP ECX

; 111: 	}

00008: 007A                     L0007:

; 112: 	if(isNumAtomsChanged()){

00008: 007A E8 00000000                 CALL SHORT _isNumAtomsChanged
00008: 007F 83 F8 00                    CMP EAX, 00000000
00008: 0082 74 20                       JE L0008

; 113: 		_setInt(numAtomsID,getNumAtoms());

00008: 0084 E8 00000000                 CALL SHORT _getNumAtoms
00008: 0089 50                          PUSH EAX
00008: 008A A1 00000000                 MOV EAX, DWORD PTR _numAtomsID
00008: 008F 50                          PUSH EAX
00008: 0090 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 0095 50                          PUSH EAX
00008: 0096 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0099 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 009E FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 114: 	}

00008: 00A4                     L0008:

; 115: 	if(isBScanSizeChanged()){

00008: 00A4 E8 00000000                 CALL SHORT _isBScanSizeChanged
00008: 00A9 83 F8 00                    CMP EAX, 00000000
00008: 00AC 74 20                       JE L0009

; 116: 		_setInt(numBondsID,getBScanSize());

00008: 00AE E8 00000000                 CALL SHORT _getBScanSize
00008: 00B3 50                          PUSH EAX
00008: 00B4 A1 00000000                 MOV EAX, DWORD PTR _numBondsID
00008: 00B9 50                          PUSH EAX
00008: 00BA A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00BF 50                          PUSH EAX
00008: 00C0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00C3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00C6 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00C8 FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 117: 	}

00008: 00CE                     L0009:

; 118: 	if(isNumDimensionsChanged()){

00008: 00CE E8 00000000                 CALL SHORT _isNumDimensionsChanged
00008: 00D3 83 F8 00                    CMP EAX, 00000000
00008: 00D6 74 20                       JE L000A

; 119: 		_setInt(numDimensionsID,getNumDimensions());

00008: 00D8 E8 00000000                 CALL SHORT _getNumDimensions
00008: 00DD 50                          PUSH EAX
00008: 00DE A1 00000000                 MOV EAX, DWORD PTR _numDimensionsID
00008: 00E3 50                          PUSH EAX
00008: 00E4 A1 00000000                 MOV EAX, DWORD PTR _obj
00008: 00E9 50                          PUSH EAX
00008: 00EA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00ED 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F0 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 00F2 FF 96 000001B4              CALL DWORD PTR 000001B4[ESI], 00000010

; 120: 	}

00008: 00F8                     L000A:

; 121: }

00000: 00F8                     L0000:
00000: 00F8                             epilog 
00000: 00F8 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00FB 5E                          POP ESI
00000: 00FC 5D                          POP EBP
00000: 00FD C3                          RETN 
