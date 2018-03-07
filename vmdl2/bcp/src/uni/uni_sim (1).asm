
Function: _DllMain@12

; 8: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 11: 	switch(wDataSeg)

00008: 0003 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0006 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0009 83 FA 01                    CMP EDX, 00000001
00008: 000C 77 23                       JA L0001
00008: 000E FF 24 95 00000000           JMP DWORD PTR @13[EDX*4], 0318CCE8
00008: 0015                     L0002:

; 14:     	    bindDLL();

00008: 0015 E8 00000000                 CALL SHORT _bindDLL

; 15:       		return 1;

00008: 001A B8 00000001                 MOV EAX, 00000001
00000: 001F                             epilog 
00000: 001F C9                          LEAVE 
00000: 0020 C2 000C                     RETN 000C
00008: 0023                     L0003:

; 18: 		    unbindDLL();

00008: 0023 E8 00000000                 CALL SHORT _unbindDLL

; 19: 			return 1;

00008: 0028 B8 00000001                 MOV EAX, 00000001
00000: 002D                             epilog 
00000: 002D C9                          LEAVE 
00000: 002E C2 000C                     RETN 000C
00008: 0031                     L0001:

; 23: 	  		return 1;

00008: 0031 B8 00000001                 MOV EAX, 00000001
00000: 0036                     L0000:
00000: 0036                             epilog 
00000: 0036 C9                          LEAVE 
00000: 0037 C2 000C                     RETN 000C

Function: _linkSim

; 30: void linkSim(JNIEnv *env,jobject obj){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 31: 	_prepID();

00008: 0013 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0016 50                          PUSH EAX
00008: 0017 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 001A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 001D 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 001F FF 56 7C                    CALL DWORD PTR 0000007C[ESI], 00000008
00008: 0022 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 32: 	curTimeID=_getDoubleID("_curTime");

00008: 0025 68 00000000                 PUSH OFFSET @18
00008: 002A 68 00000000                 PUSH OFFSET @19
00008: 002F FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0032 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0035 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0038 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 003A FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 0040 A3 00000000                 MOV DWORD PTR _curTimeID, EAX

; 33: 	errorStringID=_getStrID("_errorString");

00008: 0045 68 00000000                 PUSH OFFSET @20
00008: 004A 68 00000000                 PUSH OFFSET @21
00008: 004F FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0052 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0055 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0058 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 005A FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 0060 A3 00000000                 MOV DWORD PTR _errorStringID, EAX

; 34: 	msgStringID=_getStrID("_msgString");

00008: 0065 68 00000000                 PUSH OFFSET @20
00008: 006A 68 00000000                 PUSH OFFSET @22
00008: 006F FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0072 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0075 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0078 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 007A FF 96 00000178              CALL DWORD PTR 00000178[ESI], 00000010
00008: 0080 A3 00000000                 MOV DWORD PTR _msgStringID, EAX

; 35: }

00000: 0085                     L0000:
00000: 0085                             epilog 
00000: 0085 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0088 5E                          POP ESI
00000: 0089 5D                          POP EBP
00000: 008A C3                          RETN 

Function: _unlinkSim

; 36: void unlinkSim(JNIEnv,jobject){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 37: }

00000: 0003                     L0000:
00000: 0003                             epilog 
00000: 0003 C9                          LEAVE 
00000: 0004 C3                          RETN 

Function: _send_message_up

; 45: void send_message_up(char *str){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 46: 	strList* msg=(strList *)malloc(sizeof(strList));

00008: 0012 6A 08                       PUSH 00000008
00008: 0014 E8 00000000                 CALL SHORT _malloc
00008: 0019 59                          POP ECX
00008: 001A 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 47:     msg->next=NULL;

00008: 001D 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0020 C7 40 04 00000000           MOV DWORD PTR 00000004[EAX], 00000000

; 48:     msg->str=str;

00008: 0027 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 002A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002D 89 10                       MOV DWORD PTR 00000000[EAX], EDX

; 49:     if(msgList==NULL) msgList=msg;

00008: 002F 83 3D 00000000 00           CMP DWORD PTR _msgList, 00000000
00008: 0036 75 0A                       JNE L0001
00008: 0038 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 003B A3 00000000                 MOV DWORD PTR _msgList, EAX
00008: 0040 EB 0C                       JMP L0002
00008: 0042                     L0001:

; 50:     else msgLast->next=msg;

00008: 0042 8B 15 00000000              MOV EDX, DWORD PTR _msgLast
00008: 0048 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 004B 89 42 04                    MOV DWORD PTR 00000004[EDX], EAX
00008: 004E                     L0002:

; 52:     msgLast=msg;

00008: 004E 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0051 A3 00000000                 MOV DWORD PTR _msgLast, EAX

; 53: }

00000: 0056                     L0000:
00000: 0056                             epilog 
00000: 0056 C9                          LEAVE 
00000: 0057 C3                          RETN 

Function: _send_error_up

; 54: void send_error_up(char *str){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 55: 	strList* err=(strList *)malloc(sizeof(strList));

00008: 0012 6A 08                       PUSH 00000008
00008: 0014 E8 00000000                 CALL SHORT _malloc
00008: 0019 59                          POP ECX
00008: 001A 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 56:     err->next=NULL;

00008: 001D 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0020 C7 40 04 00000000           MOV DWORD PTR 00000004[EAX], 00000000

; 57:     err->str=str;

00008: 0027 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 002A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002D 89 10                       MOV DWORD PTR 00000000[EAX], EDX

; 58:     if(errList==NULL) errList=err;

00008: 002F 83 3D 00000000 00           CMP DWORD PTR _errList, 00000000
00008: 0036 75 0A                       JNE L0001
00008: 0038 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 003B A3 00000000                 MOV DWORD PTR _errList, EAX
00008: 0040 EB 0C                       JMP L0002
00008: 0042                     L0001:

; 59:     else errLast->next=err;

00008: 0042 8B 15 00000000              MOV EDX, DWORD PTR _errLast
00008: 0048 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 004B 89 42 04                    MOV DWORD PTR 00000004[EDX], EAX
00008: 004E                     L0002:

; 61:     errLast=err;

00008: 004E 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0051 A3 00000000                 MOV DWORD PTR _errLast, EAX

; 62: }

00000: 0056                     L0000:
00000: 0056                             epilog 
00000: 0056 C9                          LEAVE 
00000: 0057 C3                          RETN 

Function: _UNI_check

; 65: void UNI_check(JNIEnv *env,jobject obj){

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

; 66: 	int errlen=0,msglen=0;

00008: 0019 C7 45 FFFFFFD8 00000000     MOV DWORD PTR FFFFFFD8[EBP], 00000000
00008: 0020 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000

; 67: 	strList *errTemp=errList,*msgTemp=msgList;

00008: 0027 A1 00000000                 MOV EAX, DWORD PTR _errList
00008: 002C 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX
00008: 002F A1 00000000                 MOV EAX, DWORD PTR _msgList
00008: 0034 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 68: 	char *cTemp=NULL,*err=NULL,*msg=NULL,*msgB=NULL,*errB=NULL;

00008: 0037 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 003E C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0045 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 004C C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0053 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000

; 70: 	if(errList!=NULL){

00008: 005A 83 3D 00000000 00           CMP DWORD PTR _errList, 00000000
00008: 0061 0F 84 000000BA              JE L0001

; 71: 		while(errTemp!=NULL){

00008: 0067 EB 24                       JMP L0002
00008: 0069                     L0003:

; 72: 			cTemp=errTemp->str;

00008: 0069 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 006C 8B 01                       MOV EAX, DWORD PTR 00000000[ECX]
00008: 006E 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 74: 			while((*cTemp)!='\0'){cTemp++; errlen++;}

00008: 0071 EB 06                       JMP L0004
00008: 0073                     L0005:
00008: 0073 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 0076 FF 45 FFFFFFD8              INC DWORD PTR FFFFFFD8[EBP]
00008: 0079                     L0004:
00008: 0079 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 007C 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 007F 75 FFFFFFF2                 JNE L0005

; 75: 			errlen++;

00008: 0081 FF 45 FFFFFFD8              INC DWORD PTR FFFFFFD8[EBP]

; 76: 			errTemp=errTemp->next;

00008: 0084 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 0087 8B 41 04                    MOV EAX, DWORD PTR 00000004[ECX]
00008: 008A 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 77: 		}

00008: 008D                     L0002:
00008: 008D 83 7D FFFFFFE0 00           CMP DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0091 75 FFFFFFD6                 JNE L0003

; 78: 		errTemp=NULL; cTemp=NULL;

00008: 0093 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 009A C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 80: 		errB=err=(char*)malloc(errlen*sizeof(char));

00008: 00A1 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 00A4 E8 00000000                 CALL SHORT _malloc
00008: 00A9 59                          POP ECX
00008: 00AA 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX
00008: 00AD 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00B0 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 81: 		while(errList!=NULL){

00008: 00B3 EB 4C                       JMP L0006
00008: 00B5                     L0007:

; 82: 			cTemp=errList->str;

00008: 00B5 8B 15 00000000              MOV EDX, DWORD PTR _errList
00008: 00BB 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 00BD 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 83: 			while((*cTemp)!='\0'){ *err= *cTemp;cTemp++; err++;}

00008: 00C0 EB 10                       JMP L0008
00008: 00C2                     L0009:
00008: 00C2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00C5 8A 10                       MOV DL, BYTE PTR 00000000[EAX]
00008: 00C7 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00CA 88 10                       MOV BYTE PTR 00000000[EAX], DL
00008: 00CC FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 00CF FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 00D2                     L0008:
00008: 00D2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00D5 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 00D8 75 FFFFFFE8                 JNE L0009

; 85: 			cTemp=NULL;

00008: 00DA C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 88: 			errTemp=errList->next;

00008: 00E1 8B 15 00000000              MOV EDX, DWORD PTR _errList
00008: 00E7 8B 42 04                    MOV EAX, DWORD PTR 00000004[EDX]
00008: 00EA 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 89: 			free(errList);

00008: 00ED A1 00000000                 MOV EAX, DWORD PTR _errList
00008: 00F2 50                          PUSH EAX
00008: 00F3 E8 00000000                 CALL SHORT _free
00008: 00F8 59                          POP ECX

; 90: 			errList=errTemp;

00008: 00F9 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00FC A3 00000000                 MOV DWORD PTR _errList, EAX

; 91: 		}

00008: 0101                     L0006:
00008: 0101 83 3D 00000000 00           CMP DWORD PTR _errList, 00000000
00008: 0108 75 FFFFFFAB                 JNE L0007

; 92: 		*err='\0';

00008: 010A 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 010D C6 00 00                    MOV BYTE PTR 00000000[EAX], 00

; 93: 		errList=NULL; cTemp=NULL;

00008: 0110 C7 05 00000000 00000000     MOV DWORD PTR _errList, 00000000
00008: 011A C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 94: 	}

00008: 0121                     L0001:

; 95: 	errLast=NULL;

00008: 0121 C7 05 00000000 00000000     MOV DWORD PTR _errLast, 00000000

; 97: 	if(msgList!=NULL){

00008: 012B 83 3D 00000000 00           CMP DWORD PTR _msgList, 00000000
00008: 0132 0F 84 000000BA              JE L000A

; 98: 		while(msgTemp!=NULL){

00008: 0138 EB 24                       JMP L000B
00008: 013A                     L000C:

; 99: 			cTemp=msgTemp->str;

00008: 013A 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 013D 8B 01                       MOV EAX, DWORD PTR 00000000[ECX]
00008: 013F 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 101: 			while((*cTemp)!='\0'){cTemp++; msglen++;}

00008: 0142 EB 06                       JMP L000D
00008: 0144                     L000E:
00008: 0144 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 0147 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 014A                     L000D:
00008: 014A 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 014D 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0150 75 FFFFFFF2                 JNE L000E

; 102: 			msglen++;

00008: 0152 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]

; 103: 			msgTemp=msgTemp->next;

00008: 0155 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 0158 8B 41 04                    MOV EAX, DWORD PTR 00000004[ECX]
00008: 015B 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 104: 		}

00008: 015E                     L000B:
00008: 015E 83 7D FFFFFFE4 00           CMP DWORD PTR FFFFFFE4[EBP], 00000000
00008: 0162 75 FFFFFFD6                 JNE L000C

; 105: 		msgTemp=NULL; cTemp=NULL;

00008: 0164 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 016B C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 107: 		msgB=msg=(char*)malloc(msglen*sizeof(char));

00008: 0172 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 0175 E8 00000000                 CALL SHORT _malloc
00008: 017A 59                          POP ECX
00008: 017B 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 017E 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0181 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 108: 		while(msgList!=NULL){

00008: 0184 EB 4C                       JMP L000F
00008: 0186                     L0010:

; 110: 			cTemp=msgList->str;

00008: 0186 8B 15 00000000              MOV EDX, DWORD PTR _msgList
00008: 018C 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 018E 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 111: 			while((*cTemp)!='\0'){*msg= *cTemp;cTemp++; msg++;}

00008: 0191 EB 10                       JMP L0011
00008: 0193                     L0012:
00008: 0193 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0196 8A 10                       MOV DL, BYTE PTR 00000000[EAX]
00008: 0198 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 019B 88 10                       MOV BYTE PTR 00000000[EAX], DL
00008: 019D FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 01A0 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 01A3                     L0011:
00008: 01A3 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 01A6 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 01A9 75 FFFFFFE8                 JNE L0012

; 113: 			cTemp=NULL;

00008: 01AB C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 116: 			msgTemp=msgList->next;

00008: 01B2 8B 15 00000000              MOV EDX, DWORD PTR _msgList
00008: 01B8 8B 42 04                    MOV EAX, DWORD PTR 00000004[EDX]
00008: 01BB 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 117: 			free(msgList);

00008: 01BE A1 00000000                 MOV EAX, DWORD PTR _msgList
00008: 01C3 50                          PUSH EAX
00008: 01C4 E8 00000000                 CALL SHORT _free
00008: 01C9 59                          POP ECX

; 118: 			msgList=msgTemp;

00008: 01CA 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 01CD A3 00000000                 MOV DWORD PTR _msgList, EAX

; 119: 		}

00008: 01D2                     L000F:
00008: 01D2 83 3D 00000000 00           CMP DWORD PTR _msgList, 00000000
00008: 01D9 75 FFFFFFAB                 JNE L0010

; 120: 		*msg='\0';

00008: 01DB 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 01DE C6 00 00                    MOV BYTE PTR 00000000[EAX], 00

; 121: 		msgList=NULL; cTemp=NULL;

00008: 01E1 C7 05 00000000 00000000     MOV DWORD PTR _msgList, 00000000
00008: 01EB C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 122: 	}

00008: 01F2                     L000A:

; 123: 	msgLast=NULL;

00008: 01F2 C7 05 00000000 00000000     MOV DWORD PTR _msgLast, 00000000

; 125: 	if(err!=NULL){

00008: 01FC 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0200 74 32                       JE L0013

; 126: 		_setStr(errorStringID,_newStr(errB));//possible memory leak

00008: 0202 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0205 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0208 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 020B 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 020D FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 0213 50                          PUSH EAX
00008: 0214 A1 00000000                 MOV EAX, DWORD PTR _errorStringID
00008: 0219 50                          PUSH EAX
00008: 021A FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 021D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0220 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0223 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0225 FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 127: 		free(errB);

00008: 022B FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 022E E8 00000000                 CALL SHORT _free
00008: 0233 59                          POP ECX

; 128: 	}

00008: 0234                     L0013:

; 129: 	if(msg!=NULL){

00008: 0234 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0238 74 32                       JE L0014

; 130: 		_setStr(msgStringID,_newStr(msgB));//ditto

00008: 023A FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 023D FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0240 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0243 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0245 FF 96 0000029C              CALL DWORD PTR 0000029C[ESI], 00000008
00008: 024B 50                          PUSH EAX
00008: 024C A1 00000000                 MOV EAX, DWORD PTR _msgStringID
00008: 0251 50                          PUSH EAX
00008: 0252 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0255 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0258 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 025B 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 025D FF 96 000001A0              CALL DWORD PTR 000001A0[ESI], 00000010

; 131: 		free(msgB);

00008: 0263 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0266 E8 00000000                 CALL SHORT _free
00008: 026B 59                          POP ECX

; 132: 	}

00008: 026C                     L0014:

; 134: }

00000: 026C                     L0000:
00000: 026C                             epilog 
00000: 026C 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 026F 5E                          POP ESI
00000: 0270 5D                          POP EBP
00000: 0271 C3                          RETN 

Function: _getChanged

; 154: long getChanged(){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 155:   long l=CHANGE_NONE;

00008: 0012 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000

; 156:   if(!isChanged()) return l;

00008: 0019 E8 00000000                 CALL SHORT _isChanged
00008: 001E 83 F8 00                    CMP EAX, 00000000
00008: 0021 75 05                       JNE L0001
00008: 0023 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00000: 0026                             epilog 
00000: 0026 C9                          LEAVE 
00000: 0027 C3                          RETN 
00008: 0028                     L0001:

; 158:   if(isSizeChanged()) l=l|CHANGE_SIZE;

00008: 0028 E8 00000000                 CALL SHORT _isSizeChanged
00008: 002D 83 F8 00                    CMP EAX, 00000000
00008: 0030 74 0C                       JE L0002
00008: 0032 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0035 81 CA 00008000              OR EDX, 00008000
00008: 003B 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 003E                     L0002:

; 159:   if(isNumAtomsChanged()) l=l|CHANGE_NUM_ATOMS;

00008: 003E E8 00000000                 CALL SHORT _isNumAtomsChanged
00008: 0043 83 F8 00                    CMP EAX, 00000000
00008: 0046 74 0C                       JE L0003
00008: 0048 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 004B 81 CA 00000080              OR EDX, 00000080
00008: 0051 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 0054                     L0003:

; 160:   if(isBScanSizeChanged()) l=l|CHANGE_BONDS_SCAN;

00008: 0054 E8 00000000                 CALL SHORT _isBScanSizeChanged
00008: 0059 83 F8 00                    CMP EAX, 00000000
00008: 005C 74 0C                       JE L0004
00008: 005E 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0061 81 CA 00000100              OR EDX, 00000100
00008: 0067 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 006A                     L0004:

; 161:   if(isBondsChanged()) l=l|CHANGE_BONDS;

00008: 006A E8 00000000                 CALL SHORT _isBondsChanged
00008: 006F 83 F8 00                    CMP EAX, 00000000
00008: 0072 74 09                       JE L0005
00008: 0074 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0077 83 CA 40                    OR EDX, 00000040
00008: 007A 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 007D                     L0005:

; 162:   if(isPositionsChanged()) l=l|CHANGE_POSITIONS;

00008: 007D E8 00000000                 CALL SHORT _isPositionsChanged
00008: 0082 83 F8 00                    CMP EAX, 00000000
00008: 0085 74 09                       JE L0006
00008: 0087 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 008A 83 CA 10                    OR EDX, 00000010
00008: 008D 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 0090                     L0006:

; 163:   if(isVelocitiesChanged()) l=l|CHANGE_VELOCITIES;

00008: 0090 E8 00000000                 CALL SHORT _isVelocitiesChanged
00008: 0095 83 F8 00                    CMP EAX, 00000000
00008: 0098 74 09                       JE L0007
00008: 009A 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 009D 83 CA 20                    OR EDX, 00000020
00008: 00A0 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 00A3                     L0007:

; 164:   if(isParameterValuesChanged()) l=l|CHANGE_PARAM_V;

00008: 00A3 E8 00000000                 CALL SHORT _isParameterValuesChanged
00008: 00A8 83 F8 00                    CMP EAX, 00000000
00008: 00AB 74 09                       JE L0008
00008: 00AD 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 00B0 83 CA 01                    OR EDX, 00000001
00008: 00B3 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 00B6                     L0008:

; 166:   if(isParametersChanged()) l=l|CHANGE_PARAM_D;

00008: 00B6 E8 00000000                 CALL SHORT _isParametersChanged
00008: 00BB 83 F8 00                    CMP EAX, 00000000
00008: 00BE 74 09                       JE L0009
00008: 00C0 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 00C3 83 CA 02                    OR EDX, 00000002
00008: 00C6 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 00C9                     L0009:

; 167:   if(isInputParameterDescriptionsChanged()) l=l|CHANGE_INPUT_PARAM_D;

00008: 00C9 E8 00000000                 CALL SHORT _isInputParameterDescriptionsChanged
00008: 00CE 83 F8 00                    CMP EAX, 00000000
00008: 00D1 74 09                       JE L000A
00008: 00D3 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 00D6 83 CA 08                    OR EDX, 00000008
00008: 00D9 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 00DC                     L000A:

; 168:   if(isBondTypesChanged()) l=l|CHANGE_TYPES_BONDS;

00008: 00DC E8 00000000                 CALL SHORT _isBondTypesChanged
00008: 00E1 83 F8 00                    CMP EAX, 00000000
00008: 00E4 74 0C                       JE L000B
00008: 00E6 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 00E9 81 CA 00000200              OR EDX, 00000200
00008: 00EF 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 00F2                     L000B:

; 169:   if(isAtomTypesChanged()) l=l|CHANGE_TYPES_ATOMS;

00008: 00F2 E8 00000000                 CALL SHORT _isAtomTypesChanged
00008: 00F7 83 F8 00                    CMP EAX, 00000000
00008: 00FA 74 0C                       JE L000C
00008: 00FC 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 00FF 81 CA 00000400              OR EDX, 00000400
00008: 0105 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 0108                     L000C:

; 170:   if(isTypeDescriptionsChanged()) l=l|CHANGE_TYPE_DESCS;

00008: 0108 E8 00000000                 CALL SHORT _isTypeDescriptionsChanged
00008: 010D 83 F8 00                    CMP EAX, 00000000
00008: 0110 74 0C                       JE L000D
00008: 0112 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0115 81 CA 00000800              OR EDX, 00000800
00008: 011B 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 011E                     L000D:

; 171:   if(isMaxAtomsChanged()) l=l|CHANGE_TYPE_MAX_ATOMS;

00008: 011E E8 00000000                 CALL SHORT _isMaxAtomsChanged
00008: 0123 83 F8 00                    CMP EAX, 00000000
00008: 0126 74 0C                       JE L000E
00008: 0128 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 012B 81 CA 00002000              OR EDX, 00002000
00008: 0131 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 0134                     L000E:

; 172:   if(isNumDimensionsChanged()) l=l|CHANGE_NUM_DIMS;

00008: 0134 E8 00000000                 CALL SHORT _isNumDimensionsChanged
00008: 0139 83 F8 00                    CMP EAX, 00000000
00008: 013C 74 0C                       JE L000F
00008: 013E 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0141 81 CA 00004000              OR EDX, 00004000
00008: 0147 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX
00008: 014A                     L000F:

; 174:   return l;

00008: 014A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00000: 014D                     L0000:
00000: 014D                             epilog 
00000: 014D C9                          LEAVE 
00000: 014E C3                          RETN 

Function: _UNI_update

; 177: long UNI_update(JNIEnv *env,jobject obj){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 56                          PUSH ESI
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 178: 	long ret=getChanged();

00008: 0013 E8 00000000                 CALL SHORT _getChanged
00008: 0018 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 179: 	_setDouble(curTimeID,timec+timed);

00008: 001B DD 05 00000000              FLD QWORD PTR _timec
00007: 0021 DC 05 00000000              FADD QWORD PTR _timed
00007: 0027 50                          PUSH EAX
00007: 0028 50                          PUSH EAX
00007: 0029 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 002C A1 00000000                 MOV EAX, DWORD PTR _curTimeID
00008: 0031 50                          PUSH EAX
00008: 0032 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0035 50                          PUSH EAX
00008: 0036 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0039 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 003C 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 003E FF 96 000001C0              CALL DWORD PTR 000001C0[ESI], 00000014

; 181: 	if(isChanged()){

00008: 0044 E8 00000000                 CALL SHORT _isChanged
00008: 0049 83 F8 00                    CMP EAX, 00000000
00008: 004C 74 24                       JE L0001

; 182: 		updateTypes(env);

00008: 004E FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0051 E8 00000000                 CALL SHORT _updateTypes
00008: 0056 59                          POP ECX

; 183: 		updateParams(env);

00008: 0057 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 005A E8 00000000                 CALL SHORT _updateParams
00008: 005F 59                          POP ECX

; 184: 		updateInput(env);

00008: 0060 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0063 E8 00000000                 CALL SHORT _updateInput
00008: 0068 59                          POP ECX

; 185: 		updateDisplay(env);

00008: 0069 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 006C E8 00000000                 CALL SHORT _updateDisplay
00008: 0071 59                          POP ECX

; 186: 	}

00008: 0072                     L0001:

; 188: 	reset();

00008: 0072 E8 00000000                 CALL SHORT _reset

; 190: 	return ret;

00008: 0077 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00000: 007A                     L0000:
00000: 007A                             epilog 
00000: 007A 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 007D 5E                          POP ESI
00000: 007E 5D                          POP EBP
00000: 007F C3                          RETN 
