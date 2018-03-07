
Function: _next_double

; 74: {

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

; 76:   double z=x;

00008: 0018 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 001B DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 77:   z=frexp(z,&y)+ldexp(DBL_EPSILON,-1);

00008: 001E 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 0020 FF 35 00000004              PUSH DWORD PTR ___double_epsilon+00000004
00008: 0026 FF 35 00000000              PUSH DWORD PTR ___double_epsilon
00008: 002C E8 00000000                 CALL SHORT _ldexp
00007: 0031 83 C4 0C                    ADD ESP, 0000000C
00007: 0034 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]
00008: 0037 8D 45 FFFFFFFC              LEA EAX, DWORD PTR FFFFFFFC[EBP]
00008: 003A 50                          PUSH EAX
00008: 003B FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 003E FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 0041 E8 00000000                 CALL SHORT _frexp
00007: 0046 83 C4 0C                    ADD ESP, 0000000C
00007: 0049 DC 45 FFFFFFE8              FADD QWORD PTR FFFFFFE8[EBP]
00007: 004C DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]
00008: 004F DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 0052 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 78:   z=ldexp(z,y); 

00008: 0055 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0058 50                          PUSH EAX
00008: 0059 FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 005C FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 005F E8 00000000                 CALL SHORT _ldexp
00007: 0064 83 C4 0C                    ADD ESP, 0000000C
00007: 0067 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 79:   return z;

00008: 006A DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00000: 006D                     L0000:
00000: 006D                             epilog 
00000: 006D C9                          LEAVE 
00000: 006E C3                          RETN 

Function: _ldexp

; 509: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 514: 	fild exponent	; esp=address of LDEXP

00008: 0003 DB 45 10                    FILD DWORD PTR 00000010[EBP]

; 516: 	fld x	        ; load x

00007: 0006 DD 45 08                    FLD QWORD PTR 00000008[EBP]

; 517: 	fscale			; st=x st(1)=n

00006: 0009 D9 FD                       FSCALE 

; 518: 	fstp st(1)

00006: 000B DD D9                       FSTP ST(1)

; 519: 	fstp x

00007: 000D DD 5D 08                    FSTP QWORD PTR 00000008[EBP]

; 521: 	return x ;

00008: 0010 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00000: 0013                     L0000:
00000: 0013                             epilog 
00000: 0013 C9                          LEAVE 
00000: 0014 C3                          RETN 

Function: _frexp

; 477: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 482:  	fld x

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]

; 483: 	ftst			; need to check if x=0 due to  behavior of fxtract

00007: 0006 D9 E4                       FTST 

; 484: 	fnstsw ax

00007: 0008 DF E0                       FNSTSW AX

; 485: 	test ax, 0x4000	; check if C3 bit is set

00007: 000A 66 A9 4000                  TEST AX, 4000

; 486: 	jz normal_frexp

00007: 000E 74 07                       JZ L0001

; 487: 	mov ECX,exponent 	

00007: 0010 8B 4D 10                    MOV ECX, DWORD PTR 00000010[EBP]

; 488: 	fist dword ptr[ECX]

00007: 0013 DB 11                       FIST DWORD PTR 00000000[ECX]

; 489: 	jmp frexp_done

00007: 0015 EB 15                       JMP L0002
00007: 0017                     L0001:
00007: 0017 D9 F4                       FXTRACT 

; 492: 	fld __HALF		; 2^-1

00006: 0019 D9 05 00000000              FLD DWORD PTR ___HALF

; 493: 	fmul			; scale significand,pop __HALF 

00005: 001F DE C9                       FMULP ST(1), ST

; 494: 	fxch			; put exponent on top of stack

00006: 0021 D9 C9                       FXCH ST(1)

; 495: 	fld1

00006: 0023 D9 E8                       FLD1 

; 496: 	fadd     		; increase exponent by 1, overwrite exponent  pop 1

00005: 0025 DE C1                       FADDP ST(1), ST

; 498: 	mov ECX,exponent

00006: 0027 8B 4D 10                    MOV ECX, DWORD PTR 00000010[EBP]

; 499: 	fistp dword ptr[ECX]

00006: 002A DB 19                       FISTP DWORD PTR 00000000[ECX]

; 500: frexp_done:	

00007: 002C                     L0002:
00007: 002C DD 5D 08                    FSTP QWORD PTR 00000008[EBP]

; 503: 	return x ;

00008: 002F DD 45 08                    FLD QWORD PTR 00000008[EBP]
00000: 0032                     L0000:
00000: 0032                             epilog 
00000: 0032 C9                          LEAVE 
00000: 0033 C3                          RETN 

Function: _prev_double

; 82: {

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

; 84:   double z=x;

00008: 0018 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 001B DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 85:   z=frexp(z,&y)-ldexp(DBL_EPSILON,-1);

00008: 001E 6A FFFFFFFF                 PUSH FFFFFFFF
00008: 0020 FF 35 00000004              PUSH DWORD PTR ___double_epsilon+00000004
00008: 0026 FF 35 00000000              PUSH DWORD PTR ___double_epsilon
00008: 002C E8 00000000                 CALL SHORT _ldexp
00007: 0031 83 C4 0C                    ADD ESP, 0000000C
00007: 0034 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]
00008: 0037 8D 45 FFFFFFFC              LEA EAX, DWORD PTR FFFFFFFC[EBP]
00008: 003A 50                          PUSH EAX
00008: 003B FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 003E FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 0041 E8 00000000                 CALL SHORT _frexp
00007: 0046 83 C4 0C                    ADD ESP, 0000000C
00007: 0049 DC 65 FFFFFFE8              FSUB QWORD PTR FFFFFFE8[EBP]
00007: 004C DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]
00008: 004F DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 0052 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 86:   z=ldexp(z,y); 

00008: 0055 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0058 50                          PUSH EAX
00008: 0059 FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 005C FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 005F E8 00000000                 CALL SHORT _ldexp
00007: 0064 83 C4 0C                    ADD ESP, 0000000C
00007: 0067 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 87:   return z;

00008: 006A DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00000: 006D                     L0000:
00000: 006D                             epilog 
00000: 006D C9                          LEAVE 
00000: 006E C3                          RETN 

Function: _set_new_bounds

; 92: {     

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 18                    SUB ESP, 00000018
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 AB                          STOSD 
00000: 0017 AB                          STOSD 
00000: 0018 5F                          POP EDI
00000: 0019                             prolog 

; 93:   double ccell=maxrb;

00008: 0019 DD 45 0C                    FLD QWORD PTR 0000000C[EBP]
00007: 001C DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 95:   ccell=next_double(ccell);

00008: 001F FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0022 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0025 E8 00000000                 CALL SHORT _next_double
00007: 002A 59                          POP ECX
00007: 002B 59                          POP ECX
00007: 002C DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 96:   dim=ndim;

00008: 002F 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 0032 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 0035 DB 45 FFFFFFF0              FILD DWORD PTR FFFFFFF0[EBP]
00007: 0038 DD 1D 00000000              FSTP QWORD PTR _dim

; 97:   for(i=0;i<ndim;i++)

00008: 003E C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0045 E9 00000198                 JMP L0001
00008: 004A                     L0002:

; 99:       bound[i].period=L[i]/ccell;

00008: 004A 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 004D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0050 DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00007: 0053 DC 75 FFFFFFE8              FDIV QWORD PTR FFFFFFE8[EBP]
00007: 0056 D9 7D FFFFFFE4              FNSTCW WORD PTR FFFFFFE4[EBP]
00007: 0059 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00007: 005C 80 4D FFFFFFE5 0C           OR BYTE PTR FFFFFFE5[EBP], 0C
00007: 0060 D9 6D FFFFFFE4              FLDCW WORD PTR FFFFFFE4[EBP]
00007: 0063 DB 5D FFFFFFF0              FISTP DWORD PTR FFFFFFF0[EBP]
00008: 0066 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX
00008: 0069 D9 6D FFFFFFE4              FLDCW WORD PTR FFFFFFE4[EBP]
00008: 006C 8B 75 FFFFFFF0              MOV ESI, DWORD PTR FFFFFFF0[EBP]
00008: 006F 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 0072 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0075 89 34 DD 00000010           MOV DWORD PTR _bound+00000010[EBX*8], ESI

; 101:       if(bound[i].period<3)

00008: 007C 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 007F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0082 83 3C DD 00000010 03        CMP DWORD PTR _bound+00000010[EBX*8], 00000003
00008: 008A 7D 3C                       JGE L0003

; 103: 	  bound[i].period=3;

00008: 008C 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 008F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0092 C7 04 DD 00000010 00000003  MOV DWORD PTR _bound+00000010[EBX*8], 00000003

; 104: 	  bound[i].dl=ccell;

00008: 009D 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 00A0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00A3 DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 00A6 DD 1C DD 00000008           FSTP QWORD PTR _bound+00000008[EBX*8]

; 105: 	  bound[i].length=ccell*3;

00008: 00AD 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 00B0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00B3 DD 05 00000000              FLD QWORD PTR .data+00000038
00007: 00B9 DC 4D FFFFFFE8              FMUL QWORD PTR FFFFFFE8[EBP]
00007: 00BC DD 1C DD 00000000           FSTP QWORD PTR _bound[EBX*8]

; 106: 	}

00008: 00C3 E9 000000D1                 JMP L0004
00008: 00C8                     L0003:

; 109: 	  bound[i].dl=L[i]/bound[i].period;

00008: 00C8 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 00CB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00CE DB 04 DD 00000010           FILD DWORD PTR _bound+00000010[EBX*8]
00007: 00D5 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00007: 00D8 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 00DB DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00006: 00DE DE F1                       FDIVRP ST(1), ST
00007: 00E0 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 00E3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00E6 DD 1C DD 00000008           FSTP QWORD PTR _bound+00000008[EBX*8]

; 110: 	  bound[i].length=bound[i].dl*bound[i].period;

00008: 00ED 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 00F0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00F3 DB 04 DD 00000010           FILD DWORD PTR _bound+00000010[EBX*8]
00007: 00FA 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 00FD 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0100 DC 0C DD 00000008           FMUL QWORD PTR _bound+00000008[EBX*8]
00007: 0107 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 010A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 010D DD 1C DD 00000000           FSTP QWORD PTR _bound[EBX*8]

; 111:           if((bound[i].dl<=maxrb)||(bound[i].length<L[i]))

00008: 0114 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 0117 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 011A DD 04 DD 00000008           FLD QWORD PTR _bound+00000008[EBX*8]
00007: 0121 DD 45 0C                    FLD QWORD PTR 0000000C[EBP]
00006: 0124 F1DF                        FCOMIP ST, ST(1), L0005
00007: 0126 DD D8                       FSTP ST
00008: 0128 7A 02                       JP L0008
00008: 012A 73 1E                       JAE L0005
00008: 012C                     L0008:
00008: 012C 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 012F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0132 DD 04 DD 00000000           FLD QWORD PTR _bound[EBX*8]
00007: 0139 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00007: 013C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 013F DD 04 C8                    FLD QWORD PTR 00000000[EAX][ECX*8]
00006: 0142 F1DF                        FCOMIP ST, ST(1), L0006
00007: 0144 DD D8                       FSTP ST
00008: 0146 7A 2A                       JP L0006
00008: 0148 76 28                       JBE L0006
00008: 014A                     L0005:

; 113: 	      bound[i].dl=next_double(bound[i].dl);

00008: 014A 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 014D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0150 FF 34 DD 0000000C           PUSH DWORD PTR _bound+0000000C[EBX*8]
00008: 0157 FF 34 DD 00000008           PUSH DWORD PTR _bound+00000008[EBX*8]
00008: 015E E8 00000000                 CALL SHORT _next_double
00007: 0163 59                          POP ECX
00007: 0164 59                          POP ECX
00007: 0165 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 0168 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 016B DD 1C DD 00000008           FSTP QWORD PTR _bound+00000008[EBX*8]

; 114: 	    }

00008: 0172                     L0006:

; 115: 	  bound[i].length=bound[i].dl*bound[i].period;

00008: 0172 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 0175 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0178 DB 04 DD 00000010           FILD DWORD PTR _bound+00000010[EBX*8]
00007: 017F 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 0182 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0185 DC 0C DD 00000008           FMUL QWORD PTR _bound+00000008[EBX*8]
00007: 018C 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00007: 018F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0192 DD 1C DD 00000000           FSTP QWORD PTR _bound[EBX*8]

; 116: 	}

00008: 0199                     L0004:

; 117:     printf("%d %lf %d %lf\n",i,bound[i].length,bound[i].period,bound[i].dl);

00008: 0199 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 019C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 019F FF 34 DD 0000000C           PUSH DWORD PTR _bound+0000000C[EBX*8]
00008: 01A6 FF 34 DD 00000008           PUSH DWORD PTR _bound+00000008[EBX*8]
00008: 01AD 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 01B0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01B3 8B 04 DD 00000010           MOV EAX, DWORD PTR _bound+00000010[EBX*8]
00008: 01BA 50                          PUSH EAX
00008: 01BB 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 01BE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01C1 FF 34 DD 00000004           PUSH DWORD PTR _bound+00000004[EBX*8]
00008: 01C8 FF 34 DD 00000000           PUSH DWORD PTR _bound[EBX*8]
00008: 01CF FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 01D2 68 00000000                 PUSH OFFSET @106
00008: 01D7 E8 00000000                 CALL SHORT _printf
00008: 01DC 83 C4 1C                    ADD ESP, 0000001C

; 118:     }

00008: 01DF FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 01E2                     L0001:
00008: 01E2 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 01E5 3B 45 14                    CMP EAX, DWORD PTR 00000014[EBP]
00008: 01E8 0F 8C FFFFFE5C              JL L0002

; 119: if (ndim==2)

00008: 01EE 83 7D 14 02                 CMP DWORD PTR 00000014[EBP], 00000002
00008: 01F2 75 22                       JNE L0007

; 120: bound[2].length=bound[2].dl=bound[2].period=1;

00008: 01F4 C7 05 00000040 00000001     MOV DWORD PTR _bound+00000040, 00000001
00008: 01FE DB 05 00000040              FILD DWORD PTR _bound+00000040
00007: 0204 DD 1D 00000038              FSTP QWORD PTR _bound+00000038
00008: 020A DD 05 00000038              FLD QWORD PTR _bound+00000038
00007: 0210 DD 1D 00000030              FSTP QWORD PTR _bound+00000030
00008: 0216                     L0007:

; 121: }

00000: 0216                     L0000:
00000: 0216                             epilog 
00000: 0216 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0219 5E                          POP ESI
00000: 021A 5B                          POP EBX
00000: 021B 5D                          POP EBP
00000: 021C C3                          RETN 

Function: _init_parameters

; 124: {      

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 125:   corr_2=0;

00008: 0003 C7 05 00000004 00000000     MOV DWORD PTR _corr_2+00000004, 00000000
00008: 000D C7 05 00000000 00000000     MOV DWORD PTR _corr_2, 00000000

; 126:   corr=0;

00008: 0017 C7 05 00000004 00000000     MOV DWORD PTR _corr+00000004, 00000000
00008: 0021 C7 05 00000000 00000000     MOV DWORD PTR _corr, 00000000

; 127:   timea=0; 

00008: 002B C7 05 00000004 00000000     MOV DWORD PTR _timea+00000004, 00000000
00008: 0035 C7 05 00000000 00000000     MOV DWORD PTR _timea, 00000000

; 128:   timeb=0;

00008: 003F C7 05 00000004 00000000     MOV DWORD PTR _timeb+00000004, 00000000
00008: 0049 C7 05 00000000 00000000     MOV DWORD PTR _timeb, 00000000

; 129:   timec=0;

00008: 0053 C7 05 00000004 00000000     MOV DWORD PTR _timec+00000004, 00000000
00008: 005D C7 05 00000000 00000000     MOV DWORD PTR _timec, 00000000

; 130:   timed=0;

00008: 0067 C7 05 00000004 00000000     MOV DWORD PTR _timed+00000004, 00000000
00008: 0071 C7 05 00000000 00000000     MOV DWORD PTR _timed, 00000000

; 131:   ts=0;

00008: 007B C7 05 00000004 00000000     MOV DWORD PTR _ts+00000004, 00000000
00008: 0085 C7 05 00000000 00000000     MOV DWORD PTR _ts, 00000000

; 132:   ll=0;

00008: 008F C7 05 00000000 00000000     MOV DWORD PTR _ll, 00000000

; 133:   m_is_open=is_open=t_is_open=0;

00008: 0099 C7 05 00000000 00000000     MOV DWORD PTR _t_is_open, 00000000
00008: 00A3 8B 15 00000000              MOV EDX, DWORD PTR _t_is_open
00008: 00A9 89 15 00000000              MOV DWORD PTR _is_open, EDX
00008: 00AF 8B 15 00000000              MOV EDX, DWORD PTR _is_open
00008: 00B5 89 15 00000000              MOV DWORD PTR _m_is_open, EDX

; 134:   return;

00000: 00BB                     L0000:
00000: 00BB                             epilog 
00000: 00BB C9                          LEAVE 
00000: 00BC C3                          RETN 

Function: _init_update_param

; 137: {  

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 30                    SUB ESP, 00000030
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000000C                 MOV ECX, 0000000C
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 139:   double mvx=0,mvy=0,mvz=0,mass=0;

00008: 0018 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 001E DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]
00008: 0021 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0027 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 002A DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0030 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 0033 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0039 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 140:   px=bound[0].period-1;

00008: 003C 8B 15 00000010              MOV EDX, DWORD PTR _bound+00000010
00008: 0042 4A                          DEC EDX
00008: 0043 89 15 00000000              MOV DWORD PTR _px, EDX

; 141:   py=bound[1].period-1;

00008: 0049 8B 15 00000028              MOV EDX, DWORD PTR _bound+00000028
00008: 004F 4A                          DEC EDX
00008: 0050 89 15 00000000              MOV DWORD PTR _py, EDX

; 142:   pz=bound[2].period-1;

00008: 0056 8B 15 00000040              MOV EDX, DWORD PTR _bound+00000040
00008: 005C 4A                          DEC EDX
00008: 005D 89 15 00000000              MOV DWORD PTR _pz, EDX

; 143:   lx=bound[0].length;

00008: 0063 DD 05 00000000              FLD QWORD PTR _bound
00007: 0069 DD 1D 00000000              FSTP QWORD PTR _lx

; 144:   ly=bound[1].length;

00008: 006F DD 05 00000018              FLD QWORD PTR _bound+00000018
00007: 0075 DD 1D 00000000              FSTP QWORD PTR _ly

; 145:   lz=bound[2].length;

00008: 007B DD 05 00000030              FLD QWORD PTR _bound+00000030
00007: 0081 DD 1D 00000000              FSTP QWORD PTR _lz

; 148:   n2=n+2;

00008: 0087 8B 15 00000000              MOV EDX, DWORD PTR _n
00008: 008D 83 C2 02                    ADD EDX, 00000002
00008: 0090 89 15 00000000              MOV DWORD PTR _n2, EDX

; 149:   n3=n+3;

00008: 0096 8B 15 00000000              MOV EDX, DWORD PTR _n
00008: 009C 83 C2 03                    ADD EDX, 00000003
00008: 009F 89 15 00000000              MOV DWORD PTR _n3, EDX

; 150:   vvm=0.0;   

00008: 00A5 C7 05 00000004 00000000     MOV DWORD PTR _vvm+00000004, 00000000
00008: 00AF C7 05 00000000 00000000     MOV DWORD PTR _vvm, 00000000

; 151:   printf("init update param");

00008: 00B9 68 00000000                 PUSH OFFSET @150
00008: 00BE E8 00000000                 CALL SHORT _printf
00008: 00C3 59                          POP ECX

; 152:    for(i=0;i<=n;i++)

00008: 00C4 C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 00CB E9 00000412                 JMP L0001
00008: 00D0                     L0002:

; 154:       if(a[i].r.x>=lx) a[i].r.x-=lx;

00008: 00D0 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 00D3 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00DA 29 D3                       SUB EBX, EDX
00008: 00DC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00DF 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 00E5 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 00E8 DD 05 00000000              FLD QWORD PTR _lx
00006: 00EE F1DF                        FCOMIP ST, ST(1), L0003
00007: 00F0 DD D8                       FSTP ST
00008: 00F2 7A 23                       JP L0003
00008: 00F4 77 21                       JA L0003
00008: 00F6 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 00F9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0100 29 D3                       SUB EBX, EDX
00008: 0102 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0105 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 010B DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 010E DC 25 00000000              FSUB QWORD PTR _lx
00007: 0114 DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]
00008: 0117                     L0003:

; 155:       if(a[i].r.x<0) a[i].r.x+=lx;

00008: 0117 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 011A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0121 29 D3                       SUB EBX, EDX
00008: 0123 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0126 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 012C DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 012F DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0135 F1DF                        FCOMIP ST, ST(1), L0004
00007: 0137 DD D8                       FSTP ST
00008: 0139 7A 23                       JP L0004
00008: 013B 76 21                       JBE L0004
00008: 013D 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0140 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0147 29 D3                       SUB EBX, EDX
00008: 0149 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 014C 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0152 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 0155 DC 05 00000000              FADD QWORD PTR _lx
00007: 015B DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]
00008: 015E                     L0004:

; 156:       if(a[i].r.y>=ly) a[i].r.y-=ly;

00008: 015E 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0161 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0168 29 D3                       SUB EBX, EDX
00008: 016A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 016D 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0173 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0177 DD 05 00000000              FLD QWORD PTR _ly
00006: 017D F1DF                        FCOMIP ST, ST(1), L0005
00007: 017F DD D8                       FSTP ST
00008: 0181 7A 25                       JP L0005
00008: 0183 77 23                       JA L0005
00008: 0185 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0188 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 018F 29 D3                       SUB EBX, EDX
00008: 0191 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0194 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 019A DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 019E DC 25 00000000              FSUB QWORD PTR _ly
00007: 01A4 DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]
00008: 01A8                     L0005:

; 157:       if(a[i].r.y<0) a[i].r.y+=ly;

00008: 01A8 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01AB 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01B2 29 D3                       SUB EBX, EDX
00008: 01B4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01B7 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01BD DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 01C1 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 01C7 F1DF                        FCOMIP ST, ST(1), L0006
00007: 01C9 DD D8                       FSTP ST
00008: 01CB 7A 25                       JP L0006
00008: 01CD 76 23                       JBE L0006
00008: 01CF 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01D2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01D9 29 D3                       SUB EBX, EDX
00008: 01DB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01DE 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01E4 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 01E8 DC 05 00000000              FADD QWORD PTR _ly
00007: 01EE DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]
00008: 01F2                     L0006:

; 158:       if(a[i].r.z>=lz) a[i].r.z-=lz;

00008: 01F2 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01F5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01FC 29 D3                       SUB EBX, EDX
00008: 01FE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0201 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0207 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 020B DD 05 00000000              FLD QWORD PTR _lz
00006: 0211 F1DF                        FCOMIP ST, ST(1), L0007
00007: 0213 DD D8                       FSTP ST
00008: 0215 7A 25                       JP L0007
00008: 0217 77 23                       JA L0007
00008: 0219 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 021C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0223 29 D3                       SUB EBX, EDX
00008: 0225 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0228 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 022E DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0232 DC 25 00000000              FSUB QWORD PTR _lz
00007: 0238 DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]
00008: 023C                     L0007:

; 159:       if(a[i].r.z<0) a[i].r.z+=lz;

00008: 023C 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 023F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0246 29 D3                       SUB EBX, EDX
00008: 0248 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 024B 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0251 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0255 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 025B F1DF                        FCOMIP ST, ST(1), L0008
00007: 025D DD D8                       FSTP ST
00008: 025F 7A 25                       JP L0008
00008: 0261 76 23                       JBE L0008
00008: 0263 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0266 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 026D 29 D3                       SUB EBX, EDX
00008: 026F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0272 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0278 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 027C DC 05 00000000              FADD QWORD PTR _lz
00007: 0282 DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]
00008: 0286                     L0008:

; 160:       a[i].i.x.i=a[i].r.x/bound[0].dl;

00008: 0286 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0289 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0290 29 D3                       SUB EBX, EDX
00008: 0292 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0295 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 029B DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 029E DC 35 00000008              FDIV QWORD PTR _bound+00000008
00007: 02A4 D9 7D FFFFFFC8              FNSTCW WORD PTR FFFFFFC8[EBP]
00007: 02A7 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00007: 02AA 80 4D FFFFFFC9 0C           OR BYTE PTR FFFFFFC9[EBP], 0C
00007: 02AE D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00007: 02B1 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 02B4 89 55 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EDX
00008: 02B7 D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00008: 02BA 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 02BD 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 02C0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02C7 29 D3                       SUB EBX, EDX
00008: 02C9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02CC 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 02D2 89 7C DE 30                 MOV DWORD PTR 00000030[ESI][EBX*8], EDI

; 161:       a[i].i.y.i=a[i].r.y/bound[1].dl;

00008: 02D6 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 02D9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02E0 29 D3                       SUB EBX, EDX
00008: 02E2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02E5 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 02EB DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 02EF DC 35 00000020              FDIV QWORD PTR _bound+00000020
00007: 02F5 D9 7D FFFFFFC8              FNSTCW WORD PTR FFFFFFC8[EBP]
00007: 02F8 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00007: 02FB 80 4D FFFFFFC9 0C           OR BYTE PTR FFFFFFC9[EBP], 0C
00007: 02FF D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00007: 0302 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0305 89 55 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EDX
00008: 0308 D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00008: 030B 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 030E 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0311 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0318 29 D3                       SUB EBX, EDX
00008: 031A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 031D 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0323 89 7C DE 38                 MOV DWORD PTR 00000038[ESI][EBX*8], EDI

; 162:       a[i].i.z.i=a[i].r.z/bound[2].dl;            

00008: 0327 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 032A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0331 29 D3                       SUB EBX, EDX
00008: 0333 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0336 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 033C DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0340 DC 35 00000038              FDIV QWORD PTR _bound+00000038
00007: 0346 D9 7D FFFFFFC8              FNSTCW WORD PTR FFFFFFC8[EBP]
00007: 0349 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00007: 034C 80 4D FFFFFFC9 0C           OR BYTE PTR FFFFFFC9[EBP], 0C
00007: 0350 D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00007: 0353 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0356 89 55 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EDX
00008: 0359 D9 6D FFFFFFC8              FLDCW WORD PTR FFFFFFC8[EBP]
00008: 035C 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 035F 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0362 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0369 29 D3                       SUB EBX, EDX
00008: 036B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 036E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0374 89 7C DE 40                 MOV DWORD PTR 00000040[ESI][EBX*8], EDI

; 163:       a[i].add=a[i].i.x.i+(a[i].i.y.i+a[i].i.z.i*bound[1].period)*bound[0].period;

00008: 0378 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 037B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0382 29 D3                       SUB EBX, EDX
00008: 0384 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0387 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 038D 8B 3D 00000028              MOV EDI, DWORD PTR _bound+00000028
00008: 0393 0F AF 7C DE 40              IMUL EDI, DWORD PTR 00000040[ESI][EBX*8]
00008: 0398 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 039B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03A2 29 D3                       SUB EBX, EDX
00008: 03A4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03A7 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 03AD 03 7C DE 38                 ADD EDI, DWORD PTR 00000038[ESI][EBX*8]
00008: 03B1 0F AF 3D 00000010           IMUL EDI, DWORD PTR _bound+00000010
00008: 03B8 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 03BB 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03C2 29 D3                       SUB EBX, EDX
00008: 03C4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03C7 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 03CD 03 7C DE 30                 ADD EDI, DWORD PTR 00000030[ESI][EBX*8]
00008: 03D1 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 03D4 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03DB 29 D3                       SUB EBX, EDX
00008: 03DD 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03E0 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 03E6 89 BC DE 000000A0           MOV DWORD PTR 000000A0[ESI][EBX*8], EDI

; 164:       a[i].t=timeb;

00008: 03ED 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 03F0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03F7 29 D3                       SUB EBX, EDX
00008: 03F9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03FC 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0402 DD 05 00000000              FLD QWORD PTR _timeb
00007: 0408 DD 5C DA 78                 FSTP QWORD PTR 00000078[EDX][EBX*8]

; 165:       mvx+=a[i].m*a[i].v.x;

00008: 040C 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 040F 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0416 29 D6                       SUB ESI, EDX
00008: 0418 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 041B 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0421 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0424 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 042B 29 D3                       SUB EBX, EDX
00008: 042D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0430 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0436 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 043D DC 4C F7 18                 FMUL QWORD PTR 00000018[EDI][ESI*8]
00007: 0441 DC 45 FFFFFFCC              FADD QWORD PTR FFFFFFCC[EBP]
00007: 0444 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 166:       mvy+=a[i].m*a[i].v.y;

00008: 0447 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 044A 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0451 29 D6                       SUB ESI, EDX
00008: 0453 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0456 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 045C 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 045F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0466 29 D3                       SUB EBX, EDX
00008: 0468 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 046B 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0471 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 0478 DC 4C F7 20                 FMUL QWORD PTR 00000020[EDI][ESI*8]
00007: 047C DC 45 FFFFFFD4              FADD QWORD PTR FFFFFFD4[EBP]
00007: 047F DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 167:       mvz+=a[i].m*a[i].v.z;

00008: 0482 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0485 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 048C 29 D6                       SUB ESI, EDX
00008: 048E 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0491 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0497 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 049A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04A1 29 D3                       SUB EBX, EDX
00008: 04A3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04A6 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 04AC DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 04B3 DC 4C F7 28                 FMUL QWORD PTR 00000028[EDI][ESI*8]
00007: 04B7 DC 45 FFFFFFDC              FADD QWORD PTR FFFFFFDC[EBP]
00007: 04BA DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 168:       mass+=a[i].m;

00008: 04BD 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 04C0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04C7 29 D3                       SUB EBX, EDX
00008: 04C9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04CC 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 04D2 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 04D5 DC 84 DA 00000088           FADD QWORD PTR 00000088[EDX][EBX*8]
00007: 04DC DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 169:     }

00008: 04DF FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 04E2                     L0001:
00008: 04E2 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 04E5 3B 05 00000000              CMP EAX, DWORD PTR _n
00008: 04EB 0F 8E FFFFFBDF              JLE L0002

; 170:   mvx/=mass;

00008: 04F1 DD 45 FFFFFFCC              FLD QWORD PTR FFFFFFCC[EBP]
00007: 04F4 DC 75 FFFFFFE4              FDIV QWORD PTR FFFFFFE4[EBP]
00007: 04F7 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 171:   mvy/=mass;

00008: 04FA DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 04FD DC 75 FFFFFFE4              FDIV QWORD PTR FFFFFFE4[EBP]
00007: 0500 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 172:   mvz/=mass;

00008: 0503 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 0506 DC 75 FFFFFFE4              FDIV QWORD PTR FFFFFFE4[EBP]
00007: 0509 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 173:   for(i=0;i<=n;i++)

00008: 050C C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 0513 E9 000000D0                 JMP L0009
00008: 0518                     L000A:

; 175:       a[i].v.x-=mvx;

00008: 0518 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 051B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0522 29 D3                       SUB EBX, EDX
00008: 0524 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0527 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 052D DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 0531 DC 65 FFFFFFCC              FSUB QWORD PTR FFFFFFCC[EBP]
00007: 0534 DD 5C DA 18                 FSTP QWORD PTR 00000018[EDX][EBX*8]

; 176:       a[i].v.y-=mvy;

00008: 0538 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 053B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0542 29 D3                       SUB EBX, EDX
00008: 0544 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0547 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 054D DD 44 DA 20                 FLD QWORD PTR 00000020[EDX][EBX*8]
00007: 0551 DC 65 FFFFFFD4              FSUB QWORD PTR FFFFFFD4[EBP]
00007: 0554 DD 5C DA 20                 FSTP QWORD PTR 00000020[EDX][EBX*8]

; 177:       a[i].v.z-=mvz;

00008: 0558 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 055B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0562 29 D3                       SUB EBX, EDX
00008: 0564 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0567 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 056D DD 44 DA 28                 FLD QWORD PTR 00000028[EDX][EBX*8]
00007: 0571 DC 65 FFFFFFDC              FSUB QWORD PTR FFFFFFDC[EBP]
00007: 0574 DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 178:       vvm+=a[i].m*dist(a[i].v,o);

00008: 0578 83 0C 24 00                 OR DWORD PTR 00000000[ESP], 00000000
00008: 057C 83 EC 18                    SUB ESP, 00000018
00008: 057F 8D 35 00000000              LEA ESI, DWORD PTR _o
00008: 0585 89 E7                       MOV EDI, ESP
00008: 0587 A5                          MOVSD 
00008: 0588 A5                          MOVSD 
00008: 0589 A5                          MOVSD 
00008: 058A A5                          MOVSD 
00008: 058B A5                          MOVSD 
00008: 058C A5                          MOVSD 
00008: 058D 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0590 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0597 29 D3                       SUB EBX, EDX
00008: 0599 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 059C 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 05A2 83 0C 24 00                 OR DWORD PTR 00000000[ESP], 00000000
00008: 05A6 83 EC 18                    SUB ESP, 00000018
00008: 05A9 8D 74 DA 18                 LEA ESI, DWORD PTR 00000018[EDX][EBX*8]
00008: 05AD 89 E7                       MOV EDI, ESP
00008: 05AF A5                          MOVSD 
00008: 05B0 A5                          MOVSD 
00008: 05B1 A5                          MOVSD 
00008: 05B2 A5                          MOVSD 
00008: 05B3 A5                          MOVSD 
00008: 05B4 A5                          MOVSD 
00008: 05B5 E8 00000000                 CALL SHORT _dist
00007: 05BA 83 C4 30                    ADD ESP, 00000030
00007: 05BD 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00007: 05C0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 05C7 29 D3                       SUB EBX, EDX
00007: 05C9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 05CC 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 05D2 DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 05D9 DC 05 00000000              FADD QWORD PTR _vvm
00007: 05DF DD 1D 00000000              FSTP QWORD PTR _vvm

; 179:     }

00008: 05E5 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 05E8                     L0009:
00008: 05E8 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 05EB 3B 05 00000000              CMP EAX, DWORD PTR _n
00008: 05F1 0F 8E FFFFFF21              JLE L000A

; 180:   printf("%lf %lf %lf \n",mvx,mvy,mvz);

00008: 05F7 FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 05FA FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 05FD FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0600 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0603 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 0606 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0609 68 00000000                 PUSH OFFSET @151
00008: 060E E8 00000000                 CALL SHORT _printf
00008: 0613 83 C4 1C                    ADD ESP, 0000001C

; 181:   vvm*=0.5;

00008: 0616 DD 05 00000000              FLD QWORD PTR _vvm
00007: 061C DC 0D 00000000              FMUL QWORD PTR .data+00000080
00007: 0622 DD 1D 00000000              FSTP QWORD PTR _vvm

; 182:   if(!corr_2){corr_2=1;corr=sqrt(corr_2);}

00008: 0628 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 062E DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0634 F1DF                        FCOMIP ST, ST(1), L000B
00007: 0636 DD D8                       FSTP ST
00008: 0638 7A 2F                       JP L000B
00008: 063A 75 2D                       JNE L000B
00008: 063C C7 05 00000004 3FF00000     MOV DWORD PTR _corr_2+00000004, 3FF00000
00008: 0646 C7 05 00000000 00000000     MOV DWORD PTR _corr_2, 00000000
00008: 0650 FF 35 00000004              PUSH DWORD PTR _corr_2+00000004
00008: 0656 FF 35 00000000              PUSH DWORD PTR _corr_2
00008: 065C E8 00000000                 CALL SHORT _sqrt
00007: 0661 59                          POP ECX
00007: 0662 59                          POP ECX
00007: 0663 DD 1D 00000000              FSTP QWORD PTR _corr
00008: 0669                     L000B:

; 183:   delta2=0;

00008: 0669 C7 05 00000004 00000000     MOV DWORD PTR _delta2+00000004, 00000000
00008: 0673 C7 05 00000000 00000000     MOV DWORD PTR _delta2, 00000000

; 184:   delta4=0;

00008: 067D C7 05 00000004 00000000     MOV DWORD PTR _delta4+00000004, 00000000
00008: 0687 C7 05 00000000 00000000     MOV DWORD PTR _delta4, 00000000

; 185:   delta6=0;

00008: 0691 C7 05 00000004 00000000     MOV DWORD PTR _delta6+00000004, 00000000
00008: 069B C7 05 00000000 00000000     MOV DWORD PTR _delta6, 00000000

; 186:   delta1=1000;

00008: 06A5 C7 05 00000004 408F4000     MOV DWORD PTR _delta1+00000004, 408F4000
00008: 06AF C7 05 00000000 00000000     MOV DWORD PTR _delta1, 00000000

; 187:   delta3=1000;

00008: 06B9 C7 05 00000004 408F4000     MOV DWORD PTR _delta3+00000004, 408F4000
00008: 06C3 C7 05 00000000 00000000     MOV DWORD PTR _delta3, 00000000

; 188:   delta5=1000;

00008: 06CD C7 05 00000004 408F4000     MOV DWORD PTR _delta5+00000004, 408F4000
00008: 06D7 C7 05 00000000 00000000     MOV DWORD PTR _delta5, 00000000

; 189:   dticks=60;

00008: 06E1 C7 05 00000004 404E0000     MOV DWORD PTR _dticks+00000004, 404E0000
00008: 06EB C7 05 00000000 00000000     MOV DWORD PTR _dticks, 00000000

; 190:   xyz[0]=1;

00008: 06F5 C7 05 00000000 00000001     MOV DWORD PTR _xyz, 00000001

; 191:   xyz[2]=2;

00008: 06FF C7 05 00000008 00000002     MOV DWORD PTR _xyz+00000008, 00000002

; 192:   xyz[3]=3;

00008: 0709 C7 05 0000000C 00000003     MOV DWORD PTR _xyz+0000000C, 00000003

; 193:   xyz[1]=1;

00008: 0713 C7 05 00000004 00000001     MOV DWORD PTR _xyz+00000004, 00000001

; 194:   deltall=n1;

00008: 071D 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 0723 89 15 00000000              MOV DWORD PTR _deltall, EDX

; 195:   if(deltall<DELTALL)deltall=DELTALL;

00008: 0729 83 3D 00000000 64           CMP DWORD PTR _deltall, 00000064
00008: 0730 7D 0A                       JGE L000C
00008: 0732 C7 05 00000000 00000064     MOV DWORD PTR _deltall, 00000064
00008: 073C                     L000C:

; 196:   potential=0;

00008: 073C C7 05 00000004 00000000     MOV DWORD PTR _potential+00000004, 00000000
00008: 0746 C7 05 00000000 00000000     MOV DWORD PTR _potential, 00000000

; 197:   pressure=dblarg1;

00008: 0750 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0756 DD 1D 00000000              FSTP QWORD PTR _pressure

; 198:   temperature=dblarg1;

00008: 075C DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0762 DD 1D 00000000              FSTP QWORD PTR _temperature

; 199:   avePot=dblarg1;

00008: 0768 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 076E DD 1D 00000000              FSTP QWORD PTR _avePot

; 200:   mes_time=dblarg1;

00008: 0774 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 077A DD 1D 00000000              FSTP QWORD PTR _mes_time

; 201:   coeff=0;

00008: 0780 C7 05 00000004 00000000     MOV DWORD PTR _coeff+00000004, 00000000
00008: 078A C7 05 00000000 00000000     MOV DWORD PTR _coeff, 00000000

; 202:   temp_limit=0;

00008: 0794 C7 05 00000004 00000000     MOV DWORD PTR _temp_limit+00000004, 00000000
00008: 079E C7 05 00000000 00000000     MOV DWORD PTR _temp_limit, 00000000

; 203:   timep=0;

00008: 07A8 C7 05 00000004 00000000     MOV DWORD PTR _timep+00000004, 00000000
00008: 07B2 C7 05 00000000 00000000     MOV DWORD PTR _timep, 00000000

; 204:   vvmtime=0;

00008: 07BC C7 05 00000004 00000000     MOV DWORD PTR _vvmtime+00000004, 00000000
00008: 07C6 C7 05 00000000 00000000     MOV DWORD PTR _vvmtime, 00000000

; 205:   virial=0;

00008: 07D0 C7 05 00000004 00000000     MOV DWORD PTR _virial+00000004, 00000000
00008: 07DA C7 05 00000000 00000000     MOV DWORD PTR _virial, 00000000

; 206:   volume=1;

00008: 07E4 C7 05 00000004 3FF00000     MOV DWORD PTR _volume+00000004, 3FF00000
00008: 07EE C7 05 00000000 00000000     MOV DWORD PTR _volume, 00000000

; 207:   dim=0;

00008: 07F8 C7 05 00000004 00000000     MOV DWORD PTR _dim+00000004, 00000000
00008: 0802 C7 05 00000000 00000000     MOV DWORD PTR _dim, 00000000

; 208:   for(i=0;i<3;i++)

00008: 080C C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 0813 EB 3A                       JMP L000D
00008: 0815                     L000E:

; 209:   if(is_x[i])

00008: 0815 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 0818 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 081B 83 3C 88 00                 CMP DWORD PTR 00000000[EAX][ECX*4], 00000000
00008: 081F 74 2B                       JE L000F

; 211:   volume*=bound[i].length;

00008: 0821 8B 5D FFFFFFC4              MOV EBX, DWORD PTR FFFFFFC4[EBP]
00008: 0824 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0827 DD 05 00000000              FLD QWORD PTR _volume
00007: 082D DC 0C DD 00000000           FMUL QWORD PTR _bound[EBX*8]
00007: 0834 DD 1D 00000000              FSTP QWORD PTR _volume

; 212:   dim++;

00008: 083A DD 05 00000000              FLD QWORD PTR _dim
00007: 0840 D8 05 00000000              FADD DWORD PTR .data+00000088
00007: 0846 DD 1D 00000000              FSTP QWORD PTR _dim

; 213:   }

00008: 084C                     L000F:
00008: 084C FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 084F                     L000D:
00008: 084F 83 7D FFFFFFC4 03           CMP DWORD PTR FFFFFFC4[EBP], 00000003
00008: 0853 7C FFFFFFC0                 JL L000E

; 214:   if(!is_x[2])bound[2].period=1;

00008: 0855 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0858 83 78 08 00                 CMP DWORD PTR 00000008[EAX], 00000000
00008: 085C 75 0A                       JNE L0010
00008: 085E C7 05 00000040 00000001     MOV DWORD PTR _bound+00000040, 00000001
00008: 0868                     L0010:

; 215:   return; 

00000: 0868                     L0000:
00000: 0868                             epilog 
00000: 0868 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 086B 5F                          POP EDI
00000: 086C 5E                          POP ESI
00000: 086D 5B                          POP EBX
00000: 086E 5D                          POP EBP
00000: 086F C3                          RETN 

Function: _sqrt

; 552: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: if(x >=0.0)

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 05 00000000              FLD QWORD PTR .data+00000050
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

Function: _cleanup

; 218: {  

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

; 220:   double mvx=0,mvy=0,mvz=0,mass=0;

00008: 0018 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 001E DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]
00008: 0021 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0027 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]
00008: 002A DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0030 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]
00008: 0033 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0039 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 222:   double corr1=1/corr;

00008: 003C DD 05 00000000              FLD QWORD PTR .data+00000090
00007: 0042 DC 35 00000000              FDIV QWORD PTR _corr
00007: 0048 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 223:   px=bound[0].period-1;

00008: 004B 8B 15 00000010              MOV EDX, DWORD PTR _bound+00000010
00008: 0051 4A                          DEC EDX
00008: 0052 89 15 00000000              MOV DWORD PTR _px, EDX

; 224:   py=bound[1].period-1;

00008: 0058 8B 15 00000028              MOV EDX, DWORD PTR _bound+00000028
00008: 005E 4A                          DEC EDX
00008: 005F 89 15 00000000              MOV DWORD PTR _py, EDX

; 225:   pz=bound[2].period-1;

00008: 0065 8B 15 00000040              MOV EDX, DWORD PTR _bound+00000040
00008: 006B 4A                          DEC EDX
00008: 006C 89 15 00000000              MOV DWORD PTR _pz, EDX

; 226:   lx=bound[0].length;

00008: 0072 DD 05 00000000              FLD QWORD PTR _bound
00007: 0078 DD 1D 00000000              FSTP QWORD PTR _lx

; 227:   ly=bound[1].length;

00008: 007E DD 05 00000018              FLD QWORD PTR _bound+00000018
00007: 0084 DD 1D 00000000              FSTP QWORD PTR _ly

; 228:   lz=bound[2].length;

00008: 008A DD 05 00000030              FLD QWORD PTR _bound+00000030
00007: 0090 DD 1D 00000000              FSTP QWORD PTR _lz

; 229:   printf("cleanup");

00008: 0096 68 00000000                 PUSH OFFSET @194
00008: 009B E8 00000000                 CALL SHORT _printf
00008: 00A0 59                          POP ECX

; 230:   update_atoms();

00008: 00A1 E8 00000000                 CALL SHORT _update_atoms

; 231:   moveatoms();

00008: 00A6 E8 00000000                 CALL SHORT _moveatoms

; 232:   for( i=0;i<n1;i++)

00008: 00AB C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 00B2 EB 63                       JMP L0001
00008: 00B4                     L0002:

; 234:       a[i].v.x*=corr1;

00008: 00B4 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 00B7 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00BE 29 D3                       SUB EBX, EDX
00008: 00C0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00C3 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 00C9 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 00CD DC 4D FFFFFFE4              FMUL QWORD PTR FFFFFFE4[EBP]
00007: 00D0 DD 5C DA 18                 FSTP QWORD PTR 00000018[EDX][EBX*8]

; 235:       a[i].v.y*=corr1;

00008: 00D4 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 00D7 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00DE 29 D3                       SUB EBX, EDX
00008: 00E0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00E3 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 00E9 DD 44 DA 20                 FLD QWORD PTR 00000020[EDX][EBX*8]
00007: 00ED DC 4D FFFFFFE4              FMUL QWORD PTR FFFFFFE4[EBP]
00007: 00F0 DD 5C DA 20                 FSTP QWORD PTR 00000020[EDX][EBX*8]

; 236:       a[i].v.z*=corr1;

00008: 00F4 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 00F7 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00FE 29 D3                       SUB EBX, EDX
00008: 0100 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0103 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0109 DD 44 DA 28                 FLD QWORD PTR 00000028[EDX][EBX*8]
00007: 010D DC 4D FFFFFFE4              FMUL QWORD PTR FFFFFFE4[EBP]
00007: 0110 DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 237:     }

00008: 0114 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0117                     L0001:
00008: 0117 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 011A 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 0120 7C FFFFFF92                 JL L0002

; 238:   reset_colldata();

00008: 0122 E8 00000000                 CALL SHORT _reset_colldata

; 239:   vvm/=corr_2;    

00008: 0127 DD 05 00000000              FLD QWORD PTR _vvm
00007: 012D DC 35 00000000              FDIV QWORD PTR _corr_2
00007: 0133 DD 1D 00000000              FSTP QWORD PTR _vvm

; 240:   corr_2=corr=1;

00008: 0139 C7 05 00000004 3FF00000     MOV DWORD PTR _corr+00000004, 3FF00000
00008: 0143 C7 05 00000000 00000000     MOV DWORD PTR _corr, 00000000
00008: 014D DD 05 00000000              FLD QWORD PTR _corr
00007: 0153 DD 1D 00000000              FSTP QWORD PTR _corr_2

; 241:   timed+=timec;

00008: 0159 DD 05 00000000              FLD QWORD PTR _timed
00007: 015F DC 05 00000000              FADD QWORD PTR _timec
00007: 0165 DD 1D 00000000              FSTP QWORD PTR _timed

; 242:   timec=timeb=0;

00008: 016B C7 05 00000004 00000000     MOV DWORD PTR _timeb+00000004, 00000000
00008: 0175 C7 05 00000000 00000000     MOV DWORD PTR _timeb, 00000000
00008: 017F DD 05 00000000              FLD QWORD PTR _timeb
00007: 0185 DD 1D 00000000              FSTP QWORD PTR _timec

; 243:    for(i=0;i<=n;i++)

00008: 018B C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 0192 E9 00000412                 JMP L0003
00008: 0197                     L0004:

; 245:       if(a[i].r.x>=lx) a[i].r.x-=lx;

00008: 0197 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 019A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01A1 29 D3                       SUB EBX, EDX
00008: 01A3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01A6 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01AC DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 01AF DD 05 00000000              FLD QWORD PTR _lx
00006: 01B5 F1DF                        FCOMIP ST, ST(1), L0005
00007: 01B7 DD D8                       FSTP ST
00008: 01B9 7A 23                       JP L0005
00008: 01BB 77 21                       JA L0005
00008: 01BD 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 01C0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01C7 29 D3                       SUB EBX, EDX
00008: 01C9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01CC 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01D2 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 01D5 DC 25 00000000              FSUB QWORD PTR _lx
00007: 01DB DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]
00008: 01DE                     L0005:

; 246:       if(a[i].r.x<0) a[i].r.x+=lx;

00008: 01DE 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 01E1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01E8 29 D3                       SUB EBX, EDX
00008: 01EA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01ED 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01F3 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 01F6 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 01FC F1DF                        FCOMIP ST, ST(1), L0006
00007: 01FE DD D8                       FSTP ST
00008: 0200 7A 23                       JP L0006
00008: 0202 76 21                       JBE L0006
00008: 0204 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0207 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 020E 29 D3                       SUB EBX, EDX
00008: 0210 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0213 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0219 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 021C DC 05 00000000              FADD QWORD PTR _lx
00007: 0222 DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]
00008: 0225                     L0006:

; 247:       if(a[i].r.y>=ly) a[i].r.y-=ly;

00008: 0225 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0228 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 022F 29 D3                       SUB EBX, EDX
00008: 0231 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0234 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 023A DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 023E DD 05 00000000              FLD QWORD PTR _ly
00006: 0244 F1DF                        FCOMIP ST, ST(1), L0007
00007: 0246 DD D8                       FSTP ST
00008: 0248 7A 25                       JP L0007
00008: 024A 77 23                       JA L0007
00008: 024C 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 024F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0256 29 D3                       SUB EBX, EDX
00008: 0258 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 025B 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0261 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0265 DC 25 00000000              FSUB QWORD PTR _ly
00007: 026B DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]
00008: 026F                     L0007:

; 248:       if(a[i].r.y<0) a[i].r.y+=ly;

00008: 026F 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0272 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0279 29 D3                       SUB EBX, EDX
00008: 027B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 027E 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0284 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0288 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 028E F1DF                        FCOMIP ST, ST(1), L0008
00007: 0290 DD D8                       FSTP ST
00008: 0292 7A 25                       JP L0008
00008: 0294 76 23                       JBE L0008
00008: 0296 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0299 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02A0 29 D3                       SUB EBX, EDX
00008: 02A2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02A5 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 02AB DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 02AF DC 05 00000000              FADD QWORD PTR _ly
00007: 02B5 DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]
00008: 02B9                     L0008:

; 249:       if(a[i].r.z>=lz) a[i].r.z-=lz;

00008: 02B9 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 02BC 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02C3 29 D3                       SUB EBX, EDX
00008: 02C5 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02C8 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 02CE DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 02D2 DD 05 00000000              FLD QWORD PTR _lz
00006: 02D8 F1DF                        FCOMIP ST, ST(1), L0009
00007: 02DA DD D8                       FSTP ST
00008: 02DC 7A 25                       JP L0009
00008: 02DE 77 23                       JA L0009
00008: 02E0 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 02E3 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02EA 29 D3                       SUB EBX, EDX
00008: 02EC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02EF 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 02F5 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 02F9 DC 25 00000000              FSUB QWORD PTR _lz
00007: 02FF DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]
00008: 0303                     L0009:

; 250:       if(a[i].r.z<0) a[i].r.z+=lz;

00008: 0303 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0306 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 030D 29 D3                       SUB EBX, EDX
00008: 030F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0312 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0318 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 031C DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0322 F1DF                        FCOMIP ST, ST(1), L000A
00007: 0324 DD D8                       FSTP ST
00008: 0326 7A 25                       JP L000A
00008: 0328 76 23                       JBE L000A
00008: 032A 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 032D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0334 29 D3                       SUB EBX, EDX
00008: 0336 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0339 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 033F DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0343 DC 05 00000000              FADD QWORD PTR _lz
00007: 0349 DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]
00008: 034D                     L000A:

; 251:       a[i].i.x.i=a[i].r.x/bound[0].dl;

00008: 034D 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0350 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0357 29 D3                       SUB EBX, EDX
00008: 0359 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 035C 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0362 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 0365 DC 35 00000008              FDIV QWORD PTR _bound+00000008
00007: 036B D9 7D FFFFFFB8              FNSTCW WORD PTR FFFFFFB8[EBP]
00007: 036E 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00007: 0371 80 4D FFFFFFB9 0C           OR BYTE PTR FFFFFFB9[EBP], 0C
00007: 0375 D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00007: 0378 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 037B 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX
00008: 037E D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00008: 0381 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 0384 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0387 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 038E 29 D3                       SUB EBX, EDX
00008: 0390 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0393 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0399 89 7C DE 30                 MOV DWORD PTR 00000030[ESI][EBX*8], EDI

; 252:       a[i].i.y.i=a[i].r.y/bound[1].dl;

00008: 039D 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 03A0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03A7 29 D3                       SUB EBX, EDX
00008: 03A9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03AC 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 03B2 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 03B6 DC 35 00000020              FDIV QWORD PTR _bound+00000020
00007: 03BC D9 7D FFFFFFB8              FNSTCW WORD PTR FFFFFFB8[EBP]
00007: 03BF 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00007: 03C2 80 4D FFFFFFB9 0C           OR BYTE PTR FFFFFFB9[EBP], 0C
00007: 03C6 D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00007: 03C9 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 03CC 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX
00008: 03CF D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00008: 03D2 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 03D5 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 03D8 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03DF 29 D3                       SUB EBX, EDX
00008: 03E1 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03E4 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 03EA 89 7C DE 38                 MOV DWORD PTR 00000038[ESI][EBX*8], EDI

; 253:       a[i].i.z.i=a[i].r.z/bound[2].dl;            

00008: 03EE 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 03F1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03F8 29 D3                       SUB EBX, EDX
00008: 03FA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03FD 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0403 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0407 DC 35 00000038              FDIV QWORD PTR _bound+00000038
00007: 040D D9 7D FFFFFFB8              FNSTCW WORD PTR FFFFFFB8[EBP]
00007: 0410 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00007: 0413 80 4D FFFFFFB9 0C           OR BYTE PTR FFFFFFB9[EBP], 0C
00007: 0417 D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00007: 041A DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 041D 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX
00008: 0420 D9 6D FFFFFFB8              FLDCW WORD PTR FFFFFFB8[EBP]
00008: 0423 8B 7D FFFFFFEC              MOV EDI, DWORD PTR FFFFFFEC[EBP]
00008: 0426 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0429 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0430 29 D3                       SUB EBX, EDX
00008: 0432 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0435 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 043B 89 7C DE 40                 MOV DWORD PTR 00000040[ESI][EBX*8], EDI

; 254:       a[i].add=a[i].i.x.i+(a[i].i.y.i+a[i].i.z.i*bound[1].period)*bound[0].period;

00008: 043F 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0442 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0449 29 D3                       SUB EBX, EDX
00008: 044B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 044E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0454 8B 3D 00000028              MOV EDI, DWORD PTR _bound+00000028
00008: 045A 0F AF 7C DE 40              IMUL EDI, DWORD PTR 00000040[ESI][EBX*8]
00008: 045F 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0462 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0469 29 D3                       SUB EBX, EDX
00008: 046B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 046E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0474 03 7C DE 38                 ADD EDI, DWORD PTR 00000038[ESI][EBX*8]
00008: 0478 0F AF 3D 00000010           IMUL EDI, DWORD PTR _bound+00000010
00008: 047F 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0482 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0489 29 D3                       SUB EBX, EDX
00008: 048B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 048E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0494 03 7C DE 30                 ADD EDI, DWORD PTR 00000030[ESI][EBX*8]
00008: 0498 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 049B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04A2 29 D3                       SUB EBX, EDX
00008: 04A4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04A7 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 04AD 89 BC DE 000000A0           MOV DWORD PTR 000000A0[ESI][EBX*8], EDI

; 255:       a[i].t=timeb;

00008: 04B4 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 04B7 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04BE 29 D3                       SUB EBX, EDX
00008: 04C0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04C3 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 04C9 DD 05 00000000              FLD QWORD PTR _timeb
00007: 04CF DD 5C DA 78                 FSTP QWORD PTR 00000078[EDX][EBX*8]

; 256:       mvx+=a[i].m*a[i].v.x;

00008: 04D3 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 04D6 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 04DD 29 D6                       SUB ESI, EDX
00008: 04DF 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 04E2 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 04E8 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 04EB 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04F2 29 D3                       SUB EBX, EDX
00008: 04F4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04F7 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 04FD DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 0504 DC 4C F7 18                 FMUL QWORD PTR 00000018[EDI][ESI*8]
00007: 0508 DC 45 FFFFFFBC              FADD QWORD PTR FFFFFFBC[EBP]
00007: 050B DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 257:       mvy+=a[i].m*a[i].v.y;

00008: 050E 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0511 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0518 29 D6                       SUB ESI, EDX
00008: 051A 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 051D 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0523 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0526 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 052D 29 D3                       SUB EBX, EDX
00008: 052F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0532 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0538 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 053F DC 4C F7 20                 FMUL QWORD PTR 00000020[EDI][ESI*8]
00007: 0543 DC 45 FFFFFFC4              FADD QWORD PTR FFFFFFC4[EBP]
00007: 0546 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]

; 258:       mvz+=a[i].m*a[i].v.z;

00008: 0549 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 054C 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0553 29 D6                       SUB ESI, EDX
00008: 0555 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0558 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 055E 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0561 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0568 29 D3                       SUB EBX, EDX
00008: 056A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 056D 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0573 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 057A DC 4C F7 28                 FMUL QWORD PTR 00000028[EDI][ESI*8]
00007: 057E DC 45 FFFFFFCC              FADD QWORD PTR FFFFFFCC[EBP]
00007: 0581 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 259:       mass+=a[i].m;

00008: 0584 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0587 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 058E 29 D3                       SUB EBX, EDX
00008: 0590 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0593 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0599 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 059C DC 84 DA 00000088           FADD QWORD PTR 00000088[EDX][EBX*8]
00007: 05A3 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 260:     }

00008: 05A6 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 05A9                     L0003:
00008: 05A9 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 05AC 3B 05 00000000              CMP EAX, DWORD PTR _n
00008: 05B2 0F 8E FFFFFBDF              JLE L0004

; 261:   mvx/=mass;

00008: 05B8 DD 45 FFFFFFBC              FLD QWORD PTR FFFFFFBC[EBP]
00007: 05BB DC 75 FFFFFFD4              FDIV QWORD PTR FFFFFFD4[EBP]
00007: 05BE DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 262:   mvy/=mass;

00008: 05C1 DD 45 FFFFFFC4              FLD QWORD PTR FFFFFFC4[EBP]
00007: 05C4 DC 75 FFFFFFD4              FDIV QWORD PTR FFFFFFD4[EBP]
00007: 05C7 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]

; 263:   mvz/=mass;

00008: 05CA DD 45 FFFFFFCC              FLD QWORD PTR FFFFFFCC[EBP]
00007: 05CD DC 75 FFFFFFD4              FDIV QWORD PTR FFFFFFD4[EBP]
00007: 05D0 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 264:   vvm1=0.0;

00008: 05D3 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 05D9 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 266:   stop_atoms((moved_iatom*)a,n1); 

00008: 05DC A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 05E1 50                          PUSH EAX
00008: 05E2 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 05E7 50                          PUSH EAX
00008: 05E8 E8 00000000                 CALL SHORT _stop_atoms
00008: 05ED 59                          POP ECX
00008: 05EE 59                          POP ECX

; 267:   for(i=0;i<=n;i++)

00008: 05EF C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 05F6 E9 00000100                 JMP L000B
00008: 05FB                     L000C:

; 269:       a[i].v.x=a[i].u.x;

00008: 05FB 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 05FE 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0605 29 D6                       SUB ESI, EDX
00008: 0607 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 060A 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0610 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0613 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 061A 29 D3                       SUB EBX, EDX
00008: 061C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 061F 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0625 DD 44 F7 60                 FLD QWORD PTR 00000060[EDI][ESI*8]
00007: 0629 DD 5C DA 18                 FSTP QWORD PTR 00000018[EDX][EBX*8]

; 270:       a[i].v.y=a[i].u.y;

00008: 062D 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0630 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0637 29 D6                       SUB ESI, EDX
00008: 0639 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 063C 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0642 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0645 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 064C 29 D3                       SUB EBX, EDX
00008: 064E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0651 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0657 DD 44 F7 68                 FLD QWORD PTR 00000068[EDI][ESI*8]
00007: 065B DD 5C DA 20                 FSTP QWORD PTR 00000020[EDX][EBX*8]

; 271:       a[i].v.z=a[i].u.z;

00008: 065F 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0662 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0669 29 D6                       SUB ESI, EDX
00008: 066B 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 066E 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0674 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0677 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 067E 29 D3                       SUB EBX, EDX
00008: 0680 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0683 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0689 DD 44 F7 70                 FLD QWORD PTR 00000070[EDI][ESI*8]
00007: 068D DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 272:       vvm1+=a[i].m*dist(a[i].v,o);

00008: 0691 83 0C 24 00                 OR DWORD PTR 00000000[ESP], 00000000
00008: 0695 83 EC 18                    SUB ESP, 00000018
00008: 0698 8D 35 00000000              LEA ESI, DWORD PTR _o
00008: 069E 89 E7                       MOV EDI, ESP
00008: 06A0 A5                          MOVSD 
00008: 06A1 A5                          MOVSD 
00008: 06A2 A5                          MOVSD 
00008: 06A3 A5                          MOVSD 
00008: 06A4 A5                          MOVSD 
00008: 06A5 A5                          MOVSD 
00008: 06A6 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 06A9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 06B0 29 D3                       SUB EBX, EDX
00008: 06B2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 06B5 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 06BB 83 0C 24 00                 OR DWORD PTR 00000000[ESP], 00000000
00008: 06BF 83 EC 18                    SUB ESP, 00000018
00008: 06C2 8D 74 DA 18                 LEA ESI, DWORD PTR 00000018[EDX][EBX*8]
00008: 06C6 89 E7                       MOV EDI, ESP
00008: 06C8 A5                          MOVSD 
00008: 06C9 A5                          MOVSD 
00008: 06CA A5                          MOVSD 
00008: 06CB A5                          MOVSD 
00008: 06CC A5                          MOVSD 
00008: 06CD A5                          MOVSD 
00008: 06CE E8 00000000                 CALL SHORT _dist
00007: 06D3 83 C4 30                    ADD ESP, 00000030
00007: 06D6 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00007: 06D9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 06E0 29 D3                       SUB EBX, EDX
00007: 06E2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 06E5 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 06EB DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 06F2 DC 45 FFFFFFDC              FADD QWORD PTR FFFFFFDC[EBP]
00007: 06F5 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 273:     }

00008: 06F8 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 06FB                     L000B:
00008: 06FB 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 06FE 3B 05 00000000              CMP EAX, DWORD PTR _n
00008: 0704 0F 8E FFFFFEF1              JLE L000C

; 283:   printf("%lf %lf %lf \n",mvx,mvy,mvz);

00008: 070A FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 070D FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0710 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 0713 FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 0716 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 0719 FF 75 FFFFFFBC              PUSH DWORD PTR FFFFFFBC[EBP]
00008: 071C 68 00000000                 PUSH OFFSET @151
00008: 0721 E8 00000000                 CALL SHORT _printf
00008: 0726 83 C4 1C                    ADD ESP, 0000001C

; 284:   vvm1*=0.5;

00008: 0729 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 072C DC 0D 00000000              FMUL QWORD PTR .data+00000080
00007: 0732 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 285:   printf("%lf %lf\n",vvm1,vvm);

00008: 0735 FF 35 00000004              PUSH DWORD PTR _vvm+00000004
00008: 073B FF 35 00000000              PUSH DWORD PTR _vvm
00008: 0741 FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 0744 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 0747 68 00000000                 PUSH OFFSET @195
00008: 074C E8 00000000                 CALL SHORT _printf
00008: 0751 83 C4 14                    ADD ESP, 00000014

; 286:   if(!vvm1)return 0;

00008: 0754 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 0757 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 075D F1DF                        FCOMIP ST, ST(1), L000D
00007: 075F DD D8                       FSTP ST
00008: 0761 7A 0F                       JP L000D
00008: 0763 75 0D                       JNE L000D
00008: 0765 B8 00000000                 MOV EAX, 00000000
00000: 076A                             epilog 
00000: 076A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 076D 5F                          POP EDI
00000: 076E 5E                          POP ESI
00000: 076F 5B                          POP EBX
00000: 0770 5D                          POP EBP
00000: 0771 C3                          RETN 
00008: 0772                     L000D:

; 287:   vvm1=sqrt(vvm/vvm1);

00008: 0772 DD 05 00000000              FLD QWORD PTR _vvm
00007: 0778 DC 75 FFFFFFDC              FDIV QWORD PTR FFFFFFDC[EBP]
00007: 077B 50                          PUSH EAX
00007: 077C 50                          PUSH EAX
00007: 077D DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0780 E8 00000000                 CALL SHORT _sqrt
00007: 0785 59                          POP ECX
00007: 0786 59                          POP ECX
00007: 0787 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 288:   for(i=0;i<=n;i++)

00008: 078A C7 45 FFFFFFB4 00000000     MOV DWORD PTR FFFFFFB4[EBP], 00000000
00008: 0791 EB 63                       JMP L000E
00008: 0793                     L000F:

; 290:       a[i].v.x*=vvm1;

00008: 0793 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 0796 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 079D 29 D3                       SUB EBX, EDX
00008: 079F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07A2 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 07A8 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 07AC DC 4D FFFFFFDC              FMUL QWORD PTR FFFFFFDC[EBP]
00007: 07AF DD 5C DA 18                 FSTP QWORD PTR 00000018[EDX][EBX*8]

; 291:       a[i].v.y*=vvm1;

00008: 07B3 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 07B6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 07BD 29 D3                       SUB EBX, EDX
00008: 07BF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07C2 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 07C8 DD 44 DA 20                 FLD QWORD PTR 00000020[EDX][EBX*8]
00007: 07CC DC 4D FFFFFFDC              FMUL QWORD PTR FFFFFFDC[EBP]
00007: 07CF DD 5C DA 20                 FSTP QWORD PTR 00000020[EDX][EBX*8]

; 292:       a[i].v.z*=vvm1;

00008: 07D3 8B 55 FFFFFFB4              MOV EDX, DWORD PTR FFFFFFB4[EBP]
00008: 07D6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 07DD 29 D3                       SUB EBX, EDX
00008: 07DF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 07E2 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 07E8 DD 44 DA 28                 FLD QWORD PTR 00000028[EDX][EBX*8]
00007: 07EC DC 4D FFFFFFDC              FMUL QWORD PTR FFFFFFDC[EBP]
00007: 07EF DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 293:     }

00008: 07F3 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 07F6                     L000E:
00008: 07F6 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 07F9 3B 05 00000000              CMP EAX, DWORD PTR _n
00008: 07FF 7E FFFFFF92                 JLE L000F

; 294:   potential=0;

00008: 0801 C7 05 00000004 00000000     MOV DWORD PTR _potential+00000004, 00000000
00008: 080B C7 05 00000000 00000000     MOV DWORD PTR _potential, 00000000

; 295:   pressure=dblarg1;

00008: 0815 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 081B DD 1D 00000000              FSTP QWORD PTR _pressure

; 296:   temperature=dblarg1;

00008: 0821 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0827 DD 1D 00000000              FSTP QWORD PTR _temperature

; 297:   avePot=dblarg1;

00008: 082D DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0833 DD 1D 00000000              FSTP QWORD PTR _avePot

; 298:   mes_time=dblarg1;

00008: 0839 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 083F DD 1D 00000000              FSTP QWORD PTR _mes_time

; 299:   timep=0;

00008: 0845 C7 05 00000004 00000000     MOV DWORD PTR _timep+00000004, 00000000
00008: 084F C7 05 00000000 00000000     MOV DWORD PTR _timep, 00000000

; 300:   vvmtime=0;

00008: 0859 C7 05 00000004 00000000     MOV DWORD PTR _vvmtime+00000004, 00000000
00008: 0863 C7 05 00000000 00000000     MOV DWORD PTR _vvmtime, 00000000

; 301:   virial=0;

00008: 086D C7 05 00000004 00000000     MOV DWORD PTR _virial+00000004, 00000000
00008: 0877 C7 05 00000000 00000000     MOV DWORD PTR _virial, 00000000

; 302:   i=init_tables();

00008: 0881 E8 00000000                 CALL SHORT _init_tables
00008: 0886 89 45 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EAX

; 303:   if(i!=1)return 0;

00008: 0889 83 7D FFFFFFB4 01           CMP DWORD PTR FFFFFFB4[EBP], 00000001
00008: 088D 74 0D                       JE L0010
00008: 088F B8 00000000                 MOV EAX, 00000000
00000: 0894                             epilog 
00000: 0894 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0897 5F                          POP EDI
00000: 0898 5E                          POP ESI
00000: 0899 5B                          POP EBX
00000: 089A 5D                          POP EBP
00000: 089B C3                          RETN 
00008: 089C                     L0010:

; 304:   return 1; 

00008: 089C B8 00000001                 MOV EAX, 00000001
00000: 08A1                     L0000:
00000: 08A1                             epilog 
00000: 08A1 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 08A4 5F                          POP EDI
00000: 08A5 5E                          POP ESI
00000: 08A6 5B                          POP EBX
00000: 08A7 5D                          POP EBP
00000: 08A8 C3                          RETN 

Function: _add_potential

; 309: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 310:   long k=ct; 

00008: 0013 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0016 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 311:   potential+=coll[k].etot;

00008: 0019 8B 5D FFFFFFF8              MOV EBX, DWORD PTR FFFFFFF8[EBP]
00008: 001C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 001F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0025 DD 05 00000000              FLD QWORD PTR _potential
00007: 002B DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 002F DD 1D 00000000              FSTP QWORD PTR _potential

; 312: } 

00000: 0035                     L0000:
00000: 0035                             epilog 
00000: 0035 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0038 5B                          POP EBX
00000: 0039 5D                          POP EBP
00000: 003A C3                          RETN 

Function: _get_delta_ll

; 315: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 316:   return deltall;

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _deltall
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _set_delta_ll

; 320: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 321:   deltall=new_deltall;

00008: 0003 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0006 89 15 00000000              MOV DWORD PTR _deltall, EDX

; 322: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _get_mes_time

; 325: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 326:   if (mes_time!=dblarg1)

00008: 0003 DD 05 00000000              FLD QWORD PTR _mes_time
00007: 0009 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 000F F1DF                        FCOMIP ST, ST(1), L0001
00007: 0011 DD D8                       FSTP ST
00008: 0013 7A 02                       JP L0002
00008: 0015 74 0E                       JE L0001
00008: 0017                     L0002:

; 327:     return mes_time+timed;

00008: 0017 DD 05 00000000              FLD QWORD PTR _mes_time
00007: 001D DC 05 00000000              FADD QWORD PTR _timed
00000: 0023                             epilog 
00000: 0023 C9                          LEAVE 
00000: 0024 C3                          RETN 
00008: 0025                     L0001:

; 329:     return timec+timed;

00008: 0025 DD 05 00000000              FLD QWORD PTR _timec
00007: 002B DC 05 00000000              FADD QWORD PTR _timed
00000: 0031                     L0000:
00000: 0031                             epilog 
00000: 0031 C9                          LEAVE 
00000: 0032 C3                          RETN 

Function: _get_temperature

; 333: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 334:   if (temperature!=dblarg1)

00008: 0003 DD 05 00000000              FLD QWORD PTR _temperature
00007: 0009 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 000F F1DF                        FCOMIP ST, ST(1), L0001
00007: 0011 DD D8                       FSTP ST
00008: 0013 7A 02                       JP L0003
00008: 0015 74 08                       JE L0001
00008: 0017                     L0003:

; 335:   return temperature;

00008: 0017 DD 05 00000000              FLD QWORD PTR _temperature
00000: 001D                             epilog 
00000: 001D C9                          LEAVE 
00000: 001E C3                          RETN 
00008: 001F                     L0001:

; 336:   else if(timep)

00008: 001F DD 05 00000000              FLD QWORD PTR _timep
00007: 0025 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002B F1DF                        FCOMIP ST, ST(1), L0002
00007: 002D DD D8                       FSTP ST
00008: 002F 7A 02                       JP L0004
00008: 0031 74 28                       JE L0002
00008: 0033                     L0004:

; 337:     return 2*vvmtime/(n1*dim*timep*corr_2);

00008: 0033 DB 05 00000000              FILD DWORD PTR _n1
00007: 0039 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 003F DC 0D 00000000              FMUL QWORD PTR _timep
00007: 0045 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 004B DD 05 00000000              FLD QWORD PTR .data+000000b0
00006: 0051 DC 0D 00000000              FMUL QWORD PTR _vvmtime
00006: 0057 DE F1                       FDIVRP ST(1), ST
00000: 0059                             epilog 
00000: 0059 C9                          LEAVE 
00000: 005A C3                          RETN 
00008: 005B                     L0002:

; 339:     return 2*vvm/(n1*dim*corr_2);

00008: 005B DB 05 00000000              FILD DWORD PTR _n1
00007: 0061 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 0067 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 006D DD 05 00000000              FLD QWORD PTR .data+000000b0
00006: 0073 DC 0D 00000000              FMUL QWORD PTR _vvm
00006: 0079 DE F1                       FDIVRP ST(1), ST
00000: 007B                     L0000:
00000: 007B                             epilog 
00000: 007B C9                          LEAVE 
00000: 007C C3                          RETN 

Function: _get_avePot

; 343: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 344:   if (avePot!=dblarg1)

00008: 0003 DD 05 00000000              FLD QWORD PTR _avePot
00007: 0009 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 000F F1DF                        FCOMIP ST, ST(1), L0001
00007: 0011 DD D8                       FSTP ST
00008: 0013 7A 02                       JP L0003
00008: 0015 74 08                       JE L0001
00008: 0017                     L0003:

; 345:   return avePot;

00008: 0017 DD 05 00000000              FLD QWORD PTR _avePot
00000: 001D                             epilog 
00000: 001D C9                          LEAVE 
00000: 001E C3                          RETN 
00008: 001F                     L0001:

; 346:   else if(timep)

00008: 001F DD 05 00000000              FLD QWORD PTR _timep
00007: 0025 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002B F1DF                        FCOMIP ST, ST(1), L0002
00007: 002D DD D8                       FSTP ST
00008: 002F 7A 02                       JP L0004
00008: 0031 74 0E                       JE L0002
00008: 0033                     L0004:

; 347:     return potTime/timep;

00008: 0033 DD 05 00000000              FLD QWORD PTR _potTime
00007: 0039 DC 35 00000000              FDIV QWORD PTR _timep
00000: 003F                             epilog 
00000: 003F C9                          LEAVE 
00000: 0040 C3                          RETN 
00008: 0041                     L0002:

; 349:     return potential;

00008: 0041 DD 05 00000000              FLD QWORD PTR _potential
00000: 0047                     L0000:
00000: 0047                             epilog 
00000: 0047 C9                          LEAVE 
00000: 0048 C3                          RETN 

Function: _set_temp

; 353: { int i;double vvmo;

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

; 354:   vvmo=(temp*n1*dim)/2;

00008: 0016 DB 05 00000000              FILD DWORD PTR _n1
00007: 001C DC 4D 08                    FMUL QWORD PTR 00000008[EBP]
00007: 001F DC 0D 00000000              FMUL QWORD PTR _dim
00007: 0025 DC 0D 00000000              FMUL QWORD PTR .data+00000080
00007: 002B DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]

; 355:   corr_2=vvm/vvmo;

00008: 002E DD 05 00000000              FLD QWORD PTR _vvm
00007: 0034 DC 75 FFFFFFF4              FDIV QWORD PTR FFFFFFF4[EBP]
00007: 0037 DD 1D 00000000              FSTP QWORD PTR _corr_2

; 356:   for (i=0;i<nen;i++)

00008: 003D C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0044 EB 4E                       JMP L0001
00008: 0046                     L0002:

; 358:       coll[i].e=coll[i].eo*corr_2;

00008: 0046 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 0049 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 004C 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0052 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 0058 DC 4C DA 08                 FMUL QWORD PTR 00000008[EDX][EBX*8]
00007: 005C 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00007: 005F 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 0062 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 0068 DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]

; 359:       coll[i].edm=coll[i].edmo*corr_2;

00008: 006B 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 006E 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0071 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0077 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 007D DC 4C DA 30                 FMUL QWORD PTR 00000030[EDX][EBX*8]
00007: 0081 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00007: 0084 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 0087 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 008D DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 360:     }

00008: 0091 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 0094                     L0001:
00008: 0094 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0097 3B 05 00000000              CMP EAX, DWORD PTR _nen
00008: 009D 7C FFFFFFA7                 JL L0002

; 361:   corr=sqrt(corr_2);

00008: 009F FF 35 00000004              PUSH DWORD PTR _corr_2+00000004
00008: 00A5 FF 35 00000000              PUSH DWORD PTR _corr_2
00008: 00AB E8 00000000                 CALL SHORT _sqrt
00007: 00B0 59                          POP ECX
00007: 00B1 59                          POP ECX
00007: 00B2 DD 1D 00000000              FSTP QWORD PTR _corr

; 362:   llp=0;

00008: 00B8 C7 05 00000000 00000000     MOV DWORD PTR _llp, 00000000

; 363:   virial=0;

00008: 00C2 C7 05 00000004 00000000     MOV DWORD PTR _virial+00000004, 00000000
00008: 00CC C7 05 00000000 00000000     MOV DWORD PTR _virial, 00000000

; 364:   vvmtime=0;

00008: 00D6 C7 05 00000004 00000000     MOV DWORD PTR _vvmtime+00000004, 00000000
00008: 00E0 C7 05 00000000 00000000     MOV DWORD PTR _vvmtime, 00000000

; 365:   timep=0;

00008: 00EA C7 05 00000004 00000000     MOV DWORD PTR _timep+00000004, 00000000
00008: 00F4 C7 05 00000000 00000000     MOV DWORD PTR _timep, 00000000

; 366: }

00000: 00FE                     L0000:
00000: 00FE                             epilog 
00000: 00FE 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0101 5B                          POP EBX
00000: 0102 5D                          POP EBP
00000: 0103 C3                          RETN 

Function: _get_temp

; 369: {return 2*vvm/(n1*dim*corr_2);}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 369: {return 2*vvm/(n1*dim*corr_2);}

00008: 0003 DB 05 00000000              FILD DWORD PTR _n1
00007: 0009 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 000F DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 0015 DD 05 00000000              FLD QWORD PTR .data+000000b0
00006: 001B DC 0D 00000000              FMUL QWORD PTR _vvm
00006: 0021 DE F1                       FDIVRP ST(1), ST
00000: 0023                     L0000:
00000: 0023                             epilog 
00000: 0023 C9                          LEAVE 
00000: 0024 C3                          RETN 

Function: _rescale

; 373: { int i;

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

; 374:   double temp0=get_temperature();

00008: 0018 E8 00000000                 CALL SHORT _get_temperature
00007: 001D DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 375:   if (coeff)

00008: 0020 DD 05 00000000              FLD QWORD PTR _coeff
00007: 0026 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002C F1DF                        FCOMIP ST, ST(1), L0001
00007: 002E DD D8                       FSTP ST
00008: 0030 7A 06                       JP L0005
00008: 0032 0F 84 000000D2              JE L0001
00008: 0038                     L0005:

; 377:       double coeff1=coeff*timep*corr;

00008: 0038 DD 05 00000000              FLD QWORD PTR _coeff
00007: 003E DC 0D 00000000              FMUL QWORD PTR _timep
00007: 0044 DC 0D 00000000              FMUL QWORD PTR _corr
00007: 004A DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]

; 378:       if(coeff1>1)coeff1=1;

00008: 004D DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 0050 DD 05 00000000              FLD QWORD PTR .data+00000090
00006: 0056 F1DF                        FCOMIP ST, ST(1), L0002
00007: 0058 DD D8                       FSTP ST
00008: 005A 7A 0B                       JP L0002
00008: 005C 73 09                       JAE L0002
00008: 005E DD 05 00000000              FLD QWORD PTR .data+00000090
00007: 0064 DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]
00008: 0067                     L0002:

; 379:       corr_2*=temp0/(temp0*(1.0-coeff1)+temp_limit*coeff1);  

00008: 0067 DD 05 00000000              FLD QWORD PTR _temp_limit
00007: 006D DC 4D FFFFFFF4              FMUL QWORD PTR FFFFFFF4[EBP]
00007: 0070 DD 05 00000000              FLD QWORD PTR .data+00000090
00006: 0076 DC 65 FFFFFFF4              FSUB QWORD PTR FFFFFFF4[EBP]
00006: 0079 DC 4D FFFFFFEC              FMUL QWORD PTR FFFFFFEC[EBP]
00006: 007C DE C1                       FADDP ST(1), ST
00007: 007E DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00006: 0081 DE F1                       FDIVRP ST(1), ST
00007: 0083 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 0089 DD 1D 00000000              FSTP QWORD PTR _corr_2

; 380:       for (i=0;i<nen;i++)

00008: 008F C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0096 EB 4E                       JMP L0003
00008: 0098                     L0004:

; 382: 	  coll[i].e=coll[i].eo*corr_2;

00008: 0098 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 009B 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 009E 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 00A4 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 00AA DC 4C DA 08                 FMUL QWORD PTR 00000008[EDX][EBX*8]
00007: 00AE 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00007: 00B1 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 00B4 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 00BA DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]

; 383: 	  coll[i].edm=coll[i].edmo*corr_2;

00008: 00BD 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00008: 00C0 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 00C3 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 00C9 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 00CF DC 4C DA 30                 FMUL QWORD PTR 00000030[EDX][EBX*8]
00007: 00D3 8B 5D FFFFFFE8              MOV EBX, DWORD PTR FFFFFFE8[EBP]
00007: 00D6 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 00D9 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 00DF DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 384: 	}

00008: 00E3 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]
00008: 00E6                     L0003:
00008: 00E6 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00E9 3B 05 00000000              CMP EAX, DWORD PTR _nen
00008: 00EF 7C FFFFFFA7                 JL L0004

; 385:       corr=sqrt(corr_2);

00008: 00F1 FF 35 00000004              PUSH DWORD PTR _corr_2+00000004
00008: 00F7 FF 35 00000000              PUSH DWORD PTR _corr_2
00008: 00FD E8 00000000                 CALL SHORT _sqrt
00007: 0102 59                          POP ECX
00007: 0103 59                          POP ECX
00007: 0104 DD 1D 00000000              FSTP QWORD PTR _corr

; 386:     }

00008: 010A                     L0001:

; 387:   llp=0;

00008: 010A C7 05 00000000 00000000     MOV DWORD PTR _llp, 00000000

; 388:   virial=0;

00008: 0114 C7 05 00000004 00000000     MOV DWORD PTR _virial+00000004, 00000000
00008: 011E C7 05 00000000 00000000     MOV DWORD PTR _virial, 00000000

; 389:   vvmtime=0;

00008: 0128 C7 05 00000004 00000000     MOV DWORD PTR _vvmtime+00000004, 00000000
00008: 0132 C7 05 00000000 00000000     MOV DWORD PTR _vvmtime, 00000000

; 390:   potTime=0;

00008: 013C C7 05 00000004 00000000     MOV DWORD PTR _potTime+00000004, 00000000
00008: 0146 C7 05 00000000 00000000     MOV DWORD PTR _potTime, 00000000

; 391:   timep=0;

00008: 0150 C7 05 00000004 00000000     MOV DWORD PTR _timep+00000004, 00000000
00008: 015A C7 05 00000000 00000000     MOV DWORD PTR _timep, 00000000

; 392: }

00000: 0164                     L0000:
00000: 0164                             epilog 
00000: 0164 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0167 5B                          POP EBX
00000: 0168 5D                          POP EBP
00000: 0169 C3                          RETN 

Function: _set_temp_limit

; 395: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 396:   temp_limit=t;

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _temp_limit

; 397: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _get_temp_limit

; 400: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 401:   return temp_limit;

00008: 0003 DD 05 00000000              FLD QWORD PTR _temp_limit
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _set_coeff

; 405: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 406:   coeff=c;

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _coeff

; 407: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _get_coeff

; 410: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 411:   return coeff;

00008: 0003 DD 05 00000000              FLD QWORD PTR _coeff
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _get_rate

; 415: {return delta5;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 415: {return delta5;}

00008: 0003 DD 05 00000000              FLD QWORD PTR _delta5
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _set_rate

; 418: {delta5=rate;delta6=0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 418: {delta5=rate;delta6=0;}

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _delta5
00008: 000C C7 05 00000004 00000000     MOV DWORD PTR _delta6+00000004, 00000000
00008: 0016 C7 05 00000000 00000000     MOV DWORD PTR _delta6, 00000000
00000: 0020                     L0000:
00000: 0020                             epilog 
00000: 0020 C9                          LEAVE 
00000: 0021 C3                          RETN 

Function: _open_echo_file

; 430: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 81 EC 00000208              SUB ESP, 00000208
00000: 0009 57                          PUSH EDI
00000: 000A B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000F 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0013 B9 00000082                 MOV ECX, 00000082
00000: 0018 F3 AB                       REP STOSD 
00000: 001A 5F                          POP EDI
00000: 001B                             prolog 

; 433:   int fErr=noErr;

00008: 001B C7 85 FFFFFDFC00000000      MOV DWORD PTR FFFFFDFC[EBP], 00000000

; 436:   if(is_open)

00008: 0025 83 7D 08 00                 CMP DWORD PTR 00000008[EBP], 00000000
00008: 0029 74 12                       JE L0001

; 437:     fErr=fclose(echo_path);

00008: 002B A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0030 50                          PUSH EAX
00008: 0031 E8 00000000                 CALL SHORT _fclose
00008: 0036 59                          POP ECX
00008: 0037 89 85 FFFFFDFC              MOV DWORD PTR FFFFFDFC[EBP], EAX
00008: 003D                     L0001:

; 438:   if(fErr!=noErr)return 0;

00008: 003D 83 BD FFFFFDFC00            CMP DWORD PTR FFFFFDFC[EBP], 00000000
00008: 0044 74 07                       JE L0002
00008: 0046 B8 00000000                 MOV EAX, 00000000
00000: 004B                             epilog 
00000: 004B C9                          LEAVE 
00000: 004C C3                          RETN 
00008: 004D                     L0002:

; 440:   do

00008: 004D                     L0003:

; 442:       printf("open echo file? y/n\n");

00008: 004D 68 00000000                 PUSH OFFSET @306
00008: 0052 E8 00000000                 CALL SHORT _printf
00008: 0057 59                          POP ECX

; 443:       scanf("%s",fname);

00008: 0058 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 005B 68 00000000                 PUSH OFFSET @307
00008: 0060 E8 00000000                 CALL SHORT _scanf
00008: 0065 59                          POP ECX
00008: 0066 59                          POP ECX

; 444:       if(!strcmp(fname,"n"))return 0;

00008: 0067 68 00000000                 PUSH OFFSET @308
00008: 006C FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 006F E8 00000000                 CALL SHORT _strcmp
00008: 0074 59                          POP ECX
00008: 0075 59                          POP ECX
00008: 0076 83 F8 00                    CMP EAX, 00000000
00008: 0079 75 07                       JNE L0004
00008: 007B B8 00000000                 MOV EAX, 00000000
00000: 0080                             epilog 
00000: 0080 C9                          LEAVE 
00000: 0081 C3                          RETN 
00008: 0082                     L0004:

; 445:     }

00008: 0082 68 00000000                 PUSH OFFSET @309
00008: 0087 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 008A E8 00000000                 CALL SHORT _strcmp
00008: 008F 59                          POP ECX
00008: 0090 59                          POP ECX
00008: 0091 83 F8 00                    CMP EAX, 00000000
00008: 0094 75 FFFFFFB7                 JNE L0003

; 447:   printf("what is echo file name ?\n");

00008: 0096 68 00000000                 PUSH OFFSET @310
00008: 009B E8 00000000                 CALL SHORT _printf
00008: 00A0 59                          POP ECX

; 448:   scanf("%s",fname);

00008: 00A1 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 00A4 68 00000000                 PUSH OFFSET @307
00008: 00A9 E8 00000000                 CALL SHORT _scanf
00008: 00AE 59                          POP ECX
00008: 00AF 59                          POP ECX

; 449:   echo_path=fopen(fname,"wb");

00008: 00B0 68 00000000                 PUSH OFFSET @311
00008: 00B5 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 00B8 E8 00000000                 CALL SHORT _fopen
00008: 00BD 59                          POP ECX
00008: 00BE 59                          POP ECX
00008: 00BF A3 00000000                 MOV DWORD PTR _echo_path, EAX

; 450:   if(!echo_path)return 0;

00008: 00C4 83 3D 00000000 00           CMP DWORD PTR _echo_path, 00000000
00008: 00CB 75 07                       JNE L0005
00008: 00CD B8 00000000                 MOV EAX, 00000000
00000: 00D2                             epilog 
00000: 00D2 C9                          LEAVE 
00000: 00D3 C3                          RETN 
00008: 00D4                     L0005:

; 451:   n_p_mes=0;

00008: 00D4 C7 05 00000000 00000000     MOV DWORD PTR _n_p_mes, 00000000

; 452:   avpres=0;

00008: 00DE C7 05 00000004 00000000     MOV DWORD PTR _avpres+00000004, 00000000
00008: 00E8 C7 05 00000000 00000000     MOV DWORD PTR _avpres, 00000000

; 453:   avtemp=0;

00008: 00F2 C7 05 00000004 00000000     MOV DWORD PTR _avtemp+00000004, 00000000
00008: 00FC C7 05 00000000 00000000     MOV DWORD PTR _avtemp, 00000000

; 454:   avpot=0;

00008: 0106 C7 05 00000004 00000000     MOV DWORD PTR _avpot+00000004, 00000000
00008: 0110 C7 05 00000000 00000000     MOV DWORD PTR _avpot, 00000000

; 455:   nbyte=sprintf(s,

00008: 011A 68 00000000                 PUSH OFFSET @312
00008: 011F 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0125 50                          PUSH EAX
00008: 0126 E8 00000000                 CALL SHORT _sprintf
00008: 012B 59                          POP ECX
00008: 012C 59                          POP ECX
00008: 012D 89 85 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EAX

; 457:   if(nbyte<=0){ fclose(echo_path);return 0;}

00008: 0133 83 BD FFFFFDF800            CMP DWORD PTR FFFFFDF8[EBP], 00000000
00008: 013A 7F 13                       JG L0006
00008: 013C A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0141 50                          PUSH EAX
00008: 0142 E8 00000000                 CALL SHORT _fclose
00008: 0147 59                          POP ECX
00008: 0148 B8 00000000                 MOV EAX, 00000000
00000: 014D                             epilog 
00000: 014D C9                          LEAVE 
00000: 014E C3                          RETN 
00008: 014F                     L0006:

; 458:   if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}

00008: 014F A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0154 50                          PUSH EAX
00008: 0155 FF B5 FFFFFDF8              PUSH DWORD PTR FFFFFDF8[EBP]
00008: 015B 6A 01                       PUSH 00000001
00008: 015D 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0163 50                          PUSH EAX
00008: 0164 E8 00000000                 CALL SHORT _fwrite
00008: 0169 83 C4 10                    ADD ESP, 00000010
00008: 016C 39 85 FFFFFDF8              CMP DWORD PTR FFFFFDF8[EBP], EAX
00008: 0172 74 13                       JE L0007
00008: 0174 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0179 50                          PUSH EAX
00008: 017A E8 00000000                 CALL SHORT _fclose
00008: 017F 59                          POP ECX
00008: 0180 B8 00000000                 MOV EAX, 00000000
00000: 0185                             epilog 
00000: 0185 C9                          LEAVE 
00000: 0186 C3                          RETN 
00008: 0187                     L0007:

; 459:   else return 1;

00008: 0187 B8 00000001                 MOV EAX, 00000001
00000: 018C                     L0000:
00000: 018C                             epilog 
00000: 018C C9                          LEAVE 
00000: 018D C3                          RETN 

Function: _set_text_name

; 464: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 467:   int fErr=noErr;

00008: 0012 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000

; 469:   do

00008: 0019                     L0001:

; 471:       printf("open text file? y/n\n");

00008: 0019 68 00000000                 PUSH OFFSET @323
00008: 001E E8 00000000                 CALL SHORT _printf
00008: 0023 59                          POP ECX

; 472:       scanf("%s",fname);

00008: 0024 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0027 68 00000000                 PUSH OFFSET @307
00008: 002C E8 00000000                 CALL SHORT _scanf
00008: 0031 59                          POP ECX
00008: 0032 59                          POP ECX

; 473:       if(!strcmp(fname,"n"))return 0;

00008: 0033 68 00000000                 PUSH OFFSET @308
00008: 0038 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 003B E8 00000000                 CALL SHORT _strcmp
00008: 0040 59                          POP ECX
00008: 0041 59                          POP ECX
00008: 0042 83 F8 00                    CMP EAX, 00000000
00008: 0045 75 07                       JNE L0002
00008: 0047 B8 00000000                 MOV EAX, 00000000
00000: 004C                             epilog 
00000: 004C C9                          LEAVE 
00000: 004D C3                          RETN 
00008: 004E                     L0002:

; 474:     }

00008: 004E 68 00000000                 PUSH OFFSET @309
00008: 0053 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0056 E8 00000000                 CALL SHORT _strcmp
00008: 005B 59                          POP ECX
00008: 005C 59                          POP ECX
00008: 005D 83 F8 00                    CMP EAX, 00000000
00008: 0060 75 FFFFFFB7                 JNE L0001

; 476:   printf("what is text file name ?\n");

00008: 0062 68 00000000                 PUSH OFFSET @324
00008: 0067 E8 00000000                 CALL SHORT _printf
00008: 006C 59                          POP ECX

; 477:   scanf("%s",fname);

00008: 006D FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0070 68 00000000                 PUSH OFFSET @307
00008: 0075 E8 00000000                 CALL SHORT _scanf
00008: 007A 59                          POP ECX
00008: 007B 59                          POP ECX

; 479:   text_name=fname;

00008: 007C 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 007F A3 00000000                 MOV DWORD PTR _text_name, EAX

; 480:   return 1;

00008: 0084 B8 00000001                 MOV EAX, 00000001
00000: 0089                     L0000:
00000: 0089                             epilog 
00000: 0089 C9                          LEAVE 
00000: 008A C3                          RETN 

Function: _open_movie_file

; 486: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 487:  int fErr=noErr;

00008: 0012 C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000

; 489:  if(is_open)

00008: 0019 83 7D 08 00                 CMP DWORD PTR 00000008[EBP], 00000000
00008: 001D 74 0F                       JE L0001

; 490:    fErr=closemovie(movie_path);

00008: 001F A1 00000000                 MOV EAX, DWORD PTR _movie_path
00008: 0024 50                          PUSH EAX
00008: 0025 E8 00000000                 CALL SHORT _closemovie
00008: 002A 59                          POP ECX
00008: 002B 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX
00008: 002E                     L0001:

; 491:  if(fErr!=noErr)return 0;

00008: 002E 83 7D FFFFFFFC 00           CMP DWORD PTR FFFFFFFC[EBP], 00000000
00008: 0032 74 07                       JE L0002
00008: 0034 B8 00000000                 MOV EAX, 00000000
00000: 0039                             epilog 
00000: 0039 C9                          LEAVE 
00000: 003A C3                          RETN 
00008: 003B                     L0002:

; 492:  do

00008: 003B                     L0003:

; 494:      printf("open movie file? y/n\n");

00008: 003B 68 00000000                 PUSH OFFSET @343
00008: 0040 E8 00000000                 CALL SHORT _printf
00008: 0045 59                          POP ECX

; 495:      scanf("%s",fname);

00008: 0046 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0049 68 00000000                 PUSH OFFSET @307
00008: 004E E8 00000000                 CALL SHORT _scanf
00008: 0053 59                          POP ECX
00008: 0054 59                          POP ECX

; 496:      if(!strcmp(fname,"n"))return 0;

00008: 0055 68 00000000                 PUSH OFFSET @308
00008: 005A FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 005D E8 00000000                 CALL SHORT _strcmp
00008: 0062 59                          POP ECX
00008: 0063 59                          POP ECX
00008: 0064 83 F8 00                    CMP EAX, 00000000
00008: 0067 75 07                       JNE L0004
00008: 0069 B8 00000000                 MOV EAX, 00000000
00000: 006E                             epilog 
00000: 006E C9                          LEAVE 
00000: 006F C3                          RETN 
00008: 0070                     L0004:

; 497:    }

00008: 0070 68 00000000                 PUSH OFFSET @309
00008: 0075 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0078 E8 00000000                 CALL SHORT _strcmp
00008: 007D 59                          POP ECX
00008: 007E 59                          POP ECX
00008: 007F 83 F8 00                    CMP EAX, 00000000
00008: 0082 75 FFFFFFB7                 JNE L0003

; 499:  printf("what is movie file name ?\n");

00008: 0084 68 00000000                 PUSH OFFSET @344
00008: 0089 E8 00000000                 CALL SHORT _printf
00008: 008E 59                          POP ECX

; 500:  scanf("%s",fname);

00008: 008F FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0092 68 00000000                 PUSH OFFSET @307
00008: 0097 E8 00000000                 CALL SHORT _scanf
00008: 009C 59                          POP ECX
00008: 009D 59                          POP ECX

; 501:  movie_path=fopen(fname,"wb");

00008: 009E 68 00000000                 PUSH OFFSET @311
00008: 00A3 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 00A6 E8 00000000                 CALL SHORT _fopen
00008: 00AB 59                          POP ECX
00008: 00AC 59                          POP ECX
00008: 00AD A3 00000000                 MOV DWORD PTR _movie_path, EAX

; 502:  if(!movie_path)return 0;

00008: 00B2 83 3D 00000000 00           CMP DWORD PTR _movie_path, 00000000
00008: 00B9 75 07                       JNE L0005
00008: 00BB B8 00000000                 MOV EAX, 00000000
00000: 00C0                             epilog 
00000: 00C0 C9                          LEAVE 
00000: 00C1 C3                          RETN 
00008: 00C2                     L0005:

; 503:  if(write_movie_header(movie_path))return 1;

00008: 00C2 A1 00000000                 MOV EAX, DWORD PTR _movie_path
00008: 00C7 50                          PUSH EAX
00008: 00C8 E8 00000000                 CALL SHORT _write_movie_header
00008: 00CD 59                          POP ECX
00008: 00CE 83 F8 00                    CMP EAX, 00000000
00008: 00D1 74 07                       JE L0006
00008: 00D3 B8 00000001                 MOV EAX, 00000001
00000: 00D8                             epilog 
00000: 00D8 C9                          LEAVE 
00000: 00D9 C3                          RETN 
00008: 00DA                     L0006:

; 504:  return 0;			

00008: 00DA B8 00000000                 MOV EAX, 00000000
00000: 00DF                     L0000:
00000: 00DF                             epilog 
00000: 00DF C9                          LEAVE 
00000: 00E0 C3                          RETN 

Function: _write_echo

; 511: { long nbyte;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 81 EC 00000250              SUB ESP, 00000250
00000: 0009 57                          PUSH EDI
00000: 000A B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000F 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0013 B9 00000094                 MOV ECX, 00000094
00000: 0018 F3 AB                       REP STOSD 
00000: 001A 5F                          POP EDI
00000: 001B                             prolog 

; 513:   double time=get_mes_time();

00008: 001B E8 00000000                 CALL SHORT _get_mes_time
00007: 0020 DD 9D FFFFFDB8              FSTP QWORD PTR FFFFFDB8[EBP]

; 514:   double energy=countenergy();

00008: 0026 E8 00000000                 CALL SHORT _countenergy
00007: 002B DD 9D FFFFFDC0              FSTP QWORD PTR FFFFFDC0[EBP]

; 515:   double temp=n_p_mes ? avtemp/n_p_mes: get_temperature();

00008: 0031 83 3D 00000000 00           CMP DWORD PTR _n_p_mes, 00000000
00008: 0038 74 16                       JE L0001
00008: 003A DB 05 00000000              FILD DWORD PTR _n_p_mes
00007: 0040 DD 05 00000000              FLD QWORD PTR _avtemp
00006: 0046 DE F1                       FDIVRP ST(1), ST
00007: 0048 DD 9D FFFFFDE8              FSTP QWORD PTR FFFFFDE8[EBP]
00008: 004E EB 0B                       JMP L0002
00008: 0050                     L0001:
00008: 0050 E8 00000000                 CALL SHORT _get_temperature
00007: 0055 DD 9D FFFFFDE8              FSTP QWORD PTR FFFFFDE8[EBP]
00008: 005B                     L0002:
00008: 005B DD 85 FFFFFDE8              FLD QWORD PTR FFFFFDE8[EBP]
00007: 0061 DD 9D FFFFFDC8              FSTP QWORD PTR FFFFFDC8[EBP]

; 516:   double pot=n_p_mes ? avpot/n_p_mes: get_avePot();

00008: 0067 83 3D 00000000 00           CMP DWORD PTR _n_p_mes, 00000000
00008: 006E 74 16                       JE L0003
00008: 0070 DB 05 00000000              FILD DWORD PTR _n_p_mes
00007: 0076 DD 05 00000000              FLD QWORD PTR _avpot
00006: 007C DE F1                       FDIVRP ST(1), ST
00007: 007E DD 9D FFFFFDF0              FSTP QWORD PTR FFFFFDF0[EBP]
00008: 0084 EB 0B                       JMP L0004
00008: 0086                     L0003:
00008: 0086 E8 00000000                 CALL SHORT _get_avePot
00007: 008B DD 9D FFFFFDF0              FSTP QWORD PTR FFFFFDF0[EBP]
00008: 0091                     L0004:
00008: 0091 DD 85 FFFFFDF0              FLD QWORD PTR FFFFFDF0[EBP]
00007: 0097 DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]

; 517:   double gr=get_gr();

00008: 009D E8 00000000                 CALL SHORT _get_gr
00007: 00A2 DD 9D FFFFFDD8              FSTP QWORD PTR FFFFFDD8[EBP]

; 518:   double pressure=n_p_mes ? avpres/n_p_mes: get_pressure();

00008: 00A8 83 3D 00000000 00           CMP DWORD PTR _n_p_mes, 00000000
00008: 00AF 74 16                       JE L0005
00008: 00B1 DB 05 00000000              FILD DWORD PTR _n_p_mes
00007: 00B7 DD 05 00000000              FLD QWORD PTR _avpres
00006: 00BD DE F1                       FDIVRP ST(1), ST
00007: 00BF DD 9D FFFFFDF8              FSTP QWORD PTR FFFFFDF8[EBP]
00008: 00C5 EB 0B                       JMP L0006
00008: 00C7                     L0005:
00008: 00C7 E8 00000000                 CALL SHORT _get_pressure
00007: 00CC DD 9D FFFFFDF8              FSTP QWORD PTR FFFFFDF8[EBP]
00008: 00D2                     L0006:
00008: 00D2 DD 85 FFFFFDF8              FLD QWORD PTR FFFFFDF8[EBP]
00007: 00D8 DD 9D FFFFFDE0              FSTP QWORD PTR FFFFFDE0[EBP]

; 520:   n_p_mes=0;

00008: 00DE C7 05 00000000 00000000     MOV DWORD PTR _n_p_mes, 00000000

; 521:   avtemp=0;

00008: 00E8 C7 05 00000004 00000000     MOV DWORD PTR _avtemp+00000004, 00000000
00008: 00F2 C7 05 00000000 00000000     MOV DWORD PTR _avtemp, 00000000

; 522:   avpres=0;

00008: 00FC C7 05 00000004 00000000     MOV DWORD PTR _avpres+00000004, 00000000
00008: 0106 C7 05 00000000 00000000     MOV DWORD PTR _avpres, 00000000

; 523:   avpot=0;

00008: 0110 C7 05 00000004 00000000     MOV DWORD PTR _avpot+00000004, 00000000
00008: 011A C7 05 00000000 00000000     MOV DWORD PTR _avpot, 00000000

; 524:   pot=-pot;

00008: 0124 DD 85 FFFFFDD0              FLD QWORD PTR FFFFFDD0[EBP]
00007: 012A D9 E0                       FCHS 
00007: 012C DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]

; 525:   printf("%lf\n",time); 

00008: 0132 FF B5 FFFFFDBC              PUSH DWORD PTR FFFFFDBC[EBP]
00008: 0138 FF B5 FFFFFDB8              PUSH DWORD PTR FFFFFDB8[EBP]
00008: 013E 68 00000000                 PUSH OFFSET @363
00008: 0143 E8 00000000                 CALL SHORT _printf
00008: 0148 83 C4 0C                    ADD ESP, 0000000C

; 526:   nbyte=sprintf(&s[0],"%12.3lf\11%12.3lf\11%12.3lf\11%17.10lf\11%17.10lf\n"

00008: 014B FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0151 FF B5 FFFFFDE0              PUSH DWORD PTR FFFFFDE0[EBP]
00008: 0157 FF B5 FFFFFDDC              PUSH DWORD PTR FFFFFDDC[EBP]
00008: 015D FF B5 FFFFFDD8              PUSH DWORD PTR FFFFFDD8[EBP]
00008: 0163 FF B5 FFFFFDD4              PUSH DWORD PTR FFFFFDD4[EBP]
00008: 0169 FF B5 FFFFFDD0              PUSH DWORD PTR FFFFFDD0[EBP]
00008: 016F FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 0175 FF B5 FFFFFDC8              PUSH DWORD PTR FFFFFDC8[EBP]
00008: 017B FF B5 FFFFFDBC              PUSH DWORD PTR FFFFFDBC[EBP]
00008: 0181 FF B5 FFFFFDB8              PUSH DWORD PTR FFFFFDB8[EBP]
00008: 0187 68 00000000                 PUSH OFFSET @364
00008: 018C 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0192 50                          PUSH EAX
00008: 0193 E8 00000000                 CALL SHORT _sprintf
00008: 0198 83 C4 30                    ADD ESP, 00000030
00008: 019B 89 85 FFFFFDB4              MOV DWORD PTR FFFFFDB4[EBP], EAX

; 528:   if(nbyte<=0){ fclose(echo_path);return 0;}

00008: 01A1 83 BD FFFFFDB400            CMP DWORD PTR FFFFFDB4[EBP], 00000000
00008: 01A8 7F 13                       JG L0007
00008: 01AA A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 01AF 50                          PUSH EAX
00008: 01B0 E8 00000000                 CALL SHORT _fclose
00008: 01B5 59                          POP ECX
00008: 01B6 B8 00000000                 MOV EAX, 00000000
00000: 01BB                             epilog 
00000: 01BB C9                          LEAVE 
00000: 01BC C3                          RETN 
00008: 01BD                     L0007:

; 529:   if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}

00008: 01BD A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 01C2 50                          PUSH EAX
00008: 01C3 FF B5 FFFFFDB4              PUSH DWORD PTR FFFFFDB4[EBP]
00008: 01C9 6A 01                       PUSH 00000001
00008: 01CB 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 01D1 50                          PUSH EAX
00008: 01D2 E8 00000000                 CALL SHORT _fwrite
00008: 01D7 83 C4 10                    ADD ESP, 00000010
00008: 01DA 39 85 FFFFFDB4              CMP DWORD PTR FFFFFDB4[EBP], EAX
00008: 01E0 74 13                       JE L0008
00008: 01E2 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 01E7 50                          PUSH EAX
00008: 01E8 E8 00000000                 CALL SHORT _fclose
00008: 01ED 59                          POP ECX
00008: 01EE B8 00000000                 MOV EAX, 00000000
00000: 01F3                             epilog 
00000: 01F3 C9                          LEAVE 
00000: 01F4 C3                          RETN 
00008: 01F5                     L0008:

; 531:     return 1;

00008: 01F5 B8 00000001                 MOV EAX, 00000001
00000: 01FA                     L0000:
00000: 01FA                             epilog 
00000: 01FA C9                          LEAVE 
00000: 01FB C3                          RETN 

Function: _set_time

; 538: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 539: timec=time;

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _timec

; 540: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _get_time

; 541: double get_time(void){

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 542: 	return (double)(timec+timed);

00008: 0003 DD 05 00000000              FLD QWORD PTR _timec
00007: 0009 DC 05 00000000              FADD QWORD PTR _timed
00000: 000F                     L0000:
00000: 000F                             epilog 
00000: 000F C9                          LEAVE 
00000: 0010 C3                          RETN 

Function: _set_frate

; 546: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 547:   delta1=frate;

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _delta1

; 548:   delta2=0;

00008: 000C C7 05 00000004 00000000     MOV DWORD PTR _delta2+00000004, 00000000
00008: 0016 C7 05 00000000 00000000     MOV DWORD PTR _delta2, 00000000

; 549: }

00000: 0020                     L0000:
00000: 0020                             epilog 
00000: 0020 C9                          LEAVE 
00000: 0021 C3                          RETN 

Function: _get_frate

; 551: {return delta1;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 551: {return delta1;}

00008: 0003 DD 05 00000000              FLD QWORD PTR _delta1
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _set_mfrate

; 553: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: delta3=frate;

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 1D 00000000              FSTP QWORD PTR _delta3

; 555: delta4=0;

00008: 000C C7 05 00000004 00000000     MOV DWORD PTR _delta4+00000004, 00000000
00008: 0016 C7 05 00000000 00000000     MOV DWORD PTR _delta4, 00000000

; 556: }

00000: 0020                     L0000:
00000: 0020                             epilog 
00000: 0020 C9                          LEAVE 
00000: 0021 C3                          RETN 

Function: _get_mfrate

; 558: {return delta3;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 558: {return delta3;}

00008: 0003 DD 05 00000000              FLD QWORD PTR _delta3
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _vp

; 562: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 563:   c->x=a->y*b->z-a->z*b->y;

00008: 0003 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0006 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 0009 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00007: 000C DC 48 08                    FMUL QWORD PTR 00000008[EAX]
00007: 000F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0012 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00006: 0015 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00006: 0018 DC 48 10                    FMUL QWORD PTR 00000010[EAX]
00006: 001B DE E1                       FSUBRP ST(1), ST
00007: 001D 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 0020 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 564:   c->y=a->z*b->x-a->x*b->z;

00008: 0022 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0025 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0027 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00007: 002A DC 48 10                    FMUL QWORD PTR 00000010[EAX]
00007: 002D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0030 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00006: 0033 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00006: 0036 DC 08                       FMUL QWORD PTR 00000000[EAX]
00006: 0038 DE E1                       FSUBRP ST(1), ST
00007: 003A 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 003D DD 58 08                    FSTP QWORD PTR 00000008[EAX]

; 565:   c->z=a->x*b->y-a->y*b->x;

00008: 0040 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0043 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 0046 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00007: 0049 DC 08                       FMUL QWORD PTR 00000000[EAX]
00007: 004B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 004E DD 00                       FLD QWORD PTR 00000000[EAX]
00006: 0050 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00006: 0053 DC 48 08                    FMUL QWORD PTR 00000008[EAX]
00006: 0056 DE E1                       FSUBRP ST(1), ST
00007: 0058 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 005B DD 58 10                    FSTP QWORD PTR 00000010[EAX]

; 566: }

00000: 005E                     L0000:
00000: 005E                             epilog 
00000: 005E C9                          LEAVE 
00000: 005F C3                          RETN 

Function: _dist

; 568: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 18                    SUB ESP, 00000018
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 AB                          STOSD 
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 5F                          POP EDI
00000: 0017                             prolog 

; 570: x1=r.x-s.x;

00008: 0017 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 001A DC 65 20                    FSUB QWORD PTR 00000020[EBP]
00007: 001D DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 571: y1=r.y-s.y;

00008: 0020 DD 45 10                    FLD QWORD PTR 00000010[EBP]
00007: 0023 DC 65 28                    FSUB QWORD PTR 00000028[EBP]
00007: 0026 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 572: z1=r.z-s.z;

00008: 0029 DD 45 18                    FLD QWORD PTR 00000018[EBP]
00007: 002C DC 65 30                    FSUB QWORD PTR 00000030[EBP]
00007: 002F DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 573: return(y1*y1+x1*x1+z1*z1);

00008: 0032 DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 0035 D8 C8                       FMUL ST, ST
00007: 0037 DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00006: 003A D8 C8                       FMUL ST, ST
00006: 003C DE C1                       FADDP ST(1), ST
00007: 003E DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00006: 0041 D8 C8                       FMUL ST, ST
00006: 0043 DE C1                       FADDP ST(1), ST
00000: 0045                     L0000:
00000: 0045                             epilog 
00000: 0045 C9                          LEAVE 
00000: 0046 C3                          RETN 

Function: _reaction

; 581: {  

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 81 EC 000000B0              SUB ESP, 000000B0
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0014 B9 0000002C                 MOV ECX, 0000002C
00000: 0019 F3 AB                       REP STOSD 
00000: 001B                             prolog 

; 582:   int ct=ct1;

00008: 001B 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 001E 89 85 FFFFFF48              MOV DWORD PTR FFFFFF48[EBP], EAX

; 585:   if(sc<0)

00008: 0024 DD 45 18                    FLD QWORD PTR 00000018[EBP]
00007: 0027 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002D F1DF                        FCOMIP ST, ST(1), L0001
00007: 002F DD D8                       FSTP ST
00008: 0031 7A 3A                       JP L0001
00008: 0033 76 38                       JBE L0001

; 587:       rtype=coll[ct1].react;

00008: 0035 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 0038 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 003B 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0041 8B 44 DE 40                 MOV EAX, DWORD PTR 00000040[ESI][EBX*8]
00008: 0045 89 85 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EAX

; 588:       if(rtype<=0)return -1;

00008: 004B 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 0052 7F 0D                       JG L0002
00008: 0054 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0059                             epilog 
00000: 0059 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 005C 5F                          POP EDI
00000: 005D 5E                          POP ESI
00000: 005E 5B                          POP EBX
00000: 005F 5D                          POP EBP
00000: 0060 C3                          RETN 
00008: 0061                     L0002:

; 589:       revers=0;

00008: 0061 C7 85 FFFFFF5000000000      MOV DWORD PTR FFFFFF50[EBP], 00000000

; 590:     }

00008: 006B EB 51                       JMP L0003
00008: 006D                     L0001:

; 593:       ct=coll[ct1].prev;

00008: 006D 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 0070 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0073 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0079 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 007D 89 85 FFFFFF48              MOV DWORD PTR FFFFFF48[EBP], EAX

; 594:       rtype=~coll[ct].react;

00008: 0083 8B 9D FFFFFF48              MOV EBX, DWORD PTR FFFFFF48[EBP]
00008: 0089 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 008C 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0092 8B 54 DE 40                 MOV EDX, DWORD PTR 00000040[ESI][EBX*8]
00008: 0096 F7 D2                       NOT EDX
00008: 0098 89 95 FFFFFF4C              MOV DWORD PTR FFFFFF4C[EBP], EDX

; 595:       if(rtype<=0)return -1;

00008: 009E 83 BD FFFFFF4C00            CMP DWORD PTR FFFFFF4C[EBP], 00000000
00008: 00A5 7F 0D                       JG L0004
00008: 00A7 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 00AC                             epilog 
00000: 00AC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00AF 5F                          POP EDI
00000: 00B0 5E                          POP ESI
00000: 00B1 5B                          POP EBX
00000: 00B2 5D                          POP EBP
00000: 00B3 C3                          RETN 
00008: 00B4                     L0004:

; 596:       revers=1;

00008: 00B4 C7 85 FFFFFF5000000001      MOV DWORD PTR FFFFFF50[EBP], 00000001

; 597:     }

00008: 00BE                     L0003:

; 602:     double old_pot=coll[ct1].etot;

00008: 00BE 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 00C1 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 00C4 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 00CA DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 00CE DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 603:     double du,duc,new_pot=0;

00008: 00D1 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 00D7 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 605:     short np=get_np();  

00008: 00DA E8 00000000                 CALL SHORT _get_np
00008: 00DF 89 85 FFFFFF64              MOV DWORD PTR FFFFFF64[EBP], EAX

; 606:     short nq=get_nq();  

00008: 00E5 E8 00000000                 CALL SHORT _get_nq
00008: 00EA 89 85 FFFFFF68              MOV DWORD PTR FFFFFF68[EBP], EAX

; 607:     short * ap=get_atomp();  

00008: 00F0 E8 00000000                 CALL SHORT _get_atomp
00008: 00F5 89 85 FFFFFF6C              MOV DWORD PTR FFFFFF6C[EBP], EAX

; 608:     short * aq=get_atomq();  

00008: 00FB E8 00000000                 CALL SHORT _get_atomq
00008: 0100 89 85 FFFFFF70              MOV DWORD PTR FFFFFF70[EBP], EAX

; 609:     short * cp=get_collp();  

00008: 0106 E8 00000000                 CALL SHORT _get_collp
00008: 010B 89 85 FFFFFF74              MOV DWORD PTR FFFFFF74[EBP], EAX

; 610:     short * cq=get_collq();

00008: 0111 E8 00000000                 CALL SHORT _get_collq
00008: 0116 89 85 FFFFFF78              MOV DWORD PTR FFFFFF78[EBP], EAX

; 614:     a1=a+i1;

00008: 011C 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 011F 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0125 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0128 89 95 FFFFFF58              MOV DWORD PTR FFFFFF58[EBP], EDX

; 615:     a2=a+i2;

00008: 012E 8B 55 10                    MOV EDX, DWORD PTR 00000010[EBP]
00008: 0131 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0137 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 013A 89 95 FFFFFF5C              MOV DWORD PTR FFFFFF5C[EBP], EDX

; 616:     old1=a1->c;

00008: 0140 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 0146 0F BF 90 000000A4           MOVSX EDX, WORD PTR 000000A4[EAX]
00008: 014D 89 55 FFFFFF84              MOV DWORD PTR FFFFFF84[EBP], EDX

; 617:     old2=a2->c;

00008: 0150 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0156 0F BF 90 000000A4           MOVSX EDX, WORD PTR 000000A4[EAX]
00008: 015D 89 55 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EDX

; 618:     m1=a1->m;

00008: 0160 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 0166 DD 80 00000088              FLD QWORD PTR 00000088[EAX]
00007: 016C DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 619:     m2=a2->m;

00008: 016F 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 0175 DD 80 00000088              FLD QWORD PTR 00000088[EAX]
00007: 017B DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 620:     if(!revers)

00008: 017E 83 BD FFFFFF5000            CMP DWORD PTR FFFFFF50[EBP], 00000000
00008: 0185 75 7C                       JNE L0005

; 622: 	if(old1==react[rtype].old1)

00008: 0187 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 018D 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0190 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0196 0F BF 54 DE 10              MOVSX EDX, WORD PTR 00000010[ESI][EBX*8]
00008: 019B 39 55 FFFFFF84              CMP DWORD PTR FFFFFF84[EBP], EDX
00008: 019E 75 33                       JNE L0006

; 624: 	    new1=react[rtype].new1;

00008: 01A0 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 01A6 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01A9 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 01AF 0F BF 54 DE 14              MOVSX EDX, WORD PTR 00000014[ESI][EBX*8]
00008: 01B4 89 55 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EDX

; 625: 	    new2=react[rtype].new2;

00008: 01B7 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 01BD 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01C0 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 01C6 0F BF 54 DE 16              MOVSX EDX, WORD PTR 00000016[ESI][EBX*8]
00008: 01CB 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 626: 	  }

00008: 01CE E9 000000A7                 JMP L0007
00008: 01D3                     L0006:

; 629: 	    new1=react[rtype].new2;

00008: 01D3 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 01D9 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01DC 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 01E2 0F BF 54 DE 16              MOVSX EDX, WORD PTR 00000016[ESI][EBX*8]
00008: 01E7 89 55 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EDX

; 630: 	    new2=react[rtype].new1;

00008: 01EA 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 01F0 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 01F3 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 01F9 0F BF 54 DE 14              MOVSX EDX, WORD PTR 00000014[ESI][EBX*8]
00008: 01FE 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 632:       }

00008: 0201 EB 77                       JMP L0007
00008: 0203                     L0005:

; 635: 	if(old1==react[rtype].new1)

00008: 0203 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0209 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 020C 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0212 0F BF 54 DE 14              MOVSX EDX, WORD PTR 00000014[ESI][EBX*8]
00008: 0217 39 55 FFFFFF84              CMP DWORD PTR FFFFFF84[EBP], EDX
00008: 021A 75 30                       JNE L0008

; 637: 	    new1=react[rtype].old1;

00008: 021C 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0222 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0225 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 022B 0F BF 54 DE 10              MOVSX EDX, WORD PTR 00000010[ESI][EBX*8]
00008: 0230 89 55 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EDX

; 638: 	    new2=react[rtype].old2;

00008: 0233 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0239 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 023C 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0242 0F BF 54 DE 12              MOVSX EDX, WORD PTR 00000012[ESI][EBX*8]
00008: 0247 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 639: 	  }

00008: 024A EB 2E                       JMP L0009
00008: 024C                     L0008:

; 642: 	    new1=react[rtype].old2;

00008: 024C 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0252 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0255 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 025B 0F BF 54 DE 12              MOVSX EDX, WORD PTR 00000012[ESI][EBX*8]
00008: 0260 89 55 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EDX

; 643: 	    new2=react[rtype].old1;

00008: 0263 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0269 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 026C 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0272 0F BF 54 DE 10              MOVSX EDX, WORD PTR 00000010[ESI][EBX*8]
00008: 0277 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 644: 	  }

00008: 027A                     L0009:

; 645:       }

00008: 027A                     L0007:

; 649:     if(revers)

00008: 027A 83 BD FFFFFF5000            CMP DWORD PTR FFFFFF50[EBP], 00000000
00008: 0281 74 1B                       JE L000A

; 650:       ct_new=react[rtype].out;

00008: 0283 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0289 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 028C 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 0292 8B 44 DE 20                 MOV EAX, DWORD PTR 00000020[ESI][EBX*8]
00008: 0296 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX
00008: 029C EB 19                       JMP L000B
00008: 029E                     L000A:

; 652:       ct_new=react[rtype].in;

00008: 029E 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 02A4 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 02A7 8B 35 00000000              MOV ESI, DWORD PTR _react
00008: 02AD 8B 44 DE 1C                 MOV EAX, DWORD PTR 0000001C[ESI][EBX*8]
00008: 02B1 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX
00008: 02B7                     L000B:

; 654:     new_pot+=coll[ct_new].etot;

00008: 02B7 8B 9D FFFFFF60              MOV EBX, DWORD PTR FFFFFF60[EBP]
00008: 02BD 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 02C0 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 02C6 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 02C9 DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 02CD DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 655:     if(old1!=new1)

00008: 02D0 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 02D3 3B 45 FFFFFF8C              CMP EAX, DWORD PTR FFFFFF8C[EBP]
00008: 02D6 0F 84 0000012C              JE L000C

; 657: 	a1->c=new1;

00008: 02DC 66 8B 4D FFFFFF8C           MOV CX, WORD PTR FFFFFF8C[EBP]
00008: 02E0 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 02E6 66 89 88 000000A4           MOV WORD PTR 000000A4[EAX], CX

; 658: 	for(i=0;i<np;i++)

00008: 02ED C7 85 FFFFFF5400000000      MOV DWORD PTR FFFFFF54[EBP], 00000000
00008: 02F7 E9 000000F9                 JMP L000D
00008: 02FC                     L000E:

; 660: 	    ip=ap[i];

00008: 02FC 8B 8D FFFFFF54              MOV ECX, DWORD PTR FFFFFF54[EBP]
00008: 0302 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0308 0F BF 14 48                 MOVSX EDX, WORD PTR 00000000[EAX][ECX*2]
00008: 030C 89 55 FFFFFF80              MOV DWORD PTR FFFFFF80[EBP], EDX

; 661: 	    if(ip!=i2)

00008: 030F 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 0312 3B 45 10                    CMP EAX, DWORD PTR 00000010[EBP]
00008: 0315 0F 84 000000D4              JE L000F

; 663: 		old_pot+=coll[cp[ip]].etot;

00008: 031B 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 031E 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 0324 0F BF 1C 48                 MOVSX EBX, WORD PTR 00000000[EAX][ECX*2]
00008: 0328 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 032B 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0331 DD 45 FFFFFFBC              FLD QWORD PTR FFFFFFBC[EBP]
00007: 0334 DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 0338 DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 664: 		moveatom(a+ip);

00008: 033B 8B 55 FFFFFF80              MOV EDX, DWORD PTR FFFFFF80[EBP]
00008: 033E 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0344 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0347 52                          PUSH EDX
00008: 0348 E8 00000000                 CALL SHORT _moveatom
00008: 034D 59                          POP ECX

; 665: 		bond=is_bond(cp[ip]);

00008: 034E 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 0351 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 0357 0F BF 04 48                 MOVSX EAX, WORD PTR 00000000[EAX][ECX*2]
00008: 035B 50                          PUSH EAX
00008: 035C E8 00000000                 CALL SHORT _is_bond
00008: 0361 59                          POP ECX
00008: 0362 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 666: 		collp[ip]=after_type(i1,ip,&bond,cp[ip]);

00008: 0365 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 0368 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 036E 0F BF 04 48                 MOVSX EAX, WORD PTR 00000000[EAX][ECX*2]
00008: 0372 50                          PUSH EAX
00008: 0373 8D 45 FFFFFFF0              LEA EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0376 50                          PUSH EAX
00008: 0377 FF 75 FFFFFF80              PUSH DWORD PTR FFFFFF80[EBP]
00008: 037A FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 037D E8 00000000                 CALL SHORT _after_type
00008: 0382 83 C4 10                    ADD ESP, 00000010
00008: 0385 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 038B 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 038E 89 04 8B                    MOV DWORD PTR 00000000[EBX][ECX*4], EAX

; 667: 		if(collp[ip]<0)return -1;

00008: 0391 8B 15 00000000              MOV EDX, DWORD PTR _collp
00008: 0397 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 039A 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 039E 7D 0D                       JGE L0010
00008: 03A0 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 03A5                             epilog 
00000: 03A5 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03A8 5F                          POP EDI
00000: 03A9 5E                          POP ESI
00000: 03AA 5B                          POP EBX
00000: 03AB 5D                          POP EBP
00000: 03AC C3                          RETN 
00008: 03AD                     L0010:

; 668: 		new_pot+=new_pot+coll[collp[ip]].etot;

00008: 03AD 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 03B3 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 03B6 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 03B9 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 03BC 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 03C2 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 03C5 DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 03C9 DC 45 FFFFFFD4              FADD QWORD PTR FFFFFFD4[EBP]
00007: 03CC DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 669: 		if(bond)collp[ip]=~(collp[ip]);

00008: 03CF 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 03D3 74 1A                       JE L0011
00008: 03D5 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 03DB 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 03DE 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 03E1 F7 D6                       NOT ESI
00008: 03E3 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 03E9 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 03EC 89 34 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ESI
00008: 03EF                     L0011:

; 670: 	      }

00008: 03EF                     L000F:

; 671: 	  }

00008: 03EF FF 85 FFFFFF54              INC DWORD PTR FFFFFF54[EBP]
00008: 03F5                     L000D:
00008: 03F5 0F BF 95 FFFFFF64           MOVSX EDX, WORD PTR FFFFFF64[EBP]
00008: 03FC 39 95 FFFFFF54              CMP DWORD PTR FFFFFF54[EBP], EDX
00008: 0402 0F 8C FFFFFEF4              JL L000E

; 672:       }

00008: 0408                     L000C:

; 673:     if(old2!=new2)

00008: 0408 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 040B 3B 45 FFFFFF90              CMP EAX, DWORD PTR FFFFFF90[EBP]
00008: 040E 0F 84 0000014D              JE L0012

; 675: 	a2->c=new2;

00008: 0414 66 8B 4D FFFFFF90           MOV CX, WORD PTR FFFFFF90[EBP]
00008: 0418 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 041E 66 89 88 000000A4           MOV WORD PTR 000000A4[EAX], CX

; 676: 	for(i=0;i<nq;i++)

00008: 0425 C7 85 FFFFFF5400000000      MOV DWORD PTR FFFFFF54[EBP], 00000000
00008: 042F E9 0000011A                 JMP L0013
00008: 0434                     L0014:

; 678: 	    iq=aq[i];

00008: 0434 8B 8D FFFFFF54              MOV ECX, DWORD PTR FFFFFF54[EBP]
00008: 043A 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0440 0F BF 14 48                 MOVSX EDX, WORD PTR 00000000[EAX][ECX*2]
00008: 0444 89 95 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EDX

; 679: 	    if(iq!=i1)

00008: 044A 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 0450 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0453 0F 84 000000EF              JE L0015

; 681: 		old_pot+=coll[cq[iq]].etot;

00008: 0459 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 045F 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 0465 0F BF 1C 48                 MOVSX EBX, WORD PTR 00000000[EAX][ECX*2]
00008: 0469 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 046C 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0472 DD 45 FFFFFFBC              FLD QWORD PTR FFFFFFBC[EBP]
00007: 0475 DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 0479 DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 682: 		moveatom(a+iq);

00008: 047C 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 0482 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0488 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 048B 52                          PUSH EDX
00008: 048C E8 00000000                 CALL SHORT _moveatom
00008: 0491 59                          POP ECX

; 683: 		bond=is_bond(cq[iq]);

00008: 0492 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 0498 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 049E 0F BF 04 48                 MOVSX EAX, WORD PTR 00000000[EAX][ECX*2]
00008: 04A2 50                          PUSH EAX
00008: 04A3 E8 00000000                 CALL SHORT _is_bond
00008: 04A8 59                          POP ECX
00008: 04A9 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 684: 		collq[iq]=after_type(i2,iq,&bond,cq[iq]);

00008: 04AC 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 04B2 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 04B8 0F BF 04 48                 MOVSX EAX, WORD PTR 00000000[EAX][ECX*2]
00008: 04BC 50                          PUSH EAX
00008: 04BD 8D 45 FFFFFFF0              LEA EAX, DWORD PTR FFFFFFF0[EBP]
00008: 04C0 50                          PUSH EAX
00008: 04C1 FF B5 FFFFFF7C              PUSH DWORD PTR FFFFFF7C[EBP]
00008: 04C7 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 04CA E8 00000000                 CALL SHORT _after_type
00008: 04CF 83 C4 10                    ADD ESP, 00000010
00008: 04D2 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 04D8 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 04DE 89 04 8B                    MOV DWORD PTR 00000000[EBX][ECX*4], EAX

; 685: 		if(collq[iq]<0)return -1;

00008: 04E1 8B 15 00000000              MOV EDX, DWORD PTR _collq
00008: 04E7 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 04ED 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 04F1 7D 0D                       JGE L0016
00008: 04F3 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 04F8                             epilog 
00000: 04F8 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 04FB 5F                          POP EDI
00000: 04FC 5E                          POP ESI
00000: 04FD 5B                          POP EBX
00000: 04FE 5D                          POP EBP
00000: 04FF C3                          RETN 
00008: 0500                     L0016:

; 686: 		new_pot+=coll[collq[iq]].etot;

00008: 0500 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 0506 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 050C 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 050F 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0512 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0518 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 051B DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 051F DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 688: 		if(bond)collq[iq]=~(collq[iq]);

00008: 0522 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0526 74 20                       JE L0017
00008: 0528 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 052E 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 0534 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0537 F7 D6                       NOT ESI
00008: 0539 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 053F 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 0545 89 34 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ESI
00008: 0548                     L0017:

; 689: 	      }

00008: 0548                     L0015:

; 690: 	  }

00008: 0548 FF 85 FFFFFF54              INC DWORD PTR FFFFFF54[EBP]
00008: 054E                     L0013:
00008: 054E 0F BF 95 FFFFFF68           MOVSX EDX, WORD PTR FFFFFF68[EBP]
00008: 0555 39 95 FFFFFF54              CMP DWORD PTR FFFFFF54[EBP], EDX
00008: 055B 0F 8C FFFFFED3              JL L0014

; 691:       }

00008: 0561                     L0012:

; 693:     du=new_pot-old_pot;

00008: 0561 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0564 DC 65 FFFFFFBC              FSUB QWORD PTR FFFFFFBC[EBP]
00007: 0567 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]

; 694:     if(!react[rtype].bond)du+=react[rtype].eo;

00008: 056A 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0570 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0573 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0579 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 057F 75 18                       JNE L0018
00008: 0581 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0587 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 058A 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 0590 DD 45 FFFFFFC4              FLD QWORD PTR FFFFFFC4[EBP]
00007: 0593 DC 04 DA                    FADD QWORD PTR 00000000[EDX][EBX*8]
00007: 0596 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]
00008: 0599                     L0018:

; 695:     duc=du*corr_2;

00008: 0599 DD 45 FFFFFFC4              FLD QWORD PTR FFFFFFC4[EBP]
00007: 059C DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 05A2 DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 696:     ed=2*duc/(m1*m2*coll[ct].dm);

00008: 05A5 8B 9D FFFFFF48              MOV EBX, DWORD PTR FFFFFF48[EBP]
00008: 05AB 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 05AE 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 05B4 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 05B7 DC 4D FFFFFFE4              FMUL QWORD PTR FFFFFFE4[EBP]
00007: 05BA DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 05BE DD 05 00000000              FLD QWORD PTR .data+000000b0
00006: 05C4 DC 4D FFFFFFCC              FMUL QWORD PTR FFFFFFCC[EBP]
00006: 05C7 DE F1                       FDIVRP ST(1), ST
00007: 05C9 DD 5D FFFFFFB4              FSTP QWORD PTR FFFFFFB4[EBP]

; 697:     di=1.0+ed/(sc*sc);

00008: 05CC DD 45 18                    FLD QWORD PTR 00000018[EBP]
00007: 05CF D8 C8                       FMUL ST, ST
00007: 05D1 DD 45 FFFFFFB4              FLD QWORD PTR FFFFFFB4[EBP]
00006: 05D4 DE F1                       FDIVRP ST(1), ST
00007: 05D6 DC 05 00000000              FADD QWORD PTR .data+00000090
00007: 05DC DD 5D FFFFFFAC              FSTP QWORD PTR FFFFFFAC[EBP]

; 698:     if(di<=0)

00008: 05DF DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00007: 05E2 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 05E8 F1DF                        FCOMIP ST, ST(1), L0019
00007: 05EA DD D8                       FSTP ST
00008: 05EC 7A 67                       JP L0019
00008: 05EE 72 65                       JB L0019

; 704: 	ab=-2.0*sc*coll[ct].dm;

00008: 05F0 8B 9D FFFFFF48              MOV EBX, DWORD PTR FFFFFF48[EBP]
00008: 05F6 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 05F9 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 05FF DD 05 00000000              FLD QWORD PTR .data+000001e0
00007: 0605 DC 4D 18                    FMUL QWORD PTR 00000018[EBP]
00007: 0608 DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 060C DD 5D FFFFFFA4              FSTP QWORD PTR FFFFFFA4[EBP]

; 705: 	a1->c=old1;

00008: 060F 66 8B 4D FFFFFF84           MOV CX, WORD PTR FFFFFF84[EBP]
00008: 0613 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00008: 0619 66 89 88 000000A4           MOV WORD PTR 000000A4[EAX], CX

; 706: 	a2->c=old2;

00008: 0620 66 8B 4D FFFFFF88           MOV CX, WORD PTR FFFFFF88[EBP]
00008: 0624 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00008: 062A 66 89 88 000000A4           MOV WORD PTR 000000A4[EAX], CX

; 707: 	if(!revers)return -1;           

00008: 0631 83 BD FFFFFF5000            CMP DWORD PTR FFFFFF50[EBP], 00000000
00008: 0638 75 0D                       JNE L001A
00008: 063A B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 063F                             epilog 
00000: 063F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0642 5F                          POP EDI
00000: 0643 5E                          POP ESI
00000: 0644 5B                          POP EBX
00000: 0645 5D                          POP EBP
00000: 0646 C3                          RETN 
00008: 0647                     L001A:

; 708: 	ct_new=ct1;

00008: 0647 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 064A 89 85 FFFFFF60              MOV DWORD PTR FFFFFF60[EBP], EAX

; 709:       }

00008: 0650 E9 00000259                 JMP L001B
00008: 0655                     L0019:

; 712: 	ab=sc*coll[ct].dm*(sqrt(di)-1.0);

00008: 0655 FF 75 FFFFFFB0              PUSH DWORD PTR FFFFFFB0[EBP]
00008: 0658 FF 75 FFFFFFAC              PUSH DWORD PTR FFFFFFAC[EBP]
00008: 065B E8 00000000                 CALL SHORT _sqrt
00007: 0660 59                          POP ECX
00007: 0661 59                          POP ECX
00007: 0662 DC 25 00000000              FSUB QWORD PTR .data+00000090
00007: 0668 8B 9D FFFFFF48              MOV EBX, DWORD PTR FFFFFF48[EBP]
00007: 066E 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 0671 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 0677 DD 45 18                    FLD QWORD PTR 00000018[EBP]
00006: 067A DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00006: 067E DE C9                       FMULP ST(1), ST
00007: 0680 DD 5D FFFFFFA4              FSTP QWORD PTR FFFFFFA4[EBP]

; 713: 	vvm+=duc;

00008: 0683 DD 05 00000000              FLD QWORD PTR _vvm
00007: 0689 DC 45 FFFFFFCC              FADD QWORD PTR FFFFFFCC[EBP]
00007: 068C DD 1D 00000000              FSTP QWORD PTR _vvm

; 714: 	potential+=du;

00008: 0692 DD 05 00000000              FLD QWORD PTR _potential
00007: 0698 DC 45 FFFFFFC4              FADD QWORD PTR FFFFFFC4[EBP]
00007: 069B DD 1D 00000000              FSTP QWORD PTR _potential

; 715: 	if((react[rtype].old1!=react[rtype].new1)||(react[rtype].old2!=react[rtype].new2))

00008: 06A1 8B B5 FFFFFF4C              MOV ESI, DWORD PTR FFFFFF4C[EBP]
00008: 06A7 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 06AA 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 06B0 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 06B6 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 06B9 8B 3D 00000000              MOV EDI, DWORD PTR _react
00008: 06BF 66 8B 5C DF 10              MOV BX, WORD PTR 00000010[EDI][EBX*8]
00008: 06C4 66 8B 54 F2 14              MOV DX, WORD PTR 00000014[EDX][ESI*8]
00008: 06C9 66 39 D3                    CMP BX, DX
00008: 06CC 75 2D                       JNE L001C
00008: 06CE 8B B5 FFFFFF4C              MOV ESI, DWORD PTR FFFFFF4C[EBP]
00008: 06D4 8D 34 B6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*4]
00008: 06D7 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 06DD 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 06E3 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 06E6 8B 3D 00000000              MOV EDI, DWORD PTR _react
00008: 06EC 66 8B 5C DF 12              MOV BX, WORD PTR 00000012[EDI][EBX*8]
00008: 06F1 66 8B 54 F2 16              MOV DX, WORD PTR 00000016[EDX][ESI*8]
00008: 06F6 66 39 D3                    CMP BX, DX
00008: 06F9 74 08                       JE L001D
00008: 06FB                     L001C:

; 716: 	  setNewTypes(1);

00008: 06FB 6A 01                       PUSH 00000001
00008: 06FD E8 00000000                 CALL SHORT _setNewTypes
00008: 0702 59                          POP ECX
00008: 0703                     L001D:

; 717: 	if(revers)

00008: 0703 83 BD FFFFFF5000            CMP DWORD PTR FFFFFF50[EBP], 00000000
00008: 070A 74 0F                       JE L001E

; 718: 	  breakBond(i1,i2);

00008: 070C FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 070F FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0712 E8 00000000                 CALL SHORT _breakBond
00008: 0717 59                          POP ECX
00008: 0718 59                          POP ECX
00008: 0719 EB 24                       JMP L001F
00008: 071B                     L001E:

; 719:         else if(react[rtype].bond)

00008: 071B 8B 9D FFFFFF4C              MOV EBX, DWORD PTR FFFFFF4C[EBP]
00008: 0721 8D 1C 9B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*4]
00008: 0724 8B 15 00000000              MOV EDX, DWORD PTR _react
00008: 072A 66 83 7C DA 18 00           CMP WORD PTR 00000018[EDX][EBX*8], 0000
00008: 0730 74 0D                       JE L0020

; 720: 	  setBond(i1,i2);

00008: 0732 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 0735 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0738 E8 00000000                 CALL SHORT _setBond
00008: 073D 59                          POP ECX
00008: 073E 59                          POP ECX
00008: 073F                     L0020:
00008: 073F                     L001F:

; 721: 	if(new2!=old2)

00008: 073F 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0742 3B 45 FFFFFF88              CMP EAX, DWORD PTR FFFFFF88[EBP]
00008: 0745 0F 84 000000AF              JE L0021

; 722: 	for(i=0;i<nq;i++)

00008: 074B C7 85 FFFFFF5400000000      MOV DWORD PTR FFFFFF54[EBP], 00000000
00008: 0755 E9 0000008D                 JMP L0022
00008: 075A                     L0023:

; 724: 	    iq=aq[i];

00008: 075A 8B 8D FFFFFF54              MOV ECX, DWORD PTR FFFFFF54[EBP]
00008: 0760 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0766 0F BF 14 48                 MOVSX EDX, WORD PTR 00000000[EAX][ECX*2]
00008: 076A 89 95 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EDX

; 725:             if(iq!=i1)

00008: 0770 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 0776 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0779 74 66                       JE L0024

; 727: 		if(collq[iq]<0)

00008: 077B 8B 15 00000000              MOV EDX, DWORD PTR _collq
00008: 0781 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 0787 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 078B 7D 34                       JGE L0025

; 729: 		    breakBond(i2,iq);

00008: 078D FF B5 FFFFFF7C              PUSH DWORD PTR FFFFFF7C[EBP]
00008: 0793 FF 75 10                    PUSH DWORD PTR 00000010[EBP]
00008: 0796 E8 00000000                 CALL SHORT _breakBond
00008: 079B 59                          POP ECX
00008: 079C 59                          POP ECX

; 730: 		    cq[iq]=~collq[iq];

00008: 079D 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 07A3 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 07A9 66 8B 1C 83                 MOV BX, WORD PTR 00000000[EBX][EAX*4]
00008: 07AD F7 D3                       NOT EBX
00008: 07AF 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 07B5 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 07BB 66 89 1C 48                 MOV WORD PTR 00000000[EAX][ECX*2], BX

; 731: 		  }

00008: 07BF EB 20                       JMP L0026
00008: 07C1                     L0025:

; 733: 		  cq[iq]=collq[iq];

00008: 07C1 8B 1D 00000000              MOV EBX, DWORD PTR _collq
00008: 07C7 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 07CD 66 8B 1C 83                 MOV BX, WORD PTR 00000000[EBX][EAX*4]
00008: 07D1 8B 8D FFFFFF7C              MOV ECX, DWORD PTR FFFFFF7C[EBP]
00008: 07D7 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 07DD 66 89 1C 48                 MOV WORD PTR 00000000[EAX][ECX*2], BX
00008: 07E1                     L0026:

; 734: 	      }

00008: 07E1                     L0024:

; 735: 	  }

00008: 07E1 FF 85 FFFFFF54              INC DWORD PTR FFFFFF54[EBP]
00008: 07E7                     L0022:
00008: 07E7 0F BF 95 FFFFFF68           MOVSX EDX, WORD PTR FFFFFF68[EBP]
00008: 07EE 39 95 FFFFFF54              CMP DWORD PTR FFFFFF54[EBP], EDX
00008: 07F4 0F 8C FFFFFF60              JL L0023
00008: 07FA                     L0021:

; 736: 	if(new1!=old1)

00008: 07FA 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 07FD 3B 45 FFFFFF84              CMP EAX, DWORD PTR FFFFFF84[EBP]
00008: 0800 0F 84 00000094              JE L0027

; 737: 	for(i=0;i<np;i++)

00008: 0806 C7 85 FFFFFF5400000000      MOV DWORD PTR FFFFFF54[EBP], 00000000
00008: 0810 EB 75                       JMP L0028
00008: 0812                     L0029:

; 739: 	    ip=ap[i];

00008: 0812 8B 8D FFFFFF54              MOV ECX, DWORD PTR FFFFFF54[EBP]
00008: 0818 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 081E 0F BF 14 48                 MOVSX EDX, WORD PTR 00000000[EAX][ECX*2]
00008: 0822 89 55 FFFFFF80              MOV DWORD PTR FFFFFF80[EBP], EDX

; 740:             if(ip!=i2)

00008: 0825 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 0828 3B 45 10                    CMP EAX, DWORD PTR 00000010[EBP]
00008: 082B 74 54                       JE L002A

; 742: 		if(collp[ip]<0)

00008: 082D 8B 15 00000000              MOV EDX, DWORD PTR _collp
00008: 0833 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 0836 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 083A 7D 2B                       JGE L002B

; 744: 		    breakBond(i1,ip);

00008: 083C FF 75 FFFFFF80              PUSH DWORD PTR FFFFFF80[EBP]
00008: 083F FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0842 E8 00000000                 CALL SHORT _breakBond
00008: 0847 59                          POP ECX
00008: 0848 59                          POP ECX

; 745: 		    cp[ip]=~collp[ip];

00008: 0849 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 084F 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 0852 66 8B 1C 83                 MOV BX, WORD PTR 00000000[EBX][EAX*4]
00008: 0856 F7 D3                       NOT EBX
00008: 0858 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 085B 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 0861 66 89 1C 48                 MOV WORD PTR 00000000[EAX][ECX*2], BX

; 746: 		  }

00008: 0865 EB 1A                       JMP L002C
00008: 0867                     L002B:

; 748: 		  cp[ip]=collp[ip];

00008: 0867 8B 1D 00000000              MOV EBX, DWORD PTR _collp
00008: 086D 8B 45 FFFFFF80              MOV EAX, DWORD PTR FFFFFF80[EBP]
00008: 0870 66 8B 1C 83                 MOV BX, WORD PTR 00000000[EBX][EAX*4]
00008: 0874 8B 4D FFFFFF80              MOV ECX, DWORD PTR FFFFFF80[EBP]
00008: 0877 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 087D 66 89 1C 48                 MOV WORD PTR 00000000[EAX][ECX*2], BX
00008: 0881                     L002C:

; 749: 	      }

00008: 0881                     L002A:

; 750: 	  }

00008: 0881 FF 85 FFFFFF54              INC DWORD PTR FFFFFF54[EBP]
00008: 0887                     L0028:
00008: 0887 0F BF 95 FFFFFF64           MOVSX EDX, WORD PTR FFFFFF64[EBP]
00008: 088E 39 95 FFFFFF54              CMP DWORD PTR FFFFFF54[EBP], EDX
00008: 0894 0F 8C FFFFFF78              JL L0029
00008: 089A                     L0027:

; 751: 	cp[i2]=ct_new;

00008: 089A 66 8B 95 FFFFFF60           MOV DX, WORD PTR FFFFFF60[EBP]
00008: 08A1 8B 4D 10                    MOV ECX, DWORD PTR 00000010[EBP]
00008: 08A4 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 08AA 66 89 14 48                 MOV WORD PTR 00000000[EAX][ECX*2], DX

; 753:       }

00008: 08AE                     L001B:

; 755:     ab1=ab*m2;

00008: 08AE DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00007: 08B1 DC 4D FFFFFFE4              FMUL QWORD PTR FFFFFFE4[EBP]
00007: 08B4 DD 5D FFFFFF94              FSTP QWORD PTR FFFFFF94[EBP]

; 756:     ab2=-ab*m1;

00008: 08B7 DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00007: 08BA D9 E0                       FCHS 
00007: 08BC DC 4D FFFFFFDC              FMUL QWORD PTR FFFFFFDC[EBP]
00007: 08BF DD 5D FFFFFF9C              FSTP QWORD PTR FFFFFF9C[EBP]

; 757:     virial+=ab1*m1*coll[ct].dd;

00008: 08C2 8B 9D FFFFFF48              MOV EBX, DWORD PTR FFFFFF48[EBP]
00008: 08C8 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 08CB 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 08D1 DD 45 FFFFFF94              FLD QWORD PTR FFFFFF94[EBP]
00007: 08D4 DC 4D FFFFFFDC              FMUL QWORD PTR FFFFFFDC[EBP]
00007: 08D7 DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 08DB DC 05 00000000              FADD QWORD PTR _virial
00007: 08E1 DD 1D 00000000              FSTP QWORD PTR _virial

; 758:     a1->v.x+=x*ab1;

00008: 08E7 DD 45 20                    FLD QWORD PTR 00000020[EBP]
00007: 08EA DC 4D FFFFFF94              FMUL QWORD PTR FFFFFF94[EBP]
00007: 08ED 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 08F3 DC 40 18                    FADD QWORD PTR 00000018[EAX]
00007: 08F6 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 08FC DD 58 18                    FSTP QWORD PTR 00000018[EAX]

; 759:     a1->v.y+=y*ab1;

00008: 08FF DD 45 28                    FLD QWORD PTR 00000028[EBP]
00007: 0902 DC 4D FFFFFF94              FMUL QWORD PTR FFFFFF94[EBP]
00007: 0905 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 090B DC 40 20                    FADD QWORD PTR 00000020[EAX]
00007: 090E 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 0914 DD 58 20                    FSTP QWORD PTR 00000020[EAX]

; 760:     a1->v.z+=z*ab1;

00008: 0917 DD 45 30                    FLD QWORD PTR 00000030[EBP]
00007: 091A DC 4D FFFFFF94              FMUL QWORD PTR FFFFFF94[EBP]
00007: 091D 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 0923 DC 40 28                    FADD QWORD PTR 00000028[EAX]
00007: 0926 8B 85 FFFFFF58              MOV EAX, DWORD PTR FFFFFF58[EBP]
00007: 092C DD 58 28                    FSTP QWORD PTR 00000028[EAX]

; 761:     a2->v.x+=x*ab2;

00008: 092F DD 45 20                    FLD QWORD PTR 00000020[EBP]
00007: 0932 DC 4D FFFFFF9C              FMUL QWORD PTR FFFFFF9C[EBP]
00007: 0935 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 093B DC 40 18                    FADD QWORD PTR 00000018[EAX]
00007: 093E 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0944 DD 58 18                    FSTP QWORD PTR 00000018[EAX]

; 762:     a2->v.y+=y*ab2;

00008: 0947 DD 45 28                    FLD QWORD PTR 00000028[EBP]
00007: 094A DC 4D FFFFFF9C              FMUL QWORD PTR FFFFFF9C[EBP]
00007: 094D 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0953 DC 40 20                    FADD QWORD PTR 00000020[EAX]
00007: 0956 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 095C DD 58 20                    FSTP QWORD PTR 00000020[EAX]

; 763:     a2->v.z+=z*ab2;

00008: 095F DD 45 30                    FLD QWORD PTR 00000030[EBP]
00007: 0962 DC 4D FFFFFF9C              FMUL QWORD PTR FFFFFF9C[EBP]
00007: 0965 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 096B DC 40 28                    FADD QWORD PTR 00000028[EAX]
00007: 096E 8B 85 FFFFFF5C              MOV EAX, DWORD PTR FFFFFF5C[EBP]
00007: 0974 DD 58 28                    FSTP QWORD PTR 00000028[EAX]

; 764:     return ct_new; 

00008: 0977 8B 85 FFFFFF60              MOV EAX, DWORD PTR FFFFFF60[EBP]
00000: 097D                     L0000:
00000: 097D                             epilog 
00000: 097D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0980 5F                          POP EDI
00000: 0981 5E                          POP ESI
00000: 0982 5B                          POP EBX
00000: 0983 5D                          POP EBP
00000: 0984 C3                          RETN 

Function: _newvel

; 769: {  

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 81 EC 00000088              SUB ESP, 00000088
00000: 000B 57                          PUSH EDI
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0015 B9 00000022                 MOV ECX, 00000022
00000: 001A F3 AB                       REP STOSD 
00000: 001C 5F                          POP EDI
00000: 001D                             prolog 

; 773:   long k, ct=ct1;

00008: 001D 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 0020 89 45 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EAX

; 774:   if(i1<j1)

00008: 0023 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0026 3B 45 10                    CMP EAX, DWORD PTR 00000010[EBP]
00008: 0029 7D 14                       JGE L0001

; 776:       i=i1;

00008: 002B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 002E 89 85 FFFFFF70              MOV DWORD PTR FFFFFF70[EBP], EAX

; 777:       j=j1;

00008: 0034 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0037 89 85 FFFFFF74              MOV DWORD PTR FFFFFF74[EBP], EAX

; 778:     }

00008: 003D EB 12                       JMP L0002
00008: 003F                     L0001:

; 781:       i=j1;

00008: 003F 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0042 89 85 FFFFFF70              MOV DWORD PTR FFFFFF70[EBP], EAX

; 782:       j=i1;

00008: 0048 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 004B 89 85 FFFFFF74              MOV DWORD PTR FFFFFF74[EBP], EAX

; 783:     }

00008: 0051                     L0002:

; 787:   a1=a+i;

00008: 0051 8B 95 FFFFFF70              MOV EDX, DWORD PTR FFFFFF70[EBP]
00008: 0057 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 005D 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0060 89 55 FFFFFF84              MOV DWORD PTR FFFFFF84[EBP], EDX

; 788:   a2=a+j;

00008: 0063 8B 95 FFFFFF74              MOV EDX, DWORD PTR FFFFFF74[EBP]
00008: 0069 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 006F 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0072 89 55 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EDX

; 789:   moveatom(a1);

00008: 0075 FF 75 FFFFFF84              PUSH DWORD PTR FFFFFF84[EBP]
00008: 0078 E8 00000000                 CALL SHORT _moveatom
00008: 007D 59                          POP ECX

; 790:   moveatom(a2);

00008: 007E FF 75 FFFFFF88              PUSH DWORD PTR FFFFFF88[EBP]
00008: 0081 E8 00000000                 CALL SHORT _moveatom
00008: 0086 59                          POP ECX

; 791:   vx=a1->v.x-a2->v.x;

00008: 0087 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 008A DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 008D 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 0090 DC 60 18                    FSUB QWORD PTR 00000018[EAX]
00007: 0093 DD 5D FFFFFFA8              FSTP QWORD PTR FFFFFFA8[EBP]

; 792:   vy=a1->v.y-a2->v.y;

00008: 0096 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 0099 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 009C 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 009F DC 60 20                    FSUB QWORD PTR 00000020[EAX]
00007: 00A2 DD 5D FFFFFFB0              FSTP QWORD PTR FFFFFFB0[EBP]

; 793:   vz=a1->v.z-a2->v.z;

00008: 00A5 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00A8 DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 00AB 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 00AE DC 60 28                    FSUB QWORD PTR 00000028[EAX]
00007: 00B1 DD 5D FFFFFFB8              FSTP QWORD PTR FFFFFFB8[EBP]

; 794:   x=a1->r.x-a2->r.x;

00008: 00B4 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00B7 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 00B9 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 00BC DC 20                       FSUB QWORD PTR 00000000[EAX]
00007: 00BE DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]

; 795:   y=a1->r.y-a2->r.y;

00008: 00C1 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00C4 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 00C7 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 00CA DC 60 08                    FSUB QWORD PTR 00000008[EAX]
00007: 00CD DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]

; 796:   z=a1->r.z-a2->r.z;

00008: 00D0 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00D3 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 00D6 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 00D9 DC 60 10                    FSUB QWORD PTR 00000010[EAX]
00007: 00DC DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]

; 797:   ix=a1->i.x.i-a2->i.x.i;

00008: 00DF 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00E2 8B 50 30                    MOV EDX, DWORD PTR 00000030[EAX]
00008: 00E5 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 00E8 2B 50 30                    SUB EDX, DWORD PTR 00000030[EAX]
00008: 00EB 89 95 FFFFFF78              MOV DWORD PTR FFFFFF78[EBP], EDX

; 798:   iy=a1->i.y.i-a2->i.y.i;

00008: 00F1 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 00F4 8B 50 38                    MOV EDX, DWORD PTR 00000038[EAX]
00008: 00F7 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 00FA 2B 50 38                    SUB EDX, DWORD PTR 00000038[EAX]
00008: 00FD 89 95 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EDX

; 799:   iz=a1->i.z.i-a2->i.z.i;

00008: 0103 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 0106 8B 50 40                    MOV EDX, DWORD PTR 00000040[EAX]
00008: 0109 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 010C 2B 50 40                    SUB EDX, DWORD PTR 00000040[EAX]
00008: 010F 89 55 FFFFFF80              MOV DWORD PTR FFFFFF80[EBP], EDX

; 800:   if (ix>1)x-=bound[0].length;

00008: 0112 83 BD FFFFFF7801            CMP DWORD PTR FFFFFF78[EBP], 00000001
00008: 0119 7E 0E                       JLE L0003
00008: 011B DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 011E DC 25 00000000              FSUB QWORD PTR _bound
00007: 0124 DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]
00008: 0127 EB 15                       JMP L0004
00008: 0129                     L0003:

; 801:   else if (ix<-1)x+=bound[0].length;

00008: 0129 83 BD FFFFFF78FFFFFFFF      CMP DWORD PTR FFFFFF78[EBP], FFFFFFFF
00008: 0130 7D 0C                       JGE L0005
00008: 0132 DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 0135 DC 05 00000000              FADD QWORD PTR _bound
00007: 013B DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]
00008: 013E                     L0005:
00008: 013E                     L0004:

; 802:   if (iy>1)y-=bound[1].length;

00008: 013E 83 BD FFFFFF7C01            CMP DWORD PTR FFFFFF7C[EBP], 00000001
00008: 0145 7E 0E                       JLE L0006
00008: 0147 DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 014A DC 25 00000018              FSUB QWORD PTR _bound+00000018
00007: 0150 DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]
00008: 0153 EB 15                       JMP L0007
00008: 0155                     L0006:

; 803:   else if (iy<-1)y+=bound[1].length;

00008: 0155 83 BD FFFFFF7CFFFFFFFF      CMP DWORD PTR FFFFFF7C[EBP], FFFFFFFF
00008: 015C 7D 0C                       JGE L0008
00008: 015E DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 0161 DC 05 00000018              FADD QWORD PTR _bound+00000018
00007: 0167 DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]
00008: 016A                     L0008:
00008: 016A                     L0007:

; 804:   if (iz>1)z-=bound[2].length;

00008: 016A 83 7D FFFFFF80 01           CMP DWORD PTR FFFFFF80[EBP], 00000001
00008: 016E 7E 0E                       JLE L0009
00008: 0170 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0173 DC 25 00000030              FSUB QWORD PTR _bound+00000030
00007: 0179 DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]
00008: 017C EB 12                       JMP L000A
00008: 017E                     L0009:

; 805:   else if (iz<-1)z+=bound[2].length;

00008: 017E 83 7D FFFFFF80 FFFFFFFF     CMP DWORD PTR FFFFFF80[EBP], FFFFFFFF
00008: 0182 7D 0C                       JGE L000B
00008: 0184 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0187 DC 05 00000030              FADD QWORD PTR _bound+00000030
00007: 018D DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]
00008: 0190                     L000B:
00008: 0190                     L000A:

; 806:   sc=vx*x+vy*y+vz*z;

00008: 0190 DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00007: 0193 DC 4D FFFFFFC8              FMUL QWORD PTR FFFFFFC8[EBP]
00007: 0196 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00006: 0199 DC 4D FFFFFFC0              FMUL QWORD PTR FFFFFFC0[EBP]
00006: 019C DE C1                       FADDP ST(1), ST
00007: 019E DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00006: 01A1 DC 4D FFFFFFD0              FMUL QWORD PTR FFFFFFD0[EBP]
00006: 01A4 DE C1                       FADDP ST(1), ST
00007: 01A6 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 808: if(nrt)

00008: 01A9 83 3D 00000000 00           CMP DWORD PTR _nrt, 00000000
00008: 01B0 74 45                       JE L000C

; 812:       ctr=reaction(a,i,j,ct1,sc,x,y,z);

00008: 01B2 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 01B5 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 01B8 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 01BB FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 01BE FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 01C1 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 01C4 FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 01C7 FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 01CA FF 75 14                    PUSH DWORD PTR 00000014[EBP]
00008: 01CD FF B5 FFFFFF74              PUSH DWORD PTR FFFFFF74[EBP]
00008: 01D3 FF B5 FFFFFF70              PUSH DWORD PTR FFFFFF70[EBP]
00008: 01D9 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01DC E8 00000000                 CALL SHORT _reaction
00008: 01E1 83 C4 30                    ADD ESP, 00000030
00008: 01E4 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX

; 814:       if(ctr>-1){return ctr;}

00008: 01E7 83 7D FFFFFF94 FFFFFFFF     CMP DWORD PTR FFFFFF94[EBP], FFFFFFFF
00008: 01EB 7E 0A                       JLE L000D
00008: 01ED 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00000: 01F0                             epilog 
00000: 01F0 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 01F3 5E                          POP ESI
00000: 01F4 5B                          POP EBX
00000: 01F5 5D                          POP EBP
00000: 01F6 C3                          RETN 
00008: 01F7                     L000D:

; 817:     }

00008: 01F7                     L000C:

; 819:   k=ct;

00008: 01F7 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 01FA 89 45 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EAX

; 820:   ed=coll[k].edm;

00008: 01FD 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0200 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0203 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0209 DD 44 DA 28                 FLD QWORD PTR 00000028[EDX][EBX*8]
00007: 020D DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 823:   if(sc>=0)

00008: 0210 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 0213 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0219 F1DF                        FCOMIP ST, ST(1), L000E
00007: 021B DD D8                       FSTP ST
00008: 021D 7A 2A                       JP L000E
00008: 021F 77 28                       JA L000E

; 826:       k=coll[k].prev;

00008: 0221 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0224 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0227 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 022D 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0231 89 45 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EAX

; 827:       ed=-coll[k].edm;  /* depth of potential well */

00008: 0234 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0237 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 023A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0240 DD 44 DA 28                 FLD QWORD PTR 00000028[EDX][EBX*8]
00007: 0244 D9 E0                       FCHS 
00007: 0246 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 833:     }

00008: 0249                     L000E:

; 834:   if(coll[k].e==-dblarg1)

00008: 0249 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 024C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 024F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0255 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 025B D9 E0                       FCHS 
00007: 025D DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00006: 0260 F1DF                        FCOMIP ST, ST(1), L000F
00007: 0262 DD D8                       FSTP ST
00008: 0264 7A 23                       JP L000F
00008: 0266 75 21                       JNE L000F

; 837:       ab=-2.0*sc*coll[k].dm;

00008: 0268 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 026B 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 026E 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0274 DD 05 00000000              FLD QWORD PTR .data+000001e0
00007: 027A DC 4D FFFFFFE0              FMUL QWORD PTR FFFFFFE0[EBP]
00007: 027D DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 0281 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 840:     }

00008: 0284 E9 0000010A                 JMP L0010
00008: 0289                     L000F:

; 843:       di=1.0+ed/(sc*sc);

00008: 0289 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 028C D8 C8                       FMUL ST, ST
00007: 028E DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00006: 0291 DE F1                       FDIVRP ST(1), ST
00007: 0293 DC 05 00000000              FADD QWORD PTR .data+00000090
00007: 0299 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 844:       if(di<=0)

00008: 029C DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 029F DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 02A5 F1DF                        FCOMIP ST, ST(1), L0011
00007: 02A7 DD D8                       FSTP ST
00008: 02A9 7A 23                       JP L0011
00008: 02AB 72 21                       JB L0011

; 850: 	  ab=-2.0*sc*coll[k].dm;

00008: 02AD 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 02B0 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 02B3 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 02B9 DD 05 00000000              FLD QWORD PTR .data+000001e0
00007: 02BF DC 4D FFFFFFE0              FMUL QWORD PTR FFFFFFE0[EBP]
00007: 02C2 DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 02C6 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 853: 	}

00008: 02C9 E9 000000C5                 JMP L0012
00008: 02CE                     L0011:

; 856: 	  ab=sc*coll[k].dm*(sqrt(di)-1.0);

00008: 02CE FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 02D1 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 02D4 E8 00000000                 CALL SHORT _sqrt
00007: 02D9 59                          POP ECX
00007: 02DA 59                          POP ECX
00007: 02DB DC 25 00000000              FSUB QWORD PTR .data+00000090
00007: 02E1 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00007: 02E4 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00007: 02E7 8B 15 00000000              MOV EDX, DWORD PTR _coll
00007: 02ED DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00006: 02F0 DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00006: 02F4 DE C9                       FMULP ST(1), ST
00007: 02F6 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 857: 	  if (sc>=0.0) 

00008: 02F9 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 02FC DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0302 F1DF                        FCOMIP ST, ST(1), L0013
00007: 0304 DD D8                       FSTP ST
00008: 0306 7A 41                       JP L0013
00008: 0308 77 3F                       JA L0013

; 860: 	      ct=k;

00008: 030A 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 030D 89 45 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EAX

; 861: 	      vvm-=coll[k].e;

00008: 0310 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0313 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0316 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 031C DD 05 00000000              FLD QWORD PTR _vvm
00007: 0322 DC 24 DA                    FSUB QWORD PTR 00000000[EDX][EBX*8]
00007: 0325 DD 1D 00000000              FSTP QWORD PTR _vvm

; 862: 	      potential-=coll[k].eo;

00008: 032B 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 032E 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0331 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0337 DD 05 00000000              FLD QWORD PTR _potential
00007: 033D DC 64 DA 08                 FSUB QWORD PTR 00000008[EDX][EBX*8]
00007: 0341 DD 1D 00000000              FSTP QWORD PTR _potential

; 863: 	    }

00008: 0347 EB 4A                       JMP L0014
00008: 0349                     L0013:

; 867: 	      vvm+=coll[k].e;

00008: 0349 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 034C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 034F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0355 DD 05 00000000              FLD QWORD PTR _vvm
00007: 035B DC 04 DA                    FADD QWORD PTR 00000000[EDX][EBX*8]
00007: 035E DD 1D 00000000              FSTP QWORD PTR _vvm

; 868: 	      potential+=coll[k].eo;

00008: 0364 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0367 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 036A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0370 DD 05 00000000              FLD QWORD PTR _potential
00007: 0376 DC 44 DA 08                 FADD QWORD PTR 00000008[EDX][EBX*8]
00007: 037A DD 1D 00000000              FSTP QWORD PTR _potential

; 869: 	      ct=coll[k].next;

00008: 0380 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 0383 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0386 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 038C 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0390 89 45 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EAX

; 870: 	    }

00008: 0393                     L0014:

; 871: 	}

00008: 0393                     L0012:

; 872:     }

00008: 0393                     L0010:

; 873:   ab1=ab*a2->m;

00008: 0393 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 0396 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 0399 DC 88 00000088              FMUL QWORD PTR 00000088[EAX]
00007: 039F DD 5D FFFFFF98              FSTP QWORD PTR FFFFFF98[EBP]

; 874:   ab2=-ab*a1->m;

00008: 03A2 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 03A5 D9 E0                       FCHS 
00007: 03A7 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03AA DC 88 00000088              FMUL QWORD PTR 00000088[EAX]
00007: 03B0 DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]

; 875:   virial+=ab1*a1->m*coll[k].dd;

00008: 03B3 8B 5D FFFFFF8C              MOV EBX, DWORD PTR FFFFFF8C[EBP]
00008: 03B6 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 03B9 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 03BF DD 45 FFFFFF98              FLD QWORD PTR FFFFFF98[EBP]
00007: 03C2 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03C5 DC 88 00000088              FMUL QWORD PTR 00000088[EAX]
00007: 03CB DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 03CF DC 05 00000000              FADD QWORD PTR _virial
00007: 03D5 DD 1D 00000000              FSTP QWORD PTR _virial

; 876:   a1->v.x+=x*ab1;

00008: 03DB DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 03DE DC 4D FFFFFF98              FMUL QWORD PTR FFFFFF98[EBP]
00007: 03E1 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03E4 DC 40 18                    FADD QWORD PTR 00000018[EAX]
00007: 03E7 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03EA DD 58 18                    FSTP QWORD PTR 00000018[EAX]

; 877:   a1->v.y+=y*ab1;

00008: 03ED DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 03F0 DC 4D FFFFFF98              FMUL QWORD PTR FFFFFF98[EBP]
00007: 03F3 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03F6 DC 40 20                    FADD QWORD PTR 00000020[EAX]
00007: 03F9 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 03FC DD 58 20                    FSTP QWORD PTR 00000020[EAX]

; 878:   a1->v.z+=z*ab1;

00008: 03FF DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0402 DC 4D FFFFFF98              FMUL QWORD PTR FFFFFF98[EBP]
00007: 0405 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 0408 DC 40 28                    FADD QWORD PTR 00000028[EAX]
00007: 040B 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00007: 040E DD 58 28                    FSTP QWORD PTR 00000028[EAX]

; 879:   a2->v.x+=x*ab2;

00008: 0411 DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 0414 DC 4D FFFFFFA0              FMUL QWORD PTR FFFFFFA0[EBP]
00007: 0417 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 041A DC 40 18                    FADD QWORD PTR 00000018[EAX]
00007: 041D 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 0420 DD 58 18                    FSTP QWORD PTR 00000018[EAX]

; 880:   a2->v.y+=y*ab2;

00008: 0423 DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 0426 DC 4D FFFFFFA0              FMUL QWORD PTR FFFFFFA0[EBP]
00007: 0429 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 042C DC 40 20                    FADD QWORD PTR 00000020[EAX]
00007: 042F 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 0432 DD 58 20                    FSTP QWORD PTR 00000020[EAX]

; 881:   a2->v.z+=z*ab2;

00008: 0435 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0438 DC 4D FFFFFFA0              FMUL QWORD PTR FFFFFFA0[EBP]
00007: 043B 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 043E DC 40 28                    FADD QWORD PTR 00000028[EAX]
00007: 0441 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00007: 0444 DD 58 28                    FSTP QWORD PTR 00000028[EAX]

; 882:   return ct; 

00008: 0447 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00000: 044A                     L0000:
00000: 044A                             epilog 
00000: 044A 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 044D 5E                          POP ESI
00000: 044E 5B                          POP EBX
00000: 044F 5D                          POP EBP
00000: 0450 C3                          RETN 

Function: _newloc

; 892: {  

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

; 899:   a1=a+i1;

00008: 0019 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 001C 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0022 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0025 89 55 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EDX

; 900:   moveatom(a1);

00008: 0028 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 002B E8 00000000                 CALL SHORT _moveatom
00008: 0030 59                          POP ECX

; 901:   aa=(double *)a1;

00008: 0031 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0034 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 902:   xy=j1-n1;

00008: 0037 8B 55 10                    MOV EDX, DWORD PTR 00000010[EBP]
00008: 003A 2B 15 00000000              SUB EDX, DWORD PTR _n1
00008: 0040 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 904:   aa+=xy;

00008: 0043 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 0046 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 004D 01 55 FFFFFFF0              ADD DWORD PTR FFFFFFF0[EBP], EDX

; 905:   b=(triad *)aa;

00008: 0050 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0053 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 906:   bound1=&bound[xy];

00008: 0056 8B 5D FFFFFFE0              MOV EBX, DWORD PTR FFFFFFE0[EBP]
00008: 0059 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 0060 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0063 81 C3 00000000              ADD EBX, OFFSET _bound
00008: 0069 89 5D FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EBX

; 909:   i=b->i.i;

00008: 006C 8B 4D FFFFFFEC              MOV ECX, DWORD PTR FFFFFFEC[EBP]
00008: 006F 8B 41 30                    MOV EAX, DWORD PTR 00000030[ECX]
00008: 0072 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 910:   if(b->v>0)

00008: 0075 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0078 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 007B DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0081 F1DF                        FCOMIP ST, ST(1), L0001
00007: 0083 DD D8                       FSTP ST
00008: 0085 7A 28                       JP L0001
00008: 0087 73 26                       JAE L0001

; 912:       i++;

00008: 0089 FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]

; 913:       if (i==bound1->period)

00008: 008C 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 008F 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0092 3B 41 10                    CMP EAX, DWORD PTR 00000010[ECX]
00008: 0095 75 3C                       JNE L0002

; 915: 	  i=0;

00008: 0097 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000

; 916: 	  b->r-=bound1->length;

00008: 009E 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00A1 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 00A3 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 00A6 DC 20                       FSUB QWORD PTR 00000000[EAX]
00007: 00A8 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00007: 00AB DD 18                       FSTP QWORD PTR 00000000[EAX]

; 918:     }

00008: 00AD EB 24                       JMP L0002
00008: 00AF                     L0001:

; 921:       i--;

00008: 00AF FF 4D FFFFFFE4              DEC DWORD PTR FFFFFFE4[EBP]

; 922:       if (i==-1)

00008: 00B2 83 7D FFFFFFE4 FFFFFFFF     CMP DWORD PTR FFFFFFE4[EBP], FFFFFFFF
00008: 00B6 75 1B                       JNE L0003

; 924: 	  i+=bound1->period;

00008: 00B8 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 00BB 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00BE 03 41 10                    ADD EAX, DWORD PTR 00000010[ECX]
00008: 00C1 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 925: 	  b->r+=bound1->length;

00008: 00C4 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00C7 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 00C9 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 00CC DC 00                       FADD QWORD PTR 00000000[EAX]
00007: 00CE 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00007: 00D1 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 926: 	}	

00008: 00D3                     L0003:

; 927:     }

00008: 00D3                     L0002:

; 928:   b->i.i=i;

00008: 00D3 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 00D6 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00D9 89 48 30                    MOV DWORD PTR 00000030[EAX], ECX

; 929:   address=a1->i.x.i+bound[0].period*(a1->i.y.i+bound[1].period*a1->i.z.i);

00008: 00DC 8B 15 00000028              MOV EDX, DWORD PTR _bound+00000028
00008: 00E2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00E5 0F AF 50 40                 IMUL EDX, DWORD PTR 00000040[EAX]
00008: 00E9 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00EC 03 50 38                    ADD EDX, DWORD PTR 00000038[EAX]
00008: 00EF 0F AF 15 00000010           IMUL EDX, DWORD PTR _bound+00000010
00008: 00F6 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00F9 03 50 30                    ADD EDX, DWORD PTR 00000030[EAX]
00008: 00FC 89 55 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EDX

; 930:   a1->add=address;

00008: 00FF 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 0102 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0105 89 88 000000A0              MOV DWORD PTR 000000A0[EAX], ECX

; 931:   find_atoms(i1);

00008: 010B FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 010E E8 00000000                 CALL SHORT _find_atoms
00008: 0113 59                          POP ECX

; 932:  }

00000: 0114                     L0000:
00000: 0114                             epilog 
00000: 0114 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0117 5B                          POP EBX
00000: 0118 5D                          POP EBP
00000: 0119 C3                          RETN 

Function: _twall

; 936: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 70                    SUB ESP, 00000070
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 B9 0000001C                 MOV ECX, 0000001C
00000: 0015 F3 AB                       REP STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 941:   pt=a+i;

00008: 0018 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 001B 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0021 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 0027 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 942:   q=n3;

00008: 002A A1 00000000                 MOV EAX, DWORD PTR _n3
00008: 002F 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX

; 943:   y=dblarg1;

00008: 0032 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0038 DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]

; 944:   x=dblarg1;

00008: 003B DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0041 DD 5D FFFFFF98              FSTP QWORD PTR FFFFFF98[EBP]

; 945:   z=dblarg1;

00008: 0044 DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 004A DD 5D FFFFFFA8              FSTP QWORD PTR FFFFFFA8[EBP]

; 947:   rx=pt->r.x;

00008: 004D 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0050 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0052 DD 5D FFFFFFB0              FSTP QWORD PTR FFFFFFB0[EBP]

; 948:   ry=pt->r.y;

00008: 0055 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0058 DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 005B DD 5D FFFFFFB8              FSTP QWORD PTR FFFFFFB8[EBP]

; 949:   rz=pt->r.z;

00008: 005E 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0061 DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 0064 DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]

; 951:   vx=pt->v.x;

00008: 0067 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 006A DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 006D DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]

; 952:   vy=pt->v.y;

00008: 0070 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0073 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 0076 DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]

; 953:   vz=pt->v.z;

00008: 0079 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 007C DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 007F DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 955:   wrx=pt->i.x.i*bound[0].dl;

00008: 0082 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0085 DB 40 30                    FILD DWORD PTR 00000030[EAX]
00007: 0088 DC 0D 00000008              FMUL QWORD PTR _bound+00000008
00007: 008E DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 956:   hry=pt->i.y.i*bound[1].dl;

00008: 0091 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0094 DB 40 38                    FILD DWORD PTR 00000038[EAX]
00007: 0097 DC 0D 00000020              FMUL QWORD PTR _bound+00000020
00007: 009D DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 957:   drz=pt->i.z.i*bound[2].dl;

00008: 00A0 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 00A3 DB 40 40                    FILD DWORD PTR 00000040[EAX]
00007: 00A6 DC 0D 00000038              FMUL QWORD PTR _bound+00000038
00007: 00AC DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 959:   rx-=wrx;

00008: 00AF DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00007: 00B2 DC 65 FFFFFFE8              FSUB QWORD PTR FFFFFFE8[EBP]
00007: 00B5 DD 5D FFFFFFB0              FSTP QWORD PTR FFFFFFB0[EBP]

; 960:   ry-=hry;

00008: 00B8 DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00007: 00BB DC 65 FFFFFFE0              FSUB QWORD PTR FFFFFFE0[EBP]
00007: 00BE DD 5D FFFFFFB8              FSTP QWORD PTR FFFFFFB8[EBP]

; 961:   rz-=drz;

00008: 00C1 DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 00C4 DC 65 FFFFFFF0              FSUB QWORD PTR FFFFFFF0[EBP]
00007: 00C7 DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]

; 963:   wrx=bound[0].dl-rx;

00008: 00CA DD 05 00000008              FLD QWORD PTR _bound+00000008
00007: 00D0 DC 65 FFFFFFB0              FSUB QWORD PTR FFFFFFB0[EBP]
00007: 00D3 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 964:   hry=bound[1].dl-ry;

00008: 00D6 DD 05 00000020              FLD QWORD PTR _bound+00000020
00007: 00DC DC 65 FFFFFFB8              FSUB QWORD PTR FFFFFFB8[EBP]
00007: 00DF DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 965:   drz=bound[2].dl-rz;

00008: 00E2 DD 05 00000038              FLD QWORD PTR _bound+00000038
00007: 00E8 DC 65 FFFFFFC0              FSUB QWORD PTR FFFFFFC0[EBP]
00007: 00EB DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 967:   if (vx<0) 

00008: 00EE DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 00F1 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 00F7 F1DF                        FCOMIP ST, ST(1), L0001
00007: 00F9 DD D8                       FSTP ST
00008: 00FB 7A 0D                       JP L0001
00008: 00FD 76 0B                       JBE L0001

; 968:     x=-rx/vx;

00008: 00FF DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00007: 0102 D9 E0                       FCHS 
00007: 0104 DC 75 FFFFFFC8              FDIV QWORD PTR FFFFFFC8[EBP]
00007: 0107 DD 5D FFFFFF98              FSTP QWORD PTR FFFFFF98[EBP]
00008: 010A                     L0001:

; 969:   if (vx>0)

00008: 010A DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 010D DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0113 F1DF                        FCOMIP ST, ST(1), L0002
00007: 0115 DD D8                       FSTP ST
00008: 0117 7A 0B                       JP L0002
00008: 0119 73 09                       JAE L0002

; 970:     x=wrx/vx;

00008: 011B DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 011E DC 75 FFFFFFC8              FDIV QWORD PTR FFFFFFC8[EBP]
00007: 0121 DD 5D FFFFFF98              FSTP QWORD PTR FFFFFF98[EBP]
00008: 0124                     L0002:

; 971:   if (vy<0)

00008: 0124 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0127 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 012D F1DF                        FCOMIP ST, ST(1), L0003
00007: 012F DD D8                       FSTP ST
00008: 0131 7A 0D                       JP L0003
00008: 0133 76 0B                       JBE L0003

; 972:     y=-ry/vy;

00008: 0135 DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00007: 0138 D9 E0                       FCHS 
00007: 013A DC 75 FFFFFFD0              FDIV QWORD PTR FFFFFFD0[EBP]
00007: 013D DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]
00008: 0140                     L0003:

; 973:   if (vy>0)

00008: 0140 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0143 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0149 F1DF                        FCOMIP ST, ST(1), L0004
00007: 014B DD D8                       FSTP ST
00008: 014D 7A 0B                       JP L0004
00008: 014F 73 09                       JAE L0004

; 974:     y=hry/vy;

00008: 0151 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 0154 DC 75 FFFFFFD0              FDIV QWORD PTR FFFFFFD0[EBP]
00007: 0157 DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]
00008: 015A                     L0004:

; 975:   if (vz<0)

00008: 015A DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 015D DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0163 F1DF                        FCOMIP ST, ST(1), L0005
00007: 0165 DD D8                       FSTP ST
00008: 0167 7A 0D                       JP L0005
00008: 0169 76 0B                       JBE L0005

; 976:     z=-rz/vz;

00008: 016B DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 016E D9 E0                       FCHS 
00007: 0170 DC 75 FFFFFFD8              FDIV QWORD PTR FFFFFFD8[EBP]
00007: 0173 DD 5D FFFFFFA8              FSTP QWORD PTR FFFFFFA8[EBP]
00008: 0176                     L0005:

; 977:   if (vz>0)

00008: 0176 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 0179 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 017F F1DF                        FCOMIP ST, ST(1), L0006
00007: 0181 DD D8                       FSTP ST
00008: 0183 7A 0B                       JP L0006
00008: 0185 73 09                       JAE L0006

; 978:     z=drz/vz;

00008: 0187 DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 018A DC 75 FFFFFFD8              FDIV QWORD PTR FFFFFFD8[EBP]
00007: 018D DD 5D FFFFFFA8              FSTP QWORD PTR FFFFFFA8[EBP]
00008: 0190                     L0006:

; 980:   t=z;

00008: 0190 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00007: 0193 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 982:   if ((x<z)||(y<z))

00008: 0196 DD 45 FFFFFF98              FLD QWORD PTR FFFFFF98[EBP]
00007: 0199 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00006: 019C F1DF                        FCOMIP ST, ST(1), L0007
00007: 019E DD D8                       FSTP ST
00008: 01A0 7A 02                       JP L000B
00008: 01A2 77 0E                       JA L0007
00008: 01A4                     L000B:
00008: 01A4 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 01A7 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00006: 01AA F1DF                        FCOMIP ST, ST(1), L0008
00007: 01AC DD D8                       FSTP ST
00008: 01AE 7A 2C                       JP L0008
00008: 01B0 76 2A                       JBE L0008
00008: 01B2                     L0007:

; 984:       t=y;

00008: 01B2 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 01B5 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 985:       q=n2;

00008: 01B8 A1 00000000                 MOV EAX, DWORD PTR _n2
00008: 01BD 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX

; 986:       if(x<y)

00008: 01C0 DD 45 FFFFFF98              FLD QWORD PTR FFFFFF98[EBP]
00007: 01C3 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00006: 01C6 F1DF                        FCOMIP ST, ST(1), L0009
00007: 01C8 DD D8                       FSTP ST
00008: 01CA 7A 10                       JP L0009
00008: 01CC 76 0E                       JBE L0009

; 988: 	  t=x;

00008: 01CE DD 45 FFFFFF98              FLD QWORD PTR FFFFFF98[EBP]
00007: 01D1 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 989: 	  q=n1;

00008: 01D4 A1 00000000                 MOV EAX, DWORD PTR _n1
00008: 01D9 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX

; 990: 	}

00008: 01DC                     L0009:

; 991:     }

00008: 01DC                     L0008:

; 992:   if(t<dblarg1)t+=pt->t;

00008: 01DC DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 01DF DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 01E5 F1DF                        FCOMIP ST, ST(1), L000A
00007: 01E7 DD D8                       FSTP ST
00008: 01E9 7A 0E                       JP L000A
00008: 01EB 76 0C                       JBE L000A
00008: 01ED DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 01F0 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00007: 01F3 DC 40 78                    FADD QWORD PTR 00000078[EAX]
00007: 01F6 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]
00008: 01F9                     L000A:

; 993:   pt->w=t;

00008: 01F9 DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 01FC 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00007: 01FF DD 98 00000080              FSTP QWORD PTR 00000080[EAX]

; 995:   *t1=t;

00008: 0205 DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 0208 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00007: 020B DD 18                       FSTP QWORD PTR 00000000[EAX]

; 996:   return q;

00008: 020D 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00000: 0210                     L0000:
00000: 0210                             epilog 
00000: 0210 C9                          LEAVE 
00000: 0211 C3                          RETN 

Function: _tball

; 1001: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 78                    SUB ESP, 00000078
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 B9 0000001E                 MOV ECX, 0000001E
00000: 0017 F3 AB                       REP STOSD 
00000: 0019 5F                          POP EDI
00000: 001A                             prolog 

; 1005:   double t=dblarg1;

00008: 001A DD 05 00000000              FLD QWORD PTR _dblarg1
00007: 0020 DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]

; 1006:   long q=0;

00008: 0023 C7 45 FFFFFF9C 00000000     MOV DWORD PTR FFFFFF9C[EBP], 00000000

; 1008:   a1=a+i;

00008: 002A 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 002D 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0033 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 0039 89 55 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EDX

; 1009:   a2=a+j;

00008: 003C 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 003F 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0045 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 004B 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX

; 1011:   k=ct;

00008: 004E 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0051 89 45 FFFFFF84              MOV DWORD PTR FFFFFF84[EBP], EAX

; 1012:   moveatom(a1);

00008: 0054 FF 75 FFFFFF94              PUSH DWORD PTR FFFFFF94[EBP]
00008: 0057 E8 00000000                 CALL SHORT _moveatom
00008: 005C 59                          POP ECX

; 1013:   moveatom(a2);

00008: 005D FF 75 FFFFFF98              PUSH DWORD PTR FFFFFF98[EBP]
00008: 0060 E8 00000000                 CALL SHORT _moveatom
00008: 0065 59                          POP ECX

; 1015:   u=a2->v.x-a1->v.x;

00008: 0066 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 0069 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 006C 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 006F DC 60 18                    FSUB QWORD PTR 00000018[EAX]
00007: 0072 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 1016:   v=a2->v.y-a1->v.y;

00008: 0075 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 0078 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 007B 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 007E DC 60 20                    FSUB QWORD PTR 00000020[EAX]
00007: 0081 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 1017:   w=a2->v.z-a1->v.z;

00008: 0084 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 0087 DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 008A 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 008D DC 60 28                    FSUB QWORD PTR 00000028[EAX]
00007: 0090 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 1018:   ab=u*u+v*v+w*w;

00008: 0093 DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 0096 D8 C8                       FMUL ST, ST
00007: 0098 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00006: 009B D8 C8                       FMUL ST, ST
00006: 009D DE C1                       FADDP ST(1), ST
00007: 009F DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00006: 00A2 D8 C8                       FMUL ST, ST
00006: 00A4 DE C1                       FADDP ST(1), ST
00007: 00A6 DD 5D FFFFFFA8              FSTP QWORD PTR FFFFFFA8[EBP]

; 1019:   if (ab)

00008: 00A9 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00007: 00AC DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 00B2 F1DF                        FCOMIP ST, ST(1), L0001
00007: 00B4 DD D8                       FSTP ST
00008: 00B6 7A 06                       JP L000E
00008: 00B8 0F 84 000001B2              JE L0001
00008: 00BE                     L000E:

; 1021:       x=a2->r.x-a1->r.x;

00008: 00BE 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 00C1 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 00C3 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 00C6 DC 20                       FSUB QWORD PTR 00000000[EAX]
00007: 00C8 DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]

; 1022:       y=a2->r.y-a1->r.y;

00008: 00CB 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 00CE DD 40 08                    FLD QWORD PTR 00000008[EAX]
00007: 00D1 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 00D4 DC 60 08                    FSUB QWORD PTR 00000008[EAX]
00007: 00D7 DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]

; 1023:       z=a2->r.z-a1->r.z;

00008: 00DA 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 00DD DD 40 10                    FLD QWORD PTR 00000010[EAX]
00007: 00E0 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 00E3 DC 60 10                    FSUB QWORD PTR 00000010[EAX]
00007: 00E6 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 1024:       ix=a2->i.x.i-a1->i.x.i;

00008: 00E9 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 00EC 8B 50 30                    MOV EDX, DWORD PTR 00000030[EAX]
00008: 00EF 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 00F2 2B 50 30                    SUB EDX, DWORD PTR 00000030[EAX]
00008: 00F5 89 55 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EDX

; 1025:       iy=a2->i.y.i-a1->i.y.i;

00008: 00F8 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 00FB 8B 50 38                    MOV EDX, DWORD PTR 00000038[EAX]
00008: 00FE 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 0101 2B 50 38                    SUB EDX, DWORD PTR 00000038[EAX]
00008: 0104 89 55 FFFFFF8C              MOV DWORD PTR FFFFFF8C[EBP], EDX

; 1026:       iz=a2->i.z.i-a1->i.z.i;

00008: 0107 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 010A 8B 50 40                    MOV EDX, DWORD PTR 00000040[EAX]
00008: 010D 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 0110 2B 50 40                    SUB EDX, DWORD PTR 00000040[EAX]
00008: 0113 89 55 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EDX

; 1027:       if (ix>1)x-=bound[0].length;

00008: 0116 83 7D FFFFFF88 01           CMP DWORD PTR FFFFFF88[EBP], 00000001
00008: 011A 7E 0C                       JLE L0002
00008: 011C DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 011F DC 25 00000000              FSUB QWORD PTR _bound
00007: 0125 DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]
00008: 0128                     L0002:

; 1028:       if (ix<-1)x+=bound[0].length;

00008: 0128 83 7D FFFFFF88 FFFFFFFF     CMP DWORD PTR FFFFFF88[EBP], FFFFFFFF
00008: 012C 7D 0C                       JGE L0003
00008: 012E DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00007: 0131 DC 05 00000000              FADD QWORD PTR _bound
00007: 0137 DD 5D FFFFFFC8              FSTP QWORD PTR FFFFFFC8[EBP]
00008: 013A                     L0003:

; 1029:       if (iy>1)y-=bound[1].length;

00008: 013A 83 7D FFFFFF8C 01           CMP DWORD PTR FFFFFF8C[EBP], 00000001
00008: 013E 7E 0C                       JLE L0004
00008: 0140 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0143 DC 25 00000018              FSUB QWORD PTR _bound+00000018
00007: 0149 DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]
00008: 014C                     L0004:

; 1030:       if (iy<-1)y+=bound[1].length;

00008: 014C 83 7D FFFFFF8C FFFFFFFF     CMP DWORD PTR FFFFFF8C[EBP], FFFFFFFF
00008: 0150 7D 0C                       JGE L0005
00008: 0152 DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 0155 DC 05 00000018              FADD QWORD PTR _bound+00000018
00007: 015B DD 5D FFFFFFD0              FSTP QWORD PTR FFFFFFD0[EBP]
00008: 015E                     L0005:

; 1031:       if (iz>1)z-=bound[2].length;

00008: 015E 83 7D FFFFFF90 01           CMP DWORD PTR FFFFFF90[EBP], 00000001
00008: 0162 7E 0C                       JLE L0006
00008: 0164 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 0167 DC 25 00000030              FSUB QWORD PTR _bound+00000030
00007: 016D DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]
00008: 0170                     L0006:

; 1032:       if (iz<-1)z+=bound[2].length;

00008: 0170 83 7D FFFFFF90 FFFFFFFF     CMP DWORD PTR FFFFFF90[EBP], FFFFFFFF
00008: 0174 7D 0C                       JGE L0007
00008: 0176 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 0179 DC 05 00000030              FADD QWORD PTR _bound+00000030
00007: 017F DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]
00008: 0182                     L0007:

; 1034:       sc=u*x+v*y+w*z;

00008: 0182 DD 45 FFFFFFE8              FLD QWORD PTR FFFFFFE8[EBP]
00007: 0185 DC 4D FFFFFFD0              FMUL QWORD PTR FFFFFFD0[EBP]
00007: 0188 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00006: 018B DC 4D FFFFFFC8              FMUL QWORD PTR FFFFFFC8[EBP]
00006: 018E DE C1                       FADDP ST(1), ST
00007: 0190 DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00006: 0193 DC 4D FFFFFFD8              FMUL QWORD PTR FFFFFFD8[EBP]
00006: 0196 DE C1                       FADDP ST(1), ST
00007: 0198 DD 5D FFFFFFB0              FSTP QWORD PTR FFFFFFB0[EBP]

; 1035:       de=(x*x+y*y+z*z)*ab-sc*sc;

00008: 019B DD 45 FFFFFFD0              FLD QWORD PTR FFFFFFD0[EBP]
00007: 019E D8 C8                       FMUL ST, ST
00007: 01A0 DD 45 FFFFFFC8              FLD QWORD PTR FFFFFFC8[EBP]
00006: 01A3 D8 C8                       FMUL ST, ST
00006: 01A5 DE C1                       FADDP ST(1), ST
00007: 01A7 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00006: 01AA D8 C8                       FMUL ST, ST
00006: 01AC DE C1                       FADDP ST(1), ST
00007: 01AE DC 4D FFFFFFA8              FMUL QWORD PTR FFFFFFA8[EBP]
00007: 01B1 DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00006: 01B4 D8 C8                       FMUL ST, ST
00006: 01B6 DE E9                       FSUBP ST(1), ST
00007: 01B8 DD 5D FFFFFFC0              FSTP QWORD PTR FFFFFFC0[EBP]

; 1037:       if (sc<0.0)

00008: 01BB DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00007: 01BE DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 01C4 F1DF                        FCOMIP ST, ST(1), L0008
00007: 01C6 DD D8                       FSTP ST
00008: 01C8 7A 46                       JP L0008
00008: 01CA 76 44                       JBE L0008

; 1039: 	  di=ab*coll[k].dd-de;

00008: 01CC 8B 5D FFFFFF84              MOV EBX, DWORD PTR FFFFFF84[EBP]
00008: 01CF 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 01D2 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 01D8 DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00007: 01DB DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 01DF DC 65 FFFFFFC0              FSUB QWORD PTR FFFFFFC0[EBP]
00007: 01E2 DD 5D FFFFFFB8              FSTP QWORD PTR FFFFFFB8[EBP]

; 1040: 	  if (di>0.0)

00008: 01E5 DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00007: 01E8 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 01EE F1DF                        FCOMIP ST, ST(1), L0009
00007: 01F0 DD D8                       FSTP ST
00008: 01F2 7A 1C                       JP L0009
00008: 01F4 73 1A                       JAE L0009

; 1041: 	    t=(-sc-sqrt(di))/ab;

00008: 01F6 FF 75 FFFFFFBC              PUSH DWORD PTR FFFFFFBC[EBP]
00008: 01F9 FF 75 FFFFFFB8              PUSH DWORD PTR FFFFFFB8[EBP]
00008: 01FC E8 00000000                 CALL SHORT _sqrt
00007: 0201 59                          POP ECX
00007: 0202 59                          POP ECX
00007: 0203 DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00006: 0206 D9 E0                       FCHS 
00006: 0208 DE E1                       FSUBRP ST(1), ST
00007: 020A DC 75 FFFFFFA8              FDIV QWORD PTR FFFFFFA8[EBP]
00007: 020D DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]
00008: 0210                     L0009:

; 1042: 	}

00008: 0210                     L0008:

; 1043:       if((t==dblarg1)&&(coll[k].prev>-1))

00008: 0210 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 0213 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 0219 F1DF                        FCOMIP ST, ST(1), L000A
00007: 021B DD D8                       FSTP ST
00008: 021D 7A 51                       JP L000A
00008: 021F 75 4F                       JNE L000A
00008: 0221 8B 5D FFFFFF84              MOV EBX, DWORD PTR FFFFFF84[EBP]
00008: 0224 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0227 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 022D 83 7C DA 3C FFFFFFFF        CMP DWORD PTR 0000003C[EDX][EBX*8], FFFFFFFF
00008: 0232 7E 3C                       JLE L000A

; 1045: 	  t=(-sc+sqrt(ab*coll[coll[k].prev].dd-de))/ab;

00008: 0234 8B 5D FFFFFF84              MOV EBX, DWORD PTR FFFFFF84[EBP]
00008: 0237 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 023A 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0240 8B 5C DE 3C                 MOV EBX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0244 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0247 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 024D DD 45 FFFFFFA8              FLD QWORD PTR FFFFFFA8[EBP]
00007: 0250 DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 0254 DC 65 FFFFFFC0              FSUB QWORD PTR FFFFFFC0[EBP]
00007: 0257 50                          PUSH EAX
00007: 0258 50                          PUSH EAX
00007: 0259 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 025C E8 00000000                 CALL SHORT _sqrt
00007: 0261 59                          POP ECX
00007: 0262 59                          POP ECX
00007: 0263 DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00006: 0266 D9 E0                       FCHS 
00006: 0268 DE C1                       FADDP ST(1), ST
00007: 026A DC 75 FFFFFFA8              FDIV QWORD PTR FFFFFFA8[EBP]
00007: 026D DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]

; 1046: 	}   

00008: 0270                     L000A:

; 1048:     } 

00008: 0270                     L0001:

; 1049:     if (t<dblarg1)t+=a1->t;

00008: 0270 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 0273 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 0279 F1DF                        FCOMIP ST, ST(1), L000B
00007: 027B DD D8                       FSTP ST
00008: 027D 7A 0E                       JP L000B
00008: 027F 76 0C                       JBE L000B
00008: 0281 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 0284 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 0287 DC 40 78                    FADD QWORD PTR 00000078[EAX]
00007: 028A DD 5D FFFFFFA0              FSTP QWORD PTR FFFFFFA0[EBP]
00008: 028D                     L000B:

; 1050:     if((coll[k].prev>-1)||((t<=a1->w)&&(t<=a2->w)))	  q=1;

00008: 028D 8B 5D FFFFFF84              MOV EBX, DWORD PTR FFFFFF84[EBP]
00008: 0290 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0293 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0299 83 7C DA 3C FFFFFFFF        CMP DWORD PTR 0000003C[EDX][EBX*8], FFFFFFFF
00008: 029E 7F 28                       JG L000C
00008: 02A0 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 02A3 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00007: 02A6 DD 80 00000080              FLD QWORD PTR 00000080[EAX]
00006: 02AC F1DF                        FCOMIP ST, ST(1), L000D
00007: 02AE DD D8                       FSTP ST
00008: 02B0 7A 1D                       JP L000D
00008: 02B2 72 1B                       JB L000D
00008: 02B4 DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 02B7 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00007: 02BA DD 80 00000080              FLD QWORD PTR 00000080[EAX]
00006: 02C0 F1DF                        FCOMIP ST, ST(1), L000D
00007: 02C2 DD D8                       FSTP ST
00008: 02C4 7A 09                       JP L000D
00008: 02C6 72 07                       JB L000D
00008: 02C8                     L000C:
00008: 02C8 C7 45 FFFFFF9C 00000001     MOV DWORD PTR FFFFFF9C[EBP], 00000001
00008: 02CF                     L000D:

; 1052:   *t1=t;

00008: 02CF DD 45 FFFFFFA0              FLD QWORD PTR FFFFFFA0[EBP]
00007: 02D2 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00007: 02D5 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 1056:   return q;

00008: 02D7 8B 45 FFFFFF9C              MOV EAX, DWORD PTR FFFFFF9C[EBP]
00000: 02DA                     L0000:
00000: 02DA                             epilog 
00000: 02DA 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 02DD 5E                          POP ESI
00000: 02DE 5B                          POP EBX
00000: 02DF 5D                          POP EBP
00000: 02E0 C3                          RETN 

Function: _collision_type

; 1061: {  

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

; 1062:   short ic=a[i].c;

00008: 0018 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 001B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0022 29 D3                       SUB EBX, EDX
00008: 0024 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0027 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 002D 66 8B 84 DE 000000A4        MOV AX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0035 66 89 45 FFFFFFA0           MOV WORD PTR FFFFFFA0[EBP], AX

; 1065:   int link_err=isFriend(k,i);

00008: 0039 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 003C FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 003F E8 00000000                 CALL SHORT _isFriend
00008: 0044 59                          POP ECX
00008: 0045 59                          POP ECX
00008: 0046 89 45 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], EAX

; 1066:   int kc=a[k].c;

00008: 0049 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 004C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0053 29 D3                       SUB EBX, EDX
00008: 0055 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0058 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 005E 0F BF 94 DE 000000A4        MOVSX EDX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0066 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 1067:   int ie=ecoll[ic][kc];

00008: 0069 0F BF 75 FFFFFFA0           MOVSX ESI, WORD PTR FFFFFFA0[EBP]
00008: 006D 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0073 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0076 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0079 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 007C 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 1068:   int ix=a[i].i.x.i;

00008: 007F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0082 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0089 29 D3                       SUB EBX, EDX
00008: 008B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 008E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0094 8B 44 DE 30                 MOV EAX, DWORD PTR 00000030[ESI][EBX*8]
00008: 0098 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX

; 1069:   int iy=a[i].i.y.i;

00008: 009B 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 009E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00A5 29 D3                       SUB EBX, EDX
00008: 00A7 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00AA 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00B0 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 00B4 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX

; 1070:   int iz=a[i].i.z.i;

00008: 00B7 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00BA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00C1 29 D3                       SUB EBX, EDX
00008: 00C3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00C6 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00CC 8B 44 DE 40                 MOV EAX, DWORD PTR 00000040[ESI][EBX*8]
00008: 00D0 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 1071:   int kx=ix-a[k].i.x.i;

00008: 00D3 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 00D6 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00DD 29 D3                       SUB EBX, EDX
00008: 00DF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00E2 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 00E8 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 00EB 2B 74 DF 30                 SUB ESI, DWORD PTR 00000030[EDI][EBX*8]
00008: 00EF 89 75 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], ESI

; 1072:   int ct=ie;

00008: 00F2 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 00F5 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1073:   ia=abs(kx);

00008: 00F8 FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 00FB E8 00000000                 CALL SHORT _abs
00008: 0100 59                          POP ECX
00008: 0101 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 1074:   if((ia>1)&&(ia!=px))goto far_away;

00008: 0104 83 7D FFFFFFA4 01           CMP DWORD PTR FFFFFFA4[EBP], 00000001
00008: 0108 7E 0F                       JLE L0001
00008: 010A 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 010D 3B 05 00000000              CMP EAX, DWORD PTR _px
00008: 0113 0F 85 0000029C              JNE L0002
00008: 0119                     L0001:

; 1075:   ky=iy-a[k].i.y.i;

00008: 0119 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 011C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0123 29 D3                       SUB EBX, EDX
00008: 0125 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0128 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 012E 8B 75 FFFFFFC0              MOV ESI, DWORD PTR FFFFFFC0[EBP]
00008: 0131 2B 74 DF 38                 SUB ESI, DWORD PTR 00000038[EDI][EBX*8]
00008: 0135 89 75 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], ESI

; 1076:   ia=abs(ky);

00008: 0138 FF 75 FFFFFFA8              PUSH DWORD PTR FFFFFFA8[EBP]
00008: 013B E8 00000000                 CALL SHORT _abs
00008: 0140 59                          POP ECX
00008: 0141 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 1077:   if((ia>1)&&(ia!=py))goto far_away;

00008: 0144 83 7D FFFFFFA4 01           CMP DWORD PTR FFFFFFA4[EBP], 00000001
00008: 0148 7E 0F                       JLE L0003
00008: 014A 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 014D 3B 05 00000000              CMP EAX, DWORD PTR _py
00008: 0153 0F 85 0000025C              JNE L0002
00008: 0159                     L0003:

; 1078:   kz=iz-a[k].i.z.i;

00008: 0159 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 015C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0163 29 D3                       SUB EBX, EDX
00008: 0165 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0168 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 016E 8B 75 FFFFFFC4              MOV ESI, DWORD PTR FFFFFFC4[EBP]
00008: 0171 2B 74 DF 40                 SUB ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 0175 89 75 FFFFFFAC              MOV DWORD PTR FFFFFFAC[EBP], ESI

; 1079:   ia=abs(kz);

00008: 0178 FF 75 FFFFFFAC              PUSH DWORD PTR FFFFFFAC[EBP]
00008: 017B E8 00000000                 CALL SHORT _abs
00008: 0180 59                          POP ECX
00008: 0181 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 1080:   if((ia>1)&&(ia!=pz))goto far_away;

00008: 0184 83 7D FFFFFFA4 01           CMP DWORD PTR FFFFFFA4[EBP], 00000001
00008: 0188 7E 0F                       JLE L0004
00008: 018A 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 018D 3B 05 00000000              CMP EAX, DWORD PTR _pz
00008: 0193 0F 85 0000021C              JNE L0002
00008: 0199                     L0004:

; 1081:   rx=a[i].r.x-a[k].r.x;

00008: 0199 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 019C 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 01A3 29 D6                       SUB ESI, EDX
00008: 01A5 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 01A8 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 01AE 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 01B1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01B8 29 D3                       SUB EBX, EDX
00008: 01BA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01BD 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01C3 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 01C6 DC 24 F7                    FSUB QWORD PTR 00000000[EDI][ESI*8]
00007: 01C9 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 1082:   ry=a[i].r.y-a[k].r.y;

00008: 01CC 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 01CF 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 01D6 29 D6                       SUB ESI, EDX
00008: 01D8 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 01DB 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 01E1 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 01E4 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01EB 29 D3                       SUB EBX, EDX
00008: 01ED 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01F0 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01F6 DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 01FA DC 64 F7 08                 FSUB QWORD PTR 00000008[EDI][ESI*8]
00007: 01FE DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 1083:   rz=a[i].r.z-a[k].r.z;

00008: 0201 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0204 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 020B 29 D6                       SUB ESI, EDX
00008: 020D 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0210 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0216 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0219 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0220 29 D3                       SUB EBX, EDX
00008: 0222 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0225 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 022B DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 022F DC 64 F7 10                 FSUB QWORD PTR 00000010[EDI][ESI*8]
00007: 0233 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 1084:   if(kx<-1)rx+=lx;

00008: 0236 83 7D FFFFFFC8 FFFFFFFF     CMP DWORD PTR FFFFFFC8[EBP], FFFFFFFF
00008: 023A 7D 0C                       JGE L0005
00008: 023C DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 023F DC 05 00000000              FADD QWORD PTR _lx
00007: 0245 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 0248                     L0005:

; 1085:   if(kx>1)rx-=lx;

00008: 0248 83 7D FFFFFFC8 01           CMP DWORD PTR FFFFFFC8[EBP], 00000001
00008: 024C 7E 0C                       JLE L0006
00008: 024E DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0251 DC 25 00000000              FSUB QWORD PTR _lx
00007: 0257 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 025A                     L0006:

; 1086:   if(ky<-1)ry+=ly;

00008: 025A 83 7D FFFFFFA8 FFFFFFFF     CMP DWORD PTR FFFFFFA8[EBP], FFFFFFFF
00008: 025E 7D 0C                       JGE L0007
00008: 0260 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 0263 DC 05 00000000              FADD QWORD PTR _ly
00007: 0269 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 026C                     L0007:

; 1087:   if(ky>1)ry-=ly;

00008: 026C 83 7D FFFFFFA8 01           CMP DWORD PTR FFFFFFA8[EBP], 00000001
00008: 0270 7E 0C                       JLE L0008
00008: 0272 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 0275 DC 25 00000000              FSUB QWORD PTR _ly
00007: 027B DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 027E                     L0008:

; 1088:   if(kz<-1)rz+=lz;

00008: 027E 83 7D FFFFFFAC FFFFFFFF     CMP DWORD PTR FFFFFFAC[EBP], FFFFFFFF
00008: 0282 7D 0C                       JGE L0009
00008: 0284 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 0287 DC 05 00000000              FADD QWORD PTR _lz
00007: 028D DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 0290                     L0009:

; 1089:   if(kz>1)rz-=lz;

00008: 0290 83 7D FFFFFFAC 01           CMP DWORD PTR FFFFFFAC[EBP], 00000001
00008: 0294 7E 0C                       JLE L000A
00008: 0296 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 0299 DC 25 00000000              FSUB QWORD PTR _lz
00007: 029F DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 02A2                     L000A:

; 1090:   dr=rx*rx+ry*ry+rz*rz;

00008: 02A2 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 02A5 D8 C8                       FMUL ST, ST
00007: 02A7 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00006: 02AA D8 C8                       FMUL ST, ST
00006: 02AC DE C1                       FADDP ST(1), ST
00007: 02AE DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00006: 02B1 D8 C8                       FMUL ST, ST
00006: 02B3 DE C1                       FADDP ST(1), ST
00007: 02B5 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 1091:   if(link_err)

00008: 02B8 83 7D FFFFFFB0 00           CMP DWORD PTR FFFFFFB0[EBP], 00000000
00008: 02BC 0F 84 000000D3              JE L000B

; 1093:       int ii=icoll[ic][kc];

00008: 02C2 0F BF 75 FFFFFFA0           MOVSX ESI, WORD PTR FFFFFFA0[EBP]
00008: 02C6 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 02CC 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 02CF 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 02D2 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 02D5 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 1094:       if(ii>-1)

00008: 02D8 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 02DC 0F 8E 000000B3              JLE L000B

; 1096: 	  if(dr<coll[ii].dd)

00008: 02E2 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 02E5 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 02E8 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 02EE DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 02F1 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 02F5 F1DF                        FCOMIP ST, ST(1), L000B
00007: 02F7 DD D8                       FSTP ST
00008: 02F9 0F 8A 00000096              JP L000B
00008: 02FF 0F 86 00000090              JBE L000B

; 1098: 	      for(ii=coll[ii].next;ii>-1;ii=coll[ii].next)

00008: 0305 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0308 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 030B 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0311 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0315 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX
00008: 0318 EB 3D                       JMP L000C
00008: 031A                     L000D:

; 1100: 		  if(dr>coll[ii].dd)

00008: 031A 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 031D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0320 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0326 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 0329 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 032D F1DF                        FCOMIP ST, ST(1), L000E
00007: 032F DD D8                       FSTP ST
00008: 0331 7A 11                       JP L000E
00008: 0333 73 0F                       JAE L000E

; 1102: 		      link_err=0;

00008: 0335 C7 45 FFFFFFB0 00000000     MOV DWORD PTR FFFFFFB0[EBP], 00000000

; 1103: 		      ct=ii;

00008: 033C 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 033F 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1104: 		      goto far_away;

00008: 0342 EB 71                       JMP L0002
00008: 0344                     L000E:

; 1106: 		}

00008: 0344 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0347 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 034A 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0350 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0354 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX
00008: 0357                     L000C:
00008: 0357 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 035B 7F FFFFFFBD                 JG L000D

; 1111:   while(ie>-1)

00008: 035D EB 36                       JMP L000B
00008: 035F                     L000F:

; 1113:       if(dr>=coll[ie].dd)

00008: 035F 8B 5D FFFFFFB8              MOV EBX, DWORD PTR FFFFFFB8[EBP]
00008: 0362 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0365 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 036B DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 036E DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 0372 F1DF                        FCOMIP ST, ST(1), L0010
00007: 0374 DD D8                       FSTP ST
00008: 0376 7A 0A                       JP L0010
00008: 0378 77 08                       JA L0010

; 1115: 	  ct=ie;

00008: 037A 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 037D 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1116:           goto far_away;

00008: 0380 EB 33                       JMP L0002
00008: 0382                     L0010:

; 1118:       ie=coll[ie].next;

00008: 0382 8B 5D FFFFFFB8              MOV EBX, DWORD PTR FFFFFFB8[EBP]
00008: 0385 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0388 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 038E 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0392 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 1119:     }

00008: 0395                     L000B:
00008: 0395 83 7D FFFFFFB8 FFFFFFFF     CMP DWORD PTR FFFFFFB8[EBP], FFFFFFFF
00008: 0399 7F FFFFFFC4                 JG L000F

; 1120:   too_close_dialog(k,i);

00008: 039B FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 039E FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 03A1 E8 00000000                 CALL SHORT _too_close_dialog
00008: 03A6 59                          POP ECX
00008: 03A7 59                          POP ECX

; 1121:   return -3;

00008: 03A8 B8 FFFFFFFD                 MOV EAX, FFFFFFFD
00000: 03AD                             epilog 
00000: 03AD 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03B0 5F                          POP EDI
00000: 03B1 5E                          POP ESI
00000: 03B2 5B                          POP EBX
00000: 03B3 5D                          POP EBP
00000: 03B4 C3                          RETN 
00008: 03B5                     L0002:

; 1123:   if(link_err)breakBond(i,k);

00008: 03B5 83 7D FFFFFFB0 00           CMP DWORD PTR FFFFFFB0[EBP], 00000000
00008: 03B9 74 0D                       JE L0011
00008: 03BB FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 03BE FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 03C1 E8 00000000                 CALL SHORT _breakBond
00008: 03C6 59                          POP ECX
00008: 03C7 59                          POP ECX
00008: 03C8                     L0011:

; 1124:   return ct;

00008: 03C8 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 03CB                     L0000:
00000: 03CB                             epilog 
00000: 03CB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03CE 5F                          POP EDI
00000: 03CF 5E                          POP ESI
00000: 03D0 5B                          POP EBX
00000: 03D1 5D                          POP EBP
00000: 03D2 C3                          RETN 

Function: _after_type

; 1128: {  

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

; 1129:   short ic=a[i].c;

00008: 0018 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 001B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0022 29 D3                       SUB EBX, EDX
00008: 0024 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0027 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 002D 66 8B 84 DE 000000A4        MOV AX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0035 66 89 45 FFFFFFA0           MOV WORD PTR FFFFFFA0[EBP], AX

; 1130:   int prev=coll[old_ct].prev;

00008: 0039 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 003C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 003F 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0045 8B 44 DE 3C                 MOV EAX, DWORD PTR 0000003C[ESI][EBX*8]
00008: 0049 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 1133:   int kc=a[k].c;

00008: 004C 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 004F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0056 29 D3                       SUB EBX, EDX
00008: 0058 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 005B 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0061 0F BF 94 DE 000000A4        MOVSX EDX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0069 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 1134:   int ie=ecoll[ic][kc];

00008: 006C 0F BF 75 FFFFFFA0           MOVSX ESI, WORD PTR FFFFFFA0[EBP]
00008: 0070 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0076 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0079 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 007C 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 007F 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 1135:   int ix=a[i].i.x.i;

00008: 0082 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0085 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 008C 29 D3                       SUB EBX, EDX
00008: 008E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0091 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0097 8B 44 DE 30                 MOV EAX, DWORD PTR 00000030[ESI][EBX*8]
00008: 009B 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX

; 1136:   int iy=a[i].i.y.i;

00008: 009E 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00A1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00A8 29 D3                       SUB EBX, EDX
00008: 00AA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00AD 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00B3 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 00B7 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX

; 1137:   int iz=a[i].i.z.i;

00008: 00BA 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00BD 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00C4 29 D3                       SUB EBX, EDX
00008: 00C6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00C9 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00CF 8B 44 DE 40                 MOV EAX, DWORD PTR 00000040[ESI][EBX*8]
00008: 00D3 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 1138:   int kx=ix-a[k].i.x.i;

00008: 00D6 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 00D9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00E0 29 D3                       SUB EBX, EDX
00008: 00E2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00E5 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 00EB 8B 75 FFFFFFBC              MOV ESI, DWORD PTR FFFFFFBC[EBP]
00008: 00EE 2B 74 DF 30                 SUB ESI, DWORD PTR 00000030[EDI][EBX*8]
00008: 00F2 89 75 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], ESI

; 1139:   int ct=ie;

00008: 00F5 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 00F8 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1140:   ia=abs(kx);

00008: 00FB FF 75 FFFFFFC8              PUSH DWORD PTR FFFFFFC8[EBP]
00008: 00FE E8 00000000                 CALL SHORT _abs
00008: 0103 59                          POP ECX
00008: 0104 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 1141:   if((ia>1)&&(ia!=px))return ct;

00008: 0107 83 7D FFFFFFA8 01           CMP DWORD PTR FFFFFFA8[EBP], 00000001
00008: 010B 7E 16                       JLE L0001
00008: 010D 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 0110 3B 05 00000000              CMP EAX, DWORD PTR _px
00008: 0116 74 0B                       JE L0001
00008: 0118 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 011B                             epilog 
00000: 011B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 011E 5F                          POP EDI
00000: 011F 5E                          POP ESI
00000: 0120 5B                          POP EBX
00000: 0121 5D                          POP EBP
00000: 0122 C3                          RETN 
00008: 0123                     L0001:

; 1142:   ky=iy-a[k].i.y.i;

00008: 0123 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0126 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 012D 29 D3                       SUB EBX, EDX
00008: 012F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0132 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0138 8B 75 FFFFFFC0              MOV ESI, DWORD PTR FFFFFFC0[EBP]
00008: 013B 2B 74 DF 38                 SUB ESI, DWORD PTR 00000038[EDI][EBX*8]
00008: 013F 89 75 FFFFFFAC              MOV DWORD PTR FFFFFFAC[EBP], ESI

; 1143:   ia=abs(ky);

00008: 0142 FF 75 FFFFFFAC              PUSH DWORD PTR FFFFFFAC[EBP]
00008: 0145 E8 00000000                 CALL SHORT _abs
00008: 014A 59                          POP ECX
00008: 014B 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 1144:   if((ia>1)&&(ia!=py))return ct;

00008: 014E 83 7D FFFFFFA8 01           CMP DWORD PTR FFFFFFA8[EBP], 00000001
00008: 0152 7E 16                       JLE L0002
00008: 0154 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 0157 3B 05 00000000              CMP EAX, DWORD PTR _py
00008: 015D 74 0B                       JE L0002
00008: 015F 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 0162                             epilog 
00000: 0162 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0165 5F                          POP EDI
00000: 0166 5E                          POP ESI
00000: 0167 5B                          POP EBX
00000: 0168 5D                          POP EBP
00000: 0169 C3                          RETN 
00008: 016A                     L0002:

; 1145:   kz=iz-a[k].i.z.i;

00008: 016A 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 016D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0174 29 D3                       SUB EBX, EDX
00008: 0176 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0179 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 017F 8B 75 FFFFFFC4              MOV ESI, DWORD PTR FFFFFFC4[EBP]
00008: 0182 2B 74 DF 40                 SUB ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 0186 89 75 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], ESI

; 1146:   ia=abs(kz);

00008: 0189 FF 75 FFFFFFB0              PUSH DWORD PTR FFFFFFB0[EBP]
00008: 018C E8 00000000                 CALL SHORT _abs
00008: 0191 59                          POP ECX
00008: 0192 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 1147:   if((ia>1)&&(ia!=pz))return ct;

00008: 0195 83 7D FFFFFFA8 01           CMP DWORD PTR FFFFFFA8[EBP], 00000001
00008: 0199 7E 16                       JLE L0003
00008: 019B 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 019E 3B 05 00000000              CMP EAX, DWORD PTR _pz
00008: 01A4 74 0B                       JE L0003
00008: 01A6 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 01A9                             epilog 
00000: 01A9 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01AC 5F                          POP EDI
00000: 01AD 5E                          POP ESI
00000: 01AE 5B                          POP EBX
00000: 01AF 5D                          POP EBP
00000: 01B0 C3                          RETN 
00008: 01B1                     L0003:

; 1148:   rx=a[i].r.x-a[k].r.x;

00008: 01B1 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 01B4 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 01BB 29 D6                       SUB ESI, EDX
00008: 01BD 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 01C0 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 01C6 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 01C9 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01D0 29 D3                       SUB EBX, EDX
00008: 01D2 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01D5 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 01DB DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 01DE DC 24 F7                    FSUB QWORD PTR 00000000[EDI][ESI*8]
00007: 01E1 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 1149:   ry=a[i].r.y-a[k].r.y;

00008: 01E4 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 01E7 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 01EE 29 D6                       SUB ESI, EDX
00008: 01F0 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 01F3 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 01F9 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 01FC 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0203 29 D3                       SUB EBX, EDX
00008: 0205 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0208 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 020E DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0212 DC 64 F7 08                 FSUB QWORD PTR 00000008[EDI][ESI*8]
00007: 0216 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 1150:   rz=a[i].r.z-a[k].r.z;

00008: 0219 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 021C 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0223 29 D6                       SUB ESI, EDX
00008: 0225 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0228 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 022E 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0231 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0238 29 D3                       SUB EBX, EDX
00008: 023A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 023D 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0243 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0247 DC 64 F7 10                 FSUB QWORD PTR 00000010[EDI][ESI*8]
00007: 024B DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 1151:   if(kx<-1)rx+=lx;

00008: 024E 83 7D FFFFFFC8 FFFFFFFF     CMP DWORD PTR FFFFFFC8[EBP], FFFFFFFF
00008: 0252 7D 0C                       JGE L0004
00008: 0254 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0257 DC 05 00000000              FADD QWORD PTR _lx
00007: 025D DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 0260                     L0004:

; 1152:   if(kx>1)rx-=lx;

00008: 0260 83 7D FFFFFFC8 01           CMP DWORD PTR FFFFFFC8[EBP], 00000001
00008: 0264 7E 0C                       JLE L0005
00008: 0266 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0269 DC 25 00000000              FSUB QWORD PTR _lx
00007: 026F DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 0272                     L0005:

; 1153:   if(ky<-1)ry+=ly;

00008: 0272 83 7D FFFFFFAC FFFFFFFF     CMP DWORD PTR FFFFFFAC[EBP], FFFFFFFF
00008: 0276 7D 0C                       JGE L0006
00008: 0278 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 027B DC 05 00000000              FADD QWORD PTR _ly
00007: 0281 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 0284                     L0006:

; 1154:   if(ky>1)ry-=ly;

00008: 0284 83 7D FFFFFFAC 01           CMP DWORD PTR FFFFFFAC[EBP], 00000001
00008: 0288 7E 0C                       JLE L0007
00008: 028A DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 028D DC 25 00000000              FSUB QWORD PTR _ly
00007: 0293 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 0296                     L0007:

; 1155:   if(kz<-1)rz+=lz;

00008: 0296 83 7D FFFFFFB0 FFFFFFFF     CMP DWORD PTR FFFFFFB0[EBP], FFFFFFFF
00008: 029A 7D 0C                       JGE L0008
00008: 029C DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 029F DC 05 00000000              FADD QWORD PTR _lz
00007: 02A5 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 02A8                     L0008:

; 1156:   if(kz>1)rz-=lz;

00008: 02A8 83 7D FFFFFFB0 01           CMP DWORD PTR FFFFFFB0[EBP], 00000001
00008: 02AC 7E 0C                       JLE L0009
00008: 02AE DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 02B1 DC 25 00000000              FSUB QWORD PTR _lz
00007: 02B7 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 02BA                     L0009:

; 1157:   dr=rx*rx+ry*ry+rz*rz;

00008: 02BA DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 02BD D8 C8                       FMUL ST, ST
00007: 02BF DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00006: 02C2 D8 C8                       FMUL ST, ST
00006: 02C4 DE C1                       FADDP ST(1), ST
00007: 02C6 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00006: 02C9 D8 C8                       FMUL ST, ST
00006: 02CB DE C1                       FADDP ST(1), ST
00007: 02CD DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 1158:   if(dr<=coll[old_ct].dd)

00008: 02D0 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 02D3 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 02D6 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 02DC DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 02DF DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 02E3 F1DF                        FCOMIP ST, ST(1), L000A
00007: 02E5 DD D8                       FSTP ST
00008: 02E7 7A 20                       JP L000A
00008: 02E9 72 1E                       JB L000A

; 1160:       dr=next_double(coll[old_ct].dd);

00008: 02EB 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 02EE 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 02F1 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 02F7 FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 02FB FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 02FF E8 00000000                 CALL SHORT _next_double
00007: 0304 59                          POP ECX
00007: 0305 59                          POP ECX
00007: 0306 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 1161:      }

00008: 0309                     L000A:

; 1162:   if(prev>-1)

00008: 0309 83 7D FFFFFFA4 FFFFFFFF     CMP DWORD PTR FFFFFFA4[EBP], FFFFFFFF
00008: 030D 7E 39                       JLE L000B

; 1164:       if(dr>=coll[prev].dd)

00008: 030F 8B 5D FFFFFFA4              MOV EBX, DWORD PTR FFFFFFA4[EBP]
00008: 0312 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0315 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 031B DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 031E DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 0322 F1DF                        FCOMIP ST, ST(1), L000C
00007: 0324 DD D8                       FSTP ST
00008: 0326 7A 20                       JP L000C
00008: 0328 77 1E                       JA L000C

; 1165: 	dr=prev_double(coll[old_ct].dd);

00008: 032A 8B 5D 14                    MOV EBX, DWORD PTR 00000014[EBP]
00008: 032D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0330 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0336 FF 74 DA 1C                 PUSH DWORD PTR 0000001C[EDX][EBX*8]
00008: 033A FF 74 DA 18                 PUSH DWORD PTR 00000018[EDX][EBX*8]
00008: 033E E8 00000000                 CALL SHORT _prev_double
00007: 0343 59                          POP ECX
00007: 0344 59                          POP ECX
00007: 0345 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]
00008: 0348                     L000C:

; 1166:      }

00008: 0348                     L000B:

; 1168:   if(*link_err)

00008: 0348 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 034B 83 38 00                    CMP DWORD PTR 00000000[EAX], 00000000
00008: 034E 0F 84 000000E7              JE L000D

; 1170:       int ii=icoll[ic][kc];

00008: 0354 0F BF 75 FFFFFFA0           MOVSX ESI, WORD PTR FFFFFFA0[EBP]
00008: 0358 8B 1D 00000000              MOV EBX, DWORD PTR _icoll
00008: 035E 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0361 8B 4D FFFFFFB4              MOV ECX, DWORD PTR FFFFFFB4[EBP]
00008: 0364 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0367 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 1171:       if(ii>-1)

00008: 036A 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 036E 0F 8E 000000C7              JLE L000D

; 1173: 	  if(dr<coll[ii].dd)

00008: 0374 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 0377 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 037A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0380 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 0383 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 0387 F1DF                        FCOMIP ST, ST(1), L000D
00007: 0389 DD D8                       FSTP ST
00008: 038B 0F 8A 000000AA              JP L000D
00008: 0391 0F 86 000000A4              JBE L000D

; 1175: 	      for(ii=coll[ii].next;ii>-1;ii=coll[ii].next)

00008: 0397 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 039A 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 039D 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 03A3 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 03A7 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX
00008: 03AA EB 48                       JMP L000E
00008: 03AC                     L000F:

; 1177: 		  if(dr>coll[ii].dd)

00008: 03AC 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 03AF 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 03B2 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 03B8 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 03BB DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 03BF F1DF                        FCOMIP ST, ST(1), L0010
00007: 03C1 DD D8                       FSTP ST
00008: 03C3 7A 1C                       JP L0010
00008: 03C5 73 1A                       JAE L0010

; 1179: 		      *link_err=0;

00008: 03C7 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 03CA C7 00 00000000              MOV DWORD PTR 00000000[EAX], 00000000

; 1180: 		      ct=ii;

00008: 03D0 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 03D3 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1181: 		      return ct;

00008: 03D6 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 03D9                             epilog 
00000: 03D9 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 03DC 5F                          POP EDI
00000: 03DD 5E                          POP ESI
00000: 03DE 5B                          POP EBX
00000: 03DF 5D                          POP EBP
00000: 03E0 C3                          RETN 
00008: 03E1                     L0010:

; 1183: 		}

00008: 03E1 8B 5D FFFFFFD0              MOV EBX, DWORD PTR FFFFFFD0[EBP]
00008: 03E4 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 03E7 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 03ED 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 03F1 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX
00008: 03F4                     L000E:
00008: 03F4 83 7D FFFFFFD0 FFFFFFFF     CMP DWORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 03F8 7F FFFFFFB2                 JG L000F

; 1188:   while(ie>-1)

00008: 03FA EB 3F                       JMP L000D
00008: 03FC                     L0011:

; 1190:       if(dr>=coll[ie].dd)

00008: 03FC 8B 5D FFFFFFB8              MOV EBX, DWORD PTR FFFFFFB8[EBP]
00008: 03FF 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0402 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0408 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 040B DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00006: 040F F1DF                        FCOMIP ST, ST(1), L0012
00007: 0411 DD D8                       FSTP ST
00008: 0413 7A 13                       JP L0012
00008: 0415 77 11                       JA L0012

; 1192: 	  ct=ie;

00008: 0417 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 041A 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 1193:           return ct;

00008: 041D 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00000: 0420                             epilog 
00000: 0420 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0423 5F                          POP EDI
00000: 0424 5E                          POP ESI
00000: 0425 5B                          POP EBX
00000: 0426 5D                          POP EBP
00000: 0427 C3                          RETN 
00008: 0428                     L0012:

; 1195:       ie=coll[ie].next;

00008: 0428 8B 5D FFFFFFB8              MOV EBX, DWORD PTR FFFFFFB8[EBP]
00008: 042B 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 042E 8B 35 00000000              MOV ESI, DWORD PTR _coll
00008: 0434 8B 44 DE 38                 MOV EAX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0438 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 1196:     }

00008: 043B                     L000D:
00008: 043B 83 7D FFFFFFB8 FFFFFFFF     CMP DWORD PTR FFFFFFB8[EBP], FFFFFFFF
00008: 043F 7F FFFFFFBB                 JG L0011

; 1197:   return -1;

00008: 0441 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0446                     L0000:
00000: 0446                             epilog 
00000: 0446 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0449 5F                          POP EDI
00000: 044A 5E                          POP ESI
00000: 044B 5B                          POP EBX
00000: 044C 5D                          POP EBP
00000: 044D C3                          RETN 

Function: _moveatom

; 1203: { double delta=timeb-pt->t;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 1203: { double delta=timeb-pt->t;

00008: 0012 DD 05 00000000              FLD QWORD PTR _timeb
00007: 0018 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 001B DC 60 78                    FSUB QWORD PTR 00000078[EAX]
00007: 001E DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 1204:   if(delta)

00008: 0021 DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 0024 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002A F1DF                        FCOMIP ST, ST(1), L0001
00007: 002C DD D8                       FSTP ST
00008: 002E 7A 02                       JP L0002
00008: 0030 74 49                       JE L0001
00008: 0032                     L0002:

; 1206:       pt->r.x=pt->r.x+pt->v.x*delta;

00008: 0032 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0035 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 0038 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 003B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 003E DC 00                       FADD QWORD PTR 00000000[EAX]
00007: 0040 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0043 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 1207:       pt->r.y=pt->r.y+pt->v.y*delta;

00008: 0045 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0048 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 004B DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 004E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0051 DC 40 08                    FADD QWORD PTR 00000008[EAX]
00007: 0054 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0057 DD 58 08                    FSTP QWORD PTR 00000008[EAX]

; 1208:       pt->r.z=pt->r.z+pt->v.z*delta;

00008: 005A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 005D DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 0060 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 0063 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0066 DC 40 10                    FADD QWORD PTR 00000010[EAX]
00007: 0069 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 006C DD 58 10                    FSTP QWORD PTR 00000010[EAX]

; 1209:       pt->t=timeb;

00008: 006F DD 05 00000000              FLD QWORD PTR _timeb
00007: 0075 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0078 DD 58 78                    FSTP QWORD PTR 00000078[EAX]

; 1210:    }

00008: 007B                     L0001:

; 1211: }

00000: 007B                     L0000:
00000: 007B                             epilog 
00000: 007B C9                          LEAVE 
00000: 007C C3                          RETN 

Function: _moveatoms

; 1213: { double delta;

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

; 1215:   for (pt=a;pt->c!=0;pt++)

00008: 0015 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 001A 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 001D EB 54                       JMP L0001
00008: 001F                     L0002:

; 1217:       delta=timeb-pt->t;    

00008: 001F DD 05 00000000              FLD QWORD PTR _timeb
00007: 0025 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0028 DC 60 78                    FSUB QWORD PTR 00000078[EAX]
00007: 002B DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 1218:       pt->q.x=pt->r.x+pt->v.x*delta;

00008: 002E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0031 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 0034 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 0037 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 003A DC 00                       FADD QWORD PTR 00000000[EAX]
00007: 003C 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 003F DD 58 48                    FSTP QWORD PTR 00000048[EAX]

; 1219:       pt->q.y=pt->r.y+pt->v.y*delta;

00008: 0042 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0045 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 0048 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 004B 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 004E DC 40 08                    FADD QWORD PTR 00000008[EAX]
00007: 0051 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0054 DD 58 50                    FSTP QWORD PTR 00000050[EAX]

; 1220:       pt->q.z=pt->r.z+pt->v.z*delta;

00008: 0057 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 005A DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 005D DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 0060 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0063 DC 40 10                    FADD QWORD PTR 00000010[EAX]
00007: 0066 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0069 DD 58 58                    FSTP QWORD PTR 00000058[EAX]

; 1221:     }

00008: 006C 81 45 FFFFFFF4 000000A8     ADD DWORD PTR FFFFFFF4[EBP], 000000A8
00008: 0073                     L0001:
00008: 0073 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0076 66 83 B8 000000A400         CMP WORD PTR 000000A4[EAX], 0000
00008: 007E 75 FFFFFF9F                 JNE L0002

; 1222: }

00000: 0080                     L0000:
00000: 0080                             epilog 
00000: 0080 C9                          LEAVE 
00000: 0081 C3                          RETN 

Function: _update_atoms

; 1225: { double delta;

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

; 1227:   for (pt=a;pt->c!=0;pt++)

00008: 0015 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 001A 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 001D EB 5F                       JMP L0001
00008: 001F                     L0002:

; 1229:       delta=timeb-pt->t;    

00008: 001F DD 05 00000000              FLD QWORD PTR _timeb
00007: 0025 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0028 DC 60 78                    FSUB QWORD PTR 00000078[EAX]
00007: 002B DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 1230:       pt->r.x=pt->r.x+pt->v.x*delta;

00008: 002E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0031 DD 40 18                    FLD QWORD PTR 00000018[EAX]
00007: 0034 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 0037 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 003A DC 00                       FADD QWORD PTR 00000000[EAX]
00007: 003C 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 003F DD 18                       FSTP QWORD PTR 00000000[EAX]

; 1231:       pt->r.y=pt->r.y+pt->v.y*delta;

00008: 0041 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0044 DD 40 20                    FLD QWORD PTR 00000020[EAX]
00007: 0047 DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 004A 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 004D DC 40 08                    FADD QWORD PTR 00000008[EAX]
00007: 0050 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0053 DD 58 08                    FSTP QWORD PTR 00000008[EAX]

; 1232:       pt->r.z=pt->r.z+pt->v.z*delta;

00008: 0056 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0059 DD 40 28                    FLD QWORD PTR 00000028[EAX]
00007: 005C DC 4D FFFFFFF8              FMUL QWORD PTR FFFFFFF8[EBP]
00007: 005F 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0062 DC 40 10                    FADD QWORD PTR 00000010[EAX]
00007: 0065 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0068 DD 58 10                    FSTP QWORD PTR 00000010[EAX]

; 1233:       pt->t=timeb;

00008: 006B DD 05 00000000              FLD QWORD PTR _timeb
00007: 0071 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00007: 0074 DD 58 78                    FSTP QWORD PTR 00000078[EAX]

; 1234:     }

00008: 0077 81 45 FFFFFFF4 000000A8     ADD DWORD PTR FFFFFFF4[EBP], 000000A8
00008: 007E                     L0001:
00008: 007E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0081 66 83 B8 000000A400         CMP WORD PTR 000000A4[EAX], 0000
00008: 0089 75 FFFFFF94                 JNE L0002

; 1235: }

00000: 008B                     L0000:
00000: 008B                             epilog 
00000: 008B C9                          LEAVE 
00000: 008C C3                          RETN 

Function: _reset_colldata

; 1238: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 08                    SUB ESP, 00000008
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0011 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0015                             prolog 

; 1240:       for (i=0;i<nen;i++)

00008: 0015 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 001C EB 42                       JMP L0001
00008: 001E                     L0002:

; 1242: 	  coll[i].e=coll[i].eo;

00008: 001E 8B 75 FFFFFFF0              MOV ESI, DWORD PTR FFFFFFF0[EBP]
00008: 0021 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0024 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 002A 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 002D 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 0030 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0036 DD 44 F7 08                 FLD QWORD PTR 00000008[EDI][ESI*8]
00007: 003A DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]

; 1243: 	  coll[i].edm=coll[i].edmo;

00008: 003D 8B 75 FFFFFFF0              MOV ESI, DWORD PTR FFFFFFF0[EBP]
00008: 0040 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 0043 8B 3D 00000000              MOV EDI, DWORD PTR _coll
00008: 0049 8B 5D FFFFFFF0              MOV EBX, DWORD PTR FFFFFFF0[EBP]
00008: 004C 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 004F 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0055 DD 44 F7 30                 FLD QWORD PTR 00000030[EDI][ESI*8]
00007: 0059 DD 5C DA 28                 FSTP QWORD PTR 00000028[EDX][EBX*8]

; 1244: 	}

00008: 005D FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 0060                     L0001:
00008: 0060 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0063 3B 05 00000000              CMP EAX, DWORD PTR _nen
00008: 0069 7C FFFFFFB3                 JL L0002

; 1245:       return;

00000: 006B                     L0000:
00000: 006B                             epilog 
00000: 006B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 006E 5F                          POP EDI
00000: 006F 5E                          POP ESI
00000: 0070 5B                          POP EBX
00000: 0071 5D                          POP EBP
00000: 0072 C3                          RETN 

Function: _corr_vel

; 1249: {

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

; 1251:   double corr1=1/corr;

00008: 0016 DD 05 00000000              FLD QWORD PTR .data+00000090
00007: 001C DC 35 00000000              FDIV QWORD PTR _corr
00007: 0022 DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]

; 1252:   for( i=0;i<n1;i++)

00008: 0025 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 002C E9 000000A2                 JMP L0001
00008: 0031                     L0002:

; 1254:       a[i].u.x=a[i].v.x*corr1;

00008: 0031 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0034 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 003B 29 D3                       SUB EBX, EDX
00008: 003D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0040 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0046 DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 0049 DC 4C DA 18                 FMUL QWORD PTR 00000018[EDX][EBX*8]
00007: 004D 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00007: 0050 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0057 29 D3                       SUB EBX, EDX
00007: 0059 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 005C 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 0062 DD 5C DA 60                 FSTP QWORD PTR 00000060[EDX][EBX*8]

; 1255:       a[i].u.y=a[i].v.y*corr1;

00008: 0066 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0069 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0070 29 D3                       SUB EBX, EDX
00008: 0072 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0075 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 007B DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 007E DC 4C DA 20                 FMUL QWORD PTR 00000020[EDX][EBX*8]
00007: 0082 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00007: 0085 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 008C 29 D3                       SUB EBX, EDX
00007: 008E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0091 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 0097 DD 5C DA 68                 FSTP QWORD PTR 00000068[EDX][EBX*8]

; 1256:       a[i].u.z=a[i].v.z*corr1;

00008: 009B 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 009E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00A5 29 D3                       SUB EBX, EDX
00008: 00A7 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00AA 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 00B0 DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 00B3 DC 4C DA 28                 FMUL QWORD PTR 00000028[EDX][EBX*8]
00007: 00B7 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00007: 00BA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 00C1 29 D3                       SUB EBX, EDX
00007: 00C3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00C6 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 00CC DD 5C DA 70                 FSTP QWORD PTR 00000070[EDX][EBX*8]

; 1257:     }

00008: 00D0 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 00D3                     L0001:
00008: 00D3 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00D6 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 00DC 0F 8C FFFFFF4F              JL L0002

; 1258: }

00000: 00E2                     L0000:
00000: 00E2                             epilog 
00000: 00E2 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00E5 5B                          POP EBX
00000: 00E6 5D                          POP EBP
00000: 00E7 C3                          RETN 

Function: _countenergy

; 1261: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1262:   return -potential;

00008: 0003 DD 05 00000000              FLD QWORD PTR _potential
00007: 0009 D9 E0                       FCHS 
00000: 000B                     L0000:
00000: 000B                             epilog 
00000: 000B C9                          LEAVE 
00000: 000C C3                          RETN 

Function: _get_pressure

; 1266: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1267:   if (pressure!=dblarg1)

00008: 0003 DD 05 00000000              FLD QWORD PTR _pressure
00007: 0009 DD 05 00000000              FLD QWORD PTR _dblarg1
00006: 000F F1DF                        FCOMIP ST, ST(1), L0001
00007: 0011 DD D8                       FSTP ST
00008: 0013 7A 02                       JP L0003
00008: 0015 74 08                       JE L0001
00008: 0017                     L0003:

; 1268:   return pressure;

00008: 0017 DD 05 00000000              FLD QWORD PTR _pressure
00000: 001D                             epilog 
00000: 001D C9                          LEAVE 
00000: 001E C3                          RETN 
00008: 001F                     L0001:

; 1269:   else if(timep)

00008: 001F DD 05 00000000              FLD QWORD PTR _timep
00007: 0025 DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 002B F1DF                        FCOMIP ST, ST(1), L0002
00007: 002D DD D8                       FSTP ST
00008: 002F 7A 02                       JP L0004
00008: 0031 74 2E                       JE L0002
00008: 0033                     L0004:

; 1270:   return (virial+vvmtime+vvmtime)/(volume*dim*timep*corr_2);

00008: 0033 DD 05 00000000              FLD QWORD PTR _volume
00007: 0039 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 003F DC 0D 00000000              FMUL QWORD PTR _timep
00007: 0045 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 004B DD 05 00000000              FLD QWORD PTR _virial
00006: 0051 DC 05 00000000              FADD QWORD PTR _vvmtime
00006: 0057 DC 05 00000000              FADD QWORD PTR _vvmtime
00006: 005D DE F1                       FDIVRP ST(1), ST
00000: 005F                             epilog 
00000: 005F C9                          LEAVE 
00000: 0060 C3                          RETN 
00008: 0061                     L0002:

; 1272:   return dblarg1;

00008: 0061 DD 05 00000000              FLD QWORD PTR _dblarg1
00000: 0067                     L0000:
00000: 0067                             epilog 
00000: 0067 C9                          LEAVE 
00000: 0068 C3                          RETN 

Function: _collision

; 1276: { long i,k;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 18                    SUB ESP, 00000018
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 AB                          STOSD 
00000: 0011 AB                          STOSD 
00000: 0012 AB                          STOSD 
00000: 0013 AB                          STOSD 
00000: 0014 AB                          STOSD 
00000: 0015 AB                          STOSD 
00000: 0016 5F                          POP EDI
00000: 0017                             prolog 

; 1277:   int coll_type=0;

00008: 0017 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000

; 1279:   t2=timea-timeb;

00008: 001E DD 05 00000000              FLD QWORD PTR _timea
00007: 0024 DC 25 00000000              FSUB QWORD PTR _timeb
00007: 002A DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 1280:   timeb=timea;

00008: 002D DD 05 00000000              FLD QWORD PTR _timea
00007: 0033 DD 1D 00000000              FSTP QWORD PTR _timeb

; 1281:   ts++;

00008: 0039 DD 05 00000000              FLD QWORD PTR _ts
00007: 003F D8 05 00000000              FADD DWORD PTR .data+00000088
00007: 0045 DD 1D 00000000              FSTP QWORD PTR _ts

; 1282:   corrt1=t2*corr;

00008: 004B DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 004E DC 0D 00000000              FMUL QWORD PTR _corr
00007: 0054 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 1283:   timec+=corrt1;

00008: 0057 DD 05 00000000              FLD QWORD PTR _timec
00007: 005D DC 45 FFFFFFF8              FADD QWORD PTR FFFFFFF8[EBP]
00007: 0060 DD 1D 00000000              FSTP QWORD PTR _timec

; 1284:   timep+=t2;

00008: 0066 DD 05 00000000              FLD QWORD PTR _timep
00007: 006C DC 45 FFFFFFF0              FADD QWORD PTR FFFFFFF0[EBP]
00007: 006F DD 1D 00000000              FSTP QWORD PTR _timep

; 1285:   vvmtime+=t2*vvm;

00008: 0075 DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 0078 DC 0D 00000000              FMUL QWORD PTR _vvm
00007: 007E DC 05 00000000              FADD QWORD PTR _vvmtime
00007: 0084 DD 1D 00000000              FSTP QWORD PTR _vvmtime

; 1286:   potTime+=t2*potential;

00008: 008A DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 008D DC 0D 00000000              FMUL QWORD PTR _potential
00007: 0093 DC 05 00000000              FADD QWORD PTR _potTime
00007: 0099 DD 1D 00000000              FSTP QWORD PTR _potTime

; 1287:   delta2+=corrt1;

00008: 009F DD 05 00000000              FLD QWORD PTR _delta2
00007: 00A5 DC 45 FFFFFFF8              FADD QWORD PTR FFFFFFF8[EBP]
00007: 00A8 DD 1D 00000000              FSTP QWORD PTR _delta2

; 1288:   delta4+=corrt1;

00008: 00AE DD 05 00000000              FLD QWORD PTR _delta4
00007: 00B4 DC 45 FFFFFFF8              FADD QWORD PTR FFFFFFF8[EBP]
00007: 00B7 DD 1D 00000000              FSTP QWORD PTR _delta4

; 1289:   if(t_is_open)delta6+=corrt1;

00008: 00BD 83 3D 00000000 00           CMP DWORD PTR _t_is_open, 00000000
00008: 00C4 74 0F                       JE L0001
00008: 00C6 DD 05 00000000              FLD QWORD PTR _delta6
00007: 00CC DC 45 FFFFFFF8              FADD QWORD PTR FFFFFFF8[EBP]
00007: 00CF DD 1D 00000000              FSTP QWORD PTR _delta6
00008: 00D5                     L0001:

; 1290:   if (q1>=n1)

00008: 00D5 8B 0D 00000000              MOV ECX, DWORD PTR _q1
00008: 00DB 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 00E1 39 D1                       CMP ECX, EDX
00008: 00E3 7C 1F                       JL L0002

; 1291:     newloc(a,p1,q1);

00008: 00E5 A1 00000000                 MOV EAX, DWORD PTR _q1
00008: 00EA 50                          PUSH EAX
00008: 00EB A1 00000000                 MOV EAX, DWORD PTR _p1
00008: 00F0 50                          PUSH EAX
00008: 00F1 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 00F6 50                          PUSH EAX
00008: 00F7 E8 00000000                 CALL SHORT _newloc
00008: 00FC 83 C4 0C                    ADD ESP, 0000000C
00008: 00FF E9 0000016D                 JMP L0003
00008: 0104                     L0002:

; 1294:       coll_type=1;

00008: 0104 C7 45 FFFFFFEC 00000001     MOV DWORD PTR FFFFFFEC[EBP], 00000001

; 1295:       ll++;

00008: 010B FF 05 00000000              INC DWORD PTR _ll

; 1296:       llp++;

00008: 0111 FF 05 00000000              INC DWORD PTR _llp

; 1297:       ct1=newvel (a,p1,q1,ct1); /*virial is computed inside newvel*/

00008: 0117 A1 00000000                 MOV EAX, DWORD PTR _ct1
00008: 011C 50                          PUSH EAX
00008: 011D A1 00000000                 MOV EAX, DWORD PTR _q1
00008: 0122 50                          PUSH EAX
00008: 0123 A1 00000000                 MOV EAX, DWORD PTR _p1
00008: 0128 50                          PUSH EAX
00008: 0129 A1 00000000                 MOV EAX, DWORD PTR _a
00008: 012E 50                          PUSH EAX
00008: 012F E8 00000000                 CALL SHORT _newvel
00008: 0134 83 C4 10                    ADD ESP, 00000010
00008: 0137 A3 00000000                 MOV DWORD PTR _ct1, EAX

; 1298:       if(llp==deltall)

00008: 013C 8B 0D 00000000              MOV ECX, DWORD PTR _llp
00008: 0142 8B 15 00000000              MOV EDX, DWORD PTR _deltall
00008: 0148 39 D1                       CMP ECX, EDX
00008: 014A 0F 85 00000121              JNE L0004

; 1300: 	  pressure=(virial+vvmtime+vvmtime)/(volume*dim*timep*corr_2);

00008: 0150 DD 05 00000000              FLD QWORD PTR _volume
00007: 0156 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 015C DC 0D 00000000              FMUL QWORD PTR _timep
00007: 0162 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 0168 DD 05 00000000              FLD QWORD PTR _virial
00006: 016E DC 05 00000000              FADD QWORD PTR _vvmtime
00006: 0174 DC 05 00000000              FADD QWORD PTR _vvmtime
00006: 017A DE F1                       FDIVRP ST(1), ST
00007: 017C DD 1D 00000000              FSTP QWORD PTR _pressure

; 1301: 	  temperature=2*vvmtime/(n1*dim*timep*corr_2);

00008: 0182 DB 05 00000000              FILD DWORD PTR _n1
00007: 0188 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 018E DC 0D 00000000              FMUL QWORD PTR _timep
00007: 0194 DC 0D 00000000              FMUL QWORD PTR _corr_2
00007: 019A DD 05 00000000              FLD QWORD PTR .data+000000b0
00006: 01A0 DC 0D 00000000              FMUL QWORD PTR _vvmtime
00006: 01A6 DE F1                       FDIVRP ST(1), ST
00007: 01A8 DD 1D 00000000              FSTP QWORD PTR _temperature

; 1302:           avePot=potTime/timep;

00008: 01AE DD 05 00000000              FLD QWORD PTR _potTime
00007: 01B4 DC 35 00000000              FDIV QWORD PTR _timep
00007: 01BA DD 1D 00000000              FSTP QWORD PTR _avePot

; 1303: 	  mes_time=timec;

00008: 01C0 DD 05 00000000              FLD QWORD PTR _timec
00007: 01C6 DD 1D 00000000              FSTP QWORD PTR _mes_time

; 1304: 	  if(is_open)

00008: 01CC 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 01D3 74 3C                       JE L0005

; 1306: 	      n_p_mes++;

00008: 01D5 FF 05 00000000              INC DWORD PTR _n_p_mes

; 1307: 	      avpres+=pressure;

00008: 01DB DD 05 00000000              FLD QWORD PTR _avpres
00007: 01E1 DC 05 00000000              FADD QWORD PTR _pressure
00007: 01E7 DD 1D 00000000              FSTP QWORD PTR _avpres

; 1308: 	      avtemp+=temperature;

00008: 01ED DD 05 00000000              FLD QWORD PTR _avtemp
00007: 01F3 DC 05 00000000              FADD QWORD PTR _temperature
00007: 01F9 DD 1D 00000000              FSTP QWORD PTR _avtemp

; 1309:               avpot+=avePot;

00008: 01FF DD 05 00000000              FLD QWORD PTR _avpot
00007: 0205 DC 05 00000000              FADD QWORD PTR _avePot
00007: 020B DD 1D 00000000              FSTP QWORD PTR _avpot

; 1310: 	    }

00008: 0211                     L0005:

; 1311: 	  if(m_is_open)add_movie_param(temperature,-avePot,

00008: 0211 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 0218 74 52                       JE L0006
00008: 021A FF 35 00000004              PUSH DWORD PTR _pressure+00000004
00008: 0220 FF 35 00000000              PUSH DWORD PTR _pressure
00008: 0226 DD 05 00000000              FLD QWORD PTR .data+00000080
00007: 022C DC 0D 00000000              FMUL QWORD PTR _temperature
00007: 0232 DC 0D 00000000              FMUL QWORD PTR _dim
00007: 0238 DB 05 00000000              FILD DWORD PTR _n1
00006: 023E DE C9                       FMULP ST(1), ST
00007: 0240 DC 25 00000000              FSUB QWORD PTR _avePot
00007: 0246 50                          PUSH EAX
00007: 0247 50                          PUSH EAX
00007: 0248 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 024B DD 05 00000000              FLD QWORD PTR _avePot
00007: 0251 D9 E0                       FCHS 
00007: 0253 50                          PUSH EAX
00007: 0254 50                          PUSH EAX
00007: 0255 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0258 FF 35 00000004              PUSH DWORD PTR _temperature+00000004
00008: 025E FF 35 00000000              PUSH DWORD PTR _temperature
00008: 0264 E8 00000000                 CALL SHORT _add_movie_param
00008: 0269 83 C4 20                    ADD ESP, 00000020
00008: 026C                     L0006:

; 1313: 	  rescale();

00008: 026C E8 00000000                 CALL SHORT _rescale

; 1314: 	}

00008: 0271                     L0004:

; 1315:     }

00008: 0271                     L0003:

; 1317:   if (delta2>delta1)

00008: 0271 DD 05 00000000              FLD QWORD PTR _delta2
00007: 0277 DD 05 00000000              FLD QWORD PTR _delta1
00006: 027D F1DF                        FCOMIP ST, ST(1), L0007
00007: 027F DD D8                       FSTP ST
00008: 0281 7A 27                       JP L0007
00008: 0283 73 25                       JAE L0007

; 1319:       delta2-=delta1;

00008: 0285 DD 05 00000000              FLD QWORD PTR _delta2
00007: 028B DC 25 00000000              FSUB QWORD PTR _delta1
00007: 0291 DD 1D 00000000              FSTP QWORD PTR _delta2

; 1320:       if(is_open)

00008: 0297 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 029E 74 0A                       JE L0008

; 1322: 	  is_open=write_echo();

00008: 02A0 E8 00000000                 CALL SHORT _write_echo
00008: 02A5 A3 00000000                 MOV DWORD PTR _is_open, EAX

; 1323: 	}     

00008: 02AA                     L0008:

; 1324:     }

00008: 02AA                     L0007:

; 1325:   if (delta4>delta3)

00008: 02AA DD 05 00000000              FLD QWORD PTR _delta4
00007: 02B0 DD 05 00000000              FLD QWORD PTR _delta3
00006: 02B6 F1DF                        FCOMIP ST, ST(1), L0009
00007: 02B8 DD D8                       FSTP ST
00008: 02BA 7A 27                       JP L0009
00008: 02BC 73 25                       JAE L0009

; 1327:       delta4-=delta3;

00008: 02BE DD 05 00000000              FLD QWORD PTR _delta4
00007: 02C4 DC 25 00000000              FSUB QWORD PTR _delta3
00007: 02CA DD 1D 00000000              FSTP QWORD PTR _delta4

; 1328:       if(m_is_open)m_is_open=write_movie_frame();

00008: 02D0 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 02D7 74 0A                       JE L000A
00008: 02D9 E8 00000000                 CALL SHORT _write_movie_frame
00008: 02DE A3 00000000                 MOV DWORD PTR _m_is_open, EAX
00008: 02E3                     L000A:

; 1329:     }

00008: 02E3                     L0009:

; 1330:   if (delta6>delta5)

00008: 02E3 DD 05 00000000              FLD QWORD PTR _delta6
00007: 02E9 DD 05 00000000              FLD QWORD PTR _delta5
00006: 02EF F1DF                        FCOMIP ST, ST(1), L000B
00007: 02F1 DD D8                       FSTP ST
00008: 02F3 7A 26                       JP L000B
00008: 02F5 73 24                       JAE L000B

; 1332:       if(!coll_type)

00008: 02F7 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 02FB 75 1E                       JNE L000C

; 1334: 	  delta6-=delta5;

00008: 02FD DD 05 00000000              FLD QWORD PTR _delta6
00007: 0303 DC 25 00000000              FSUB QWORD PTR _delta5
00007: 0309 DD 1D 00000000              FSTP QWORD PTR _delta6

; 1335: 	  writetext(text_name);

00008: 030F A1 00000000                 MOV EAX, DWORD PTR _text_name
00008: 0314 50                          PUSH EAX
00008: 0315 E8 00000000                 CALL SHORT _writetext
00008: 031A 59                          POP ECX

; 1336: 	}

00008: 031B                     L000C:

; 1337:     }

00008: 031B                     L000B:

; 1339:   corr_func(corrt1);

00008: 031B FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 031E FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0321 E8 00000000                 CALL SHORT _corr_func
00008: 0326 59                          POP ECX
00008: 0327 59                          POP ECX

; 1340:   return coll_type;

00008: 0328 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00000: 032B                     L0000:
00000: 032B                             epilog 
00000: 032B C9                          LEAVE 
00000: 032C C3                          RETN 

Function: _writetext

; 1345: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 1348:   long fErr=0;

00008: 0012 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000

; 1363:   path=fopen(/*new*/fname,"wb");//newname->fname

00008: 0019 68 00000000                 PUSH OFFSET @311
00008: 001E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0021 50                          PUSH EAX
00008: 0022 E8 00000000                 CALL SHORT _fopen
00008: 0027 59                          POP ECX
00008: 0028 59                          POP ECX
00008: 0029 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 1365:   if(!path)return 1;

00008: 002C 83 7D FFFFFFFC 00           CMP DWORD PTR FFFFFFFC[EBP], 00000000
00008: 0030 75 07                       JNE L0001
00008: 0032 B8 00000001                 MOV EAX, 00000001
00000: 0037                             epilog 
00000: 0037 C9                          LEAVE 
00000: 0038 C3                          RETN 
00008: 0039                     L0001:

; 1366:   fErr=write_key_coord(path);

00008: 0039 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 003C E8 00000000                 CALL SHORT _write_key_coord
00008: 0041 59                          POP ECX
00008: 0042 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 1367:   if(fErr==noErr)

00008: 0045 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0049 75 1F                       JNE L0002

; 1369:       fflush(path);

00008: 004B FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 004E E8 00000000                 CALL SHORT _fflush
00008: 0053 59                          POP ECX

; 1370:       fclose(path);

00008: 0054 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0057 E8 00000000                 CALL SHORT _fclose
00008: 005C 59                          POP ECX

; 1371:       text_no++;

00008: 005D FF 05 00000000              INC DWORD PTR _text_no

; 1372:       return 0;

00008: 0063 B8 00000000                 MOV EAX, 00000000
00000: 0068                             epilog 
00000: 0068 C9                          LEAVE 
00000: 0069 C3                          RETN 
00008: 006A                     L0002:

; 1375:     return 1;			

00008: 006A B8 00000001                 MOV EAX, 00000001
00000: 006F                     L0000:
00000: 006F                             epilog 
00000: 006F C9                          LEAVE 
00000: 0070 C3                          RETN 

Function: _stop_atoms

; 1379: {    

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 81 EC 00000100              SUB ESP, 00000100
00000: 000B 57                          PUSH EDI
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0015 B9 00000040                 MOV ECX, 00000040
00000: 001A F3 AB                       REP STOSD 
00000: 001C 5F                          POP EDI
00000: 001D                             prolog 

; 1385:   double corr1=1/corr;

00008: 001D DD 05 00000000              FLD QWORD PTR .data+00000090
00007: 0023 DC 35 00000000              FDIV QWORD PTR _corr
00007: 0029 DD 9D FFFFFF40              FSTP QWORD PTR FFFFFF40[EBP]

; 1386:   printf("stop atoms");

00008: 002F 68 00000000                 PUSH OFFSET @887
00008: 0034 E8 00000000                 CALL SHORT _printf
00008: 0039 59                          POP ECX

; 1387:   sm=0; 

00008: 003A DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0040 DD 9D FFFFFF20              FSTP QWORD PTR FFFFFF20[EBP]

; 1388:   for(i=0;i<n;i++)

00008: 0046 C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 0050 EB 2E                       JMP L0001
00008: 0052                     L0002:

; 1389:     sm+=a[i].m;

00008: 0052 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0058 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 005F 29 D3                       SUB EBX, EDX
00008: 0061 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0064 DD 85 FFFFFF20              FLD QWORD PTR FFFFFF20[EBP]
00007: 006A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 006D DC 84 D8 00000088           FADD QWORD PTR 00000088[EAX][EBX*8]
00007: 0074 DD 9D FFFFFF20              FSTP QWORD PTR FFFFFF20[EBP]
00008: 007A FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 0080                     L0001:
00008: 0080 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 0086 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0089 7C FFFFFFC7                 JL L0002

; 1391:   for(j=0;j<3;j++)

00008: 008B C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 0095 E9 0000021C                 JMP L0003
00008: 009A                     L0004:

; 1393:       rx=a[0].r[j];

00008: 009A 8B 8D FFFFFF00              MOV ECX, DWORD PTR FFFFFF00[EBP]
00008: 00A0 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00A3 DD 44 C8 48                 FLD QWORD PTR 00000048[EAX][ECX*8]
00007: 00A7 DD 9D FFFFFF08              FSTP QWORD PTR FFFFFF08[EBP]

; 1394:       a[0].r[j]=0;

00008: 00AD 8B 8D FFFFFF00              MOV ECX, DWORD PTR FFFFFF00[EBP]
00008: 00B3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00B6 C7 44 C8 4C 00000000        MOV DWORD PTR 0000004C[EAX][ECX*8], 00000000
00008: 00BE 8B 8D FFFFFF00              MOV ECX, DWORD PTR FFFFFF00[EBP]
00008: 00C4 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00C7 C7 44 C8 48 00000000        MOV DWORD PTR 00000048[EAX][ECX*8], 00000000

; 1395:       sx=0;

00008: 00CF DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 00D5 DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1396:       for(i=1;i<n;i++){ 

00008: 00DB C7 85 FFFFFEFC00000001      MOV DWORD PTR FFFFFEFC[EBP], 00000001
00008: 00E5 E9 0000015C                 JMP L0005
00008: 00EA                     L0006:

; 1397: 	dx=a[i].r[j]-rx;

00008: 00EA 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 00F0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00F7 29 D3                       SUB EBX, EDX
00008: 00F9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00FC 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0102 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0105 DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 0109 DC A5 FFFFFF08              FSUB QWORD PTR FFFFFF08[EBP]
00007: 010F DD 9D FFFFFF18              FSTP QWORD PTR FFFFFF18[EBP]

; 1398: 	if(dx+dx<-bound[j].length)dx+=bound[j].length;

00008: 0115 8B 9D FFFFFF00              MOV EBX, DWORD PTR FFFFFF00[EBP]
00008: 011B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 011E DD 04 DD 00000000           FLD QWORD PTR _bound[EBX*8]
00007: 0125 D9 E0                       FCHS 
00007: 0127 DD 85 FFFFFF18              FLD QWORD PTR FFFFFF18[EBP]
00006: 012D D8 C0                       FADD ST, ST
00006: 012F F1DF                        FCOMIP ST, ST(1), L0007
00007: 0131 DD D8                       FSTP ST
00008: 0133 7A 1E                       JP L0007
00008: 0135 73 1C                       JAE L0007
00008: 0137 8B 9D FFFFFF00              MOV EBX, DWORD PTR FFFFFF00[EBP]
00008: 013D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0140 DD 85 FFFFFF18              FLD QWORD PTR FFFFFF18[EBP]
00007: 0146 DC 04 DD 00000000           FADD QWORD PTR _bound[EBX*8]
00007: 014D DD 9D FFFFFF18              FSTP QWORD PTR FFFFFF18[EBP]
00008: 0153                     L0007:

; 1399: 	if(dx+dx>bound[j].length)dx-=bound[j].length;

00008: 0153 8B 9D FFFFFF00              MOV EBX, DWORD PTR FFFFFF00[EBP]
00008: 0159 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 015C DD 85 FFFFFF18              FLD QWORD PTR FFFFFF18[EBP]
00007: 0162 D8 C0                       FADD ST, ST
00007: 0164 DD 04 DD 00000000           FLD QWORD PTR _bound[EBX*8]
00006: 016B F1DF                        FCOMIP ST, ST(1), L0008
00007: 016D DD D8                       FSTP ST
00008: 016F 7A 1E                       JP L0008
00008: 0171 73 1C                       JAE L0008
00008: 0173 8B 9D FFFFFF00              MOV EBX, DWORD PTR FFFFFF00[EBP]
00008: 0179 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 017C DD 85 FFFFFF18              FLD QWORD PTR FFFFFF18[EBP]
00007: 0182 DC 24 DD 00000000           FSUB QWORD PTR _bound[EBX*8]
00007: 0189 DD 9D FFFFFF18              FSTP QWORD PTR FFFFFF18[EBP]
00008: 018F                     L0008:

; 1400: 	rx=a[i].r[j];

00008: 018F 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0195 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 019C 29 D3                       SUB EBX, EDX
00008: 019E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01A1 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 01A7 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 01AA DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 01AE DD 9D FFFFFF08              FSTP QWORD PTR FFFFFF08[EBP]

; 1401: 	a[i].r[j]=a[i-1].r[j]+dx;

00008: 01B4 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 01BA 4A                          DEC EDX
00008: 01BB 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01C2 29 D3                       SUB EBX, EDX
00008: 01C4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01C7 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 01CD DD 85 FFFFFF18              FLD QWORD PTR FFFFFF18[EBP]
00007: 01D3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 01D6 DC 44 D8 48                 FADD QWORD PTR 00000048[EAX][EBX*8]
00007: 01DA 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00007: 01E0 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 01E7 29 D3                       SUB EBX, EDX
00007: 01E9 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 01EC 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00007: 01F2 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 01F5 DD 5C D8 48                 FSTP QWORD PTR 00000048[EAX][EBX*8]

; 1402: 	sx+=a[i].r[j]*a[i].m;

00008: 01F9 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 01FF 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0206 29 D6                       SUB ESI, EDX
00008: 0208 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 020B 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0211 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0218 29 D3                       SUB EBX, EDX
00008: 021A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 021D 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0223 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0226 DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 022A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 022D DC 8C F0 00000088           FMUL QWORD PTR 00000088[EAX][ESI*8]
00007: 0234 DC 85 FFFFFF10              FADD QWORD PTR FFFFFF10[EBP]
00007: 023A DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1403:       }

00008: 0240 FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 0246                     L0005:
00008: 0246 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 024C 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 024F 0F 8C FFFFFE95              JL L0006

; 1404:       sx/=sm;

00008: 0255 DD 85 FFFFFF10              FLD QWORD PTR FFFFFF10[EBP]
00007: 025B DC B5 FFFFFF20              FDIV QWORD PTR FFFFFF20[EBP]
00007: 0261 DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1405:       for(i=0;i<n;i++)

00008: 0267 C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 0271 EB 32                       JMP L0009
00008: 0273                     L000A:

; 1406: 	a[i].r[j]-=sx;

00008: 0273 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0279 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0280 29 D3                       SUB EBX, EDX
00008: 0282 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0285 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 028B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 028E DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 0292 DC A5 FFFFFF10              FSUB QWORD PTR FFFFFF10[EBP]
00007: 0298 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 029B DD 5C D8 48                 FSTP QWORD PTR 00000048[EAX][EBX*8]
00008: 029F FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 02A5                     L0009:
00008: 02A5 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 02AB 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 02AE 7C FFFFFFC3                 JL L000A

; 1407:     }

00008: 02B0 FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 02B6                     L0003:
00008: 02B6 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 02BD 0F 8C FFFFFDD7              JL L0004

; 1409:     for(j=0;j<3;j++)

00008: 02C3 C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 02CD E9 000000EF                 JMP L000B
00008: 02D2                     L000C:

; 1411: 	sx=0;

00008: 02D2 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 02D8 DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1412: 	for(i=0;i<n;i++){ 

00008: 02DE C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 02E8 EB 4D                       JMP L000D
00008: 02EA                     L000E:

; 1413: 	  sx+=a[i].v[j]*a[i].m;

00008: 02EA 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 02F0 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 02F7 29 D6                       SUB ESI, EDX
00008: 02F9 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 02FC 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0302 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0309 29 D3                       SUB EBX, EDX
00008: 030B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 030E 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0314 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0317 DD 44 D8 18                 FLD QWORD PTR 00000018[EAX][EBX*8]
00007: 031B 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 031E DC 8C F0 00000088           FMUL QWORD PTR 00000088[EAX][ESI*8]
00007: 0325 DC 85 FFFFFF10              FADD QWORD PTR FFFFFF10[EBP]
00007: 032B DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1414: 	}

00008: 0331 FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 0337                     L000D:
00008: 0337 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 033D 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0340 7C FFFFFFA8                 JL L000E

; 1415: 	sx/=sm;

00008: 0342 DD 85 FFFFFF10              FLD QWORD PTR FFFFFF10[EBP]
00007: 0348 DC B5 FFFFFF20              FDIV QWORD PTR FFFFFF20[EBP]
00007: 034E DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1416: 	for(i=0;i<n;i++)

00008: 0354 C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 035E EB 50                       JMP L000F
00008: 0360                     L0010:

; 1417: 	  a[i].u[j]=(a[i].v[j]-sx)*corr1;

00008: 0360 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0366 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 036D 29 D3                       SUB EBX, EDX
00008: 036F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0372 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0378 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 037B DD 44 D8 18                 FLD QWORD PTR 00000018[EAX][EBX*8]
00007: 037F DC A5 FFFFFF10              FSUB QWORD PTR FFFFFF10[EBP]
00007: 0385 DC 8D FFFFFF40              FMUL QWORD PTR FFFFFF40[EBP]
00007: 038B 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00007: 0391 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0398 29 D3                       SUB EBX, EDX
00007: 039A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 039D 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00007: 03A3 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 03A6 DD 5C D8 60                 FSTP QWORD PTR 00000060[EAX][EBX*8]
00008: 03AA FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 03B0                     L000F:
00008: 03B0 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 03B6 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 03B9 7C FFFFFFA5                 JL L0010

; 1418:       }

00008: 03BB FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 03C1                     L000B:
00008: 03C1 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 03C8 0F 8C FFFFFF04              JL L000C

; 1420:   I=0;

00008: 03CE DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 03D4 DD 9D FFFFFF28              FSTP QWORD PTR FFFFFF28[EBP]

; 1421:   for(i=0;i<3;i++)

00008: 03DA C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 03E4 E9 00000111                 JMP L0011
00008: 03E9                     L0012:

; 1423:       for(j=0;j<3;j++)

00008: 03E9 C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 03F3 E9 000000B1                 JMP L0013
00008: 03F8                     L0014:

; 1425: 	  double  rij=0;

00008: 03F8 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 03FE DD 9D FFFFFF48              FSTP QWORD PTR FFFFFF48[EBP]

; 1426: 	  for(k=0;k<n;k++)

00008: 0404 C7 85 FFFFFF0400000000      MOV DWORD PTR FFFFFF04[EBP], 00000000
00008: 040E EB 6C                       JMP L0015
00008: 0410                     L0016:

; 1428: 	      rij+=a[k].r[i]*a[k].r[j]*a[k].m;

00008: 0410 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0416 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 041D 29 D6                       SUB ESI, EDX
00008: 041F 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0422 03 B5 FFFFFF00              ADD ESI, DWORD PTR FFFFFF00[EBP]
00008: 0428 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 042E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0435 29 D3                       SUB EBX, EDX
00008: 0437 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 043A 03 9D FFFFFEFC              ADD EBX, DWORD PTR FFFFFEFC[EBP]
00008: 0440 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0443 DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 0447 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 044A DC 4C F0 48                 FMUL QWORD PTR 00000048[EAX][ESI*8]
00007: 044E 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0454 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 045B 29 D3                       SUB EBX, EDX
00007: 045D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0460 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0463 DC 8C D8 00000088           FMUL QWORD PTR 00000088[EAX][EBX*8]
00007: 046A DC 85 FFFFFF48              FADD QWORD PTR FFFFFF48[EBP]
00007: 0470 DD 9D FFFFFF48              FSTP QWORD PTR FFFFFF48[EBP]

; 1429: 	    }

00008: 0476 FF 85 FFFFFF04              INC DWORD PTR FFFFFF04[EBP]
00008: 047C                     L0015:
00008: 047C 8B 85 FFFFFF04              MOV EAX, DWORD PTR FFFFFF04[EBP]
00008: 0482 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0485 7C FFFFFF89                 JL L0016

; 1430: 	  A[i][j]=rij;

00008: 0487 8B 9D FFFFFEFC              MOV EBX, DWORD PTR FFFFFEFC[EBP]
00008: 048D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0490 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0496 DD 85 FFFFFF48              FLD QWORD PTR FFFFFF48[EBP]
00007: 049C DD 9C DD FFFFFF68           FSTP QWORD PTR FFFFFF68[EBP][EBX*8]

; 1431: 	}

00008: 04A3 FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 04A9                     L0013:
00008: 04A9 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 04B0 0F 8C FFFFFF42              JL L0014

; 1432:       I+=A[i][i];

00008: 04B6 8B 9D FFFFFEFC              MOV EBX, DWORD PTR FFFFFEFC[EBP]
00008: 04BC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04BF 03 9D FFFFFEFC              ADD EBX, DWORD PTR FFFFFEFC[EBP]
00008: 04C5 DD 85 FFFFFF28              FLD QWORD PTR FFFFFF28[EBP]
00007: 04CB DC 84 DD FFFFFF68           FADD QWORD PTR FFFFFF68[EBP][EBX*8]
00007: 04D2 DD 9D FFFFFF28              FSTP QWORD PTR FFFFFF28[EBP]

; 1433:       M[i]=0;

00008: 04D8 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 04DE C7 44 C5 FFFFFFE4 00000000  MOV DWORD PTR FFFFFFE4[EBP][EAX*8], 00000000
00008: 04E6 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 04EC C7 44 C5 FFFFFFE0 00000000  MOV DWORD PTR FFFFFFE0[EBP][EAX*8], 00000000

; 1434:     }

00008: 04F4 FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 04FA                     L0011:
00008: 04FA 83 BD FFFFFEFC03            CMP DWORD PTR FFFFFEFC[EBP], 00000003
00008: 0501 0F 8C FFFFFEE2              JL L0012

; 1435:   if(!I) return;

00008: 0507 DD 85 FFFFFF28              FLD QWORD PTR FFFFFF28[EBP]
00007: 050D DD 05 00000000              FLD QWORD PTR .data+00000050
00006: 0513 F1DF                        FCOMIP ST, ST(1), L0017
00007: 0515 DD D8                       FSTP ST
00008: 0517 7A 09                       JP L0017
00008: 0519 75 07                       JNE L0017
00000: 051B                             epilog 
00000: 051B 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 051E 5E                          POP ESI
00000: 051F 5B                          POP EBX
00000: 0520 5D                          POP EBP
00000: 0521 C3                          RETN 
00008: 0522                     L0017:

; 1436:   for(k=0;k<n;k++)

00008: 0522 C7 85 FFFFFF0400000000      MOV DWORD PTR FFFFFF04[EBP], 00000000
00008: 052C E9 0000019E                 JMP L0018
00008: 0531                     L0019:

; 1438:     M[2]+=(a[k].r[0]*a[k].u[1]-a[k].r[1]*a[k].u[0])*a[k].m;

00008: 0531 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0537 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 053E 29 D6                       SUB ESI, EDX
00008: 0540 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0543 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0549 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0550 29 D3                       SUB EBX, EDX
00008: 0552 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0555 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0558 DD 44 D8 50                 FLD QWORD PTR 00000050[EAX][EBX*8]
00007: 055C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 055F DC 4C F0 60                 FMUL QWORD PTR 00000060[EAX][ESI*8]
00007: 0563 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0569 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00007: 0570 29 D6                       SUB ESI, EDX
00007: 0572 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00007: 0575 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 057B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0582 29 D3                       SUB EBX, EDX
00007: 0584 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0587 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 058A DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00006: 058E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 0591 DC 4C F0 68                 FMUL QWORD PTR 00000068[EAX][ESI*8]
00006: 0595 DE E1                       FSUBRP ST(1), ST
00007: 0597 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 059D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 05A4 29 D3                       SUB EBX, EDX
00007: 05A6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 05A9 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 05AC DC 8C D8 00000088           FMUL QWORD PTR 00000088[EAX][EBX*8]
00007: 05B3 DC 45 FFFFFFF0              FADD QWORD PTR FFFFFFF0[EBP]
00007: 05B6 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 1439:     M[0]+=(a[k].r[1]*a[k].u[2]-a[k].r[2]*a[k].u[1])*a[k].m;

00008: 05B9 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 05BF 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 05C6 29 D6                       SUB ESI, EDX
00008: 05C8 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 05CB 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 05D1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 05D8 29 D3                       SUB EBX, EDX
00008: 05DA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 05DD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 05E0 DD 44 D8 58                 FLD QWORD PTR 00000058[EAX][EBX*8]
00007: 05E4 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 05E7 DC 4C F0 68                 FMUL QWORD PTR 00000068[EAX][ESI*8]
00007: 05EB 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 05F1 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00007: 05F8 29 D6                       SUB ESI, EDX
00007: 05FA 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00007: 05FD 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0603 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 060A 29 D3                       SUB EBX, EDX
00007: 060C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 060F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0612 DD 44 D8 50                 FLD QWORD PTR 00000050[EAX][EBX*8]
00006: 0616 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 0619 DC 4C F0 70                 FMUL QWORD PTR 00000070[EAX][ESI*8]
00006: 061D DE E1                       FSUBRP ST(1), ST
00007: 061F 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0625 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 062C 29 D3                       SUB EBX, EDX
00007: 062E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0631 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0634 DC 8C D8 00000088           FMUL QWORD PTR 00000088[EAX][EBX*8]
00007: 063B DC 45 FFFFFFE0              FADD QWORD PTR FFFFFFE0[EBP]
00007: 063E DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 1440:     M[1]+=(a[k].r[2]*a[k].u[0]-a[k].r[0]*a[k].u[2])*a[k].m;

00008: 0641 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0647 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 064E 29 D6                       SUB ESI, EDX
00008: 0650 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0653 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0659 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0660 29 D3                       SUB EBX, EDX
00008: 0662 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0665 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0668 DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 066C 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 066F DC 4C F0 70                 FMUL QWORD PTR 00000070[EAX][ESI*8]
00007: 0673 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0679 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00007: 0680 29 D6                       SUB ESI, EDX
00007: 0682 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00007: 0685 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 068B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0692 29 D3                       SUB EBX, EDX
00007: 0694 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0697 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 069A DD 44 D8 58                 FLD QWORD PTR 00000058[EAX][EBX*8]
00006: 069E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 06A1 DC 4C F0 60                 FMUL QWORD PTR 00000060[EAX][ESI*8]
00006: 06A5 DE E1                       FSUBRP ST(1), ST
00007: 06A7 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 06AD 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 06B4 29 D3                       SUB EBX, EDX
00007: 06B6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 06B9 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 06BC DC 8C D8 00000088           FMUL QWORD PTR 00000088[EAX][EBX*8]
00007: 06C3 DC 45 FFFFFFE8              FADD QWORD PTR FFFFFFE8[EBP]
00007: 06C6 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 1441:   }

00008: 06C9 FF 85 FFFFFF04              INC DWORD PTR FFFFFF04[EBP]
00008: 06CF                     L0018:
00008: 06CF 8B 85 FFFFFF04              MOV EAX, DWORD PTR FFFFFF04[EBP]
00008: 06D5 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 06D8 0F 8C FFFFFE53              JL L0019

; 1442:     printf("%lf %lf %lf\n",M[0],M[1],M[2]);

00008: 06DE FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 06E1 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 06E4 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 06E7 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 06EA FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 06ED FF 75 FFFFFFE0              PUSH DWORD PTR FFFFFFE0[EBP]
00008: 06F0 68 00000000                 PUSH OFFSET @888
00008: 06F5 E8 00000000                 CALL SHORT _printf
00008: 06FA 83 C4 1C                    ADD ESP, 0000001C

; 1443: norm=0;

00008: 06FD DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 0703 DD 9D FFFFFF38              FSTP QWORD PTR FFFFFF38[EBP]

; 1444:   for(i=0;i<3;i++)

00008: 0709 C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 0713 E9 00000092                 JMP L001A
00008: 0718                     L001B:

; 1446:       for(j=0;j<3;j++)

00008: 0718 C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 0722 EB 29                       JMP L001C
00008: 0724                     L001D:

; 1448: 	  A[i][j]/=I;

00008: 0724 8B 9D FFFFFEFC              MOV EBX, DWORD PTR FFFFFEFC[EBP]
00008: 072A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 072D 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0733 DD 84 DD FFFFFF68           FLD QWORD PTR FFFFFF68[EBP][EBX*8]
00007: 073A DC B5 FFFFFF28              FDIV QWORD PTR FFFFFF28[EBP]
00007: 0740 DD 9C DD FFFFFF68           FSTP QWORD PTR FFFFFF68[EBP][EBX*8]

; 1450: 	}

00008: 0747 FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 074D                     L001C:
00008: 074D 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 0754 7C FFFFFFCE                 JL L001D

; 1452:       M[i]/=I;

00008: 0756 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 075C DD 44 C5 FFFFFFE0           FLD QWORD PTR FFFFFFE0[EBP][EAX*8]
00007: 0760 DC B5 FFFFFF28              FDIV QWORD PTR FFFFFF28[EBP]
00007: 0766 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 076C DD 5C C5 FFFFFFE0           FSTP QWORD PTR FFFFFFE0[EBP][EAX*8]

; 1453:       W[i]=M[i];

00008: 0770 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 0776 DD 44 C5 FFFFFFE0           FLD QWORD PTR FFFFFFE0[EBP][EAX*8]
00007: 077A 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 0780 DD 5C C5 FFFFFFB0           FSTP QWORD PTR FFFFFFB0[EBP][EAX*8]

; 1454:       norm+=M[i]*M[i];

00008: 0784 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 078A DD 44 C5 FFFFFFE0           FLD QWORD PTR FFFFFFE0[EBP][EAX*8]
00007: 078E 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 0794 DC 4C C5 FFFFFFE0           FMUL QWORD PTR FFFFFFE0[EBP][EAX*8]
00007: 0798 DC 85 FFFFFF38              FADD QWORD PTR FFFFFF38[EBP]
00007: 079E DD 9D FFFFFF38              FSTP QWORD PTR FFFFFF38[EBP]

; 1455:     }

00008: 07A4 FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 07AA                     L001A:
00008: 07AA 83 BD FFFFFEFC03            CMP DWORD PTR FFFFFEFC[EBP], 00000003
00008: 07B1 0F 8C FFFFFF61              JL L001B

; 1456:   k=0;

00008: 07B7 C7 85 FFFFFF0400000000      MOV DWORD PTR FFFFFF04[EBP], 00000000

; 1457:   norm*=1.0e-32;

00008: 07C1 DD 85 FFFFFF38              FLD QWORD PTR FFFFFF38[EBP]
00007: 07C7 DC 0D 00000000              FMUL QWORD PTR .data+00000208
00007: 07CD DD 9D FFFFFF38              FSTP QWORD PTR FFFFFF38[EBP]

; 1458:   do{

00008: 07D3                     L001E:

; 1459:     smax=0;

00008: 07D3 DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 07D9 DD 9D FFFFFF30              FSTP QWORD PTR FFFFFF30[EBP]

; 1460:     for(i=0;i<3;i++)

00008: 07DF C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 07E9 EB 69                       JMP L001F
00008: 07EB                     L0020:

; 1462: 	double s=0;

00008: 07EB DD 05 00000000              FLD QWORD PTR .data+00000050
00007: 07F1 DD 9D FFFFFF50              FSTP QWORD PTR FFFFFF50[EBP]

; 1463: 	for(j=0;j<3;j++)

00008: 07F7 C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 0801 EB 32                       JMP L0021
00008: 0803                     L0022:

; 1464: 	  s+=A[i][j]*W[j];

00008: 0803 8B 9D FFFFFEFC              MOV EBX, DWORD PTR FFFFFEFC[EBP]
00008: 0809 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 080C 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0812 8B 85 FFFFFF00              MOV EAX, DWORD PTR FFFFFF00[EBP]
00008: 0818 DD 44 C5 FFFFFFB0           FLD QWORD PTR FFFFFFB0[EBP][EAX*8]
00007: 081C DC 8C DD FFFFFF68           FMUL QWORD PTR FFFFFF68[EBP][EBX*8]
00007: 0823 DC 85 FFFFFF50              FADD QWORD PTR FFFFFF50[EBP]
00007: 0829 DD 9D FFFFFF50              FSTP QWORD PTR FFFFFF50[EBP]
00008: 082F FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 0835                     L0021:
00008: 0835 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 083C 7C FFFFFFC5                 JL L0022

; 1465: 	W1[i]=s;

00008: 083E DD 85 FFFFFF50              FLD QWORD PTR FFFFFF50[EBP]
00007: 0844 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 084A DD 5C C5 FFFFFFC8           FSTP QWORD PTR FFFFFFC8[EBP][EAX*8]

; 1466:       }

00008: 084E FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 0854                     L001F:
00008: 0854 83 BD FFFFFEFC03            CMP DWORD PTR FFFFFEFC[EBP], 00000003
00008: 085B 7C FFFFFF8E                 JL L0020

; 1467:     for(i=0;i<3;i++)

00008: 085D C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 0867 EB 5A                       JMP L0023
00008: 0869                     L0024:

; 1468:       {double s1=W1[i]+M[i];

00008: 0869 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 086F DD 44 C5 FFFFFFC8           FLD QWORD PTR FFFFFFC8[EBP][EAX*8]
00007: 0873 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 0879 DC 44 C5 FFFFFFE0           FADD QWORD PTR FFFFFFE0[EBP][EAX*8]
00007: 087D DD 9D FFFFFF58              FSTP QWORD PTR FFFFFF58[EBP]

; 1469:        double s=s1-W[i];

00008: 0883 DD 85 FFFFFF58              FLD QWORD PTR FFFFFF58[EBP]
00007: 0889 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 088F DC 64 C5 FFFFFFB0           FSUB QWORD PTR FFFFFFB0[EBP][EAX*8]
00007: 0893 DD 9D FFFFFF60              FSTP QWORD PTR FFFFFF60[EBP]

; 1470:        smax+=s*s; 

00008: 0899 DD 85 FFFFFF60              FLD QWORD PTR FFFFFF60[EBP]
00007: 089F D8 C8                       FMUL ST, ST
00007: 08A1 DC 85 FFFFFF30              FADD QWORD PTR FFFFFF30[EBP]
00007: 08A7 DD 9D FFFFFF30              FSTP QWORD PTR FFFFFF30[EBP]

; 1471:       W[i]=s1;

00008: 08AD DD 85 FFFFFF58              FLD QWORD PTR FFFFFF58[EBP]
00007: 08B3 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00007: 08B9 DD 5C C5 FFFFFFB0           FSTP QWORD PTR FFFFFFB0[EBP][EAX*8]

; 1472:      }

00008: 08BD FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 08C3                     L0023:
00008: 08C3 83 BD FFFFFEFC03            CMP DWORD PTR FFFFFEFC[EBP], 00000003
00008: 08CA 7C FFFFFF9D                 JL L0024

; 1474:     k++;

00008: 08CC FF 85 FFFFFF04              INC DWORD PTR FFFFFF04[EBP]

; 1475: if(k==1000)break;

00008: 08D2 81 BD FFFFFF04000003E8      CMP DWORD PTR FFFFFF04[EBP], 000003E8
00008: 08DC 74 18                       JE L0025

; 1476:   }while(smax>norm);

00008: 08DE DD 85 FFFFFF30              FLD QWORD PTR FFFFFF30[EBP]
00007: 08E4 DD 85 FFFFFF38              FLD QWORD PTR FFFFFF38[EBP]
00006: 08EA F1DF                        FCOMIP ST, ST(1), L001E
00007: 08EC DD D8                       FSTP ST
00008: 08EE 7A 06                       JP L002C
00008: 08F0 0F 82 FFFFFEDD              JB L001E
00008: 08F6                     L002C:
00008: 08F6                     L0025:

; 1479:     for(k=0;k<n;k++)

00008: 08F6 C7 85 FFFFFF0400000000      MOV DWORD PTR FFFFFF04[EBP], 00000000
00008: 0900 E9 0000011A                 JMP L0026
00008: 0905                     L0027:

; 1481: 	a[k].u[2]-=W[0]*a[k].r[1]-W[1]*a[k].r[0];

00008: 0905 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 090B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0912 29 D3                       SUB EBX, EDX
00008: 0914 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0917 DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00007: 091A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 091D DC 4C D8 48                 FMUL QWORD PTR 00000048[EAX][EBX*8]
00007: 0921 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0927 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 092E 29 D3                       SUB EBX, EDX
00007: 0930 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0933 DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00006: 0936 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 0939 DC 4C D8 50                 FMUL QWORD PTR 00000050[EAX][EBX*8]
00006: 093D DE E1                       FSUBRP ST(1), ST
00007: 093F 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0945 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 094C 29 D3                       SUB EBX, EDX
00007: 094E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0951 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0954 DD 44 D8 70                 FLD QWORD PTR 00000070[EAX][EBX*8]
00006: 0958 DE E1                       FSUBRP ST(1), ST
00007: 095A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 095D DD 5C D8 70                 FSTP QWORD PTR 00000070[EAX][EBX*8]

; 1482: 	a[k].u[0]-=W[1]*a[k].r[2]-W[2]*a[k].r[1];

00008: 0961 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 0967 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 096E 29 D3                       SUB EBX, EDX
00008: 0970 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0973 DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00007: 0976 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0979 DC 4C D8 50                 FMUL QWORD PTR 00000050[EAX][EBX*8]
00007: 097D 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 0983 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 098A 29 D3                       SUB EBX, EDX
00007: 098C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 098F DD 45 FFFFFFB8              FLD QWORD PTR FFFFFFB8[EBP]
00006: 0992 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 0995 DC 4C D8 58                 FMUL QWORD PTR 00000058[EAX][EBX*8]
00006: 0999 DE E1                       FSUBRP ST(1), ST
00007: 099B 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 09A1 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 09A8 29 D3                       SUB EBX, EDX
00007: 09AA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 09AD 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 09B0 DD 44 D8 60                 FLD QWORD PTR 00000060[EAX][EBX*8]
00006: 09B4 DE E1                       FSUBRP ST(1), ST
00007: 09B6 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 09B9 DD 5C D8 60                 FSTP QWORD PTR 00000060[EAX][EBX*8]

; 1483: 	a[k].u[1]-=W[2]*a[k].r[0]-W[0]*a[k].r[2];

00008: 09BD 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00008: 09C3 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 09CA 29 D3                       SUB EBX, EDX
00008: 09CC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 09CF DD 45 FFFFFFB0              FLD QWORD PTR FFFFFFB0[EBP]
00007: 09D2 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 09D5 DC 4C D8 58                 FMUL QWORD PTR 00000058[EAX][EBX*8]
00007: 09D9 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 09DF 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 09E6 29 D3                       SUB EBX, EDX
00007: 09E8 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 09EB DD 45 FFFFFFC0              FLD QWORD PTR FFFFFFC0[EBP]
00006: 09EE 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00006: 09F1 DC 4C D8 48                 FMUL QWORD PTR 00000048[EAX][EBX*8]
00006: 09F5 DE E1                       FSUBRP ST(1), ST
00007: 09F7 8B 95 FFFFFF04              MOV EDX, DWORD PTR FFFFFF04[EBP]
00007: 09FD 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0A04 29 D3                       SUB EBX, EDX
00007: 0A06 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0A09 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0A0C DD 44 D8 68                 FLD QWORD PTR 00000068[EAX][EBX*8]
00006: 0A10 DE E1                       FSUBRP ST(1), ST
00007: 0A12 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0A15 DD 5C D8 68                 FSTP QWORD PTR 00000068[EAX][EBX*8]

; 1484:       }

00008: 0A19 FF 85 FFFFFF04              INC DWORD PTR FFFFFF04[EBP]
00008: 0A1F                     L0026:
00008: 0A1F 8B 85 FFFFFF04              MOV EAX, DWORD PTR FFFFFF04[EBP]
00008: 0A25 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0A28 0F 8C FFFFFED7              JL L0027

; 1496:   for(j=0;j<3;j++)

00008: 0A2E C7 85 FFFFFF0000000000      MOV DWORD PTR FFFFFF00[EBP], 00000000
00008: 0A38 EB 6B                       JMP L0028
00008: 0A3A                     L0029:

; 1498:       sx=bound[j].length*0.5;

00008: 0A3A 8B 9D FFFFFF00              MOV EBX, DWORD PTR FFFFFF00[EBP]
00008: 0A40 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A43 DD 05 00000000              FLD QWORD PTR .data+00000080
00007: 0A49 DC 0C DD 00000000           FMUL QWORD PTR _bound[EBX*8]
00007: 0A50 DD 9D FFFFFF10              FSTP QWORD PTR FFFFFF10[EBP]

; 1499:       for(i=0;i<n;i++) 

00008: 0A56 C7 85 FFFFFEFC00000000      MOV DWORD PTR FFFFFEFC[EBP], 00000000
00008: 0A60 EB 32                       JMP L002A
00008: 0A62                     L002B:

; 1500: 	a[i].r[j]+=sx;

00008: 0A62 8B 95 FFFFFEFC              MOV EDX, DWORD PTR FFFFFEFC[EBP]
00008: 0A68 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0A6F 29 D3                       SUB EBX, EDX
00008: 0A71 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0A74 03 9D FFFFFF00              ADD EBX, DWORD PTR FFFFFF00[EBP]
00008: 0A7A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0A7D DD 44 D8 48                 FLD QWORD PTR 00000048[EAX][EBX*8]
00007: 0A81 DC 85 FFFFFF10              FADD QWORD PTR FFFFFF10[EBP]
00007: 0A87 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00007: 0A8A DD 5C D8 48                 FSTP QWORD PTR 00000048[EAX][EBX*8]
00008: 0A8E FF 85 FFFFFEFC              INC DWORD PTR FFFFFEFC[EBP]
00008: 0A94                     L002A:
00008: 0A94 8B 85 FFFFFEFC              MOV EAX, DWORD PTR FFFFFEFC[EBP]
00008: 0A9A 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0A9D 7C FFFFFFC3                 JL L002B

; 1501:     }

00008: 0A9F FF 85 FFFFFF00              INC DWORD PTR FFFFFF00[EBP]
00008: 0AA5                     L0028:
00008: 0AA5 83 BD FFFFFF0003            CMP DWORD PTR FFFFFF00[EBP], 00000003
00008: 0AAC 7C FFFFFF8C                 JL L0029

; 1516:   return;

00000: 0AAE                     L0000:
00000: 0AAE                             epilog 
00000: 0AAE 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0AB1 5E                          POP ESI
00000: 0AB2 5B                          POP EBX
00000: 0AB3 5D                          POP EBP
00000: 0AB4 C3                          RETN 

Function: _main

; 1523: { long ares;

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

; 1525:   if((ares=startup())<1){if(!ares)StopAlert(FILE_ALRT);return;}

00008: 0015 E8 00000000                 CALL SHORT _startup
00008: 001A 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 001D 83 7D FFFFFFF4 01           CMP DWORD PTR FFFFFFF4[EBP], 00000001
00008: 0021 7D 10                       JGE L0001
00008: 0023 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0027 75 08                       JNE L0002
00008: 0029 6A 01                       PUSH 00000001
00008: 002B E8 00000000                 CALL SHORT _StopAlert
00008: 0030 59                          POP ECX
00008: 0031                     L0002:
00000: 0031                             epilog 
00000: 0031 C9                          LEAVE 
00000: 0032 C3                          RETN 
00008: 0033                     L0001:

; 1526:   else if(ares>MOVIE){ares-=MOVIE;text_error_dialog(ares);return;}

00008: 0033 83 7D FFFFFFF4 03           CMP DWORD PTR FFFFFFF4[EBP], 00000003
00008: 0037 7E 0F                       JLE L0003
00008: 0039 83 6D FFFFFFF4 03           SUB DWORD PTR FFFFFFF4[EBP], 00000003
00008: 003D FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0040 E8 00000000                 CALL SHORT _text_error_dialog
00008: 0045 59                          POP ECX
00000: 0046                             epilog 
00000: 0046 C9                          LEAVE 
00000: 0047 C3                          RETN 
00008: 0048                     L0003:

; 1527:   if(ares!=MOVIE)

00008: 0048 83 7D FFFFFFF4 03           CMP DWORD PTR FFFFFFF4[EBP], 00000003
00008: 004C 74 1E                       JE L0004

; 1528:   ct1=squeeze_table(&p1,&q1,&timea); 

00008: 004E 68 00000000                 PUSH OFFSET _timea
00008: 0053 68 00000000                 PUSH OFFSET _q1
00008: 0058 68 00000000                 PUSH OFFSET _p1
00008: 005D E8 00000000                 CALL SHORT _squeeze_table
00008: 0062 83 C4 0C                    ADD ESP, 0000000C
00008: 0065 A3 00000000                 MOV DWORD PTR _ct1, EAX
00008: 006A EB 02                       JMP L0005
00008: 006C                     L0004:

; 1530:   return;

00000: 006C                             epilog 
00000: 006C C9                          LEAVE 
00000: 006D C3                          RETN 
00008: 006E                     L0005:

; 1531:   event_loop(options_dialog());

00008: 006E E8 00000000                 CALL SHORT _options_dialog
00007: 0073 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]
00008: 0076 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0079 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 007C E8 00000000                 CALL SHORT _event_loop
00008: 0081 59                          POP ECX
00008: 0082 59                          POP ECX

; 1533:   writetext(text_name); 

00008: 0083 A1 00000000                 MOV EAX, DWORD PTR _text_name
00008: 0088 50                          PUSH EAX
00008: 0089 E8 00000000                 CALL SHORT _writetext
00008: 008E 59                          POP ECX

; 1534:   if(is_open){fclose(echo_path);}

00008: 008F 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 0096 74 0C                       JE L0006
00008: 0098 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 009D 50                          PUSH EAX
00008: 009E E8 00000000                 CALL SHORT _fclose
00008: 00A3 59                          POP ECX
00008: 00A4                     L0006:

; 1535:   if(m_is_open)closemovie(movie_path);

00008: 00A4 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 00AB 74 0C                       JE L0007
00008: 00AD A1 00000000                 MOV EAX, DWORD PTR _movie_path
00008: 00B2 50                          PUSH EAX
00008: 00B3 E8 00000000                 CALL SHORT _closemovie
00008: 00B8 59                          POP ECX
00008: 00B9                     L0007:

; 1536:   close_corr_func();

00008: 00B9 E8 00000000                 CALL SHORT _close_corr_func

; 1537:   close_rms();

00008: 00BE E8 00000000                 CALL SHORT _close_rms

; 1540: }

00000: 00C3                     L0000:
00000: 00C3                             epilog 
00000: 00C3 C9                          LEAVE 
00000: 00C4 C3                          RETN 

Function: _event_loop

; 1544: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1545:   while ((get_time()<maxtime)||coll_type) 

00008: 0003 E9 00000080                 JMP L0001
00008: 0008                     L0002:

; 1548:       coll_type=collision();

00008: 0008 E8 00000000                 CALL SHORT _collision
00008: 000D A3 00000000                 MOV DWORD PTR _coll_type, EAX

; 1549:       update_table(p1,q1,ct1);

00008: 0012 A1 00000000                 MOV EAX, DWORD PTR _ct1
00008: 0017 50                          PUSH EAX
00008: 0018 A1 00000000                 MOV EAX, DWORD PTR _q1
00008: 001D 50                          PUSH EAX
00008: 001E A1 00000000                 MOV EAX, DWORD PTR _p1
00008: 0023 50                          PUSH EAX
00008: 0024 E8 00000000                 CALL SHORT _update_table
00008: 0029 83 C4 0C                    ADD ESP, 0000000C

; 1550:       rms();

00008: 002C E8 00000000                 CALL SHORT _rms

; 1551:       if((corr_2>1.0e1)||(corr_2<1.0e-1))

00008: 0031 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 0037 DD 05 00000000              FLD QWORD PTR .data+00000210
00006: 003D F1DF                        FCOMIP ST, ST(1), L0003
00007: 003F DD D8                       FSTP ST
00008: 0041 7A 02                       JP L0007
00008: 0043 72 14                       JB L0003
00008: 0045                     L0007:
00008: 0045 DD 05 00000000              FLD QWORD PTR _corr_2
00007: 004B DD 05 00000000              FLD QWORD PTR .data+00000218
00006: 0051 F1DF                        FCOMIP ST, ST(1), L0004
00007: 0053 DD D8                       FSTP ST
00008: 0055 7A 15                       JP L0004
00008: 0057 76 13                       JBE L0004
00008: 0059                     L0003:

; 1552: 	if(!coll_type)

00008: 0059 83 3D 00000000 00           CMP DWORD PTR _coll_type, 00000000
00008: 0060 75 0A                       JNE L0005

; 1553: 	  if(!cleanup())break;

00008: 0062 E8 00000000                 CALL SHORT _cleanup
00008: 0067 83 F8 00                    CMP EAX, 00000000
00008: 006A 74 3D                       JE L0006
00008: 006C                     L0005:
00008: 006C                     L0004:

; 1555:       ct1=squeeze_table(&p1,&q1,&timea);

00008: 006C 68 00000000                 PUSH OFFSET _timea
00008: 0071 68 00000000                 PUSH OFFSET _q1
00008: 0076 68 00000000                 PUSH OFFSET _p1
00008: 007B E8 00000000                 CALL SHORT _squeeze_table
00008: 0080 83 C4 0C                    ADD ESP, 0000000C
00008: 0083 A3 00000000                 MOV DWORD PTR _ct1, EAX

; 1557:     }

00008: 0088                     L0001:
00008: 0088 E8 00000000                 CALL SHORT _get_time
00007: 008D DD 45 08                    FLD QWORD PTR 00000008[EBP]
00006: 0090 F1DF                        FCOMIP ST, ST(1), L0002
00007: 0092 DD D8                       FSTP ST
00008: 0094 7A 06                       JP L0008
00008: 0096 0F 87 FFFFFF6C              JA L0002
00008: 009C                     L0008:
00008: 009C 83 3D 00000000 00           CMP DWORD PTR _coll_type, 00000000
00008: 00A3 0F 85 FFFFFF5F              JNE L0002
00008: 00A9                     L0006:

; 1558: }

00000: 00A9                     L0000:
00000: 00A9                             epilog 
00000: 00A9 C9                          LEAVE 
00000: 00AA C3                          RETN 

Function: _readfile

; 1561: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 1572:   fname=JAVA_FILENAME;//Modified 8/27 AB to avoid using sio

00008: 0012 A1 00000000                 MOV EAX, DWORD PTR _JAVA_FILENAME
00008: 0017 89 45 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EAX

; 1573:   path=fopen(fname,"rb");

00008: 001A 68 00000000                 PUSH OFFSET @930
00008: 001F FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0022 E8 00000000                 CALL SHORT _fopen
00008: 0027 59                          POP ECX
00008: 0028 59                          POP ECX
00008: 0029 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 1574:   if(!path) return 0;

00008: 002C 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0030 75 07                       JNE L0001
00008: 0032 B8 00000000                 MOV EAX, 00000000
00000: 0037                             epilog 
00000: 0037 C9                          LEAVE 
00000: 0038 C3                          RETN 
00008: 0039                     L0001:

; 1575:   text_path=path;return TEXT;

00008: 0039 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 003C A3 00000000                 MOV DWORD PTR _text_path, EAX
00008: 0041 B8 00000002                 MOV EAX, 00000002
00000: 0046                     L0000:
00000: 0046                             epilog 
00000: 0046 C9                          LEAVE 
00000: 0047 C3                          RETN 

Function: _get_atom

; 1578: atom * get_atom(void){return a;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1578: atom * get_atom(void){return a;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _a
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_atom_number

; 1579: int get_atom_number(void){return n1;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1579: int get_atom_number(void){return n1;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _n1
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_dimension

; 1580: int get_dimension(void){return (int)dim;}

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

; 1580: int get_dimension(void){return (int)dim;}

00008: 0015 DD 05 00000000              FLD QWORD PTR _dim
00007: 001B D9 7D FFFFFFF4              FNSTCW WORD PTR FFFFFFF4[EBP]
00007: 001E 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00007: 0021 80 4D FFFFFFF5 0C           OR BYTE PTR FFFFFFF5[EBP], 0C
00007: 0025 D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00007: 0028 DB 5D FFFFFFF8              FISTP DWORD PTR FFFFFFF8[EBP]
00008: 002B 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX
00008: 002E D9 6D FFFFFFF4              FLDCW WORD PTR FFFFFFF4[EBP]
00008: 0031 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00000: 0034                     L0000:
00000: 0034                             epilog 
00000: 0034 C9                          LEAVE 
00000: 0035 C3                          RETN 

Function: _get_bounds

; 1581: dimensions * get_bounds(void){return &bound[0];}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1581: dimensions * get_bounds(void){return &bound[0];}

00008: 0003 B8 00000000                 MOV EAX, OFFSET _bound
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_movie_dt

; 1582: double get_movie_dt(void){return delta3;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1582: double get_movie_dt(void){return delta3;}

00008: 0003 DD 05 00000000              FLD QWORD PTR _delta3
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _is_reaction

; 1583: int is_reaction(well_type k){int i=coll[k].react;return i>-1?i:~i;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 08                    SUB ESP, 00000008
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0010 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0014                             prolog 

; 1583: int is_reaction(well_type k){int i=coll[k].react;return i>-1?i:~i;}

00008: 0014 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 0017 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 001A 8B 1D 00000000              MOV EBX, DWORD PTR _coll
00008: 0020 8B 44 F3 40                 MOV EAX, DWORD PTR 00000040[EBX][ESI*8]
00008: 0024 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 0027 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 002B 7E 05                       JLE L0001
00008: 002D 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0030 EB 05                       JMP L0002
00008: 0032                     L0001:
00008: 0032 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0035 F7 D0                       NOT EAX
00008: 0037                     L0002:
00000: 0037                     L0000:
00000: 0037                             epilog 
00000: 0037 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 003A 5E                          POP ESI
00000: 003B 5B                          POP EBX
00000: 003C 5D                          POP EBP
00000: 003D C3                          RETN 

Function: _is_bond

; 1584: int is_bond(well_type k){int i=coll[k].react;return (int)(i<0);} 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 08                    SUB ESP, 00000008
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0010 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0014                             prolog 

; 1584: int is_bond(well_type k){int i=coll[k].react;return (int)(i<0);} 

00008: 0014 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 0017 8D 34 F6                    LEA ESI, DWORD PTR 00000000[ESI][ESI*8]
00008: 001A 8B 1D 00000000              MOV EBX, DWORD PTR _coll
00008: 0020 8B 44 F3 40                 MOV EAX, DWORD PTR 00000040[EBX][ESI*8]
00008: 0024 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 0027 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 002B 0F 9C C0                    SETL AL
00008: 002E 83 E0 01                    AND EAX, 00000001
00000: 0031                     L0000:
00000: 0031                             epilog 
00000: 0031 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0034 5E                          POP ESI
00000: 0035 5B                          POP EBX
00000: 0036 5D                          POP EBP
00000: 0037 C3                          RETN 

Function: _is_internal

; 1585: int is_internal(well_type k){return coll[k].prev==-1?0:1;} 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004                             prolog 

; 1585: int is_internal(well_type k){return coll[k].prev==-1?0:1;} 

00008: 0004 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0007 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 000A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0010 83 7C DA 3C FFFFFFFF        CMP DWORD PTR 0000003C[EDX][EBX*8], FFFFFFFF
00008: 0015 75 07                       JNE L0001
00008: 0017 B8 00000000                 MOV EAX, 00000000
00008: 001C EB 05                       JMP L0002
00008: 001E                     L0001:
00008: 001E B8 00000001                 MOV EAX, 00000001
00008: 0023                     L0002:
00000: 0023                     L0000:
00000: 0023                             epilog 
00000: 0023 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0026 5B                          POP EBX
00000: 0027 5D                          POP EBP
00000: 0028 C3                          RETN 

Function: _etot

; 1586: double etot(well_type k){return coll[k].etot;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004                             prolog 

; 1586: double etot(well_type k){return coll[k].etot;}

00008: 0004 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0007 8D 1C DB                    LEA EBX, DWORD PTR 00000000[EBX][EBX*8]
00008: 000A 8B 15 00000000              MOV EDX, DWORD PTR _coll
00008: 0010 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00000: 0014                     L0000:
00000: 0014                             epilog 
00000: 0014 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0017 5B                          POP EBX
00000: 0018 5D                          POP EBP
00000: 0019 C3                          RETN 

Function: _get_corr

; 1587: double get_corr(void){return 1/corr_2;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1587: double get_corr(void){return 1/corr_2;}

00008: 0003 DD 05 00000000              FLD QWORD PTR .data+00000090
00007: 0009 DC 35 00000000              FDIV QWORD PTR _corr_2
00000: 000F                     L0000:
00000: 000F                             epilog 
00000: 000F C9                          LEAVE 
00000: 0010 C3                          RETN 

Function: _get_ll

; 1588: long get_ll(void){return ll;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 1588: long get_ll(void){return ll;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _ll
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 
