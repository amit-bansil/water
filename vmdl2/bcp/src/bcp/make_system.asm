
Function: _getNat

; 33: static int nat; extern int getNat(){return nat;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 33: static int nat; extern int getNat(){return nat;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _nat
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _set_write_param

; 50: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 51:   write_start=n0;

00008: 0003 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0006 A3 00000000                 MOV DWORD PTR _write_start, EAX

; 52:   write_finish=n0+n1;

00008: 000B 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 000E 03 55 0C                    ADD EDX, DWORD PTR 0000000C[EBP]
00008: 0011 89 15 00000000              MOV DWORD PTR _write_finish, EDX

; 53:   write_n1=n1;

00008: 0017 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 001A A3 00000000                 MOV DWORD PTR _write_n1, EAX

; 54:   write_stop=yes;

00008: 001F 8B 55 10                    MOV EDX, DWORD PTR 00000010[EBP]
00008: 0022 89 15 00000000              MOV DWORD PTR _write_stop, EDX

; 55: }

00000: 0028                     L0000:
00000: 0028                             epilog 
00000: 0028 C9                          LEAVE 
00000: 0029 C3                          RETN 

Function: _init_coll

; 58: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006                             prolog 

; 60:   coll[j].e=-en;

00008: 0006 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0009 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 000C 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0012 DD 45 24                    FLD QWORD PTR 00000024[EBP]
00007: 0015 D9 E0                       FCHS 
00007: 0017 DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]

; 61:   coll[j].eo=-en;

00008: 001A 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 001D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0020 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0026 DD 45 24                    FLD QWORD PTR 00000024[EBP]
00007: 0029 D9 E0                       FCHS 
00007: 002B DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]

; 62:   coll[j].dd=diam*diam;

00008: 002F DD 45 2C                    FLD QWORD PTR 0000002C[EBP]
00007: 0032 D8 C8                       FMUL ST, ST
00007: 0034 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00007: 0037 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 003A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 0040 DD 5C DA 18                 FSTP QWORD PTR 00000018[EDX][EBX*8]

; 63:   coll[j].dm=1/((mi+mj)*coll[j].dd);

00008: 0044 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0047 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 004A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0050 DD 45 14                    FLD QWORD PTR 00000014[EBP]
00007: 0053 DC 45 1C                    FADD QWORD PTR 0000001C[EBP]
00007: 0056 DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 005A DD 05 00000000              FLD QWORD PTR .data+00000000
00006: 0060 DE F1                       FDIVRP ST(1), ST
00007: 0062 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00007: 0065 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 0068 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 006E DD 5C DA 20                 FSTP QWORD PTR 00000020[EDX][EBX*8]

; 64:   if(en!=dblarg1)

00008: 0072 DD 45 24                    FLD QWORD PTR 00000024[EBP]
00007: 0075 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 007B F1DF                        FCOMIP ST, ST(1), L0001
00007: 007D DD D8                       FSTP ST
00008: 007F 7A 02                       JP L0003
00008: 0081 74 3F                       JE L0001
00008: 0083                     L0003:

; 65:     coll[j].edm=2*coll[j].e/(mi*mj*coll[j].dm);

00008: 0083 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0086 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0089 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 008F DD 45 14                    FLD QWORD PTR 00000014[EBP]
00007: 0092 DC 4D 1C                    FMUL QWORD PTR 0000001C[EBP]
00007: 0095 DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 0099 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00007: 009C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 009F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 00A5 DD 05 00000000              FLD QWORD PTR .data+00000008
00006: 00AB DC 0C DA                    FMUL QWORD PTR 00000000[EDX][EBX*8]
00006: 00AE DE F1                       FDIVRP ST(1), ST
00007: 00B0 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00007: 00B3 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 00B6 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 00BC DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]
00008: 00C0 EB 1C                       JMP L0002
00008: 00C2                     L0001:

; 67:     coll[j].edm=0;

00008: 00C2 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00C5 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 00C8 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 00CE C7 44 DA 2C 00000000        MOV DWORD PTR 0000002C[EDX][EBX*8], 00000000
00008: 00D6 C7 44 DA 28 00000000        MOV DWORD PTR 00000028[EDX][EBX*8], 00000000
00008: 00DE                     L0002:

; 68:   coll[j].edmo=coll[j].edm;

00008: 00DE 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 00E1 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 00E4 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 00EA 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00ED 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 00F0 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 00F6 DD 44 F7 28                 FLD QWORD PTR 00000028[EDI][ESI*8]
00007: 00FA DD 5C DA 30                 FSTP QWORD PTR 00000030[EDX][EBX*8]

; 69:   coll[j].prev=prev;

00008: 00FE 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0101 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0104 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 010A 8B 75 0C                    MOV ESI, DWORD PTR 0000000C[EBP]
00008: 010D 89 74 DF 3C                 MOV DWORD PTR 0000003C[EDI][EBX*8], ESI

; 70:   coll[j].next=next;

00008: 0111 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0114 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0117 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 011D 8B 75 10                    MOV ESI, DWORD PTR 00000010[EBP]
00008: 0120 89 74 DF 38                 MOV DWORD PTR 00000038[EDI][EBX*8], ESI

; 71:   coll[j].react=react;

00008: 0124 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0127 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 012A 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0130 8B 75 34                    MOV ESI, DWORD PTR 00000034[EBP]
00008: 0133 89 74 DF 40                 MOV DWORD PTR 00000040[EDI][EBX*8], ESI

; 73: }

00000: 0137                     L0000:
00000: 0137                             epilog 
00000: 0137 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 013A 5F                          POP EDI
00000: 013B 5E                          POP ESI
00000: 013C 5B                          POP EBX
00000: 013D 5D                          POP EBP
00000: 013E C3                          RETN 

Function: _allocReact

; 76: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 18                    SUB ESP, 00000018
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 AB                          STOSD 
00000: 0017                             prolog 

; 77:   if(nrt0+nrt1==0)

00008: 0017 8B 55 14                    MOV EDX, DWORD PTR 00000014[EBP]
00008: 001A 03 55 0C                    ADD EDX, DWORD PTR 0000000C[EBP]
00008: 001D 83 FA 00                    CMP EDX, 00000000
00008: 0020 75 0D                       JNE L0001

; 78:     return 0;  

00008: 0022 B8 00000000                 MOV EAX, 00000000
00000: 0027                             epilog 
00000: 0027 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 002A 5F                          POP EDI
00000: 002B 5E                          POP ESI
00000: 002C 5B                          POP EBX
00000: 002D 5D                          POP EBP
00000: 002E C3                          RETN 
00008: 002F                     L0001:

; 79:   if(!nrt0)

00008: 002F 83 7D 14 00                 CMP DWORD PTR 00000014[EBP], 00000000
00008: 0033 75 13                       JNE L0002

; 81:       react=react1;

00008: 0035 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0038 A3 00000000                 MOV DWORD PTR _react, EAX

; 82:       return nrt1;

00008: 003D 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00000: 0040                             epilog 
00000: 0040 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0043 5F                          POP EDI
00000: 0044 5E                          POP ESI
00000: 0045 5B                          POP EBX
00000: 0046 5D                          POP EBP
00000: 0047 C3                          RETN 
00008: 0048                     L0002:

; 84:   if(!nrt1)

00008: 0048 83 7D 0C 00                 CMP DWORD PTR 0000000C[EBP], 00000000
00008: 004C 75 13                       JNE L0003

; 86:       react=react0;

00008: 004E 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0051 A3 00000000                 MOV DWORD PTR _react, EAX

; 87:       return nrt0;

00008: 0056 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00000: 0059                             epilog 
00000: 0059 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 005C 5F                          POP EDI
00000: 005D 5E                          POP ESI
00000: 005E 5B                          POP EBX
00000: 005F 5D                          POP EBP
00000: 0060 C3                          RETN 
00008: 0061                     L0003:

; 89:   if((nrt1>0)&&(nrt0>0))

00008: 0061 83 7D 0C 00                 CMP DWORD PTR 0000000C[EBP], 00000000
00008: 0065 0F 8E 00000340              JLE L0004
00008: 006B 83 7D 14 00                 CMP DWORD PTR 00000014[EBP], 00000000
00008: 006F 0F 8E 00000336              JLE L0004

; 92:       k=0;

00008: 0075 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 93:       for(i=1;i<=nrt0;i++)

00008: 007C C7 45 FFFFFFE8 00000001     MOV DWORD PTR FFFFFFE8[EBP], 00000001
00008: 0083 E9 00000165                 JMP L0005
00008: 0088                     L0006:

; 95: 	  for(j=1;j<=nrt1;j++)

00008: 0088 C7 45 FFFFFFEC 00000001     MOV DWORD PTR FFFFFFEC[EBP], 00000001
00008: 008F E9 0000014A                 JMP L0007
00008: 0094                     L0008:

; 97: 	    if(react1[j].bond)

00008: 0094 8B 5D FFFFFFEC              MOV EBX, DWORD PTR FFFFFFEC[EBP]
00008: 0097 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 009A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009D 66 83 7C D8 18 00           CMP WORD PTR 00000018[EAX][EBX*8], 0000
00008: 00A3 0F 84 0000009C              JE L0009

; 99: 		if(((react0[i].new1==react1[j].new1)&&(react0[i].new2==react1[j].new2))||

00008: 00A9 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 00AC 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 00AF 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 00B2 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 00B5 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 00B8 66 8B 5C D8 14              MOV BX, WORD PTR 00000014[EAX][EBX*8]
00008: 00BD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00C0 66 8B 54 F0 14              MOV DX, WORD PTR 00000014[EAX][ESI*8]
00008: 00C5 66 39 D3                    CMP BX, DX
00008: 00C8 75 21                       JNE L000A
00008: 00CA 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 00CD 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 00D0 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 00D3 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 00D6 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 00D9 66 8B 5C D8 16              MOV BX, WORD PTR 00000016[EAX][EBX*8]
00008: 00DE 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00E1 66 8B 54 F0 16              MOV DX, WORD PTR 00000016[EAX][ESI*8]
00008: 00E6 66 39 D3                    CMP BX, DX
00008: 00E9 74 42                       JE L000B
00008: 00EB                     L000A:
00008: 00EB 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 00EE 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 00F1 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 00F4 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 00F7 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 00FA 66 8B 5C D8 14              MOV BX, WORD PTR 00000014[EAX][EBX*8]
00008: 00FF 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0102 66 8B 54 F0 16              MOV DX, WORD PTR 00000016[EAX][ESI*8]
00008: 0107 66 39 D3                    CMP BX, DX
00008: 010A 75 39                       JNE L000C
00008: 010C 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 010F 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 0112 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0115 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0118 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 011B 66 8B 5C D8 16              MOV BX, WORD PTR 00000016[EAX][EBX*8]
00008: 0120 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0123 66 8B 54 F0 14              MOV DX, WORD PTR 00000014[EAX][ESI*8]
00008: 0128 66 39 D3                    CMP BX, DX
00008: 012B 75 18                       JNE L000C
00008: 012D                     L000B:

; 102: 		    react0[i].old1=0;

00008: 012D 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0130 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0133 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0136 66 C7 44 D8 10 0000         MOV WORD PTR 00000010[EAX][EBX*8], 0000

; 103: 		    k++;

00008: 013D FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]

; 104:                     break;

00008: 0140 E9 000000A5                 JMP L000D
00008: 0145                     L000C:

; 106: 	      }

00008: 0145                     L0009:

; 107: 	  if(((react0[i].old1==react1[j].old1)&&(react0[i].old2==react1[j].old2))||

00008: 0145 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 0148 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 014B 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 014E 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0151 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0154 66 8B 5C D8 10              MOV BX, WORD PTR 00000010[EAX][EBX*8]
00008: 0159 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 015C 66 8B 54 F0 10              MOV DX, WORD PTR 00000010[EAX][ESI*8]
00008: 0161 66 39 D3                    CMP BX, DX
00008: 0164 75 21                       JNE L000E
00008: 0166 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 0169 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 016C 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 016F 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0172 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0175 66 8B 5C D8 12              MOV BX, WORD PTR 00000012[EAX][EBX*8]
00008: 017A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 017D 66 8B 54 F0 12              MOV DX, WORD PTR 00000012[EAX][ESI*8]
00008: 0182 66 39 D3                    CMP BX, DX
00008: 0185 74 42                       JE L000F
00008: 0187                     L000E:
00008: 0187 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 018A 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 018D 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0190 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0193 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0196 66 8B 5C D8 10              MOV BX, WORD PTR 00000010[EAX][EBX*8]
00008: 019B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 019E 66 8B 54 F0 12              MOV DX, WORD PTR 00000012[EAX][ESI*8]
00008: 01A3 66 39 D3                    CMP BX, DX
00008: 01A6 75 33                       JNE L0010
00008: 01A8 8B 75 FFFFFFEC              MOV ESI, DWORD PTR FFFFFFEC[EBP]
00008: 01AB 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 01AE 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 01B1 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01B4 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 01B7 66 8B 5C D8 12              MOV BX, WORD PTR 00000012[EAX][EBX*8]
00008: 01BC 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01BF 66 8B 54 F0 10              MOV DX, WORD PTR 00000010[EAX][ESI*8]
00008: 01C4 66 39 D3                    CMP BX, DX
00008: 01C7 75 12                       JNE L0010
00008: 01C9                     L000F:

; 110: 	      react0[i].bond=-1;

00008: 01C9 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 01CC 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01CF 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 01D2 66 C7 44 D8 18 FFFFFFFF     MOV WORD PTR 00000018[EAX][EBX*8], FFFFFFFF

; 111: 	      break;

00008: 01D9 EB 0F                       JMP L000D
00008: 01DB                     L0010:

; 113: 	  }

00008: 01DB FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 01DE                     L0007:
00008: 01DE 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 01E1 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 01E4 0F 8E FFFFFEAA              JLE L0008
00008: 01EA                     L000D:

; 114: 	}

00008: 01EA FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 01ED                     L0005:
00008: 01ED 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 01F0 3B 45 14                    CMP EAX, DWORD PTR 00000014[EBP]
00008: 01F3 0F 8E FFFFFE8F              JLE L0006

; 115:       nrt=nrt1+nrt0-k;

00008: 01F9 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 01FC 03 55 14                    ADD EDX, DWORD PTR 00000014[EBP]
00008: 01FF 2B 55 FFFFFFF0              SUB EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0202 89 15 00000000              MOV DWORD PTR _nrt, EDX

; 116:       react=(ReactionData *)malloc((nrt+1)*sizeof(ReactionData));

00008: 0208 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 020E 42                          INC EDX
00008: 020F 6B D2 28                    IMUL EDX, EDX, 00000028
00008: 0212 52                          PUSH EDX
00008: 0213 E8 00000000                 CALL SHORT _malloc
00008: 0218 59                          POP ECX
00008: 0219 A3 00000000                 MOV DWORD PTR _react, EAX

; 117:       if(!react){StopAlert (MEMORY_ALRT);return -1;}      

00008: 021E 83 3D 00000000 00           CMP DWORD PTR _react, 00000000
00008: 0225 75 15                       JNE L0011
00008: 0227 6A 02                       PUSH 00000002
00008: 0229 E8 00000000                 CALL SHORT _StopAlert
00008: 022E 59                          POP ECX
00008: 022F B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0234                             epilog 
00000: 0234 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0237 5F                          POP EDI
00000: 0238 5E                          POP ESI
00000: 0239 5B                          POP EBX
00000: 023A 5D                          POP EBP
00000: 023B C3                          RETN 
00008: 023C                     L0011:

; 118:       for(i=1;i<=nrt1;i++)

00008: 023C C7 45 FFFFFFE8 00000001     MOV DWORD PTR FFFFFFE8[EBP], 00000001
00008: 0243 EB 34                       JMP L0012
00008: 0245                     L0013:

; 119: 	react[i]=react1[i];

00008: 0245 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0248 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00008: 024B 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 024E 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 0251 8D 04 91                    LEA EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 0254 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00008: 0257 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 025A 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 025D 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0263 8D 3C DA                    LEA EDI, DWORD PTR 00000000[EDX][EBX*8]
00008: 0266 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 0269 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 026C 8D 34 C8                    LEA ESI, DWORD PTR 00000000[EAX][ECX*8]
00008: 026F B9 0000000A                 MOV ECX, 0000000A
00008: 0274 F3 A5                       REP MOVSD 
00008: 0276 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 0279                     L0012:
00008: 0279 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 027C 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 027F 7E FFFFFFC4                 JLE L0013

; 120:       k=nrt1;

00008: 0281 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0284 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 121:       for(i=1;i<=nrt0;i++)

00008: 0287 C7 45 FFFFFFE8 00000001     MOV DWORD PTR FFFFFFE8[EBP], 00000001
00008: 028E EB 48                       JMP L0014
00008: 0290                     L0015:

; 122: 	if(react0[i].old1>0)

00008: 0290 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0293 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0296 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0299 66 83 7C D8 10 00           CMP WORD PTR 00000010[EAX][EBX*8], 0000
00008: 029F 7E 34                       JLE L0016

; 124: 	    k++;

00008: 02A1 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]

; 125: 	    react[k]=react0[i];

00008: 02A4 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 02A7 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX
00008: 02AA 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 02AD 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 02B0 8D 04 91                    LEA EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 02B3 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX
00008: 02B6 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 02B9 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 02BC 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 02C2 8D 3C DA                    LEA EDI, DWORD PTR 00000000[EDX][EBX*8]
00008: 02C5 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 02C8 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 02CB 8D 34 C8                    LEA ESI, DWORD PTR 00000000[EAX][ECX*8]
00008: 02CE B9 0000000A                 MOV ECX, 0000000A
00008: 02D3 F3 A5                       REP MOVSD 

; 126: 	  }

00008: 02D5                     L0016:
00008: 02D5 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 02D8                     L0014:
00008: 02D8 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 02DB 3B 45 14                    CMP EAX, DWORD PTR 00000014[EBP]
00008: 02DE 7E FFFFFFB0                 JLE L0015

; 127:       free(react1);

00008: 02E0 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 02E3 E8 00000000                 CALL SHORT _free
00008: 02E8 59                          POP ECX

; 128:       free(react0);

00008: 02E9 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 02EC E8 00000000                 CALL SHORT _free
00008: 02F1 59                          POP ECX

; 129:       for (i=1;i<=nrt;i++)

00008: 02F2 C7 45 FFFFFFE8 00000001     MOV DWORD PTR FFFFFFE8[EBP], 00000001
00008: 02F9 E9 00000091                 JMP L0017
00008: 02FE                     L0018:

; 130: 	printf("%d %d %d %d %d %lf %lf\n",react[i].old1,react[i].old2,

00008: 02FE 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0301 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0304 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 030A FF 74 DA 04                 PUSH DWORD PTR 00000004[EDX][EBX*8]
00008: 030E FF 34 DA                    PUSH DWORD PTR 00000000[EDX][EBX*8]
00008: 0311 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0314 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0317 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 031D FF 74 DA 0C                 PUSH DWORD PTR 0000000C[EDX][EBX*8]
00008: 0321 FF 74 DA 08                 PUSH DWORD PTR 00000008[EDX][EBX*8]
00008: 0325 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0328 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 032B 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0331 0F BF 44 DE 18              MOVSX EAX, WORD PTR 00000018[ESI][EBX*8]
00008: 0336 50                          PUSH EAX
00008: 0337 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 033A 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 033D 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0343 0F BF 44 DE 16              MOVSX EAX, WORD PTR 00000016[ESI][EBX*8]
00008: 0348 50                          PUSH EAX
00008: 0349 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 034C 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 034F 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0355 0F BF 44 DE 14              MOVSX EAX, WORD PTR 00000014[ESI][EBX*8]
00008: 035A 50                          PUSH EAX
00008: 035B 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 035E 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0361 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0367 0F BF 44 DE 12              MOVSX EAX, WORD PTR 00000012[ESI][EBX*8]
00008: 036C 50                          PUSH EAX
00008: 036D 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 0370 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0373 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0379 0F BF 44 DE 10              MOVSX EAX, WORD PTR 00000010[ESI][EBX*8]
00008: 037E 50                          PUSH EAX
00008: 037F 68 00000000                 PUSH OFFSET @141
00008: 0384 E8 00000000                 CALL SHORT _printf
00008: 0389 83 C4 28                    ADD ESP, 00000028
00008: 038C FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 038F                     L0017:
00008: 038F 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0392 3B 05 00000000              CMP EAX, DWORD PTR _nrt
00008: 0398 0F 8E FFFFFF60              JLE L0018

; 132:       return nrt;

00008: 039E A1 00000000                 MOV EAX, DWORD PTR _nrt
00000: 03A3                             epilog 
00000: 03A3 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03A6 5F                          POP EDI
00000: 03A7 5E                          POP ESI
00000: 03A8 5B                          POP EBX
00000: 03A9 5D                          POP EBP
00000: 03AA C3                          RETN 
00008: 03AB                     L0004:

; 134: }

00000: 03AB                     L0000:
00000: 03AB                             epilog 
00000: 03AB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03AE 5F                          POP EDI
00000: 03AF 5E                          POP ESI
00000: 03B0 5B                          POP EBX
00000: 03B1 5D                          POP EBP
00000: 03B2 C3                          RETN 

Function: _write_key_coord

; 137: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 81 EC 000002A0              SUB ESP, 000002A0
00000: 000B 57                          PUSH EDI
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0015 B9 000000A8                 MOV ECX, 000000A8
00000: 001A F3 AB                       REP STOSD 
00000: 001C 5F                          POP EDI
00000: 001D                             prolog 

; 141:    int fErr=noErr;

00008: 001D C7 85 FFFFFD6C00000000      MOV DWORD PTR FFFFFD6C[EBP], 00000000

; 142:    long free=get_free();

00008: 0027 E8 00000000                 CALL SHORT _get_free
00008: 002C 89 85 FFFFFD70              MOV DWORD PTR FFFFFD70[EBP], EAX

; 143:    double dlmin=bound[0].dl;

00008: 0032 DD 05 00000008              FLD QWORD PTR _bound+00000008
00007: 0038 DD 9D FFFFFD80              FSTP QWORD PTR FFFFFD80[EBP]

; 144:    double corr=get_corr();

00008: 003E E8 00000000                 CALL SHORT _get_corr
00007: 0043 DD 9D FFFFFD88              FSTP QWORD PTR FFFFFD88[EBP]

; 145:    double mf=get_maxfree();

00008: 0049 E8 00000000                 CALL SHORT _get_maxfree
00008: 004E 89 85 FFFFFDE8              MOV DWORD PTR FFFFFDE8[EBP], EAX
00008: 0054 DB 85 FFFFFDE8              FILD DWORD PTR FFFFFDE8[EBP]
00007: 005A DD 9D FFFFFD90              FSTP QWORD PTR FFFFFD90[EBP]

; 146:    moved_atom * a=(moved_atom *)get_atom();

00008: 0060 E8 00000000                 CALL SHORT _get_atom
00008: 0065 89 85 FFFFFD74              MOV DWORD PTR FFFFFD74[EBP], EAX

; 147:    moveatoms();

00008: 006B E8 00000000                 CALL SHORT _moveatoms

; 148:    if(bound[1].dl<dlmin)dlmin=bound[1].dl;

00008: 0070 DD 05 00000020              FLD QWORD PTR _bound+00000020
00007: 0076 DD 85 FFFFFD80              FLD QWORD PTR FFFFFD80[EBP]
00006: 007C F1DF                        FCOMIP ST, ST(1), L0001
00007: 007E DD D8                       FSTP ST
00008: 0080 7A 0E                       JP L0001
00008: 0082 76 0C                       JBE L0001
00008: 0084 DD 05 00000020              FLD QWORD PTR _bound+00000020
00007: 008A DD 9D FFFFFD80              FSTP QWORD PTR FFFFFD80[EBP]
00008: 0090                     L0001:

; 149:    if(bound[2].dl<dlmin)dlmin=bound[2].dl;

00008: 0090 DD 05 00000038              FLD QWORD PTR _bound+00000038
00007: 0096 DD 85 FFFFFD80              FLD QWORD PTR FFFFFD80[EBP]
00006: 009C F1DF                        FCOMIP ST, ST(1), L0002
00007: 009E DD D8                       FSTP ST
00008: 00A0 7A 0E                       JP L0002
00008: 00A2 76 0C                       JBE L0002
00008: 00A4 DD 05 00000038              FLD QWORD PTR _bound+00000038
00007: 00AA DD 9D FFFFFD80              FSTP QWORD PTR FFFFFD80[EBP]
00008: 00B0                     L0002:

; 150:    nbyte=sprintf(&s[0],

00008: 00B0 E8 00000000                 CALL SHORT _get_time
00007: 00B5 DD 9D FFFFFDD8              FSTP QWORD PTR FFFFFDD8[EBP]
00008: 00BB E8 00000000                 CALL SHORT _get_ll
00008: 00C0 50                          PUSH EAX
00008: 00C1 FF B5 FFFFFD8C              PUSH DWORD PTR FFFFFD8C[EBP]
00008: 00C7 FF B5 FFFFFD88              PUSH DWORD PTR FFFFFD88[EBP]
00008: 00CD FF B5 FFFFFD70              PUSH DWORD PTR FFFFFD70[EBP]
00008: 00D3 FF B5 FFFFFDDC              PUSH DWORD PTR FFFFFDDC[EBP]
00008: 00D9 FF B5 FFFFFDD8              PUSH DWORD PTR FFFFFDD8[EBP]
00008: 00DF 68 00000000                 PUSH OFFSET @372
00008: 00E4 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 00EA 50                          PUSH EAX
00008: 00EB E8 00000000                 CALL SHORT _sprintf
00008: 00F0 83 C4 20                    ADD ESP, 00000020
00008: 00F3 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 153:    if(nbyte<=0) fErr=-1;    

00008: 00F9 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0100 7F 0A                       JG L0003
00008: 0102 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 010C                     L0003:

; 154:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 010C 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0113 75 2C                       JNE L0004
00008: 0115 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0118 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 011E 6A 01                       PUSH 00000001
00008: 0120 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0126 50                          PUSH EAX
00008: 0127 E8 00000000                 CALL SHORT _fwrite
00008: 012C 83 C4 10                    ADD ESP, 00000010
00008: 012F 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0135 0F 95 C2                    SETNE DL
00008: 0138 83 E2 01                    AND EDX, 00000001
00008: 013B 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0141                     L0004:

; 155:    if(fErr==noErr)

00008: 0141 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0148 0F 85 000000BA              JNE L0005

; 157:        if(dim<3)     

00008: 014E DD 05 00000000              FLD QWORD PTR _dim
00007: 0154 DD 05 00000000              FLD QWORD PTR .data+00000088
00006: 015A F1DF                        FCOMIP ST, ST(1), L0006
00007: 015C DD D8                       FSTP ST
00008: 015E 7A 50                       JP L0006
00008: 0160 76 4E                       JBE L0006

; 158: 	 nbyte=sprintf(&s[0],"%s\n%.7lf %.7lf\n%s\n%ld\n",

00008: 0162 A1 00000000                 MOV EAX, DWORD PTR _write_n1
00008: 0167 50                          PUSH EAX
00008: 0168 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 016E 8B 42 08                    MOV EAX, DWORD PTR 00000008[EDX]
00008: 0171 50                          PUSH EAX
00008: 0172 FF 35 0000001C              PUSH DWORD PTR _bound+0000001C
00008: 0178 FF 35 00000018              PUSH DWORD PTR _bound+00000018
00008: 017E FF 35 00000004              PUSH DWORD PTR _bound+00000004
00008: 0184 FF 35 00000000              PUSH DWORD PTR _bound
00008: 018A 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0190 8B 42 04                    MOV EAX, DWORD PTR 00000004[EDX]
00008: 0193 50                          PUSH EAX
00008: 0194 68 00000000                 PUSH OFFSET @373
00008: 0199 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 019F 50                          PUSH EAX
00008: 01A0 E8 00000000                 CALL SHORT _sprintf
00008: 01A5 83 C4 24                    ADD ESP, 00000024
00008: 01A8 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 01AE EB 58                       JMP L0007
00008: 01B0                     L0006:

; 162: 	 nbyte=sprintf(&s[0],"%s\n%.7lf %.7lf %.7lf\n%s\n%ld\n",

00008: 01B0 A1 00000000                 MOV EAX, DWORD PTR _write_n1
00008: 01B5 50                          PUSH EAX
00008: 01B6 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 01BC 8B 42 08                    MOV EAX, DWORD PTR 00000008[EDX]
00008: 01BF 50                          PUSH EAX
00008: 01C0 FF 35 00000034              PUSH DWORD PTR _bound+00000034
00008: 01C6 FF 35 00000030              PUSH DWORD PTR _bound+00000030
00008: 01CC FF 35 0000001C              PUSH DWORD PTR _bound+0000001C
00008: 01D2 FF 35 00000018              PUSH DWORD PTR _bound+00000018
00008: 01D8 FF 35 00000004              PUSH DWORD PTR _bound+00000004
00008: 01DE FF 35 00000000              PUSH DWORD PTR _bound
00008: 01E4 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 01EA 8B 42 04                    MOV EAX, DWORD PTR 00000004[EDX]
00008: 01ED 50                          PUSH EAX
00008: 01EE 68 00000000                 PUSH OFFSET @374
00008: 01F3 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 01F9 50                          PUSH EAX
00008: 01FA E8 00000000                 CALL SHORT _sprintf
00008: 01FF 83 C4 2C                    ADD ESP, 0000002C
00008: 0202 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0208                     L0007:

; 164:      }

00008: 0208                     L0005:

; 165:    if(nbyte<=0) fErr=-1;    

00008: 0208 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 020F 7F 0A                       JG L0008
00008: 0211 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 021B                     L0008:

; 166:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 021B 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0222 75 2C                       JNE L0009
00008: 0224 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0227 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 022D 6A 01                       PUSH 00000001
00008: 022F 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0235 50                          PUSH EAX
00008: 0236 E8 00000000                 CALL SHORT _fwrite
00008: 023B 83 C4 10                    ADD ESP, 00000010
00008: 023E 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0244 0F 95 C2                    SETNE DL
00008: 0247 83 E2 01                    AND EDX, 00000001
00008: 024A 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0250                     L0009:

; 167:    if(fErr==noErr)

00008: 0250 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0257 75 24                       JNE L000A

; 168:      nbyte=sprintf(&s[0],"%s\n//type,mass,ellastic radius,interaction radius\n",

00008: 0259 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 025F 8B 42 0C                    MOV EAX, DWORD PTR 0000000C[EDX]
00008: 0262 50                          PUSH EAX
00008: 0263 68 00000000                 PUSH OFFSET @375
00008: 0268 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 026E 50                          PUSH EAX
00008: 026F E8 00000000                 CALL SHORT _sprintf
00008: 0274 83 C4 0C                    ADD ESP, 0000000C
00008: 0277 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 027D                     L000A:

; 170:    if(nbyte<=0) fErr=-1;    

00008: 027D 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0284 7F 0A                       JG L000B
00008: 0286 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0290                     L000B:

; 171:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 

00008: 0290 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0297 75 2C                       JNE L000C
00008: 0299 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 029C FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 02A2 6A 01                       PUSH 00000001
00008: 02A4 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 02AA 50                          PUSH EAX
00008: 02AB E8 00000000                 CALL SHORT _fwrite
00008: 02B0 83 C4 10                    ADD ESP, 00000010
00008: 02B3 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 02B9 0F 95 C2                    SETNE DL
00008: 02BC 83 E2 01                    AND EDX, 00000001
00008: 02BF 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 02C5                     L000C:

; 172:    if(fErr==noErr) 

00008: 02C5 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 02CC 0F 85 0000010A              JNE L000D

; 173:      for(k=1;k<=nat;k++)

00008: 02D2 C7 85 FFFFFD6800000001      MOV DWORD PTR FFFFFD68[EBP], 00000001
00008: 02DC E9 000000E9                 JMP L000E
00008: 02E1                     L000F:

; 175: 	 nbyte=sprintf(&s[0],"%ld %lf %lf %lf\n",k,sam[k].m,sam[k].s,sam[k].b);

00008: 02E1 8B 95 FFFFFD68              MOV EDX, DWORD PTR FFFFFD68[EBP]
00008: 02E7 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02EE 29 D3                       SUB EBX, EDX
00008: 02F0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02F3 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 02F9 FF B4 DA 00000094           PUSH DWORD PTR 00000094[EDX][EBX*8]
00008: 0300 FF B4 DA 00000090           PUSH DWORD PTR 00000090[EDX][EBX*8]
00008: 0307 8B 95 FFFFFD68              MOV EDX, DWORD PTR FFFFFD68[EBP]
00008: 030D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0314 29 D3                       SUB EBX, EDX
00008: 0316 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0319 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 031F FF B4 DA 0000009C           PUSH DWORD PTR 0000009C[EDX][EBX*8]
00008: 0326 FF B4 DA 00000098           PUSH DWORD PTR 00000098[EDX][EBX*8]
00008: 032D 8B 95 FFFFFD68              MOV EDX, DWORD PTR FFFFFD68[EBP]
00008: 0333 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 033A 29 D3                       SUB EBX, EDX
00008: 033C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 033F 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0345 FF B4 DA 0000008C           PUSH DWORD PTR 0000008C[EDX][EBX*8]
00008: 034C FF B4 DA 00000088           PUSH DWORD PTR 00000088[EDX][EBX*8]
00008: 0353 FF B5 FFFFFD68              PUSH DWORD PTR FFFFFD68[EBP]
00008: 0359 68 00000000                 PUSH OFFSET @376
00008: 035E 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0364 50                          PUSH EAX
00008: 0365 E8 00000000                 CALL SHORT _sprintf
00008: 036A 83 C4 24                    ADD ESP, 00000024
00008: 036D 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 176: 	 if(nbyte<=0) fErr=-1;

00008: 0373 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 037A 7F 0A                       JG L0010
00008: 037C C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0386                     L0010:

; 177: 	 if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 0386 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 038D 75 2C                       JNE L0011
00008: 038F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0392 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 0398 6A 01                       PUSH 00000001
00008: 039A 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 03A0 50                          PUSH EAX
00008: 03A1 E8 00000000                 CALL SHORT _fwrite
00008: 03A6 83 C4 10                    ADD ESP, 00000010
00008: 03A9 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 03AF 0F 95 C2                    SETNE DL
00008: 03B2 83 E2 01                    AND EDX, 00000001
00008: 03B5 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 03BB                     L0011:

; 178: 	 if(fErr!=noErr)break;

00008: 03BB 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 03C2 75 18                       JNE L0012

; 179:        }

00008: 03C4 FF 85 FFFFFD68              INC DWORD PTR FFFFFD68[EBP]
00008: 03CA                     L000E:
00008: 03CA 8B 85 FFFFFD68              MOV EAX, DWORD PTR FFFFFD68[EBP]
00008: 03D0 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 03D6 0F 8E FFFFFF05              JLE L000F
00008: 03DC                     L0012:
00008: 03DC                     L000D:

; 184:    if(fErr==noErr)

00008: 03DC 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 03E3 75 24                       JNE L0013

; 185:      nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist, interaction distance, energy\n"

00008: 03E5 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 03EB 8B 42 10                    MOV EAX, DWORD PTR 00000010[EDX]
00008: 03EE 50                          PUSH EAX
00008: 03EF 68 00000000                 PUSH OFFSET @377
00008: 03F4 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 03FA 50                          PUSH EAX
00008: 03FB E8 00000000                 CALL SHORT _sprintf
00008: 0400 83 C4 0C                    ADD ESP, 0000000C
00008: 0403 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0409                     L0013:

; 187:    if(nbyte<=0) fErr=-1;    

00008: 0409 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0410 7F 0A                       JG L0014
00008: 0412 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 041C                     L0014:

; 188:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 

00008: 041C 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0423 75 2C                       JNE L0015
00008: 0425 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0428 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 042E 6A 01                       PUSH 00000001
00008: 0430 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0436 50                          PUSH EAX
00008: 0437 E8 00000000                 CALL SHORT _fwrite
00008: 043C 83 C4 10                    ADD ESP, 00000010
00008: 043F 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0445 0F 95 C2                    SETNE DL
00008: 0448 83 E2 01                    AND EDX, 00000001
00008: 044B 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0451                     L0015:

; 189:    if(fErr==noErr) 

00008: 0451 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0458 0F 85 00000257              JNE L0016

; 190:      for(i=1;i<=nat;i++)

00008: 045E C7 85 FFFFFD6000000001      MOV DWORD PTR FFFFFD60[EBP], 00000001
00008: 0468 E9 00000236                 JMP L0017
00008: 046D                     L0018:

; 191:        for(j=1;j<=i;j++)

00008: 046D C7 85 FFFFFD6400000001      MOV DWORD PTR FFFFFD64[EBP], 00000001
00008: 0477 E9 0000020F                 JMP L0019
00008: 047C                     L001A:

; 193: 	   k=ecoll[i][j];

00008: 047C 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0482 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 0488 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 048B 8B 8D FFFFFD64              MOV ECX, DWORD PTR FFFFFD64[EBP]
00008: 0491 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0494 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX

; 194: 	   if(coll[k].next>-1)

00008: 049A 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 04A0 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 04A3 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 04A9 83 7C DA 38 FFFFFFFF        CMP DWORD PTR 00000038[EDX][EBX*8], FFFFFFFF
00008: 04AE 0F 8E 000001D1              JLE L001B

; 197:                int sbyte=0;

00008: 04B4 C7 85 FFFFFD7800000000      MOV DWORD PTR FFFFFD78[EBP], 00000000

; 198: 	       while(coll[k].next>-1)

00008: 04BE EB 19                       JMP L001C
00008: 04C0                     L001D:

; 199: 		 k=coll[k].next;

00008: 04C0 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 04C6 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 04C9 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 04CF 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 04D3 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX
00008: 04D9                     L001C:
00008: 04D9 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 04DF 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 04E2 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 04E8 83 7C DA 38 FFFFFFFF        CMP DWORD PTR 00000038[EDX][EBX*8], FFFFFFFF
00008: 04ED 7F FFFFFFD1                 JG L001D

; 200: 	       dd=sqrt(coll[k].dd);

00008: 04EF 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 04F5 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 04F8 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 04FE FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 0502 FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 0506 E8 00000000                 CALL SHORT _sqrt
00007: 050B 59                          POP ECX
00007: 050C 59                          POP ECX
00007: 050D DD 9D FFFFFD98              FSTP QWORD PTR FFFFFD98[EBP]

; 201: 	       nbyte=sprintf(&s[0],"%d %d %lf \n",i,j,dd);

00008: 0513 FF B5 FFFFFD9C              PUSH DWORD PTR FFFFFD9C[EBP]
00008: 0519 FF B5 FFFFFD98              PUSH DWORD PTR FFFFFD98[EBP]
00008: 051F FF B5 FFFFFD64              PUSH DWORD PTR FFFFFD64[EBP]
00008: 0525 FF B5 FFFFFD60              PUSH DWORD PTR FFFFFD60[EBP]
00008: 052B 68 00000000                 PUSH OFFSET @378
00008: 0530 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0536 50                          PUSH EAX
00008: 0537 E8 00000000                 CALL SHORT _sprintf
00008: 053C 83 C4 18                    ADD ESP, 00000018
00008: 053F 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 202:                sbyte+=nbyte-1; 

00008: 0545 8B 95 FFFFFD5C              MOV EDX, DWORD PTR FFFFFD5C[EBP]
00008: 054B 4A                          DEC EDX
00008: 054C 01 95 FFFFFD78              ADD DWORD PTR FFFFFD78[EBP], EDX

; 203: 	       if(nbyte<=0) 

00008: 0552 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0559 0F 8F 000000C4              JG L001E

; 204: 		 fErr=-1;

00008: 055F C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0569 E9 000000CF                 JMP L001F
00008: 056E                     L0020:

; 208: 		     k=coll[k].prev;

00008: 056E 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0574 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0577 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 057D 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0581 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX

; 209: 		     dd=sqrt(coll[k].dd);

00008: 0587 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 058D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0590 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0596 FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 059A FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 059E E8 00000000                 CALL SHORT _sqrt
00007: 05A3 59                          POP ECX
00007: 05A4 59                          POP ECX
00007: 05A5 DD 9D FFFFFD98              FSTP QWORD PTR FFFFFD98[EBP]

; 210: 		     en=-coll[k].eo;

00008: 05AB 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 05B1 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 05B4 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 05BA DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 05BE D9 E0                       FCHS 
00007: 05C0 DD 9D FFFFFDA0              FSTP QWORD PTR FFFFFDA0[EBP]

; 211: 		     nbyte=sprintf(&s[sbyte],"%lf %lf \n",dd,en);

00008: 05C6 FF B5 FFFFFDA4              PUSH DWORD PTR FFFFFDA4[EBP]
00008: 05CC FF B5 FFFFFDA0              PUSH DWORD PTR FFFFFDA0[EBP]
00008: 05D2 FF B5 FFFFFD9C              PUSH DWORD PTR FFFFFD9C[EBP]
00008: 05D8 FF B5 FFFFFD98              PUSH DWORD PTR FFFFFD98[EBP]
00008: 05DE 68 00000000                 PUSH OFFSET @379
00008: 05E3 8D 95 FFFFFDF4              LEA EDX, DWORD PTR FFFFFDF4[EBP]
00008: 05E9 03 95 FFFFFD78              ADD EDX, DWORD PTR FFFFFD78[EBP]
00008: 05EF 52                          PUSH EDX
00008: 05F0 E8 00000000                 CALL SHORT _sprintf
00008: 05F5 83 C4 18                    ADD ESP, 00000018
00008: 05F8 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 212: 		     sbyte+=nbyte-1; 

00008: 05FE 8B 95 FFFFFD5C              MOV EDX, DWORD PTR FFFFFD5C[EBP]
00008: 0604 4A                          DEC EDX
00008: 0605 01 95 FFFFFD78              ADD DWORD PTR FFFFFD78[EBP], EDX

; 213: 		     if(nbyte<=0){fErr=-1;goto hell;}

00008: 060B 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0612 7F 0F                       JG L0021
00008: 0614 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 061E E9 00000C07                 JMP L0022
00008: 0623                     L0021:

; 214: 		   } 

00008: 0623                     L001E:
00008: 0623 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0629 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 062C 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0632 83 7C DA 3C FFFFFFFF        CMP DWORD PTR 0000003C[EDX][EBX*8], FFFFFFFF
00008: 0637 0F 8F FFFFFF31              JG L0020
00008: 063D                     L001F:

; 215: 	       sbyte++;

00008: 063D FF 85 FFFFFD78              INC DWORD PTR FFFFFD78[EBP]

; 216: 	       if(fErr==noErr)fErr=(fwrite(&s[0],1,sbyte,path)!=sbyte);

00008: 0643 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 064A 75 2C                       JNE L0023
00008: 064C FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 064F FF B5 FFFFFD78              PUSH DWORD PTR FFFFFD78[EBP]
00008: 0655 6A 01                       PUSH 00000001
00008: 0657 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 065D 50                          PUSH EAX
00008: 065E E8 00000000                 CALL SHORT _fwrite
00008: 0663 83 C4 10                    ADD ESP, 00000010
00008: 0666 39 85 FFFFFD78              CMP DWORD PTR FFFFFD78[EBP], EAX
00008: 066C 0F 95 C2                    SETNE DL
00008: 066F 83 E2 01                    AND EDX, 00000001
00008: 0672 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0678                     L0023:

; 217: 	       if(fErr!=noErr)goto hell;

00008: 0678 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 067F 0F 85 00000BA5              JNE L0022

; 218: 	     }

00008: 0685                     L001B:

; 219: 	 }

00008: 0685 FF 85 FFFFFD64              INC DWORD PTR FFFFFD64[EBP]
00008: 068B                     L0019:
00008: 068B 8B 85 FFFFFD64              MOV EAX, DWORD PTR FFFFFD64[EBP]
00008: 0691 3B 85 FFFFFD60              CMP EAX, DWORD PTR FFFFFD60[EBP]
00008: 0697 0F 8E FFFFFDDF              JLE L001A
00008: 069D FF 85 FFFFFD60              INC DWORD PTR FFFFFD60[EBP]
00008: 06A3                     L0017:
00008: 06A3 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 06A9 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 06AF 0F 8E FFFFFDB8              JLE L0018
00008: 06B5                     L0016:

; 221:   if(fErr==noErr)

00008: 06B5 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 06BC 75 24                       JNE L0024

; 222:   nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist\n",keywords[EL_COL]);

00008: 06BE 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 06C4 8B 42 14                    MOV EAX, DWORD PTR 00000014[EDX]
00008: 06C7 50                          PUSH EAX
00008: 06C8 68 00000000                 PUSH OFFSET @380
00008: 06CD 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 06D3 50                          PUSH EAX
00008: 06D4 E8 00000000                 CALL SHORT _sprintf
00008: 06D9 83 C4 0C                    ADD ESP, 0000000C
00008: 06DC 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 06E2                     L0024:

; 223:   if(nbyte<=0) fErr=-1;    

00008: 06E2 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 06E9 7F 0A                       JG L0025
00008: 06EB C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 06F5                     L0025:

; 224:   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 

00008: 06F5 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 06FC 75 2C                       JNE L0026
00008: 06FE FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0701 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 0707 6A 01                       PUSH 00000001
00008: 0709 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 070F 50                          PUSH EAX
00008: 0710 E8 00000000                 CALL SHORT _fwrite
00008: 0715 83 C4 10                    ADD ESP, 00000010
00008: 0718 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 071E 0F 95 C2                    SETNE DL
00008: 0721 83 E2 01                    AND EDX, 00000001
00008: 0724 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 072A                     L0026:

; 225:   if(fErr==noErr) 

00008: 072A 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0731 0F 85 00000143              JNE L0027

; 227:    if(fErr==noErr) 

00008: 0737 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 073E 0F 85 00000136              JNE L0028

; 228:      for(i=1;i<=nat;i++)

00008: 0744 C7 85 FFFFFD6000000001      MOV DWORD PTR FFFFFD60[EBP], 00000001
00008: 074E E9 00000115                 JMP L0029
00008: 0753                     L002A:

; 229:        for(j=1;j<=i;j++)

00008: 0753 C7 85 FFFFFD6400000001      MOV DWORD PTR FFFFFD64[EBP], 00000001
00008: 075D E9 000000EE                 JMP L002B
00008: 0762                     L002C:

; 231: 	   k=ecoll[i][j];

00008: 0762 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0768 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 076E 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0771 8B 8D FFFFFD64              MOV ECX, DWORD PTR FFFFFD64[EBP]
00008: 0777 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 077A 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX

; 232: 	   if(coll[k].next<0)

00008: 0780 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0786 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0789 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 078F 83 7C DA 38 00              CMP DWORD PTR 00000038[EDX][EBX*8], 00000000
00008: 0794 0F 8D 000000B0              JGE L002D

; 235: 	       dd=sqrt(coll[k].dd);

00008: 079A 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 07A0 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 07A3 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 07A9 FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 07AD FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 07B1 E8 00000000                 CALL SHORT _sqrt
00007: 07B6 59                          POP ECX
00007: 07B7 59                          POP ECX
00007: 07B8 DD 9D FFFFFDA8              FSTP QWORD PTR FFFFFDA8[EBP]

; 236: 	       nbyte=sprintf(&s[0],"%d %d %lf\n",i,j,dd);

00008: 07BE FF B5 FFFFFDAC              PUSH DWORD PTR FFFFFDAC[EBP]
00008: 07C4 FF B5 FFFFFDA8              PUSH DWORD PTR FFFFFDA8[EBP]
00008: 07CA FF B5 FFFFFD64              PUSH DWORD PTR FFFFFD64[EBP]
00008: 07D0 FF B5 FFFFFD60              PUSH DWORD PTR FFFFFD60[EBP]
00008: 07D6 68 00000000                 PUSH OFFSET @381
00008: 07DB 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 07E1 50                          PUSH EAX
00008: 07E2 E8 00000000                 CALL SHORT _sprintf
00008: 07E7 83 C4 18                    ADD ESP, 00000018
00008: 07EA 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 237: 	       if(nbyte<=0) 

00008: 07F0 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 07F7 7F 0F                       JG L002E

; 238: 		 {fErr=-1;goto hell;}

00008: 07F9 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0803 E9 00000A22                 JMP L0022
00008: 0808                     L002E:

; 239: 	       if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 0808 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 080F 75 2C                       JNE L002F
00008: 0811 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0814 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 081A 6A 01                       PUSH 00000001
00008: 081C 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0822 50                          PUSH EAX
00008: 0823 E8 00000000                 CALL SHORT _fwrite
00008: 0828 83 C4 10                    ADD ESP, 00000010
00008: 082B 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0831 0F 95 C2                    SETNE DL
00008: 0834 83 E2 01                    AND EDX, 00000001
00008: 0837 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 083D                     L002F:

; 240: 	       if(fErr!=noErr)goto hell;

00008: 083D 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0844 0F 85 000009E0              JNE L0022

; 241: 	     }

00008: 084A                     L002D:

; 242: 	 }

00008: 084A FF 85 FFFFFD64              INC DWORD PTR FFFFFD64[EBP]
00008: 0850                     L002B:
00008: 0850 8B 85 FFFFFD64              MOV EAX, DWORD PTR FFFFFD64[EBP]
00008: 0856 3B 85 FFFFFD60              CMP EAX, DWORD PTR FFFFFD60[EBP]
00008: 085C 0F 8E FFFFFF00              JLE L002C
00008: 0862 FF 85 FFFFFD60              INC DWORD PTR FFFFFD60[EBP]
00008: 0868                     L0029:
00008: 0868 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 086E 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0874 0F 8E FFFFFED9              JLE L002A
00008: 087A                     L0028:
00008: 087A                     L0027:

; 244:    nbyte=sprintf(&s[0],"%s\n//pair types, repulsive dist, attractive distance\n",

00008: 087A 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0880 8B 42 18                    MOV EAX, DWORD PTR 00000018[EDX]
00008: 0883 50                          PUSH EAX
00008: 0884 68 00000000                 PUSH OFFSET @382
00008: 0889 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 088F 50                          PUSH EAX
00008: 0890 E8 00000000                 CALL SHORT _sprintf
00008: 0895 83 C4 0C                    ADD ESP, 0000000C
00008: 0898 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 246:    if(nbyte<=0) fErr=-1;    

00008: 089E 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 08A5 7F 0A                       JG L0030
00008: 08A7 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 08B1                     L0030:

; 247:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   	 

00008: 08B1 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 08B8 75 2C                       JNE L0031
00008: 08BA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 08BD FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 08C3 6A 01                       PUSH 00000001
00008: 08C5 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 08CB 50                          PUSH EAX
00008: 08CC E8 00000000                 CALL SHORT _fwrite
00008: 08D1 83 C4 10                    ADD ESP, 00000010
00008: 08D4 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 08DA 0F 95 C2                    SETNE DL
00008: 08DD 83 E2 01                    AND EDX, 00000001
00008: 08E0 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 08E6                     L0031:

; 250:    if(fErr==noErr) 

00008: 08E6 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 08ED 0F 85 0000028C              JNE L0032

; 251:      for(i=1;i<=nat;i++)

00008: 08F3 C7 85 FFFFFD6000000001      MOV DWORD PTR FFFFFD60[EBP], 00000001
00008: 08FD E9 0000026B                 JMP L0033
00008: 0902                     L0034:

; 252:        for(j=1;j<=i;j++)

00008: 0902 C7 85 FFFFFD6400000001      MOV DWORD PTR FFFFFD64[EBP], 00000001
00008: 090C E9 00000244                 JMP L0035
00008: 0911                     L0036:

; 254: 	   k=icoll[i][j];

00008: 0911 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 0917 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 091D 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0920 8B 8D FFFFFD64              MOV ECX, DWORD PTR FFFFFD64[EBP]
00008: 0926 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0929 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX

; 255: 	   if(k>-1)

00008: 092F 83 BD FFFFFD68FFFFFFFF      CMP DWORD PTR FFFFFD68[EBP], FFFFFFFF
00008: 0936 0F 8E 00000213              JLE L0037

; 258:                int sbyte=0;

00008: 093C C7 85 FFFFFD7C00000000      MOV DWORD PTR FFFFFD7C[EBP], 00000000

; 259: 	       while(coll[k].next>-1)

00008: 0946 EB 19                       JMP L0038
00008: 0948                     L0039:

; 260: 		 k=coll[k].next;

00008: 0948 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 094E 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0951 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0957 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 095B 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX
00008: 0961                     L0038:
00008: 0961 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0967 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 096A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0970 83 7C DA 38 FFFFFFFF        CMP DWORD PTR 00000038[EDX][EBX*8], FFFFFFFF
00008: 0975 7F FFFFFFD1                 JG L0039

; 261: 	       dd=sqrt(coll[k].dd);

00008: 0977 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 097D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0980 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0986 FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 098A FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 098E E8 00000000                 CALL SHORT _sqrt
00007: 0993 59                          POP ECX
00007: 0994 59                          POP ECX
00007: 0995 DD 9D FFFFFDB0              FSTP QWORD PTR FFFFFDB0[EBP]

; 262: 	       nbyte=sprintf(&s[0],"%d %d %lf \n",i,j,dd);

00008: 099B FF B5 FFFFFDB4              PUSH DWORD PTR FFFFFDB4[EBP]
00008: 09A1 FF B5 FFFFFDB0              PUSH DWORD PTR FFFFFDB0[EBP]
00008: 09A7 FF B5 FFFFFD64              PUSH DWORD PTR FFFFFD64[EBP]
00008: 09AD FF B5 FFFFFD60              PUSH DWORD PTR FFFFFD60[EBP]
00008: 09B3 68 00000000                 PUSH OFFSET @378
00008: 09B8 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 09BE 50                          PUSH EAX
00008: 09BF E8 00000000                 CALL SHORT _sprintf
00008: 09C4 83 C4 18                    ADD ESP, 00000018
00008: 09C7 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 263:                sbyte+=nbyte-1; 

00008: 09CD 8B 95 FFFFFD5C              MOV EDX, DWORD PTR FFFFFD5C[EBP]
00008: 09D3 4A                          DEC EDX
00008: 09D4 01 95 FFFFFD7C              ADD DWORD PTR FFFFFD7C[EBP], EDX

; 264: 	       if(nbyte<=0) 

00008: 09DA 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 09E1 0F 8F 00000106              JG L003A

; 265: 		 fErr=-1;

00008: 09E7 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 09F1 E9 00000111                 JMP L003B
00008: 09F6                     L003C:

; 269: 		     k=coll[k].prev;

00008: 09F6 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 09FC 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 09FF 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0A05 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0A09 89 85 FFFFFD68              MOV DWORD PTR FFFFFD68[EBP], EAX

; 270: 		     dd=sqrt(coll[k].dd);

00008: 0A0F 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0A15 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0A18 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0A1E FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 0A22 FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 0A26 E8 00000000                 CALL SHORT _sqrt
00007: 0A2B 59                          POP ECX
00007: 0A2C 59                          POP ECX
00007: 0A2D DD 9D FFFFFDB0              FSTP QWORD PTR FFFFFDB0[EBP]

; 271: 		     en=-coll[k].eo;

00008: 0A33 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0A39 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0A3C 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0A42 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0A46 D9 E0                       FCHS 
00007: 0A48 DD 9D FFFFFDB8              FSTP QWORD PTR FFFFFDB8[EBP]

; 272:                      if(en!=dblarg1)

00008: 0A4E DD 85 FFFFFDB8              FLD QWORD PTR FFFFFDB8[EBP]
00007: 0A54 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 0A5A F1DF                        FCOMIP ST, ST(1), L003D
00007: 0A5C DD D8                       FSTP ST
00008: 0A5E 7A 02                       JP L0067
00008: 0A60 74 3A                       JE L003D
00008: 0A62                     L0067:

; 273: 		       nbyte=sprintf(&s[sbyte],"%lf %lf \n",dd,en);

00008: 0A62 FF B5 FFFFFDBC              PUSH DWORD PTR FFFFFDBC[EBP]
00008: 0A68 FF B5 FFFFFDB8              PUSH DWORD PTR FFFFFDB8[EBP]
00008: 0A6E FF B5 FFFFFDB4              PUSH DWORD PTR FFFFFDB4[EBP]
00008: 0A74 FF B5 FFFFFDB0              PUSH DWORD PTR FFFFFDB0[EBP]
00008: 0A7A 68 00000000                 PUSH OFFSET @379
00008: 0A7F 8D 95 FFFFFDF4              LEA EDX, DWORD PTR FFFFFDF4[EBP]
00008: 0A85 03 95 FFFFFD7C              ADD EDX, DWORD PTR FFFFFD7C[EBP]
00008: 0A8B 52                          PUSH EDX
00008: 0A8C E8 00000000                 CALL SHORT _sprintf
00008: 0A91 83 C4 18                    ADD ESP, 00000018
00008: 0A94 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0A9A EB 2C                       JMP L003E
00008: 0A9C                     L003D:

; 275: 		       nbyte=sprintf(&s[sbyte],"%lf \n",dd);

00008: 0A9C FF B5 FFFFFDB4              PUSH DWORD PTR FFFFFDB4[EBP]
00008: 0AA2 FF B5 FFFFFDB0              PUSH DWORD PTR FFFFFDB0[EBP]
00008: 0AA8 68 00000000                 PUSH OFFSET @383
00008: 0AAD 8D 95 FFFFFDF4              LEA EDX, DWORD PTR FFFFFDF4[EBP]
00008: 0AB3 03 95 FFFFFD7C              ADD EDX, DWORD PTR FFFFFD7C[EBP]
00008: 0AB9 52                          PUSH EDX
00008: 0ABA E8 00000000                 CALL SHORT _sprintf
00008: 0ABF 83 C4 10                    ADD ESP, 00000010
00008: 0AC2 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0AC8                     L003E:

; 276: 		     sbyte+=nbyte-1; 

00008: 0AC8 8B 95 FFFFFD5C              MOV EDX, DWORD PTR FFFFFD5C[EBP]
00008: 0ACE 4A                          DEC EDX
00008: 0ACF 01 95 FFFFFD7C              ADD DWORD PTR FFFFFD7C[EBP], EDX

; 277: 		     if(nbyte<=0){fErr=-1;goto hell;}

00008: 0AD5 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0ADC 7F 0F                       JG L003F
00008: 0ADE C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0AE8 E9 0000073D                 JMP L0022
00008: 0AED                     L003F:

; 278: 		   } 

00008: 0AED                     L003A:
00008: 0AED 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0AF3 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0AF6 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0AFC 83 7C DA 3C FFFFFFFF        CMP DWORD PTR 0000003C[EDX][EBX*8], FFFFFFFF
00008: 0B01 0F 8F FFFFFEEF              JG L003C
00008: 0B07                     L003B:

; 279: 	       sbyte++;

00008: 0B07 FF 85 FFFFFD7C              INC DWORD PTR FFFFFD7C[EBP]

; 280: 	       if(fErr==noErr)fErr=(fwrite(&s[0],1,sbyte,path)!=sbyte);

00008: 0B0D 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0B14 75 2C                       JNE L0040
00008: 0B16 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0B19 FF B5 FFFFFD7C              PUSH DWORD PTR FFFFFD7C[EBP]
00008: 0B1F 6A 01                       PUSH 00000001
00008: 0B21 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0B27 50                          PUSH EAX
00008: 0B28 E8 00000000                 CALL SHORT _fwrite
00008: 0B2D 83 C4 10                    ADD ESP, 00000010
00008: 0B30 39 85 FFFFFD7C              CMP DWORD PTR FFFFFD7C[EBP], EAX
00008: 0B36 0F 95 C2                    SETNE DL
00008: 0B39 83 E2 01                    AND EDX, 00000001
00008: 0B3C 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0B42                     L0040:

; 281: 	       if(fErr!=noErr)goto hell;

00008: 0B42 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0B49 0F 85 000006DB              JNE L0022

; 282: 	     }

00008: 0B4F                     L0037:

; 283: 	 }

00008: 0B4F FF 85 FFFFFD64              INC DWORD PTR FFFFFD64[EBP]
00008: 0B55                     L0035:
00008: 0B55 8B 85 FFFFFD64              MOV EAX, DWORD PTR FFFFFD64[EBP]
00008: 0B5B 3B 85 FFFFFD60              CMP EAX, DWORD PTR FFFFFD60[EBP]
00008: 0B61 0F 8E FFFFFDAA              JLE L0036
00008: 0B67 FF 85 FFFFFD60              INC DWORD PTR FFFFFD60[EBP]
00008: 0B6D                     L0033:
00008: 0B6D 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 0B73 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0B79 0F 8E FFFFFD83              JLE L0034
00008: 0B7F                     L0032:

; 285:    if(fErr==noErr)

00008: 0B7F 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0B86 75 24                       JNE L0041

; 286:      nbyte=sprintf(&s[0],"%s\n//old1,old2,new1,new2,bond,radius energy\n",keywords[REACT]);

00008: 0B88 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0B8E 8B 42 1C                    MOV EAX, DWORD PTR 0000001C[EDX]
00008: 0B91 50                          PUSH EAX
00008: 0B92 68 00000000                 PUSH OFFSET @384
00008: 0B97 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0B9D 50                          PUSH EAX
00008: 0B9E E8 00000000                 CALL SHORT _sprintf
00008: 0BA3 83 C4 0C                    ADD ESP, 0000000C
00008: 0BA6 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0BAC                     L0041:

; 287:    if(nbyte<=0) fErr=-1;    

00008: 0BAC 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0BB3 7F 0A                       JG L0042
00008: 0BB5 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0BBF                     L0042:

; 288:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 

00008: 0BBF 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0BC6 75 2C                       JNE L0043
00008: 0BC8 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0BCB FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 0BD1 6A 01                       PUSH 00000001
00008: 0BD3 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0BD9 50                          PUSH EAX
00008: 0BDA E8 00000000                 CALL SHORT _fwrite
00008: 0BDF 83 C4 10                    ADD ESP, 00000010
00008: 0BE2 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0BE8 0F 95 C2                    SETNE DL
00008: 0BEB 83 E2 01                    AND EDX, 00000001
00008: 0BEE 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0BF4                     L0043:

; 289:    if(fErr==noErr) 

00008: 0BF4 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0BFB 0F 85 00000141              JNE L0044

; 290:      for(k=1;k<=nrt;k++)

00008: 0C01 C7 85 FFFFFD6800000001      MOV DWORD PTR FFFFFD68[EBP], 00000001
00008: 0C0B E9 00000120                 JMP L0045
00008: 0C10                     L0046:

; 292: 	 nbyte=sprintf(&s[0],"%d %d %d %d %d %lf %lf\n",

00008: 0C10 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C16 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C19 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0C1F FF 74 DA 0C                 PUSH DWORD PTR 0000000C[EDX][EBX*8]
00008: 0C23 FF 74 DA 08                 PUSH DWORD PTR 00000008[EDX][EBX*8]
00008: 0C27 E8 00000000                 CALL SHORT _sqrt
00007: 0C2C 59                          POP ECX
00007: 0C2D 59                          POP ECX
00007: 0C2E DD 9D FFFFFDE0              FSTP QWORD PTR FFFFFDE0[EBP]
00008: 0C34 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C3A 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C3D 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0C43 FF 74 DA 04                 PUSH DWORD PTR 00000004[EDX][EBX*8]
00008: 0C47 FF 34 DA                    PUSH DWORD PTR 00000000[EDX][EBX*8]
00008: 0C4A FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0C50 FF B5 FFFFFDE0              PUSH DWORD PTR FFFFFDE0[EBP]
00008: 0C56 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C5C 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C5F 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C65 0F BF 44 DE 18              MOVSX EAX, WORD PTR 00000018[ESI][EBX*8]
00008: 0C6A 50                          PUSH EAX
00008: 0C6B 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C71 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C74 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C7A 0F BF 44 DE 16              MOVSX EAX, WORD PTR 00000016[ESI][EBX*8]
00008: 0C7F 50                          PUSH EAX
00008: 0C80 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C86 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C89 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C8F 0F BF 44 DE 14              MOVSX EAX, WORD PTR 00000014[ESI][EBX*8]
00008: 0C94 50                          PUSH EAX
00008: 0C95 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0C9B 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C9E 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0CA4 0F BF 44 DE 12              MOVSX EAX, WORD PTR 00000012[ESI][EBX*8]
00008: 0CA9 50                          PUSH EAX
00008: 0CAA 8B 9D FFFFFD68              MOV EBX, DWORD PTR FFFFFD68[EBP]
00008: 0CB0 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0CB3 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0CB9 0F BF 44 DE 10              MOVSX EAX, WORD PTR 00000010[ESI][EBX*8]
00008: 0CBE 50                          PUSH EAX
00008: 0CBF 68 00000000                 PUSH OFFSET @141
00008: 0CC4 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0CCA 50                          PUSH EAX
00008: 0CCB E8 00000000                 CALL SHORT _sprintf
00008: 0CD0 83 C4 2C                    ADD ESP, 0000002C
00008: 0CD3 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 300: 	 if(nbyte<=0) fErr=-1;

00008: 0CD9 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0CE0 7F 0A                       JG L0047
00008: 0CE2 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0CEC                     L0047:

; 301: 	 if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 0CEC 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0CF3 75 2C                       JNE L0048
00008: 0CF5 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0CF8 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 0CFE 6A 01                       PUSH 00000001
00008: 0D00 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0D06 50                          PUSH EAX
00008: 0D07 E8 00000000                 CALL SHORT _fwrite
00008: 0D0C 83 C4 10                    ADD ESP, 00000010
00008: 0D0F 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0D15 0F 95 C2                    SETNE DL
00008: 0D18 83 E2 01                    AND EDX, 00000001
00008: 0D1B 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0D21                     L0048:

; 302: 	 if(fErr!=noErr)break;

00008: 0D21 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0D28 75 18                       JNE L0049

; 303:        }

00008: 0D2A FF 85 FFFFFD68              INC DWORD PTR FFFFFD68[EBP]
00008: 0D30                     L0045:
00008: 0D30 8B 85 FFFFFD68              MOV EAX, DWORD PTR FFFFFD68[EBP]
00008: 0D36 3B 05 00000000              CMP EAX, DWORD PTR _nrt
00008: 0D3C 0F 8E FFFFFECE              JLE L0046
00008: 0D42                     L0049:
00008: 0D42                     L0044:

; 305:   if(fErr==noErr)

00008: 0D42 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0D49 75 24                       JNE L004A

; 306:   nbyte=sprintf(&s[0],"%s\n//number, type, x, y, z, Vx, Vy, Vz\n",keywords[LIST_ATOMS]);

00008: 0D4B 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0D51 8B 42 20                    MOV EAX, DWORD PTR 00000020[EDX]
00008: 0D54 50                          PUSH EAX
00008: 0D55 68 00000000                 PUSH OFFSET @385
00008: 0D5A 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0D60 50                          PUSH EAX
00008: 0D61 E8 00000000                 CALL SHORT _sprintf
00008: 0D66 83 C4 0C                    ADD ESP, 0000000C
00008: 0D69 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 0D6F                     L004A:

; 307:   if(nbyte<=0) fErr=-1;    

00008: 0D6F 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 0D76 7F 0A                       JG L004B
00008: 0D78 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 0D82                     L004B:

; 308:   if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   

00008: 0D82 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0D89 75 2C                       JNE L004C
00008: 0D8B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0D8E FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 0D94 6A 01                       PUSH 00000001
00008: 0D96 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 0D9C 50                          PUSH EAX
00008: 0D9D E8 00000000                 CALL SHORT _fwrite
00008: 0DA2 83 C4 10                    ADD ESP, 00000010
00008: 0DA5 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 0DAB 0F 95 C2                    SETNE DL
00008: 0DAE 83 E2 01                    AND EDX, 00000001
00008: 0DB1 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 0DB7                     L004C:

; 309:   if(fErr==noErr)

00008: 0DB7 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 0DBE 75 30                       JNE L004D

; 310:     if(write_stop)stop_atoms((moved_iatom *)(a+write_start),write_n1);

00008: 0DC0 83 3D 00000000 00           CMP DWORD PTR _write_stop, 00000000
00008: 0DC7 74 22                       JE L004E
00008: 0DC9 A1 00000000                 MOV EAX, DWORD PTR _write_n1
00008: 0DCE 50                          PUSH EAX
00008: 0DCF 8B 15 00000000              MOV EDX, DWORD PTR _write_start
00008: 0DD5 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0DDB 03 95 FFFFFD74              ADD EDX, DWORD PTR FFFFFD74[EBP]
00008: 0DE1 52                          PUSH EDX
00008: 0DE2 E8 00000000                 CALL SHORT _stop_atoms
00008: 0DE7 59                          POP ECX
00008: 0DE8 59                          POP ECX
00008: 0DE9 EB 05                       JMP L004F
00008: 0DEB                     L004E:

; 311:     else corr_vel(); 	 

00008: 0DEB E8 00000000                 CALL SHORT _corr_vel
00008: 0DF0                     L004F:
00008: 0DF0                     L004D:

; 312:   for(i=write_start;i<write_finish;i++)

00008: 0DF0 A1 00000000                 MOV EAX, DWORD PTR _write_start
00008: 0DF5 89 85 FFFFFD60              MOV DWORD PTR FFFFFD60[EBP], EAX
00008: 0DFB E9 00000280                 JMP L0050
00008: 0E00                     L0051:

; 314:     double x=a[i].r.x;

00008: 0E00 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0E06 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0E0D 29 D3                       SUB EBX, EDX
00008: 0E0F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0E12 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0E18 DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 0E1C DD 9D FFFFFDC0              FSTP QWORD PTR FFFFFDC0[EBP]

; 315:     double y=a[i].r.y;

00008: 0E22 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0E28 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0E2F 29 D3                       SUB EBX, EDX
00008: 0E31 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0E34 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0E3A DD 44 D8 50                 FLD QWORD PTR 00000050[EAX][EBX*8]
00007: 0E3E DD 9D FFFFFDC8              FSTP QWORD PTR FFFFFDC8[EBP]

; 316:     double z=a[i].r.z;

00008: 0E44 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0E4A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0E51 29 D3                       SUB EBX, EDX
00008: 0E53 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0E56 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0E5C DD 44 D8 58                 FLD QWORD PTR 00000058[EAX][EBX*8]
00007: 0E60 DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]

; 317:     if(x<0)x+=bound[0].length;

00008: 0E66 DD 85 FFFFFDC0              FLD QWORD PTR FFFFFDC0[EBP]
00007: 0E6C DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 0E72 F1DF                        FCOMIP ST, ST(1), L0052
00007: 0E74 DD D8                       FSTP ST
00008: 0E76 7A 14                       JP L0052
00008: 0E78 76 12                       JBE L0052
00008: 0E7A DD 85 FFFFFDC0              FLD QWORD PTR FFFFFDC0[EBP]
00007: 0E80 DC 05 00000000              FADD QWORD PTR _bound
00007: 0E86 DD 9D FFFFFDC0              FSTP QWORD PTR FFFFFDC0[EBP]
00008: 0E8C                     L0052:

; 318:     if(y<0)y+=bound[1].length;

00008: 0E8C DD 85 FFFFFDC8              FLD QWORD PTR FFFFFDC8[EBP]
00007: 0E92 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 0E98 F1DF                        FCOMIP ST, ST(1), L0053
00007: 0E9A DD D8                       FSTP ST
00008: 0E9C 7A 14                       JP L0053
00008: 0E9E 76 12                       JBE L0053
00008: 0EA0 DD 85 FFFFFDC8              FLD QWORD PTR FFFFFDC8[EBP]
00007: 0EA6 DC 05 00000018              FADD QWORD PTR _bound+00000018
00007: 0EAC DD 9D FFFFFDC8              FSTP QWORD PTR FFFFFDC8[EBP]
00008: 0EB2                     L0053:

; 319:     if(z<0)z+=bound[2].length;

00008: 0EB2 DD 85 FFFFFDD0              FLD QWORD PTR FFFFFDD0[EBP]
00007: 0EB8 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 0EBE F1DF                        FCOMIP ST, ST(1), L0054
00007: 0EC0 DD D8                       FSTP ST
00008: 0EC2 7A 14                       JP L0054
00008: 0EC4 76 12                       JBE L0054
00008: 0EC6 DD 85 FFFFFDD0              FLD QWORD PTR FFFFFDD0[EBP]
00007: 0ECC DC 05 00000030              FADD QWORD PTR _bound+00000030
00007: 0ED2 DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]
00008: 0ED8                     L0054:

; 320:     if(x>bound[0].length)x-=bound[0].length;

00008: 0ED8 DD 85 FFFFFDC0              FLD QWORD PTR FFFFFDC0[EBP]
00007: 0EDE DD 05 00000000              FLD QWORD PTR _bound
00006: 0EE4 F1DF                        FCOMIP ST, ST(1), L0055
00007: 0EE6 DD D8                       FSTP ST
00008: 0EE8 7A 14                       JP L0055
00008: 0EEA 73 12                       JAE L0055
00008: 0EEC DD 85 FFFFFDC0              FLD QWORD PTR FFFFFDC0[EBP]
00007: 0EF2 DC 25 00000000              FSUB QWORD PTR _bound
00007: 0EF8 DD 9D FFFFFDC0              FSTP QWORD PTR FFFFFDC0[EBP]
00008: 0EFE                     L0055:

; 321:     if(y>bound[1].length)y-=bound[1].length;

00008: 0EFE DD 85 FFFFFDC8              FLD QWORD PTR FFFFFDC8[EBP]
00007: 0F04 DD 05 00000018              FLD QWORD PTR _bound+00000018
00006: 0F0A F1DF                        FCOMIP ST, ST(1), L0056
00007: 0F0C DD D8                       FSTP ST
00008: 0F0E 7A 14                       JP L0056
00008: 0F10 73 12                       JAE L0056
00008: 0F12 DD 85 FFFFFDC8              FLD QWORD PTR FFFFFDC8[EBP]
00007: 0F18 DC 25 00000018              FSUB QWORD PTR _bound+00000018
00007: 0F1E DD 9D FFFFFDC8              FSTP QWORD PTR FFFFFDC8[EBP]
00008: 0F24                     L0056:

; 322:     if(z>bound[2].length)z-=bound[2].length;

00008: 0F24 DD 85 FFFFFDD0              FLD QWORD PTR FFFFFDD0[EBP]
00007: 0F2A DD 05 00000030              FLD QWORD PTR _bound+00000030
00006: 0F30 F1DF                        FCOMIP ST, ST(1), L0057
00007: 0F32 DD D8                       FSTP ST
00008: 0F34 7A 14                       JP L0057
00008: 0F36 73 12                       JAE L0057
00008: 0F38 DD 85 FFFFFDD0              FLD QWORD PTR FFFFFDD0[EBP]
00007: 0F3E DC 25 00000030              FSUB QWORD PTR _bound+00000030
00007: 0F44 DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]
00008: 0F4A                     L0057:

; 323:     nbyte=sprintf(&s[0],"%4ld %4d %18.13lf %18.13lf %18.13lf %18.13lf %18.13lf %18.13lf\n",

00008: 0F4A 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0F50 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0F57 29 D3                       SUB EBX, EDX
00008: 0F59 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0F5C 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0F62 FF 74 D8 74                 PUSH DWORD PTR 00000074[EAX][EBX*8]
00008: 0F66 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0F6C FF 74 D8 70                 PUSH DWORD PTR 00000070[EAX][EBX*8]
00008: 0F70 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0F76 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0F7D 29 D3                       SUB EBX, EDX
00008: 0F7F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0F82 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0F88 FF 74 D8 6C                 PUSH DWORD PTR 0000006C[EAX][EBX*8]
00008: 0F8C 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0F92 FF 74 D8 68                 PUSH DWORD PTR 00000068[EAX][EBX*8]
00008: 0F96 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0F9C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0FA3 29 D3                       SUB EBX, EDX
00008: 0FA5 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0FA8 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0FAE FF 74 D8 64                 PUSH DWORD PTR 00000064[EAX][EBX*8]
00008: 0FB2 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0FB8 FF 74 D8 60                 PUSH DWORD PTR 00000060[EAX][EBX*8]
00008: 0FBC FF B5 FFFFFDD4              PUSH DWORD PTR FFFFFDD4[EBP]
00008: 0FC2 FF B5 FFFFFDD0              PUSH DWORD PTR FFFFFDD0[EBP]
00008: 0FC8 FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 0FCE FF B5 FFFFFDC8              PUSH DWORD PTR FFFFFDC8[EBP]
00008: 0FD4 FF B5 FFFFFDC4              PUSH DWORD PTR FFFFFDC4[EBP]
00008: 0FDA FF B5 FFFFFDC0              PUSH DWORD PTR FFFFFDC0[EBP]
00008: 0FE0 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 0FE6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0FED 29 D3                       SUB EBX, EDX
00008: 0FEF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0FF2 8B 85 FFFFFD74              MOV EAX, DWORD PTR FFFFFD74[EBP]
00008: 0FF8 0F BF 84 D8 000000A4        MOVSX EAX, WORD PTR 000000A4[EAX][EBX*8]
00008: 1000 50                          PUSH EAX
00008: 1001 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 1007 42                          INC EDX
00008: 1008 2B 15 00000000              SUB EDX, DWORD PTR _write_start
00008: 100E 52                          PUSH EDX
00008: 100F 68 00000000                 PUSH OFFSET @386
00008: 1014 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 101A 50                          PUSH EAX
00008: 101B E8 00000000                 CALL SHORT _sprintf
00008: 1020 83 C4 40                    ADD ESP, 00000040
00008: 1023 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 326:     if(nbyte<=0) fErr=-1;  

00008: 1029 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 1030 7F 0A                       JG L0058
00008: 1032 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 103C                     L0058:

; 327:     if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 103C 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 1043 75 2C                       JNE L0059
00008: 1045 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 1048 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 104E 6A 01                       PUSH 00000001
00008: 1050 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 1056 50                          PUSH EAX
00008: 1057 E8 00000000                 CALL SHORT _fwrite
00008: 105C 83 C4 10                    ADD ESP, 00000010
00008: 105F 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 1065 0F 95 C2                    SETNE DL
00008: 1068 83 E2 01                    AND EDX, 00000001
00008: 106B 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 1071                     L0059:

; 328:     if(fErr!=noErr)break;

00008: 1071 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 1078 75 18                       JNE L005A

; 329:   }

00008: 107A FF 85 FFFFFD60              INC DWORD PTR FFFFFD60[EBP]
00008: 1080                     L0050:
00008: 1080 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 1086 3B 05 00000000              CMP EAX, DWORD PTR _write_finish
00008: 108C 0F 8C FFFFFD6E              JL L0051
00008: 1092                     L005A:

; 331:    if(fErr==noErr)

00008: 1092 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 1099 75 24                       JNE L005B

; 332:     nbyte=sprintf(&s[0],"%s\n//number1,number2\n",keywords[LIST_BONDS]);

00008: 109B 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 10A1 8B 42 24                    MOV EAX, DWORD PTR 00000024[EDX]
00008: 10A4 50                          PUSH EAX
00008: 10A5 68 00000000                 PUSH OFFSET @387
00008: 10AA 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 10B0 50                          PUSH EAX
00008: 10B1 E8 00000000                 CALL SHORT _sprintf
00008: 10B6 83 C4 0C                    ADD ESP, 0000000C
00008: 10B9 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX
00008: 10BF                     L005B:

; 333:    if(nbyte<=0) fErr=-1;    

00008: 10BF 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 10C6 7F 0A                       JG L005C
00008: 10C8 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 10D2                     L005C:

; 334:    if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);	 	   

00008: 10D2 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 10D9 75 2C                       JNE L005D
00008: 10DB FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 10DE FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 10E4 6A 01                       PUSH 00000001
00008: 10E6 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 10EC 50                          PUSH EAX
00008: 10ED E8 00000000                 CALL SHORT _fwrite
00008: 10F2 83 C4 10                    ADD ESP, 00000010
00008: 10F5 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 10FB 0F 95 C2                    SETNE DL
00008: 10FE 83 E2 01                    AND EDX, 00000001
00008: 1101 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 1107                     L005D:

; 335:    if(fErr==noErr) 	 

00008: 1107 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 110E 0F 85 00000116              JNE L005E

; 336:     for(i=0;i<n1;i++)

00008: 1114 C7 85 FFFFFD6000000000      MOV DWORD PTR FFFFFD60[EBP], 00000000
00008: 111E E9 000000F5                 JMP L005F
00008: 1123                     L0060:

; 338: 	  int index=-1;

00008: 1123 C7 45 FFFFFFF4 FFFFFFFF     MOV DWORD PTR FFFFFFF4[EBP], FFFFFFFF

; 339: 	  do

00008: 112A                     L0061:

; 341: 	      j=nextFriend(i,&index);

00008: 112A 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 112D 50                          PUSH EAX
00008: 112E FF B5 FFFFFD60              PUSH DWORD PTR FFFFFD60[EBP]
00008: 1134 E8 00000000                 CALL SHORT _nextFriend
00008: 1139 59                          POP ECX
00008: 113A 59                          POP ECX
00008: 113B 89 85 FFFFFD64              MOV DWORD PTR FFFFFD64[EBP], EAX

; 342: 	      if(index==-1)break;

00008: 1141 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 1145 0F 84 000000C7              JE L0062

; 343: 	      if((j>i)&&(i>=write_start)&&(j<write_finish))

00008: 114B 8B 85 FFFFFD64              MOV EAX, DWORD PTR FFFFFD64[EBP]
00008: 1151 3B 85 FFFFFD60              CMP EAX, DWORD PTR FFFFFD60[EBP]
00008: 1157 0F 8E 000000AB              JLE L0063
00008: 115D 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 1163 3B 05 00000000              CMP EAX, DWORD PTR _write_start
00008: 1169 0F 8C 00000099              JL L0063
00008: 116F 8B 85 FFFFFD64              MOV EAX, DWORD PTR FFFFFD64[EBP]
00008: 1175 3B 05 00000000              CMP EAX, DWORD PTR _write_finish
00008: 117B 0F 8D 00000087              JGE L0063

; 345: 		  nbyte=sprintf(&s[0],"%4ld %4ld\n",

00008: 1181 8B 95 FFFFFD64              MOV EDX, DWORD PTR FFFFFD64[EBP]
00008: 1187 42                          INC EDX
00008: 1188 2B 15 00000000              SUB EDX, DWORD PTR _write_start
00008: 118E 52                          PUSH EDX
00008: 118F 8B 95 FFFFFD60              MOV EDX, DWORD PTR FFFFFD60[EBP]
00008: 1195 42                          INC EDX
00008: 1196 2B 15 00000000              SUB EDX, DWORD PTR _write_start
00008: 119C 52                          PUSH EDX
00008: 119D 68 00000000                 PUSH OFFSET @388
00008: 11A2 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 11A8 50                          PUSH EAX
00008: 11A9 E8 00000000                 CALL SHORT _sprintf
00008: 11AE 83 C4 10                    ADD ESP, 00000010
00008: 11B1 89 85 FFFFFD5C              MOV DWORD PTR FFFFFD5C[EBP], EAX

; 347: 		  if(nbyte<=0) fErr=-1;  

00008: 11B7 83 BD FFFFFD5C00            CMP DWORD PTR FFFFFD5C[EBP], 00000000
00008: 11BE 7F 0A                       JG L0064
00008: 11C0 C7 85 FFFFFD6CFFFFFFFF      MOV DWORD PTR FFFFFD6C[EBP], FFFFFFFF
00008: 11CA                     L0064:

; 348: 		  if(fErr==noErr)fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 11CA 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 11D1 75 2C                       JNE L0065
00008: 11D3 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 11D6 FF B5 FFFFFD5C              PUSH DWORD PTR FFFFFD5C[EBP]
00008: 11DC 6A 01                       PUSH 00000001
00008: 11DE 8D 85 FFFFFDF4              LEA EAX, DWORD PTR FFFFFDF4[EBP]
00008: 11E4 50                          PUSH EAX
00008: 11E5 E8 00000000                 CALL SHORT _fwrite
00008: 11EA 83 C4 10                    ADD ESP, 00000010
00008: 11ED 39 85 FFFFFD5C              CMP DWORD PTR FFFFFD5C[EBP], EAX
00008: 11F3 0F 95 C2                    SETNE DL
00008: 11F6 83 E2 01                    AND EDX, 00000001
00008: 11F9 89 95 FFFFFD6C              MOV DWORD PTR FFFFFD6C[EBP], EDX
00008: 11FF                     L0065:

; 349: 		  if(fErr!=noErr)break;

00008: 11FF 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 1206 75 0A                       JNE L0062

; 350: 		}

00008: 1208                     L0063:

; 351: 	    }while(index>-1);

00008: 1208 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 120C 0F 8F FFFFFF18              JG L0061
00008: 1212                     L0062:

; 352: 	}

00008: 1212 FF 85 FFFFFD60              INC DWORD PTR FFFFFD60[EBP]
00008: 1218                     L005F:
00008: 1218 8B 85 FFFFFD60              MOV EAX, DWORD PTR FFFFFD60[EBP]
00008: 121E 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 1224 0F 8C FFFFFEF9              JL L0060
00008: 122A                     L005E:

; 353:  hell:

00008: 122A                     L0022:

; 354:    if(fErr!=noErr)fclose(path);

00008: 122A 83 BD FFFFFD6C00            CMP DWORD PTR FFFFFD6C[EBP], 00000000
00008: 1231 74 09                       JE L0066
00008: 1233 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 1236 E8 00000000                 CALL SHORT _fclose
00008: 123B 59                          POP ECX
00008: 123C                     L0066:

; 355:    return fErr;

00008: 123C 8B 85 FFFFFD6C              MOV EAX, DWORD PTR FFFFFD6C[EBP]
00000: 1242                     L0000:
00000: 1242                             epilog 
00000: 1242 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 1245 5E                          POP ESI
00000: 1246 5B                          POP EBX
00000: 1247 5D                          POP EBP
00000: 1248 C3                          RETN 

Function: _sqrt

; 552: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: if(x >=0.0)

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 000C F1DF                        FCOMIP ST, ST(1), L0001
00007: 000E DD D8                       FSTP ST
00008: 0010 7A 0F                       JP L0001
00008: 0012 77 0D                       JA L0001

; 560: 		fld x

00008: 0014 DD 45 08                    FLD QWORD PTR 00000008[EBP]

; 561: 		fsqrt

00007: 0017 D9 FA                       FSQRT 

; 562: 		fstp x

00007: 0019 DD 5D 08                    FSTP QWORD PTR 00000008[EBP]

; 565: 	return x ;

00008: 001C DD 45 08                    FLD QWORD PTR 00000008[EBP]
00000: 001F                             epilog 
00000: 001F C9                          LEAVE 
00000: 0020 C3                          RETN 
00008: 0021                     L0001:

; 570: errno=EDOM ;

00008: 0021 6A 01                       PUSH 00000001
00008: 0023 E8 00000000                 CALL SHORT __GetThreadLocalData
00008: 0028 59                          POP ECX
00008: 0029 C7 40 04 00000021           MOV DWORD PTR 00000004[EAX], 00000021

; 572: return NAN ;

00008: 0030 D9 05 00000000              FLD DWORD PTR ___float_nan
00000: 0036                     L0000:
00000: 0036                             epilog 
00000: 0036 C9                          LEAVE 
00000: 0037 C3                          RETN 

Function: _get_buffer

; 363: {   

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

; 370:   fErr=fseek(text_path,0,SEEK_END);

00008: 0015 6A 02                       PUSH 00000002
00008: 0017 6A 00                       PUSH 00000000
00008: 0019 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 001E 50                          PUSH EAX
00008: 001F E8 00000000                 CALL SHORT _fseek
00008: 0024 83 C4 0C                    ADD ESP, 0000000C
00008: 0027 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 371:   if(fErr==noErr)file_size=ftell(text_path);

00008: 002A 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 002E 75 0F                       JNE L0001
00008: 0030 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 0035 50                          PUSH EAX
00008: 0036 E8 00000000                 CALL SHORT _ftell
00008: 003B 59                          POP ECX
00008: 003C 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 003F                     L0001:

; 372:   if(file_size<=0)fErr=-1;

00008: 003F 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0043 7F 07                       JG L0002
00008: 0045 C7 45 FFFFFFF4 FFFFFFFF     MOV DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 004C                     L0002:

; 373:   if(fErr==noErr)fErr=fseek(text_path,0,SEEK_SET);

00008: 004C 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0050 75 15                       JNE L0003
00008: 0052 6A 00                       PUSH 00000000
00008: 0054 6A 00                       PUSH 00000000
00008: 0056 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 005B 50                          PUSH EAX
00008: 005C E8 00000000                 CALL SHORT _fseek
00008: 0061 83 C4 0C                    ADD ESP, 0000000C
00008: 0064 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 0067                     L0003:

; 374:    if(fErr!=noErr){fclose(text_path); return NULL;}

00008: 0067 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 006B 74 13                       JE L0004
00008: 006D A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 0072 50                          PUSH EAX
00008: 0073 E8 00000000                 CALL SHORT _fclose
00008: 0078 59                          POP ECX
00008: 0079 B8 00000000                 MOV EAX, 00000000
00000: 007E                             epilog 
00000: 007E C9                          LEAVE 
00000: 007F C3                          RETN 
00008: 0080                     L0004:

; 375:    buf=(unsigned char *)malloc(file_size+2);

00008: 0080 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0083 83 C0 02                    ADD EAX, 00000002
00008: 0086 50                          PUSH EAX
00008: 0087 E8 00000000                 CALL SHORT _malloc
00008: 008C 59                          POP ECX
00008: 008D 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 376:    if(!buf){StopAlert (MEMORY_ALRT);fclose(text_path);return NULL;}

00008: 0090 83 7D FFFFFFFC 00           CMP DWORD PTR FFFFFFFC[EBP], 00000000
00008: 0094 75 1B                       JNE L0005
00008: 0096 6A 02                       PUSH 00000002
00008: 0098 E8 00000000                 CALL SHORT _StopAlert
00008: 009D 59                          POP ECX
00008: 009E A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 00A3 50                          PUSH EAX
00008: 00A4 E8 00000000                 CALL SHORT _fclose
00008: 00A9 59                          POP ECX
00008: 00AA B8 00000000                 MOV EAX, 00000000
00000: 00AF                             epilog 
00000: 00AF C9                          LEAVE 
00000: 00B0 C3                          RETN 
00008: 00B1                     L0005:

; 377:    buf[0]='\n';

00008: 00B1 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 00B4 C6 00 0A                    MOV BYTE PTR 00000000[EAX], 0A

; 378:    fErr=(fread(buf+1,1,file_size,text_path)!=file_size);

00008: 00B7 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 00BC 50                          PUSH EAX
00008: 00BD FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00C0 6A 01                       PUSH 00000001
00008: 00C2 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 00C5 40                          INC EAX
00008: 00C6 50                          PUSH EAX
00008: 00C7 E8 00000000                 CALL SHORT _fread
00008: 00CC 83 C4 10                    ADD ESP, 00000010
00008: 00CF 39 45 FFFFFFF8              CMP DWORD PTR FFFFFFF8[EBP], EAX
00008: 00D2 0F 95 C2                    SETNE DL
00008: 00D5 83 E2 01                    AND EDX, 00000001
00008: 00D8 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX

; 379:    if(fErr!=noErr){fclose(text_path);free(buf); return NULL;}

00008: 00DB 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 00DF 74 1C                       JE L0006
00008: 00E1 A1 00000000                 MOV EAX, DWORD PTR _text_path
00008: 00E6 50                          PUSH EAX
00008: 00E7 E8 00000000                 CALL SHORT _fclose
00008: 00EC 59                          POP ECX
00008: 00ED FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 00F0 E8 00000000                 CALL SHORT _free
00008: 00F5 59                          POP ECX
00008: 00F6 B8 00000000                 MOV EAX, 00000000
00000: 00FB                             epilog 
00000: 00FB C9                          LEAVE 
00000: 00FC C3                          RETN 
00008: 00FD                     L0006:

; 380:    endbuf=buf+file_size+1;

00008: 00FD 8B 55 FFFFFFFC              MOV EDX, DWORD PTR FFFFFFFC[EBP]
00008: 0100 03 55 FFFFFFF8              ADD EDX, DWORD PTR FFFFFFF8[EBP]
00008: 0103 42                          INC EDX
00008: 0104 89 15 00000000              MOV DWORD PTR _endbuf, EDX

; 381:    file_length[0]=file_size;

00008: 010A 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 010D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0110 89 08                       MOV DWORD PTR 00000000[EAX], ECX

; 382:    return buf;

00008: 0112 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00000: 0115                     L0000:
00000: 0115                             epilog 
00000: 0115 C9                          LEAVE 
00000: 0116 C3                          RETN 

Function: _next_line1

; 388: { unsigned char * t=s;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 388: { unsigned char * t=s;

00008: 0012 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0015 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 391:   while ((*t)!='\n')

00008: 0018 EB 22                       JMP L0001
00008: 001A                     L0002:

; 393:   if ((*t)=='\0')*t=' ';

00008: 001A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 001D 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0020 75 08                       JNE L0003
00008: 0022 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0025 C6 00 20                    MOV BYTE PTR 00000000[EAX], 20
00008: 0028 EB 0F                       JMP L0004
00008: 002A                     L0003:

; 394:   else if((*t)==(unsigned char)'\377')return NULL;

00008: 002A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002D 80 38 FFFFFFFF              CMP BYTE PTR 00000000[EAX], FFFFFFFF
00008: 0030 75 07                       JNE L0005
00008: 0032 B8 00000000                 MOV EAX, 00000000
00000: 0037                             epilog 
00000: 0037 C9                          LEAVE 
00000: 0038 C3                          RETN 
00008: 0039                     L0005:
00008: 0039                     L0004:

; 395:   t++;

00008: 0039 FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]

; 396:   }

00008: 003C                     L0001:
00008: 003C 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 003F 80 38 0A                    CMP BYTE PTR 00000000[EAX], 0A
00008: 0042 75 FFFFFFD6                 JNE L0002

; 397:   *t='\0';t++;line_number++;

00008: 0044 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0047 C6 00 00                    MOV BYTE PTR 00000000[EAX], 00
00008: 004A FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]
00008: 004D FF 05 00000000              INC DWORD PTR _line_number

; 398:   }while ((*t)=='/');

00008: 0053 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0056 80 38 2F                    CMP BYTE PTR 00000000[EAX], 2F
00008: 0059 74 FFFFFFE1                 JE L0001

; 399:   return t; 

00008: 005B 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00000: 005E                     L0000:
00000: 005E                             epilog 
00000: 005E C9                          LEAVE 
00000: 005F C3                          RETN 

Function: _next_line

; 409: { 

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

; 410:   unsigned char * t=s;

00008: 0015 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0018 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 411:   int first=1;

00008: 001B C7 45 FFFFFFF8 00000001     MOV DWORD PTR FFFFFFF8[EBP], 00000001

; 412:   int slash=0;

00008: 0022 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000

; 415:       while ((*t)!='\n')

00008: 0029 EB 63                       JMP L0001
00008: 002B                     L0002:

; 417: 	  if(t==endbuf)return NULL;

00008: 002B 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 002E 3B 05 00000000              CMP EAX, DWORD PTR _endbuf
00008: 0034 75 07                       JNE L0003
00008: 0036 B8 00000000                 MOV EAX, 00000000
00000: 003B                             epilog 
00000: 003B C9                          LEAVE 
00000: 003C C3                          RETN 
00008: 003D                     L0003:

; 418: 	  if ((*t)=='\0')*t=' ';

00008: 003D 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0040 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0043 75 06                       JNE L0004
00008: 0045 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0048 C6 00 20                    MOV BYTE PTR 00000000[EAX], 20
00008: 004B                     L0004:

; 420: 	  if (!slash)

00008: 004B 83 7D FFFFFFFC 00           CMP DWORD PTR FFFFFFFC[EBP], 00000000
00008: 004F 75 34                       JNE L0005

; 422: 	      if ((*t)=='/'){*t=' ';slash=1;}

00008: 0051 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0054 80 38 2F                    CMP BYTE PTR 00000000[EAX], 2F
00008: 0057 75 0F                       JNE L0006
00008: 0059 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 005C C6 00 20                    MOV BYTE PTR 00000000[EAX], 20
00008: 005F C7 45 FFFFFFFC 00000001     MOV DWORD PTR FFFFFFFC[EBP], 00000001
00008: 0066 EB 23                       JMP L0007
00008: 0068                     L0006:

; 423: 	      else if(!isspace(*t))

00008: 0068 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 006B 0F B6 00                    MOVZX EAX, BYTE PTR 00000000[EAX]
00008: 006E 50                          PUSH EAX
00008: 006F E8 00000000                 CALL SHORT _isspace
00008: 0074 59                          POP ECX
00008: 0075 83 F8 00                    CMP EAX, 00000000
00008: 0078 75 11                       JNE L0007

; 424: 		{if(!first) return t;}

00008: 007A 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 007E 75 0B                       JNE L0007
00008: 0080 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00000: 0083                             epilog 
00000: 0083 C9                          LEAVE 
00000: 0084 C3                          RETN 
00008: 0085                     L0005:

; 427: 	    *t=' ';

00008: 0085 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0088 C6 00 20                    MOV BYTE PTR 00000000[EAX], 20
00008: 008B                     L0007:

; 428: 	  t++;

00008: 008B FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]

; 429: 	}

00008: 008E                     L0001:
00008: 008E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0091 80 38 0A                    CMP BYTE PTR 00000000[EAX], 0A
00008: 0094 75 FFFFFF95                 JNE L0002

; 430:       line_number++;

00008: 0096 FF 05 00000000              INC DWORD PTR _line_number

; 431:       *t='\0';

00008: 009C 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 009F C6 00 00                    MOV BYTE PTR 00000000[EAX], 00

; 432:       first=0;

00008: 00A2 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000

; 433:       slash=0;

00008: 00A9 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000

; 434:       if(t==endbuf)return NULL;

00008: 00B0 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00B3 3B 05 00000000              CMP EAX, DWORD PTR _endbuf
00008: 00B9 75 07                       JNE L0008
00008: 00BB B8 00000000                 MOV EAX, 00000000
00000: 00C0                             epilog 
00000: 00C0 C9                          LEAVE 
00000: 00C1 C3                          RETN 
00008: 00C2                     L0008:

; 435:       t++;

00008: 00C2 FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]

; 436:     }while (1);

00008: 00C5 EB FFFFFFC7                 JMP L0001
00000: 00C7                     L0000:
00000: 00C7                             epilog 
00000: 00C7 C9                          LEAVE 
00000: 00C8 C3                          RETN 

Function: _isparam

; 439: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 440: return 0;

00008: 0003 B8 00000000                 MOV EAX, 00000000
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _iskeyword

; 443: {

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

; 458:   for(i=1;i<=n_keywords;i++)

00008: 0018 C7 45 FFFFFFEC 00000001     MOV DWORD PTR FFFFFFEC[EBP], 00000001
00008: 001F E9 00000126                 JMP L0001
00008: 0024                     L0002:

; 460:       l=strlen(keywords[i]);

00008: 0024 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 002A 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 002D 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0030 50                          PUSH EAX
00008: 0031 E8 00000000                 CALL SHORT _strlen
00008: 0036 59                          POP ECX
00008: 0037 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 461:       t=datfile+l;

00008: 003A 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 003D 03 55 FFFFFFE8              ADD EDX, DWORD PTR FFFFFFE8[EBP]
00008: 0040 89 55 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EDX

; 462:       if(strncmp(keywords[i],datfile,l))continue;

00008: 0043 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0046 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0049 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 004F 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0052 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0055 50                          PUSH EAX
00008: 0056 E8 00000000                 CALL SHORT _strncmp
00008: 005B 83 C4 0C                    ADD ESP, 0000000C
00008: 005E 83 F8 00                    CMP EAX, 00000000
00008: 0061 0F 85 000000E0              JNE L0003

; 463:       for(j=i;j<=n_keywords;j++)

00008: 0067 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 006A 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 006D EB 1D                       JMP L0004
00008: 006F                     L0005:

; 464: 	if(keyfound[j])return -1;

00008: 006F 8B 15 00000000              MOV EDX, DWORD PTR _keyfound
00008: 0075 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0078 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 007C 74 0B                       JE L0006
00008: 007E B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0083                             epilog 
00000: 0083 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0086 5B                          POP EBX
00000: 0087 5D                          POP EBP
00000: 0088 C3                          RETN 
00008: 0089                     L0006:
00008: 0089 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 008C                     L0004:
00008: 008C 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 008F 3B 05 00000000              CMP EAX, DWORD PTR _n_keywords
00008: 0095 7E FFFFFFD8                 JLE L0005

; 465:       keyfound[i]=1;

00008: 0097 8B 15 00000000              MOV EDX, DWORD PTR _keyfound
00008: 009D 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00A0 C7 04 82 00000001           MOV DWORD PTR 00000000[EDX][EAX*4], 00000001

; 466:       k=i; 

00008: 00A7 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00AA 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 467:       if(k>3)k=3;

00008: 00AD 83 7D FFFFFFF4 03           CMP DWORD PTR FFFFFFF4[EBP], 00000003
00008: 00B1 7E 07                       JLE L0007
00008: 00B3 C7 45 FFFFFFF4 00000003     MOV DWORD PTR FFFFFFF4[EBP], 00000003
00008: 00BA                     L0007:

; 468:       for(j=1;j<=k;j++)

00008: 00BA C7 45 FFFFFFF0 00000001     MOV DWORD PTR FFFFFFF0[EBP], 00000001
00008: 00C1 EB 1D                       JMP L0008
00008: 00C3                     L0009:

; 469: 	if(!keyfound[j])return -1;

00008: 00C3 8B 15 00000000              MOV EDX, DWORD PTR _keyfound
00008: 00C9 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00CC 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 00D0 75 0B                       JNE L000A
00008: 00D2 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 00D7                             epilog 
00000: 00D7 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00DA 5B                          POP EBX
00000: 00DB 5D                          POP EBP
00000: 00DC C3                          RETN 
00008: 00DD                     L000A:
00008: 00DD FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 00E0                     L0008:
00008: 00E0 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00E3 3B 45 FFFFFFF4              CMP EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00E6 7E FFFFFFDB                 JLE L0009

; 470:       if((i>LIST_ATOMS)&&(!keyfound[LIST_ATOMS]))return -1;

00008: 00E8 83 7D FFFFFFEC 08           CMP DWORD PTR FFFFFFEC[EBP], 00000008
00008: 00EC 7E 2B                       JLE L000B
00008: 00EE 8B 15 00000000              MOV EDX, DWORD PTR _keyfound
00008: 00F4 83 7A 20 00                 CMP DWORD PTR 00000020[EDX], 00000000
00008: 00F8 75 1F                       JNE L000B
00008: 00FA B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 00FF                             epilog 
00000: 00FF 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0102 5B                          POP EBX
00000: 0103 5D                          POP EBP
00000: 0104 C3                          RETN 
00008: 0105                     L000C:

; 473: 	  if((*t)=='\0')return i;

00008: 0105 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0108 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 010B 75 09                       JNE L000D
00008: 010D 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00000: 0110                             epilog 
00000: 0110 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0113 5B                          POP EBX
00000: 0114 5D                          POP EBP
00000: 0115 C3                          RETN 
00008: 0116                     L000D:

; 474: 	  t++;

00008: 0116 FF 45 FFFFFFF8              INC DWORD PTR FFFFFFF8[EBP]

; 475: 	}

00008: 0119                     L000B:
00008: 0119 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 011C 0F B6 00                    MOVZX EAX, BYTE PTR 00000000[EAX]
00008: 011F 50                          PUSH EAX
00008: 0120 E8 00000000                 CALL SHORT _isspace
00008: 0125 59                          POP ECX
00008: 0126 83 F8 00                    CMP EAX, 00000000
00008: 0129 75 FFFFFFDA                 JNE L000C

; 476:       if((*t)=='\0')return i;

00008: 012B 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 012E 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0131 75 09                       JNE L000E
00008: 0133 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00000: 0136                             epilog 
00000: 0136 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0139 5B                          POP EBX
00000: 013A 5D                          POP EBP
00000: 013B C3                          RETN 
00008: 013C                     L000E:

; 477:       else return -1;

00008: 013C B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0141                             epilog 
00000: 0141 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0144 5B                          POP EBX
00000: 0145 5D                          POP EBP
00000: 0146 C3                          RETN 
00008: 0147                     L0003:
00008: 0147 FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 014A                     L0001:
00008: 014A 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 014D 3B 05 00000000              CMP EAX, DWORD PTR _n_keywords
00008: 0153 0F 8E FFFFFECB              JLE L0002

; 479:   return 0;

00008: 0159 B8 00000000                 MOV EAX, 00000000
00000: 015E                     L0000:
00000: 015E                             epilog 
00000: 015E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0161 5B                          POP EBX
00000: 0162 5D                          POP EBP
00000: 0163 C3                          RETN 

Function: _next_word

; 484: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 485:   unsigned char * t=s;

00008: 0012 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0015 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 486:   while (isspace(*t))

00008: 0018 EB 12                       JMP L0001
00008: 001A                     L0002:

; 488:     if((*t)=='\0')return NULL;

00008: 001A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 001D 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0020 75 07                       JNE L0003
00008: 0022 B8 00000000                 MOV EAX, 00000000
00000: 0027                             epilog 
00000: 0027 C9                          LEAVE 
00000: 0028 C3                          RETN 
00008: 0029                     L0003:

; 489:     t++;

00008: 0029 FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]

; 490:   }

00008: 002C                     L0001:
00008: 002C 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002F 0F B6 00                    MOVZX EAX, BYTE PTR 00000000[EAX]
00008: 0032 50                          PUSH EAX
00008: 0033 E8 00000000                 CALL SHORT _isspace
00008: 0038 59                          POP ECX
00008: 0039 83 F8 00                    CMP EAX, 00000000
00008: 003C 75 FFFFFFDC                 JNE L0002

; 491:   while(!isspace(*t))

00008: 003E EB 12                       JMP L0004
00008: 0040                     L0005:

; 493:    if ((*t)=='\0')return NULL;

00008: 0040 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0043 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0046 75 07                       JNE L0006
00008: 0048 B8 00000000                 MOV EAX, 00000000
00000: 004D                             epilog 
00000: 004D C9                          LEAVE 
00000: 004E C3                          RETN 
00008: 004F                     L0006:

; 494:    t++;

00008: 004F FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]

; 495:    }

00008: 0052                     L0004:
00008: 0052 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0055 0F B6 00                    MOVZX EAX, BYTE PTR 00000000[EAX]
00008: 0058 50                          PUSH EAX
00008: 0059 E8 00000000                 CALL SHORT _isspace
00008: 005E 59                          POP ECX
00008: 005F 83 F8 00                    CMP EAX, 00000000
00008: 0062 74 FFFFFFDC                 JE L0005

; 496:   return t; 

00008: 0064 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00000: 0067                     L0000:
00000: 0067                             epilog 
00000: 0067 C9                          LEAVE 
00000: 0068 C3                          RETN 

Function: _is_word

; 500: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 501:   unsigned char * t=s;

00008: 0012 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0015 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 502:   while (isspace(*t))

00008: 0018 EB 12                       JMP L0001
00008: 001A                     L0002:

; 504:     if((*t)=='\0')return 0;

00008: 001A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 001D 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0020 75 07                       JNE L0003
00008: 0022 B8 00000000                 MOV EAX, 00000000
00000: 0027                             epilog 
00000: 0027 C9                          LEAVE 
00000: 0028 C3                          RETN 
00008: 0029                     L0003:

; 505:     t++;

00008: 0029 FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]

; 506:   }

00008: 002C                     L0001:
00008: 002C 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002F 0F B6 00                    MOVZX EAX, BYTE PTR 00000000[EAX]
00008: 0032 50                          PUSH EAX
00008: 0033 E8 00000000                 CALL SHORT _isspace
00008: 0038 59                          POP ECX
00008: 0039 83 F8 00                    CMP EAX, 00000000
00008: 003C 75 FFFFFFDC                 JNE L0002

; 507:   if((*t)=='\0')return 0;

00008: 003E 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0041 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 0044 75 07                       JNE L0004
00008: 0046 B8 00000000                 MOV EAX, 00000000
00000: 004B                             epilog 
00000: 004B C9                          LEAVE 
00000: 004C C3                          RETN 
00008: 004D                     L0004:

; 508:     else return 1;

00008: 004D B8 00000001                 MOV EAX, 00000001
00000: 0052                     L0000:
00000: 0052                             epilog 
00000: 0052 C9                          LEAVE 
00000: 0053 C3                          RETN 

Function: _dimensionality

; 513: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
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

; 514:   int i,j,k=0;

00008: 0016 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 515:   iatom * b=(iatom *)a;

00008: 001D A1 00000000                 MOV EAX, DWORD PTR _a
00008: 0022 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 516:   for(i=0;i<3;i++)

00008: 0025 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 002C E9 00000092                 JMP L0001
00008: 0031                     L0002:

; 518:   is_x[i]=0;

00008: 0031 8B 4D FFFFFFEC              MOV ECX, DWORD PTR FFFFFFEC[EBP]
00008: 0034 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0037 C7 04 88 00000000           MOV DWORD PTR 00000000[EAX][ECX*4], 00000000

; 519:   for(j=0;j<n1;j++)

00008: 003E C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0045 EB 5F                       JMP L0003
00008: 0047                     L0004:

; 520:   if ((b[j].r[i])||(b[j].v[i])) {is_x[i]=1;break;}

00008: 0047 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 004A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0051 29 D3                       SUB EBX, EDX
00008: 0053 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0056 03 5D FFFFFFEC              ADD EBX, DWORD PTR FFFFFFEC[EBP]
00008: 0059 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 005C DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00007: 005F DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 0065 F1DF                        FCOMIP ST, ST(1), L0005
00007: 0067 DD D8                       FSTP ST
00008: 0069 7A 29                       JP L0005
00008: 006B 75 27                       JNE L0005
00008: 006D 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0070 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0077 29 D3                       SUB EBX, EDX
00008: 0079 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 007C 03 5D FFFFFFEC              ADD EBX, DWORD PTR FFFFFFEC[EBP]
00008: 007F 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0082 DD 44 D8 18                 FLD QWORD PTR 00000018[EAX][EBX*8]
00007: 0086 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 008C F1DF                        FCOMIP ST, ST(1), L0006
00007: 008E DD D8                       FSTP ST
00008: 0090 7A 02                       JP L0008
00008: 0092 74 0F                       JE L0006
00008: 0094                     L0008:
00008: 0094                     L0005:
00008: 0094 8B 4D FFFFFFEC              MOV ECX, DWORD PTR FFFFFFEC[EBP]
00008: 0097 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009A C7 04 88 00000001           MOV DWORD PTR 00000000[EAX][ECX*4], 00000001
00008: 00A1 EB 0E                       JMP L0007
00008: 00A3                     L0006:
00008: 00A3 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 00A6                     L0003:
00008: 00A6 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00A9 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 00AF 7C FFFFFF96                 JL L0004
00008: 00B1                     L0007:

; 521:   k+=is_x[i];

00008: 00B1 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 00B4 8B 4D 08                    MOV ECX, DWORD PTR 00000008[EBP]
00008: 00B7 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00BA 03 04 91                    ADD EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 00BD 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 522:   }

00008: 00C0 FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 00C3                     L0001:
00008: 00C3 83 7D FFFFFFEC 03           CMP DWORD PTR FFFFFFEC[EBP], 00000003
00008: 00C7 0F 8C FFFFFF64              JL L0002

; 523:   return k; 

00008: 00CD 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00000: 00D0                     L0000:
00000: 00D0                             epilog 
00000: 00D0 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00D3 5B                          POP EBX
00000: 00D4 5D                          POP EBP
00000: 00D5 C3                          RETN 

Function: _make_tables

; 527: {  

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

; 530:   if(!dimensionality(is_x))return 0;

00008: 0015 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0018 50                          PUSH EAX
00008: 0019 E8 00000000                 CALL SHORT _dimensionality
00008: 001E 59                          POP ECX
00008: 001F 83 F8 00                    CMP EAX, 00000000
00008: 0022 75 07                       JNE L0001
00008: 0024 B8 00000000                 MOV EAX, 00000000
00000: 0029                             epilog 
00000: 0029 C9                          LEAVE 
00000: 002A C3                          RETN 
00008: 002B                     L0001:

; 531:   init_update_param(is_x);

00008: 002B 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 002E 50                          PUSH EAX
00008: 002F E8 00000000                 CALL SHORT _init_update_param
00008: 0034 59                          POP ECX

; 532:   if(!allocsearch(n1)){StopAlert (MEMORY_ALRT);return -1;}

00008: 0035 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 003A 50                          PUSH EAX
00008: 003B E8 00000000                 CALL SHORT _allocsearch
00008: 0040 59                          POP ECX
00008: 0041 83 F8 00                    CMP EAX, 00000000
00008: 0044 75 0F                       JNE L0002
00008: 0046 6A 02                       PUSH 00000002
00008: 0048 E8 00000000                 CALL SHORT _StopAlert
00008: 004D 59                          POP ECX
00008: 004E B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0053                             epilog 
00000: 0053 C9                          LEAVE 
00000: 0054 C3                          RETN 
00008: 0055                     L0002:

; 533:   err=init_tables();

00008: 0055 E8 00000000                 CALL SHORT _init_tables
00008: 005A 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 534:   if(err!=1)return err;

00008: 005D 83 7D FFFFFFF0 01           CMP DWORD PTR FFFFFFF0[EBP], 00000001
00008: 0061 74 05                       JE L0003
00008: 0063 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00000: 0066                             epilog 
00000: 0066 C9                          LEAVE 
00000: 0067 C3                          RETN 
00008: 0068                     L0003:

; 538:   dticks=10000;

00008: 0068 C7 05 00000004 40C38800     MOV DWORD PTR _dticks+00000004, 40C38800
00008: 0072 C7 05 00000000 00000000     MOV DWORD PTR _dticks, 00000000

; 539:   return 1;

00008: 007C B8 00000001                 MOV EAX, 00000001
00000: 0081                     L0000:
00000: 0081                             epilog 
00000: 0081 C9                          LEAVE 
00000: 0082 C3                          RETN 

Function: _init_keywords

; 543: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 545:   keywords=(unsigned char **)malloc(20*sizeof(unsigned char *));

00008: 0012 6A 50                       PUSH 00000050
00008: 0014 E8 00000000                 CALL SHORT _malloc
00008: 0019 59                          POP ECX
00008: 001A A3 00000000                 MOV DWORD PTR _keywords, EAX

; 546:   if(!keywords) return 0;

00008: 001F 83 3D 00000000 00           CMP DWORD PTR _keywords, 00000000
00008: 0026 75 07                       JNE L0001
00008: 0028 B8 00000000                 MOV EAX, 00000000
00000: 002D                             epilog 
00000: 002D C9                          LEAVE 
00000: 002E C3                          RETN 
00008: 002F                     L0001:

; 547:   keyfound=(int *)malloc(20*sizeof(int));

00008: 002F 6A 50                       PUSH 00000050
00008: 0031 E8 00000000                 CALL SHORT _malloc
00008: 0036 59                          POP ECX
00008: 0037 A3 00000000                 MOV DWORD PTR _keyfound, EAX

; 548:   if(!keyfound) return 0;

00008: 003C 83 3D 00000000 00           CMP DWORD PTR _keyfound, 00000000
00008: 0043 75 07                       JNE L0002
00008: 0045 B8 00000000                 MOV EAX, 00000000
00000: 004A                             epilog 
00000: 004A C9                          LEAVE 
00000: 004B C3                          RETN 
00008: 004C                     L0002:

; 549:   n_keywords=12; 

00008: 004C C7 05 00000000 0000000C     MOV DWORD PTR _n_keywords, 0000000C

; 550:   keywords[SYS_SIZE]="A.SYSTEM SIZE";

00008: 0056 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 005C C7 42 04 00000000           MOV DWORD PTR 00000004[EDX], OFFSET @564

; 551:   keywords[NUM_ATOMS]="B.NUMBER OF ATOMS";

00008: 0063 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0069 C7 42 08 00000000           MOV DWORD PTR 00000008[EDX], OFFSET @565

; 552:   keywords[TYPE_ATOMS]="C.TYPES OF ATOMS";

00008: 0070 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0076 C7 42 0C 00000000           MOV DWORD PTR 0000000C[EDX], OFFSET @566

; 553:   keywords[NONEL_COL]="D.NON-ELASTIC COLLISIONS";

00008: 007D 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0083 C7 42 10 00000000           MOV DWORD PTR 00000010[EDX], OFFSET @567

; 554:   keywords[EL_COL]="E.ELASTIC COLLISIONS";

00008: 008A 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 0090 C7 42 14 00000000           MOV DWORD PTR 00000014[EDX], OFFSET @568

; 555:   keywords[LINK_PAIRS]="F.LINKED PAIRS";

00008: 0097 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 009D C7 42 18 00000000           MOV DWORD PTR 00000018[EDX], OFFSET @569

; 556:   keywords[REACT]="G.REACTIONS";

00008: 00A4 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00AA C7 42 1C 00000000           MOV DWORD PTR 0000001C[EDX], OFFSET @570

; 557:   keywords[LIST_ATOMS]="H.LIST OF ATOMS";

00008: 00B1 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00B7 C7 42 20 00000000           MOV DWORD PTR 00000020[EDX], OFFSET @571

; 558:   keywords[LIST_BONDS]="I.LIST OF BONDS";

00008: 00BE 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00C4 C7 42 24 00000000           MOV DWORD PTR 00000024[EDX], OFFSET @572

; 559:   keywords[NUM_BONDS]="J.BOND TABLE LENGTH";

00008: 00CB 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00D1 C7 42 28 00000000           MOV DWORD PTR 00000028[EDX], OFFSET @573

; 560:   keywords[LIST_PARAM]="K.LIST OF PARAMETERS";

00008: 00D8 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00DE C7 42 2C 00000000           MOV DWORD PTR 0000002C[EDX], OFFSET @574

; 561:   keywords[COL_TABLE]="COLLISION TABLE LENGTH";

00008: 00E5 8B 15 00000000              MOV EDX, DWORD PTR _keywords
00008: 00EB C7 42 30 00000000           MOV DWORD PTR 00000030[EDX], OFFSET @575

; 562:   for(i=0;i<=n_keywords;i++)

00008: 00F2 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000
00008: 00F9 EB 13                       JMP L0003
00008: 00FB                     L0004:

; 563:   keyfound[i]=0;

00008: 00FB 8B 15 00000000              MOV EDX, DWORD PTR _keyfound
00008: 0101 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0104 C7 04 82 00000000           MOV DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 010B FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]
00008: 010E                     L0003:
00008: 010E 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0111 3B 05 00000000              CMP EAX, DWORD PTR _n_keywords
00008: 0117 7E FFFFFFE2                 JLE L0004

; 564:   return 1;

00008: 0119 B8 00000001                 MOV EAX, 00000001
00000: 011E                     L0000:
00000: 011E                             epilog 
00000: 011E C9                          LEAVE 
00000: 011F C3                          RETN 

Function: _startup

; 568: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 20                    SUB ESP, 00000020
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 B9 00000008                 MOV ECX, 00000008
00000: 0015 F3 AB                       REP STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 572:   if(!init_keywords())return -4;

00008: 0018 E8 00000000                 CALL SHORT _init_keywords
00008: 001D 83 F8 00                    CMP EAX, 00000000
00008: 0020 75 07                       JNE L0001
00008: 0022 B8 FFFFFFFC                 MOV EAX, FFFFFFFC
00000: 0027                             epilog 
00000: 0027 C9                          LEAVE 
00000: 0028 C3                          RETN 
00008: 0029                     L0001:

; 573:   dblarg1=DBL_MAX*0.5e-10;

00008: 0029 DD 05 00000000              FLD QWORD PTR .data+00000388
00007: 002F DC 0D 00000000              FMUL QWORD PTR ___double_max
00007: 0035 DD 1D 00000000              FSTP QWORD PTR _dblarg1

; 574:   dblarg2=DBL_MAX*10e-10;

00008: 003B DD 05 00000000              FLD QWORD PTR .data+00000390
00007: 0041 DC 0D 00000000              FMUL QWORD PTR ___double_max
00007: 0047 DD 1D 00000000              FSTP QWORD PTR _dblarg2

; 575:   isfile=readfile();

00008: 004D E8 00000000                 CALL SHORT _readfile
00008: 0052 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 576:   if(isfile==TEXT)

00008: 0055 83 7D FFFFFFE4 02           CMP DWORD PTR FFFFFFE4[EBP], 00000002
00008: 0059 0F 85 0000009E              JNE L0002

; 579:       unsigned char * buf=get_buffer(&file_length);

00008: 005F 8D 45 FFFFFFFC              LEA EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0062 50                          PUSH EAX
00008: 0063 E8 00000000                 CALL SHORT _get_buffer
00008: 0068 59                          POP ECX
00008: 0069 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 580:       unsigned char * datfile, *nextline= buf;;   

00008: 006C 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 006F 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 581:       if(!buf)return -4; 

00008: 0072 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0076 75 07                       JNE L0003
00008: 0078 B8 FFFFFFFC                 MOV EAX, FFFFFFFC
00000: 007D                             epilog 
00000: 007D C9                          LEAVE 
00000: 007E C3                          RETN 
00008: 007F                     L0003:

; 583:       line_number=MOVIE-1;

00008: 007F C7 05 00000000 00000002     MOV DWORD PTR _line_number, 00000002

; 584:       nextline=next_line(nextline);

00008: 0089 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 008C E8 00000000                 CALL SHORT _next_line
00008: 0091 59                          POP ECX
00008: 0092 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 586:       datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 0095 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0098 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 009B FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 009E E8 00000000                 CALL SHORT _next_line
00008: 00A3 59                          POP ECX
00008: 00A4 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 00A7 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 00AB 75 07                       JNE L0004
00008: 00AD A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 00B2                             epilog 
00000: 00B2 C9                          LEAVE 
00000: 00B3 C3                          RETN 
00008: 00B4                     L0004:

; 588:       i=iskeyword(datfile);

00008: 00B4 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 00B7 E8 00000000                 CALL SHORT _iskeyword
00008: 00BC 59                          POP ECX
00008: 00BD 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 590:       if(i>0) err=make_key_system(i,nextline,file_length);

00008: 00C0 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 00C4 7E 17                       JLE L0005
00008: 00C6 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 00C9 50                          PUSH EAX
00008: 00CA FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 00CD FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 00D0 E8 00000000                 CALL SHORT _make_key_system
00008: 00D5 83 C4 0C                    ADD ESP, 0000000C
00008: 00D8 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 00DB EB 07                       JMP L0006
00008: 00DD                     L0005:

; 591:       else return line_number;

00008: 00DD A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 00E2                             epilog 
00000: 00E2 C9                          LEAVE 
00000: 00E3 C3                          RETN 
00008: 00E4                     L0006:

; 595:       if(err!=1)return err;

00008: 00E4 83 7D FFFFFFE8 01           CMP DWORD PTR FFFFFFE8[EBP], 00000001
00008: 00E8 74 05                       JE L0007
00008: 00EA 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00000: 00ED                             epilog 
00000: 00ED C9                          LEAVE 
00000: 00EE C3                          RETN 
00008: 00EF                     L0007:

; 596:       free(buf);

00008: 00EF FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 00F2 E8 00000000                 CALL SHORT _free
00008: 00F7 59                          POP ECX

; 597:       init_parameters();

00008: 00F8 E8 00000000                 CALL SHORT _init_parameters

; 598:     }

00008: 00FD                     L0002:

; 599:   return make_tables(isfile);

00008: 00FD FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 0100 E8 00000000                 CALL SHORT _make_tables
00008: 0105 59                          POP ECX
00008: 0106 89 C0                       MOV EAX, EAX
00000: 0108                     L0000:
00000: 0108                             epilog 
00000: 0108 C9                          LEAVE 
00000: 0109 C3                          RETN 

Function: _make_bonds

; 603: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 20                    SUB ESP, 00000020
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 B9 00000008                 MOV ECX, 00000008
00000: 0015 F3 AB                       REP STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 605: int actual_number=0;

00008: 0018 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000

; 608: for (i=0;i<numbond;i++)

00008: 001F C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0026 E9 00000080                 JMP L0001
00008: 002B                     L0002:

; 610:     friend1=*bonds;

00008: 002B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 002E DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0030 D9 7D FFFFFFF4              FNSTCW WORD PTR FFFFFFF4[EBP]
00007: 0033 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00007: 0036 80 4D FFFFFFF5 0C           OR BYTE PTR FFFFFFF5[EBP], 0C
00007: 003A D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00007: 003D DB 5D FFFFFFF8              FISTP DWORD PTR FFFFFFF8[EBP]
00008: 0040 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX
00008: 0043 D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00008: 0046 8B 55 FFFFFFF8              MOV EDX, DWORD PTR FFFFFFF8[EBP]
00008: 0049 89 55 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EDX

; 611:     bonds++;

00008: 004C 83 45 0C 08                 ADD DWORD PTR 0000000C[EBP], 00000008

; 612:     friend2=*bonds;

00008: 0050 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0053 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0055 D9 7D FFFFFFF4              FNSTCW WORD PTR FFFFFFF4[EBP]
00007: 0058 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00007: 005B 80 4D FFFFFFF5 0C           OR BYTE PTR FFFFFFF5[EBP], 0C
00007: 005F D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00007: 0062 DB 5D FFFFFFF8              FISTP DWORD PTR FFFFFFF8[EBP]
00008: 0065 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX
00008: 0068 D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00008: 006B 8B 55 FFFFFFF8              MOV EDX, DWORD PTR FFFFFFF8[EBP]
00008: 006E 89 55 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EDX

; 613:     bonds++;

00008: 0071 83 45 0C 08                 ADD DWORD PTR 0000000C[EBP], 00000008

; 614:     res=setBond(friend1,friend2);

00008: 0075 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0078 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 007B E8 00000000                 CALL SHORT _setBond
00008: 0080 59                          POP ECX
00008: 0081 59                          POP ECX
00008: 0082 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 615:     if(res<0)

00008: 0085 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0089 7D 07                       JGE L0003

; 616:       {return -1;}

00008: 008B B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0090                             epilog 
00000: 0090 C9                          LEAVE 
00000: 0091 C3                          RETN 
00008: 0092                     L0003:

; 617:     if(res==1)

00008: 0092 83 7D FFFFFFE8 01           CMP DWORD PTR FFFFFFE8[EBP], 00000001
00008: 0096 75 07                       JNE L0004

; 618:       {return -1;}

00008: 0098 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 009D                             epilog 
00000: 009D C9                          LEAVE 
00000: 009E C3                          RETN 
00008: 009F                     L0004:

; 619:     actual_number+=res;

00008: 009F 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00A2 03 45 FFFFFFE8              ADD EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00A5 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 620:   }

00008: 00A8 FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 00AB                     L0001:
00008: 00AB 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00AE 3B 45 08                    CMP EAX, DWORD PTR 00000008[EBP]
00008: 00B1 0F 8C FFFFFF74              JL L0002

; 621: return actual_number;   

00008: 00B7 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00000: 00BA                     L0000:
00000: 00BA                             epilog 
00000: 00BA C9                          LEAVE 
00000: 00BB C3                          RETN 

Function: _printwells

; 624: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 58                    SUB ESP, 00000058
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 00000016                 MOV ECX, 00000016
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 627:   for(i=1;i<=nat;i++)

00008: 0018 C7 45 FFFFFFA0 00000001     MOV DWORD PTR FFFFFFA0[EBP], 00000001
00008: 001F E9 00000084                 JMP L0001
00008: 0024                     L0002:

; 628:     for(j=1;j<=i;j++)

00008: 0024 C7 45 FFFFFFA4 00000001     MOV DWORD PTR FFFFFFA4[EBP], 00000001
00008: 002B EB 70                       JMP L0003
00008: 002D                     L0004:

; 630: 	next=icoll[i][j];

00008: 002D 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 0030 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0033 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0036 8B 4D FFFFFFA4              MOV ECX, DWORD PTR FFFFFFA4[EBP]
00008: 0039 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 003C 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 631: 	while(next>-1)

00008: 003F EB 53                       JMP L0005
00008: 0041                     L0006:

; 633: 	    x=coll[next];

00008: 0041 8B 5D FFFFFFA8              MOV EBX, DWORD PTR FFFFFFA8[EBP]
00008: 0044 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0047 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 004D 8D 7D FFFFFFAC              LEA EDI, DWORD PTR FFFFFFAC[EBP]
00008: 0050 8D 34 DA                    LEA ESI, DWORD PTR 00000000[EDX][EBX*8]
00008: 0053 B9 00000012                 MOV ECX, 00000012
00008: 0058 F3 A5                       REP MOVSD 

; 634: 	    printf("%d %d %d %d %d %d %lf %le %le\n",i,j,next, (int)x.next,(int)x.prev,(int)x.react,x.dd,x.eo,x.etot);

00008: 005A FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 005D FF 75 FFFFFFBC              PUSH DWORD PTR FFFFFFBC[EBP]
00008: 0060 FF 75 FFFFFFB8              PUSH DWORD PTR FFFFFFB8[EBP]
00008: 0063 FF 75 FFFFFFB4              PUSH DWORD PTR FFFFFFB4[EBP]
00008: 0066 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 0069 FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 006C 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 006F 50                          PUSH EAX
00008: 0070 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0073 50                          PUSH EAX
00008: 0074 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0077 50                          PUSH EAX
00008: 0078 FF 75 FFFFFFA8              PUSH DWORD PTR FFFFFFA8[EBP]
00008: 007B FF 75 FFFFFFA4              PUSH DWORD PTR FFFFFFA4[EBP]
00008: 007E FF 75 FFFFFFA0              PUSH DWORD PTR FFFFFFA0[EBP]
00008: 0081 68 00000000                 PUSH OFFSET @624
00008: 0086 E8 00000000                 CALL SHORT _printf
00008: 008B 83 C4 34                    ADD ESP, 00000034

; 635: 	    next=x.next;

00008: 008E 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0091 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 636: 	  }

00008: 0094                     L0005:
00008: 0094 83 7D FFFFFFA8 FFFFFFFF     CMP DWORD PTR FFFFFFA8[EBP], FFFFFFFF
00008: 0098 7F FFFFFFA7                 JG L0006

; 637:       }

00008: 009A FF 45 FFFFFFA4              INC DWORD PTR FFFFFFA4[EBP]
00008: 009D                     L0003:
00008: 009D 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 00A0 3B 45 FFFFFFA0              CMP EAX, DWORD PTR FFFFFFA0[EBP]
00008: 00A3 7E FFFFFF88                 JLE L0004
00008: 00A5 FF 45 FFFFFFA0              INC DWORD PTR FFFFFFA0[EBP]
00008: 00A8                     L0001:
00008: 00A8 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 00AB 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 00AE 0F 8E FFFFFF70              JLE L0002

; 638:   printf("%d %d\n",nen,nen1);

00008: 00B4 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 00B9 50                          PUSH EAX
00008: 00BA A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 00BF 50                          PUSH EAX
00008: 00C0 68 00000000                 PUSH OFFSET @625
00008: 00C5 E8 00000000                 CALL SHORT _printf
00008: 00CA 83 C4 0C                    ADD ESP, 0000000C

; 639: }

00000: 00CD                     L0000:
00000: 00CD                             epilog 
00000: 00CD 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00D0 5F                          POP EDI
00000: 00D1 5E                          POP ESI
00000: 00D2 5B                          POP EBX
00000: 00D3 5D                          POP EBP
00000: 00D4 C3                          RETN 

Function: _make_wells

; 644: {

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

; 651:   ntot=numwell+numbondwell+nrt;

00008: 0018 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 001B 03 55 14                    ADD EDX, DWORD PTR 00000014[EBP]
00008: 001E 03 15 00000000              ADD EDX, DWORD PTR _nrt
00008: 0024 89 15 00000000              MOV DWORD PTR _ntot, EDX

; 652:   for(i=1;i<=nat;i++)

00008: 002A C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 0031 EB 2F                       JMP L0001
00008: 0033                     L0002:

; 653:     for(j=1;j<=i;j++)

00008: 0033 C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 003A EB 1B                       JMP L0003
00008: 003C                     L0004:

; 654: 	if(!coldata[i][j])ntot++;

00008: 003C 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 003F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0042 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0045 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0048 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 004C 75 06                       JNE L0005
00008: 004E FF 05 00000000              INC DWORD PTR _ntot
00008: 0054                     L0005:
00008: 0054 FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 0057                     L0003:
00008: 0057 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 005A 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 005D 7E FFFFFFDD                 JLE L0004
00008: 005F FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0062                     L0001:
00008: 0062 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0065 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 0068 7E FFFFFFC9                 JLE L0002

; 655:   for(k=0;k<numbond;k++)

00008: 006A C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000
00008: 0071 E9 000000EC                 JMP L0006
00008: 0076                     L0007:

; 657:       i=bonds[2*k];

00008: 0076 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0079 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 0080 8B 45 18                    MOV EAX, DWORD PTR 00000018[EBP]
00008: 0083 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 0086 D9 7D FFFFFFD8              FNSTCW WORD PTR FFFFFFD8[EBP]
00007: 0089 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00007: 008C 80 4D FFFFFFD9 0C           OR BYTE PTR FFFFFFD9[EBP], 0C
00007: 0090 D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00007: 0093 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0096 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 0099 D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00008: 009C 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 009F 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 658:       j=bonds[2*k+1];

00008: 00A2 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 00A5 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00AC 42                          INC EDX
00008: 00AD 8B 45 18                    MOV EAX, DWORD PTR 00000018[EBP]
00008: 00B0 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 00B3 D9 7D FFFFFFD8              FNSTCW WORD PTR FFFFFFD8[EBP]
00007: 00B6 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00007: 00B9 80 4D FFFFFFD9 0C           OR BYTE PTR FFFFFFD9[EBP], 0C
00007: 00BD D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00007: 00C0 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 00C3 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 00C6 D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00008: 00C9 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 00CC 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX

; 659:       i=a[i].c;

00008: 00CF 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 00D2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00D9 29 D3                       SUB EBX, EDX
00008: 00DB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00DE 8B 45 20                    MOV EAX, DWORD PTR 00000020[EBP]
00008: 00E1 0F BF 94 D8 000000A4        MOVSX EDX, WORD PTR 000000A4[EAX][EBX*8]
00008: 00E9 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 660:       j=a[j].c;

00008: 00EC 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 00EF 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00F6 29 D3                       SUB EBX, EDX
00008: 00F8 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00FB 8B 45 20                    MOV EAX, DWORD PTR 00000020[EBP]
00008: 00FE 0F BF 94 D8 000000A4        MOVSX EDX, WORD PTR 000000A4[EAX][EBX*8]
00008: 0106 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX

; 661:       if(j>i){l=i;i=j;j=l;}

00008: 0109 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 010C 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 010F 7E 12                       JLE L0008
00008: 0111 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0114 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX
00008: 0117 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 011A 89 45 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EAX
00008: 011D 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 0120 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX
00008: 0123                     L0008:

; 662:       if(!bonddata[i][j])

00008: 0123 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0126 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0129 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 012C 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 012F 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 0133 75 2A                       JNE L0009

; 664: 	  bonddata[i][j]=bonds+2*k;

00008: 0135 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0138 8D 1C 5D 00000000           LEA EBX, [00000000][EBX*2]
00008: 013F 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 0146 03 5D 18                    ADD EBX, DWORD PTR 00000018[EBP]
00008: 0149 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 014C 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 014F 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 0152 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0155 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 665: 	  ntot+=2;

00008: 0158 83 05 00000000 02           ADD DWORD PTR _ntot, 00000002

; 666: 	}

00008: 015F                     L0009:

; 667:     }

00008: 015F FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0162                     L0006:
00008: 0162 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0165 3B 45 1C                    CMP EAX, DWORD PTR 0000001C[EBP]
00008: 0168 0F 8C FFFFFF08              JL L0007

; 669:   nat2=(nat+1)*(nat+1);

00008: 016E 8B 4D 2C                    MOV ECX, DWORD PTR 0000002C[EBP]
00008: 0171 41                          INC ECX
00008: 0172 8B 55 2C                    MOV EDX, DWORD PTR 0000002C[EBP]
00008: 0175 42                          INC EDX
00008: 0176 0F AF CA                    IMUL ECX, EDX
00008: 0179 89 4D FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], ECX

; 670:   coll=(CollisionData *)malloc(ntot*sizeof(CollisionData));

00008: 017C 8B 15 00000000              MOV EDX, DWORD PTR _ntot
00008: 0182 6B D2 48                    IMUL EDX, EDX, 00000048
00008: 0185 52                          PUSH EDX
00008: 0186 E8 00000000                 CALL SHORT _malloc
00008: 018B 59                          POP ECX
00008: 018C A3 00000000                 MOV DWORD PTR _coll, EAX

; 671:   if(!coll)return 0; 

00008: 0191 83 3D 00000000 00           CMP DWORD PTR _coll, 00000000
00008: 0198 75 0D                       JNE L000A
00008: 019A B8 00000000                 MOV EAX, 00000000
00000: 019F                             epilog 
00000: 019F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01A2 5F                          POP EDI
00000: 01A3 5E                          POP ESI
00000: 01A4 5B                          POP EBX
00000: 01A5 5D                          POP EBP
00000: 01A6 C3                          RETN 
00008: 01A7                     L000A:

; 672:   ecoll=(well_type **)malloc((nat+1)*sizeof(well_type *));

00008: 01A7 8B 55 2C                    MOV EDX, DWORD PTR 0000002C[EBP]
00008: 01AA 42                          INC EDX
00008: 01AB 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 01B2 52                          PUSH EDX
00008: 01B3 E8 00000000                 CALL SHORT _malloc
00008: 01B8 59                          POP ECX
00008: 01B9 A3 00000000                 MOV DWORD PTR _ecoll, EAX

; 673:   if(!ecoll){StopAlert (MEMORY_ALRT);return line_number;}

00008: 01BE 83 3D 00000000 00           CMP DWORD PTR _ecoll, 00000000
00008: 01C5 75 15                       JNE L000B
00008: 01C7 6A 02                       PUSH 00000002
00008: 01C9 E8 00000000                 CALL SHORT _StopAlert
00008: 01CE 59                          POP ECX
00008: 01CF A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 01D4                             epilog 
00000: 01D4 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01D7 5F                          POP EDI
00000: 01D8 5E                          POP ESI
00000: 01D9 5B                          POP EBX
00000: 01DA 5D                          POP EBP
00000: 01DB C3                          RETN 
00008: 01DC                     L000B:

; 674:   ecoll[0]=(well_type *)malloc(nat2*sizeof(well_type));

00008: 01DC 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01DF 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 01E6 52                          PUSH EDX
00008: 01E7 E8 00000000                 CALL SHORT _malloc
00008: 01EC 59                          POP ECX
00008: 01ED 8B 15 00000000              MOV EDX, DWORD PTR _ecoll
00008: 01F3 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 675:   if(!ecoll[0]){StopAlert (MEMORY_ALRT);return line_number;}

00008: 01F5 8B 15 00000000              MOV EDX, DWORD PTR _ecoll
00008: 01FB 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 01FE 75 15                       JNE L000C
00008: 0200 6A 02                       PUSH 00000002
00008: 0202 E8 00000000                 CALL SHORT _StopAlert
00008: 0207 59                          POP ECX
00008: 0208 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 020D                             epilog 
00000: 020D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0210 5F                          POP EDI
00000: 0211 5E                          POP ESI
00000: 0212 5B                          POP EBX
00000: 0213 5D                          POP EBP
00000: 0214 C3                          RETN 
00008: 0215                     L000C:

; 676:   for(i=0;i<nat;i++)

00008: 0215 C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 021C EB 29                       JMP L000D
00008: 021E                     L000E:

; 677:     ecoll[i+1]=ecoll[i]+nat+1;

00008: 021E 8B 5D 2C                    MOV EBX, DWORD PTR 0000002C[EBP]
00008: 0221 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 0228 8B 35 00000000              MOV ESI, DWORD PTR _ecoll
00008: 022E 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0231 03 1C 86                    ADD EBX, DWORD PTR 00000000[ESI][EAX*4]
00008: 0234 83 C3 04                    ADD EBX, 00000004
00008: 0237 8B 7D FFFFFFB4              MOV EDI, DWORD PTR FFFFFFB4[EBP]
00008: 023A 47                          INC EDI
00008: 023B 8B 35 00000000              MOV ESI, DWORD PTR _ecoll
00008: 0241 89 1C BE                    MOV DWORD PTR 00000000[ESI][EDI*4], EBX
00008: 0244 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0247                     L000D:
00008: 0247 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 024A 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 024D 7C FFFFFFCF                 JL L000E

; 678:   for(i=0;i<nat2;i++)

00008: 024F C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 0256 EB 15                       JMP L000F
00008: 0258                     L0010:

; 679:     ecoll[0][i]=-1;

00008: 0258 8B 15 00000000              MOV EDX, DWORD PTR _ecoll
00008: 025E 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0260 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0263 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF
00008: 026A FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 026D                     L000F:
00008: 026D 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0270 3B 45 FFFFFFC4              CMP EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0273 7C FFFFFFE3                 JL L0010

; 681:   icoll=(well_type **)malloc((nat+1)*sizeof(well_type *));

00008: 0275 8B 55 2C                    MOV EDX, DWORD PTR 0000002C[EBP]
00008: 0278 42                          INC EDX
00008: 0279 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0280 52                          PUSH EDX
00008: 0281 E8 00000000                 CALL SHORT _malloc
00008: 0286 59                          POP ECX
00008: 0287 A3 00000000                 MOV DWORD PTR _icoll, EAX

; 682:   if(!icoll){StopAlert (MEMORY_ALRT);return line_number;}

00008: 028C 83 3D 00000000 00           CMP DWORD PTR _icoll, 00000000
00008: 0293 75 15                       JNE L0011
00008: 0295 6A 02                       PUSH 00000002
00008: 0297 E8 00000000                 CALL SHORT _StopAlert
00008: 029C 59                          POP ECX
00008: 029D A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 02A2                             epilog 
00000: 02A2 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02A5 5F                          POP EDI
00000: 02A6 5E                          POP ESI
00000: 02A7 5B                          POP EBX
00000: 02A8 5D                          POP EBP
00000: 02A9 C3                          RETN 
00008: 02AA                     L0011:

; 683:   icoll[0]=(well_type *)malloc(nat2*sizeof(well_type));

00008: 02AA 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 02AD 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 02B4 52                          PUSH EDX
00008: 02B5 E8 00000000                 CALL SHORT _malloc
00008: 02BA 59                          POP ECX
00008: 02BB 8B 15 00000000              MOV EDX, DWORD PTR _icoll
00008: 02C1 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 684:   if(!icoll[0]){StopAlert (MEMORY_ALRT);return line_number;}

00008: 02C3 8B 15 00000000              MOV EDX, DWORD PTR _icoll
00008: 02C9 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 02CC 75 15                       JNE L0012
00008: 02CE 6A 02                       PUSH 00000002
00008: 02D0 E8 00000000                 CALL SHORT _StopAlert
00008: 02D5 59                          POP ECX
00008: 02D6 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 02DB                             epilog 
00000: 02DB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02DE 5F                          POP EDI
00000: 02DF 5E                          POP ESI
00000: 02E0 5B                          POP EBX
00000: 02E1 5D                          POP EBP
00000: 02E2 C3                          RETN 
00008: 02E3                     L0012:

; 685:   for(i=0;i<nat;i++)

00008: 02E3 C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 02EA EB 29                       JMP L0013
00008: 02EC                     L0014:

; 686:     icoll[i+1]=icoll[i]+nat+1;

00008: 02EC 8B 5D 2C                    MOV EBX, DWORD PTR 0000002C[EBP]
00008: 02EF 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 02F6 8B 35 00000000              MOV ESI, DWORD PTR _icoll
00008: 02FC 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 02FF 03 1C 86                    ADD EBX, DWORD PTR 00000000[ESI][EAX*4]
00008: 0302 83 C3 04                    ADD EBX, 00000004
00008: 0305 8B 7D FFFFFFB4              MOV EDI, DWORD PTR FFFFFFB4[EBP]
00008: 0308 47                          INC EDI
00008: 0309 8B 35 00000000              MOV ESI, DWORD PTR _icoll
00008: 030F 89 1C BE                    MOV DWORD PTR 00000000[ESI][EDI*4], EBX
00008: 0312 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0315                     L0013:
00008: 0315 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0318 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 031B 7C FFFFFFCF                 JL L0014

; 687:   for(i=0;i<nat2;i++)

00008: 031D C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 0324 EB 15                       JMP L0015
00008: 0326                     L0016:

; 688:     icoll[0][i]=-1;

00008: 0326 8B 15 00000000              MOV EDX, DWORD PTR _icoll
00008: 032C 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 032E 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0331 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF
00008: 0338 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 033B                     L0015:
00008: 033B 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 033E 3B 45 FFFFFFC4              CMP EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0341 7C FFFFFFE3                 JL L0016

; 690:   nen=0;

00008: 0343 C7 05 00000000 00000000     MOV DWORD PTR _nen, 00000000

; 691:   nen1=ntot;

00008: 034D 8B 15 00000000              MOV EDX, DWORD PTR _ntot
00008: 0353 89 15 00000000              MOV DWORD PTR _nen1, EDX

; 692:   for(i=1;i<=nat;i++)

00008: 0359 C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 0360 E9 0000025B                 JMP L0017
00008: 0365                     L0018:

; 693:     for(j=1;j<=i;j++)

00008: 0365 C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 036C E9 00000240                 JMP L0019
00008: 0371                     L001A:

; 695: 	if(coldata[i][j])

00008: 0371 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0374 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0377 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 037A 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 037D 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 0381 0F 84 00000154              JE L001B

; 697: 	    l=coldata[i][j][0];

00008: 0387 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 038A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 038D 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0390 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0393 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0396 DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 0398 D9 7D FFFFFFD8              FNSTCW WORD PTR FFFFFFD8[EBP]
00007: 039B 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00007: 039E 80 4D FFFFFFD9 0C           OR BYTE PTR FFFFFFD9[EBP], 0C
00007: 03A2 D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00007: 03A5 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 03A8 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 03AB D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00008: 03AE 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 03B1 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 698:             next=-1;

00008: 03B4 C7 45 FFFFFFD0 FFFFFFFF     MOV DWORD PTR FFFFFFD0[EBP], FFFFFFFF

; 699: 	    for(k=1;k<l;k+=2)

00008: 03BB C7 45 FFFFFFBC 00000001     MOV DWORD PTR FFFFFFBC[EBP], 00000001
00008: 03C2 E9 000000D9                 JMP L001C
00008: 03C7                     L001D:

; 701: 		if(k==1)

00008: 03C7 83 7D FFFFFFBC 01           CMP DWORD PTR FFFFFFBC[EBP], 00000001
00008: 03CB 75 10                       JNE L001E

; 703:                     nen1--;

00008: 03CD FF 0D 00000000              DEC DWORD PTR _nen1

; 704:                     num=nen1;

00008: 03D3 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 03D8 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 705: 		  }

00008: 03DB EB 0E                       JMP L001F
00008: 03DD                     L001E:

; 709: 		    num=nen;

00008: 03DD A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 03E2 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 710: 		    nen++;

00008: 03E5 FF 05 00000000              INC DWORD PTR _nen

; 711: 		  }

00008: 03EB                     L001F:

; 712: 		if(k==l-2)

00008: 03EB 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 03EE 83 C2 FFFFFFFE              ADD EDX, FFFFFFFE
00008: 03F1 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 03F4 75 09                       JNE L0020

; 713: 		  prev=-1;

00008: 03F6 C7 45 FFFFFFD4 FFFFFFFF     MOV DWORD PTR FFFFFFD4[EBP], FFFFFFFF
00008: 03FD EB 08                       JMP L0021
00008: 03FF                     L0020:

; 715: 		  prev=nen;

00008: 03FF A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 0404 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX
00008: 0407                     L0021:

; 716: 		init_coll(num,prev,next,sam[i].m,sam[j].m,coldata[i][j][k+1],coldata[i][j][k],0);

00008: 0407 6A 00                       PUSH 00000000
00008: 0409 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 040C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 040F 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0412 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0415 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0418 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 041B FF 74 C2 04                 PUSH DWORD PTR 00000004[EDX][EAX*8]
00008: 041F 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0422 FF 34 C2                    PUSH DWORD PTR 00000000[EDX][EAX*8]
00008: 0425 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0428 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 042B 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 042E 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0431 43                          INC EBX
00008: 0432 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0435 8B 14 86                    MOV EDX, DWORD PTR 00000000[ESI][EAX*4]
00008: 0438 FF 74 DA 04                 PUSH DWORD PTR 00000004[EDX][EBX*8]
00008: 043C FF 34 DA                    PUSH DWORD PTR 00000000[EDX][EBX*8]
00008: 043F 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0442 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0449 29 D3                       SUB EBX, EDX
00008: 044B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 044E 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0451 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0458 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 045B FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0462 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0465 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 046C 29 D3                       SUB EBX, EDX
00008: 046E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0471 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0474 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 047B 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 047E FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0485 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 0488 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 048B FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 048E E8 00000000                 CALL SHORT _init_coll
00008: 0493 83 C4 30                    ADD ESP, 00000030

; 717: 		next=num;

00008: 0496 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0499 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 718: 	      }

00008: 049C 83 45 FFFFFFBC 02           ADD DWORD PTR FFFFFFBC[EBP], 00000002
00008: 04A0                     L001C:
00008: 04A0 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 04A3 3B 45 FFFFFFC0              CMP EAX, DWORD PTR FFFFFFC0[EBP]
00008: 04A6 0F 8C FFFFFF1B              JL L001D

; 719: 	    ecoll[i][j]=next;

00008: 04AC 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 04B2 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 04B5 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04B8 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 04BB 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 04BE 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 720:             ecoll[j][i]=next;

00008: 04C1 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 04C7 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 04CA 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04CD 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 04D0 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 04D3 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 721: 	  }

00008: 04D6 E9 000000D3                 JMP L0022
00008: 04DB                     L001B:

; 724: 	    nen1--;

00008: 04DB FF 0D 00000000              DEC DWORD PTR _nen1

; 725:             ecoll[i][j]=nen1;

00008: 04E1 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 04E7 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 04EA 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 04ED 8B 1D 00000000              MOV EBX, DWORD PTR _nen1
00008: 04F3 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 04F6 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 726:             ecoll[j][i]=nen1;

00008: 04F9 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 04FF 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0502 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0505 8B 1D 00000000              MOV EBX, DWORD PTR _nen1
00008: 050B 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 050E 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 727:             init_coll(nen1,-1,-1,sam[i].m,sam[j].m,dblarg1,sam[i].s+sam[j].s,0);

00008: 0511 6A 00                       PUSH 00000000
00008: 0513 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0516 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 051D 29 D6                       SUB ESI, EDX
00008: 051F 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0522 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0525 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 052C 29 D3                       SUB EBX, EDX
00008: 052E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0531 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0534 DD 84 D8 00000098           FLD QWORD PTR 00000098[EAX][EBX*8]
00007: 053B 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00007: 053E DC 84 F0 00000098           FADD QWORD PTR 00000098[EAX][ESI*8]
00007: 0545 50                          PUSH EAX
00007: 0546 50                          PUSH EAX
00007: 0547 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 054A FF 35 00000004              PUSH DWORD PTR _dblarg1+00000004
00008: 0550 FF 35 00000000              PUSH DWORD PTR _dblarg1
00008: 0556 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0559 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0560 29 D3                       SUB EBX, EDX
00008: 0562 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0565 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0568 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 056F 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0572 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0579 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 057C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0583 29 D3                       SUB EBX, EDX
00008: 0585 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0588 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 058B FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0592 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0595 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 059C 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 059E 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 05A0 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 05A5 50                          PUSH EAX
00008: 05A6 E8 00000000                 CALL SHORT _init_coll
00008: 05AB 83 C4 30                    ADD ESP, 00000030

; 728: 	  }

00008: 05AE                     L0022:

; 729:       }

00008: 05AE FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 05B1                     L0019:
00008: 05B1 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 05B4 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 05B7 0F 8E FFFFFDB4              JLE L001A
00008: 05BD FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 05C0                     L0017:
00008: 05C0 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 05C3 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 05C6 0F 8E FFFFFD99              JLE L0018

; 731:   for(i=1;i<=nat;i++)

00008: 05CC C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 05D3 E9 0000038D                 JMP L0023
00008: 05D8                     L0024:

; 732:     for(j=1;j<=i;j++)

00008: 05D8 C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 05DF E9 00000372                 JMP L0025
00008: 05E4                     L0026:

; 733:       if(bonddata[i][j])

00008: 05E4 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 05E7 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 05EA 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 05ED 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 05F0 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 05F4 0F 84 00000359              JE L0027

; 735: 	  if(bonddata[i][j]<bonds)

00008: 05FA 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 05FD 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0600 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0603 8B 4D 18                    MOV ECX, DWORD PTR 00000018[EBP]
00008: 0606 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0609 39 0C 83                    CMP DWORD PTR 00000000[EBX][EAX*4], ECX
00008: 060C 0F 83 000001C1              JAE L0028

; 737: 	      l=bonddata[i][j][0];

00008: 0612 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0615 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0618 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 061B 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 061E 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0621 DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 0623 D9 7D FFFFFFD8              FNSTCW WORD PTR FFFFFFD8[EBP]
00007: 0626 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00007: 0629 80 4D FFFFFFD9 0C           OR BYTE PTR FFFFFFD9[EBP], 0C
00007: 062D D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00007: 0630 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0633 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 0636 D9 6D FFFFFFD8              FLDCW WORD PTR FFFFFFD8[EBP]
00008: 0639 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 063C 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 738: 	      unstable=l&1;

00008: 063F 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 0642 83 E2 01                    AND EDX, 00000001
00008: 0645 89 55 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EDX

; 739: 	      l=l|1;

00008: 0648 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 064B 83 CA 01                    OR EDX, 00000001
00008: 064E 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 740: 	      next=-1;

00008: 0651 C7 45 FFFFFFD0 FFFFFFFF     MOV DWORD PTR FFFFFFD0[EBP], FFFFFFFF

; 741: 	      for(k=1;k<l;k+=2)

00008: 0658 C7 45 FFFFFFBC 00000001     MOV DWORD PTR FFFFFFBC[EBP], 00000001
00008: 065F E9 00000134                 JMP L0029
00008: 0664                     L002A:

; 743: 		  if((k==1)||((k==l-2)&&(!unstable)))

00008: 0664 83 7D FFFFFFBC 01           CMP DWORD PTR FFFFFFBC[EBP], 00000001
00008: 0668 74 11                       JE L002B
00008: 066A 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 066D 83 C2 FFFFFFFE              ADD EDX, FFFFFFFE
00008: 0670 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 0673 75 16                       JNE L002C
00008: 0675 83 7D FFFFFFC8 00           CMP DWORD PTR FFFFFFC8[EBP], 00000000
00008: 0679 75 10                       JNE L002C
00008: 067B                     L002B:

; 745: 		      nen1--;

00008: 067B FF 0D 00000000              DEC DWORD PTR _nen1

; 746: 		      num=nen1;

00008: 0681 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 0686 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 747: 		    }

00008: 0689 EB 0E                       JMP L002D
00008: 068B                     L002C:

; 751: 		      num=nen;

00008: 068B A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 0690 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 752: 		      nen++;

00008: 0693 FF 05 00000000              INC DWORD PTR _nen

; 753: 		    }

00008: 0699                     L002D:

; 755: 		  if(k==l-2)

00008: 0699 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 069C 83 C2 FFFFFFFE              ADD EDX, FFFFFFFE
00008: 069F 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 06A2 75 33                       JNE L002E

; 757: 		      prev=-1;

00008: 06A4 C7 45 FFFFFFD4 FFFFFFFF     MOV DWORD PTR FFFFFFD4[EBP], FFFFFFFF

; 758: 		      if(unstable)

00008: 06AB 83 7D FFFFFFC8 00           CMP DWORD PTR FFFFFFC8[EBP], 00000000
00008: 06AF 74 1B                       JE L002F

; 759: 			en=bonddata[i][j][k+1];

00008: 06B1 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 06B4 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 06B7 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 06BA 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 06BD 43                          INC EBX
00008: 06BE 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 06C1 8B 14 86                    MOV EDX, DWORD PTR 00000000[ESI][EAX*4]
00008: 06C4 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 06C7 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 06CA EB 2C                       JMP L0030
00008: 06CC                     L002F:

; 761: 			en=dblarg1;

00008: 06CC DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 06D2 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 762: 		    }

00008: 06D5 EB 21                       JMP L0030
00008: 06D7                     L002E:

; 765: 		      en=bonddata[i][j][k+1];

00008: 06D7 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 06DA 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 06DD 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 06E0 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 06E3 43                          INC EBX
00008: 06E4 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 06E7 8B 14 86                    MOV EDX, DWORD PTR 00000000[ESI][EAX*4]
00008: 06EA DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 06ED DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 766: 		      prev=nen;

00008: 06F0 A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 06F5 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 767: 		    }

00008: 06F8                     L0030:

; 768: 		  if((k==l-4)&&(!unstable))

00008: 06F8 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 06FB 83 C2 FFFFFFFC              ADD EDX, FFFFFFFC
00008: 06FE 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 0701 75 10                       JNE L0031
00008: 0703 83 7D FFFFFFC8 00           CMP DWORD PTR FFFFFFC8[EBP], 00000000
00008: 0707 75 0A                       JNE L0031

; 769: 		    prev=nen1-1;

00008: 0709 8B 15 00000000              MOV EDX, DWORD PTR _nen1
00008: 070F 4A                          DEC EDX
00008: 0710 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX
00008: 0713                     L0031:

; 770: 		  init_coll(num,prev,next,sam[i].m,sam[j].m,en,bonddata[i][j][k],-1);

00008: 0713 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 0715 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0718 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 071B 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 071E 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0721 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0724 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0727 FF 74 C2 04                 PUSH DWORD PTR 00000004[EDX][EAX*8]
00008: 072B 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 072E FF 34 C2                    PUSH DWORD PTR 00000000[EDX][EAX*8]
00008: 0731 FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 0734 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 0737 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 073A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0741 29 D3                       SUB EBX, EDX
00008: 0743 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0746 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0749 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0750 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0753 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 075A 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 075D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0764 29 D3                       SUB EBX, EDX
00008: 0766 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0769 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 076C FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0773 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0776 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 077D FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 0780 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0783 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0786 E8 00000000                 CALL SHORT _init_coll
00008: 078B 83 C4 30                    ADD ESP, 00000030

; 771: 		  next=num;

00008: 078E 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0791 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 772: 		}

00008: 0794 83 45 FFFFFFBC 02           ADD DWORD PTR FFFFFFBC[EBP], 00000002
00008: 0798                     L0029:
00008: 0798 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 079B 3B 45 FFFFFFC0              CMP EAX, DWORD PTR FFFFFFC0[EBP]
00008: 079E 0F 8C FFFFFEC0              JL L002A

; 773: 	      icoll[i][j]=next;

00008: 07A4 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 07AA 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 07AD 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 07B0 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 07B3 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 07B6 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 774: 	      icoll[j][i]=next;

00008: 07B9 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 07BF 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 07C2 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 07C5 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 07C8 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 07CB 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 775: 	    }

00008: 07CE E9 00000180                 JMP L0032
00008: 07D3                     L0028:

; 778: 	      nen1--;

00008: 07D3 FF 0D 00000000              DEC DWORD PTR _nen1

; 779: 	      init_coll(nen1,nen1-1,-1,sam[i].m,sam[j].m,dblarg1,sam[i].s+sam[j].s,-1);

00008: 07D9 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 07DB 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 07DE 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 07E5 29 D6                       SUB ESI, EDX
00008: 07E7 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 07EA 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 07ED 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 07F4 29 D3                       SUB EBX, EDX
00008: 07F6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07F9 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 07FC DD 84 D8 00000098           FLD QWORD PTR 00000098[EAX][EBX*8]
00007: 0803 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00007: 0806 DC 84 F0 00000098           FADD QWORD PTR 00000098[EAX][ESI*8]
00007: 080D 50                          PUSH EAX
00007: 080E 50                          PUSH EAX
00007: 080F DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0812 FF 35 00000004              PUSH DWORD PTR _dblarg1+00000004
00008: 0818 FF 35 00000000              PUSH DWORD PTR _dblarg1
00008: 081E 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0821 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0828 29 D3                       SUB EBX, EDX
00008: 082A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 082D 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0830 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0837 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 083A FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0841 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0844 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 084B 29 D3                       SUB EBX, EDX
00008: 084D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0850 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0853 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 085A 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 085D FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0864 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 0866 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 086B 48                          DEC EAX
00008: 086C 50                          PUSH EAX
00008: 086D A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 0872 50                          PUSH EAX
00008: 0873 E8 00000000                 CALL SHORT _init_coll
00008: 0878 83 C4 30                    ADD ESP, 00000030

; 780: 	      nen1--;

00008: 087B FF 0D 00000000              DEC DWORD PTR _nen1

; 781: 	      icoll[i][j]=nen1;

00008: 0881 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 0887 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 088A 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 088D 8B 1D 00000000              MOV EBX, DWORD PTR _nen1
00008: 0893 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0896 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 782: 	      icoll[j][i]=nen1;

00008: 0899 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 089F 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 08A2 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 08A5 8B 1D 00000000              MOV EBX, DWORD PTR _nen1
00008: 08AB 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 08AE 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 783: 	      init_coll(nen1,-1,nen+1,sam[i].m,sam[j].m,dblarg1,sam[i].b+sam[j].b,-1);

00008: 08B1 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 08B3 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 08B6 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 08BD 29 D6                       SUB ESI, EDX
00008: 08BF 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 08C2 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 08C5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 08CC 29 D3                       SUB EBX, EDX
00008: 08CE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 08D1 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 08D4 DD 84 D8 00000090           FLD QWORD PTR 00000090[EAX][EBX*8]
00007: 08DB 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00007: 08DE DC 84 F0 00000090           FADD QWORD PTR 00000090[EAX][ESI*8]
00007: 08E5 50                          PUSH EAX
00007: 08E6 50                          PUSH EAX
00007: 08E7 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 08EA FF 35 00000004              PUSH DWORD PTR _dblarg1+00000004
00008: 08F0 FF 35 00000000              PUSH DWORD PTR _dblarg1
00008: 08F6 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 08F9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0900 29 D3                       SUB EBX, EDX
00008: 0902 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0905 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0908 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 090F 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0912 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0919 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 091C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0923 29 D3                       SUB EBX, EDX
00008: 0925 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0928 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 092B FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0932 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0935 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 093C A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 0941 40                          INC EAX
00008: 0942 50                          PUSH EAX
00008: 0943 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 0945 A1 00000000                 MOV EAX, DWORD PTR _nen1
00008: 094A 50                          PUSH EAX
00008: 094B E8 00000000                 CALL SHORT _init_coll
00008: 0950 83 C4 30                    ADD ESP, 00000030

; 785: 	    }

00008: 0953                     L0032:

; 786: 	}

00008: 0953                     L0027:
00008: 0953 FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 0956                     L0025:
00008: 0956 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0959 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 095C 0F 8E FFFFFC82              JLE L0026
00008: 0962 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0965                     L0023:
00008: 0965 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0968 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 096B 0F 8E FFFFFC67              JLE L0024

; 788:   for(i=1;i<=nat;i++)

00008: 0971 C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 0978 E9 00000084                 JMP L0033
00008: 097D                     L0034:

; 789:     for(j=1;j<=i;j++)

00008: 097D C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 0984 EB 70                       JMP L0035
00008: 0986                     L0036:

; 791: 	next=ecoll[i][j];

00008: 0986 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 098C 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 098F 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0992 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 0995 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0998 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 792:         coll[next].etot==0;//????is this an error

00008: 099B 31 F6                       XOR ESI, ESI
00008: 099D 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 09A0 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 09A3 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 09A9 DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 09AF DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00006: 09B3 F1DF                        FCOMIP ST, ST(1), L0037
00007: 09B5 DD D8                       FSTP ST
00008: 09B7 7A 03                       JP L0037
00008: 09B9 75 01                       JNE L0037
00008: 09BB 46                          INC ESI
00008: 09BC                     L0037:

; 793: 	next=icoll[i][j];

00008: 09BC 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 09C2 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 09C5 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 09C8 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 09CB 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 09CE 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 794: 	  if(next>-1)

00008: 09D1 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 09D5 7E 1C                       JLE L0038

; 795: 	    coll[next].etot=0;

00008: 09D7 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 09DA 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 09DD 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 09E3 C7 44 DA 14 00000000        MOV DWORD PTR 00000014[EDX][EBX*8], 00000000
00008: 09EB C7 44 DA 10 00000000        MOV DWORD PTR 00000010[EDX][EBX*8], 00000000
00008: 09F3                     L0038:

; 796:       }

00008: 09F3 FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 09F6                     L0035:
00008: 09F6 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 09F9 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 09FC 7E FFFFFF88                 JLE L0036
00008: 09FE FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0A01                     L0033:
00008: 0A01 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0A04 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 0A07 0F 8E FFFFFF70              JLE L0034

; 798:   for(k=1;k<=nrt;k++)

00008: 0A0D C7 45 FFFFFFBC 00000001     MOV DWORD PTR FFFFFFBC[EBP], 00000001
00008: 0A14 E9 000005C6                 JMP L0039
00008: 0A19                     L003A:

; 799:     if(react[k].bond>=0)

00008: 0A19 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0A1C 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0A1F 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0A25 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0A2B 0F 8C 000004C8              JL L003B

; 801: 	i=react[k].new1;

00008: 0A31 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0A34 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0A37 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0A3D 0F BF 54 DE 14              MOVSX EDX, WORD PTR 00000014[ESI][EBX*8]
00008: 0A42 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 802: 	j=react[k].new2;

00008: 0A45 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0A48 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0A4B 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0A51 0F BF 54 DE 16              MOVSX EDX, WORD PTR 00000016[ESI][EBX*8]
00008: 0A56 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX

; 803: 	num=icoll[i][j];

00008: 0A59 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 0A5F 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0A62 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0A65 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 0A68 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0A6B 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 804: 	if(num<0)react[k].bond=0;

00008: 0A6E 83 7D FFFFFFCC 00           CMP DWORD PTR FFFFFFCC[EBP], 00000000
00008: 0A72 7D 13                       JGE L003C
00008: 0A74 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0A77 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0A7A 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0A80 66 C7 44 DA 18 0000         MOV WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0A87                     L003C:

; 805: 	if(react[k].bond)

00008: 0A87 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0A8A 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0A8D 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0A93 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0A99 0F 84 000001AE              JE L003D

; 807: 	    if(react[k].dd>coll[num].dd)

00008: 0A9F 8B 75 FFFFFFCC              MOV ESI, DWORD PTR FFFFFFCC[EBP]
00008: 0AA2 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0AA5 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0AAB 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0AAE 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0AB1 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0AB7 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0ABB DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0ABF F1DF                        FCOMIP ST, ST(1), L003E
00007: 0AC1 DD D8                       FSTP ST
00008: 0AC3 7A 1A                       JP L003E
00008: 0AC5 73 18                       JAE L003E

; 808: 	      react[k].bond=0;

00008: 0AC7 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0ACA 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0ACD 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0AD3 66 C7 44 DA 18 0000         MOV WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0ADA E9 0000016E                 JMP L003F
00008: 0ADF                     L003E:

; 811: 		next=coll[num].next;

00008: 0ADF 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0AE2 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0AE5 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0AEB 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0AEF 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 812: 		while(next>-1)

00008: 0AF2 EB 50                       JMP L0040
00008: 0AF4                     L0041:

; 814: 		    if(react[k].dd>coll[next].dd)

00008: 0AF4 8B 75 FFFFFFD0              MOV ESI, DWORD PTR FFFFFFD0[EBP]
00008: 0AF7 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0AFA 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0B00 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0B03 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0B06 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0B0C DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0B10 DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0B14 F1DF                        FCOMIP ST, ST(1), L0042
00007: 0B16 DD D8                       FSTP ST
00008: 0B18 7A 17                       JP L0042
00008: 0B1A 73 15                       JAE L0042

; 817: 			react[k].in=next;

00008: 0B1C 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0B1F 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0B22 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0B28 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0B2B 89 44 DE 1C                 MOV DWORD PTR 0000001C[ESI][EBX*8], EAX

; 818: 			break;

00008: 0B2F EB 19                       JMP L0043
00008: 0B31                     L0042:

; 820: 		    next=coll[next].next;  

00008: 0B31 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0B34 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0B37 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0B3D 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0B41 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 821: 		  }

00008: 0B44                     L0040:
00008: 0B44 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 0B48 7F FFFFFFAA                 JG L0041
00008: 0B4A                     L0043:

; 822: 		if(next<0)react[k].bond=0;

00008: 0B4A 83 7D FFFFFFD0 00           CMP DWORD PTR FFFFFFD0[EBP], 00000000
00008: 0B4E 7D 18                       JGE L0044
00008: 0B50 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0B53 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0B56 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0B5C 66 C7 44 DA 18 0000         MOV WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0B63 E9 000000E5                 JMP L0045
00008: 0B68                     L0044:

; 826: 		    if(coll[num].eo==-dblarg1)

00008: 0B68 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0B6B 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0B6E 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0B74 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0B7A D9 E0                       FCHS 
00007: 0B7C DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00006: 0B80 F1DF                        FCOMIP ST, ST(1), L0046
00007: 0B82 DD D8                       FSTP ST
00008: 0B84 7A 28                       JP L0046
00008: 0B86 75 26                       JNE L0046

; 827: 		      coll[num].etot=-react[k].eo;

00008: 0B88 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0B8B 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0B8E 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0B94 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 0B97 D9 E0                       FCHS 
00007: 0B99 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00007: 0B9C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 0B9F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 0BA5 DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]
00008: 0BA9 E9 0000009F                 JMP L0047
00008: 0BAE                     L0046:

; 830: 			coll[num].react=-k-1; /* reverese reaction happens if .react is less then -1 */

00008: 0BAE 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0BB1 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0BB4 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0BBA 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 0BBD F7 DE                       NEG ESI
00008: 0BBF 4E                          DEC ESI
00008: 0BC0 89 74 DF 40                 MOV DWORD PTR 00000040[EDI][EBX*8], ESI

; 831: 			next=ecoll[react[k].old1][react[k].old2];

00008: 0BC4 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0BC7 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0BCA 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0BD0 0F BF 7C DE 12              MOVSX EDI, WORD PTR 00000012[ESI][EBX*8]
00008: 0BD5 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0BD8 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0BDB 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0BE1 0F BF 74 DE 10              MOVSX ESI, WORD PTR 00000010[ESI][EBX*8]
00008: 0BE6 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0BEC 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0BEF 8B 04 BB                    MOV EAX, DWORD PTR 00000000[EBX][EDI*4]
00008: 0BF2 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 832: 			while(next>-1)

00008: 0BF5 EB 50                       JMP L0048
00008: 0BF7                     L0049:

; 834: 			    if(coll[num].dd >=coll[next].dd)

00008: 0BF7 8B 75 FFFFFFD0              MOV ESI, DWORD PTR FFFFFFD0[EBP]
00008: 0BFA 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0BFD 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0C03 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0C06 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0C09 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0C0F DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 0C13 DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0C17 F1DF                        FCOMIP ST, ST(1), L004A
00007: 0C19 DD D8                       FSTP ST
00008: 0C1B 7A 17                       JP L004A
00008: 0C1D 77 15                       JA L004A

; 836: 				react[k].out=next;

00008: 0C1F 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0C22 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C25 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C2B 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0C2E 89 44 DE 20                 MOV DWORD PTR 00000020[ESI][EBX*8], EAX

; 837: 				break;

00008: 0C32 EB 19                       JMP L004B
00008: 0C34                     L004A:

; 839: 			    next=coll[next].next;

00008: 0C34 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0C37 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0C3A 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0C40 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0C44 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 840: 			  }

00008: 0C47                     L0048:
00008: 0C47 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 0C4B 7F FFFFFFAA                 JG L0049
00008: 0C4D                     L004B:

; 841: 		      }

00008: 0C4D                     L0047:

; 842: 		  }

00008: 0C4D                     L0045:

; 843: 	      }

00008: 0C4D                     L003F:

; 844: 	  }

00008: 0C4D                     L003D:

; 845: 	if((react[k].in>-1)||(!(react[k].bond)))

00008: 0C4D 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0C50 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C53 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0C59 83 7C DA 1C FFFFFFFF        CMP DWORD PTR 0000001C[EDX][EBX*8], FFFFFFFF
00008: 0C5E 7F 18                       JG L004C
00008: 0C60 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0C63 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C66 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0C6C 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0C72 0F 85 00000364              JNE L004D
00008: 0C78                     L004C:

; 847: 	    i=react[k].old1;

00008: 0C78 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0C7B 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C7E 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C84 0F BF 54 DE 10              MOVSX EDX, WORD PTR 00000010[ESI][EBX*8]
00008: 0C89 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 848: 	    j=react[k].old2;

00008: 0C8C 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0C8F 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0C92 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0C98 0F BF 54 DE 12              MOVSX EDX, WORD PTR 00000012[ESI][EBX*8]
00008: 0C9D 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX

; 849: 	    next=ecoll[i][j];

00008: 0CA0 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0CA6 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0CA9 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0CAC 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 0CAF 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0CB2 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 850: 	    while(next>-1)

00008: 0CB5 E9 00000230                 JMP L004E
00008: 0CBA                     L004F:

; 852: 		if(react[k].dd>=coll[next].dd)

00008: 0CBA 8B 75 FFFFFFD0              MOV ESI, DWORD PTR FFFFFFD0[EBP]
00008: 0CBD 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0CC0 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0CC6 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0CC9 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0CCC 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0CD2 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0CD6 DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0CDA F1DF                        FCOMIP ST, ST(1), L0050
00007: 0CDC DD D8                       FSTP ST
00008: 0CDE 0F 8A 000001F3              JP L0050
00008: 0CE4 0F 87 000001ED              JA L0050

; 854: 		    if(react[k].dd>coll[next].dd)

00008: 0CEA 8B 75 FFFFFFD0              MOV ESI, DWORD PTR FFFFFFD0[EBP]
00008: 0CED 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0CF0 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0CF6 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0CF9 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0CFC 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0D02 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0D06 DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0D0A F1DF                        FCOMIP ST, ST(1), L0051
00007: 0D0C DD D8                       FSTP ST
00008: 0D0E 0F 8A 0000014D              JP L0051
00008: 0D14 0F 83 00000147              JAE L0051

; 856: 			prev=coll[next].prev;

00008: 0D1A 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0D1D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0D20 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0D26 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0D2A 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 857: 			num=nen;

00008: 0D2D A1 00000000                 MOV EAX, DWORD PTR _nen
00008: 0D32 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 858: 			nen++;

00008: 0D35 FF 05 00000000              INC DWORD PTR _nen

; 859: 			init_coll(num,prev,next,sam[i].m,sam[j].m,(double)0,sqrt(react[k].dd),0);

00008: 0D3B 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0D3E 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0D41 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0D47 FF 74 DA 0C                 PUSH DWORD PTR 0000000C[EDX][EBX*8]
00008: 0D4B FF 74 DA 08                 PUSH DWORD PTR 00000008[EDX][EBX*8]
00008: 0D4F E8 00000000                 CALL SHORT _sqrt
00007: 0D54 59                          POP ECX
00007: 0D55 59                          POP ECX
00007: 0D56 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 0D59 6A 00                       PUSH 00000000
00008: 0D5B FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0D5E FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 0D61 FF 35 00000004              PUSH DWORD PTR .data+00000230+00000004
00008: 0D67 FF 35 00000000              PUSH DWORD PTR .data+00000230
00008: 0D6D 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 0D70 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0D77 29 D3                       SUB EBX, EDX
00008: 0D79 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0D7C 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0D7F FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0D86 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0D89 FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0D90 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0D93 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0D9A 29 D3                       SUB EBX, EDX
00008: 0D9C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0D9F 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0DA2 FF B4 D8 0000008C           PUSH DWORD PTR 0000008C[EAX][EBX*8]
00008: 0DA9 8B 45 28                    MOV EAX, DWORD PTR 00000028[EBP]
00008: 0DAC FF B4 D8 00000088           PUSH DWORD PTR 00000088[EAX][EBX*8]
00008: 0DB3 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 0DB6 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0DB9 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0DBC E8 00000000                 CALL SHORT _init_coll
00008: 0DC1 83 C4 30                    ADD ESP, 00000030

; 860: 			if(!react[k].bond)react[k].in=next;

00008: 0DC4 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0DC7 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0DCA 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0DD0 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0DD6 75 13                       JNE L0052
00008: 0DD8 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0DDB 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0DDE 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0DE4 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0DE7 89 44 DE 1C                 MOV DWORD PTR 0000001C[ESI][EBX*8], EAX
00008: 0DEB                     L0052:

; 861: 			coll[next].prev=num;

00008: 0DEB 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0DEE 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0DF1 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0DF7 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0DFA 89 44 DE 3C                 MOV DWORD PTR 0000003C[ESI][EBX*8], EAX

; 862: 			if(prev==-1)

00008: 0DFE 83 7D FFFFFFD4 FFFFFFFF     CMP DWORD PTR FFFFFFD4[EBP], FFFFFFFF
00008: 0E02 75 48                       JNE L0053

; 864: 			    ecoll[i][j]=num;

00008: 0E04 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0E0A 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0E0D 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0E10 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0E13 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0E16 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 865: 			    ecoll[j][i]=num;

00008: 0E19 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0E1F 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0E22 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0E25 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0E28 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0E2B 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 866: 			    coll[num].etot=0;

00008: 0E2E 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0E31 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0E34 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0E3A C7 44 DA 14 00000000        MOV DWORD PTR 00000014[EDX][EBX*8], 00000000
00008: 0E42 C7 44 DA 10 00000000        MOV DWORD PTR 00000010[EDX][EBX*8], 00000000

; 867: 			  }

00008: 0E4A EB 73                       JMP L0054
00008: 0E4C                     L0053:

; 870: 			    coll[prev].next=num;

00008: 0E4C 8B 5D FFFFFFD4              MOV EBX, DWORD PTR FFFFFFD4[EBP]
00008: 0E4F 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0E52 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0E58 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0E5B 89 44 DE 38                 MOV DWORD PTR 00000038[ESI][EBX*8], EAX

; 872: 		      }

00008: 0E5F EB 5E                       JMP L0054
00008: 0E61                     L0051:

; 875: 			num=next;

00008: 0E61 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0E64 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 876: 			next=coll[next].next;

00008: 0E67 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0E6A 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0E6D 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0E73 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0E77 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 877: 			if(next<=-1){printf("error\n");return 0;}			

00008: 0E7A 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 0E7E 7F 18                       JG L0055
00008: 0E80 68 00000000                 PUSH OFFSET @848
00008: 0E85 E8 00000000                 CALL SHORT _printf
00008: 0E8A 59                          POP ECX
00008: 0E8B B8 00000000                 MOV EAX, 00000000
00000: 0E90                             epilog 
00000: 0E90 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0E93 5F                          POP EDI
00000: 0E94 5E                          POP ESI
00000: 0E95 5B                          POP EBX
00000: 0E96 5D                          POP EBP
00000: 0E97 C3                          RETN 
00008: 0E98                     L0055:

; 878: 			if(!react[k].bond)react[k].in=next;

00008: 0E98 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0E9B 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0E9E 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0EA4 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0EAA 75 13                       JNE L0056
00008: 0EAC 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0EAF 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0EB2 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0EB8 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0EBB 89 44 DE 1C                 MOV DWORD PTR 0000001C[ESI][EBX*8], EAX
00008: 0EBF                     L0056:

; 880: 		    }

00008: 0EBF                     L0054:

; 881: 		    coll[num].react=k;

00008: 0EBF 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0EC2 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0EC5 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0ECB 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0ECE 89 44 DE 40                 MOV DWORD PTR 00000040[ESI][EBX*8], EAX

; 882: 		    break;

00008: 0ED2 E9 00000105                 JMP L004D
00008: 0ED7                     L0050:

; 884: 		next=coll[next].next;

00008: 0ED7 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0EDA 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0EDD 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0EE3 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0EE7 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 885: 	      }

00008: 0EEA                     L004E:
00008: 0EEA 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 0EEE 0F 8F FFFFFDC6              JG L004F

; 887:       }

00008: 0EF4 E9 000000E3                 JMP L004D
00008: 0EF9                     L003B:

; 891: 	react[k].bond=1;

00008: 0EF9 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0EFC 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0EFF 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0F05 66 C7 44 DA 18 0001         MOV WORD PTR 00000018[EDX][EBX*8], 0001

; 892: 	num=icoll[react[k].new1][react[k].new2];

00008: 0F0C 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0F0F 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0F12 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0F18 0F BF 7C DE 16              MOVSX EDI, WORD PTR 00000016[ESI][EBX*8]
00008: 0F1D 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0F20 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0F23 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0F29 0F BF 74 DE 14              MOVSX ESI, WORD PTR 00000014[ESI][EBX*8]
00008: 0F2E 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 0F34 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0F37 8B 04 BB                    MOV EAX, DWORD PTR 00000000[EBX][EDI*4]
00008: 0F3A 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 893: 	coll[num].react=-k-1; /* reverese reaction happens if .react is less then -1 */

00008: 0F3D 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0F40 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0F43 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0F49 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 0F4C F7 DE                       NEG ESI
00008: 0F4E 4E                          DEC ESI
00008: 0F4F 89 74 DF 40                 MOV DWORD PTR 00000040[EDI][EBX*8], ESI

; 894: 	next=ecoll[react[k].old1][react[k].old2];

00008: 0F53 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0F56 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0F59 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0F5F 0F BF 7C DE 12              MOVSX EDI, WORD PTR 00000012[ESI][EBX*8]
00008: 0F64 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0F67 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0F6A 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0F70 0F BF 74 DE 10              MOVSX ESI, WORD PTR 00000010[ESI][EBX*8]
00008: 0F75 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0F7B 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0F7E 8B 04 BB                    MOV EAX, DWORD PTR 00000000[EBX][EDI*4]
00008: 0F81 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 895: 	while(next>-1)

00008: 0F84 EB 50                       JMP L0057
00008: 0F86                     L0058:

; 897: 	    if(coll[num].dd >=coll[next].dd)

00008: 0F86 8B 75 FFFFFFD0              MOV ESI, DWORD PTR FFFFFFD0[EBP]
00008: 0F89 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0F8C 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0F92 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 0F95 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0F98 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0F9E DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 0FA2 DD 44 F7 18                 FLD QWORD PTR 00000018[EDI][ESI*8]
00006: 0FA6 F1DF                        FCOMIP ST, ST(1), L0059
00007: 0FA8 DD D8                       FSTP ST
00008: 0FAA 7A 17                       JP L0059
00008: 0FAC 77 15                       JA L0059

; 899: 		react[k].out=next;

00008: 0FAE 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 0FB1 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0FB4 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0FBA 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0FBD 89 44 DE 20                 MOV DWORD PTR 00000020[ESI][EBX*8], EAX

; 900: 		break;

00008: 0FC1 EB 19                       JMP L005A
00008: 0FC3                     L0059:

; 902: 	    next=coll[next].next;

00008: 0FC3 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0FC6 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0FC9 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0FCF 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0FD3 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 903: 	  }

00008: 0FD6                     L0057:
00008: 0FD6 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 0FDA 7F FFFFFFAA                 JG L0058
00008: 0FDC                     L005A:

; 904:       }

00008: 0FDC                     L004D:
00008: 0FDC FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0FDF                     L0039:
00008: 0FDF 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0FE2 3B 05 00000000              CMP EAX, DWORD PTR _nrt
00008: 0FE8 0F 8E FFFFFA2B              JLE L003A

; 909:   for(i=1;i<=nat;i++)

00008: 0FEE C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 0FF5 E9 00000083                 JMP L005B
00008: 0FFA                     L005C:

; 910:     for(j=1;j<=i;j++)

00008: 0FFA C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 1001 EB 6F                       JMP L005D
00008: 1003                     L005E:

; 912: 	num=ecoll[i][j];

00008: 1003 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 1009 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 100C 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 100F 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 1012 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 1015 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 914: 	while(num>-1)

00008: 1018 EB 4F                       JMP L005F
00008: 101A                     L0060:

; 916: 	    next=coll[num].next;

00008: 101A 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 101D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 1020 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 1026 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 102A 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 917: 	    if(next>-1)

00008: 102D 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 1031 7E 30                       JLE L0061

; 919: 		  coll[next].etot=coll[num].etot+coll[num].eo;

00008: 1033 8B 75 FFFFFFCC              MOV ESI, DWORD PTR FFFFFFCC[EBP]
00008: 1036 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 1039 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 103F 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 1042 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 1045 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 104B DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 104F DC 44 F7 08                 FADD QWORD PTR 00000008[EDI][ESI*8]
00007: 1053 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00007: 1056 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 1059 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 105F DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]

; 921: 	      }

00008: 1063                     L0061:

; 922: 		num=next;

00008: 1063 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 1066 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 923: 	  }

00008: 1069                     L005F:
00008: 1069 83 7D FFFFFFCC FFFFFFFF     CMP DWORD PTR FFFFFFCC[EBP], FFFFFFFF
00008: 106D 7F FFFFFFAB                 JG L0060

; 924:       }

00008: 106F FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 1072                     L005D:
00008: 1072 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 1075 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 1078 7E FFFFFF89                 JLE L005E
00008: 107A FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 107D                     L005B:
00008: 107D 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 1080 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 1083 0F 8E FFFFFF71              JLE L005C

; 926:   for(i=1;i<=nat;i++)

00008: 1089 C7 45 FFFFFFB4 00000001     MOV DWORD PTR FFFFFFB4[EBP], 00000001
00008: 1090 E9 000000E3                 JMP L0062
00008: 1095                     L0063:

; 927:     for(j=1;j<=i;j++)

00008: 1095 C7 45 FFFFFFB8 00000001     MOV DWORD PTR FFFFFFB8[EBP], 00000001
00008: 109C E9 000000C8                 JMP L0064
00008: 10A1                     L0065:

; 929: 	num=icoll[i][j];

00008: 10A1 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 10A7 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 10AA 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 10AD 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 10B0 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 10B3 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 930: 	while(num>-1)

00008: 10B6 EB 71                       JMP L0066
00008: 10B8                     L0067:

; 932: 	    next=coll[num].next;

00008: 10B8 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 10BB 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 10BE 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 10C4 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 10C8 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 933: 	    if(next>-1)

00008: 10CB 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 10CF 7E 52                       JLE L0068

; 935: 		en=coll[num].eo;

00008: 10D1 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 10D4 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 10D7 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 10DD DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 10E1 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 936: 		if(en==-dblarg1)en=0;

00008: 10E4 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 10EA D9 E0                       FCHS 
00007: 10EC DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00006: 10EF F1DF                        FCOMIP ST, ST(1), L0069
00007: 10F1 DD D8                       FSTP ST
00008: 10F3 7A 0B                       JP L0069
00008: 10F5 75 09                       JNE L0069
00008: 10F7 DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 10FD DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 1100                     L0069:

; 937: 		coll[next].etot=coll[num].etot+en;

00008: 1100 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 1103 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 1106 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 110C DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 110F DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 1113 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00007: 1116 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 1119 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 111F DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]

; 938: 	      }

00008: 1123                     L0068:

; 939: 	    num=next;

00008: 1123 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 1126 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 940: 	  }

00008: 1129                     L0066:
00008: 1129 83 7D FFFFFFCC FFFFFFFF     CMP DWORD PTR FFFFFFCC[EBP], FFFFFFFF
00008: 112D 7F FFFFFF89                 JG L0067

; 941: 	num=icoll[i][j];

00008: 112F 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 1135 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 1138 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 113B 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 113E 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 1141 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 942: 	if(num>-1)coll[num].etot=0;

00008: 1144 83 7D FFFFFFCC FFFFFFFF     CMP DWORD PTR FFFFFFCC[EBP], FFFFFFFF
00008: 1148 7E 1C                       JLE L006A
00008: 114A 8B 5D FFFFFFCC              MOV EBX, DWORD PTR FFFFFFCC[EBP]
00008: 114D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 1150 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 1156 C7 44 DA 14 00000000        MOV DWORD PTR 00000014[EDX][EBX*8], 00000000
00008: 115E C7 44 DA 10 00000000        MOV DWORD PTR 00000010[EDX][EBX*8], 00000000
00008: 1166                     L006A:

; 943:       }

00008: 1166 FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 1169                     L0064:
00008: 1169 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 116C 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 116F 0F 8E FFFFFF2C              JLE L0065
00008: 1175 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 1178                     L0062:
00008: 1178 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 117B 3B 45 2C                    CMP EAX, DWORD PTR 0000002C[EBP]
00008: 117E 0F 8E FFFFFF11              JLE L0063

; 945: }

00000: 1184                     L0000:
00000: 1184                             epilog 
00000: 1184 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1187 5F                          POP EDI
00000: 1188 5E                          POP ESI
00000: 1189 5B                          POP EBX
00000: 118A 5D                          POP EBP
00000: 118B C3                          RETN 

Function: _make_key_system

; 948: {  

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 81 EC 000000E8              SUB ESP, 000000E8
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0014 B9 0000003A                 MOV ECX, 0000003A
00000: 0019 F3 AB                       REP STOSD 
00000: 001B                             prolog 

; 949:   unsigned char * datfile, *nextline= buf;

00008: 001B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 001E 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 957:   int current_key=first_key;

00008: 0024 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0027 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 959:   int numwell=0;

00008: 002D C7 85 FFFFFF3800000000      MOV DWORD PTR FFFFFF38[EBP], 00000000

; 960:   int numbondwell=0;

00008: 0037 C7 85 FFFFFF3C00000000      MOV DWORD PTR FFFFFF3C[EBP], 00000000

; 961:   int numunstable=0;

00008: 0041 C7 85 FFFFFF4000000000      MOV DWORD PTR FFFFFF40[EBP], 00000000

; 963:   int numbond=0;//8/27 ACTUAL NUMBER OF BONDS AB

00008: 004B C7 85 FFFFFF4800000000      MOV DWORD PTR FFFFFF48[EBP], 00000000

; 965:   int lbt=0;/*length of bond table*/

00008: 0055 C7 85 FFFFFF5000000000      MOV DWORD PTR FFFFFF50[EBP], 00000000

; 966:   int lct=0;/*length of collision table*/

00008: 005F C7 85 FFFFFF5400000000      MOV DWORD PTR FFFFFF54[EBP], 00000000

; 967:   double *storage, *top, *dummy, *bonds=0;

00008: 0069 C7 85 FFFFFF6400000000      MOV DWORD PTR FFFFFF64[EBP], 00000000

; 970:   double coord_shift[3]={0.0,0.0,0.0};

00008: 0073 8D 7D FFFFFFDC              LEA EDI, DWORD PTR FFFFFFDC[EBP]
00008: 0076 BE 00000000                 MOV ESI, OFFSET .bss+00000000
00008: 007B A5                          MOVSD 
00008: 007C A5                          MOVSD 
00008: 007D A5                          MOVSD 
00008: 007E A5                          MOVSD 
00008: 007F A5                          MOVSD 
00008: 0080 A5                          MOVSD 
00008: 0081 8D 55 FFFFFFDC              LEA EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0084 89 D1                       MOV ECX, EDX

; 975:   nrt=0;

00008: 0086 C7 05 00000000 00000000     MOV DWORD PTR _nrt, 00000000

; 976:   storage=(double *)malloc(file_length*sizeof(double));

00008: 0090 8B 55 10                    MOV EDX, DWORD PTR 00000010[EBP]
00008: 0093 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 009A 52                          PUSH EDX
00008: 009B E8 00000000                 CALL SHORT _malloc
00008: 00A0 59                          POP ECX
00008: 00A1 89 85 FFFFFF58              MOV DWORD PTR FFFFFF58[EBP], EAX

; 977:   if(!storage){StopAlert (MEMORY_ALRT);return line_number;}

00008: 00A7 83 BD FFFFFF5800            CMP DWORD PTR FFFFFF58[EBP], 00000000
00008: 00AE 75 15                       JNE L0001
00008: 00B0 6A 02                       PUSH 00000002
00008: 00B2 E8 00000000                 CALL SHORT _StopAlert
00008: 00B7 59                          POP ECX
00008: 00B8 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 00BD                             epilog 
00000: 00BD 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00C0 5F                          POP EDI
00000: 00C1 5E                          POP ESI
00000: 00C2 5B                          POP EBX
00000: 00C3 5D                          POP EBP
00000: 00C4 C3                          RETN 
00008: 00C5                     L0001:

; 978:   dummy=storage;

00008: 00C5 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 00CB 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 979:   while(current_key)

00008: 00D1 E9 00002AB7                 JMP L0002
00008: 00D6                     L0003:

; 981:       switch (current_key){

00008: 00D6 8B 95 FFFFFF30              MOV EDX, DWORD PTR FFFFFF30[EBP]
00008: 00DC 8B 95 FFFFFF30              MOV EDX, DWORD PTR FFFFFF30[EBP]
00008: 00E2 4A                          DEC EDX
00008: 00E3 83 FA 0B                    CMP EDX, 0000000B
00008: 00E6 0F 87 00002A78              JA L0004
00008: 00EC FF 24 95 00000000           JMP DWORD PTR @1300[EDX*4], 0325D268
00008: 00F3                     L0005:

; 984: 	    printf("%s\n",keywords[current_key]);

00008: 00F3 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 00F9 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 00FF 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0102 50                          PUSH EAX
00008: 0103 68 00000000                 PUSH OFFSET @1301
00008: 0108 E8 00000000                 CALL SHORT _printf
00008: 010D 59                          POP ECX
00008: 010E 59                          POP ECX

; 985: 	    datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 010F 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 0115 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 011B FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0121 E8 00000000                 CALL SHORT _next_line
00008: 0126 59                          POP ECX
00008: 0127 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 012D 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 0134 75 0D                       JNE L0006
00008: 0136 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 013B                             epilog 
00000: 013B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 013E 5F                          POP EDI
00000: 013F 5E                          POP ESI
00000: 0140 5B                          POP EBX
00000: 0141 5D                          POP EBP
00000: 0142 C3                          RETN 
00008: 0143                     L0006:

; 987: 	    ndim=0;

00008: 0143 C7 85 FFFFFF2C00000000      MOV DWORD PTR FFFFFF2C[EBP], 00000000

; 989: 		while(is_word(datfile))

00008: 014D EB 48                       JMP L0007
00008: 014F                     L0008:

; 991: 		    sscanf(datfile,"%lf",storage+ndim);

00008: 014F 8B 95 FFFFFF2C              MOV EDX, DWORD PTR FFFFFF2C[EBP]
00008: 0155 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 015C 03 95 FFFFFF58              ADD EDX, DWORD PTR FFFFFF58[EBP]
00008: 0162 52                          PUSH EDX
00008: 0163 68 00000000                 PUSH OFFSET @1302
00008: 0168 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 016E E8 00000000                 CALL SHORT _sscanf
00008: 0173 83 C4 0C                    ADD ESP, 0000000C

; 992:                     ndim++;

00008: 0176 FF 85 FFFFFF2C              INC DWORD PTR FFFFFF2C[EBP]

; 993: 		    if(!(datfile=next_word(datfile)))break;

00008: 017C FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0182 E8 00000000                 CALL SHORT _next_word
00008: 0187 59                          POP ECX
00008: 0188 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 018E 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 0195 74 11                       JE L0009

; 994: 		  }

00008: 0197                     L0007:
00008: 0197 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 019D E8 00000000                 CALL SHORT _is_word
00008: 01A2 59                          POP ECX
00008: 01A3 83 F8 00                    CMP EAX, 00000000
00008: 01A6 75 FFFFFFA7                 JNE L0008
00008: 01A8                     L0009:

; 995: 	    if((ndim<2)||(ndim>3))return line_number;

00008: 01A8 83 BD FFFFFF2C02            CMP DWORD PTR FFFFFF2C[EBP], 00000002
00008: 01AF 7C 09                       JL L000A
00008: 01B1 83 BD FFFFFF2C03            CMP DWORD PTR FFFFFF2C[EBP], 00000003
00008: 01B8 7E 0D                       JLE L000B
00008: 01BA                     L000A:
00008: 01BA A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 01BF                             epilog 
00000: 01BF 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01C2 5F                          POP EDI
00000: 01C3 5E                          POP ESI
00000: 01C4 5B                          POP EBX
00000: 01C5 5D                          POP EBP
00000: 01C6 C3                          RETN 
00008: 01C7                     L000B:

; 996: 	    for(i=0;i<ndim;i++)

00008: 01C7 C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 01D1 EB 6A                       JMP L000C
00008: 01D3                     L000D:

; 998: 		if(dummy[i]<=0)return line_number;

00008: 01D3 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 01D9 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 01DF DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 01E2 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 01E8 F1DF                        FCOMIP ST, ST(1), L000E
00007: 01EA DD D8                       FSTP ST
00008: 01EC 7A 0F                       JP L000E
00008: 01EE 72 0D                       JB L000E
00008: 01F0 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 01F5                             epilog 
00000: 01F5 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01F8 5F                          POP EDI
00000: 01F9 5E                          POP ESI
00000: 01FA 5B                          POP EBX
00000: 01FB 5D                          POP EBP
00000: 01FC C3                          RETN 
00008: 01FD                     L000E:

; 999:                 L[i]=dummy[i];

00008: 01FD 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 0203 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 0209 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 020C 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00007: 0212 DD 5C C5 FFFFFFC4           FSTP QWORD PTR FFFFFFC4[EBP][EAX*8]

; 1000: 		printf("%lf\n",L[i]);

00008: 0216 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 021C FF 74 C5 FFFFFFC8           PUSH DWORD PTR FFFFFFC8[EBP][EAX*8]
00008: 0220 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0226 FF 74 C5 FFFFFFC4           PUSH DWORD PTR FFFFFFC4[EBP][EAX*8]
00008: 022A 68 00000000                 PUSH OFFSET @1303
00008: 022F E8 00000000                 CALL SHORT _printf
00008: 0234 83 C4 0C                    ADD ESP, 0000000C

; 1001: 	      }

00008: 0237 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 023D                     L000C:
00008: 023D 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0243 3B 85 FFFFFF2C              CMP EAX, DWORD PTR FFFFFF2C[EBP]
00008: 0249 7C FFFFFF88                 JL L000D

; 1002: 	    datfile=nextline;

00008: 024B 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 0251 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1003: 	    if(!(nextline=next_line(datfile)))return line_number;

00008: 0257 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 025D E8 00000000                 CALL SHORT _next_line
00008: 0262 59                          POP ECX
00008: 0263 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 0269 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 0270 75 0D                       JNE L000F
00008: 0272 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0277                             epilog 
00000: 0277 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 027A 5F                          POP EDI
00000: 027B 5E                          POP ESI
00000: 027C 5B                          POP EBX
00000: 027D 5D                          POP EBP
00000: 027E C3                          RETN 
00008: 027F                     L000F:

; 1004: 	    next_key=iskeyword(datfile);

00008: 027F FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0285 E8 00000000                 CALL SHORT _iskeyword
00008: 028A 59                          POP ECX
00008: 028B 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1005: 	    if(next_key<=0)return line_number;

00008: 0291 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0298 7F 0D                       JG L0010
00008: 029A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 029F                             epilog 
00000: 029F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02A2 5F                          POP EDI
00000: 02A3 5E                          POP ESI
00000: 02A4 5B                          POP EBX
00000: 02A5 5D                          POP EBP
00000: 02A6 C3                          RETN 
00008: 02A7                     L0010:

; 1006: 	    else current_key=next_key;

00008: 02A7 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 02AD 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1007:             break;

00008: 02B3 E9 000028D5                 JMP L0011
00008: 02B8                     L0012:

; 1011: 	    printf("%s\n",keywords[current_key]);

00008: 02B8 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 02BE 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 02C4 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 02C7 50                          PUSH EAX
00008: 02C8 68 00000000                 PUSH OFFSET @1301
00008: 02CD E8 00000000                 CALL SHORT _printf
00008: 02D2 59                          POP ECX
00008: 02D3 59                          POP ECX

; 1012: 	    datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 02D4 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 02DA 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 02E0 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 02E6 E8 00000000                 CALL SHORT _next_line
00008: 02EB 59                          POP ECX
00008: 02EC 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 02F2 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 02F9 75 0D                       JNE L0013
00008: 02FB A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0300                             epilog 
00000: 0300 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0303 5F                          POP EDI
00000: 0304 5E                          POP ESI
00000: 0305 5B                          POP EBX
00000: 0306 5D                          POP EBP
00000: 0307 C3                          RETN 
00008: 0308                     L0013:

; 1014: 	    sscanf(datfile,"%lf",dummy);

00008: 0308 FF B5 FFFFFF60              PUSH DWORD PTR FFFFFF60[EBP]
00008: 030E 68 00000000                 PUSH OFFSET @1302
00008: 0313 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0319 E8 00000000                 CALL SHORT _sscanf
00008: 031E 83 C4 0C                    ADD ESP, 0000000C

; 1015:             n1=dummy[0];

00008: 0321 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 0327 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0329 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 032C 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 032F 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 0333 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 0336 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 0339 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 033C D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 033F 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0342 89 15 00000000              MOV DWORD PTR _n1, EDX

; 1016:             if((n1<1)||(n1!=dummy[0]))return line_number;

00008: 0348 83 3D 00000000 01           CMP DWORD PTR _n1, 00000001
00008: 034F 7C 16                       JL L0014
00008: 0351 DB 05 00000000              FILD DWORD PTR _n1
00007: 0357 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 035D DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 035F F1DF                        FCOMIP ST, ST(1), L0015
00007: 0361 DD D8                       FSTP ST
00008: 0363 7A 02                       JP L00D0
00008: 0365 74 0D                       JE L0015
00008: 0367                     L00D0:
00008: 0367                     L0014:
00008: 0367 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 036C                             epilog 
00000: 036C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 036F 5F                          POP EDI
00000: 0370 5E                          POP ESI
00000: 0371 5B                          POP EBX
00000: 0372 5D                          POP EBP
00000: 0373 C3                          RETN 
00008: 0374                     L0015:

; 1017: 	    datfile=nextline;

00008: 0374 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 037A 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1018: 	    if(!(nextline=next_line(datfile)))return line_number;

00008: 0380 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0386 E8 00000000                 CALL SHORT _next_line
00008: 038B 59                          POP ECX
00008: 038C 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 0392 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 0399 75 0D                       JNE L0016
00008: 039B A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 03A0                             epilog 
00000: 03A0 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03A3 5F                          POP EDI
00000: 03A4 5E                          POP ESI
00000: 03A5 5B                          POP EBX
00000: 03A6 5D                          POP EBP
00000: 03A7 C3                          RETN 
00008: 03A8                     L0016:

; 1019: 	    next_key=iskeyword(datfile);

00008: 03A8 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 03AE E8 00000000                 CALL SHORT _iskeyword
00008: 03B3 59                          POP ECX
00008: 03B4 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1020: 	    if(next_key<=0)return line_number;

00008: 03BA 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 03C1 7F 0D                       JG L0017
00008: 03C3 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 03C8                             epilog 
00000: 03C8 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03CB 5F                          POP EDI
00000: 03CC 5E                          POP ESI
00000: 03CD 5B                          POP EBX
00000: 03CE 5D                          POP EBP
00000: 03CF C3                          RETN 
00008: 03D0                     L0017:

; 1021: 	    else current_key=next_key;

00008: 03D0 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 03D6 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1022: 	    if(!(a=(atom *)malloc((n1+1)*sizeof(atom))))

00008: 03DC 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 03E2 42                          INC EDX
00008: 03E3 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 03E9 52                          PUSH EDX
00008: 03EA E8 00000000                 CALL SHORT _malloc
00008: 03EF 59                          POP ECX
00008: 03F0 A3 00000000                 MOV DWORD PTR _a, EAX
00008: 03F5 83 3D 00000000 00           CMP DWORD PTR _a, 00000000
00008: 03FC 75 15                       JNE L0018

; 1023: 	      {StopAlert (MEMORY_ALRT);return line_number;}

00008: 03FE 6A 02                       PUSH 00000002
00008: 0400 E8 00000000                 CALL SHORT _StopAlert
00008: 0405 59                          POP ECX
00008: 0406 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 040B                             epilog 
00000: 040B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 040E 5F                          POP EDI
00000: 040F 5E                          POP ESI
00000: 0410 5B                          POP EBX
00000: 0411 5D                          POP EBP
00000: 0412 C3                          RETN 
00008: 0413                     L0018:

; 1024: 	      for(i=0;i<n1;i++)

00008: 0413 C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 041D EB 28                       JMP L0019
00008: 041F                     L001A:

; 1025: 		a[i].c=0;

00008: 041F 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 0425 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 042C 29 D3                       SUB EBX, EDX
00008: 042E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0431 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0437 66 C7 84 DA 000000A40000    MOV WORD PTR 000000A4[EDX][EBX*8], 0000
00008: 0441 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0447                     L0019:
00008: 0447 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 044D 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 0453 7C FFFFFFCA                 JL L001A

; 1026: 	    printf("NUM_ATOMS=%d\n",n1);

00008: 0455 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 045A 50                          PUSH EAX
00008: 045B 68 00000000                 PUSH OFFSET @1304
00008: 0460 E8 00000000                 CALL SHORT _printf
00008: 0465 59                          POP ECX
00008: 0466 59                          POP ECX

; 1027: 	    set_write_param(0,n1,0); /* setting parameters for text writing */

00008: 0467 6A 00                       PUSH 00000000
00008: 0469 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 046E 50                          PUSH EAX
00008: 046F 6A 00                       PUSH 00000000
00008: 0471 E8 00000000                 CALL SHORT _set_write_param
00008: 0476 83 C4 0C                    ADD ESP, 0000000C

; 1028: 	    n=n1-1;

00008: 0479 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 047F 4A                          DEC EDX
00008: 0480 89 15 00000000              MOV DWORD PTR _n, EDX

; 1029:             break;

00008: 0486 E9 00002702                 JMP L0011
00008: 048B                     L001B:

; 1033: 	    printf("%s\n",keywords[current_key]);

00008: 048B 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 0491 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 0497 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 049A 50                          PUSH EAX
00008: 049B 68 00000000                 PUSH OFFSET @1301
00008: 04A0 E8 00000000                 CALL SHORT _printf
00008: 04A5 59                          POP ECX
00008: 04A6 59                          POP ECX

; 1034:             nat=0;

00008: 04A7 C7 05 00000000 00000000     MOV DWORD PTR _nat, 00000000

; 1035: 	    maxrb=0;

00008: 04B1 DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 04B7 DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]

; 1036:             do

00008: 04BA                     L001C:

; 1038: 		numword=0;

00008: 04BA C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1039: 		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 04C4 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 04CA 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 04D0 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 04D6 E8 00000000                 CALL SHORT _next_line
00008: 04DB 59                          POP ECX
00008: 04DC 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 04E2 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 04E9 75 0D                       JNE L001D
00008: 04EB A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 04F0                             epilog 
00000: 04F0 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 04F3 5F                          POP EDI
00000: 04F4 5E                          POP ESI
00000: 04F5 5B                          POP EBX
00000: 04F6 5D                          POP EBP
00000: 04F7 C3                          RETN 
00008: 04F8                     L001D:

; 1040: 		next_key=iskeyword(datfile);

00008: 04F8 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 04FE E8 00000000                 CALL SHORT _iskeyword
00008: 0503 59                          POP ECX
00008: 0504 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1041: 		if(next_key<0)return line_number;

00008: 050A 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0511 7D 0D                       JGE L001E
00008: 0513 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0518                             epilog 
00000: 0518 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 051B 5F                          POP EDI
00000: 051C 5E                          POP ESI
00000: 051D 5B                          POP EBX
00000: 051E 5D                          POP EBP
00000: 051F C3                          RETN 
00008: 0520                     L001E:

; 1042:                 if((next_key>0)&&(!nat))return line_number;

00008: 0520 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0527 7E 16                       JLE L001F
00008: 0529 83 3D 00000000 00           CMP DWORD PTR _nat, 00000000
00008: 0530 75 0D                       JNE L001F
00008: 0532 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0537                             epilog 
00000: 0537 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 053A 5F                          POP EDI
00000: 053B 5E                          POP ESI
00000: 053C 5B                          POP EBX
00000: 053D 5D                          POP EBP
00000: 053E C3                          RETN 
00008: 053F                     L001F:

; 1043:                 if(!next_key)

00008: 053F 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0546 0F 85 00000152              JNE L0020

; 1046: 		    numword=0;

00008: 054C C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1047: 		    while(is_word(datfile))

00008: 0556 EB 57                       JMP L0021
00008: 0558                     L0022:

; 1049: 			sscanf(datfile,"%lf",dummy+nat+numword);

00008: 0558 8B 9D FFFFFF44              MOV EBX, DWORD PTR FFFFFF44[EBP]
00008: 055E 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 0565 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 056B 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 0572 03 95 FFFFFF60              ADD EDX, DWORD PTR FFFFFF60[EBP]
00008: 0578 01 D3                       ADD EBX, EDX
00008: 057A 53                          PUSH EBX
00008: 057B 68 00000000                 PUSH OFFSET @1302
00008: 0580 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0586 E8 00000000                 CALL SHORT _sscanf
00008: 058B 83 C4 0C                    ADD ESP, 0000000C

; 1050: 			numword++;

00008: 058E FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1051: 			if(!(datfile=next_word(datfile)))break;

00008: 0594 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 059A E8 00000000                 CALL SHORT _next_word
00008: 059F 59                          POP ECX
00008: 05A0 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 05A6 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 05AD 74 11                       JE L0023

; 1052: 		      }

00008: 05AF                     L0021:
00008: 05AF FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 05B5 E8 00000000                 CALL SHORT _is_word
00008: 05BA 59                          POP ECX
00008: 05BB 83 F8 00                    CMP EAX, 00000000
00008: 05BE 75 FFFFFF98                 JNE L0022
00008: 05C0                     L0023:

; 1053: 		    if((numword<3)||(numword>4))return line_number;

00008: 05C0 83 BD FFFFFF4403            CMP DWORD PTR FFFFFF44[EBP], 00000003
00008: 05C7 7C 09                       JL L0024
00008: 05C9 83 BD FFFFFF4404            CMP DWORD PTR FFFFFF44[EBP], 00000004
00008: 05D0 7E 0D                       JLE L0025
00008: 05D2                     L0024:
00008: 05D2 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 05D7                             epilog 
00000: 05D7 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 05DA 5F                          POP EDI
00000: 05DB 5E                          POP ESI
00000: 05DC 5B                          POP EBX
00000: 05DD 5D                          POP EBP
00000: 05DE C3                          RETN 
00008: 05DF                     L0025:

; 1054: 		    if(dummy[nat]!=(int)dummy[nat])return line_number;

00008: 05DF 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 05E5 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 05EB DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 05EE D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 05F1 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 05F4 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 05F8 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 05FB DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 05FE 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 0601 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 0604 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0607 89 55 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EDX
00008: 060A DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 060D 8B 15 00000000              MOV EDX, DWORD PTR _nat
00007: 0613 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 0619 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00006: 061C F1DF                        FCOMIP ST, ST(1), L0026
00007: 061E DD D8                       FSTP ST
00008: 0620 7A 02                       JP L00D1
00008: 0622 74 0D                       JE L0026
00008: 0624                     L00D1:
00008: 0624 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0629                             epilog 
00000: 0629 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 062C 5F                          POP EDI
00000: 062D 5E                          POP ESI
00000: 062E 5B                          POP EBX
00000: 062F 5D                          POP EBP
00000: 0630 C3                          RETN 
00008: 0631                     L0026:

; 1055: 		    if(numword==3)dummy[nat+3]=dummy[nat+2];

00008: 0631 83 BD FFFFFF4403            CMP DWORD PTR FFFFFF44[EBP], 00000003
00008: 0638 75 24                       JNE L0027
00008: 063A 8B 1D 00000000              MOV EBX, DWORD PTR _nat
00008: 0640 83 C3 02                    ADD EBX, 00000002
00008: 0643 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 0649 83 C2 03                    ADD EDX, 00000003
00008: 064C 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 0652 DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00007: 0655 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 065B DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]
00008: 065E                     L0027:

; 1056: 		    if(dummy[nat+3]<dummy[nat+2])return line_number;

00008: 065E 8B 1D 00000000              MOV EBX, DWORD PTR _nat
00008: 0664 83 C3 02                    ADD EBX, 00000002
00008: 0667 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 066D 83 C2 03                    ADD EDX, 00000003
00008: 0670 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 0676 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 0679 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 067F DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00006: 0682 F1DF                        FCOMIP ST, ST(1), L0028
00007: 0684 DD D8                       FSTP ST
00008: 0686 7A 0F                       JP L0028
00008: 0688 76 0D                       JBE L0028
00008: 068A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 068F                             epilog 
00000: 068F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0692 5F                          POP EDI
00000: 0693 5E                          POP ESI
00000: 0694 5B                          POP EBX
00000: 0695 5D                          POP EBP
00000: 0696 C3                          RETN 
00008: 0697                     L0028:

; 1057: 		    nat+=4;

00008: 0697 83 05 00000000 04           ADD DWORD PTR _nat, 00000004

; 1058: 		  }

00008: 069E                     L0020:

; 1060: 	      }while(!next_key);

00008: 069E 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 06A5 0F 84 FFFFFE0F              JE L001C

; 1061:             nat/=4;

00008: 06AB A1 00000000                 MOV EAX, DWORD PTR _nat
00008: 06B0 99                          CDQ 
00008: 06B1 83 E2 03                    AND EDX, 00000003
00008: 06B4 01 D0                       ADD EAX, EDX
00008: 06B6 C1 F8 02                    SAR EAX, 00000002
00008: 06B9 A3 00000000                 MOV DWORD PTR _nat, EAX

; 1062: 	    if(!(sam=(atom *)malloc((nat+1)*sizeof(atom))))

00008: 06BE 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 06C4 42                          INC EDX
00008: 06C5 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 06CB 52                          PUSH EDX
00008: 06CC E8 00000000                 CALL SHORT _malloc
00008: 06D1 59                          POP ECX
00008: 06D2 A3 00000000                 MOV DWORD PTR _sam, EAX
00008: 06D7 83 3D 00000000 00           CMP DWORD PTR _sam, 00000000
00008: 06DE 75 15                       JNE L0029

; 1063: 	      {StopAlert (MEMORY_ALRT);return line_number;}

00008: 06E0 6A 02                       PUSH 00000002
00008: 06E2 E8 00000000                 CALL SHORT _StopAlert
00008: 06E7 59                          POP ECX
00008: 06E8 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 06ED                             epilog 
00000: 06ED 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 06F0 5F                          POP EDI
00000: 06F1 5E                          POP ESI
00000: 06F2 5B                          POP EBX
00000: 06F3 5D                          POP EBP
00000: 06F4 C3                          RETN 
00008: 06F5                     L0029:

; 1064: 	    for(i=1;i<=nat;i++) /*fix it later 4*/

00008: 06F5 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 06FF EB 28                       JMP L002A
00008: 0701                     L002B:

; 1065: 	      sam[i].c=0;

00008: 0701 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 0707 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 070E 29 D3                       SUB EBX, EDX
00008: 0710 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0713 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0719 66 C7 84 DA 000000A40000    MOV WORD PTR 000000A4[EDX][EBX*8], 0000
00008: 0723 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0729                     L002A:
00008: 0729 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 072F 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0735 7E FFFFFFCA                 JLE L002B

; 1067: 	    for (i=1;i<=nat;i++)

00008: 0737 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 0741 E9 00000281                 JMP L002C
00008: 0746                     L002D:

; 1069: 		j=dummy[(i-1)*4];

00008: 0746 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 074C 4A                          DEC EDX
00008: 074D 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0754 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 075A DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 075D D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 0760 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 0763 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 0767 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 076A DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 076D 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 0770 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 0773 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0776 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX

; 1070: 		if((j>nat)||(j<1))return line_number; /*fix it later 4*/

00008: 077C 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0782 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0788 7F 09                       JG L002E
00008: 078A 83 BD FFFFFF2401            CMP DWORD PTR FFFFFF24[EBP], 00000001
00008: 0791 7D 0D                       JGE L002F
00008: 0793                     L002E:
00008: 0793 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0798                             epilog 
00000: 0798 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 079B 5F                          POP EDI
00000: 079C 5E                          POP ESI
00000: 079D 5B                          POP EBX
00000: 079E 5D                          POP EBP
00000: 079F C3                          RETN 
00008: 07A0                     L002F:

; 1071:                 if(sam[j].c)return line_number; /*fix it later 4*/

00008: 07A0 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 07A6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 07AD 29 D3                       SUB EBX, EDX
00008: 07AF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07B2 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 07B8 66 83 BC DA 000000A400      CMP WORD PTR 000000A4[EDX][EBX*8], 0000
00008: 07C1 74 0D                       JE L0030
00008: 07C3 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 07C8                             epilog 
00000: 07C8 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 07CB 5F                          POP EDI
00000: 07CC 5E                          POP ESI
00000: 07CD 5B                          POP EBX
00000: 07CE 5D                          POP EBP
00000: 07CF C3                          RETN 
00008: 07D0                     L0030:

; 1072: 		sam[j].m=dummy[(i-1)*4+1];

00008: 07D0 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 07D6 4E                          DEC ESI
00008: 07D7 8D 34 B5 00000000           LEA ESI, [00000000][ESI*4]
00008: 07DE 46                          INC ESI
00008: 07DF 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 07E5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 07EC 29 D3                       SUB EBX, EDX
00008: 07EE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07F1 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 07F7 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 07FD DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 0800 DD 9C DA 00000088           FSTP QWORD PTR 00000088[EDX][EBX*8]

; 1073: 		sam[j].s=dummy[(i-1)*4+2];

00008: 0807 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 080D 4E                          DEC ESI
00008: 080E 8D 34 B5 00000000           LEA ESI, [00000000][ESI*4]
00008: 0815 83 C6 02                    ADD ESI, 00000002
00008: 0818 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 081E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0825 29 D3                       SUB EBX, EDX
00008: 0827 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 082A 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0830 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 0836 DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 0839 DD 9C DA 00000098           FSTP QWORD PTR 00000098[EDX][EBX*8]

; 1074: 		sam[j].b=dummy[(i-1)*4+3];

00008: 0840 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 0846 4E                          DEC ESI
00008: 0847 8D 34 B5 00000000           LEA ESI, [00000000][ESI*4]
00008: 084E 83 C6 03                    ADD ESI, 00000003
00008: 0851 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 0857 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 085E 29 D3                       SUB EBX, EDX
00008: 0860 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0863 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0869 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 086F DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 0872 DD 9C DA 00000090           FSTP QWORD PTR 00000090[EDX][EBX*8]

; 1075: 		sam[j].c=i;

00008: 0879 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 087F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0886 29 D3                       SUB EBX, EDX
00008: 0888 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 088B 8B 35 00000000              MOV ESI, DWORD PTR _sam
00008: 0891 66 8B 85 FFFFFF20           MOV AX, WORD PTR FFFFFF20[EBP]
00008: 0898 66 89 84 DE 000000A4        MOV WORD PTR 000000A4[ESI][EBX*8], AX

; 1076: 		sam[i].r=o;

00008: 08A0 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 08A6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 08AD 29 D3                       SUB EBX, EDX
00008: 08AF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 08B2 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 08B8 8D 3C DA                    LEA EDI, DWORD PTR 00000000[EDX][EBX*8]
00008: 08BB BE 00000000                 MOV ESI, OFFSET _o
00008: 08C0 A5                          MOVSD 
00008: 08C1 A5                          MOVSD 
00008: 08C2 A5                          MOVSD 
00008: 08C3 A5                          MOVSD 
00008: 08C4 A5                          MOVSD 
00008: 08C5 A5                          MOVSD 

; 1077: 		sam[i].v=o;

00008: 08C6 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 08CC 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 08D3 29 D3                       SUB EBX, EDX
00008: 08D5 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 08D8 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 08DE 8D 7C DA 18                 LEA EDI, DWORD PTR 00000018[EDX][EBX*8]
00008: 08E2 BE 00000000                 MOV ESI, OFFSET _o
00008: 08E7 A5                          MOVSD 
00008: 08E8 A5                          MOVSD 
00008: 08E9 A5                          MOVSD 
00008: 08EA A5                          MOVSD 
00008: 08EB A5                          MOVSD 
00008: 08EC A5                          MOVSD 

; 1078: 		sam[i].t=0.0;

00008: 08ED 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 08F3 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 08FA 29 D3                       SUB EBX, EDX
00008: 08FC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 08FF 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0905 C7 44 DA 7C 00000000        MOV DWORD PTR 0000007C[EDX][EBX*8], 00000000
00008: 090D C7 44 DA 78 00000000        MOV DWORD PTR 00000078[EDX][EBX*8], 00000000

; 1079: 		sam[i].i.x.i=0;

00008: 0915 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 091B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0922 29 D3                       SUB EBX, EDX
00008: 0924 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0927 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 092D C7 44 DA 30 00000000        MOV DWORD PTR 00000030[EDX][EBX*8], 00000000

; 1080: 		sam[i].i.y.i=0;

00008: 0935 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 093B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0942 29 D3                       SUB EBX, EDX
00008: 0944 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0947 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 094D C7 44 DA 38 00000000        MOV DWORD PTR 00000038[EDX][EBX*8], 00000000

; 1081: 		sam[i].i.z.i=0;

00008: 0955 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 095B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0962 29 D3                       SUB EBX, EDX
00008: 0964 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0967 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 096D C7 44 DA 40 00000000        MOV DWORD PTR 00000040[EDX][EBX*8], 00000000

; 1082: 		if(sam[i].b>maxrb)maxrb=sam[i].b;

00008: 0975 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 097B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0982 29 D3                       SUB EBX, EDX
00008: 0984 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0987 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 098D DD 84 DA 00000090           FLD QWORD PTR 00000090[EDX][EBX*8]
00007: 0994 DD 45 FFFFFF9C              FLD QWORD PTR FFFFFF9C[EBP]
00006: 0997 F1DF                        FCOMIP ST, ST(1), L0031
00007: 0999 DD D8                       FSTP ST
00008: 099B 7A 24                       JP L0031
00008: 099D 73 22                       JAE L0031
00008: 099F 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 09A5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 09AC 29 D3                       SUB EBX, EDX
00008: 09AE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 09B1 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 09B7 DD 84 DA 00000090           FLD QWORD PTR 00000090[EDX][EBX*8]
00007: 09BE DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]
00008: 09C1                     L0031:

; 1083: 	      }

00008: 09C1 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 09C7                     L002C:
00008: 09C7 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 09CD 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 09D3 0F 8E FFFFFD6D              JLE L002D

; 1084:             maxrb*=2; 

00008: 09D9 DD 45 FFFFFF9C              FLD QWORD PTR FFFFFF9C[EBP]
00007: 09DC DC 0D 00000000              FMUL QWORD PTR .data+00000008
00007: 09E2 DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]

; 1085: 	    for (i=1;i<=nat;i++)

00008: 09E5 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 09EF E9 000000AC                 JMP L0032
00008: 09F4                     L0033:

; 1086: 	      printf("%d %d %lf %lf %lf\n",i,sam[i].c,sam[i].m,sam[i].s,sam[i].b);

00008: 09F4 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 09FA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0A01 29 D3                       SUB EBX, EDX
00008: 0A03 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A06 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0A0C FF B4 DA 00000094           PUSH DWORD PTR 00000094[EDX][EBX*8]
00008: 0A13 FF B4 DA 00000090           PUSH DWORD PTR 00000090[EDX][EBX*8]
00008: 0A1A 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 0A20 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0A27 29 D3                       SUB EBX, EDX
00008: 0A29 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A2C 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0A32 FF B4 DA 0000009C           PUSH DWORD PTR 0000009C[EDX][EBX*8]
00008: 0A39 FF B4 DA 00000098           PUSH DWORD PTR 00000098[EDX][EBX*8]
00008: 0A40 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 0A46 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0A4D 29 D3                       SUB EBX, EDX
00008: 0A4F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A52 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 0A58 FF B4 DA 0000008C           PUSH DWORD PTR 0000008C[EDX][EBX*8]
00008: 0A5F FF B4 DA 00000088           PUSH DWORD PTR 00000088[EDX][EBX*8]
00008: 0A66 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 0A6C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0A73 29 D3                       SUB EBX, EDX
00008: 0A75 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A78 8B 35 00000000              MOV ESI, DWORD PTR _sam
00008: 0A7E 0F BF 84 DE 000000A4        MOVSX EAX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0A86 50                          PUSH EAX
00008: 0A87 FF B5 FFFFFF20              PUSH DWORD PTR FFFFFF20[EBP]
00008: 0A8D 68 00000000                 PUSH OFFSET @1305
00008: 0A92 E8 00000000                 CALL SHORT _printf
00008: 0A97 83 C4 24                    ADD ESP, 00000024
00008: 0A9A FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0AA0                     L0032:
00008: 0AA0 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0AA6 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0AAC 0F 8E FFFFFF42              JLE L0033

; 1088:             coldata=(double ***)malloc((nat+1)*sizeof(double **));

00008: 0AB2 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 0AB8 42                          INC EDX
00008: 0AB9 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0AC0 52                          PUSH EDX
00008: 0AC1 E8 00000000                 CALL SHORT _malloc
00008: 0AC6 59                          POP ECX
00008: 0AC7 89 85 FFFFFF68              MOV DWORD PTR FFFFFF68[EBP], EAX

; 1089: 	    if(!coldata){StopAlert (MEMORY_ALRT);return line_number;}

00008: 0ACD 83 BD FFFFFF6800            CMP DWORD PTR FFFFFF68[EBP], 00000000
00008: 0AD4 75 15                       JNE L0034
00008: 0AD6 6A 02                       PUSH 00000002
00008: 0AD8 E8 00000000                 CALL SHORT _StopAlert
00008: 0ADD 59                          POP ECX
00008: 0ADE A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0AE3                             epilog 
00000: 0AE3 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0AE6 5F                          POP EDI
00000: 0AE7 5E                          POP ESI
00000: 0AE8 5B                          POP EBX
00000: 0AE9 5D                          POP EBP
00000: 0AEA C3                          RETN 
00008: 0AEB                     L0034:

; 1090:             numcol=nat*(nat+1)/2;

00008: 0AEB 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 0AF1 42                          INC EDX
00008: 0AF2 0F AF 15 00000000           IMUL EDX, DWORD PTR _nat
00008: 0AF9 81 FA 80000000              CMP EDX, 80000000
00008: 0AFF 83 DA FFFFFFFF              SBB EDX, FFFFFFFF
00008: 0B02 D1 FA                       SAR EDX, 00000001
00008: 0B04 89 95 FFFFFF34              MOV DWORD PTR FFFFFF34[EBP], EDX

; 1091:             coldata[0]=(double **)malloc((numcol+1)*sizeof(double *));

00008: 0B0A 8B 95 FFFFFF34              MOV EDX, DWORD PTR FFFFFF34[EBP]
00008: 0B10 42                          INC EDX
00008: 0B11 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0B18 52                          PUSH EDX
00008: 0B19 E8 00000000                 CALL SHORT _malloc
00008: 0B1E 59                          POP ECX
00008: 0B1F 8B 8D FFFFFF68              MOV ECX, DWORD PTR FFFFFF68[EBP]
00008: 0B25 89 01                       MOV DWORD PTR 00000000[ECX], EAX

; 1092: 	    if(!coldata[0]){StopAlert (MEMORY_ALRT);return line_number;}

00008: 0B27 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0B2D 83 38 00                    CMP DWORD PTR 00000000[EAX], 00000000
00008: 0B30 75 15                       JNE L0035
00008: 0B32 6A 02                       PUSH 00000002
00008: 0B34 E8 00000000                 CALL SHORT _StopAlert
00008: 0B39 59                          POP ECX
00008: 0B3A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0B3F                             epilog 
00000: 0B3F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0B42 5F                          POP EDI
00000: 0B43 5E                          POP ESI
00000: 0B44 5B                          POP EBX
00000: 0B45 5D                          POP EBP
00000: 0B46 C3                          RETN 
00008: 0B47                     L0035:

; 1094: 	    for(i=0;i<nat;i++)

00008: 0B47 C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 0B51 EB 32                       JMP L0036
00008: 0B53                     L0037:

; 1095:             coldata[i+1]=coldata[i]+i;

00008: 0B53 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 0B59 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 0B60 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 0B66 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0B6C 03 1C 88                    ADD EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0B6F 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 0B75 46                          INC ESI
00008: 0B76 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0B7C 89 1C B0                    MOV DWORD PTR 00000000[EAX][ESI*4], EBX
00008: 0B7F FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0B85                     L0036:
00008: 0B85 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0B8B 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0B91 7C FFFFFFC0                 JL L0037

; 1097: 	    for(i=0;i<=numcol;i++)

00008: 0B93 C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 0B9D EB 1B                       JMP L0038
00008: 0B9F                     L0039:

; 1098:             coldata[0][i]=0;

00008: 0B9F 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0BA5 8B 10                       MOV EDX, DWORD PTR 00000000[EAX]
00008: 0BA7 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0BAD C7 04 82 00000000           MOV DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 0BB4 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0BBA                     L0038:
00008: 0BBA 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0BC0 3B 85 FFFFFF34              CMP EAX, DWORD PTR FFFFFF34[EBP]
00008: 0BC6 7E FFFFFFD7                 JLE L0039

; 1100:             bonddata=(double ***)malloc((nat+1)*sizeof(double **));

00008: 0BC8 8B 15 00000000              MOV EDX, DWORD PTR _nat
00008: 0BCE 42                          INC EDX
00008: 0BCF 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0BD6 52                          PUSH EDX
00008: 0BD7 E8 00000000                 CALL SHORT _malloc
00008: 0BDC 59                          POP ECX
00008: 0BDD 89 85 FFFFFF6C              MOV DWORD PTR FFFFFF6C[EBP], EAX

; 1101: 	    if(!coldata){StopAlert (MEMORY_ALRT);return line_number;}

00008: 0BE3 83 BD FFFFFF6800            CMP DWORD PTR FFFFFF68[EBP], 00000000
00008: 0BEA 75 15                       JNE L003A
00008: 0BEC 6A 02                       PUSH 00000002
00008: 0BEE E8 00000000                 CALL SHORT _StopAlert
00008: 0BF3 59                          POP ECX
00008: 0BF4 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0BF9                             epilog 
00000: 0BF9 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0BFC 5F                          POP EDI
00000: 0BFD 5E                          POP ESI
00000: 0BFE 5B                          POP EBX
00000: 0BFF 5D                          POP EBP
00000: 0C00 C3                          RETN 
00008: 0C01                     L003A:

; 1102:             bonddata[0]=(double **)malloc((numcol+1)*sizeof(double *));

00008: 0C01 8B 95 FFFFFF34              MOV EDX, DWORD PTR FFFFFF34[EBP]
00008: 0C07 42                          INC EDX
00008: 0C08 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0C0F 52                          PUSH EDX
00008: 0C10 E8 00000000                 CALL SHORT _malloc
00008: 0C15 59                          POP ECX
00008: 0C16 8B 8D FFFFFF6C              MOV ECX, DWORD PTR FFFFFF6C[EBP]
00008: 0C1C 89 01                       MOV DWORD PTR 00000000[ECX], EAX

; 1103: 	    if(!coldata[0]){StopAlert (MEMORY_ALRT);return line_number;}

00008: 0C1E 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0C24 83 38 00                    CMP DWORD PTR 00000000[EAX], 00000000
00008: 0C27 75 15                       JNE L003B
00008: 0C29 6A 02                       PUSH 00000002
00008: 0C2B E8 00000000                 CALL SHORT _StopAlert
00008: 0C30 59                          POP ECX
00008: 0C31 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0C36                             epilog 
00000: 0C36 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0C39 5F                          POP EDI
00000: 0C3A 5E                          POP ESI
00000: 0C3B 5B                          POP EBX
00000: 0C3C 5D                          POP EBP
00000: 0C3D C3                          RETN 
00008: 0C3E                     L003B:

; 1105: 	    for(i=0;i<nat;i++)

00008: 0C3E C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 0C48 EB 32                       JMP L003C
00008: 0C4A                     L003D:

; 1106:             bonddata[i+1]=bonddata[i]+i;

00008: 0C4A 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 0C50 8D 1C 9D 00000000           LEA EBX, [00000000][EBX*4]
00008: 0C57 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 0C5D 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0C63 03 1C 88                    ADD EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0C66 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 0C6C 46                          INC ESI
00008: 0C6D 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0C73 89 1C B0                    MOV DWORD PTR 00000000[EAX][ESI*4], EBX
00008: 0C76 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0C7C                     L003C:
00008: 0C7C 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0C82 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 0C88 7C FFFFFFC0                 JL L003D

; 1108: 	    for(i=0;i<=numcol;i++)

00008: 0C8A C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 0C94 EB 1B                       JMP L003E
00008: 0C96                     L003F:

; 1109:             bonddata[0][i]=0;

00008: 0C96 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0C9C 8B 10                       MOV EDX, DWORD PTR 00000000[EAX]
00008: 0C9E 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0CA4 C7 04 82 00000000           MOV DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 0CAB FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 0CB1                     L003E:
00008: 0CB1 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0CB7 3B 85 FFFFFF34              CMP EAX, DWORD PTR FFFFFF34[EBP]
00008: 0CBD 7E FFFFFFD7                 JLE L003F

; 1110:             top=storage;

00008: 0CBF 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 0CC5 89 85 FFFFFF5C              MOV DWORD PTR FFFFFF5C[EBP], EAX

; 1113: 	    current_key=next_key;

00008: 0CCB 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 0CD1 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1114:             break;

00008: 0CD7 E9 00001EB1                 JMP L0011
00008: 0CDC                     L0041:

; 1119: 	    printf("%s\n",keywords[current_key]);

00008: 0CDC 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 0CE2 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 0CE8 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0CEB 50                          PUSH EAX
00008: 0CEC 68 00000000                 PUSH OFFSET @1301
00008: 0CF1 E8 00000000                 CALL SHORT _printf
00008: 0CF6 59                          POP ECX
00008: 0CF7 59                          POP ECX

; 1120: 	    do

00008: 0CF8                     L0042:

; 1122: 		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 0CF8 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 0CFE 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 0D04 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0D0A E8 00000000                 CALL SHORT _next_line
00008: 0D0F 59                          POP ECX
00008: 0D10 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 0D16 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 0D1D 75 0D                       JNE L0043
00008: 0D1F A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0D24                             epilog 
00000: 0D24 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0D27 5F                          POP EDI
00000: 0D28 5E                          POP ESI
00000: 0D29 5B                          POP EBX
00000: 0D2A 5D                          POP EBP
00000: 0D2B C3                          RETN 
00008: 0D2C                     L0043:

; 1123: 		next_key=iskeyword(datfile);

00008: 0D2C FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0D32 E8 00000000                 CALL SHORT _iskeyword
00008: 0D37 59                          POP ECX
00008: 0D38 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1124: 		if(next_key<0)return line_number;

00008: 0D3E 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0D45 7D 0D                       JGE L0044
00008: 0D47 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0D4C                             epilog 
00000: 0D4C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0D4F 5F                          POP EDI
00000: 0D50 5E                          POP ESI
00000: 0D51 5B                          POP EBX
00000: 0D52 5D                          POP EBP
00000: 0D53 C3                          RETN 
00008: 0D54                     L0044:

; 1125:                 if(!next_key)

00008: 0D54 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0D5B 0F 85 0000029B              JNE L0045

; 1127:                     double a=0;

00008: 0D61 DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 0D67 DD 5D FFFFFFA4              FSTP QWORD PTR FFFFFFA4[EBP]

; 1128: 		    numword=0;

00008: 0D6A C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1130: 		    while(is_word(datfile))

00008: 0D74 EB 48                       JMP L0046
00008: 0D76                     L0047:

; 1132: 			sscanf(datfile,"%lf",top+numword);

00008: 0D76 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 0D7C 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 0D83 03 95 FFFFFF5C              ADD EDX, DWORD PTR FFFFFF5C[EBP]
00008: 0D89 52                          PUSH EDX
00008: 0D8A 68 00000000                 PUSH OFFSET @1302
00008: 0D8F FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0D95 E8 00000000                 CALL SHORT _sscanf
00008: 0D9A 83 C4 0C                    ADD ESP, 0000000C

; 1133: 			numword++;

00008: 0D9D FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1134: 			if(!(datfile=next_word(datfile)))break;

00008: 0DA3 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0DA9 E8 00000000                 CALL SHORT _next_word
00008: 0DAE 59                          POP ECX
00008: 0DAF 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 0DB5 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 0DBC 74 11                       JE L0048

; 1135: 		      }

00008: 0DBE                     L0046:
00008: 0DBE FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 0DC4 E8 00000000                 CALL SHORT _is_word
00008: 0DC9 59                          POP ECX
00008: 0DCA 83 F8 00                    CMP EAX, 00000000
00008: 0DCD 75 FFFFFFA7                 JNE L0047
00008: 0DCF                     L0048:

; 1136: 		    if((numword<3)||(!(numword&1)))return line_number;

00008: 0DCF 83 BD FFFFFF4403            CMP DWORD PTR FFFFFF44[EBP], 00000003
00008: 0DD6 7C 0E                       JL L0049
00008: 0DD8 8B 85 FFFFFF44              MOV EAX, DWORD PTR FFFFFF44[EBP]
00008: 0DDE 83 E0 01                    AND EAX, 00000001
00008: 0DE1 83 F8 00                    CMP EAX, 00000000
00008: 0DE4 75 0D                       JNE L004A
00008: 0DE6                     L0049:
00008: 0DE6 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0DEB                             epilog 
00000: 0DEB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0DEE 5F                          POP EDI
00000: 0DEF 5E                          POP ESI
00000: 0DF0 5B                          POP EBX
00000: 0DF1 5D                          POP EBP
00000: 0DF2 C3                          RETN 
00008: 0DF3                     L004A:

; 1137:                     if((current_key==EL_COL)&&(numword>3))return line_number;

00008: 0DF3 83 BD FFFFFF3005            CMP DWORD PTR FFFFFF30[EBP], 00000005
00008: 0DFA 75 16                       JNE L004B
00008: 0DFC 83 BD FFFFFF4403            CMP DWORD PTR FFFFFF44[EBP], 00000003
00008: 0E03 7E 0D                       JLE L004B
00008: 0E05 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0E0A                             epilog 
00000: 0E0A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0E0D 5F                          POP EDI
00000: 0E0E 5E                          POP ESI
00000: 0E0F 5B                          POP EBX
00000: 0E10 5D                          POP EBP
00000: 0E11 C3                          RETN 
00008: 0E12                     L004B:

; 1138: 		    i=top[0];

00008: 0E12 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0E18 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0E1A D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 0E1D 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 0E20 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 0E24 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 0E27 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 0E2A 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 0E2D D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 0E30 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0E33 89 95 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EDX

; 1139: 		    if(i!=top[0])return line_number;

00008: 0E39 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0E3F 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 0E42 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 0E45 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0E4B DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 0E4D F1DF                        FCOMIP ST, ST(1), L004C
00007: 0E4F DD D8                       FSTP ST
00008: 0E51 7A 02                       JP L00D2
00008: 0E53 74 0D                       JE L004C
00008: 0E55                     L00D2:
00008: 0E55 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0E5A                             epilog 
00000: 0E5A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0E5D 5F                          POP EDI
00000: 0E5E 5E                          POP ESI
00000: 0E5F 5B                          POP EBX
00000: 0E60 5D                          POP EBP
00000: 0E61 C3                          RETN 
00008: 0E62                     L004C:

; 1140: 		    j=top[1];

00008: 0E62 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0E68 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 0E6B D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 0E6E 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 0E71 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 0E75 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 0E78 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 0E7B 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 0E7E D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 0E81 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0E84 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX

; 1141:                     if(j!=top[1])return line_number;

00008: 0E8A 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0E90 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 0E93 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 0E96 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0E9C DD 40 08                    FLD QWORD PTR 00000008[EAX]
00006: 0E9F F1DF                        FCOMIP ST, ST(1), L004D
00007: 0EA1 DD D8                       FSTP ST
00008: 0EA3 7A 02                       JP L00D3
00008: 0EA5 74 0D                       JE L004D
00008: 0EA7                     L00D3:
00008: 0EA7 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0EAC                             epilog 
00000: 0EAC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0EAF 5F                          POP EDI
00000: 0EB0 5E                          POP ESI
00000: 0EB1 5B                          POP EBX
00000: 0EB2 5D                          POP EBP
00000: 0EB3 C3                          RETN 
00008: 0EB4                     L004D:

; 1142: 		    if(j>i){k=i;i=j;j=k;}

00008: 0EB4 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0EBA 3B 85 FFFFFF20              CMP EAX, DWORD PTR FFFFFF20[EBP]
00008: 0EC0 7E 24                       JLE L004E
00008: 0EC2 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 0EC8 89 85 FFFFFF28              MOV DWORD PTR FFFFFF28[EBP], EAX
00008: 0ECE 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0ED4 89 85 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EAX
00008: 0EDA 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 0EE0 89 85 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EAX
00008: 0EE6                     L004E:

; 1143: 		    if(coldata[i][j])return line_number;

00008: 0EE6 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 0EEC 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0EF2 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0EF5 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0EFB 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 0EFF 74 0D                       JE L004F
00008: 0F01 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0F06                             epilog 
00000: 0F06 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0F09 5F                          POP EDI
00000: 0F0A 5E                          POP ESI
00000: 0F0B 5B                          POP EBX
00000: 0F0C 5D                          POP EBP
00000: 0F0D C3                          RETN 
00008: 0F0E                     L004F:

; 1144: 		    coldata[i][j]=top;

00008: 0F0E 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 0F14 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 0F1A 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 0F1D 8B 8D FFFFFF5C              MOV ECX, DWORD PTR FFFFFF5C[EBP]
00008: 0F23 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 0F29 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 1145:                     top[0]=numword;

00008: 0F2C 8B 85 FFFFFF44              MOV EAX, DWORD PTR FFFFFF44[EBP]
00008: 0F32 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 0F35 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 0F38 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0F3E DD 18                       FSTP QWORD PTR 00000000[EAX]

; 1146: 		    top[1]=top[2];

00008: 0F40 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0F46 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 0F49 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0F4F DD 58 08                    FSTP QWORD PTR 00000008[EAX]

; 1147: 		    top[2]=dblarg1;

00008: 0F52 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0F58 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0F5E DD 58 10                    FSTP QWORD PTR 00000010[EAX]

; 1148:                     for(k=1;k<numword;k+=2)

00008: 0F61 C7 85 FFFFFF2800000001      MOV DWORD PTR FFFFFF28[EBP], 00000001
00008: 0F6B EB 40                       JMP L0050
00008: 0F6D                     L0051:

; 1150: 			if(top[k]<=a)return line_number;

00008: 0F6D 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 0F73 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0F79 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 0F7C DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00006: 0F7F F1DF                        FCOMIP ST, ST(1), L0052
00007: 0F81 DD D8                       FSTP ST
00008: 0F83 7A 0F                       JP L0052
00008: 0F85 72 0D                       JB L0052
00008: 0F87 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 0F8C                             epilog 
00000: 0F8C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0F8F 5F                          POP EDI
00000: 0F90 5E                          POP ESI
00000: 0F91 5B                          POP EBX
00000: 0F92 5D                          POP EBP
00000: 0F93 C3                          RETN 
00008: 0F94                     L0052:

; 1151: 			a=top[k];

00008: 0F94 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 0F9A 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0FA0 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 0FA3 DD 5D FFFFFFA4              FSTP QWORD PTR FFFFFFA4[EBP]

; 1152: 		      }

00008: 0FA6 83 85 FFFFFF2802            ADD DWORD PTR FFFFFF28[EBP], 00000002
00008: 0FAD                     L0050:
00008: 0FAD 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 0FB3 3B 85 FFFFFF44              CMP EAX, DWORD PTR FFFFFF44[EBP]
00008: 0FB9 7C FFFFFFB2                 JL L0051

; 1153: 		    if(maxrb<a)maxrb=a;

00008: 0FBB DD 45 FFFFFF9C              FLD QWORD PTR FFFFFF9C[EBP]
00007: 0FBE DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00006: 0FC1 F1DF                        FCOMIP ST, ST(1), L0053
00007: 0FC3 DD D8                       FSTP ST
00008: 0FC5 7A 08                       JP L0053
00008: 0FC7 76 06                       JBE L0053
00008: 0FC9 DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00007: 0FCC DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]
00008: 0FCF                     L0053:

; 1154: 		    top+=numword;

00008: 0FCF 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 0FD5 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 0FDC 01 95 FFFFFF5C              ADD DWORD PTR FFFFFF5C[EBP], EDX

; 1155:                     bonds=top;

00008: 0FE2 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0FE8 89 85 FFFFFF64              MOV DWORD PTR FFFFFF64[EBP], EAX

; 1156: 		    numwell+=numword>>1;

00008: 0FEE 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 0FF4 D1 FA                       SAR EDX, 00000001
00008: 0FF6 01 95 FFFFFF38              ADD DWORD PTR FFFFFF38[EBP], EDX

; 1157: 		  }

00008: 0FFC                     L0045:

; 1158: 	      }while(!next_key);

00008: 0FFC 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1003 0F 84 FFFFFCEF              JE L0042

; 1159: 	  current_key=next_key;

00008: 1009 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 100F 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1160: 	  break;

00008: 1015 E9 00001B73                 JMP L0011
00008: 101A                     L0054:

; 1164: 	    printf("%s\n",keywords[current_key]);

00008: 101A 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 1020 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 1026 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 1029 50                          PUSH EAX
00008: 102A 68 00000000                 PUSH OFFSET @1301
00008: 102F E8 00000000                 CALL SHORT _printf
00008: 1034 59                          POP ECX
00008: 1035 59                          POP ECX

; 1165: 	    do

00008: 1036                     L0055:

; 1167: 		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 1036 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 103C 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 1042 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1048 E8 00000000                 CALL SHORT _next_line
00008: 104D 59                          POP ECX
00008: 104E 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 1054 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 105B 75 0D                       JNE L0056
00008: 105D A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1062                             epilog 
00000: 1062 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1065 5F                          POP EDI
00000: 1066 5E                          POP ESI
00000: 1067 5B                          POP EBX
00000: 1068 5D                          POP EBP
00000: 1069 C3                          RETN 
00008: 106A                     L0056:

; 1168: 		next_key=iskeyword(datfile);

00008: 106A FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1070 E8 00000000                 CALL SHORT _iskeyword
00008: 1075 59                          POP ECX
00008: 1076 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1169: 		if(next_key<0)return line_number;

00008: 107C 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1083 7D 0D                       JGE L0057
00008: 1085 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 108A                             epilog 
00000: 108A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 108D 5F                          POP EDI
00000: 108E 5E                          POP ESI
00000: 108F 5B                          POP EBX
00000: 1090 5D                          POP EBP
00000: 1091 C3                          RETN 
00008: 1092                     L0057:

; 1170:                 if(!next_key)

00008: 1092 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1099 0F 85 000002BE              JNE L0058

; 1172:                     double a=0;

00008: 109F DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 10A5 DD 5D FFFFFFAC              FSTP QWORD PTR FFFFFFAC[EBP]

; 1173: 		    numword=0;

00008: 10A8 C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1175: 		    while(is_word(datfile))

00008: 10B2 EB 48                       JMP L0059
00008: 10B4                     L005A:

; 1177: 			sscanf(datfile,"%lf",top+numword);

00008: 10B4 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 10BA 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 10C1 03 95 FFFFFF5C              ADD EDX, DWORD PTR FFFFFF5C[EBP]
00008: 10C7 52                          PUSH EDX
00008: 10C8 68 00000000                 PUSH OFFSET @1302
00008: 10CD FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 10D3 E8 00000000                 CALL SHORT _sscanf
00008: 10D8 83 C4 0C                    ADD ESP, 0000000C

; 1178: 			numword++;

00008: 10DB FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1179: 			if(!(datfile=next_word(datfile)))break;

00008: 10E1 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 10E7 E8 00000000                 CALL SHORT _next_word
00008: 10EC 59                          POP ECX
00008: 10ED 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 10F3 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 10FA 74 11                       JE L005B

; 1180: 		      }

00008: 10FC                     L0059:
00008: 10FC FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1102 E8 00000000                 CALL SHORT _is_word
00008: 1107 59                          POP ECX
00008: 1108 83 F8 00                    CMP EAX, 00000000
00008: 110B 75 FFFFFFA7                 JNE L005A
00008: 110D                     L005B:

; 1181: 		    if(numword<4)return line_number;

00008: 110D 83 BD FFFFFF4404            CMP DWORD PTR FFFFFF44[EBP], 00000004
00008: 1114 7D 0D                       JGE L005C
00008: 1116 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 111B                             epilog 
00000: 111B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 111E 5F                          POP EDI
00000: 111F 5E                          POP ESI
00000: 1120 5B                          POP EBX
00000: 1121 5D                          POP EBP
00000: 1122 C3                          RETN 
00008: 1123                     L005C:

; 1182: 		    i=top[0];

00008: 1123 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 1129 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 112B D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 112E 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1131 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1135 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1138 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 113B 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 113E D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1141 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1144 89 95 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EDX

; 1183: 		    if(i!=top[0])return line_number;

00008: 114A 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 1150 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 1153 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 1156 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 115C DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 115E F1DF                        FCOMIP ST, ST(1), L005D
00007: 1160 DD D8                       FSTP ST
00008: 1162 7A 02                       JP L00D4
00008: 1164 74 0D                       JE L005D
00008: 1166                     L00D4:
00008: 1166 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 116B                             epilog 
00000: 116B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 116E 5F                          POP EDI
00000: 116F 5E                          POP ESI
00000: 1170 5B                          POP EBX
00000: 1171 5D                          POP EBP
00000: 1172 C3                          RETN 
00008: 1173                     L005D:

; 1184: 		    j=top[1];

00008: 1173 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 1179 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 117C D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 117F 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1182 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1186 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1189 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 118C 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 118F D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1192 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1195 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX

; 1185:                     if(j!=top[1])return line_number;

00008: 119B 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 11A1 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 11A4 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 11A7 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 11AD DD 40 08                    FLD QWORD PTR 00000008[EAX]
00006: 11B0 F1DF                        FCOMIP ST, ST(1), L005E
00007: 11B2 DD D8                       FSTP ST
00008: 11B4 7A 02                       JP L00D5
00008: 11B6 74 0D                       JE L005E
00008: 11B8                     L00D5:
00008: 11B8 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 11BD                             epilog 
00000: 11BD 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 11C0 5F                          POP EDI
00000: 11C1 5E                          POP ESI
00000: 11C2 5B                          POP EBX
00000: 11C3 5D                          POP EBP
00000: 11C4 C3                          RETN 
00008: 11C5                     L005E:

; 1186: 		    if(j>i){k=i;i=j;j=k;}

00008: 11C5 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 11CB 3B 85 FFFFFF20              CMP EAX, DWORD PTR FFFFFF20[EBP]
00008: 11D1 7E 24                       JLE L005F
00008: 11D3 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 11D9 89 85 FFFFFF28              MOV DWORD PTR FFFFFF28[EBP], EAX
00008: 11DF 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 11E5 89 85 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EAX
00008: 11EB 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 11F1 89 85 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EAX
00008: 11F7                     L005F:

; 1187: 		    if(bonddata[i][j])return line_number;

00008: 11F7 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 11FD 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 1203 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1206 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 120C 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 1210 74 0D                       JE L0060
00008: 1212 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1217                             epilog 
00000: 1217 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 121A 5F                          POP EDI
00000: 121B 5E                          POP ESI
00000: 121C 5B                          POP EBX
00000: 121D 5D                          POP EBP
00000: 121E C3                          RETN 
00008: 121F                     L0060:

; 1188: 		    bonddata[i][j]=top;

00008: 121F 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1225 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 122B 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 122E 8B 8D FFFFFF5C              MOV ECX, DWORD PTR FFFFFF5C[EBP]
00008: 1234 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 123A 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 1189:                     top[0]=numword;

00008: 123D 8B 85 FFFFFF44              MOV EAX, DWORD PTR FFFFFF44[EBP]
00008: 1243 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 1246 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 1249 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 124F DD 18                       FSTP QWORD PTR 00000000[EAX]

; 1190: 		    top[1]=top[2];

00008: 1251 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 1257 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 125A 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 1260 DD 58 08                    FSTP QWORD PTR 00000008[EAX]

; 1191: 		    top[2]=dblarg1;

00008: 1263 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 1269 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 126F DD 58 10                    FSTP QWORD PTR 00000010[EAX]

; 1192:                     for(k=1;k<numword;k+=2)

00008: 1272 C7 85 FFFFFF2800000001      MOV DWORD PTR FFFFFF28[EBP], 00000001
00008: 127C EB 40                       JMP L0061
00008: 127E                     L0062:

; 1194: 			if(top[k]<=a)return line_number;

00008: 127E 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 1284 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 128A DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 128D DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00006: 1290 F1DF                        FCOMIP ST, ST(1), L0063
00007: 1292 DD D8                       FSTP ST
00008: 1294 7A 0F                       JP L0063
00008: 1296 72 0D                       JB L0063
00008: 1298 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 129D                             epilog 
00000: 129D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 12A0 5F                          POP EDI
00000: 12A1 5E                          POP ESI
00000: 12A2 5B                          POP EBX
00000: 12A3 5D                          POP EBP
00000: 12A4 C3                          RETN 
00008: 12A5                     L0063:

; 1195: 			a=top[k];

00008: 12A5 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 12AB 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 12B1 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 12B4 DD 5D FFFFFFAC              FSTP QWORD PTR FFFFFFAC[EBP]

; 1196: 		      }

00008: 12B7 83 85 FFFFFF2802            ADD DWORD PTR FFFFFF28[EBP], 00000002
00008: 12BE                     L0061:
00008: 12BE 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 12C4 3B 85 FFFFFF44              CMP EAX, DWORD PTR FFFFFF44[EBP]
00008: 12CA 7C FFFFFFB2                 JL L0062

; 1198:                     if((numword&1)&&(a<coldata[i][j][1]))return line_number;

00008: 12CC 8B 85 FFFFFF44              MOV EAX, DWORD PTR FFFFFF44[EBP]
00008: 12D2 83 E0 01                    AND EAX, 00000001
00008: 12D5 83 F8 00                    CMP EAX, 00000000
00008: 12D8 74 33                       JE L0064
00008: 12DA 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 12E0 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 12E6 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 12E9 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 12EF 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 12F2 DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00007: 12F5 DD 42 08                    FLD QWORD PTR 00000008[EDX]
00006: 12F8 F1DF                        FCOMIP ST, ST(1), L0064
00007: 12FA DD D8                       FSTP ST
00008: 12FC 7A 0F                       JP L0064
00008: 12FE 76 0D                       JBE L0064
00008: 1300 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1305                             epilog 
00000: 1305 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1308 5F                          POP EDI
00000: 1309 5E                          POP ESI
00000: 130A 5B                          POP EBX
00000: 130B 5D                          POP EBP
00000: 130C C3                          RETN 
00008: 130D                     L0064:

; 1199: 		    if(maxrb<a)maxrb=a;

00008: 130D DD 45 FFFFFF9C              FLD QWORD PTR FFFFFF9C[EBP]
00007: 1310 DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00006: 1313 F1DF                        FCOMIP ST, ST(1), L0065
00007: 1315 DD D8                       FSTP ST
00008: 1317 7A 08                       JP L0065
00008: 1319 76 06                       JBE L0065
00008: 131B DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00007: 131E DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]
00008: 1321                     L0065:

; 1200: 		    top+=numword;

00008: 1321 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 1327 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 132E 01 95 FFFFFF5C              ADD DWORD PTR FFFFFF5C[EBP], EDX

; 1201:                     bonds=top;

00008: 1334 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 133A 89 85 FFFFFF64              MOV DWORD PTR FFFFFF64[EBP], EAX

; 1202: 		    numbondwell+=numword>>1;

00008: 1340 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 1346 D1 FA                       SAR EDX, 00000001
00008: 1348 01 95 FFFFFF3C              ADD DWORD PTR FFFFFF3C[EBP], EDX

; 1203:                     numunstable+=numword&1;

00008: 134E 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 1354 83 E2 01                    AND EDX, 00000001
00008: 1357 01 95 FFFFFF40              ADD DWORD PTR FFFFFF40[EBP], EDX

; 1204: 		  }

00008: 135D                     L0058:

; 1205: 	      }while(!next_key);

00008: 135D 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1364 0F 84 FFFFFCCC              JE L0055

; 1206: 	    if(numunstable)

00008: 136A 83 BD FFFFFF4000            CMP DWORD PTR FFFFFF40[EBP], 00000000
00008: 1371 0F 84 0000022A              JE L0066

; 1208: 		react0=(ReactionData *)malloc((numunstable+1)*sizeof(ReactionData));

00008: 1377 8B 95 FFFFFF40              MOV EDX, DWORD PTR FFFFFF40[EBP]
00008: 137D 42                          INC EDX
00008: 137E 6B D2 28                    IMUL EDX, EDX, 00000028
00008: 1381 52                          PUSH EDX
00008: 1382 E8 00000000                 CALL SHORT _malloc
00008: 1387 59                          POP ECX
00008: 1388 89 85 FFFFFF70              MOV DWORD PTR FFFFFF70[EBP], EAX

; 1209: 		k=0;

00008: 138E C7 85 FFFFFF2800000000      MOV DWORD PTR FFFFFF28[EBP], 00000000

; 1210: 		for(i=1;i<=nat;i++)

00008: 1398 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 13A2 E9 000001E8                 JMP L0067
00008: 13A7                     L0068:

; 1211: 		  for(j=1;j<=i;j++)

00008: 13A7 C7 85 FFFFFF2400000001      MOV DWORD PTR FFFFFF24[EBP], 00000001
00008: 13B1 E9 000001C1                 JMP L0069
00008: 13B6                     L006A:

; 1212: 		    if(bonddata[i][j])

00008: 13B6 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 13BC 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 13C2 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 13C5 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 13CB 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 13CF 0F 84 0000019C              JE L006B

; 1214: 			numword=bonddata[i][j][0];

00008: 13D5 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 13DB 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 13E1 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 13E4 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 13EA 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 13ED DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 13EF D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 13F2 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 13F5 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 13F9 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 13FC DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 13FF 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1402 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1405 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1408 89 95 FFFFFF44              MOV DWORD PTR FFFFFF44[EBP], EDX

; 1215: 			if(numword&1)

00008: 140E 8B 85 FFFFFF44              MOV EAX, DWORD PTR FFFFFF44[EBP]
00008: 1414 83 E0 01                    AND EAX, 00000001
00008: 1417 83 F8 00                    CMP EAX, 00000000
00008: 141A 0F 84 00000151              JE L006C

; 1217: 			    k++;

00008: 1420 FF 85 FFFFFF28              INC DWORD PTR FFFFFF28[EBP]

; 1218: 			    react0[k].old1=i;

00008: 1426 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 142C 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 142F 66 8B 8D FFFFFF20           MOV CX, WORD PTR FFFFFF20[EBP]
00008: 1436 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 143C 66 89 4C D8 10              MOV WORD PTR 00000010[EAX][EBX*8], CX

; 1219: 			    react0[k].old2=j;

00008: 1441 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1447 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 144A 66 8B 8D FFFFFF24           MOV CX, WORD PTR FFFFFF24[EBP]
00008: 1451 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 1457 66 89 4C D8 12              MOV WORD PTR 00000012[EAX][EBX*8], CX

; 1220: 			    react0[k].new1=i;

00008: 145C 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1462 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1465 66 8B 8D FFFFFF20           MOV CX, WORD PTR FFFFFF20[EBP]
00008: 146C 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 1472 66 89 4C D8 14              MOV WORD PTR 00000014[EAX][EBX*8], CX

; 1221: 			    react0[k].new2=j;

00008: 1477 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 147D 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1480 66 8B 8D FFFFFF24           MOV CX, WORD PTR FFFFFF24[EBP]
00008: 1487 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 148D 66 89 4C D8 16              MOV WORD PTR 00000016[EAX][EBX*8], CX

; 1222: 			    react0[k].bond=1;

00008: 1492 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1498 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 149B 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 14A1 66 C7 44 D8 18 0001         MOV WORD PTR 00000018[EAX][EBX*8], 0001

; 1223: 			    react0[k].dd=bonddata[i][j][numword-2];

00008: 14A8 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 14AE 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 14B4 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 14B7 8B B5 FFFFFF44              MOV ESI, DWORD PTR FFFFFF44[EBP]
00008: 14BD 83 C6 FFFFFFFE              ADD ESI, FFFFFFFE
00008: 14C0 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 14C6 8B 3C 83                    MOV EDI, DWORD PTR 00000000[EBX][EAX*4]
00008: 14C9 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 14CF 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 14D2 DD 04 F7                    FLD QWORD PTR 00000000[EDI][ESI*8]
00007: 14D5 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 14DB DD 5C D8 08                 FSTP QWORD PTR 00000008[EAX][EBX*8]

; 1224: 			    react0[k].dd*=react0[k].dd;

00008: 14DF 8B B5 FFFFFF28              MOV ESI, DWORD PTR FFFFFF28[EBP]
00008: 14E5 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 14E8 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 14EE 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 14F1 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 14F7 DD 44 D8 08                 FLD QWORD PTR 00000008[EAX][EBX*8]
00007: 14FB 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 1501 DC 4C F0 08                 FMUL QWORD PTR 00000008[EAX][ESI*8]
00007: 1505 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 150B DD 5C D8 08                 FSTP QWORD PTR 00000008[EAX][EBX*8]

; 1225: 			    react0[k].eo=bonddata[i][j][numword-1];

00008: 150F 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1515 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 151B 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 151E 8B B5 FFFFFF44              MOV ESI, DWORD PTR FFFFFF44[EBP]
00008: 1524 4E                          DEC ESI
00008: 1525 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 152B 8B 3C 83                    MOV EDI, DWORD PTR 00000000[EBX][EAX*4]
00008: 152E 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1534 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1537 DD 04 F7                    FLD QWORD PTR 00000000[EDI][ESI*8]
00007: 153A 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 1540 DD 1C D8                    FSTP QWORD PTR 00000000[EAX][EBX*8]

; 1226: 			    react0[k].in=-1;

00008: 1543 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1549 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 154C 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 1552 C7 44 D8 1C FFFFFFFF        MOV DWORD PTR 0000001C[EAX][EBX*8], FFFFFFFF

; 1227: 			    react0[k].out =-1;

00008: 155A 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 1560 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1563 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 1569 C7 44 D8 20 FFFFFFFF        MOV DWORD PTR 00000020[EAX][EBX*8], FFFFFFFF

; 1228: 			  }

00008: 1571                     L006C:

; 1229: 		      }

00008: 1571                     L006B:
00008: 1571 FF 85 FFFFFF24              INC DWORD PTR FFFFFF24[EBP]
00008: 1577                     L0069:
00008: 1577 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 157D 3B 85 FFFFFF20              CMP EAX, DWORD PTR FFFFFF20[EBP]
00008: 1583 0F 8E FFFFFE2D              JLE L006A
00008: 1589 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 158F                     L0067:
00008: 158F 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 1595 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 159B 0F 8E FFFFFE06              JLE L0068

; 1230: 	      }

00008: 15A1                     L0066:

; 1231: 	    current_key=next_key;

00008: 15A1 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 15A7 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1232: 	    break;

00008: 15AD E9 000015DB                 JMP L0011
00008: 15B2                     L006D:

; 1236: 	    printf("%s\n",keywords[current_key]);

00008: 15B2 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 15B8 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 15BE 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 15C1 50                          PUSH EAX
00008: 15C2 68 00000000                 PUSH OFFSET @1301
00008: 15C7 E8 00000000                 CALL SHORT _printf
00008: 15CC 59                          POP ECX
00008: 15CD 59                          POP ECX

; 1237: 	    dummy=top;

00008: 15CE 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 15D4 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 1238:             nrt=0;

00008: 15DA C7 05 00000000 00000000     MOV DWORD PTR _nrt, 00000000

; 1239:             do

00008: 15E4                     L006E:

; 1241: 		numword=0;

00008: 15E4 C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1242: 		datfile=nextline;if(!(nextline=next_line(datfile)))return line_number;

00008: 15EE 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 15F4 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 15FA FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1600 E8 00000000                 CALL SHORT _next_line
00008: 1605 59                          POP ECX
00008: 1606 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX
00008: 160C 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 1613 75 0D                       JNE L006F
00008: 1615 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 161A                             epilog 
00000: 161A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 161D 5F                          POP EDI
00000: 161E 5E                          POP ESI
00000: 161F 5B                          POP EBX
00000: 1620 5D                          POP EBP
00000: 1621 C3                          RETN 
00008: 1622                     L006F:

; 1243: 		next_key=iskeyword(datfile);

00008: 1622 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1628 E8 00000000                 CALL SHORT _iskeyword
00008: 162D 59                          POP ECX
00008: 162E 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1244: 		if(next_key<0)return line_number;

00008: 1634 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 163B 7D 0D                       JGE L0070
00008: 163D A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1642                             epilog 
00000: 1642 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1645 5F                          POP EDI
00000: 1646 5E                          POP ESI
00000: 1647 5B                          POP EBX
00000: 1648 5D                          POP EBP
00000: 1649 C3                          RETN 
00008: 164A                     L0070:

; 1245:                 if(!next_key)

00008: 164A 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1651 0F 85 0000055E              JNE L0071

; 1249: 		    numword=0;

00008: 1657 C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1250: 		    while(is_word(datfile))

00008: 1661 EB 57                       JMP L0072
00008: 1663                     L0073:

; 1252: 			sscanf(datfile,"%lf",dummy+nrt+numword);

00008: 1663 8B 9D FFFFFF44              MOV EBX, DWORD PTR FFFFFF44[EBP]
00008: 1669 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 1670 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1676 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 167D 03 95 FFFFFF60              ADD EDX, DWORD PTR FFFFFF60[EBP]
00008: 1683 01 D3                       ADD EBX, EDX
00008: 1685 53                          PUSH EBX
00008: 1686 68 00000000                 PUSH OFFSET @1302
00008: 168B FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 1691 E8 00000000                 CALL SHORT _sscanf
00008: 1696 83 C4 0C                    ADD ESP, 0000000C

; 1253: 			numword++;

00008: 1699 FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1254: 			if(!(datfile=next_word(datfile)))break;

00008: 169F FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 16A5 E8 00000000                 CALL SHORT _next_word
00008: 16AA 59                          POP ECX
00008: 16AB 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 16B1 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 16B8 74 11                       JE L0074

; 1255: 		      }

00008: 16BA                     L0072:
00008: 16BA FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 16C0 E8 00000000                 CALL SHORT _is_word
00008: 16C5 59                          POP ECX
00008: 16C6 83 F8 00                    CMP EAX, 00000000
00008: 16C9 75 FFFFFF98                 JNE L0073
00008: 16CB                     L0074:

; 1256: 		    if((numword<4)||(numword>7))return line_number;

00008: 16CB 83 BD FFFFFF4404            CMP DWORD PTR FFFFFF44[EBP], 00000004
00008: 16D2 7C 09                       JL L0075
00008: 16D4 83 BD FFFFFF4407            CMP DWORD PTR FFFFFF44[EBP], 00000007
00008: 16DB 7E 0D                       JLE L0076
00008: 16DD                     L0075:
00008: 16DD A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 16E2                             epilog 
00000: 16E2 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 16E5 5F                          POP EDI
00000: 16E6 5E                          POP ESI
00000: 16E7 5B                          POP EBX
00000: 16E8 5D                          POP EBP
00000: 16E9 C3                          RETN 
00008: 16EA                     L0076:

; 1257:                     if(numword==4)dummy[numword]=0;

00008: 16EA 83 BD FFFFFF4404            CMP DWORD PTR FFFFFF44[EBP], 00000004
00008: 16F1 75 27                       JNE L0077
00008: 16F3 8B 8D FFFFFF44              MOV ECX, DWORD PTR FFFFFF44[EBP]
00008: 16F9 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 16FF C7 44 C8 04 00000000        MOV DWORD PTR 00000004[EAX][ECX*8], 00000000
00008: 1707 8B 8D FFFFFF44              MOV ECX, DWORD PTR FFFFFF44[EBP]
00008: 170D 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1713 C7 04 C8 00000000           MOV DWORD PTR 00000000[EAX][ECX*8], 00000000
00008: 171A                     L0077:

; 1258:                     for(i=0;i<5;i++)

00008: 171A C7 85 FFFFFF2000000000      MOV DWORD PTR FFFFFF20[EBP], 00000000
00008: 1724 EB 64                       JMP L0078
00008: 1726                     L0079:

; 1259: 		      if(dummy[nrt+i]!=(int)dummy[nrt+i])return line_number;

00008: 1726 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 172C 03 95 FFFFFF20              ADD EDX, DWORD PTR FFFFFF20[EBP]
00008: 1732 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1738 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 173B D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 173E 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1741 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1745 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1748 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 174B 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 174E D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1751 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1754 89 55 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EDX
00008: 1757 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 175A 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00007: 1760 03 95 FFFFFF20              ADD EDX, DWORD PTR FFFFFF20[EBP]
00007: 1766 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 176C DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00006: 176F F1DF                        FCOMIP ST, ST(1), L007A
00007: 1771 DD D8                       FSTP ST
00008: 1773 7A 02                       JP L00D6
00008: 1775 74 0D                       JE L007A
00008: 1777                     L00D6:
00008: 1777 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 177C                             epilog 
00000: 177C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 177F 5F                          POP EDI
00000: 1780 5E                          POP ESI
00000: 1781 5B                          POP EBX
00000: 1782 5D                          POP EBP
00000: 1783 C3                          RETN 
00008: 1784                     L007A:
00008: 1784 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 178A                     L0078:
00008: 178A 83 BD FFFFFF2005            CMP DWORD PTR FFFFFF20[EBP], 00000005
00008: 1791 7C FFFFFF93                 JL L0079

; 1260: 		    old1=i=dummy[nrt];

00008: 1793 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1799 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 179F DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 17A2 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 17A5 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 17A8 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 17AC D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 17AF DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 17B2 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 17B5 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 17B8 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 17BB 89 95 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EDX
00008: 17C1 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 17C7 89 85 FFFFFF78              MOV DWORD PTR FFFFFF78[EBP], EAX

; 1261: 		    old2=j=dummy[nrt+1];

00008: 17CD 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 17D3 42                          INC EDX
00008: 17D4 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 17DA DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 17DD D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 17E0 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 17E3 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 17E7 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 17EA DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 17ED 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 17F0 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 17F3 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 17F6 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX
00008: 17FC 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1802 89 85 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EAX

; 1262:                     new1=dummy[nrt+2];

00008: 1808 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 180E 83 C2 02                    ADD EDX, 00000002
00008: 1811 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1817 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 181A D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 181D 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1820 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1824 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1827 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 182A 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 182D D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1830 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1833 89 55 FFFFFF80              MOV DWORD PTR FFFFFF80[EBP], EDX

; 1263:                     new2=dummy[nrt+3];

00008: 1836 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 183C 83 C2 03                    ADD EDX, 00000003
00008: 183F 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1845 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 1848 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 184B 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 184E 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1852 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1855 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1858 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 185B D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 185E 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1861 89 55 FFFFFF84              MOV DWORD PTR FFFFFF84[EBP], EDX

; 1264:                     if(sam[old1].m!=sam[new1].m)return line_number;

00008: 1864 8B 55 FFFFFF80              MOV EDX, DWORD PTR FFFFFF80[EBP]
00008: 1867 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 186E 29 D6                       SUB ESI, EDX
00008: 1870 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 1873 8B 3D 00000000              MOV EDI, DWORD PTR _sam
00008: 1879 8B 95 FFFFFF78              MOV EDX, DWORD PTR FFFFFF78[EBP]
00008: 187F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 1886 29 D3                       SUB EBX, EDX
00008: 1888 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 188B 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 1891 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 1898 DD 84 F7 00000088           FLD QWORD PTR 00000088[EDI][ESI*8]
00006: 189F F1DF                        FCOMIP ST, ST(1), L007B
00007: 18A1 DD D8                       FSTP ST
00008: 18A3 7A 02                       JP L00D7
00008: 18A5 74 0D                       JE L007B
00008: 18A7                     L00D7:
00008: 18A7 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 18AC                             epilog 
00000: 18AC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 18AF 5F                          POP EDI
00000: 18B0 5E                          POP ESI
00000: 18B1 5B                          POP EBX
00000: 18B2 5D                          POP EBP
00000: 18B3 C3                          RETN 
00008: 18B4                     L007B:

; 1265:                     if(sam[old2].m!=sam[new2].m)return line_number;

00008: 18B4 8B 55 FFFFFF84              MOV EDX, DWORD PTR FFFFFF84[EBP]
00008: 18B7 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 18BE 29 D6                       SUB ESI, EDX
00008: 18C0 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 18C3 8B 3D 00000000              MOV EDI, DWORD PTR _sam
00008: 18C9 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 18CF 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 18D6 29 D3                       SUB EBX, EDX
00008: 18D8 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 18DB 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 18E1 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 18E8 DD 84 F7 00000088           FLD QWORD PTR 00000088[EDI][ESI*8]
00006: 18EF F1DF                        FCOMIP ST, ST(1), L007C
00007: 18F1 DD D8                       FSTP ST
00008: 18F3 7A 02                       JP L00D8
00008: 18F5 74 0D                       JE L007C
00008: 18F7                     L00D8:
00008: 18F7 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 18FC                             epilog 
00000: 18FC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 18FF 5F                          POP EDI
00000: 1900 5E                          POP ESI
00000: 1901 5B                          POP EBX
00000: 1902 5D                          POP EBP
00000: 1903 C3                          RETN 
00008: 1904                     L007C:

; 1266: 		    if(j>i){k=i;i=j;j=k;}

00008: 1904 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 190A 3B 85 FFFFFF20              CMP EAX, DWORD PTR FFFFFF20[EBP]
00008: 1910 7E 24                       JLE L007D
00008: 1912 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 1918 89 85 FFFFFF28              MOV DWORD PTR FFFFFF28[EBP], EAX
00008: 191E 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1924 89 85 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EAX
00008: 192A 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 1930 89 85 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EAX
00008: 1936                     L007D:

; 1269: 		    if((numword==5)||(numword==6))

00008: 1936 83 BD FFFFFF4405            CMP DWORD PTR FFFFFF44[EBP], 00000005
00008: 193D 74 0D                       JE L007E
00008: 193F 83 BD FFFFFF4406            CMP DWORD PTR FFFFFF44[EBP], 00000006
00008: 1946 0F 85 00000193              JNE L007F
00008: 194C                     L007E:

; 1271: 			if((!coldata[i][j])||((coldata[i][j])&&(coldata[i][j][0]==3)))

00008: 194C 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1952 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1958 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 195B 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1961 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 1965 74 4F                       JE L0080
00008: 1967 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 196D 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1973 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1976 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 197C 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 1980 0F 84 000000B6              JE L0081
00008: 1986 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 198C 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1992 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1995 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 199B 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 199E DD 05 00000000              FLD QWORD PTR .data+00000088
00007: 19A4 DD 02                       FLD QWORD PTR 00000000[EDX]
00006: 19A6 F1DF                        FCOMIP ST, ST(1), L0081
00007: 19A8 DD D8                       FSTP ST
00008: 19AA 0F 8A 0000008C              JP L0081
00008: 19B0 0F 85 00000086              JNE L0081
00008: 19B6                     L0080:

; 1273: 			    dummy[nrt+6]=0;

00008: 19B6 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 19BC 83 C2 06                    ADD EDX, 00000006
00008: 19BF 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 19C5 C7 44 D0 04 00000000        MOV DWORD PTR 00000004[EAX][EDX*8], 00000000
00008: 19CD 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 19D3 C7 04 D0 00000000           MOV DWORD PTR 00000000[EAX][EDX*8], 00000000

; 1274: 			    if(numword==5)dummy[nrt+5]=sam[i].b+sam[j].b;

00008: 19DA 83 BD FFFFFF4405            CMP DWORD PTR FFFFFF44[EBP], 00000005
00008: 19E1 0F 85 000000F8              JNE L0082
00008: 19E7 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 19ED 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 19F4 29 D6                       SUB ESI, EDX
00008: 19F6 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 19F9 8B 3D 00000000              MOV EDI, DWORD PTR _sam
00008: 19FF 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 1A05 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 1A0C 29 D3                       SUB EBX, EDX
00008: 1A0E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 1A11 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 1A17 DD 84 DA 00000090           FLD QWORD PTR 00000090[EDX][EBX*8]
00007: 1A1E DC 84 F7 00000090           FADD QWORD PTR 00000090[EDI][ESI*8]
00007: 1A25 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00007: 1A2B 83 C2 05                    ADD EDX, 00000005
00007: 1A2E 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 1A34 DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]

; 1275: 			  }

00008: 1A37 E9 000000A3                 JMP L0082
00008: 1A3C                     L0081:

; 1278: 			    int k=coldata[i][j][0];

00008: 1A3C 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1A42 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1A48 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1A4B 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1A51 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 1A54 DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 1A56 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1A59 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1A5C 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1A60 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1A63 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1A66 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1A69 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1A6C 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 1A6F 89 55 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EDX

; 1279: 			    dummy[nrt+6]=coldata[i][j][k-1];

00008: 1A72 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1A78 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1A7E 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 1A81 8B 5D FFFFFF88              MOV EBX, DWORD PTR FFFFFF88[EBP]
00008: 1A84 4B                          DEC EBX
00008: 1A85 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1A8B 8B 34 86                    MOV ESI, DWORD PTR 00000000[ESI][EAX*4]
00008: 1A8E 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1A94 83 C2 06                    ADD EDX, 00000006
00008: 1A97 DD 04 DE                    FLD QWORD PTR 00000000[ESI][EBX*8]
00007: 1A9A 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 1AA0 DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]

; 1280: 			    if(numword==5)dummy[nrt+5]=coldata[i][j][k-2];

00008: 1AA3 83 BD FFFFFF4405            CMP DWORD PTR FFFFFF44[EBP], 00000005
00008: 1AAA 75 33                       JNE L0083
00008: 1AAC 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1AB2 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1AB8 8B 34 88                    MOV ESI, DWORD PTR 00000000[EAX][ECX*4]
00008: 1ABB 8B 5D FFFFFF88              MOV EBX, DWORD PTR FFFFFF88[EBP]
00008: 1ABE 83 C3 FFFFFFFE              ADD EBX, FFFFFFFE
00008: 1AC1 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1AC7 8B 34 86                    MOV ESI, DWORD PTR 00000000[ESI][EAX*4]
00008: 1ACA 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1AD0 83 C2 05                    ADD EDX, 00000005
00008: 1AD3 DD 04 DE                    FLD QWORD PTR 00000000[ESI][EBX*8]
00007: 1AD6 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 1ADC DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]
00008: 1ADF                     L0083:

; 1281: 			  }

00008: 1ADF                     L0082:

; 1282: 		      }

00008: 1ADF                     L007F:

; 1283: 		    if(numword>=6)

00008: 1ADF 83 BD FFFFFF4406            CMP DWORD PTR FFFFFF44[EBP], 00000006
00008: 1AE6 0F 8C 000000C2              JL L0084

; 1287: 			if(coldata[i][j])

00008: 1AEC 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1AF2 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1AF8 8B 14 88                    MOV EDX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1AFB 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1B01 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 1B05 74 42                       JE L0085

; 1289: 			    if(dummy[nrt+5]<=coldata[i][j][1])return line_number;

00008: 1B07 8B 35 00000000              MOV ESI, DWORD PTR _nrt
00008: 1B0D 83 C6 05                    ADD ESI, 00000005
00008: 1B10 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 1B16 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 1B1C 8B 1C 88                    MOV EBX, DWORD PTR 00000000[EAX][ECX*4]
00008: 1B1F 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1B25 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 1B28 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1B2E DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 1B31 DD 42 08                    FLD QWORD PTR 00000008[EDX]
00006: 1B34 F1DF                        FCOMIP ST, ST(1), L0086
00007: 1B36 DD D8                       FSTP ST
00008: 1B38 7A 74                       JP L0086
00008: 1B3A 72 72                       JB L0086
00008: 1B3C A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1B41                             epilog 
00000: 1B41 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1B44 5F                          POP EDI
00000: 1B45 5E                          POP ESI
00000: 1B46 5B                          POP EBX
00000: 1B47 5D                          POP EBP
00000: 1B48 C3                          RETN 
00008: 1B49                     L0085:

; 1291: 			else if(dummy[nrt+5]<=sam[i].s+sam[j].s)return line_number;

00008: 1B49 8B 3D 00000000              MOV EDI, DWORD PTR _nrt
00008: 1B4F 83 C7 05                    ADD EDI, 00000005
00008: 1B52 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 1B58 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 1B5F 29 D6                       SUB ESI, EDX
00008: 1B61 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 1B64 8B 0D 00000000              MOV ECX, DWORD PTR _sam
00008: 1B6A 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 1B70 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 1B77 29 D3                       SUB EBX, EDX
00008: 1B79 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 1B7C 8B 15 00000000              MOV EDX, DWORD PTR _sam
00008: 1B82 DD 84 DA 00000098           FLD QWORD PTR 00000098[EDX][EBX*8]
00007: 1B89 DC 84 F1 00000098           FADD QWORD PTR 00000098[ECX][ESI*8]
00007: 1B90 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 1B96 DD 04 F8                    FLD QWORD PTR 00000000[EAX][EDI*8]
00006: 1B99 F1DF                        FCOMIP ST, ST(1), L0087
00007: 1B9B DD D8                       FSTP ST
00008: 1B9D 7A 0F                       JP L0087
00008: 1B9F 77 0D                       JA L0087
00008: 1BA1 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1BA6                             epilog 
00000: 1BA6 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1BA9 5F                          POP EDI
00000: 1BAA 5E                          POP ESI
00000: 1BAB 5B                          POP EBX
00000: 1BAC 5D                          POP EBP
00000: 1BAD C3                          RETN 
00008: 1BAE                     L0087:
00008: 1BAE                     L0086:

; 1292: 		      }

00008: 1BAE                     L0084:

; 1293: 		    nrt+=7;

00008: 1BAE 83 05 00000000 07           ADD DWORD PTR _nrt, 00000007

; 1294: 		  }

00008: 1BB5                     L0071:

; 1295: 	      }while(!next_key);

00008: 1BB5 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 1BBC 0F 84 FFFFFA22              JE L006E

; 1296: 	    nrt/=7;

00008: 1BC2 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1BC8 B8 92492493                 MOV EAX, 92492493
00008: 1BCD 89 D1                       MOV ECX, EDX
00008: 1BCF F7 EA                       IMUL EDX
00008: 1BD1 01 CA                       ADD EDX, ECX
00008: 1BD3 C1 E9 1F                    SHR ECX, 0000001F
00008: 1BD6 C1 FA 02                    SAR EDX, 00000002
00008: 1BD9 01 D1                       ADD ECX, EDX
00008: 1BDB 89 0D 00000000              MOV DWORD PTR _nrt, ECX

; 1297: 	    react1=(ReactionData *)malloc((nrt+1)*sizeof(ReactionData));

00008: 1BE1 8B 15 00000000              MOV EDX, DWORD PTR _nrt
00008: 1BE7 42                          INC EDX
00008: 1BE8 6B D2 28                    IMUL EDX, EDX, 00000028
00008: 1BEB 52                          PUSH EDX
00008: 1BEC E8 00000000                 CALL SHORT _malloc
00008: 1BF1 59                          POP ECX
00008: 1BF2 89 85 FFFFFF74              MOV DWORD PTR FFFFFF74[EBP], EAX

; 1298: 	    if(!react1){StopAlert (MEMORY_ALRT);return line_number;}      

00008: 1BF8 83 BD FFFFFF7400            CMP DWORD PTR FFFFFF74[EBP], 00000000
00008: 1BFF 75 15                       JNE L0088
00008: 1C01 6A 02                       PUSH 00000002
00008: 1C03 E8 00000000                 CALL SHORT _StopAlert
00008: 1C08 59                          POP ECX
00008: 1C09 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1C0E                             epilog 
00000: 1C0E 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1C11 5F                          POP EDI
00000: 1C12 5E                          POP ESI
00000: 1C13 5B                          POP EBX
00000: 1C14 5D                          POP EBP
00000: 1C15 C3                          RETN 
00008: 1C16                     L0088:

; 1299: 	    for (i=1;i<=nrt;i++)

00008: 1C16 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 1C20 E9 0000037C                 JMP L0089
00008: 1C25                     L008A:

; 1301: 		react1[i].old1=dummy[(i-1)*7];

00008: 1C25 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 1C2B 4A                          DEC EDX
00008: 1C2C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 1C33 29 D3                       SUB EBX, EDX
00008: 1C35 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1C3B DD 04 D8                    FLD QWORD PTR 00000000[EAX][EBX*8]
00007: 1C3E D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1C41 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1C44 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1C48 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1C4B DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1C4E 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1C51 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1C54 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 1C57 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1C5D 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1C60 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1C66 66 89 74 D8 10              MOV WORD PTR 00000010[EAX][EBX*8], SI

; 1302: 		react1[i].old2=dummy[(i-1)*7+1];

00008: 1C6B 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1C71 4B                          DEC EBX
00008: 1C72 8D 14 DD 00000000           LEA EDX, [00000000][EBX*8]
00008: 1C79 29 DA                       SUB EDX, EBX
00008: 1C7B 42                          INC EDX
00008: 1C7C 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1C82 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 1C85 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1C88 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1C8B 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1C8F D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1C92 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1C95 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1C98 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1C9B 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 1C9E 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1CA4 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1CA7 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1CAD 66 89 74 D8 12              MOV WORD PTR 00000012[EAX][EBX*8], SI

; 1303: 		react1[i].new1=dummy[(i-1)*7+2];

00008: 1CB2 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1CB8 4B                          DEC EBX
00008: 1CB9 8D 14 DD 00000000           LEA EDX, [00000000][EBX*8]
00008: 1CC0 29 DA                       SUB EDX, EBX
00008: 1CC2 83 C2 02                    ADD EDX, 00000002
00008: 1CC5 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1CCB DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 1CCE D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1CD1 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1CD4 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1CD8 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1CDB DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1CDE 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1CE1 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1CE4 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 1CE7 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1CED 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1CF0 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1CF6 66 89 74 D8 14              MOV WORD PTR 00000014[EAX][EBX*8], SI

; 1304: 		react1[i].new2=dummy[(i-1)*7+3];

00008: 1CFB 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1D01 4B                          DEC EBX
00008: 1D02 8D 14 DD 00000000           LEA EDX, [00000000][EBX*8]
00008: 1D09 29 DA                       SUB EDX, EBX
00008: 1D0B 83 C2 03                    ADD EDX, 00000003
00008: 1D0E 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1D14 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 1D17 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1D1A 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1D1D 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1D21 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1D24 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1D27 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1D2A D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1D2D 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 1D30 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1D36 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1D39 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1D3F 66 89 74 D8 16              MOV WORD PTR 00000016[EAX][EBX*8], SI

; 1305: 		for(j=1;j<i;j++)

00008: 1D44 C7 85 FFFFFF2400000001      MOV DWORD PTR FFFFFF24[EBP], 00000001
00008: 1D4E E9 000000FE                 JMP L008B
00008: 1D53                     L008C:

; 1306: 		  if(((react1[j].old1==react1[i].old1)&&(react1[j].old2==react1[i].old2))

00008: 1D53 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 1D59 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 1D5C 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1D62 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1D65 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1D6B 66 8B 5C D8 10              MOV BX, WORD PTR 00000010[EAX][EBX*8]
00008: 1D70 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1D76 66 8B 54 F0 10              MOV DX, WORD PTR 00000010[EAX][ESI*8]
00008: 1D7B 66 39 D3                    CMP BX, DX
00008: 1D7E 75 2D                       JNE L008D
00008: 1D80 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 1D86 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 1D89 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1D8F 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1D92 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1D98 66 8B 5C D8 12              MOV BX, WORD PTR 00000012[EAX][EBX*8]
00008: 1D9D 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1DA3 66 8B 54 F0 12              MOV DX, WORD PTR 00000012[EAX][ESI*8]
00008: 1DA8 66 39 D3                    CMP BX, DX
00008: 1DAB 74 5A                       JE L008E
00008: 1DAD                     L008D:
00008: 1DAD 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 1DB3 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 1DB6 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1DBC 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1DBF 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1DC5 66 8B 5C D8 10              MOV BX, WORD PTR 00000010[EAX][EBX*8]
00008: 1DCA 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1DD0 66 8B 54 F0 12              MOV DX, WORD PTR 00000012[EAX][ESI*8]
00008: 1DD5 66 39 D3                    CMP BX, DX
00008: 1DD8 75 71                       JNE L008F
00008: 1DDA 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 1DE0 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 1DE3 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1DE9 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1DEC 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1DF2 66 8B 5C D8 12              MOV BX, WORD PTR 00000012[EAX][EBX*8]
00008: 1DF7 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1DFD 66 8B 54 F0 10              MOV DX, WORD PTR 00000010[EAX][ESI*8]
00008: 1E02 66 39 D3                    CMP BX, DX
00008: 1E05 75 44                       JNE L008F
00008: 1E07                     L008E:

; 1309: 		      printf("Multiple Definition of Reaction %d+%d->\n",react1[j].old1,react1[j].old2);

00008: 1E07 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1E0D 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1E10 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1E16 0F BF 44 D8 12              MOVSX EAX, WORD PTR 00000012[EAX][EBX*8]
00008: 1E1B 50                          PUSH EAX
00008: 1E1C 8B 9D FFFFFF24              MOV EBX, DWORD PTR FFFFFF24[EBP]
00008: 1E22 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1E25 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1E2B 0F BF 44 D8 10              MOVSX EAX, WORD PTR 00000010[EAX][EBX*8]
00008: 1E30 50                          PUSH EAX
00008: 1E31 68 00000000                 PUSH OFFSET @1306
00008: 1E36 E8 00000000                 CALL SHORT _printf
00008: 1E3B 83 C4 0C                    ADD ESP, 0000000C

; 1310: 		      return line_number;

00008: 1E3E A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 1E43                             epilog 
00000: 1E43 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1E46 5F                          POP EDI
00000: 1E47 5E                          POP ESI
00000: 1E48 5B                          POP EBX
00000: 1E49 5D                          POP EBP
00000: 1E4A C3                          RETN 
00008: 1E4B                     L008F:
00008: 1E4B FF 85 FFFFFF24              INC DWORD PTR FFFFFF24[EBP]
00008: 1E51                     L008B:
00008: 1E51 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 1E57 3B 85 FFFFFF20              CMP EAX, DWORD PTR FFFFFF20[EBP]
00008: 1E5D 0F 8C FFFFFEF0              JL L008C

; 1312: 		react1[i].bond=dummy[(i-1)*7+4];

00008: 1E63 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1E69 4B                          DEC EBX
00008: 1E6A 8D 14 DD 00000000           LEA EDX, [00000000][EBX*8]
00008: 1E71 29 DA                       SUB EDX, EBX
00008: 1E73 83 C2 04                    ADD EDX, 00000004
00008: 1E76 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1E7C DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 1E7F D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 1E82 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 1E85 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 1E89 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 1E8C DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 1E8F 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 1E92 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 1E95 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 1E98 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1E9E 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1EA1 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1EA7 66 89 74 D8 18              MOV WORD PTR 00000018[EAX][EBX*8], SI

; 1313: 		react1[i].dd=dummy[(i-1)*7+5];

00008: 1EAC 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 1EB2 4A                          DEC EDX
00008: 1EB3 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 1EBA 29 D6                       SUB ESI, EDX
00008: 1EBC 83 C6 05                    ADD ESI, 00000005
00008: 1EBF 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1EC5 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1EC8 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1ECE DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 1ED1 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 1ED7 DD 5C D8 08                 FSTP QWORD PTR 00000008[EAX][EBX*8]

; 1314:                 if(maxrb<react1[i].dd)maxrb=react1[i].dd;

00008: 1EDB 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1EE1 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1EE4 DD 45 FFFFFF9C              FLD QWORD PTR FFFFFF9C[EBP]
00007: 1EE7 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 1EED DD 44 D8 08                 FLD QWORD PTR 00000008[EAX][EBX*8]
00006: 1EF1 F1DF                        FCOMIP ST, ST(1), L0090
00007: 1EF3 DD D8                       FSTP ST
00008: 1EF5 7A 18                       JP L0090
00008: 1EF7 76 16                       JBE L0090
00008: 1EF9 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1EFF 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1F02 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1F08 DD 44 D8 08                 FLD QWORD PTR 00000008[EAX][EBX*8]
00007: 1F0C DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]
00008: 1F0F                     L0090:

; 1315: 		react1[i].dd*=react1[i].dd;

00008: 1F0F 8B B5 FFFFFF20              MOV ESI, DWORD PTR FFFFFF20[EBP]
00008: 1F15 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 1F18 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1F1E 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1F21 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1F27 DD 44 D8 08                 FLD QWORD PTR 00000008[EAX][EBX*8]
00007: 1F2B 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 1F31 DC 4C F0 08                 FMUL QWORD PTR 00000008[EAX][ESI*8]
00007: 1F35 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 1F3B DD 5C D8 08                 FSTP QWORD PTR 00000008[EAX][EBX*8]

; 1316: 		react1[i].eo=dummy[(i-1)*7+6];

00008: 1F3F 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 1F45 4A                          DEC EDX
00008: 1F46 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 1F4D 29 D6                       SUB ESI, EDX
00008: 1F4F 83 C6 06                    ADD ESI, 00000006
00008: 1F52 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1F58 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1F5B 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 1F61 DD 04 F0                    FLD QWORD PTR 00000000[EAX][ESI*8]
00007: 1F64 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 1F6A DD 1C D8                    FSTP QWORD PTR 00000000[EAX][EBX*8]

; 1317:                 react1[i].in=-1;

00008: 1F6D 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1F73 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1F76 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1F7C C7 44 D8 1C FFFFFFFF        MOV DWORD PTR 0000001C[EAX][EBX*8], FFFFFFFF

; 1318:                 react1[i].out =-1;

00008: 1F84 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1F8A 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1F8D 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1F93 C7 44 D8 20 FFFFFFFF        MOV DWORD PTR 00000020[EAX][EBX*8], FFFFFFFF

; 1319: 	      }

00008: 1F9B FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 1FA1                     L0089:
00008: 1FA1 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 1FA7 3B 05 00000000              CMP EAX, DWORD PTR _nrt
00008: 1FAD 0F 8E FFFFFC72              JLE L008A

; 1320: 	    for (i=1;i<=nrt;i++)

00008: 1FB3 C7 85 FFFFFF2000000001      MOV DWORD PTR FFFFFF20[EBP], 00000001
00008: 1FBD E9 000000B5                 JMP L0091
00008: 1FC2                     L0092:

; 1321: 	      printf("%d %d %d %d %d %lf %lf\n",react1[i].old1,react1[i].old2,

00008: 1FC2 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1FC8 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1FCB 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1FD1 FF 74 D8 04                 PUSH DWORD PTR 00000004[EAX][EBX*8]
00008: 1FD5 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1FDB FF 34 D8                    PUSH DWORD PTR 00000000[EAX][EBX*8]
00008: 1FDE 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 1FE4 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 1FE7 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1FED FF 74 D8 0C                 PUSH DWORD PTR 0000000C[EAX][EBX*8]
00008: 1FF1 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 1FF7 FF 74 D8 08                 PUSH DWORD PTR 00000008[EAX][EBX*8]
00008: 1FFB 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 2001 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 2004 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 200A 0F BF 44 D8 18              MOVSX EAX, WORD PTR 00000018[EAX][EBX*8]
00008: 200F 50                          PUSH EAX
00008: 2010 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 2016 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 2019 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 201F 0F BF 44 D8 16              MOVSX EAX, WORD PTR 00000016[EAX][EBX*8]
00008: 2024 50                          PUSH EAX
00008: 2025 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 202B 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 202E 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 2034 0F BF 44 D8 14              MOVSX EAX, WORD PTR 00000014[EAX][EBX*8]
00008: 2039 50                          PUSH EAX
00008: 203A 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 2040 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 2043 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 2049 0F BF 44 D8 12              MOVSX EAX, WORD PTR 00000012[EAX][EBX*8]
00008: 204E 50                          PUSH EAX
00008: 204F 8B 9D FFFFFF20              MOV EBX, DWORD PTR FFFFFF20[EBP]
00008: 2055 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 2058 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 205E 0F BF 44 D8 10              MOVSX EAX, WORD PTR 00000010[EAX][EBX*8]
00008: 2063 50                          PUSH EAX
00008: 2064 68 00000000                 PUSH OFFSET @141
00008: 2069 E8 00000000                 CALL SHORT _printf
00008: 206E 83 C4 28                    ADD ESP, 00000028
00008: 2071 FF 85 FFFFFF20              INC DWORD PTR FFFFFF20[EBP]
00008: 2077                     L0091:
00008: 2077 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 207D 3B 05 00000000              CMP EAX, DWORD PTR _nrt
00008: 2083 0F 8E FFFFFF39              JLE L0092

; 1324: 	    current_key=next_key;

00008: 2089 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 208F 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1325:             break;

00008: 2095 E9 00000AF3                 JMP L0011
00008: 209A                     L0093:

; 1330: 	    int na=0;

00008: 209A C7 45 FFFFFF8C 00000000     MOV DWORD PTR FFFFFF8C[EBP], 00000000

; 1331: 	    printf("%s\n",keywords[current_key]);

00008: 20A1 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 20A7 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 20AD 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 20B0 50                          PUSH EAX
00008: 20B1 68 00000000                 PUSH OFFSET @1301
00008: 20B6 E8 00000000                 CALL SHORT _printf
00008: 20BB 59                          POP ECX
00008: 20BC 59                          POP ECX

; 1332: 	    set_new_bounds(L,maxrb,ndim);

00008: 20BD FF B5 FFFFFF2C              PUSH DWORD PTR FFFFFF2C[EBP]
00008: 20C3 FF 75 FFFFFFA0              PUSH DWORD PTR FFFFFFA0[EBP]
00008: 20C6 FF 75 FFFFFF9C              PUSH DWORD PTR FFFFFF9C[EBP]
00008: 20C9 8D 45 FFFFFFC4              LEA EAX, DWORD PTR FFFFFFC4[EBP]
00008: 20CC 50                          PUSH EAX
00008: 20CD E8 00000000                 CALL SHORT _set_new_bounds
00008: 20D2 83 C4 10                    ADD ESP, 00000010

; 1333: 	    dummy=top;

00008: 20D5 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 20DB 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 1334:             do

00008: 20E1                     L0094:

; 1337:                 int nd=3;

00008: 20E1 C7 45 FFFFFF90 00000003     MOV DWORD PTR FFFFFF90[EBP], 00000003

; 1340: 		numword=0;

00008: 20E8 C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1341: 		if(!nextline)

00008: 20F2 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 20F9 75 1C                       JNE L0095

; 1342: 		  {if(na==n1)goto finish;

00008: 20FB 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 20FE 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 2104 0F 84 00000A90              JE L0096

; 1343: 		  else return line_number;}

00008: 210A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 210F                             epilog 
00000: 210F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2112 5F                          POP EDI
00000: 2113 5E                          POP ESI
00000: 2114 5B                          POP EBX
00000: 2115 5D                          POP EBP
00000: 2116 C3                          RETN 
00008: 2117                     L0095:

; 1345: 		datfile=nextline;

00008: 2117 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 211D 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1346: 		nextline=next_line(datfile);

00008: 2123 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2129 E8 00000000                 CALL SHORT _next_line
00008: 212E 59                          POP ECX
00008: 212F 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1347: if(line_number==278)

00008: 2135 81 3D 00000000 00000116     CMP DWORD PTR _line_number, 00000116
00008: 213F 75 0B                       JNE L0097

; 1348: printf("at 278\n");

00008: 2141 68 00000000                 PUSH OFFSET @1307
00008: 2146 E8 00000000                 CALL SHORT _printf
00008: 214B 59                          POP ECX
00008: 214C                     L0097:

; 1349: 		next_key=iskeyword(datfile);

00008: 214C FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2152 E8 00000000                 CALL SHORT _iskeyword
00008: 2157 59                          POP ECX
00008: 2158 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1350: 		if(next_key<0)return line_number;

00008: 215E 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2165 7D 0D                       JGE L0098
00008: 2167 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 216C                             epilog 
00000: 216C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 216F 5F                          POP EDI
00000: 2170 5E                          POP ESI
00000: 2171 5B                          POP EBX
00000: 2172 5D                          POP EBP
00000: 2173 C3                          RETN 
00008: 2174                     L0098:

; 1351:                 if((next_key>0)&&(n1!=na))return line_number;

00008: 2174 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 217B 7E 18                       JLE L0099
00008: 217D 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 2180 39 05 00000000              CMP DWORD PTR _n1, EAX
00008: 2186 74 0D                       JE L0099
00008: 2188 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 218D                             epilog 
00000: 218D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2190 5F                          POP EDI
00000: 2191 5E                          POP ESI
00000: 2192 5B                          POP EBX
00000: 2193 5D                          POP EBP
00000: 2194 C3                          RETN 
00008: 2195                     L0099:

; 1352:                 if(!next_key)

00008: 2195 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 219C 0F 85 00000407              JNE L009A

; 1355:                     if(na==n1)return line_number;

00008: 21A2 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 21A5 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 21AB 75 0D                       JNE L009B
00008: 21AD A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 21B2                             epilog 
00000: 21B2 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 21B5 5F                          POP EDI
00000: 21B6 5E                          POP ESI
00000: 21B7 5B                          POP EBX
00000: 21B8 5D                          POP EBP
00000: 21B9 C3                          RETN 
00008: 21BA                     L009B:

; 1356: 		    numword=0;

00008: 21BA C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1357: 		    while(is_word(datfile))

00008: 21C4 EB 48                       JMP L009C
00008: 21C6                     L009D:

; 1359: 			sscanf(datfile,"%lf",dummy+numword);

00008: 21C6 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 21CC 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 21D3 03 95 FFFFFF60              ADD EDX, DWORD PTR FFFFFF60[EBP]
00008: 21D9 52                          PUSH EDX
00008: 21DA 68 00000000                 PUSH OFFSET @1302
00008: 21DF FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 21E5 E8 00000000                 CALL SHORT _sscanf
00008: 21EA 83 C4 0C                    ADD ESP, 0000000C

; 1360: 			numword++;

00008: 21ED FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1361: 			if(!(datfile=next_word(datfile)))break;

00008: 21F3 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 21F9 E8 00000000                 CALL SHORT _next_word
00008: 21FE 59                          POP ECX
00008: 21FF 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 2205 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 220C 74 11                       JE L009E

; 1362: 		      }

00008: 220E                     L009C:
00008: 220E FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2214 E8 00000000                 CALL SHORT _is_word
00008: 2219 59                          POP ECX
00008: 221A 83 F8 00                    CMP EAX, 00000000
00008: 221D 75 FFFFFFA7                 JNE L009D
00008: 221F                     L009E:

; 1363: 		    if(!(((numword==6)&&(ndim==2))||(numword==8)))return line_number;

00008: 221F 83 BD FFFFFF4406            CMP DWORD PTR FFFFFF44[EBP], 00000006
00008: 2226 75 09                       JNE L009F
00008: 2228 83 BD FFFFFF2C02            CMP DWORD PTR FFFFFF2C[EBP], 00000002
00008: 222F 74 16                       JE L00A0
00008: 2231                     L009F:
00008: 2231 83 BD FFFFFF4408            CMP DWORD PTR FFFFFF44[EBP], 00000008
00008: 2238 74 0D                       JE L00A0
00008: 223A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 223F                             epilog 
00000: 223F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2242 5F                          POP EDI
00000: 2243 5E                          POP ESI
00000: 2244 5B                          POP EBX
00000: 2245 5D                          POP EBP
00000: 2246 C3                          RETN 
00008: 2247                     L00A0:

; 1364:                     i=dummy[0];

00008: 2247 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 224D DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 224F D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 2252 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 2255 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 2259 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 225C DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 225F 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 2262 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 2265 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 2268 89 95 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EDX

; 1365: 		    if(dummy[0]!=i)return line_number;

00008: 226E 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 2274 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 2277 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 227A 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 2280 DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 2282 F1DF                        FCOMIP ST, ST(1), L00A1
00007: 2284 DD D8                       FSTP ST
00008: 2286 7A 02                       JP L00D9
00008: 2288 74 0D                       JE L00A1
00008: 228A                     L00D9:
00008: 228A A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 228F                             epilog 
00000: 228F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2292 5F                          POP EDI
00000: 2293 5E                          POP ESI
00000: 2294 5B                          POP EBX
00000: 2295 5D                          POP EBP
00000: 2296 C3                          RETN 
00008: 2297                     L00A1:

; 1366:                     j=dummy[1];

00008: 2297 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 229D DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 22A0 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 22A3 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 22A6 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 22AA D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 22AD DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 22B0 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 22B3 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 22B6 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 22B9 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX

; 1367: 		    if(dummy[1]!=j)return line_number;

00008: 22BF 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 22C5 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 22C8 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 22CB 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 22D1 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00006: 22D4 F1DF                        FCOMIP ST, ST(1), L00A2
00007: 22D6 DD D8                       FSTP ST
00008: 22D8 7A 02                       JP L00DA
00008: 22DA 74 0D                       JE L00A2
00008: 22DC                     L00DA:
00008: 22DC A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 22E1                             epilog 
00000: 22E1 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 22E4 5F                          POP EDI
00000: 22E5 5E                          POP ESI
00000: 22E6 5B                          POP EBX
00000: 22E7 5D                          POP EBP
00000: 22E8 C3                          RETN 
00008: 22E9                     L00A2:

; 1368:                     i--;

00008: 22E9 FF 8D FFFFFF20              DEC DWORD PTR FFFFFF20[EBP]

; 1369: 		    if((i<0)||(i>=n1)||a[i].c)return line_number;

00008: 22EF 83 BD FFFFFF2000            CMP DWORD PTR FFFFFF20[EBP], 00000000
00008: 22F6 7C 31                       JL L00A3
00008: 22F8 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 22FE 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 2304 7D 23                       JGE L00A3
00008: 2306 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 230C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 2313 29 D3                       SUB EBX, EDX
00008: 2315 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 2318 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 231E 66 83 BC DA 000000A400      CMP WORD PTR 000000A4[EDX][EBX*8], 0000
00008: 2327 74 0D                       JE L00A4
00008: 2329                     L00A3:
00008: 2329 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 232E                             epilog 
00000: 232E 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2331 5F                          POP EDI
00000: 2332 5E                          POP ESI
00000: 2333 5B                          POP EBX
00000: 2334 5D                          POP EBP
00000: 2335 C3                          RETN 
00008: 2336                     L00A4:

; 1370: 		    if((j<1)||(j>nat))return line_number;

00008: 2336 83 BD FFFFFF2401            CMP DWORD PTR FFFFFF24[EBP], 00000001
00008: 233D 7C 0E                       JL L00A5
00008: 233F 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 2345 3B 05 00000000              CMP EAX, DWORD PTR _nat
00008: 234B 7E 0D                       JLE L00A6
00008: 234D                     L00A5:
00008: 234D A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2352                             epilog 
00000: 2352 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2355 5F                          POP EDI
00000: 2356 5E                          POP ESI
00000: 2357 5B                          POP EBX
00000: 2358 5D                          POP EBP
00000: 2359 C3                          RETN 
00008: 235A                     L00A6:

; 1371:                     a[i]=sam[j];

00008: 235A 8B 95 FFFFFF24              MOV EDX, DWORD PTR FFFFFF24[EBP]
00008: 2360 8D 04 D5 00000000           LEA EAX, [00000000][EDX*8]
00008: 2367 89 85 FFFFFF14              MOV DWORD PTR FFFFFF14[EBP], EAX
00008: 236D 29 95 FFFFFF14              SUB DWORD PTR FFFFFF14[EBP], EDX
00008: 2373 8B 95 FFFFFF14              MOV EDX, DWORD PTR FFFFFF14[EBP]
00008: 2379 8B 8D FFFFFF14              MOV ECX, DWORD PTR FFFFFF14[EBP]
00008: 237F 8D 04 51                    LEA EAX, DWORD PTR 00000000[ECX][EDX*2]
00008: 2382 89 85 FFFFFF14              MOV DWORD PTR FFFFFF14[EBP], EAX
00008: 2388 A1 00000000                 MOV EAX, DWORD PTR _sam
00008: 238D 89 85 FFFFFF10              MOV DWORD PTR FFFFFF10[EBP], EAX
00008: 2393 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 2399 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 23A0 29 D3                       SUB EBX, EDX
00008: 23A2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 23A5 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 23AB 8D 3C DA                    LEA EDI, DWORD PTR 00000000[EDX][EBX*8]
00008: 23AE 8B 8D FFFFFF14              MOV ECX, DWORD PTR FFFFFF14[EBP]
00008: 23B4 8B 85 FFFFFF10              MOV EAX, DWORD PTR FFFFFF10[EBP]
00008: 23BA 8D 34 C8                    LEA ESI, DWORD PTR 00000000[EAX][ECX*8]
00008: 23BD B9 0000002A                 MOV ECX, 0000002A
00008: 23C2 F3 A5                       REP MOVSD 

; 1372:                     a[i].c=j;

00008: 23C4 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 23CA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 23D1 29 D3                       SUB EBX, EDX
00008: 23D3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 23D6 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 23DC 66 8B 85 FFFFFF24           MOV AX, WORD PTR FFFFFF24[EBP]
00008: 23E3 66 89 84 DE 000000A4        MOV WORD PTR 000000A4[ESI][EBX*8], AX

; 1373:                     b=(iatom *)(a+i); 

00008: 23EB 8B 95 FFFFFF20              MOV EDX, DWORD PTR FFFFFF20[EBP]
00008: 23F1 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 23F7 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 23FD 89 55 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EDX

; 1374:                     if(numword==6)nd=2;

00008: 2400 83 BD FFFFFF4406            CMP DWORD PTR FFFFFF44[EBP], 00000006
00008: 2407 75 07                       JNE L00A7
00008: 2409 C7 45 FFFFFF90 00000002     MOV DWORD PTR FFFFFF90[EBP], 00000002
00008: 2410                     L00A7:

; 1375: 		    for(k=0;k<ndim;k++)

00008: 2410 C7 85 FFFFFF2800000000      MOV DWORD PTR FFFFFF28[EBP], 00000000
00008: 241A E9 00000178                 JMP L00A8
00008: 241F                     L00A9:

; 1377: 			b->r[k]=dummy[2+k]+coord_shift[k];

00008: 241F 8B 95 FFFFFF28              MOV EDX, DWORD PTR FFFFFF28[EBP]
00008: 2425 83 C2 02                    ADD EDX, 00000002
00008: 2428 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 242E DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 2431 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00007: 2437 DC 44 C5 FFFFFFDC           FADD QWORD PTR FFFFFFDC[EBP][EAX*8]
00007: 243B 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00007: 2441 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 2444 DD 1C C8                    FSTP QWORD PTR 00000000[EAX][ECX*8]

; 1378: 			if(b->r[k]>bound[k].length)b->r[k]-=bound[k].length;

00008: 2447 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 244D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 2450 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 2456 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 2459 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 245C DD 04 DD 00000000           FLD QWORD PTR _bound[EBX*8]
00006: 2463 F1DF                        FCOMIP ST, ST(1), L00AA
00007: 2465 DD D8                       FSTP ST
00008: 2467 7A 2A                       JP L00AA
00008: 2469 73 28                       JAE L00AA
00008: 246B 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 2471 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 2474 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 247A 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 247D DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 2480 DC 24 DD 00000000           FSUB QWORD PTR _bound[EBX*8]
00007: 2487 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00007: 248D 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 2490 DD 1C C8                    FSTP QWORD PTR 00000000[EAX][ECX*8]
00008: 2493                     L00AA:

; 1379: 			if(b->r[k]<0)b->r[k]+=bound[k].length;

00008: 2493 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 2499 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 249C DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 249F DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 24A5 F1DF                        FCOMIP ST, ST(1), L00AB
00007: 24A7 DD D8                       FSTP ST
00008: 24A9 7A 2A                       JP L00AB
00008: 24AB 76 28                       JBE L00AB
00008: 24AD 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 24B3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 24B6 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 24BC 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 24BF DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 24C2 DC 04 DD 00000000           FADD QWORD PTR _bound[EBX*8]
00007: 24C9 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00007: 24CF 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 24D2 DD 1C C8                    FSTP QWORD PTR 00000000[EAX][ECX*8]
00008: 24D5                     L00AB:

; 1380: 			if(b->r[k]>bound[k].length)return line_number;

00008: 24D5 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 24DB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 24DE 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 24E4 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 24E7 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 24EA DD 04 DD 00000000           FLD QWORD PTR _bound[EBX*8]
00006: 24F1 F1DF                        FCOMIP ST, ST(1), L00AC
00007: 24F3 DD D8                       FSTP ST
00008: 24F5 7A 0F                       JP L00AC
00008: 24F7 73 0D                       JAE L00AC
00008: 24F9 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 24FE                             epilog 
00000: 24FE 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2501 5F                          POP EDI
00000: 2502 5E                          POP ESI
00000: 2503 5B                          POP EBX
00000: 2504 5D                          POP EBP
00000: 2505 C3                          RETN 
00008: 2506                     L00AC:

; 1381: 			if(b->r[k]<0)return line_number;

00008: 2506 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 250C 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 250F DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 2512 DD 05 00000000              FLD QWORD PTR .data+00000230
00006: 2518 F1DF                        FCOMIP ST, ST(1), L00AD
00007: 251A DD D8                       FSTP ST
00008: 251C 7A 0F                       JP L00AD
00008: 251E 76 0D                       JBE L00AD
00008: 2520 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2525                             epilog 
00000: 2525 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2528 5F                          POP EDI
00000: 2529 5E                          POP ESI
00000: 252A 5B                          POP EBX
00000: 252B 5D                          POP EBP
00000: 252C C3                          RETN 
00008: 252D                     L00AD:

; 1382: 			b->i[k].i=(long)(b->r[k]/bound[k].dl);

00008: 252D 8B 9D FFFFFF28              MOV EBX, DWORD PTR FFFFFF28[EBP]
00008: 2533 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 2536 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 253C 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 253F DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 2542 DC 34 DD 00000008           FDIV QWORD PTR _bound+00000008[EBX*8]
00007: 2549 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 254C 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 254F 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 2553 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 2556 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 2559 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 255C D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 255F 8B 5D FFFFFFBC              MOV EBX, DWORD PTR FFFFFFBC[EBP]
00008: 2562 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 2568 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 256B 89 5C C8 30                 MOV DWORD PTR 00000030[EAX][ECX*8], EBX

; 1383: 			b->v[k]=dummy[2+nd+k];

00008: 256F 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 2572 83 C2 02                    ADD EDX, 00000002
00008: 2575 03 95 FFFFFF28              ADD EDX, DWORD PTR FFFFFF28[EBP]
00008: 257B 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 2581 DD 04 D0                    FLD QWORD PTR 00000000[EAX][EDX*8]
00007: 2584 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00007: 258A 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 258D DD 5C C8 18                 FSTP QWORD PTR 00000018[EAX][ECX*8]

; 1384: 		      }		    

00008: 2591 FF 85 FFFFFF28              INC DWORD PTR FFFFFF28[EBP]
00008: 2597                     L00A8:
00008: 2597 8B 85 FFFFFF28              MOV EAX, DWORD PTR FFFFFF28[EBP]
00008: 259D 3B 85 FFFFFF2C              CMP EAX, DWORD PTR FFFFFF2C[EBP]
00008: 25A3 0F 8C FFFFFE76              JL L00A9

; 1385: 		  }

00008: 25A9                     L009A:

; 1386: 		na++;

00008: 25A9 FF 45 FFFFFF8C              INC DWORD PTR FFFFFF8C[EBP]

; 1387: 	      }while(!next_key);

00008: 25AC 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 25B3 0F 84 FFFFFB28              JE L0094

; 1388: 	    current_key=next_key;

00008: 25B9 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 25BF 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1389: 	    break;

00008: 25C5 E9 000005C3                 JMP L0011
00008: 25CA                     L00AE:

; 1393: 	    printf("%s\n",keywords[current_key]);

00008: 25CA 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 25D0 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 25D6 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 25D9 50                          PUSH EAX
00008: 25DA 68 00000000                 PUSH OFFSET @1301
00008: 25DF E8 00000000                 CALL SHORT _printf
00008: 25E4 59                          POP ECX
00008: 25E5 59                          POP ECX

; 1394: 	    numbond=0;

00008: 25E6 C7 85 FFFFFF4800000000      MOV DWORD PTR FFFFFF48[EBP], 00000000

; 1395: 	    do

00008: 25F0                     L00AF:

; 1397: 		if(!nextline)goto finish;

00008: 25F0 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 25F7 0F 84 0000059D              JE L0096

; 1398: 		datfile=nextline;

00008: 25FD 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 2603 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1399: 		nextline=next_line(datfile);

00008: 2609 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 260F E8 00000000                 CALL SHORT _next_line
00008: 2614 59                          POP ECX
00008: 2615 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1400: 		next_key=iskeyword(datfile);

00008: 261B FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2621 E8 00000000                 CALL SHORT _iskeyword
00008: 2626 59                          POP ECX
00008: 2627 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1401: 		if(next_key<0)

00008: 262D 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2634 7D 0D                       JGE L00B0

; 1402: 		  return line_number;

00008: 2636 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 263B                             epilog 
00000: 263B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 263E 5F                          POP EDI
00000: 263F 5E                          POP ESI
00000: 2640 5B                          POP EBX
00000: 2641 5D                          POP EBP
00000: 2642 C3                          RETN 
00008: 2643                     L00B0:

; 1403:                 if(!next_key)

00008: 2643 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 264A 0F 85 000001FD              JNE L00B1

; 1405:                     double a=0;

00008: 2650 DD 05 00000000              FLD QWORD PTR .data+00000230
00007: 2656 DD 5D FFFFFFB4              FSTP QWORD PTR FFFFFFB4[EBP]

; 1406: 		    numword=0;

00008: 2659 C7 85 FFFFFF4400000000      MOV DWORD PTR FFFFFF44[EBP], 00000000

; 1408: 		    while(is_word(datfile))

00008: 2663 EB 48                       JMP L00B2
00008: 2665                     L00B3:

; 1410: 			sscanf(datfile,"%lf",top+numword);

00008: 2665 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 266B 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 2672 03 95 FFFFFF5C              ADD EDX, DWORD PTR FFFFFF5C[EBP]
00008: 2678 52                          PUSH EDX
00008: 2679 68 00000000                 PUSH OFFSET @1302
00008: 267E FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2684 E8 00000000                 CALL SHORT _sscanf
00008: 2689 83 C4 0C                    ADD ESP, 0000000C

; 1411: 			numword++;

00008: 268C FF 85 FFFFFF44              INC DWORD PTR FFFFFF44[EBP]

; 1412: 			if(!(datfile=next_word(datfile)))break;

00008: 2692 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2698 E8 00000000                 CALL SHORT _next_word
00008: 269D 59                          POP ECX
00008: 269E 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX
00008: 26A4 83 BD FFFFFF1800            CMP DWORD PTR FFFFFF18[EBP], 00000000
00008: 26AB 74 11                       JE L00B4

; 1413: 		      }

00008: 26AD                     L00B2:
00008: 26AD FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 26B3 E8 00000000                 CALL SHORT _is_word
00008: 26B8 59                          POP ECX
00008: 26B9 83 F8 00                    CMP EAX, 00000000
00008: 26BC 75 FFFFFFA7                 JNE L00B3
00008: 26BE                     L00B4:

; 1414: 		    if(numword<2)return line_number;

00008: 26BE 83 BD FFFFFF4402            CMP DWORD PTR FFFFFF44[EBP], 00000002
00008: 26C5 7D 0D                       JGE L00B5
00008: 26C7 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 26CC                             epilog 
00000: 26CC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 26CF 5F                          POP EDI
00000: 26D0 5E                          POP ESI
00000: 26D1 5B                          POP EBX
00000: 26D2 5D                          POP EBP
00000: 26D3 C3                          RETN 
00008: 26D4                     L00B5:

; 1415: 		    i=top[0];

00008: 26D4 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 26DA DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 26DC D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 26DF 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 26E2 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 26E6 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 26E9 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 26EC 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 26EF D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 26F2 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 26F5 89 95 FFFFFF20              MOV DWORD PTR FFFFFF20[EBP], EDX

; 1416: 		    if(i!=top[0])return line_number;

00008: 26FB 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 2701 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 2704 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 2707 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 270D DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 270F F1DF                        FCOMIP ST, ST(1), L00B6
00007: 2711 DD D8                       FSTP ST
00008: 2713 7A 02                       JP L00DB
00008: 2715 74 0D                       JE L00B6
00008: 2717                     L00DB:
00008: 2717 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 271C                             epilog 
00000: 271C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 271F 5F                          POP EDI
00000: 2720 5E                          POP ESI
00000: 2721 5B                          POP EBX
00000: 2722 5D                          POP EBP
00000: 2723 C3                          RETN 
00008: 2724                     L00B6:

; 1417: 		    for(k=numword-1;k>=1;k--)

00008: 2724 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 272A 4A                          DEC EDX
00008: 272B 89 95 FFFFFF28              MOV DWORD PTR FFFFFF28[EBP], EDX
00008: 2731 E9 000000EF                 JMP L00B7
00008: 2736                     L00B8:

; 1419: 			j=top[k];

00008: 2736 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00008: 273C 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 2742 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 2745 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 2748 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 274B 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 274F D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 2752 DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 2755 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 2758 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 275B 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 275E 89 95 FFFFFF24              MOV DWORD PTR FFFFFF24[EBP], EDX

; 1420: 			if(j!=top[k])return line_number;                  

00008: 2764 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 276A 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 276D DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 2770 8B 8D FFFFFF28              MOV ECX, DWORD PTR FFFFFF28[EBP]
00007: 2776 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 277C DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00006: 277F F1DF                        FCOMIP ST, ST(1), L00B9
00007: 2781 DD D8                       FSTP ST
00008: 2783 7A 02                       JP L00DC
00008: 2785 74 0D                       JE L00B9
00008: 2787                     L00DC:
00008: 2787 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 278C                             epilog 
00000: 278C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 278F 5F                          POP EDI
00000: 2790 5E                          POP ESI
00000: 2791 5B                          POP EBX
00000: 2792 5D                          POP EBP
00000: 2793 C3                          RETN 
00008: 2794                     L00B9:

; 1421: 			if((i<1)||(i>n1)||(j<1)||(j>n1))return line_number;

00008: 2794 83 BD FFFFFF2001            CMP DWORD PTR FFFFFF20[EBP], 00000001
00008: 279B 7C 25                       JL L00BA
00008: 279D 8B 85 FFFFFF20              MOV EAX, DWORD PTR FFFFFF20[EBP]
00008: 27A3 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 27A9 7F 17                       JG L00BA
00008: 27AB 83 BD FFFFFF2401            CMP DWORD PTR FFFFFF24[EBP], 00000001
00008: 27B2 7C 0E                       JL L00BA
00008: 27B4 8B 85 FFFFFF24              MOV EAX, DWORD PTR FFFFFF24[EBP]
00008: 27BA 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 27C0 7E 0D                       JLE L00BB
00008: 27C2                     L00BA:
00008: 27C2 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 27C7                             epilog 
00000: 27C7 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 27CA 5F                          POP EDI
00000: 27CB 5E                          POP ESI
00000: 27CC 5B                          POP EBX
00000: 27CD 5D                          POP EBP
00000: 27CE C3                          RETN 
00008: 27CF                     L00BB:

; 1422:                         top[2*k-2]=i-1;

00008: 27CF 8B 95 FFFFFF28              MOV EDX, DWORD PTR FFFFFF28[EBP]
00008: 27D5 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 27DC 83 C2 FFFFFFFE              ADD EDX, FFFFFFFE
00008: 27DF 8B 8D FFFFFF20              MOV ECX, DWORD PTR FFFFFF20[EBP]
00008: 27E5 49                          DEC ECX
00008: 27E6 89 4D FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], ECX
00008: 27E9 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 27EC 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 27F2 DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]

; 1423: 			top[2*k-1]=j-1;

00008: 27F5 8B 95 FFFFFF28              MOV EDX, DWORD PTR FFFFFF28[EBP]
00008: 27FB 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 2802 4A                          DEC EDX
00008: 2803 8B 8D FFFFFF24              MOV ECX, DWORD PTR FFFFFF24[EBP]
00008: 2809 49                          DEC ECX
00008: 280A 89 4D FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], ECX
00008: 280D DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 2810 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 2816 DD 1C D0                    FSTP QWORD PTR 00000000[EAX][EDX*8]

; 1424: 			numbond++;

00008: 2819 FF 85 FFFFFF48              INC DWORD PTR FFFFFF48[EBP]

; 1425: 		      }

00008: 281F FF 8D FFFFFF28              DEC DWORD PTR FFFFFF28[EBP]
00008: 2825                     L00B7:
00008: 2825 83 BD FFFFFF2801            CMP DWORD PTR FFFFFF28[EBP], 00000001
00008: 282C 0F 8D FFFFFF04              JGE L00B8

; 1426: 			top+=2*(numword-1);

00008: 2832 8B 95 FFFFFF44              MOV EDX, DWORD PTR FFFFFF44[EBP]
00008: 2838 4A                          DEC EDX
00008: 2839 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 2840 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 2847 01 95 FFFFFF5C              ADD DWORD PTR FFFFFF5C[EBP], EDX

; 1427: 		  }

00008: 284D                     L00B1:

; 1428: 	      }while(!next_key);

00008: 284D 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2854 0F 84 FFFFFD96              JE L00AF

; 1429: 	  current_key=next_key;

00008: 285A 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 2860 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1430: 	  break;

00008: 2866 E9 00000322                 JMP L0011
00008: 286B                     L00BC:

; 1434: 	    dummy=top;

00008: 286B 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 2871 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 1435: 	    printf("%s\n",keywords[current_key]);

00008: 2877 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 287D 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 2883 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 2886 50                          PUSH EAX
00008: 2887 68 00000000                 PUSH OFFSET @1301
00008: 288C E8 00000000                 CALL SHORT _printf
00008: 2891 59                          POP ECX
00008: 2892 59                          POP ECX

; 1436: 	    if(!nextline)goto finish;	    

00008: 2893 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 289A 0F 84 000002FA              JE L0096

; 1437: 	    datfile=nextline;

00008: 28A0 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 28A6 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1438: 	    nextline=next_line(datfile);

00008: 28AC FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 28B2 E8 00000000                 CALL SHORT _next_line
00008: 28B7 59                          POP ECX
00008: 28B8 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1440: 	    sscanf(datfile,"%lf",dummy);

00008: 28BE FF B5 FFFFFF60              PUSH DWORD PTR FFFFFF60[EBP]
00008: 28C4 68 00000000                 PUSH OFFSET @1302
00008: 28C9 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 28CF E8 00000000                 CALL SHORT _sscanf
00008: 28D4 83 C4 0C                    ADD ESP, 0000000C

; 1441:             lbt=dummy[0];

00008: 28D7 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 28DD DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 28DF D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 28E2 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 28E5 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 28E9 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 28EC DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 28EF 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 28F2 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 28F5 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 28F8 89 95 FFFFFF50              MOV DWORD PTR FFFFFF50[EBP], EDX

; 1442:             if((lbt<1)||(lbt!=dummy[0]))return line_number;

00008: 28FE 83 BD FFFFFF5001            CMP DWORD PTR FFFFFF50[EBP], 00000001
00008: 2905 7C 1C                       JL L00BD
00008: 2907 8B 85 FFFFFF50              MOV EAX, DWORD PTR FFFFFF50[EBP]
00008: 290D 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 2910 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 2913 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 2919 DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 291B F1DF                        FCOMIP ST, ST(1), L00BE
00007: 291D DD D8                       FSTP ST
00008: 291F 7A 02                       JP L00DD
00008: 2921 74 0D                       JE L00BE
00008: 2923                     L00DD:
00008: 2923                     L00BD:
00008: 2923 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2928                             epilog 
00000: 2928 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 292B 5F                          POP EDI
00000: 292C 5E                          POP ESI
00000: 292D 5B                          POP EBX
00000: 292E 5D                          POP EBP
00000: 292F C3                          RETN 
00008: 2930                     L00BE:

; 1443: 	    if(!nextline)goto finish;	    

00008: 2930 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 2937 0F 84 0000025D              JE L0096

; 1444: 	    datfile=nextline;

00008: 293D 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 2943 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1445: 	    nextline=next_line(datfile);

00008: 2949 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 294F E8 00000000                 CALL SHORT _next_line
00008: 2954 59                          POP ECX
00008: 2955 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1446: 	    next_key=iskeyword(datfile);

00008: 295B FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2961 E8 00000000                 CALL SHORT _iskeyword
00008: 2966 59                          POP ECX
00008: 2967 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1447: 	    if(next_key<=0)return line_number;

00008: 296D 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2974 7F 0D                       JG L00BF
00008: 2976 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 297B                             epilog 
00000: 297B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 297E 5F                          POP EDI
00000: 297F 5E                          POP ESI
00000: 2980 5B                          POP EBX
00000: 2981 5D                          POP EBP
00000: 2982 C3                          RETN 
00008: 2983                     L00BF:

; 1448: 	    else current_key=next_key;

00008: 2983 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 2989 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1449:             break;

00008: 298F E9 000001F9                 JMP L0011
00008: 2994                     L00C0:

; 1453: 	    dummy=top;

00008: 2994 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 299A 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 1454: 	    printf("%s\n",keywords[current_key]);

00008: 29A0 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 29A6 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 29AC 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 29AF 50                          PUSH EAX
00008: 29B0 68 00000000                 PUSH OFFSET @1301
00008: 29B5 E8 00000000                 CALL SHORT _printf
00008: 29BA 59                          POP ECX
00008: 29BB 59                          POP ECX

; 1455: 	    do

00008: 29BC                     L00C1:

; 1457: 		if(!nextline)goto finish;

00008: 29BC 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 29C3 0F 84 000001D1              JE L0096

; 1458: 		datfile=nextline;

00008: 29C9 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 29CF 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1459: 		nextline=next_line(datfile);

00008: 29D5 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 29DB E8 00000000                 CALL SHORT _next_line
00008: 29E0 59                          POP ECX
00008: 29E1 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1460: 		next_key=iskeyword(datfile);

00008: 29E7 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 29ED E8 00000000                 CALL SHORT _iskeyword
00008: 29F2 59                          POP ECX
00008: 29F3 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1461: 		if(next_key<0)return line_number;

00008: 29F9 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2A00 7D 0D                       JGE L00C2
00008: 2A02 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2A07                             epilog 
00000: 2A07 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2A0A 5F                          POP EDI
00000: 2A0B 5E                          POP ESI
00000: 2A0C 5B                          POP EBX
00000: 2A0D 5D                          POP EBP
00000: 2A0E C3                          RETN 
00008: 2A0F                     L00C2:

; 1462:                 if(!next_key)

00008: 2A0F 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2A16 75 0C                       JNE L00C3

; 1464: 		    isparam(datfile);

00008: 2A18 FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2A1E E8 00000000                 CALL SHORT _isparam
00008: 2A23 59                          POP ECX

; 1465: 		  }

00008: 2A24                     L00C3:

; 1466: 	      }while(!next_key);

00008: 2A24 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2A2B 74 FFFFFF8F                 JE L00C1

; 1467: 	  current_key=next_key;

00008: 2A2D 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 2A33 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1468: 	  break;

00008: 2A39 E9 0000014F                 JMP L0011
00008: 2A3E                     L00C4:

; 1474: 	    dummy=top;

00008: 2A3E 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 2A44 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 1475: 	    printf("%s\n",keywords[current_key]);

00008: 2A4A 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 2A50 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 2A56 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 2A59 50                          PUSH EAX
00008: 2A5A 68 00000000                 PUSH OFFSET @1301
00008: 2A5F E8 00000000                 CALL SHORT _printf
00008: 2A64 59                          POP ECX
00008: 2A65 59                          POP ECX

; 1476: 	    if(!nextline)goto finish;	    

00008: 2A66 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 2A6D 0F 84 00000127              JE L0096

; 1477: 	    datfile=nextline;

00008: 2A73 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 2A79 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1478: 	    nextline=next_line(datfile);

00008: 2A7F FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2A85 E8 00000000                 CALL SHORT _next_line
00008: 2A8A 59                          POP ECX
00008: 2A8B 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1480: 	    sscanf(datfile,"%lf",dummy);

00008: 2A91 FF B5 FFFFFF60              PUSH DWORD PTR FFFFFF60[EBP]
00008: 2A97 68 00000000                 PUSH OFFSET @1302
00008: 2A9C FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2AA2 E8 00000000                 CALL SHORT _sscanf
00008: 2AA7 83 C4 0C                    ADD ESP, 0000000C

; 1481:             lct=dummy[0];

00008: 2AAA 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00008: 2AB0 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 2AB2 D9 7D FFFFFF98              FNSTCW WORD PTR FFFFFF98[EBP]
00007: 2AB5 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00007: 2AB8 80 4D FFFFFF99 0C           OR BYTE PTR FFFFFF99[EBP], 0C
00007: 2ABC D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00007: 2ABF DB 5D FFFFFFBC              FISTP DWORD PTR FFFFFFBC[EBP]
00008: 2AC2 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX
00008: 2AC5 D9 6D FFFFFF98              FLDCW WORD PTR FFFFFF98[EBP]
00008: 2AC8 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 2ACB 89 95 FFFFFF54              MOV DWORD PTR FFFFFF54[EBP], EDX

; 1482:             if((lct<1)||(lct!=dummy[0]))return line_number;

00008: 2AD1 83 BD FFFFFF5401            CMP DWORD PTR FFFFFF54[EBP], 00000001
00008: 2AD8 7C 1C                       JL L00C5
00008: 2ADA 8B 85 FFFFFF54              MOV EAX, DWORD PTR FFFFFF54[EBP]
00008: 2AE0 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 2AE3 DB 45 FFFFFFBC              FILD DWORD PTR FFFFFFBC[EBP]
00007: 2AE6 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00007: 2AEC DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 2AEE F1DF                        FCOMIP ST, ST(1), L00C6
00007: 2AF0 DD D8                       FSTP ST
00008: 2AF2 7A 02                       JP L00DE
00008: 2AF4 74 0D                       JE L00C6
00008: 2AF6                     L00DE:
00008: 2AF6                     L00C5:
00008: 2AF6 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2AFB                             epilog 
00000: 2AFB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2AFE 5F                          POP EDI
00000: 2AFF 5E                          POP ESI
00000: 2B00 5B                          POP EBX
00000: 2B01 5D                          POP EBP
00000: 2B02 C3                          RETN 
00008: 2B03                     L00C6:

; 1483: 	    if(!nextline)goto finish;	    

00008: 2B03 83 BD FFFFFF1C00            CMP DWORD PTR FFFFFF1C[EBP], 00000000
00008: 2B0A 0F 84 0000008A              JE L0096

; 1484: 	    datfile=nextline;

00008: 2B10 8B 85 FFFFFF1C              MOV EAX, DWORD PTR FFFFFF1C[EBP]
00008: 2B16 89 85 FFFFFF18              MOV DWORD PTR FFFFFF18[EBP], EAX

; 1485: 	    nextline=next_line(datfile);

00008: 2B1C FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2B22 E8 00000000                 CALL SHORT _next_line
00008: 2B27 59                          POP ECX
00008: 2B28 89 85 FFFFFF1C              MOV DWORD PTR FFFFFF1C[EBP], EAX

; 1486: 	    next_key=iskeyword(datfile);

00008: 2B2E FF B5 FFFFFF18              PUSH DWORD PTR FFFFFF18[EBP]
00008: 2B34 E8 00000000                 CALL SHORT _iskeyword
00008: 2B39 59                          POP ECX
00008: 2B3A 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 1487: 	    if(next_key<=0)return line_number;

00008: 2B40 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 2B47 7F 0D                       JG L00C7
00008: 2B49 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2B4E                             epilog 
00000: 2B4E 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2B51 5F                          POP EDI
00000: 2B52 5E                          POP ESI
00000: 2B53 5B                          POP EBX
00000: 2B54 5D                          POP EBP
00000: 2B55 C3                          RETN 
00008: 2B56                     L00C7:

; 1488: 	    else current_key=next_key;

00008: 2B56 8B 85 FFFFFF4C              MOV EAX, DWORD PTR FFFFFF4C[EBP]
00008: 2B5C 89 85 FFFFFF30              MOV DWORD PTR FFFFFF30[EBP], EAX

; 1489:             break;

00008: 2B62 EB 29                       JMP L0011
00008: 2B64                     L0004:

; 1494: 	    printf("%s\n",keywords[current_key]);

00008: 2B64 8B 1D 00000000              MOV EBX, DWORD PTR _keywords
00008: 2B6A 8B 85 FFFFFF30              MOV EAX, DWORD PTR FFFFFF30[EBP]
00008: 2B70 8B 04 83                    MOV EAX, DWORD PTR 00000000[EBX][EAX*4]
00008: 2B73 50                          PUSH EAX
00008: 2B74 68 00000000                 PUSH OFFSET @1301
00008: 2B79 E8 00000000                 CALL SHORT _printf
00008: 2B7E 59                          POP ECX
00008: 2B7F 59                          POP ECX

; 1495: 	    return line_number;

00008: 2B80 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2B85                             epilog 
00000: 2B85 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2B88 5F                          POP EDI
00000: 2B89 5E                          POP ESI
00000: 2B8A 5B                          POP EBX
00000: 2B8B 5D                          POP EBP
00000: 2B8C C3                          RETN 
00008: 2B8D                     L0011:

; 1500:     }/* while (current_k) */

00008: 2B8D                     L0002:
00008: 2B8D 83 BD FFFFFF3000            CMP DWORD PTR FFFFFF30[EBP], 00000000
00008: 2B94 0F 85 FFFFD53C              JNE L0003

; 1501: 	finish:

00008: 2B9A                     L0096:

; 1502: 	  if(nrt||numunstable)

00008: 2B9A 83 3D 00000000 00           CMP DWORD PTR _nrt, 00000000
00008: 2BA1 75 09                       JNE L00C8
00008: 2BA3 83 BD FFFFFF4000            CMP DWORD PTR FFFFFF40[EBP], 00000000
00008: 2BAA 74 6E                       JE L00C9
00008: 2BAC                     L00C8:

; 1504: 	      collp=(well_type *)malloc(n1*sizeof(well_type));

00008: 2BAC 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 2BB2 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 2BB9 52                          PUSH EDX
00008: 2BBA E8 00000000                 CALL SHORT _malloc
00008: 2BBF 59                          POP ECX
00008: 2BC0 A3 00000000                 MOV DWORD PTR _collp, EAX

; 1505: 	      if(!collp){nrt=numunstable=0;}

00008: 2BC5 83 3D 00000000 00           CMP DWORD PTR _collp, 00000000
00008: 2BCC 75 15                       JNE L00CA
00008: 2BCE C7 85 FFFFFF4000000000      MOV DWORD PTR FFFFFF40[EBP], 00000000
00008: 2BD8 8B 85 FFFFFF40              MOV EAX, DWORD PTR FFFFFF40[EBP]
00008: 2BDE A3 00000000                 MOV DWORD PTR _nrt, EAX
00008: 2BE3                     L00CA:

; 1506: 	      collq=(well_type *)malloc(n1*sizeof(well_type));

00008: 2BE3 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 2BE9 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 2BF0 52                          PUSH EDX
00008: 2BF1 E8 00000000                 CALL SHORT _malloc
00008: 2BF6 59                          POP ECX
00008: 2BF7 A3 00000000                 MOV DWORD PTR _collq, EAX

; 1507: 	      if(!collq){nrt=numunstable=0;}

00008: 2BFC 83 3D 00000000 00           CMP DWORD PTR _collq, 00000000
00008: 2C03 75 15                       JNE L00CB
00008: 2C05 C7 85 FFFFFF4000000000      MOV DWORD PTR FFFFFF40[EBP], 00000000
00008: 2C0F 8B 85 FFFFFF40              MOV EAX, DWORD PTR FFFFFF40[EBP]
00008: 2C15 A3 00000000                 MOV DWORD PTR _nrt, EAX
00008: 2C1A                     L00CB:

; 1508: 	    }

00008: 2C1A                     L00C9:

; 1510:   nrt=allocReact(react1,nrt,react0,numunstable);

00008: 2C1A FF B5 FFFFFF40              PUSH DWORD PTR FFFFFF40[EBP]
00008: 2C20 FF B5 FFFFFF70              PUSH DWORD PTR FFFFFF70[EBP]
00008: 2C26 A1 00000000                 MOV EAX, DWORD PTR _nrt
00008: 2C2B 50                          PUSH EAX
00008: 2C2C FF B5 FFFFFF74              PUSH DWORD PTR FFFFFF74[EBP]
00008: 2C32 E8 00000000                 CALL SHORT _allocReact
00008: 2C37 83 C4 10                    ADD ESP, 00000010
00008: 2C3A A3 00000000                 MOV DWORD PTR _nrt, EAX

; 1511:   if(nrt<0)return line_number;

00008: 2C3F 83 3D 00000000 00           CMP DWORD PTR _nrt, 00000000
00008: 2C46 7D 0D                       JGE L00CC
00008: 2C48 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2C4D                             epilog 
00000: 2C4D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2C50 5F                          POP EDI
00000: 2C51 5E                          POP ESI
00000: 2C52 5B                          POP EBX
00000: 2C53 5D                          POP EBP
00000: 2C54 C3                          RETN 
00008: 2C55                     L00CC:

; 1512:   if(!allocBonds(n1, numbond,nrt,lbt)){StopAlert (MEMORY_ALRT);return line_number;}

00008: 2C55 FF B5 FFFFFF50              PUSH DWORD PTR FFFFFF50[EBP]
00008: 2C5B A1 00000000                 MOV EAX, DWORD PTR _nrt
00008: 2C60 50                          PUSH EAX
00008: 2C61 FF B5 FFFFFF48              PUSH DWORD PTR FFFFFF48[EBP]
00008: 2C67 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 2C6C 50                          PUSH EAX
00008: 2C6D E8 00000000                 CALL SHORT _allocBonds
00008: 2C72 83 C4 10                    ADD ESP, 00000010
00008: 2C75 83 F8 00                    CMP EAX, 00000000
00008: 2C78 75 15                       JNE L00CD
00008: 2C7A 6A 02                       PUSH 00000002
00008: 2C7C E8 00000000                 CALL SHORT _StopAlert
00008: 2C81 59                          POP ECX
00008: 2C82 A1 00000000                 MOV EAX, DWORD PTR _line_number
00000: 2C87                             epilog 
00000: 2C87 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2C8A 5F                          POP EDI
00000: 2C8B 5E                          POP ESI
00000: 2C8C 5B                          POP EBX
00000: 2C8D 5D                          POP EBP
00000: 2C8E C3                          RETN 
00008: 2C8F                     L00CD:

; 1514:   if((make_bonds(numbond,bonds))<0)printf("error in bonds\n");

00008: 2C8F FF B5 FFFFFF64              PUSH DWORD PTR FFFFFF64[EBP]
00008: 2C95 FF B5 FFFFFF48              PUSH DWORD PTR FFFFFF48[EBP]
00008: 2C9B E8 00000000                 CALL SHORT _make_bonds
00008: 2CA0 59                          POP ECX
00008: 2CA1 59                          POP ECX
00008: 2CA2 83 F8 00                    CMP EAX, 00000000
00008: 2CA5 7D 0D                       JGE L00CE
00008: 2CA7 68 00000000                 PUSH OFFSET @1308
00008: 2CAC E8 00000000                 CALL SHORT _printf
00008: 2CB1 59                          POP ECX
00008: 2CB2 EB 12                       JMP L00CF
00008: 2CB4                     L00CE:

; 1516:     printf("number of bonds= %d\n",numbond);

00008: 2CB4 FF B5 FFFFFF48              PUSH DWORD PTR FFFFFF48[EBP]
00008: 2CBA 68 00000000                 PUSH OFFSET @1309
00008: 2CBF E8 00000000                 CALL SHORT _printf
00008: 2CC4 59                          POP ECX
00008: 2CC5 59                          POP ECX
00008: 2CC6                     L00CF:

; 1517:   printf("%ld %ld %ld %ld\n", (long)storage, (long)bonds, file_length,(long)top); 

00008: 2CC6 FF B5 FFFFFF5C              PUSH DWORD PTR FFFFFF5C[EBP]
00008: 2CCC FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 2CCF FF B5 FFFFFF64              PUSH DWORD PTR FFFFFF64[EBP]
00008: 2CD5 FF B5 FFFFFF58              PUSH DWORD PTR FFFFFF58[EBP]
00008: 2CDB 68 00000000                 PUSH OFFSET @1310
00008: 2CE0 E8 00000000                 CALL SHORT _printf
00008: 2CE5 83 C4 14                    ADD ESP, 00000014

; 1519:  make_wells(coldata,numwell,bonddata,numbondwell,

00008: 2CE8 A1 00000000                 MOV EAX, DWORD PTR _nat
00008: 2CED 50                          PUSH EAX
00008: 2CEE A1 00000000                 MOV EAX, DWORD PTR _sam
00008: 2CF3 50                          PUSH EAX
00008: 2CF4 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 2CF9 50                          PUSH EAX
00008: 2CFA A1 00000000                 MOV EAX, DWORD PTR _a
00008: 2CFF 50                          PUSH EAX
00008: 2D00 FF B5 FFFFFF48              PUSH DWORD PTR FFFFFF48[EBP]
00008: 2D06 FF B5 FFFFFF64              PUSH DWORD PTR FFFFFF64[EBP]
00008: 2D0C FF B5 FFFFFF3C              PUSH DWORD PTR FFFFFF3C[EBP]
00008: 2D12 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 2D18 FF B5 FFFFFF38              PUSH DWORD PTR FFFFFF38[EBP]
00008: 2D1E FF B5 FFFFFF68              PUSH DWORD PTR FFFFFF68[EBP]
00008: 2D24 E8 00000000                 CALL SHORT _make_wells
00008: 2D29 83 C4 28                    ADD ESP, 00000028

; 1523:   free(storage);

00008: 2D2C FF B5 FFFFFF58              PUSH DWORD PTR FFFFFF58[EBP]
00008: 2D32 E8 00000000                 CALL SHORT _free
00008: 2D37 59                          POP ECX

; 1524:   free(bonddata[0]);

00008: 2D38 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 2D3E 8B 00                       MOV EAX, DWORD PTR 00000000[EAX]
00008: 2D40 50                          PUSH EAX
00008: 2D41 E8 00000000                 CALL SHORT _free
00008: 2D46 59                          POP ECX

; 1525:   free(bonddata);  

00008: 2D47 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 2D4D E8 00000000                 CALL SHORT _free
00008: 2D52 59                          POP ECX

; 1526:   free(coldata[0]);

00008: 2D53 8B 85 FFFFFF68              MOV EAX, DWORD PTR FFFFFF68[EBP]
00008: 2D59 8B 00                       MOV EAX, DWORD PTR 00000000[EAX]
00008: 2D5B 50                          PUSH EAX
00008: 2D5C E8 00000000                 CALL SHORT _free
00008: 2D61 59                          POP ECX

; 1527:   free(coldata);  

00008: 2D62 FF B5 FFFFFF68              PUSH DWORD PTR FFFFFF68[EBP]
00008: 2D68 E8 00000000                 CALL SHORT _free
00008: 2D6D 59                          POP ECX

; 1528: return 1;

00008: 2D6E B8 00000001                 MOV EAX, 00000001
00000: 2D73                     L0000:
00000: 2D73                             epilog 
00000: 2D73 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 2D76 5F                          POP EDI
00000: 2D77 5E                          POP ESI
00000: 2D78 5B                          POP EBX
00000: 2D79 5D                          POP EBP
00000: 2D7A C3                          RETN 

Function: _get_sample_atoms

; 1530: atom * get_sample_atoms(){return sam;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1530: atom * get_sample_atoms(){return sam;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _sam
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_atom_types

; 1531: int get_atom_types(){return nat;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1531: int get_atom_types(){return nat;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _nat
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 
