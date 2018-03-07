
Function: _bindDLL

; 31: void bindDLL(){}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 31: void bindDLL(){}

00000: 0003                     L0000:
00000: 0003                             epilog 
00000: 0003 C9                          LEAVE 
00000: 0004 C3                          RETN 

Function: _unbindDLL

; 32: void unbindDLL(){}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 32: void unbindDLL(){}

00000: 0003                     L0000:
00000: 0003                             epilog 
00000: 0003 C9                          LEAVE 
00000: 0004 C3                          RETN 

Function: _reset

; 39: void reset(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 40: 	CHANGE_FRAME=FALSE;

00008: 0003 C7 05 00000000 00000000     MOV DWORD PTR _CHANGE_FRAME, 00000000

; 41: 	CHANGE_PARAMS=FALSE;

00008: 000D C7 05 00000000 00000000     MOV DWORD PTR _CHANGE_PARAMS, 00000000

; 43: 	CHANGE_REACTION=FALSE;

00008: 0017 C7 05 00000000 00000000     MOV DWORD PTR _CHANGE_REACTION, 00000000

; 44: 	CHANGE_LOAD=FALSE;

00008: 0021 C7 05 00000000 00000000     MOV DWORD PTR _CHANGE_LOAD, 00000000

; 45: 	CHANGE_LINK=FALSE;

00008: 002B C7 05 00000000 00000000     MOV DWORD PTR _CHANGE_LINK, 00000000

; 46: }

00000: 0035                     L0000:
00000: 0035                             epilog 
00000: 0035 C9                          LEAVE 
00000: 0036 C3                          RETN 

Function: _isChanged

; 47: int isChanged(){return CHANGE_FRAME|CHANGE_PARAMS;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 47: int isChanged(){return CHANGE_FRAME|CHANGE_PARAMS;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_FRAME
00008: 0008 0B 05 00000000              OR EAX, DWORD PTR _CHANGE_PARAMS
00000: 000E                     L0000:
00000: 000E                             epilog 
00000: 000E C9                          LEAVE 
00000: 000F C3                          RETN 

Function: _isParametersChanged

; 49: int isParametersChanged(){return CHANGE_LINK;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 49: int isParametersChanged(){return CHANGE_LINK;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LINK
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isParameterValuesChanged

; 50: int isParameterValuesChanged(){return CHANGE_FRAME;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 50: int isParameterValuesChanged(){return CHANGE_FRAME;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_FRAME
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getFirstParameterChanged

; 51: int getFirstParameterChanged(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 52: 	if(CHANGE_LOAD) return 0;

00008: 0003 83 3D 00000000 00           CMP DWORD PTR _CHANGE_LOAD, 00000000
00008: 000A 74 07                       JE L0001
00008: 000C B8 00000000                 MOV EAX, 00000000
00000: 0011                             epilog 
00000: 0011 C9                          LEAVE 
00000: 0012 C3                          RETN 
00008: 0013                     L0001:

; 53: 	if(CHANGE_REACTION) return 0;

00008: 0013 83 3D 00000000 00           CMP DWORD PTR _CHANGE_REACTION, 00000000
00008: 001A 74 07                       JE L0002
00008: 001C B8 00000000                 MOV EAX, 00000000
00000: 0021                             epilog 
00000: 0021 C9                          LEAVE 
00000: 0022 C3                          RETN 
00008: 0023                     L0002:

; 54: 	if(CHANGE_PARAMS) return 0; //getNat();

00008: 0023 83 3D 00000000 00           CMP DWORD PTR _CHANGE_PARAMS, 00000000
00008: 002A 74 07                       JE L0003
00008: 002C B8 00000000                 MOV EAX, 00000000
00000: 0031                             epilog 
00000: 0031 C9                          LEAVE 
00000: 0032 C3                          RETN 
00008: 0033                     L0003:

; 55: }		

00000: 0033                     L0000:
00000: 0033                             epilog 
00000: 0033 C9                          LEAVE 
00000: 0034 C3                          RETN 

Function: _isInputParameterDescriptionsChanged

; 56: int isInputParameterDescriptionsChanged(){return CHANGE_LINK;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 56: int isInputParameterDescriptionsChanged(){return CHANGE_LINK;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LINK
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isNumAtomsChanged

; 57: int isNumAtomsChanged(){ return CHANGE_LOAD; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 57: int isNumAtomsChanged(){ return CHANGE_LOAD; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isBScanSizeChanged

; 58: int isBScanSizeChanged(){ return CHANGE_LOAD; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 58: int isBScanSizeChanged(){ return CHANGE_LOAD; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isBondTypesChanged

; 59: int isBondTypesChanged(){ return CHANGE_LOAD; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 59: int isBondTypesChanged(){ return CHANGE_LOAD; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isAtomTypesChanged

; 60: int isAtomTypesChanged(){ return CHANGE_REACTION; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 60: int isAtomTypesChanged(){ return CHANGE_REACTION; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_REACTION
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isPositionsChanged

; 61: int isPositionsChanged(){return CHANGE_FRAME; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 61: int isPositionsChanged(){return CHANGE_FRAME; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_FRAME
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isVelocitiesChanged

; 62: int isVelocitiesChanged(){return CHANGE_FRAME; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 62: int isVelocitiesChanged(){return CHANGE_FRAME; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_FRAME
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isBondsChanged

; 63: int isBondsChanged(){return CHANGE_REACTION;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 63: int isBondsChanged(){return CHANGE_REACTION;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_REACTION
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getLastAtomNumChanged

; 65: int getLastAtomNumChanged(){return getNumAtoms()-2;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 65: int getLastAtomNumChanged(){return getNumAtoms()-2;}

00008: 0003 E8 00000000                 CALL SHORT _getNumAtoms
00008: 0008 83 C0 FFFFFFFE              ADD EAX, FFFFFFFE
00008: 000B 89 C0                       MOV EAX, EAX
00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _getFirstAtomNumChanged

; 66: int getFirstAtomNumChanged(){return 0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 66: int getFirstAtomNumChanged(){return 0;}

00008: 0003 B8 00000000                 MOV EAX, 00000000
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getFirstBondNumChanged

; 67: int getFirstBondNumChanged(){return 0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 67: int getFirstBondNumChanged(){return 0;}

00008: 0003 B8 00000000                 MOV EAX, 00000000
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getLastBondNumChanged

; 68: int getLastBondNumChanged(){return getNumAtoms()-2;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 68: int getLastBondNumChanged(){return getNumAtoms()-2;}

00008: 0003 E8 00000000                 CALL SHORT _getNumAtoms
00008: 0008 83 C0 FFFFFFFE              ADD EAX, FFFFFFFE
00008: 000B 89 C0                       MOV EAX, EAX
00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _isMaxBondsChanged

; 69: int isMaxBondsChanged(){ return CHANGE_LOAD;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 69: int isMaxBondsChanged(){ return CHANGE_LOAD;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isMaxAtomsChanged

; 70: int isMaxAtomsChanged(){return CHANGE_LOAD;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 70: int isMaxAtomsChanged(){return CHANGE_LOAD;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isSizeChanged

; 72: int isSizeChanged(){return CHANGE_FRAME;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 72: int isSizeChanged(){return CHANGE_FRAME;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_FRAME
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getFirstBondNumTypeChanged

; 73: int getFirstBondNumTypeChanged(){return 0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 73: int getFirstBondNumTypeChanged(){return 0;}

00008: 0003 B8 00000000                 MOV EAX, 00000000
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getLastBondNumTypeChanged

; 74: int getLastBondNumTypeChanged(){return getNumAtoms()-2;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 74: int getLastBondNumTypeChanged(){return getNumAtoms()-2;}

00008: 0003 E8 00000000                 CALL SHORT _getNumAtoms
00008: 0008 83 C0 FFFFFFFE              ADD EAX, FFFFFFFE
00008: 000B 89 C0                       MOV EAX, EAX
00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _getFirstAtomNumTypeChanged

; 75: int getFirstAtomNumTypeChanged(){return 0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 75: int getFirstAtomNumTypeChanged(){return 0;}

00008: 0003 B8 00000000                 MOV EAX, 00000000
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getLastAtomNumTypeChanged

; 76: int getLastAtomNumTypeChanged(){return getNumAtoms()-2;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 76: int getLastAtomNumTypeChanged(){return getNumAtoms()-2;}

00008: 0003 E8 00000000                 CALL SHORT _getNumAtoms
00008: 0008 83 C0 FFFFFFFE              ADD EAX, FFFFFFFE
00008: 000B 89 C0                       MOV EAX, EAX
00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _isTypeDescriptionsChanged

; 77: int isTypeDescriptionsChanged(){return CHANGE_LOAD;}//expensive

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 77: int isTypeDescriptionsChanged(){return CHANGE_LOAD;}//expensive

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _loadSim

; 85: void loadSim(const char *fileName,const char*){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
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

; 87: 	int i=0;

00008: 0018 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000

; 90: 	JAVA_FILENAME=fileName;

00008: 001F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0022 89 15 00000000              MOV DWORD PTR _JAVA_FILENAME, EDX

; 93:   	if((ares=startup())<1){

00008: 0028 E8 00000000                 CALL SHORT _startup
00008: 002D 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 0030 83 7D FFFFFFE8 01           CMP DWORD PTR FFFFFFE8[EBP], 00000001
00008: 0034 7D 2E                       JGE L0001

; 94:   		printf("ares %i\n",ares);

00008: 0036 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0039 68 00000000                 PUSH OFFSET @205
00008: 003E E8 00000000                 CALL SHORT _printf
00008: 0043 59                          POP ECX
00008: 0044 59                          POP ECX

; 95:   		if(!ares)StopAlert(FILE_ALRT);

00008: 0045 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0049 75 08                       JNE L0002
00008: 004B 6A 01                       PUSH 00000001
00008: 004D E8 00000000                 CALL SHORT _StopAlert
00008: 0052 59                          POP ECX
00008: 0053                     L0002:

; 96:   		send_error_up("startup error");

00008: 0053 68 00000000                 PUSH OFFSET @206
00008: 0058 E8 00000000                 CALL SHORT _send_error_up
00008: 005D 59                          POP ECX

; 97:   		return;

00000: 005E                             epilog 
00000: 005E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0061 5B                          POP EBX
00000: 0062 5D                          POP EBP
00000: 0063 C3                          RETN 
00008: 0064                     L0001:
00008: 0064 83 7D FFFFFFE8 03           CMP DWORD PTR FFFFFFE8[EBP], 00000003
00008: 0068 7E 1E                       JLE L0003

; 99:   		ares-=MOVIE;

00008: 006A 83 6D FFFFFFE8 03           SUB DWORD PTR FFFFFFE8[EBP], 00000003

; 100:   		text_error_dialog(ares);

00008: 006E FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0071 E8 00000000                 CALL SHORT _text_error_dialog
00008: 0076 59                          POP ECX

; 101:   		send_error_up("movie error");

00008: 0077 68 00000000                 PUSH OFFSET @207
00008: 007C E8 00000000                 CALL SHORT _send_error_up
00008: 0081 59                          POP ECX

; 102:   		return;

00000: 0082                             epilog 
00000: 0082 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0085 5B                          POP EBX
00000: 0086 5D                          POP EBP
00000: 0087 C3                          RETN 
00008: 0088                     L0003:

; 105: 	if(ares!=MOVIE)

00008: 0088 83 7D FFFFFFE8 03           CMP DWORD PTR FFFFFFE8[EBP], 00000003
00008: 008C 74 1E                       JE L0004

; 106: 	  	ct1=squeeze_table(&p1,&q1,&timea); 

00008: 008E 68 00000000                 PUSH OFFSET _timea
00008: 0093 68 00000000                 PUSH OFFSET _q1
00008: 0098 68 00000000                 PUSH OFFSET _p1
00008: 009D E8 00000000                 CALL SHORT _squeeze_table
00008: 00A2 83 C4 0C                    ADD ESP, 0000000C
00008: 00A5 A3 00000000                 MOV DWORD PTR _ct1, EAX
00008: 00AA EB 0B                       JMP L0005
00008: 00AC                     L0004:

; 108: 	  	send_error_up("squeeze table");

00008: 00AC 68 00000000                 PUSH OFFSET @208
00008: 00B1 E8 00000000                 CALL SHORT _send_error_up
00008: 00B6 59                          POP ECX
00008: 00B7                     L0005:

; 110: 	sze=get_bounds();

00008: 00B7 E8 00000000                 CALL SHORT _get_bounds
00008: 00BC 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 111: 	for(i=0;i<3;i++)

00008: 00BF C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 00C6 EB 1F                       JMP L0006
00008: 00C8                     L0007:

; 112:     	boxSize[i]=(float)sze[i].length*SCALE_FACTOR;

00008: 00C8 8B 5D FFFFFFEC              MOV EBX, DWORD PTR FFFFFFEC[EBP]
00008: 00CB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00CE 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00D1 DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00007: 00D4 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 00D7 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 00DA 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00DD 89 14 85 00000000           MOV DWORD PTR _boxSize[EAX*4], EDX
00008: 00E4 FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 00E7                     L0006:
00008: 00E7 83 7D FFFFFFEC 03           CMP DWORD PTR FFFFFFEC[EBP], 00000003
00008: 00EB 7C FFFFFFDB                 JL L0007

; 114:   	bondCount=0; TIME_ADVANCE=0;

00008: 00ED C7 05 00000000 00000000     MOV DWORD PTR _bondCount, 00000000
00008: 00F7 C7 05 00000000 00000000     MOV DWORD PTR _TIME_ADVANCE, 00000000

; 116:   	 fclose(text_path);//note

00008: 0101 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 0106 50                          PUSH EAX
00008: 0107 E8 00000000                 CALL SHORT _fclose
00008: 010C 59                          POP ECX

; 118:   	initPValues();

00008: 010D E8 00000000                 CALL SHORT _initPValues

; 120: 	CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=CHANGE_PARAMS=TRUE;

00008: 0112 C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_PARAMS, 00000001
00008: 011C 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_PARAMS
00008: 0122 89 15 00000000              MOV DWORD PTR _CHANGE_REACTION, EDX
00008: 0128 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_REACTION
00008: 012E 89 15 00000000              MOV DWORD PTR _CHANGE_FRAME, EDX
00008: 0134 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_FRAME
00008: 013A 89 15 00000000              MOV DWORD PTR _CHANGE_LOAD, EDX

; 121: }

00000: 0140                     L0000:
00000: 0140                             epilog 
00000: 0140 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0143 5B                          POP EBX
00000: 0144 5D                          POP EBP
00000: 0145 C3                          RETN 

Function: _saveSim

; 123: void saveSim(const char *fileName,const char*){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 124: 	writetext((char *)fileName);

00008: 0003 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0006 50                          PUSH EAX
00008: 0007 E8 00000000                 CALL SHORT _writetext
00008: 000C 59                          POP ECX

; 125: }

00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _closeSim

; 126: void closeSim(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 128:  	if(is_open){fclose(echo_path);}

00008: 0003 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 000A 74 0C                       JE L0001
00008: 000C A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0011 50                          PUSH EAX
00008: 0012 E8 00000000                 CALL SHORT _fclose
00008: 0017 59                          POP ECX
00008: 0018                     L0001:

; 129:  	if(m_is_open)closemovie(movie_path);

00008: 0018 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 001F 74 0C                       JE L0002
00008: 0021 A1 00000000                 MOV EAX, DWORD PTR _movie_path
00008: 0026 50                          PUSH EAX
00008: 0027 E8 00000000                 CALL SHORT _closemovie
00008: 002C 59                          POP ECX
00008: 002D                     L0002:

; 130:  	close_corr_func();

00008: 002D E8 00000000                 CALL SHORT _close_corr_func

; 131:  	close_rms();

00008: 0032 E8 00000000                 CALL SHORT _close_rms

; 132:  	bondCount=0; TIME_ADVANCE=0;

00008: 0037 C7 05 00000000 00000000     MOV DWORD PTR _bondCount, 00000000
00008: 0041 C7 05 00000000 00000000     MOV DWORD PTR _TIME_ADVANCE, 00000000

; 133: 	CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=CHANGE_PARAMS=TRUE;

00008: 004B C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_PARAMS, 00000001
00008: 0055 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_PARAMS
00008: 005B 89 15 00000000              MOV DWORD PTR _CHANGE_REACTION, EDX
00008: 0061 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_REACTION
00008: 0067 89 15 00000000              MOV DWORD PTR _CHANGE_FRAME, EDX
00008: 006D 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_FRAME
00008: 0073 89 15 00000000              MOV DWORD PTR _CHANGE_LOAD, EDX

; 134: }

00000: 0079                     L0000:
00000: 0079                             epilog 
00000: 0079 C9                          LEAVE 
00000: 007A C3                          RETN 

Function: _abort

; 135: void abort(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 136: 	ABORT=TRUE;

00008: 0003 C7 05 00000000 00000001     MOV DWORD PTR _ABORT, 00000001

; 137: }

00000: 000D                     L0000:
00000: 000D                             epilog 
00000: 000D C9                          LEAVE 
00000: 000E C3                          RETN 

Function: _step

; 139: void step(float maxTime){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 20                    SUB ESP, 00000020
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 B9 00000008                 MOV ECX, 00000008
00000: 0016 F3 AB                       REP STOSD 
00000: 0018 5F                          POP EDI
00000: 0019                             prolog 

; 141: 	int nBs=0,nTs=0,i;

00008: 0019 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 0020 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000

; 144: 	CHANGE_FRAME=TRUE;

00008: 0027 C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_FRAME, 00000001

; 145: 	t=get_time();

00008: 0031 E8 00000000                 CALL SHORT _get_time
00007: 0036 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 146: 	maxTime+=TIME_ADVANCE;

00008: 0039 D9 45 08                    FLD DWORD PTR 00000008[EBP]
00007: 003C D8 05 00000000              FADD DWORD PTR _TIME_ADVANCE
00007: 0042 D9 5D 08                    FSTP DWORD PTR 00000008[EBP]

; 147: 	while ( (((timec+timed)+(timea-timeb)/corr<=t+maxTime)||coll_type)

00008: 0045 E9 000000B7                 JMP L0001
00008: 004A                     L0002:

; 151: 		coll_type=collision();//only save when coll_type (collision type) is != 1

00008: 004A E8 00000000                 CALL SHORT _collision
00008: 004F A3 00000000                 MOV DWORD PTR _coll_type, EAX

; 153: 		update_table(p1,q1,ct1);

00008: 0054 A1 00000000                 MOV EAX, DWORD PTR _ct1
00008: 0059 50                          PUSH EAX
00008: 005A A1 00000000                 MOV EAX, DWORD PTR _q1
00008: 005F 50                          PUSH EAX
00008: 0060 A1 00000000                 MOV EAX, DWORD PTR _p1
00008: 0065 50                          PUSH EAX
00008: 0066 E8 00000000                 CALL SHORT _update_table
00008: 006B 83 C4 0C                    ADD ESP, 0000000C

; 155: 		rms();

00008: 006E E8 00000000                 CALL SHORT _rms

; 156: 		if((corr_2>1.0e1)||(corr_2<1.0e-1))

00008: 0073 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 0079 DD 05 00000000              FLD QWORD PTR .data+00000038
00006: 007F F1DF                        FCOMIP ST, ST(1), L0003
00007: 0081 DD D8                       FSTP ST
00008: 0083 7A 02                       JP L000D
00008: 0085 72 14                       JB L0003
00008: 0087                     L000D:
00008: 0087 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 008D DD 05 00000000              FLD QWORD PTR .data+00000040
00006: 0093 F1DF                        FCOMIP ST, ST(1), L0004
00007: 0095 DD D8                       FSTP ST
00008: 0097 7A 24                       JP L0004
00008: 0099 76 22                       JBE L0004
00008: 009B                     L0003:

; 157: 			if(!coll_type){

00008: 009B 83 3D 00000000 00           CMP DWORD PTR _coll_type, 00000000
00008: 00A2 75 19                       JNE L0005

; 158: 				printf("!coltype\n");

00008: 00A4 68 00000000                 PUSH OFFSET @251
00008: 00A9 E8 00000000                 CALL SHORT _printf
00008: 00AE 59                          POP ECX

; 159: 				if(!cleanup())break;

00008: 00AF E8 00000000                 CALL SHORT _cleanup
00008: 00B4 83 F8 00                    CMP EAX, 00000000
00008: 00B7 0F 84 0000008A              JE L0006

; 160: 			}

00008: 00BD                     L0005:
00008: 00BD                     L0004:

; 161: 		if(getnewBonds()){

00008: 00BD E8 00000000                 CALL SHORT _getnewBonds
00008: 00C2 83 F8 00                    CMP EAX, 00000000
00008: 00C5 74 0A                       JE L0007

; 162: 			CHANGE_REACTION=TRUE;

00008: 00C7 C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_REACTION, 00000001

; 163: 		}

00008: 00D1                     L0007:

; 164: 		if(getnewTypes()){

00008: 00D1 E8 00000000                 CALL SHORT _getnewTypes
00008: 00D6 83 F8 00                    CMP EAX, 00000000
00008: 00D9 74 0A                       JE L0008

; 165: 			CHANGE_REACTION=TRUE;

00008: 00DB C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_REACTION, 00000001

; 166: 		}

00008: 00E5                     L0008:

; 168: 		ct1=squeeze_table(&p1,&q1,&timea);//determines time of next collision

00008: 00E5 68 00000000                 PUSH OFFSET _timea
00008: 00EA 68 00000000                 PUSH OFFSET _q1
00008: 00EF 68 00000000                 PUSH OFFSET _p1
00008: 00F4 E8 00000000                 CALL SHORT _squeeze_table
00008: 00F9 83 C4 0C                    ADD ESP, 0000000C
00008: 00FC A3 00000000                 MOV DWORD PTR _ct1, EAX

; 170: 	}

00008: 0101                     L0001:
00008: 0101 DD 05 00000000              FLD QWORD PTR _timea
00007: 0107 DC 25 00000000              FSUB QWORD PTR _timeb
00007: 010D DC 35 00000000              FDIV QWORD PTR _corr
00007: 0113 DD 05 00000000              FLD QWORD PTR _timec
00006: 0119 DC 05 00000000              FADD QWORD PTR _timed
00006: 011F DE C1                       FADDP ST(1), ST
00007: 0121 D9 45 08                    FLD DWORD PTR 00000008[EBP]
00006: 0124 DC 45 FFFFFFEC              FADD QWORD PTR FFFFFFEC[EBP]
00006: 0127 D9 C9                       FXCH ST(1)
00006: 0129 F1DF                        FCOMIP ST, ST(1), L0009
00007: 012B DD D8                       FSTP ST
00008: 012D 7A 02                       JP L000E
00008: 012F 76 09                       JBE L0009
00008: 0131                     L000E:
00008: 0131 83 3D 00000000 00           CMP DWORD PTR _coll_type, 00000000
00008: 0138 74 0D                       JE L000A
00008: 013A                     L0009:
00008: 013A 83 3D 00000000 00           CMP DWORD PTR _ABORT, 00000000
00008: 0141 0F 84 FFFFFF03              JE L0002
00008: 0147                     L000A:
00008: 0147                     L0006:

; 172: 	TIME_ADVANCE=(float)(maxTime-(get_time()-t));

00008: 0147 E8 00000000                 CALL SHORT _get_time
00007: 014C DC 65 FFFFFFEC              FSUB QWORD PTR FFFFFFEC[EBP]
00007: 014F D9 45 08                    FLD DWORD PTR 00000008[EBP]
00006: 0152 DE E1                       FSUBRP ST(1), ST
00007: 0154 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0157 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 015A 89 15 00000000              MOV DWORD PTR _TIME_ADVANCE, EDX

; 174: 	sze=get_bounds();

00008: 0160 E8 00000000                 CALL SHORT _get_bounds
00008: 0165 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 176: 	for(i=0;i<3;i++)

00008: 0168 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 016F EB 1F                       JMP L000B
00008: 0171                     L000C:

; 177:     	boxSize[i]=(float)sze[i].length*SCALE_FACTOR;

00008: 0171 8B 5D FFFFFFE4              MOV EBX, DWORD PTR FFFFFFE4[EBP]
00008: 0174 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0177 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 017A DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00007: 017D D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0180 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0183 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0186 89 14 85 00000000           MOV DWORD PTR _boxSize[EAX*4], EDX
00008: 018D FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]
00008: 0190                     L000B:
00008: 0190 83 7D FFFFFFE4 03           CMP DWORD PTR FFFFFFE4[EBP], 00000003
00008: 0194 7C FFFFFFDB                 JL L000C

; 178: 	ABORT=FALSE;

00008: 0196 C7 05 00000000 00000000     MOV DWORD PTR _ABORT, 00000000

; 179: 	CHANGE_PARAMS=TRUE;

00008: 01A0 C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_PARAMS, 00000001

; 181: 	doParameterValueUpdate();

00008: 01AA E8 00000000                 CALL SHORT _doParameterValueUpdate

; 182: }

00000: 01AF                     L0000:
00000: 01AF                             epilog 
00000: 01AF 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 01B2 5B                          POP EBX
00000: 01B3 5D                          POP EBP
00000: 01B4 C3                          RETN 

Function: _linkInterpreter

; 184: void linkInterpreter(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 185: 	CHANGE_LINK=CHANGE_LOAD=CHANGE_FRAME=CHANGE_REACTION=

00008: 0003 C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_PARAMS, 00000001
00008: 000D 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_PARAMS
00008: 0013 89 15 00000000              MOV DWORD PTR _CHANGE_REACTION, EDX
00008: 0019 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_REACTION
00008: 001F 89 15 00000000              MOV DWORD PTR _CHANGE_FRAME, EDX
00008: 0025 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_FRAME
00008: 002B 89 15 00000000              MOV DWORD PTR _CHANGE_LOAD, EDX
00008: 0031 8B 15 00000000              MOV EDX, DWORD PTR _CHANGE_LOAD
00008: 0037 89 15 00000000              MOV DWORD PTR _CHANGE_LINK, EDX

; 187: }

00000: 003D                     L0000:
00000: 003D                             epilog 
00000: 003D C9                          LEAVE 
00000: 003E C3                          RETN 

Function: _unlinkInterpreter

; 188: void unlinkInterpreter(){}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 188: void unlinkInterpreter(){}

00000: 0003                     L0000:
00000: 0003                             epilog 
00000: 0003 C9                          LEAVE 
00000: 0004 C3                          RETN 

Function: _doParameterValueUpdate

; 194: void doParameterValueUpdate(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 195:   parameterValues[0]=get_temperature();

00008: 0012 E8 00000000                 CALL SHORT _get_temperature
00007: 0017 DD 1D 00000000              FSTP QWORD PTR _parameterValues

; 196:   parameterValues[1]=get_avePot();

00008: 001D E8 00000000                 CALL SHORT _get_avePot
00008: 0022 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 0025 DB 45 FFFFFFF8              FILD DWORD PTR FFFFFFF8[EBP]
00007: 0028 DD 1D 00000008              FSTP QWORD PTR _parameterValues+00000008

; 197:   parameterValues[2]=get_mes_time();

00008: 002E E8 00000000                 CALL SHORT _get_mes_time
00007: 0033 DD 1D 00000010              FSTP QWORD PTR _parameterValues+00000010

; 198:   parameterValues[3]=get_temp();

00008: 0039 E8 00000000                 CALL SHORT _get_temp
00007: 003E DD 1D 00000018              FSTP QWORD PTR _parameterValues+00000018

; 199: }

00000: 0044                     L0000:
00000: 0044                             epilog 
00000: 0044 C9                          LEAVE 
00000: 0045 C3                          RETN 

Function: _getParameterGroups

; 200: char** getParameterGroups(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 201: 	return parameterGroups;

00008: 0003 B8 00000000                 MOV EAX, OFFSET _parameterGroups
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getParameterNames

; 203: char** getParameterNames(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 204: 	return parameterNames;

00008: 0003 B8 00000000                 MOV EAX, OFFSET _parameterNames
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getNumParameters

; 206: int getNumParameters(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 207: 	return 4;

00008: 0003 B8 00000004                 MOV EAX, 00000004
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getParameterValues

; 209: double* getParameterValues(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 210: 	return parameterValues;

00008: 0003 B8 00000000                 MOV EAX, OFFSET _parameterValues
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getInputNames

; 220: char **getInputNames(){return inputNames;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 220: char **getInputNames(){return inputNames;}

00008: 0003 B8 00000000                 MOV EAX, OFFSET _inputNames
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getInputGroups

; 221: char **getInputGroups(){return inputGroups;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 221: char **getInputGroups(){return inputGroups;}

00008: 0003 B8 00000000                 MOV EAX, OFFSET _inputGroups
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getInputCounts

; 222: long *getInputCounts(){return parameterCounts;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 222: long *getInputCounts(){return parameterCounts;}

00008: 0003 B8 00000000                 MOV EAX, OFFSET _parameterCounts
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getInputParameterNames

; 223: char **getInputParameterNames(){return inputParameterNames;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 223: char **getInputParameterNames(){return inputParameterNames;}

00008: 0003 B8 00000000                 MOV EAX, OFFSET _inputParameterNames
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getInputParameterNamesCount

; 224: int getInputParameterNamesCount(){return 3;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 224: int getInputParameterNamesCount(){return 3;}

00008: 0003 B8 00000003                 MOV EAX, 00000003
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getNumInput

; 225: int getNumInput(){return 3;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 225: int getNumInput(){return 3;}

00008: 0003 B8 00000003                 MOV EAX, 00000003
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _call

; 228: void call(int fnum,int numParams,double* parameters){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 230: 	pValues[fnum]=parameters[0];//ffix

00008: 0003 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0006 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0008 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 000B DD 1C C5 00000000           FSTP QWORD PTR _pValues[EAX*8]

; 231: 	switch(fnum){

00008: 0012 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0015 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0018 83 FA 02                    CMP EDX, 00000002
00008: 001B 77 43                       JA L0001
00008: 001D FF 24 95 00000000           JMP DWORD PTR @323[EDX*4], 0338D4F8
00008: 0024                     L0002:

; 233: 			set_temp(parameters[0]);

00008: 0024 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0027 FF 70 04                    PUSH DWORD PTR 00000004[EAX]
00008: 002A 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 002D FF 30                       PUSH DWORD PTR 00000000[EAX]
00008: 002F E8 00000000                 CALL SHORT _set_temp
00008: 0034 59                          POP ECX
00008: 0035 59                          POP ECX

; 234: 			break;

00008: 0036 EB 33                       JMP L0003
00008: 0038                     L0004:

; 236: 			set_temp_limit(parameters[0]);

00008: 0038 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 003B FF 70 04                    PUSH DWORD PTR 00000004[EAX]
00008: 003E 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0041 FF 30                       PUSH DWORD PTR 00000000[EAX]
00008: 0043 E8 00000000                 CALL SHORT _set_temp_limit
00008: 0048 59                          POP ECX
00008: 0049 59                          POP ECX

; 237: 			break;

00008: 004A EB 1F                       JMP L0003
00008: 004C                     L0005:

; 239: 			set_coeff(parameters[0]);

00008: 004C 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 004F FF 70 04                    PUSH DWORD PTR 00000004[EAX]
00008: 0052 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0055 FF 30                       PUSH DWORD PTR 00000000[EAX]
00008: 0057 E8 00000000                 CALL SHORT _set_coeff
00008: 005C 59                          POP ECX
00008: 005D 59                          POP ECX

; 240: 			break;

00008: 005E EB 0B                       JMP L0003
00008: 0060                     L0001:

; 242: 			send_error_up("unknown function");

00008: 0060 68 00000000                 PUSH OFFSET @324
00008: 0065 E8 00000000                 CALL SHORT _send_error_up
00008: 006A 59                          POP ECX

; 243: 	}

00008: 006B                     L0003:

; 244: 	CHANGE_PARAMS=TRUE;

00008: 006B C7 05 00000000 00000001     MOV DWORD PTR _CHANGE_PARAMS, 00000001

; 245: 	doParameterValueUpdate();

00008: 0075 E8 00000000                 CALL SHORT _doParameterValueUpdate

; 246: }

00000: 007A                     L0000:
00000: 007A                             epilog 
00000: 007A C9                          LEAVE 
00000: 007B C3                          RETN 

Function: _initPValues

; 247: int initPValues(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 248:     pValues[0]=get_temp();

00008: 0003 E8 00000000                 CALL SHORT _get_temp
00007: 0008 DD 1D 00000000              FSTP QWORD PTR _pValues

; 249: 	pValues[1]=get_temp_limit();

00008: 000E E8 00000000                 CALL SHORT _get_temp_limit
00007: 0013 DD 1D 00000008              FSTP QWORD PTR _pValues+00000008

; 250: 	pValues[2]=get_coeff();

00008: 0019 E8 00000000                 CALL SHORT _get_coeff
00007: 001E DD 1D 00000010              FSTP QWORD PTR _pValues+00000010

; 251: }

00000: 0024                     L0000:
00000: 0024                             epilog 
00000: 0024 C9                          LEAVE 
00000: 0025 C3                          RETN 

Function: _getInputParameterValues

; 252: double *getInputParameterValues(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 253: 	return pValues;

00008: 0003 B8 00000000                 MOV EAX, OFFSET _pValues
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getPositions

; 257: void getPositions(int,int,float *positions){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 30                    SUB ESP, 00000030
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 B9 0000000C                 MOV ECX, 0000000C
00000: 0016 F3 AB                       REP STOSD 
00000: 0018 5F                          POP EDI
00000: 0019                             prolog 

; 258: 	const int numAtoms=get_atom_number();

00008: 0019 E8 00000000                 CALL SHORT _get_atom_number
00008: 001E 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 260:     const register float _TIME_ADVANCE=TIME_ADVANCE;

00008: 0021 8B 15 00000000              MOV EDX, DWORD PTR _TIME_ADVANCE
00008: 0027 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 261:     const register float _corr=(float)corr;

00008: 002A DD 05 00000000              FLD QWORD PTR _corr
00007: 0030 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0033 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0036 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 262:     const register float _timeb=(float)timeb;

00008: 0039 DD 05 00000000              FLD QWORD PTR _timeb
00007: 003F D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0042 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0045 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 263:     const register atom* _a=a;

00008: 0048 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 004D 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 264:     const register float tx=-(get_bounds()[0].length/2.0f),

00008: 0050 E8 00000000                 CALL SHORT _get_bounds
00008: 0055 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0057 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 005D D9 E0                       FCHS 
00007: 005F D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0062 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0065 89 55 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EDX
00008: 0068 E8 00000000                 CALL SHORT _get_bounds
00008: 006D DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 0070 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 0076 D9 E0                       FCHS 
00007: 0078 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 007B 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 007E 89 55 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EDX
00008: 0081 E8 00000000                 CALL SHORT _get_bounds
00008: 0086 DD 40 30                    FLD QWORD PTR 00000030[EAX]
00007: 0089 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 008F D9 E0                       FCHS 
00007: 0091 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0094 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0097 89 55 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EDX

; 268:     for(i=0,j=0;i<numAtoms;i++){

00008: 009A C7 45 FFFFFFD0 00000000     MOV DWORD PTR FFFFFFD0[EBP], 00000000
00008: 00A1 C7 45 FFFFFFD4 00000000     MOV DWORD PTR FFFFFFD4[EBP], 00000000
00008: 00A8 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00008: 00AB E9 0000012A                 JMP L0001
00008: 00B0                     L0002:

; 269:         positions[j+0]=(((float)(_a[i].r.x+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.x)))+tx)*SCALE_FACTOR;

00008: 00B0 D9 45 FFFFFFDC              FLD DWORD PTR FFFFFFDC[EBP]
00007: 00B3 D8 75 FFFFFFE0              FDIV DWORD PTR FFFFFFE0[EBP]
00007: 00B6 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 00B9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 00C0 29 D3                       SUB EBX, EDX
00007: 00C2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00C5 D9 45 FFFFFFE4              FLD DWORD PTR FFFFFFE4[EBP]
00006: 00C8 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00006: 00CB DC 64 D8 78                 FSUB QWORD PTR 00000078[EAX][EBX*8]
00006: 00CF DE C1                       FADDP ST(1), ST
00007: 00D1 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 00D4 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 00DB 29 D3                       SUB EBX, EDX
00007: 00DD 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00E0 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 00E3 DC 4C D8 18                 FMUL QWORD PTR 00000018[EAX][EBX*8]
00007: 00E7 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 00EA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 00F1 29 D3                       SUB EBX, EDX
00007: 00F3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00F6 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 00F9 DC 04 D8                    FADD QWORD PTR 00000000[EAX][EBX*8]
00007: 00FC D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 00FF D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 0102 D8 45 FFFFFFE8              FADD DWORD PTR FFFFFFE8[EBP]
00007: 0105 8B 4D FFFFFFD4              MOV ECX, DWORD PTR FFFFFFD4[EBP]
00007: 0108 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 010B D9 1C 88                    FSTP DWORD PTR 00000000[EAX][ECX*4]

; 270:         positions[j+1]=(((float)(_a[i].r.y+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.y)))+ty)*SCALE_FACTOR;

00008: 010E D9 45 FFFFFFDC              FLD DWORD PTR FFFFFFDC[EBP]
00007: 0111 D8 75 FFFFFFE0              FDIV DWORD PTR FFFFFFE0[EBP]
00007: 0114 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 0117 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 011E 29 D3                       SUB EBX, EDX
00007: 0120 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0123 D9 45 FFFFFFE4              FLD DWORD PTR FFFFFFE4[EBP]
00006: 0126 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00006: 0129 DC 64 D8 78                 FSUB QWORD PTR 00000078[EAX][EBX*8]
00006: 012D DE C1                       FADDP ST(1), ST
00007: 012F 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 0132 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0139 29 D3                       SUB EBX, EDX
00007: 013B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 013E 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 0141 DC 4C D8 20                 FMUL QWORD PTR 00000020[EAX][EBX*8]
00007: 0145 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 0148 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 014F 29 D3                       SUB EBX, EDX
00007: 0151 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0154 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 0157 DC 44 D8 08                 FADD QWORD PTR 00000008[EAX][EBX*8]
00007: 015B D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 015E D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 0161 D8 45 FFFFFFEC              FADD DWORD PTR FFFFFFEC[EBP]
00007: 0164 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00007: 0167 42                          INC EDX
00007: 0168 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 016B D9 1C 90                    FSTP DWORD PTR 00000000[EAX][EDX*4]

; 271:         positions[j+2]=(((float)(a[i].r.z+((_TIME_ADVANCE/_corr+(_timeb-_a[i].t))*_a[i].v.z)))+tz)*SCALE_FACTOR;

00008: 016E D9 45 FFFFFFDC              FLD DWORD PTR FFFFFFDC[EBP]
00007: 0171 D8 75 FFFFFFE0              FDIV DWORD PTR FFFFFFE0[EBP]
00007: 0174 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 0177 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 017E 29 D3                       SUB EBX, EDX
00007: 0180 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0183 D9 45 FFFFFFE4              FLD DWORD PTR FFFFFFE4[EBP]
00006: 0186 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00006: 0189 DC 64 D8 78                 FSUB QWORD PTR 00000078[EAX][EBX*8]
00006: 018D DE C1                       FADDP ST(1), ST
00007: 018F 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 0192 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0199 29 D3                       SUB EBX, EDX
00007: 019B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 019E 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 01A1 DC 4C D8 28                 FMUL QWORD PTR 00000028[EAX][EBX*8]
00007: 01A5 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 01A8 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 01AF 29 D3                       SUB EBX, EDX
00007: 01B1 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 01B4 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 01BA DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 01BE D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 01C1 D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 01C4 D8 45 FFFFFFF0              FADD DWORD PTR FFFFFFF0[EBP]
00007: 01C7 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00007: 01CA 83 C2 02                    ADD EDX, 00000002
00007: 01CD 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 01D0 D9 1C 90                    FSTP DWORD PTR 00000000[EAX][EDX*4]

; 273:         j+=3;

00008: 01D3 83 45 FFFFFFD4 03           ADD DWORD PTR FFFFFFD4[EBP], 00000003

; 274:     }

00008: 01D7 FF 45 FFFFFFD0              INC DWORD PTR FFFFFFD0[EBP]
00008: 01DA                     L0001:
00008: 01DA 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 01DD 3B 45 FFFFFFCC              CMP EAX, DWORD PTR FFFFFFCC[EBP]
00008: 01E0 0F 8C FFFFFECA              JL L0002

; 275: }

00000: 01E6                     L0000:
00000: 01E6                             epilog 
00000: 01E6 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 01E9 5B                          POP EBX
00000: 01EA 5D                          POP EBP
00000: 01EB C3                          RETN 

Function: _getVelocities

; 276: void getVelocities(int,int,float *velocities){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 20                    SUB ESP, 00000020
00000: 0007 57                          PUSH EDI
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0011 B9 00000008                 MOV ECX, 00000008
00000: 0016 F3 AB                       REP STOSD 
00000: 0018 5F                          POP EDI
00000: 0019                             prolog 

; 277: 	const int numAtoms=get_atom_number();

00008: 0019 E8 00000000                 CALL SHORT _get_atom_number
00008: 001E 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 279:     const register float _corr=(float)corr;

00008: 0021 DD 05 00000000              FLD QWORD PTR _corr
00007: 0027 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 002A 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 002D 89 55 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EDX

; 280:     const register atom* _a=a;

00008: 0030 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 0035 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 282:     for(i=0,j=0;i<numAtoms;i++){

00008: 0038 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 003F C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0046 8B 55 FFFFFFE8              MOV EDX, DWORD PTR FFFFFFE8[EBP]
00008: 0049 E9 00000083                 JMP L0001
00008: 004E                     L0002:

; 283:         velocities[j+0]=((float)_a[i].v.x/_corr)*SCALE_FACTOR;

00008: 004E 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0051 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0058 29 D3                       SUB EBX, EDX
00008: 005A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 005D 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0060 DD 44 D8 18                 FLD QWORD PTR 00000018[EAX][EBX*8]
00007: 0064 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 0067 D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 006A D8 75 FFFFFFF0              FDIV DWORD PTR FFFFFFF0[EBP]
00007: 006D 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00007: 0070 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 0073 D9 1C 88                    FSTP DWORD PTR 00000000[EAX][ECX*4]

; 284:         velocities[j+1]=((float)_a[i].v.y/_corr)*SCALE_FACTOR;

00008: 0076 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0079 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0080 29 D3                       SUB EBX, EDX
00008: 0082 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0085 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0088 DD 44 D8 20                 FLD QWORD PTR 00000020[EAX][EBX*8]
00007: 008C D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 008F D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 0092 D8 75 FFFFFFF0              FDIV DWORD PTR FFFFFFF0[EBP]
00007: 0095 8B 55 FFFFFFE8              MOV EDX, DWORD PTR FFFFFFE8[EBP]
00007: 0098 42                          INC EDX
00007: 0099 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 009C D9 1C 90                    FSTP DWORD PTR 00000000[EAX][EDX*4]

; 285:         velocities[j+2]=((float)_a[i].v.z/_corr)*SCALE_FACTOR;

00008: 009F 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 00A2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00A9 29 D3                       SUB EBX, EDX
00008: 00AB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00AE 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00B1 DD 44 D8 28                 FLD QWORD PTR 00000028[EAX][EBX*8]
00007: 00B5 D9 5D FFFFFFF4              FSTP DWORD PTR FFFFFFF4[EBP]
00008: 00B8 D9 45 FFFFFFF4              FLD DWORD PTR FFFFFFF4[EBP]
00007: 00BB D8 75 FFFFFFF0              FDIV DWORD PTR FFFFFFF0[EBP]
00007: 00BE 8B 55 FFFFFFE8              MOV EDX, DWORD PTR FFFFFFE8[EBP]
00007: 00C1 83 C2 02                    ADD EDX, 00000002
00007: 00C4 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 00C7 D9 1C 90                    FSTP DWORD PTR 00000000[EAX][EDX*4]

; 287:         j+=3;

00008: 00CA 83 45 FFFFFFE8 03           ADD DWORD PTR FFFFFFE8[EBP], 00000003

; 288:     }

00008: 00CE FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]
00008: 00D1                     L0001:
00008: 00D1 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00D4 3B 45 FFFFFFE0              CMP EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00D7 0F 8C FFFFFF71              JL L0002

; 289: }

00000: 00DD                     L0000:
00000: 00DD                             epilog 
00000: 00DD 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00E0 5B                          POP EBX
00000: 00E1 5D                          POP EBP
00000: 00E2 C3                          RETN 

Function: _getBonds

; 291: void getBonds(int,int,long *bonds){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 40                    SUB ESP, 00000040
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 00000010                 MOV ECX, 00000010
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 292: 	register int i,k,j=0,m;

00008: 0018 C7 45 FFFFFFC0 00000000     MOV DWORD PTR FFFFFFC0[EBP], 00000000

; 294: 	const int scan=getBScanSize();

00008: 001F E8 00000000                 CALL SHORT _getBScanSize
00008: 0024 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 295: 	const int total=get_atom_number()*scan;

00008: 0027 E8 00000000                 CALL SHORT _get_atom_number
00008: 002C 0F AF 45 FFFFFFC8           IMUL EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0030 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 296: 	dimensions* sze=get_bounds();

00008: 0033 E8 00000000                 CALL SHORT _get_bounds
00008: 0038 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 297: 	const register mx=sze[0].length/2.0f;

00008: 003B 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 003E DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0040 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 0046 D9 7D FFFFFFE0              FNSTCW WORD PTR FFFFFFE0[EBP]
00007: 0049 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00007: 004C 80 4D FFFFFFE1 0C           OR BYTE PTR FFFFFFE1[EBP], 0C
00007: 0050 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00007: 0053 DB 5D FFFFFFE4              FISTP DWORD PTR FFFFFFE4[EBP]
00008: 0056 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX
00008: 0059 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00008: 005C 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 005F 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 298: 	const register my=sze[1].length/2.0f;

00008: 0062 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0065 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 0068 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 006E D9 7D FFFFFFE0              FNSTCW WORD PTR FFFFFFE0[EBP]
00007: 0071 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00007: 0074 80 4D FFFFFFE1 0C           OR BYTE PTR FFFFFFE1[EBP], 0C
00007: 0078 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00007: 007B DB 5D FFFFFFE4              FISTP DWORD PTR FFFFFFE4[EBP]
00008: 007E 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX
00008: 0081 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00008: 0084 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0087 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX

; 299: 	const register mz=sze[2].length/2.0f;

00008: 008A 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 008D DD 40 30                    FLD QWORD PTR 00000030[EAX]
00007: 0090 DC 0D 00000000              FMUL QWORD PTR .data+00000118
00007: 0096 D9 7D FFFFFFE0              FNSTCW WORD PTR FFFFFFE0[EBP]
00007: 0099 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00007: 009C 80 4D FFFFFFE1 0C           OR BYTE PTR FFFFFFE1[EBP], 0C
00007: 00A0 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00007: 00A3 DB 5D FFFFFFE4              FISTP DWORD PTR FFFFFFE4[EBP]
00008: 00A6 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX
00008: 00A9 D9 6D FFFFFFE0              FLDCW WORD PTR FFFFFFE0[EBP]
00008: 00AC 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 00AF 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 302:     for (i=0;i<total;i+=scan){ 

00008: 00B2 C7 45 FFFFFFB8 00000000     MOV DWORD PTR FFFFFFB8[EBP], 00000000
00008: 00B9 E9 00000193                 JMP L0001
00008: 00BE                     L0002:

; 303: 	   	index=-1;

00008: 00BE C7 45 FFFFFFF0 FFFFFFFF     MOV DWORD PTR FFFFFFF0[EBP], FFFFFFFF

; 304: 	    for(k=0;k<scan;k++){

00008: 00C5 C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000
00008: 00CC E9 00000168                 JMP L0003
00008: 00D1                     L0004:

; 305: 	        m=nextFriend(j,&index);

00008: 00D1 8D 45 FFFFFFF0              LEA EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00D4 50                          PUSH EAX
00008: 00D5 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 00D8 E8 00000000                 CALL SHORT _nextFriend
00008: 00DD 59                          POP ECX
00008: 00DE 59                          POP ECX
00008: 00DF 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 306: 	        bonds[i+k]=m;

00008: 00E2 8B 5D FFFFFFB8              MOV EBX, DWORD PTR FFFFFFB8[EBP]
00008: 00E5 03 5D FFFFFFBC              ADD EBX, DWORD PTR FFFFFFBC[EBP]
00008: 00E8 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 00EB 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 00EE 89 0C 98                    MOV DWORD PTR 00000000[EAX][EBX*4], ECX

; 307: 	        if(index<0){bonds[i+k]=-1; break;}

00008: 00F1 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 00F5 7D 15                       JGE L0005
00008: 00F7 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 00FA 03 55 FFFFFFBC              ADD EDX, DWORD PTR FFFFFFBC[EBP]
00008: 00FD 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0100 C7 04 90 FFFFFFFF           MOV DWORD PTR 00000000[EAX][EDX*4], FFFFFFFF
00008: 0107 E9 00000139                 JMP L0006
00008: 010C                     L0005:

; 309: 	        if(fabs(a[j].r.x-a[m].r.x)>mx){bonds[i+k]=-1; break;}

00008: 010C 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 010F 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0116 29 D6                       SUB ESI, EDX
00008: 0118 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 011B 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0121 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 0124 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 012B 29 D3                       SUB EBX, EDX
00008: 012D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0130 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0136 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 0139 DC 24 F7                    FSUB QWORD PTR 00000000[EDI][ESI*8]
00007: 013C 50                          PUSH EAX
00007: 013D 50                          PUSH EAX
00007: 013E DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0141 E8 00000000                 CALL SHORT _fabs
00007: 0146 59                          POP ECX
00007: 0147 59                          POP ECX
00007: 0148 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00007: 014B 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00007: 014E DB 45 FFFFFFE4              FILD DWORD PTR FFFFFFE4[EBP]
00006: 0151 D9 C9                       FXCH ST(1)
00006: 0153 F1DF                        FCOMIP ST, ST(1), L0007
00007: 0155 DD D8                       FSTP ST
00008: 0157 7A 17                       JP L0007
00008: 0159 76 15                       JBE L0007
00008: 015B 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 015E 03 55 FFFFFFBC              ADD EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0161 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0164 C7 04 90 FFFFFFFF           MOV DWORD PTR 00000000[EAX][EDX*4], FFFFFFFF
00008: 016B E9 000000D5                 JMP L0006
00008: 0170                     L0007:

; 310: 	        if(fabs(a[j].r.y-a[m].r.y)>my){bonds[i+k]=-1; break;}

00008: 0170 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0173 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 017A 29 D6                       SUB ESI, EDX
00008: 017C 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 017F 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0185 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 0188 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 018F 29 D3                       SUB EBX, EDX
00008: 0191 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0194 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 019A DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 019E DC 64 F7 08                 FSUB QWORD PTR 00000008[EDI][ESI*8]
00007: 01A2 50                          PUSH EAX
00007: 01A3 50                          PUSH EAX
00007: 01A4 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 01A7 E8 00000000                 CALL SHORT _fabs
00007: 01AC 59                          POP ECX
00007: 01AD 59                          POP ECX
00007: 01AE 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00007: 01B1 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00007: 01B4 DB 45 FFFFFFE4              FILD DWORD PTR FFFFFFE4[EBP]
00006: 01B7 D9 C9                       FXCH ST(1)
00006: 01B9 F1DF                        FCOMIP ST, ST(1), L0008
00007: 01BB DD D8                       FSTP ST
00008: 01BD 7A 14                       JP L0008
00008: 01BF 76 12                       JBE L0008
00008: 01C1 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 01C4 03 55 FFFFFFBC              ADD EDX, DWORD PTR FFFFFFBC[EBP]
00008: 01C7 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 01CA C7 04 90 FFFFFFFF           MOV DWORD PTR 00000000[EAX][EDX*4], FFFFFFFF
00008: 01D1 EB 72                       JMP L0006
00008: 01D3                     L0008:

; 311: 	        if(fabs(a[j].r.z-a[m].r.z)>mz){bonds[i+k]=-1; break;}

00008: 01D3 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01D6 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 01DD 29 D6                       SUB ESI, EDX
00008: 01DF 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 01E2 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 01E8 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 01EB 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01F2 29 D3                       SUB EBX, EDX
00008: 01F4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01F7 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01FD DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0201 DC 64 F7 10                 FSUB QWORD PTR 00000010[EDI][ESI*8]
00007: 0205 50                          PUSH EAX
00007: 0206 50                          PUSH EAX
00007: 0207 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 020A E8 00000000                 CALL SHORT _fabs
00007: 020F 59                          POP ECX
00007: 0210 59                          POP ECX
00007: 0211 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00007: 0214 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00007: 0217 DB 45 FFFFFFE4              FILD DWORD PTR FFFFFFE4[EBP]
00006: 021A D9 C9                       FXCH ST(1)
00006: 021C F1DF                        FCOMIP ST, ST(1), L0009
00007: 021E DD D8                       FSTP ST
00008: 0220 7A 14                       JP L0009
00008: 0222 76 12                       JBE L0009
00008: 0224 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0227 03 55 FFFFFFBC              ADD EDX, DWORD PTR FFFFFFBC[EBP]
00008: 022A 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 022D C7 04 90 FFFFFFFF           MOV DWORD PTR 00000000[EAX][EDX*4], FFFFFFFF
00008: 0234 EB 0F                       JMP L0006
00008: 0236                     L0009:

; 312: 	  	}

00008: 0236 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0239                     L0003:
00008: 0239 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 023C 3B 45 FFFFFFC8              CMP EAX, DWORD PTR FFFFFFC8[EBP]
00008: 023F 0F 8C FFFFFE8C              JL L0004
00008: 0245                     L0006:

; 313: 	  	j++;

00008: 0245 FF 45 FFFFFFC0              INC DWORD PTR FFFFFFC0[EBP]

; 314: 	}

00008: 0248 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 024B 03 45 FFFFFFC8              ADD EAX, DWORD PTR FFFFFFC8[EBP]
00008: 024E 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX
00008: 0251                     L0001:
00008: 0251 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0254 3B 45 FFFFFFCC              CMP EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0257 0F 8C FFFFFE61              JL L0002

; 315: }

00000: 025D                     L0000:
00000: 025D                             epilog 
00000: 025D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0260 5F                          POP EDI
00000: 0261 5E                          POP ESI
00000: 0262 5B                          POP EBX
00000: 0263 5D                          POP EBP
00000: 0264 C3                          RETN 

Function: _fabs

; 578: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 583: 		fld x

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]

; 584: 		fabs

00007: 0006 D9 E1                       FABS 

; 585: 		fstp x

00007: 0008 DD 5D 08                    FSTP QWORD PTR 00000008[EBP]

; 588: 	return x ;

00008: 000B DD 45 08                    FLD QWORD PTR 00000008[EBP]
00000: 000E                     L0000:
00000: 000E                             epilog 
00000: 000E C9                          LEAVE 
00000: 000F C3                          RETN 

Function: _getNumAtoms

; 316: int getNumAtoms(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 317: 	return get_atom_number();

00008: 0003 E8 00000000                 CALL SHORT _get_atom_number
00008: 0008 89 C0                       MOV EAX, EAX
00000: 000A                     L0000:
00000: 000A                             epilog 
00000: 000A C9                          LEAVE 
00000: 000B C3                          RETN 

Function: _getBScanSize

; 319: int getBScanSize(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 320: 	return 12;

00008: 0003 B8 0000000C                 MOV EAX, 0000000C
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getMaxAtoms

; 322: int getMaxAtoms(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 323: 	return get_atom_number();

00008: 0003 E8 00000000                 CALL SHORT _get_atom_number
00008: 0008 89 C0                       MOV EAX, EAX
00000: 000A                     L0000:
00000: 000A                             epilog 
00000: 000A C9                          LEAVE 
00000: 000B C3                          RETN 

Function: _getNumDimensions

; 325: int getNumDimensions(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 326: 	return get_dimension();

00008: 0003 E8 00000000                 CALL SHORT _get_dimension
00008: 0008 89 C0                       MOV EAX, EAX
00000: 000A                     L0000:
00000: 000A                             epilog 
00000: 000A C9                          LEAVE 
00000: 000B C3                          RETN 

Function: _isNumDimensionsChanged

; 329: int isNumDimensionsChanged(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 330: 	return CHANGE_LOAD;

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _CHANGE_LOAD
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getSize

; 332: float* getSize(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 333: 	return boxSize;

00008: 0003 B8 00000000                 MOV EAX, OFFSET _boxSize
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getCurrentTime

; 335: double getCurrentTime(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 336: 	return (double)(timec+timed);

00008: 0003 DD 05 00000000              FLD QWORD PTR _timec
00007: 0009 DC 05 00000000              FADD QWORD PTR _timed
00000: 000F                     L0000:
00000: 000F                             epilog 
00000: 000F C9                          LEAVE 
00000: 0010 C3                          RETN 

Function: _cmap

; 373: float cmap(float f){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 374: 	return ((f/256.0f));

00008: 0003 D9 45 08                    FLD DWORD PTR 00000008[EBP]
00007: 0006 D8 0D 00000000              FMUL DWORD PTR .data+00000258
00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _getBondTypes

; 376: void getBondTypes(int beginBondNum,int endBondNum,long *data){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 378: 	for(i=beginBondNum*2;i<(endBondNum+1)*2;i++) data[i]=0;

00008: 0012 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0015 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 001C 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 001F EB 10                       JMP L0001
00008: 0021                     L0002:
00008: 0021 8B 4D FFFFFFFC              MOV ECX, DWORD PTR FFFFFFFC[EBP]
00008: 0024 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0027 C7 04 88 00000000           MOV DWORD PTR 00000000[EAX][ECX*4], 00000000
00008: 002E FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]
00008: 0031                     L0001:
00008: 0031 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0034 42                          INC EDX
00008: 0035 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 003C 39 55 FFFFFFFC              CMP DWORD PTR FFFFFFFC[EBP], EDX
00008: 003F 7C FFFFFFE0                 JL L0002

; 379: }

00000: 0041                     L0000:
00000: 0041                             epilog 
00000: 0041 C9                          LEAVE 
00000: 0042 C3                          RETN 

Function: _getAtomTypes

; 380: void getAtomTypes(int beginAtomNum,int endAtomNum,long *data){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 08                    SUB ESP, 00000008
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0010 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0014                             prolog 

; 382: 	for(i=beginAtomNum;i<endAtomNum+1;i++)

00008: 0014 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0017 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 001A EB 2A                       JMP L0001
00008: 001C                     L0002:

; 383: 		data[i]=a[i].c-1;

00008: 001C 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 001F 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0026 29 D6                       SUB ESI, EDX
00008: 0028 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 002B 8B 1D 00000000              MOV EBX, DWORD PTR _a
00008: 0031 0F BF 9C F3 000000A4        MOVSX EBX, WORD PTR 000000A4[EBX][ESI*8]
00008: 0039 4B                          DEC EBX
00008: 003A 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 003D 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0040 89 1C 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EBX
00008: 0043 FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]
00008: 0046                     L0001:
00008: 0046 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0049 42                          INC EDX
00008: 004A 39 55 FFFFFFF4              CMP DWORD PTR FFFFFFF4[EBP], EDX
00008: 004D 7C FFFFFFCD                 JL L0002

; 384: }

00000: 004F                     L0000:
00000: 004F                             epilog 
00000: 004F 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0052 5E                          POP ESI
00000: 0053 5B                          POP EBX
00000: 0054 5D                          POP EBP
00000: 0055 C3                          RETN 

Function: _getNumAtomTypeDescriptions

; 386: int getNumAtomTypeDescriptions(){return getNat();}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 386: int getNumAtomTypeDescriptions(){return getNat();}

00008: 0003 E8 00000000                 CALL SHORT _getNat
00008: 0008 89 C0                       MOV EAX, EAX
00000: 000A                     L0000:
00000: 000A                             epilog 
00000: 000A C9                          LEAVE 
00000: 000B C3                          RETN 

Function: _getAtomTypeDescription

; 387: ATOM_TYPE_DESCRIPTION getAtomTypeDescription(int num){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 28                    SUB ESP, 00000028
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000000A                 MOV ECX, 0000000A
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 389: 	int cnum=(int)((float)num*(24.0f/(float)getNat()));

00008: 0018 E8 00000000                 CALL SHORT _getNat
00008: 001D 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX
00008: 0020 DB 45 FFFFFFD4              FILD DWORD PTR FFFFFFD4[EBP]
00007: 0023 D9 05 00000000              FLD DWORD PTR .data+0000025c
00006: 0029 DE F1                       FDIVRP ST(1), ST
00007: 002B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00007: 002E 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX
00007: 0031 DB 45 FFFFFFD4              FILD DWORD PTR FFFFFFD4[EBP]
00006: 0034 DE C9                       FMULP ST(1), ST
00007: 0036 D9 7D FFFFFFD0              FNSTCW WORD PTR FFFFFFD0[EBP]
00007: 0039 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00007: 003C 80 4D FFFFFFD1 0C           OR BYTE PTR FFFFFFD1[EBP], 0C
00007: 0040 D9 6D FFFFFFD0              FLDCW WORD PTR FFFFFFD0[EBP]
00007: 0043 DB 5D FFFFFFD4              FISTP DWORD PTR FFFFFFD4[EBP]
00008: 0046 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX
00008: 0049 D9 6D FFFFFFD0              FLDCW WORD PTR FFFFFFD0[EBP]
00008: 004C 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00008: 004F 89 55 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EDX

; 390: 	if(cnum>25) cnum=25;

00008: 0052 83 7D FFFFFFCC 19           CMP DWORD PTR FFFFFFCC[EBP], 00000019
00008: 0056 7E 07                       JLE L0001
00008: 0058 C7 45 FFFFFFCC 00000019     MOV DWORD PTR FFFFFFCC[EBP], 00000019
00008: 005F                     L0001:

; 391: 	atm.r=cmap(colorMap[cnum][0]);

00008: 005F 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0062 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0065 FF 34 9D 00000000           PUSH DWORD PTR _colorMap[EBX*4]
00008: 006C E8 00000000                 CALL SHORT _cmap
00007: 0071 59                          POP ECX
00007: 0072 D9 5D FFFFFFDC              FSTP DWORD PTR FFFFFFDC[EBP]

; 392: 	atm.g=cmap(colorMap[cnum][1]);

00008: 0075 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0078 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 007B FF 34 9D 00000004           PUSH DWORD PTR _colorMap+00000004[EBX*4]
00008: 0082 E8 00000000                 CALL SHORT _cmap
00007: 0087 59                          POP ECX
00007: 0088 D9 5D FFFFFFE0              FSTP DWORD PTR FFFFFFE0[EBP]

; 393: 	atm.b=cmap(colorMap[cnum][2]);

00008: 008B 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 008E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0091 FF 34 9D 00000008           PUSH DWORD PTR _colorMap+00000008[EBX*4]
00008: 0098 E8 00000000                 CALL SHORT _cmap
00007: 009D 59                          POP ECX
00007: 009E D9 5D FFFFFFE4              FSTP DWORD PTR FFFFFFE4[EBP]

; 394: 	atm.radius=get_sample_atoms()[num+1].s*SCALE_FACTOR;

00008: 00A1 E8 00000000                 CALL SHORT _get_sample_atoms
00008: 00A6 8B 5D 0C                    MOV EBX, DWORD PTR 0000000C[EBP]
00008: 00A9 43                          INC EBX
00008: 00AA 8D 34 DD 00000000           LEA ESI, [00000000][EBX*8]
00008: 00B1 29 DE                       SUB ESI, EBX
00008: 00B3 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00B6 DD 84 F0 00000098           FLD QWORD PTR 00000098[EAX][ESI*8]
00007: 00BD D9 5D FFFFFFD4              FSTP DWORD PTR FFFFFFD4[EBP]
00008: 00C0 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00008: 00C3 89 55 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EDX

; 395: 	if(atm.radius==0) atm.radius=-.01f;

00008: 00C6 D9 05 00000000              FLD DWORD PTR .data+00000260
00007: 00CC D9 45 FFFFFFEC              FLD DWORD PTR FFFFFFEC[EBP]
00006: 00CF F1DF                        FCOMIP ST, ST(1), L0002
00007: 00D1 DD D8                       FSTP ST
00008: 00D3 7A 09                       JP L0002
00008: 00D5 75 07                       JNE L0002
00008: 00D7 C7 45 FFFFFFEC BC23D70A     MOV DWORD PTR FFFFFFEC[EBP], BC23D70A
00008: 00DE                     L0002:

; 397: 	atm.description="default atom";

00008: 00DE C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], OFFSET @438

; 398: 	atm.e1=' ';

00008: 00E5 C6 45 FFFFFFE8 20           MOV BYTE PTR FFFFFFE8[EBP], 20

; 399: 	atm.e2=' ';

00008: 00E9 C6 45 FFFFFFE9 20           MOV BYTE PTR FFFFFFE9[EBP], 20

; 400: 	return atm;

00008: 00ED 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00F0 8D 38                       LEA EDI, DWORD PTR 00000000[EAX]
00008: 00F2 8D 75 FFFFFFDC              LEA ESI, DWORD PTR FFFFFFDC[EBP]
00008: 00F5 A5                          MOVSD 
00008: 00F6 A5                          MOVSD 
00008: 00F7 A5                          MOVSD 
00008: 00F8 A5                          MOVSD 
00008: 00F9 A5                          MOVSD 
00008: 00FA A5                          MOVSD 
00008: 00FB 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00000: 00FE                     L0000:
00000: 00FE                             epilog 
00000: 00FE 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0101 5F                          POP EDI
00000: 0102 5E                          POP ESI
00000: 0103 5B                          POP EBX
00000: 0104 5D                          POP EBP
00000: 0105 C3                          RETN 

Function: _getNumBondTypeDescriptions

; 403: int getNumBondTypeDescriptions(){return 1;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 403: int getNumBondTypeDescriptions(){return 1;}

00008: 0003 B8 00000001                 MOV EAX, 00000001
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getBondTypeDescription

; 404: BOND_TYPE_DESCRIPTION getBondTypeDescription(int num){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 57                          PUSH EDI
00000: 0005 83 EC 18                    SUB ESP, 00000018
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0010 AB                          STOSD 
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00000: 0019                             prolog 

; 406: 	b.r=.5f;

00008: 0019 C7 45 FFFFFFE8 3F000000     MOV DWORD PTR FFFFFFE8[EBP], 3F000000

; 407: 	b.g=.5f;

00008: 0020 C7 45 FFFFFFEC 3F000000     MOV DWORD PTR FFFFFFEC[EBP], 3F000000

; 408: 	b.b=.5f;

00008: 0027 C7 45 FFFFFFF0 3F000000     MOV DWORD PTR FFFFFFF0[EBP], 3F000000

; 409: 	b.order=.2*SCALE_FACTOR;

00008: 002E C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000

; 410: 	b.radius=0;

00008: 0035 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 411: 	return b;

00008: 003C 8D 3A                       LEA EDI, DWORD PTR 00000000[EDX]
00008: 003E 8D 75 FFFFFFE4              LEA ESI, DWORD PTR FFFFFFE4[EBP]
00008: 0041 A5                          MOVSD 
00008: 0042 A5                          MOVSD 
00008: 0043 A5                          MOVSD 
00008: 0044 A5                          MOVSD 
00008: 0045 A5                          MOVSD 
00008: 0046 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00000: 0049                     L0000:
00000: 0049                             epilog 
00000: 0049 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 004C 5F                          POP EDI
00000: 004D 5E                          POP ESI
00000: 004E 5D                          POP EBP
00000: 004F C3                          RETN 
