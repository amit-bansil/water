
Function: _initsearch

; 17: { 

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

; 20:   long n=search.n;

00008: 0018 0F BF 15 00000042           MOVSX EDX, WORD PTR _search+00000042
00008: 001F 89 55 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EDX

; 21:   tlist * tc=search.storage;

00008: 0022 A1 00000010                 MOV EAX, DWORD PTR _search+00000010
00008: 0027 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 22:   tlist ** ptc=search.begin;

00008: 002A A1 00000004                 MOV EAX, DWORD PTR _search+00000004
00008: 002F 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 23:   for (i=0;i<n;i++)

00008: 0032 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0039 EB 12                       JMP L0001
00008: 003B                     L0002:

; 24:     search.collp[i]=-1;

00008: 003B 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 0041 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0044 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF
00008: 004A FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 004D                     L0001:
00008: 004D 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0050 3B 45 FFFFFFF0              CMP EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0053 7C FFFFFFE6                 JL L0002

; 25:   for (i=0;i<n;i++)

00008: 0055 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 005C EB 12                       JMP L0003
00008: 005E                     L0004:

; 26:     search.collq[i]=-1;

00008: 005E 8B 15 00000034              MOV EDX, DWORD PTR _search+00000034
00008: 0064 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0067 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF
00008: 006D FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 0070                     L0003:
00008: 0070 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0073 3B 45 FFFFFFF0              CMP EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0076 7C FFFFFFE6                 JL L0004

; 27:   search.np=0;

00008: 0078 66 C7 05 0000003E 0000      MOV WORD PTR _search+0000003E, 0000

; 28:   search.nq=0;

00008: 0081 66 C7 05 00000040 0000      MOV WORD PTR _search+00000040, 0000

; 29:   for(i=0;i<search.maxfree;i++)ptc[i]=&tc[i];

00008: 008A C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0091 EB 1C                       JMP L0005
00008: 0093                     L0006:
00008: 0093 8B 5D FFFFFFEC              MOV EBX, DWORD PTR FFFFFFEC[EBP]
00008: 0096 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 009D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00A0 03 5D FFFFFFF4              ADD EBX, DWORD PTR FFFFFFF4[EBP]
00008: 00A3 8B 4D FFFFFFEC              MOV ECX, DWORD PTR FFFFFFEC[EBP]
00008: 00A6 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 00A9 89 1C 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EBX
00008: 00AC FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 00AF                     L0005:
00008: 00AF 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00B2 3B 05 00000014              CMP EAX, DWORD PTR _search+00000014
00008: 00B8 7C FFFFFFD9                 JL L0006

; 30:   ptc[search.maxfree]=NULL;

00008: 00BA 8B 15 00000014              MOV EDX, DWORD PTR _search+00000014
00008: 00C0 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 00C3 C7 04 90 00000000           MOV DWORD PTR 00000000[EAX][EDX*4], 00000000

; 31:   search.free=(search.begin)+1;

00008: 00CA 8B 15 00000004              MOV EDX, DWORD PTR _search+00000004
00008: 00D0 83 C2 04                    ADD EDX, 00000004
00008: 00D3 89 15 00000008              MOV DWORD PTR _search+00000008, EDX

; 32:   inpt=*(search.begin);

00008: 00D9 8B 15 00000004              MOV EDX, DWORD PTR _search+00000004
00008: 00DF 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 00E1 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 33:   for(i=0;i<=search.z;i++)

00008: 00E4 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 00EB EB 12                       JMP L0007
00008: 00ED                     L0008:

; 34:     search.inpt[i]=inpt;

00008: 00ED 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 00F3 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 00F6 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00F9 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX
00008: 00FC FF 45 FFFFFFEC              INC DWORD PTR FFFFFFEC[EBP]
00008: 00FF                     L0007:
00008: 00FF 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0102 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0108 7E FFFFFFE3                 JLE L0008

; 35:   inpt->dt.t=dblarg2;

00008: 010A DD 05 00000000              FLD QWORD PTR _dblarg2
00007: 0110 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00007: 0113 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 36:   inpt->dt.p=-1;

00008: 0115 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0118 66 C7 40 08 FFFFFFFF        MOV WORD PTR 00000008[EAX], FFFFFFFF

; 37:   inpt->dt.q=-1; 

00008: 011E 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0121 66 C7 40 0A FFFFFFFF        MOV WORD PTR 0000000A[EAX], FFFFFFFF

; 38:   inpt->pt=NULL;

00008: 0127 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 012A C7 40 10 00000000           MOV DWORD PTR 00000010[EAX], 00000000

; 39: }   

00000: 0131                     L0000:
00000: 0131                             epilog 
00000: 0131 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0134 5B                          POP EBX
00000: 0135 5D                          POP EBP
00000: 0136 C3                          RETN 

Function: _allocsearch

; 43: {

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

; 47:  search.x=bound[0].period;

00008: 0017 8B 15 00000010              MOV EDX, DWORD PTR _bound+00000010
00008: 001D 89 15 0000001C              MOV DWORD PTR _search+0000001C, EDX

; 48:  search.y=search.x*bound[1].period;

00008: 0023 8B 15 0000001C              MOV EDX, DWORD PTR _search+0000001C
00008: 0029 0F AF 15 00000028           IMUL EDX, DWORD PTR _bound+00000028
00008: 0030 89 15 00000020              MOV DWORD PTR _search+00000020, EDX

; 49:  search.z=search.y*bound[2].period;

00008: 0036 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 003C 0F AF 15 00000040           IMUL EDX, DWORD PTR _bound+00000040
00008: 0043 89 15 00000024              MOV DWORD PTR _search+00000024, EDX

; 50:  maxadd=search.z;

00008: 0049 A1 00000024                 MOV EAX, DWORD PTR _search+00000024
00008: 004E 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 51:  search.n=n;     

00008: 0051 66 8B 45 08                 MOV AX, WORD PTR 00000008[EBP]
00008: 0055 66 A3 00000042              MOV WORD PTR _search+00000042, AX

; 52:  if(maxadd>MAXADD)return 0;

00008: 005B 81 7D FFFFFFF0 00400000     CMP DWORD PTR FFFFFFF0[EBP], 00400000
00008: 0062 7E 0D                       JLE L0001
00008: 0064 B8 00000000                 MOV EAX, 00000000
00000: 0069                             epilog 
00000: 0069 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 006C 5F                          POP EDI
00000: 006D 5E                          POP ESI
00000: 006E 5B                          POP EBX
00000: 006F 5D                          POP EBP
00000: 0070 C3                          RETN 
00008: 0071                     L0001:

; 54:  if(!(search.collp=(short *)malloc(n*sizeof(short))))return 0;

00008: 0071 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0074 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 007B 52                          PUSH EDX
00008: 007C E8 00000000                 CALL SHORT _malloc
00008: 0081 59                          POP ECX
00008: 0082 A3 00000030                 MOV DWORD PTR _search+00000030, EAX
00008: 0087 83 3D 00000030 00           CMP DWORD PTR _search+00000030, 00000000
00008: 008E 75 0D                       JNE L0002
00008: 0090 B8 00000000                 MOV EAX, 00000000
00000: 0095                             epilog 
00000: 0095 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0098 5F                          POP EDI
00000: 0099 5E                          POP ESI
00000: 009A 5B                          POP EBX
00000: 009B 5D                          POP EBP
00000: 009C C3                          RETN 
00008: 009D                     L0002:

; 55:  if(!(search.collq=(short *)malloc(n*sizeof(short))))return 0;

00008: 009D 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00A0 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00A7 52                          PUSH EDX
00008: 00A8 E8 00000000                 CALL SHORT _malloc
00008: 00AD 59                          POP ECX
00008: 00AE A3 00000034                 MOV DWORD PTR _search+00000034, EAX
00008: 00B3 83 3D 00000034 00           CMP DWORD PTR _search+00000034, 00000000
00008: 00BA 75 0D                       JNE L0003
00008: 00BC B8 00000000                 MOV EAX, 00000000
00000: 00C1                             epilog 
00000: 00C1 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00C4 5F                          POP EDI
00000: 00C5 5E                          POP ESI
00000: 00C6 5B                          POP EBX
00000: 00C7 5D                          POP EBP
00000: 00C8 C3                          RETN 
00008: 00C9                     L0003:

; 57:  if(!(search.atomp=(short *)malloc(n*sizeof(short))))return 0;    

00008: 00C9 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00CC 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00D3 52                          PUSH EDX
00008: 00D4 E8 00000000                 CALL SHORT _malloc
00008: 00D9 59                          POP ECX
00008: 00DA A3 00000028                 MOV DWORD PTR _search+00000028, EAX
00008: 00DF 83 3D 00000028 00           CMP DWORD PTR _search+00000028, 00000000
00008: 00E6 75 0D                       JNE L0004
00008: 00E8 B8 00000000                 MOV EAX, 00000000
00000: 00ED                             epilog 
00000: 00ED 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00F0 5F                          POP EDI
00000: 00F1 5E                          POP ESI
00000: 00F2 5B                          POP EBX
00000: 00F3 5D                          POP EBP
00000: 00F4 C3                          RETN 
00008: 00F5                     L0004:

; 58:  if(!(search.atomq=(short *)malloc(n*sizeof(short))))return 0;

00008: 00F5 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00F8 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00FF 52                          PUSH EDX
00008: 0100 E8 00000000                 CALL SHORT _malloc
00008: 0105 59                          POP ECX
00008: 0106 A3 0000002C                 MOV DWORD PTR _search+0000002C, EAX
00008: 010B 83 3D 0000002C 00           CMP DWORD PTR _search+0000002C, 00000000
00008: 0112 75 0D                       JNE L0005
00008: 0114 B8 00000000                 MOV EAX, 00000000
00000: 0119                             epilog 
00000: 0119 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 011C 5F                          POP EDI
00000: 011D 5E                          POP ESI
00000: 011E 5B                          POP EBX
00000: 011F 5D                          POP EBP
00000: 0120 C3                          RETN 
00008: 0121                     L0005:

; 61:  if(!(ptc=(tlist **)malloc((maxadd+1)*sizeof(tlist *))))return 0;

00008: 0121 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0124 42                          INC EDX
00008: 0125 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 012C 52                          PUSH EDX
00008: 012D E8 00000000                 CALL SHORT _malloc
00008: 0132 59                          POP ECX
00008: 0133 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX
00008: 0136 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 013A 75 0D                       JNE L0006
00008: 013C B8 00000000                 MOV EAX, 00000000
00000: 0141                             epilog 
00000: 0141 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0144 5F                          POP EDI
00000: 0145 5E                          POP ESI
00000: 0146 5B                          POP EBX
00000: 0147 5D                          POP EBP
00000: 0148 C3                          RETN 
00008: 0149                     L0006:

; 62:  search.inpt=ptc;

00008: 0149 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 014C A3 0000000C                 MOV DWORD PTR _search+0000000C, EAX

; 63:  if(!search.maxfree)search.maxfree=NFREE;

00008: 0151 83 3D 00000014 00           CMP DWORD PTR _search+00000014, 00000000
00008: 0158 75 0A                       JNE L0007
00008: 015A C7 05 00000014 00030D40     MOV DWORD PTR _search+00000014, 00030D40
00008: 0164                     L0007:

; 64:  if(!(tc =(tlist *)malloc(search.maxfree*sizeof(tlist))))return 0;

00008: 0164 8B 1D 00000014              MOV EBX, DWORD PTR _search+00000014
00008: 016A 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 0171 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0174 53                          PUSH EBX
00008: 0175 E8 00000000                 CALL SHORT _malloc
00008: 017A 59                          POP ECX
00008: 017B 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 017E 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0182 75 0D                       JNE L0008
00008: 0184 B8 00000000                 MOV EAX, 00000000
00000: 0189                             epilog 
00000: 0189 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 018C 5F                          POP EDI
00000: 018D 5E                          POP ESI
00000: 018E 5B                          POP EBX
00000: 018F 5D                          POP EBP
00000: 0190 C3                          RETN 
00008: 0191                     L0008:

; 65:  search.storage=tc;

00008: 0191 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0194 A3 00000010                 MOV DWORD PTR _search+00000010, EAX

; 67:  if(!(ptc=(tlist **)malloc((search.maxfree+1)*sizeof(tlist *))))return 0;

00008: 0199 8B 15 00000014              MOV EDX, DWORD PTR _search+00000014
00008: 019F 42                          INC EDX
00008: 01A0 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 01A7 52                          PUSH EDX
00008: 01A8 E8 00000000                 CALL SHORT _malloc
00008: 01AD 59                          POP ECX
00008: 01AE 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX
00008: 01B1 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 01B5 75 0D                       JNE L0009
00008: 01B7 B8 00000000                 MOV EAX, 00000000
00000: 01BC                             epilog 
00000: 01BC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01BF 5F                          POP EDI
00000: 01C0 5E                          POP ESI
00000: 01C1 5B                          POP EBX
00000: 01C2 5D                          POP EBP
00000: 01C3 C3                          RETN 
00008: 01C4                     L0009:

; 68:  search.begin=ptc;

00008: 01C4 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 01C7 A3 00000004                 MOV DWORD PTR _search+00000004, EAX

; 70:  k=0;

00008: 01CC C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000

; 71:  j=maxadd;

00008: 01D3 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 01D6 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 72:  level=0;

00008: 01D9 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000

; 74:  do

00008: 01E0                     L000A:

; 75:  { j=(j>>1)+(j&1);

00008: 01E0 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 01E3 D1 F9                       SAR ECX, 00000001
00008: 01E5 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 01E8 83 E2 01                    AND EDX, 00000001
00008: 01EB 01 D1                       ADD ECX, EDX
00008: 01ED 89 4D FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], ECX

; 76:    k+=j;

00008: 01F0 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 01F3 03 45 FFFFFFDC              ADD EAX, DWORD PTR FFFFFFDC[EBP]
00008: 01F6 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 77:    level++;

00008: 01F9 FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]

; 78:   }while(j>1);

00008: 01FC 83 7D FFFFFFDC 01           CMP DWORD PTR FFFFFFDC[EBP], 00000001
00008: 0200 7F FFFFFFDE                 JG L000A

; 80:   search.final=level;

00008: 0202 66 8B 45 FFFFFFE4           MOV AX, WORD PTR FFFFFFE4[EBP]
00008: 0206 66 A3 0000003C              MOV WORD PTR _search+0000003C, AX

; 81:   search.olymp=(size_al **)malloc((level+1)*sizeof(size_al *));

00008: 020C 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 020F 42                          INC EDX
00008: 0210 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0217 52                          PUSH EDX
00008: 0218 E8 00000000                 CALL SHORT _malloc
00008: 021D 59                          POP ECX
00008: 021E A3 00000000                 MOV DWORD PTR _search, EAX

; 82:   if(!(search.olymp))return 0;

00008: 0223 83 3D 00000000 00           CMP DWORD PTR _search, 00000000
00008: 022A 75 0D                       JNE L000B
00008: 022C B8 00000000                 MOV EAX, 00000000
00000: 0231                             epilog 
00000: 0231 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0234 5F                          POP EDI
00000: 0235 5E                          POP ESI
00000: 0236 5B                          POP EBX
00000: 0237 5D                          POP EBP
00000: 0238 C3                          RETN 
00008: 0239                     L000B:

; 83:   search.olymp[0]=(size_al *)malloc((k+1)*sizeof(size_al));

00008: 0239 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 023C 42                          INC EDX
00008: 023D 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0244 52                          PUSH EDX
00008: 0245 E8 00000000                 CALL SHORT _malloc
00008: 024A 59                          POP ECX
00008: 024B 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0251 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 84:     if(!(search.olymp[0]))return 0;

00008: 0253 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0259 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 025C 75 0D                       JNE L000C
00008: 025E B8 00000000                 MOV EAX, 00000000
00000: 0263                             epilog 
00000: 0263 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0266 5F                          POP EDI
00000: 0267 5E                          POP ESI
00000: 0268 5B                          POP EBX
00000: 0269 5D                          POP EBP
00000: 026A C3                          RETN 
00008: 026B                     L000C:

; 85:   j=maxadd;

00008: 026B 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 026E 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 86:   level=0;

00008: 0271 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000

; 88:   while(j>1)

00008: 0278 EB 36                       JMP L000D
00008: 027A                     L000E:

; 90:    j=(j>>1)+(j&1);

00008: 027A 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 027D D1 F9                       SAR ECX, 00000001
00008: 027F 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0282 83 E2 01                    AND EDX, 00000001
00008: 0285 01 D1                       ADD ECX, EDX
00008: 0287 89 4D FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], ECX

; 91:    search.olymp[level+1]=search.olymp[level]+j;

00008: 028A 8B 75 FFFFFFDC              MOV ESI, DWORD PTR FFFFFFDC[EBP]
00008: 028D 8D 34 B5 00000000           LEA ESI, [00000000][ESI*4]
00008: 0294 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 029A 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 029D 03 34 83                    ADD ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 02A0 8B 7D FFFFFFE4              MOV EDI, DWORD PTR FFFFFFE4[EBP]
00008: 02A3 47                          INC EDI
00008: 02A4 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 02AA 89 34 BB                    MOV DWORD PTR 00000000[EBX][EDI*4], ESI

; 92:    level++;

00008: 02AD FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]

; 93:    }

00008: 02B0                     L000D:
00008: 02B0 83 7D FFFFFFDC 01           CMP DWORD PTR FFFFFFDC[EBP], 00000001
00008: 02B4 7F FFFFFFC4                 JG L000E

; 95:    search.change=(size_al *)malloc(46*sizeof(size_al));

00008: 02B6 68 000000B8                 PUSH 000000B8
00008: 02BB E8 00000000                 CALL SHORT _malloc
00008: 02C0 59                          POP ECX
00008: 02C1 A3 00000038                 MOV DWORD PTR _search+00000038, EAX

; 96:     if(!(search.change))return 0;

00008: 02C6 83 3D 00000038 00           CMP DWORD PTR _search+00000038, 00000000
00008: 02CD 75 0D                       JNE L000F
00008: 02CF B8 00000000                 MOV EAX, 00000000
00000: 02D4                             epilog 
00000: 02D4 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02D7 5F                          POP EDI
00000: 02D8 5E                          POP ESI
00000: 02D9 5B                          POP EBX
00000: 02DA 5D                          POP EBP
00000: 02DB C3                          RETN 
00008: 02DC                     L000F:

; 97:  return 1;

00008: 02DC B8 00000001                 MOV EAX, 00000001
00000: 02E1                     L0000:
00000: 02E1                             epilog 
00000: 02E1 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02E4 5F                          POP EDI
00000: 02E5 5E                          POP ESI
00000: 02E6 5B                          POP EBX
00000: 02E7 5D                          POP EBP
00000: 02E8 C3                          RETN 

Function: _find_atoms

; 100: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 48                    SUB ESP, 00000048
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 00000012                 MOV ECX, 00000012
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 102:  long np=search.np;

00008: 0018 0F BF 15 0000003E           MOVSX EDX, WORD PTR _search+0000003E
00008: 001F 89 55 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EDX

; 106:   i1=a[p1].i.x.i-1;

00008: 0022 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0025 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 002C 29 D3                       SUB EBX, EDX
00008: 002E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0031 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0037 8B 54 DE 30                 MOV EDX, DWORD PTR 00000030[ESI][EBX*8]
00008: 003B 4A                          DEC EDX
00008: 003C 89 55 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EDX

; 107:   j1=(a[p1].i.y.i-1)*search.x;

00008: 003F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0042 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0049 29 D3                       SUB EBX, EDX
00008: 004B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 004E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0054 8B 54 DE 38                 MOV EDX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0058 4A                          DEC EDX
00008: 0059 0F AF 15 0000001C           IMUL EDX, DWORD PTR _search+0000001C
00008: 0060 89 55 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EDX

; 108:   i2=i1+2;

00008: 0063 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 0066 83 C2 02                    ADD EDX, 00000002
00008: 0069 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 109:   j2=j1+(search.x<<1);

00008: 006C 8B 15 0000001C              MOV EDX, DWORD PTR _search+0000001C
00008: 0072 D1 E2                       SHL EDX, 00000001
00008: 0074 03 55 FFFFFFC8              ADD EDX, DWORD PTR FFFFFFC8[EBP]
00008: 0077 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 110:   if(search.z==search.y)

00008: 007A 8B 0D 00000024              MOV ECX, DWORD PTR _search+00000024
00008: 0080 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 0086 39 D1                       CMP ECX, EDX
00008: 0088 75 2B                       JNE L0001

; 111:   {k1=a[p1].i.z.i*search.y;k2=k1;}

00008: 008A 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 008D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0094 29 D3                       SUB EBX, EDX
00008: 0096 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0099 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 009F 8B 35 00000020              MOV ESI, DWORD PTR _search+00000020
00008: 00A5 0F AF 74 DF 40              IMUL ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 00AA 89 75 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], ESI
00008: 00AD 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00B0 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX
00008: 00B3 EB 32                       JMP L0002
00008: 00B5                     L0001:

; 113:   {k1=(a[p1].i.z.i-1)*search.y;k2=k1+(search.y<<1);}

00008: 00B5 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00B8 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00BF 29 D3                       SUB EBX, EDX
00008: 00C1 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00C4 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00CA 8B 54 DE 40                 MOV EDX, DWORD PTR 00000040[ESI][EBX*8]
00008: 00CE 4A                          DEC EDX
00008: 00CF 0F AF 15 00000020           IMUL EDX, DWORD PTR _search+00000020
00008: 00D6 89 55 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EDX
00008: 00D9 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 00DF D1 E2                       SHL EDX, 00000001
00008: 00E1 03 55 FFFFFFCC              ADD EDX, DWORD PTR FFFFFFCC[EBP]
00008: 00E4 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 00E7                     L0002:

; 115:   for(k=k1;k<=k2;k+=search.y)

00008: 00E7 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00EA 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX
00008: 00ED E9 0000024B                 JMP L0003
00008: 00F2                     L0004:

; 117:       addressz=k;

00008: 00F2 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 00F5 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 118:       if(addressz<0)addressz+=search.z;

00008: 00F8 83 7D FFFFFFE0 00           CMP DWORD PTR FFFFFFE0[EBP], 00000000
00008: 00FC 7D 0C                       JGE L0005
00008: 00FE 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0101 03 05 00000024              ADD EAX, DWORD PTR _search+00000024
00008: 0107 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX
00008: 010A                     L0005:

; 119:       if(addressz==search.z)addressz=0;

00008: 010A 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 010D 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0113 75 07                       JNE L0006
00008: 0115 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 011C                     L0006:

; 120:       for(j=j1;j<=j2;j+=search.x)

00008: 011C 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 011F 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 0122 E9 000001FE                 JMP L0007
00008: 0127                     L0008:

; 122: 	  addressy=j; 

00008: 0127 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 012A 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 123: 	  if(addressy<0)addressy+=search.y;

00008: 012D 83 7D FFFFFFE4 00           CMP DWORD PTR FFFFFFE4[EBP], 00000000
00008: 0131 7D 0C                       JGE L0009
00008: 0133 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0136 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 013C 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00008: 013F                     L0009:

; 124: 	  if(addressy==search.y)addressy=0;

00008: 013F 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0142 3B 05 00000020              CMP EAX, DWORD PTR _search+00000020
00008: 0148 75 07                       JNE L000A
00008: 014A C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 0151                     L000A:

; 125: 	  addressy+=addressz;

00008: 0151 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0154 03 45 FFFFFFE0              ADD EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0157 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 126: 	  for(i=i1;i<=i2;i++)

00008: 015A 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 015D 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX
00008: 0160 E9 000001A8                 JMP L000B
00008: 0165                     L000C:

; 128: 	      address=i; 

00008: 0165 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0168 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 129: 	      if(address<0)address+=search.x;

00008: 016B 83 7D FFFFFFDC 00           CMP DWORD PTR FFFFFFDC[EBP], 00000000
00008: 016F 7D 0C                       JGE L000D
00008: 0171 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0174 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 017A 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX
00008: 017D                     L000D:

; 130: 	      if(address==search.x)address=0;

00008: 017D 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0180 3B 05 0000001C              CMP EAX, DWORD PTR _search+0000001C
00008: 0186 75 07                       JNE L000E
00008: 0188 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 018F                     L000E:

; 131: 	      address+=addressy;

00008: 018F 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0192 03 45 FFFFFFE4              ADD EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0195 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 132: 	      for(inpt=search.inpt[address];inpt;inpt=inpt->pt)

00008: 0198 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 019E 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 01A1 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 01A4 89 45 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], EAX
00008: 01A7 E9 00000154                 JMP L000F
00008: 01AC                     L0010:

; 135: 	   if(p1==inpt->dt.p)

00008: 01AC 8B 45 FFFFFFB0              MOV EAX, DWORD PTR FFFFFFB0[EBP]
00008: 01AF 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 01B3 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 01B6 75 4D                       JNE L0011

; 137: 	     short p2=inpt->dt.q;

00008: 01B8 8B 4D FFFFFFB0              MOV ECX, DWORD PTR FFFFFFB0[EBP]
00008: 01BB 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 01BF 66 89 45 FFFFFFE8           MOV WORD PTR FFFFFFE8[EBP], AX

; 138: 	     if(p2<search.n)

00008: 01C3 66 8B 45 FFFFFFE8           MOV AX, WORD PTR FFFFFFE8[EBP]
00008: 01C7 66 3B 05 00000042           CMP AX, WORD PTR _search+00000042
00008: 01CE 7D 35                       JGE L0012

; 140: 	     if(search.collp[p2]==-1)search.atomp[np++]=p2;

00008: 01D0 0F BF 5D FFFFFFE8           MOVSX EBX, WORD PTR FFFFFFE8[EBP]
00008: 01D4 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 01DA 66 83 3C 5A FFFFFFFF        CMP WORD PTR 00000000[EDX][EBX*2], FFFFFFFF
00008: 01DF 75 14                       JNE L0013
00008: 01E1 8B 75 FFFFFFB4              MOV ESI, DWORD PTR FFFFFFB4[EBP]
00008: 01E4 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 01E7 8B 1D 00000028              MOV EBX, DWORD PTR _search+00000028
00008: 01ED 66 8B 45 FFFFFFE8           MOV AX, WORD PTR FFFFFFE8[EBP]
00008: 01F1 66 89 04 73                 MOV WORD PTR 00000000[EBX][ESI*2], AX
00008: 01F5                     L0013:

; 141: 	     search.collp[p2]=-2;

00008: 01F5 0F BF 5D FFFFFFE8           MOVSX EBX, WORD PTR FFFFFFE8[EBP]
00008: 01F9 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 01FF 66 C7 04 5A FFFFFFFE        MOV WORD PTR 00000000[EDX][EBX*2], FFFFFFFE

; 143: 	      }

00008: 0205                     L0012:

; 144: 	    } 

00008: 0205                     L0011:

; 145: 	   if(p1==inpt->dt.q)

00008: 0205 8B 45 FFFFFFB0              MOV EAX, DWORD PTR FFFFFFB0[EBP]
00008: 0208 0F BF 50 0A                 MOVSX EDX, WORD PTR 0000000A[EAX]
00008: 020C 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 020F 75 40                       JNE L0014

; 147: 	     short p2=inpt->dt.p;

00008: 0211 8B 4D FFFFFFB0              MOV ECX, DWORD PTR FFFFFFB0[EBP]
00008: 0214 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 0218 66 89 45 FFFFFFEC           MOV WORD PTR FFFFFFEC[EBP], AX

; 148: 	     if(search.collp[p2]==-1)search.atomp[np++]=p2;

00008: 021C 0F BF 5D FFFFFFEC           MOVSX EBX, WORD PTR FFFFFFEC[EBP]
00008: 0220 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 0226 66 83 3C 5A FFFFFFFF        CMP WORD PTR 00000000[EDX][EBX*2], FFFFFFFF
00008: 022B 75 14                       JNE L0015
00008: 022D 8B 75 FFFFFFB4              MOV ESI, DWORD PTR FFFFFFB4[EBP]
00008: 0230 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 0233 8B 1D 00000028              MOV EBX, DWORD PTR _search+00000028
00008: 0239 66 8B 45 FFFFFFEC           MOV AX, WORD PTR FFFFFFEC[EBP]
00008: 023D 66 89 04 73                 MOV WORD PTR 00000000[EBX][ESI*2], AX
00008: 0241                     L0015:

; 149: 	     search.collp[p2]=-2;

00008: 0241 0F BF 5D FFFFFFEC           MOVSX EBX, WORD PTR FFFFFFEC[EBP]
00008: 0245 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 024B 66 C7 04 5A FFFFFFFE        MOV WORD PTR 00000000[EDX][EBX*2], FFFFFFFE

; 153: 	    }

00008: 0251                     L0014:

; 154: 	   if(inpt->dt.q>=search.n) /* those atoms who sit there but 

00008: 0251 8B 45 FFFFFFB0              MOV EAX, DWORD PTR FFFFFFB0[EBP]
00008: 0254 66 8B 48 0A                 MOV CX, WORD PTR 0000000A[EAX]
00008: 0258 66 8B 15 00000042           MOV DX, WORD PTR _search+00000042
00008: 025F 66 39 D1                    CMP CX, DX
00008: 0262 0F 8C 0000008F              JL L0016

; 156: 	    { short p2=inpt->dt.p;

00008: 0268 8B 4D FFFFFFB0              MOV ECX, DWORD PTR FFFFFFB0[EBP]
00008: 026B 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 026F 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX

; 157: 	      if((search.collp[p2]==-1)&&(p2!=p1))

00008: 0273 0F BF 5D FFFFFFF0           MOVSX EBX, WORD PTR FFFFFFF0[EBP]
00008: 0277 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 027D 66 83 3C 5A FFFFFFFF        CMP WORD PTR 00000000[EDX][EBX*2], FFFFFFFF
00008: 0282 75 73                       JNE L0017
00008: 0284 0F BF 55 FFFFFFF0           MOVSX EDX, WORD PTR FFFFFFF0[EBP]
00008: 0288 3B 55 08                    CMP EDX, DWORD PTR 00000008[EBP]
00008: 028B 74 6A                       JE L0017

; 159: 	      	search.collp[p2]=ecoll[a[p2].c][a[p1].c];

00008: 028D 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0290 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0297 29 D3                       SUB EBX, EDX
00008: 0299 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 029C 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 02A2 0F BF 8C DE 000000A4        MOVSX ECX, WORD PTR 000000A4[ESI][EBX*8]
00008: 02AA 0F BF 55 FFFFFFF0           MOVSX EDX, WORD PTR FFFFFFF0[EBP]
00008: 02AE 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 02B5 29 D3                       SUB EBX, EDX
00008: 02B7 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02BA 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 02C0 0F BF B4 DE 000000A4        MOVSX ESI, WORD PTR 000000A4[ESI][EBX*8]
00008: 02C8 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 02CE 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 02D1 0F BF 7D FFFFFFF0           MOVSX EDI, WORD PTR FFFFFFF0[EBP]
00008: 02D5 8B 35 00000030              MOV ESI, DWORD PTR _search+00000030
00008: 02DB 66 8B 1C 8B                 MOV BX, WORD PTR 00000000[EBX][ECX*4]
00008: 02DF 66 89 1C 7E                 MOV WORD PTR 00000000[ESI][EDI*2], BX

; 160: 	       search.atomp[np++]=p2;

00008: 02E3 8B 75 FFFFFFB4              MOV ESI, DWORD PTR FFFFFFB4[EBP]
00008: 02E6 FF 45 FFFFFFB4              INC DWORD PTR FFFFFFB4[EBP]
00008: 02E9 8B 1D 00000028              MOV EBX, DWORD PTR _search+00000028
00008: 02EF 66 8B 45 FFFFFFF0           MOV AX, WORD PTR FFFFFFF0[EBP]
00008: 02F3 66 89 04 73                 MOV WORD PTR 00000000[EBX][ESI*2], AX

; 161: 	      } 

00008: 02F7                     L0017:

; 162: 	     }

00008: 02F7                     L0016:

; 163: 	   }  

00008: 02F7 8B 4D FFFFFFB0              MOV ECX, DWORD PTR FFFFFFB0[EBP]
00008: 02FA 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 02FD 89 45 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], EAX
00008: 0300                     L000F:
00008: 0300 83 7D FFFFFFB0 00           CMP DWORD PTR FFFFFFB0[EBP], 00000000
00008: 0304 0F 85 FFFFFEA2              JNE L0010

; 164: 	  }

00008: 030A FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]
00008: 030D                     L000B:
00008: 030D 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0310 3B 45 FFFFFFD0              CMP EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0313 0F 8E FFFFFE4C              JLE L000C

; 165:     }

00008: 0319 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 031C 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 0322 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 0325                     L0007:
00008: 0325 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0328 3B 45 FFFFFFD4              CMP EAX, DWORD PTR FFFFFFD4[EBP]
00008: 032B 0F 8E FFFFFDF6              JLE L0008

; 166:   }  

00008: 0331 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 0334 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 033A 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX
00008: 033D                     L0003:
00008: 033D 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 0340 3B 45 FFFFFFD8              CMP EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0343 0F 8E FFFFFDA9              JLE L0004

; 167:  search.np=np;

00008: 0349 66 8B 45 FFFFFFB4           MOV AX, WORD PTR FFFFFFB4[EBP]
00008: 034D 66 A3 0000003E              MOV WORD PTR _search+0000003E, AX

; 168:  return;

00000: 0353                     L0000:
00000: 0353                             epilog 
00000: 0353 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0356 5F                          POP EDI
00000: 0357 5E                          POP ESI
00000: 0358 5B                          POP EBX
00000: 0359 5D                          POP EBP
00000: 035A C3                          RETN 

Function: _find_neighbors

; 174: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 38                    SUB ESP, 00000038
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000000E                 MOV ECX, 0000000E
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 176:  int nn=0;

00008: 0018 C7 45 FFFFFFC0 00000000     MOV DWORD PTR FFFFFFC0[EBP], 00000000

; 180:   i1=a[p].i.x.i-1;

00008: 001F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0022 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0029 29 D3                       SUB EBX, EDX
00008: 002B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 002E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0034 8B 54 DE 30                 MOV EDX, DWORD PTR 00000030[ESI][EBX*8]
00008: 0038 4A                          DEC EDX
00008: 0039 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 181:   j1=(a[p].i.y.i-1)*search.x;

00008: 003C 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 003F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0046 29 D3                       SUB EBX, EDX
00008: 0048 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 004B 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0051 8B 54 DE 38                 MOV EDX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0055 4A                          DEC EDX
00008: 0056 0F AF 15 0000001C           IMUL EDX, DWORD PTR _search+0000001C
00008: 005D 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 182:   i2=i1+2;

00008: 0060 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00008: 0063 83 C2 02                    ADD EDX, 00000002
00008: 0066 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 183:   j2=j1+(search.x<<1);

00008: 0069 8B 15 0000001C              MOV EDX, DWORD PTR _search+0000001C
00008: 006F D1 E2                       SHL EDX, 00000001
00008: 0071 03 55 FFFFFFD4              ADD EDX, DWORD PTR FFFFFFD4[EBP]
00008: 0074 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 184:   if(search.z==search.y)

00008: 0077 8B 0D 00000024              MOV ECX, DWORD PTR _search+00000024
00008: 007D 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 0083 39 D1                       CMP ECX, EDX
00008: 0085 75 2B                       JNE L0001

; 185:   {k1=a[p].i.z.i*search.y;k2=k1;}

00008: 0087 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 008A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0091 29 D3                       SUB EBX, EDX
00008: 0093 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0096 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 009C 8B 35 00000020              MOV ESI, DWORD PTR _search+00000020
00008: 00A2 0F AF 74 DF 40              IMUL ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 00A7 89 75 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], ESI
00008: 00AA 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00AD 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00008: 00B0 EB 32                       JMP L0002
00008: 00B2                     L0001:

; 187:   {k1=(a[p].i.z.i-1)*search.y;k2=k1+(search.y<<1);}

00008: 00B2 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00B5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00BC 29 D3                       SUB EBX, EDX
00008: 00BE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00C1 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00C7 8B 54 DE 40                 MOV EDX, DWORD PTR 00000040[ESI][EBX*8]
00008: 00CB 4A                          DEC EDX
00008: 00CC 0F AF 15 00000020           IMUL EDX, DWORD PTR _search+00000020
00008: 00D3 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX
00008: 00D6 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 00DC D1 E2                       SHL EDX, 00000001
00008: 00DE 03 55 FFFFFFD8              ADD EDX, DWORD PTR FFFFFFD8[EBP]
00008: 00E1 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX
00008: 00E4                     L0002:

; 189:   for(k=k1;k<=k2;k+=search.y)

00008: 00E4 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00E7 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX
00008: 00EA E9 0000011D                 JMP L0003
00008: 00EF                     L0004:

; 191:       addressz=k;

00008: 00EF 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00F2 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 192:       if(addressz<0)addressz+=search.z;

00008: 00F5 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 00F9 7D 0C                       JGE L0005
00008: 00FB 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00FE 03 05 00000024              ADD EAX, DWORD PTR _search+00000024
00008: 0104 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX
00008: 0107                     L0005:

; 193:       if(addressz==search.z)addressz=0;

00008: 0107 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 010A 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0110 75 07                       JNE L0006
00008: 0112 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0119                     L0006:

; 194:       for(j=j1;j<=j2;j+=search.x)

00008: 0119 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 011C 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 011F E9 000000D0                 JMP L0007
00008: 0124                     L0008:

; 196: 	  addressy=j; 

00008: 0124 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0127 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 197: 	  if(addressy<0)addressy+=search.y;

00008: 012A 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 012E 7D 0C                       JGE L0009
00008: 0130 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0133 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 0139 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 013C                     L0009:

; 198: 	  if(addressy==search.y)addressy=0;

00008: 013C 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 013F 3B 05 00000020              CMP EAX, DWORD PTR _search+00000020
00008: 0145 75 07                       JNE L000A
00008: 0147 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000
00008: 014E                     L000A:

; 199: 	  addressy+=addressz;

00008: 014E 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0151 03 45 FFFFFFEC              ADD EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0154 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 200: 	  for(i=i1;i<=i2;i++)

00008: 0157 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 015A 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX
00008: 015D EB 7D                       JMP L000B
00008: 015F                     L000C:

; 202: 	      address=i; 

00008: 015F 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0162 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 203: 	      if(address<0)address+=search.x;

00008: 0165 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0169 7D 0C                       JGE L000D
00008: 016B 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 016E 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 0174 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 0177                     L000D:

; 204: 	      if(address==search.x)address=0;

00008: 0177 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 017A 3B 05 0000001C              CMP EAX, DWORD PTR _search+0000001C
00008: 0180 75 07                       JNE L000E
00008: 0182 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0189                     L000E:

; 205: 	      address+=addressy;

00008: 0189 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 018C 03 45 FFFFFFF0              ADD EAX, DWORD PTR FFFFFFF0[EBP]
00008: 018F 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 206: 	      for(inpt=search.inpt[address];inpt;inpt=inpt->pt)

00008: 0192 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0198 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 019B 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 019E 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 01A1 EB 30                       JMP L000F
00008: 01A3                     L0010:

; 207: 		if(inpt->dt.q>=search.n)

00008: 01A3 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 01A6 66 8B 48 0A                 MOV CX, WORD PTR 0000000A[EAX]
00008: 01AA 66 8B 15 00000042           MOV DX, WORD PTR _search+00000042
00008: 01B1 66 39 D1                    CMP CX, DX
00008: 01B4 7C 14                       JL L0011

; 208: 		    neib[nn++]=inpt->dt.p;

00008: 01B6 8B 75 FFFFFFC0              MOV ESI, DWORD PTR FFFFFFC0[EBP]
00008: 01B9 FF 45 FFFFFFC0              INC DWORD PTR FFFFFFC0[EBP]
00008: 01BC 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 01BF 66 8B 58 08                 MOV BX, WORD PTR 00000008[EAX]
00008: 01C3 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 01C6 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX
00008: 01CA                     L0011:
00008: 01CA 8B 4D FFFFFFBC              MOV ECX, DWORD PTR FFFFFFBC[EBP]
00008: 01CD 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 01D0 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX
00008: 01D3                     L000F:
00008: 01D3 83 7D FFFFFFBC 00           CMP DWORD PTR FFFFFFBC[EBP], 00000000
00008: 01D7 75 FFFFFFCA                 JNE L0010

; 209: 	    } 

00008: 01D9 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 01DC                     L000B:
00008: 01DC 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 01DF 3B 45 FFFFFFDC              CMP EAX, DWORD PTR FFFFFFDC[EBP]
00008: 01E2 0F 8E FFFFFF77              JLE L000C

; 210: 	}  

00008: 01E8 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01EB 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 01F1 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 01F4                     L0007:
00008: 01F4 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01F7 3B 45 FFFFFFE0              CMP EAX, DWORD PTR FFFFFFE0[EBP]
00008: 01FA 0F 8E FFFFFF24              JLE L0008

; 211:     }

00008: 0200 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0203 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 0209 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX
00008: 020C                     L0003:
00008: 020C 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 020F 3B 45 FFFFFFE4              CMP EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0212 0F 8E FFFFFED7              JLE L0004

; 212:  return nn;

00008: 0218 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00000: 021B                     L0000:
00000: 021B                             epilog 
00000: 021B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 021E 5F                          POP EDI
00000: 021F 5E                          POP ESI
00000: 0220 5B                          POP EBX
00000: 0221 5D                          POP EBP
00000: 0222 C3                          RETN 

Function: _list_atoms

; 216: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 08                    SUB ESP, 00000008
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0010 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0014                             prolog 

; 217: 	short i=0;

00008: 0014 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 219: 	for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)

00008: 001B 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0021 8B 4D 08                    MOV ECX, DWORD PTR 00000008[EBP]
00008: 0024 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0027 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 002A EB 33                       JMP L0001
00008: 002C                     L0002:

; 220:  	if(inpt1->dt.q>=search.n)

00008: 002C 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 002F 66 8B 48 0A                 MOV CX, WORD PTR 0000000A[EAX]
00008: 0033 66 8B 15 00000042           MOV DX, WORD PTR _search+00000042
00008: 003A 66 39 D1                    CMP CX, DX
00008: 003D 7C 17                       JL L0003

; 221:  	{ atomx[i++]=inpt1->dt.p;}

00008: 003F 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 0042 FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 0045 0F BF F2                    MOVSX ESI, DX
00008: 0048 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 004B 66 8B 58 08                 MOV BX, WORD PTR 00000008[EAX]
00008: 004F 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0052 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX
00008: 0056                     L0003:
00008: 0056 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 0059 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 005C 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX
00008: 005F                     L0001:
00008: 005F 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0063 75 FFFFFFC7                 JNE L0002

; 222:  return i;	

00008: 0065 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00000: 0068                     L0000:
00000: 0068                             epilog 
00000: 0068 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 006B 5E                          POP ESI
00000: 006C 5B                          POP EBX
00000: 006D 5D                          POP EBP
00000: 006E C3                          RETN 

Function: _check_atoms

; 226: { 

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

; 227: 	short i=0;

00008: 0019 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000

; 231: 	for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)

00008: 0020 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0026 8B 4D 08                    MOV ECX, DWORD PTR 00000008[EBP]
00008: 0029 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 002C 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 002F EB 43                       JMP L0001
00008: 0031                     L0002:

; 233:  	  p=inpt1->dt.p;

00008: 0031 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 0034 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 0038 66 89 45 FFFFFFE4           MOV WORD PTR FFFFFFE4[EBP], AX

; 234:  	  q=inpt1->dt.q;

00008: 003C 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 003F 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 0043 66 89 45 FFFFFFE8           MOV WORD PTR FFFFFFE8[EBP], AX

; 235:  	  c=inpt1->dt.ct;

00008: 0047 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 004A 66 8B 41 0C                 MOV AX, WORD PTR 0000000C[ECX]
00008: 004E 66 89 45 FFFFFFEC           MOV WORD PTR FFFFFFEC[EBP], AX

; 236:  	  t=inpt1->dt.t;

00008: 0052 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0055 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0057 DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]

; 237:  	  if((p>-1)&&(q>-1))

00008: 005A 66 83 7D FFFFFFE4 FFFFFFFF  CMP WORD PTR FFFFFFE4[EBP], FFFFFFFF
00008: 005F 7E 0A                       JLE L0003
00008: 0061 66 83 7D FFFFFFE8 FFFFFFFF  CMP WORD PTR FFFFFFE8[EBP], FFFFFFFF
00008: 0066 7E 03                       JLE L0003

; 238:  	  i++;

00008: 0068 FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 006B                     L0003:

; 239:  	  }

00008: 006B 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 006E 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 0071 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 0074                     L0001:
00008: 0074 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0078 75 FFFFFFB7                 JNE L0002

; 240:  return i;	

00008: 007A 0F BF 45 FFFFFFE0           MOVSX EAX, WORD PTR FFFFFFE0[EBP]
00000: 007E                     L0000:
00000: 007E                             epilog 
00000: 007E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0081 5B                          POP EBX
00000: 0082 5D                          POP EBP
00000: 0083 C3                          RETN 

Function: _bond

; 243: {   

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

; 245: 	for( inpt1=search.inpt[a[i].add];inpt1;inpt1=inpt1->pt)

00008: 0015 0F BF 55 08                 MOVSX EDX, WORD PTR 00000008[EBP]
00008: 0019 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0020 29 D6                       SUB ESI, EDX
00008: 0022 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0025 8B 1D 00000000              MOV EBX, DWORD PTR _a
00008: 002B 8B B4 F3 000000A0           MOV ESI, DWORD PTR 000000A0[EBX][ESI*8]
00008: 0032 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0038 8B 04 B3                    MOV EAX, DWORD PTR 00000000[EBX][ESI*4]
00008: 003B 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 003E EB 32                       JMP L0001
00008: 0040                     L0002:

; 246: 	if((i==inpt1->dt.p)&&(j==inpt1->dt.q)) return inpt1->dt.ct;

00008: 0040 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 0043 66 8B 45 08                 MOV AX, WORD PTR 00000008[EBP]
00008: 0047 66 3B 41 08                 CMP AX, WORD PTR 00000008[ECX]
00008: 004B 75 1C                       JNE L0003
00008: 004D 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 0050 66 8B 45 0C                 MOV AX, WORD PTR 0000000C[EBP]
00008: 0054 66 3B 41 0A                 CMP AX, WORD PTR 0000000A[ECX]
00008: 0058 75 0F                       JNE L0003
00008: 005A 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 005D 66 8B 40 0C                 MOV AX, WORD PTR 0000000C[EAX]
00000: 0061                             epilog 
00000: 0061 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0064 5F                          POP EDI
00000: 0065 5E                          POP ESI
00000: 0066 5B                          POP EBX
00000: 0067 5D                          POP EBP
00000: 0068 C3                          RETN 
00008: 0069                     L0003:
00008: 0069 8B 4D FFFFFFF0              MOV ECX, DWORD PTR FFFFFFF0[EBP]
00008: 006C 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 006F 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX
00008: 0072                     L0001:
00008: 0072 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 0076 75 FFFFFFC8                 JNE L0002

; 247: 	return -ecoll[a[i].c][a[j].c];

00008: 0078 0F BF 55 0C                 MOVSX EDX, WORD PTR 0000000C[EBP]
00008: 007C 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0083 29 D6                       SUB ESI, EDX
00008: 0085 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0088 8B 1D 00000000              MOV EBX, DWORD PTR _a
00008: 008E 0F BF BC F3 000000A4        MOVSX EDI, WORD PTR 000000A4[EBX][ESI*8]
00008: 0096 0F BF 55 08                 MOVSX EDX, WORD PTR 00000008[EBP]
00008: 009A 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 00A1 29 D6                       SUB ESI, EDX
00008: 00A3 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00A6 8B 1D 00000000              MOV EBX, DWORD PTR _a
00008: 00AC 0F BF B4 F3 000000A4        MOVSX ESI, WORD PTR 000000A4[EBX][ESI*8]
00008: 00B4 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 00BA 8B 14 B3                    MOV EDX, DWORD PTR 00000000[EBX][ESI*4]
00008: 00BD 66 8B 04 BA                 MOV AX, WORD PTR 00000000[EDX][EDI*4]
00008: 00C1 F7 D8                       NEG EAX
00000: 00C3                     L0000:
00000: 00C3                             epilog 
00000: 00C3 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00C6 5F                          POP EDI
00000: 00C7 5E                          POP ESI
00000: 00C8 5B                          POP EBX
00000: 00C9 5D                          POP EBP
00000: 00CA C3                          RETN 

Function: _init_tables

; 251: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 78                    SUB ESP, 00000078
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000001E                 MOV ECX, 0000001E
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 254:   long maxadd=search.z;

00008: 0018 A1 00000024                 MOV EAX, DWORD PTR _search+00000024
00008: 001D 89 45 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EAX

; 257:   short n=search.n-1;

00008: 0020 66 8B 15 00000042           MOV DX, WORD PTR _search+00000042
00008: 0027 4A                          DEC EDX
00008: 0028 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 258:   short n1=n+1;

00008: 002B 8B 55 FFFFFFC0              MOV EDX, DWORD PTR FFFFFFC0[EBP]
00008: 002E 42                          INC EDX
00008: 002F 89 55 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EDX

; 263:   initsearch();

00008: 0032 E8 00000000                 CALL SHORT _initsearch

; 264:   for(i=0;i<=n;i++)

00008: 0037 C7 45 FFFFFF90 00000000     MOV DWORD PTR FFFFFF90[EBP], 00000000
00008: 003E EB 37                       JMP L0001
00008: 0040                     L0002:

; 266:       tb.p=i;

00008: 0040 66 8B 45 FFFFFF90           MOV AX, WORD PTR FFFFFF90[EBP]
00008: 0044 66 89 45 FFFFFFEC           MOV WORD PTR FFFFFFEC[EBP], AX

; 267:       tb.ct=-1;

00008: 0048 66 C7 45 FFFFFFF0 FFFFFFFF  MOV WORD PTR FFFFFFF0[EBP], FFFFFFFF

; 268:       tb.q=twall(i,&(tb.t));

00008: 004E 8D 45 FFFFFFE4              LEA EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0051 50                          PUSH EAX
00008: 0052 FF 75 FFFFFF90              PUSH DWORD PTR FFFFFF90[EBP]
00008: 0055 E8 00000000                 CALL SHORT _twall
00008: 005A 59                          POP ECX
00008: 005B 59                          POP ECX
00008: 005C 66 89 45 FFFFFFEE           MOV WORD PTR FFFFFFEE[EBP], AX

; 269:       bubble(tb);

00008: 0060 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0063 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0066 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0069 FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 006C E8 00000000                 CALL SHORT _bubble
00008: 0071 83 C4 10                    ADD ESP, 00000010

; 270:     }

00008: 0074 FF 45 FFFFFF90              INC DWORD PTR FFFFFF90[EBP]
00008: 0077                     L0001:
00008: 0077 0F BF 55 FFFFFFC0           MOVSX EDX, WORD PTR FFFFFFC0[EBP]
00008: 007B 39 55 FFFFFF90              CMP DWORD PTR FFFFFF90[EBP], EDX
00008: 007E 7E FFFFFFC0                 JLE L0002

; 273:   a[n1].c=0;

00008: 0080 0F BF 55 FFFFFFC4           MOVSX EDX, WORD PTR FFFFFFC4[EBP]
00008: 0084 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 008B 29 D3                       SUB EBX, EDX
00008: 008D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0090 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0096 66 C7 84 DA 000000A40000    MOV WORD PTR 000000A4[EDX][EBX*8], 0000

; 274:   for (k0=0;k0<maxadd;k0++)

00008: 00A0 C7 45 FFFFFF84 00000000     MOV DWORD PTR FFFFFF84[EBP], 00000000
00008: 00A7 E9 0000030E                 JMP L0003
00008: 00AC                     L0004:

; 275:   if(search.np=list_atoms(k0,search.atomp))

00008: 00AC A1 00000028                 MOV EAX, DWORD PTR _search+00000028
00008: 00B1 50                          PUSH EAX
00008: 00B2 FF 75 FFFFFF84              PUSH DWORD PTR FFFFFF84[EBP]
00008: 00B5 E8 00000000                 CALL SHORT _list_atoms
00008: 00BA 59                          POP ECX
00008: 00BB 59                          POP ECX
00008: 00BC 66 A3 0000003E              MOV WORD PTR _search+0000003E, AX
00008: 00C2 66 83 3D 0000003E 00        CMP WORD PTR _search+0000003E, 0000
00008: 00CA 0F 84 000002E7              JE L0005

; 277:    i0=search.atomp[0];

00008: 00D0 8B 15 00000028              MOV EDX, DWORD PTR _search+00000028
00008: 00D6 0F BF 12                    MOVSX EDX, WORD PTR 00000000[EDX]
00008: 00D9 89 95 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EDX

; 278:    i1=a[i0].i.x.i-1;

00008: 00DF 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 00E5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00EC 29 D3                       SUB EBX, EDX
00008: 00EE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00F1 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00F7 8B 54 DE 30                 MOV EDX, DWORD PTR 00000030[ESI][EBX*8]
00008: 00FB 4A                          DEC EDX
00008: 00FC 89 55 FFFFFF9C              MOV DWORD PTR FFFFFF9C[EBP], EDX

; 279:    i2=i1+2;

00008: 00FF 8B 55 FFFFFF9C              MOV EDX, DWORD PTR FFFFFF9C[EBP]
00008: 0102 83 C2 02                    ADD EDX, 00000002
00008: 0105 89 55 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EDX

; 280:    j1=(a[i0].i.y.i-1)*search.x;

00008: 0108 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 010E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0115 29 D3                       SUB EBX, EDX
00008: 0117 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 011A 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0120 8B 54 DE 38                 MOV EDX, DWORD PTR 00000038[ESI][EBX*8]
00008: 0124 4A                          DEC EDX
00008: 0125 0F AF 15 0000001C           IMUL EDX, DWORD PTR _search+0000001C
00008: 012C 89 55 FFFFFFA0              MOV DWORD PTR FFFFFFA0[EBP], EDX

; 281:    j2=j1+(search.x<<1);

00008: 012F 8B 15 0000001C              MOV EDX, DWORD PTR _search+0000001C
00008: 0135 D1 E2                       SHL EDX, 00000001
00008: 0137 03 55 FFFFFFA0              ADD EDX, DWORD PTR FFFFFFA0[EBP]
00008: 013A 89 55 FFFFFFAC              MOV DWORD PTR FFFFFFAC[EBP], EDX

; 282:   if(search.z==search.y)

00008: 013D 8B 0D 00000024              MOV ECX, DWORD PTR _search+00000024
00008: 0143 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 0149 39 D1                       CMP ECX, EDX
00008: 014B 75 2E                       JNE L0006

; 283:   {k1=a[i0].i.z.i*search.y;k2=k1;}

00008: 014D 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 0153 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 015A 29 D3                       SUB EBX, EDX
00008: 015C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 015F 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0165 8B 35 00000020              MOV ESI, DWORD PTR _search+00000020
00008: 016B 0F AF 74 DF 40              IMUL ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 0170 89 75 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], ESI
00008: 0173 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 0176 89 45 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], EAX
00008: 0179 EB 35                       JMP L0007
00008: 017B                     L0006:

; 285:   {k1=(a[i0].i.z.i-1)*search.y;k2=k1+(search.y<<1);}

00008: 017B 8B 95 FFFFFF7C              MOV EDX, DWORD PTR FFFFFF7C[EBP]
00008: 0181 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0188 29 D3                       SUB EBX, EDX
00008: 018A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 018D 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0193 8B 54 DE 40                 MOV EDX, DWORD PTR 00000040[ESI][EBX*8]
00008: 0197 4A                          DEC EDX
00008: 0198 0F AF 15 00000020           IMUL EDX, DWORD PTR _search+00000020
00008: 019F 89 55 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EDX
00008: 01A2 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 01A8 D1 E2                       SHL EDX, 00000001
00008: 01AA 03 55 FFFFFFA4              ADD EDX, DWORD PTR FFFFFFA4[EBP]
00008: 01AD 89 55 FFFFFFB0              MOV DWORD PTR FFFFFFB0[EBP], EDX
00008: 01B0                     L0007:

; 286:    for(k=k1;k<=k2;k+=search.y)

00008: 01B0 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 01B3 89 45 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EAX
00008: 01B6 E9 000001F0                 JMP L0008
00008: 01BB                     L0009:

; 288:      addressz=k;

00008: 01BB 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 01BE 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 289:      if(addressz<0)addressz+=search.z;

00008: 01C1 83 7D FFFFFFC8 00           CMP DWORD PTR FFFFFFC8[EBP], 00000000
00008: 01C5 7D 0C                       JGE L000A
00008: 01C7 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01CA 03 05 00000024              ADD EAX, DWORD PTR _search+00000024
00008: 01D0 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 01D3                     L000A:

; 290:      if(addressz==search.z)addressz=0;

00008: 01D3 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01D6 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 01DC 75 07                       JNE L000B
00008: 01DE C7 45 FFFFFFC8 00000000     MOV DWORD PTR FFFFFFC8[EBP], 00000000
00008: 01E5                     L000B:

; 291:      for(j=j1;j<=j2;j+=search.x)

00008: 01E5 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 01E8 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX
00008: 01EB E9 000001A3                 JMP L000C
00008: 01F0                     L000D:

; 293: 	  addressy=j; 

00008: 01F0 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 01F3 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 294: 	  if(addressy<0)addressy+=search.y;

00008: 01F6 83 7D FFFFFFCC 00           CMP DWORD PTR FFFFFFCC[EBP], 00000000
00008: 01FA 7D 0C                       JGE L000E
00008: 01FC 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 01FF 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 0205 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX
00008: 0208                     L000E:

; 295: 	  if(addressy==search.y)addressy=0;

00008: 0208 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 020B 3B 05 00000020              CMP EAX, DWORD PTR _search+00000020
00008: 0211 75 07                       JNE L000F
00008: 0213 C7 45 FFFFFFCC 00000000     MOV DWORD PTR FFFFFFCC[EBP], 00000000
00008: 021A                     L000F:

; 296: 	  addressy+=addressz;

00008: 021A 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 021D 03 45 FFFFFFC8              ADD EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0220 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 297: 	  for(i=i1;i<=i2;i++)

00008: 0223 8B 45 FFFFFF9C              MOV EAX, DWORD PTR FFFFFF9C[EBP]
00008: 0226 89 45 FFFFFF90              MOV DWORD PTR FFFFFF90[EBP], EAX
00008: 0229 E9 0000014D                 JMP L0010
00008: 022E                     L0011:

; 301: 	   address=i; 

00008: 022E 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0231 89 45 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EAX

; 302: 	   if(address<0)address+=search.x;

00008: 0234 83 7D FFFFFF88 00           CMP DWORD PTR FFFFFF88[EBP], 00000000
00008: 0238 7D 0C                       JGE L0012
00008: 023A 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 023D 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 0243 89 45 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EAX
00008: 0246                     L0012:

; 303: 	   if(address==search.x)address=0;

00008: 0246 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 0249 3B 05 0000001C              CMP EAX, DWORD PTR _search+0000001C
00008: 024F 75 07                       JNE L0013
00008: 0251 C7 45 FFFFFF88 00000000     MOV DWORD PTR FFFFFF88[EBP], 00000000
00008: 0258                     L0013:

; 304: 	   address+=addressy;

00008: 0258 8B 45 FFFFFF88              MOV EAX, DWORD PTR FFFFFF88[EBP]
00008: 025B 03 45 FFFFFFCC              ADD EAX, DWORD PTR FFFFFFCC[EBP]
00008: 025E 89 45 FFFFFF88              MOV DWORD PTR FFFFFF88[EBP], EAX

; 305:  	   search.nq=list_atoms(address,search.atomq);

00008: 0261 A1 0000002C                 MOV EAX, DWORD PTR _search+0000002C
00008: 0266 50                          PUSH EAX
00008: 0267 FF 75 FFFFFF88              PUSH DWORD PTR FFFFFF88[EBP]
00008: 026A E8 00000000                 CALL SHORT _list_atoms
00008: 026F 59                          POP ECX
00008: 0270 59                          POP ECX
00008: 0271 66 A3 00000040              MOV WORD PTR _search+00000040, AX

; 306:  	   for (iq=0;iq<search.nq;iq++)

00008: 0277 C7 45 FFFFFFD0 00000000     MOV DWORD PTR FFFFFFD0[EBP], 00000000
00008: 027E E9 000000E4                 JMP L0014
00008: 0283                     L0015:

; 307:  	   for (ip=0;ip<search.np;ip++)

00008: 0283 C7 45 FFFFFFD4 00000000     MOV DWORD PTR FFFFFFD4[EBP], 00000000
00008: 028A E9 000000C4                 JMP L0016
00008: 028F                     L0017:

; 309:   	    i0=search.atomp[ip]; 

00008: 028F 0F BF 75 FFFFFFD4           MOVSX ESI, WORD PTR FFFFFFD4[EBP]
00008: 0293 8B 1D 00000028              MOV EBX, DWORD PTR _search+00000028
00008: 0299 0F BF 14 73                 MOVSX EDX, WORD PTR 00000000[EBX][ESI*2]
00008: 029D 89 95 FFFFFF7C              MOV DWORD PTR FFFFFF7C[EBP], EDX

; 310:   	    j0=search.atomq[iq];

00008: 02A3 0F BF 75 FFFFFFD0           MOVSX ESI, WORD PTR FFFFFFD0[EBP]
00008: 02A7 8B 1D 0000002C              MOV EBX, DWORD PTR _search+0000002C
00008: 02AD 0F BF 14 73                 MOVSX EDX, WORD PTR 00000000[EBX][ESI*2]
00008: 02B1 89 55 FFFFFF80              MOV DWORD PTR FFFFFF80[EBP], EDX

; 311: 	    if(i0<j0)

00008: 02B4 8B 85 FFFFFF7C              MOV EAX, DWORD PTR FFFFFF7C[EBP]
00008: 02BA 3B 45 FFFFFF80              CMP EAX, DWORD PTR FFFFFF80[EBP]
00008: 02BD 0F 8D 0000008D              JGE L0018

; 314: 	     long ct=collision_type(i0,j0);

00008: 02C3 FF 75 FFFFFF80              PUSH DWORD PTR FFFFFF80[EBP]
00008: 02C6 FF B5 FFFFFF7C              PUSH DWORD PTR FFFFFF7C[EBP]
00008: 02CC E8 00000000                 CALL SHORT _collision_type
00008: 02D1 59                          POP ECX
00008: 02D2 59                          POP ECX
00008: 02D3 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 315: 	     if(ct<0) return (int) ct;

00008: 02D6 83 7D FFFFFFD8 00           CMP DWORD PTR FFFFFFD8[EBP], 00000000
00008: 02DA 7D 0B                       JGE L0019
00008: 02DC 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00000: 02DF                             epilog 
00000: 02DF 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02E2 5F                          POP EDI
00000: 02E3 5E                          POP ESI
00000: 02E4 5B                          POP EBX
00000: 02E5 5D                          POP EBP
00000: 02E6 C3                          RETN 
00008: 02E7                     L0019:

; 316: 	     if(tball(i0,j0,ct,&(tb.t))) 

00008: 02E7 8D 45 FFFFFFE4              LEA EAX, DWORD PTR FFFFFFE4[EBP]
00008: 02EA 50                          PUSH EAX
00008: 02EB FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 02EE FF 75 FFFFFF80              PUSH DWORD PTR FFFFFF80[EBP]
00008: 02F1 FF B5 FFFFFF7C              PUSH DWORD PTR FFFFFF7C[EBP]
00008: 02F7 E8 00000000                 CALL SHORT _tball
00008: 02FC 83 C4 10                    ADD ESP, 00000010
00008: 02FF 83 F8 00                    CMP EAX, 00000000
00008: 0302 74 1D                       JE L001A

; 318: 	      tb.p=i0;

00008: 0304 66 8B 85 FFFFFF7C           MOV AX, WORD PTR FFFFFF7C[EBP]
00008: 030B 66 89 45 FFFFFFEC           MOV WORD PTR FFFFFFEC[EBP], AX

; 319: 	      tb.q=j0;

00008: 030F 66 8B 45 FFFFFF80           MOV AX, WORD PTR FFFFFF80[EBP]
00008: 0313 66 89 45 FFFFFFEE           MOV WORD PTR FFFFFFEE[EBP], AX

; 320: 	      tb.ct=ct;

00008: 0317 66 8B 45 FFFFFFD8           MOV AX, WORD PTR FFFFFFD8[EBP]
00008: 031B 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX

; 321: 	      }

00008: 031F EB 12                       JMP L001B
00008: 0321                     L001A:

; 324: 	      tb.p=-1;

00008: 0321 66 C7 45 FFFFFFEC FFFFFFFF  MOV WORD PTR FFFFFFEC[EBP], FFFFFFFF

; 325: 	      tb.q=-1;

00008: 0327 66 C7 45 FFFFFFEE FFFFFFFF  MOV WORD PTR FFFFFFEE[EBP], FFFFFFFF

; 326: 	      tb.ct=-1;

00008: 032D 66 C7 45 FFFFFFF0 FFFFFFFF  MOV WORD PTR FFFFFFF0[EBP], FFFFFFFF

; 327: 	      }  

00008: 0333                     L001B:

; 328: 	     bubble(tb);

00008: 0333 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0336 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0339 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 033C FF 75 FFFFFFE4              PUSH DWORD PTR FFFFFFE4[EBP]
00008: 033F E8 00000000                 CALL SHORT _bubble
00008: 0344 83 C4 10                    ADD ESP, 00000010

; 329: 	     add_potential(ct);

00008: 0347 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 034A E8 00000000                 CALL SHORT _add_potential
00008: 034F 59                          POP ECX

; 330: 	     }

00008: 0350                     L0018:

; 331: 	    }

00008: 0350 FF 45 FFFFFFD4              INC DWORD PTR FFFFFFD4[EBP]
00008: 0353                     L0016:
00008: 0353 66 8B 45 FFFFFFD4           MOV AX, WORD PTR FFFFFFD4[EBP]
00008: 0357 66 3B 05 0000003E           CMP AX, WORD PTR _search+0000003E
00008: 035E 0F 8C FFFFFF2B              JL L0017
00008: 0364 FF 45 FFFFFFD0              INC DWORD PTR FFFFFFD0[EBP]
00008: 0367                     L0014:
00008: 0367 66 8B 45 FFFFFFD0           MOV AX, WORD PTR FFFFFFD0[EBP]
00008: 036B 66 3B 05 00000040           CMP AX, WORD PTR _search+00000040
00008: 0372 0F 8C FFFFFF0B              JL L0015

; 332: 	   }

00008: 0378 FF 45 FFFFFF90              INC DWORD PTR FFFFFF90[EBP]
00008: 037B                     L0010:
00008: 037B 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 037E 3B 45 FFFFFFA8              CMP EAX, DWORD PTR FFFFFFA8[EBP]
00008: 0381 0F 8E FFFFFEA7              JLE L0011

; 333: 	  }

00008: 0387 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 038A 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 0390 89 45 FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], EAX
00008: 0393                     L000C:
00008: 0393 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 0396 3B 45 FFFFFFAC              CMP EAX, DWORD PTR FFFFFFAC[EBP]
00008: 0399 0F 8E FFFFFE51              JLE L000D

; 334: 	 }

00008: 039F 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 03A2 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 03A8 89 45 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EAX
00008: 03AB                     L0008:
00008: 03AB 8B 45 FFFFFF98              MOV EAX, DWORD PTR FFFFFF98[EBP]
00008: 03AE 3B 45 FFFFFFB0              CMP EAX, DWORD PTR FFFFFFB0[EBP]
00008: 03B1 0F 8E FFFFFE04              JLE L0009

; 335:     }

00008: 03B7                     L0005:
00008: 03B7 FF 45 FFFFFF84              INC DWORD PTR FFFFFF84[EBP]
00008: 03BA                     L0003:
00008: 03BA 8B 45 FFFFFF84              MOV EAX, DWORD PTR FFFFFF84[EBP]
00008: 03BD 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 03C0 0F 8C FFFFFCE6              JL L0004

; 336: k=maxadd;

00008: 03C6 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 03C9 89 45 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EAX

; 337: k=(k>>1)+(k&1);

00008: 03CC 8B 4D FFFFFF98              MOV ECX, DWORD PTR FFFFFF98[EBP]
00008: 03CF D1 F9                       SAR ECX, 00000001
00008: 03D1 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00008: 03D4 83 E2 01                    AND EDX, 00000001
00008: 03D7 01 D1                       ADD ECX, EDX
00008: 03D9 89 4D FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], ECX

; 338: for(i=0;i<k;i++)

00008: 03DC C7 45 FFFFFF90 00000000     MOV DWORD PTR FFFFFF90[EBP], 00000000
00008: 03E3 EB 60                       JMP L001C
00008: 03E5                     L001D:

; 340: address1=i<<1;

00008: 03E5 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 03E8 D1 E2                       SHL EDX, 00000001
00008: 03EA 89 55 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EDX

; 341: address2=address1+1;

00008: 03ED 8B 55 FFFFFFB8              MOV EDX, DWORD PTR FFFFFFB8[EBP]
00008: 03F0 42                          INC EDX
00008: 03F1 89 55 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EDX

; 342: search.olymp[0][i]=address1;

00008: 03F4 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 03FA 8B 1A                       MOV EBX, DWORD PTR 00000000[EDX]
00008: 03FC 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 03FF 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0402 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 343: if((address2<maxadd)&&(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t))

00008: 0405 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0408 3B 45 FFFFFFB4              CMP EAX, DWORD PTR FFFFFFB4[EBP]
00008: 040B 73 35                       JAE L001E
00008: 040D 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0413 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 0416 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0419 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 041F 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 0422 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0425 DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 0427 DD 06                       FLD QWORD PTR 00000000[ESI]
00006: 0429 F1DF                        FCOMIP ST, ST(1), L001E
00007: 042B DD D8                       FSTP ST
00008: 042D 7A 13                       JP L001E
00008: 042F 73 11                       JAE L001E

; 344: search.olymp[0][i]=address2;

00008: 0431 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0437 8B 1A                       MOV EBX, DWORD PTR 00000000[EDX]
00008: 0439 8B 4D FFFFFFBC              MOV ECX, DWORD PTR FFFFFFBC[EBP]
00008: 043C 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 043F 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX
00008: 0442                     L001E:

; 345: }

00008: 0442 FF 45 FFFFFF90              INC DWORD PTR FFFFFF90[EBP]
00008: 0445                     L001C:
00008: 0445 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0448 3B 45 FFFFFF98              CMP EAX, DWORD PTR FFFFFF98[EBP]
00008: 044B 7C FFFFFF98                 JL L001D

; 347: for(level=1;level<search.final;level++)

00008: 044D C7 45 FFFFFF8C 00000001     MOV DWORD PTR FFFFFF8C[EBP], 00000001
00008: 0454 E9 000000D5                 JMP L001F
00008: 0459                     L0020:

; 348: { j=(k>>1)+(k&1);

00008: 0459 8B 4D FFFFFF98              MOV ECX, DWORD PTR FFFFFF98[EBP]
00008: 045C D1 F9                       SAR ECX, 00000001
00008: 045E 8B 55 FFFFFF98              MOV EDX, DWORD PTR FFFFFF98[EBP]
00008: 0461 83 E2 01                    AND EDX, 00000001
00008: 0464 01 D1                       ADD ECX, EDX
00008: 0466 89 4D FFFFFF94              MOV DWORD PTR FFFFFF94[EBP], ECX

; 349:   for(i=0;i<j;i++)

00008: 0469 C7 45 FFFFFF90 00000000     MOV DWORD PTR FFFFFF90[EBP], 00000000
00008: 0470 E9 000000A4                 JMP L0021
00008: 0475                     L0022:

; 351:   size_al i1=i<<1;

00008: 0475 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 0478 D1 E2                       SHL EDX, 00000001
00008: 047A 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 352:   size_al i2=i1+1;

00008: 047D 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0480 42                          INC EDX
00008: 0481 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 353:   search.olymp[level][i]=search.olymp[level-1][i1];

00008: 0484 8B 75 FFFFFF8C              MOV ESI, DWORD PTR FFFFFF8C[EBP]
00008: 0487 4E                          DEC ESI
00008: 0488 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 048E 8B 3C B3                    MOV EDI, DWORD PTR 00000000[EBX][ESI*4]
00008: 0491 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 0497 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 049A 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 049D 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 04A0 8B 1C 87                    MOV EBX, DWORD PTR 00000000[EDI][EAX*4]
00008: 04A3 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 04A6 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 354:   if(i2<k)

00008: 04A9 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 04AC 3B 45 FFFFFF98              CMP EAX, DWORD PTR FFFFFF98[EBP]
00008: 04AF 73 65                       JAE L0023

; 356:     address1=search.olymp[level-1][i1];

00008: 04B1 8B 75 FFFFFF8C              MOV ESI, DWORD PTR FFFFFF8C[EBP]
00008: 04B4 4E                          DEC ESI
00008: 04B5 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 04BB 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 04BE 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 04C1 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 04C4 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 357:     address2=search.olymp[level-1][i2];

00008: 04C7 8B 75 FFFFFF8C              MOV ESI, DWORD PTR FFFFFF8C[EBP]
00008: 04CA 4E                          DEC ESI
00008: 04CB 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 04D1 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 04D4 8B 4D FFFFFFE0              MOV ECX, DWORD PTR FFFFFFE0[EBP]
00008: 04D7 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 04DA 89 45 FFFFFFBC              MOV DWORD PTR FFFFFFBC[EBP], EAX

; 358:    	if(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t)

00008: 04DD 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 04E3 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 04E6 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 04E9 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 04EF 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 04F2 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04F5 DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 04F7 DD 06                       FLD QWORD PTR 00000000[ESI]
00006: 04F9 F1DF                        FCOMIP ST, ST(1), L0024
00007: 04FB DD D8                       FSTP ST
00008: 04FD 7A 17                       JP L0024
00008: 04FF 73 15                       JAE L0024

; 359:    	 search.olymp[level][i]=address2;

00008: 0501 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 0507 8B 45 FFFFFF8C              MOV EAX, DWORD PTR FFFFFF8C[EBP]
00008: 050A 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 050D 8B 4D FFFFFFBC              MOV ECX, DWORD PTR FFFFFFBC[EBP]
00008: 0510 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 0513 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX
00008: 0516                     L0024:

; 360:   }

00008: 0516                     L0023:

; 361:  }

00008: 0516 FF 45 FFFFFF90              INC DWORD PTR FFFFFF90[EBP]
00008: 0519                     L0021:
00008: 0519 8B 45 FFFFFF90              MOV EAX, DWORD PTR FFFFFF90[EBP]
00008: 051C 3B 45 FFFFFF94              CMP EAX, DWORD PTR FFFFFF94[EBP]
00008: 051F 0F 8C FFFFFF50              JL L0022

; 362:   k=j;

00008: 0525 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 0528 89 45 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EAX

; 363: }  

00008: 052B FF 45 FFFFFF8C              INC DWORD PTR FFFFFF8C[EBP]
00008: 052E                     L001F:
00008: 052E 0F BF 15 0000003C           MOVSX EDX, WORD PTR _search+0000003C
00008: 0535 39 55 FFFFFF8C              CMP DWORD PTR FFFFFF8C[EBP], EDX
00008: 0538 0F 8C FFFFFF1B              JL L0020

; 364:  return 1;  

00008: 053E B8 00000001                 MOV EAX, 00000001
00000: 0543                     L0000:
00000: 0543                             epilog 
00000: 0543 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0546 5F                          POP EDI
00000: 0547 5E                          POP ESI
00000: 0548 5B                          POP EBX
00000: 0549 5D                          POP EBP
00000: 054A C3                          RETN 

Function: _bubble

; 368: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 20                    SUB ESP, 00000020
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 00000008                 MOV ECX, 00000008
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 373:   if (tb.p>=0)

00008: 0018 66 83 7D 10 00              CMP WORD PTR 00000010[EBP], 0000
00008: 001D 0F 8C 000000E2              JL L0001

; 375:       address=a[tb.p].add;

00008: 0023 0F BF 55 10                 MOVSX EDX, WORD PTR 00000010[EBP]
00008: 0027 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 002E 29 D3                       SUB EBX, EDX
00008: 0030 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0033 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0039 8B 84 DE 000000A0           MOV EAX, DWORD PTR 000000A0[ESI][EBX*8]
00008: 0040 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 376:       inpt=search.inpt[address];

00008: 0043 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0049 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 004C 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 004F 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 377:       npt=*(search.free);

00008: 0052 8B 15 00000008              MOV EDX, DWORD PTR _search+00000008
00008: 0058 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 005A 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 378:       if(!npt){writetext(text_name);exit(0);}

00008: 005D 83 7D FFFFFFD8 00           CMP DWORD PTR FFFFFFD8[EBP], 00000000
00008: 0061 75 14                       JNE L0002
00008: 0063 A1 00000000                 MOV EAX, DWORD PTR _text_name
00008: 0068 50                          PUSH EAX
00008: 0069 E8 00000000                 CALL SHORT _writetext
00008: 006E 59                          POP ECX
00008: 006F 6A 00                       PUSH 00000000
00008: 0071 E8 00000000                 CALL SHORT _exit
00008: 0076 59                          POP ECX
00008: 0077                     L0002:

; 379:       search.free++;

00008: 0077 83 05 00000008 04           ADD DWORD PTR _search+00000008, 00000004

; 380:       npt->dt=tb;

00008: 007E 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0081 8D 38                       LEA EDI, DWORD PTR 00000000[EAX]
00008: 0083 8D 75 08                    LEA ESI, DWORD PTR 00000008[EBP]
00008: 0086 A5                          MOVSD 
00008: 0087 A5                          MOVSD 
00008: 0088 A5                          MOVSD 
00008: 0089 A5                          MOVSD 

; 381:       dtt=tb.t;

00008: 008A DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 008D DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 382:       if(inpt->dt.t >= dtt)

00008: 0090 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0093 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0095 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00006: 0098 F1DF                        FCOMIP ST, ST(1), L0003
00007: 009A DD D8                       FSTP ST
00008: 009C 7A 25                       JP L0003
00008: 009E 77 23                       JA L0003

; 384: 	  npt->pt=inpt;

00008: 00A0 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 00A3 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00A6 89 48 10                    MOV DWORD PTR 00000010[EAX], ECX

; 385: 	  search.inpt[address]=npt;

00008: 00A9 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 00AF 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 00B2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00B5 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 386: 	  return address;

00008: 00B8 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00000: 00BB                             epilog 
00000: 00BB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 00BE 5F                          POP EDI
00000: 00BF 5E                          POP ESI
00000: 00C0 5B                          POP EBX
00000: 00C1 5D                          POP EBP
00000: 00C2 C3                          RETN 
00008: 00C3                     L0003:

; 390: 	  pt=inpt->pt;

00008: 00C3 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 00C6 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 00C9 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 391:           pt1=inpt;

00008: 00CC 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00CF 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 392: 	  while ( pt->dt.t<dtt)

00008: 00D2 EB 0F                       JMP L0004
00008: 00D4                     L0005:

; 394: 	      pt1=pt;

00008: 00D4 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 00D7 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 395: 	      pt=pt->pt;

00008: 00DA 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 00DD 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 00E0 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 396: 	    }

00008: 00E3                     L0004:
00008: 00E3 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 00E6 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 00E8 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00006: 00EB F1DF                        FCOMIP ST, ST(1), L0005
00007: 00ED DD D8                       FSTP ST
00008: 00EF 7A 02                       JP L0006
00008: 00F1 77 FFFFFFE1                 JA L0005
00008: 00F3                     L0006:

; 397:          pt1->pt=npt;

00008: 00F3 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 00F6 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00F9 89 48 10                    MOV DWORD PTR 00000010[EAX], ECX

; 398:          npt->pt=pt;

00008: 00FC 8B 4D FFFFFFDC              MOV ECX, DWORD PTR FFFFFFDC[EBP]
00008: 00FF 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0102 89 48 10                    MOV DWORD PTR 00000010[EAX], ECX

; 400:     }

00008: 0105                     L0001:

; 401:     return MAXADD;

00008: 0105 B8 00400000                 MOV EAX, 00400000
00000: 010A                     L0000:
00000: 010A                             epilog 
00000: 010A 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 010D 5F                          POP EDI
00000: 010E 5E                          POP ESI
00000: 010F 5B                          POP EBX
00000: 0110 5D                          POP EBP
00000: 0111 C3                          RETN 

Function: _olymp_sort

; 406: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 38                    SUB ESP, 00000038
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000000E                 MOV ECX, 0000000E
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 407:   size_al *change=search.change;

00008: 0018 A1 00000038                 MOV EAX, DWORD PTR _search+00000038
00008: 001D 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX

; 410:   long ch,nch1,nch=search.nch;

00008: 0020 A1 00000018                 MOV EAX, DWORD PTR _search+00000018
00008: 0025 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 412:   nch1=0;

00008: 0028 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 413:   curr=search.olymp[0];

00008: 002F 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0035 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 0037 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 414:   next=search.olymp[1];

00008: 003A 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0040 8B 42 04                    MOV EAX, DWORD PTR 00000004[EDX]
00008: 0043 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 415:   for(ch=0;ch<nch;ch++)

00008: 0046 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 004D E9 00000098                 JMP L0001
00008: 0052                     L0002:

; 417:     i=change[ch];

00008: 0052 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0055 8B 4D FFFFFFC0              MOV ECX, DWORD PTR FFFFFFC0[EBP]
00008: 0058 8B 04 91                    MOV EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 005B 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 418:     address1=i<<1;

00008: 005E 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00008: 0061 D1 E2                       SHL EDX, 00000001
00008: 0063 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 419:     address2=address1+1;

00008: 0066 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0069 42                          INC EDX
00008: 006A 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 420:     curr[i]=address1;

00008: 006D 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0070 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 0073 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0076 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 421:     if((address2<search.z)&&(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t))

00008: 0079 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 007C 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0082 73 30                       JAE L0003
00008: 0084 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 008A 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 008D 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0090 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 0096 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0099 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 009C DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 009E DD 06                       FLD QWORD PTR 00000000[ESI]
00006: 00A0 F1DF                        FCOMIP ST, ST(1), L0003
00007: 00A2 DD D8                       FSTP ST
00008: 00A4 7A 0E                       JP L0003
00008: 00A6 73 0C                       JAE L0003

; 422:       curr[i]=address2;

00008: 00A8 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 00AB 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 00AE 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 00B1 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX
00008: 00B4                     L0003:

; 423:     j=i>>1;

00008: 00B4 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00008: 00B7 D1 EA                       SHR EDX, 00000001
00008: 00B9 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 424:     if(next[j]<MAXADD)

00008: 00BC 8B 4D FFFFFFD4              MOV ECX, DWORD PTR FFFFFFD4[EBP]
00008: 00BF 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 00C2 81 3C 88 00400000           CMP DWORD PTR 00000000[EAX][ECX*4], 00400000
00008: 00C9 73 1C                       JAE L0004

; 426:       next[j]=MAXADD;

00008: 00CB 8B 4D FFFFFFD4              MOV ECX, DWORD PTR FFFFFFD4[EBP]
00008: 00CE 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 00D1 C7 04 88 00400000           MOV DWORD PTR 00000000[EAX][ECX*4], 00400000

; 427:       change[nch1]=j;

00008: 00D8 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00008: 00DB 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 00DE 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 00E1 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 428:       nch1++;

00008: 00E4 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]

; 429:     } 

00008: 00E7                     L0004:

; 430:    }

00008: 00E7 FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]
00008: 00EA                     L0001:
00008: 00EA 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00ED 3B 45 FFFFFFEC              CMP EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00F0 0F 8C FFFFFF5C              JL L0002

; 431:  nch=nch1;

00008: 00F6 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00F9 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 432:  k=search.z; 

00008: 00FC A1 00000024                 MOV EAX, DWORD PTR _search+00000024
00008: 0101 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 433:  for(level=2;level<search.final;level++) 

00008: 0104 C7 45 FFFFFFF0 00000002     MOV DWORD PTR FFFFFFF0[EBP], 00000002
00008: 010B E9 00000101                 JMP L0005
00008: 0110                     L0006:

; 435:    k=(k>>1)+(k&1);

00008: 0110 8B 4D FFFFFFD8              MOV ECX, DWORD PTR FFFFFFD8[EBP]
00008: 0113 D1 E9                       SHR ECX, 00000001
00008: 0115 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00008: 0118 83 E2 01                    AND EDX, 00000001
00008: 011B 01 D1                       ADD ECX, EDX
00008: 011D 89 4D FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], ECX

; 436:    nch1=0;

00008: 0120 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000

; 437:    prev=curr;

00008: 0127 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 012A 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 438:    curr=next;

00008: 012D 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0130 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 439:    next=search.olymp[level];

00008: 0133 0F BF 75 FFFFFFF0           MOVSX ESI, WORD PTR FFFFFFF0[EBP]
00008: 0137 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 013D 8B 04 B3                    MOV EAX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0140 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 440:    for(ch=0;ch<nch;ch++)

00008: 0143 C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 014A E9 000000AD                 JMP L0007
00008: 014F                     L0008:

; 442:      i=change[ch];

00008: 014F 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0152 8B 4D FFFFFFC0              MOV ECX, DWORD PTR FFFFFFC0[EBP]
00008: 0155 8B 04 91                    MOV EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 0158 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 443:      address1=i<<1;

00008: 015B 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00008: 015E D1 E2                       SHL EDX, 00000001
00008: 0160 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 444:      address2=address1+1;

00008: 0163 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0166 42                          INC EDX
00008: 0167 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 445:      address1=prev[address1];

00008: 016A 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 016D 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0170 8B 04 91                    MOV EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 0173 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX

; 446:      curr[i]=address1;

00008: 0176 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0179 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 017C 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 017F 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 447:      if(address2<k)

00008: 0182 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0185 3B 45 FFFFFFD8              CMP EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0188 73 3C                       JAE L0009

; 449:       	address2=prev[address2];

00008: 018A 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 018D 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0190 8B 04 91                    MOV EAX, DWORD PTR 00000000[ECX][EDX*4]
00008: 0193 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 450:         if(search.inpt[address1]->dt.t>search.inpt[address2]->dt.t)

00008: 0196 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 019C 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 019F 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 01A2 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 01A8 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 01AB 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 01AE DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 01B0 DD 06                       FLD QWORD PTR 00000000[ESI]
00006: 01B2 F1DF                        FCOMIP ST, ST(1), L000A
00007: 01B4 DD D8                       FSTP ST
00008: 01B6 7A 0E                       JP L000A
00008: 01B8 73 0C                       JAE L000A

; 451:   	      curr[i]=address2;

00008: 01BA 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 01BD 8B 4D FFFFFFD0              MOV ECX, DWORD PTR FFFFFFD0[EBP]
00008: 01C0 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 01C3 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX
00008: 01C6                     L000A:

; 452:   	   }

00008: 01C6                     L0009:

; 453:      j=i>>1;

00008: 01C6 8B 55 FFFFFFD0              MOV EDX, DWORD PTR FFFFFFD0[EBP]
00008: 01C9 D1 EA                       SHR EDX, 00000001
00008: 01CB 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 454:      if(next[j]<MAXADD)

00008: 01CE 8B 4D FFFFFFD4              MOV ECX, DWORD PTR FFFFFFD4[EBP]
00008: 01D1 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01D4 81 3C 88 00400000           CMP DWORD PTR 00000000[EAX][ECX*4], 00400000
00008: 01DB 73 1C                       JAE L000B

; 456:         next[j]=MAXADD;

00008: 01DD 8B 4D FFFFFFD4              MOV ECX, DWORD PTR FFFFFFD4[EBP]
00008: 01E0 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01E3 C7 04 88 00400000           MOV DWORD PTR 00000000[EAX][ECX*4], 00400000

; 457:         change[nch1]=j;

00008: 01EA 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00008: 01ED 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 01F0 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 01F3 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 458:         nch1++;

00008: 01F6 FF 45 FFFFFFE8              INC DWORD PTR FFFFFFE8[EBP]

; 459:       } 

00008: 01F9                     L000B:

; 461:     }  

00008: 01F9 FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]
00008: 01FC                     L0007:
00008: 01FC 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 01FF 3B 45 FFFFFFEC              CMP EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0202 0F 8C FFFFFF47              JL L0008

; 462:    nch=nch1;

00008: 0208 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 020B 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 463:  } 

00008: 020E FF 45 FFFFFFF0              INC DWORD PTR FFFFFFF0[EBP]
00008: 0211                     L0005:
00008: 0211 66 8B 45 FFFFFFF0           MOV AX, WORD PTR FFFFFFF0[EBP]
00008: 0215 66 3B 05 0000003C           CMP AX, WORD PTR _search+0000003C
00008: 021C 0F 8C FFFFFEEE              JL L0006

; 464:  next[0]=(search.inpt[curr[0]]->dt.t>search.inpt[curr[1]]->dt.t) ? curr[1]:curr[0];

00008: 0222 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0225 8B 70 04                    MOV ESI, DWORD PTR 00000004[EAX]
00008: 0228 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 022E 8B 3C B3                    MOV EDI, DWORD PTR 00000000[EBX][ESI*4]
00008: 0231 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0234 8B 30                       MOV ESI, DWORD PTR 00000000[EAX]
00008: 0236 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 023C 8B 14 B3                    MOV EDX, DWORD PTR 00000000[EBX][ESI*4]
00008: 023F DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 0241 DD 07                       FLD QWORD PTR 00000000[EDI]
00006: 0243 F1DF                        FCOMIP ST, ST(1), L000C
00007: 0245 DD D8                       FSTP ST
00008: 0247 7A 0A                       JP L000C
00008: 0249 73 08                       JAE L000C
00008: 024B 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 024E 8B 50 04                    MOV EDX, DWORD PTR 00000004[EAX]
00008: 0251 EB 05                       JMP L000D
00008: 0253                     L000C:
00008: 0253 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0256 8B 10                       MOV EDX, DWORD PTR 00000000[EAX]
00008: 0258                     L000D:
00008: 0258 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 025B 89 10                       MOV DWORD PTR 00000000[EAX], EDX

; 466:  return;  

00000: 025D                     L0000:
00000: 025D                             epilog 
00000: 025D 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0260 5F                          POP EDI
00000: 0261 5E                          POP ESI
00000: 0262 5B                          POP EBX
00000: 0263 5D                          POP EBP
00000: 0264 C3                          RETN 

Function: _get_free

; 470: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 471: return (long)(search.free-search.begin);

00008: 0003 A1 00000008                 MOV EAX, DWORD PTR _search+00000008
00008: 0008 2B 05 00000004              SUB EAX, DWORD PTR _search+00000004
00008: 000E 99                          CDQ 
00008: 000F 83 E2 03                    AND EDX, 00000003
00008: 0012 01 D0                       ADD EAX, EDX
00008: 0014 C1 F8 02                    SAR EAX, 00000002
00008: 0017 89 C0                       MOV EAX, EAX
00000: 0019                     L0000:
00000: 0019                             epilog 
00000: 0019 C9                          LEAVE 
00000: 001A C3                          RETN 

Function: _get_maxfree

; 474: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 475: return search.maxfree;

00008: 0003 A1 00000014                 MOV EAX, DWORD PTR _search+00000014
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _set_maxfree

; 478: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 479: search.maxfree=a;

00008: 0003 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0006 89 15 00000014              MOV DWORD PTR _search+00000014, EDX

; 480: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _update_table

; 484: {

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

; 487:   long nch=search.nch;

00008: 001A A1 00000018                 MOV EAX, DWORD PTR _search+00000018
00008: 001F 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 489:   size_al * change=search.change;

00008: 0022 A1 00000038                 MOV EAX, DWORD PTR _search+00000038
00008: 0027 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 490:   if((search.n<=search.np)||(search.n<=search.nq))

00008: 002A 66 8B 0D 00000042           MOV CX, WORD PTR _search+00000042
00008: 0031 66 8B 15 0000003E           MOV DX, WORD PTR _search+0000003E
00008: 0038 66 39 D1                    CMP CX, DX
00008: 003B 7E 13                       JLE L0001
00008: 003D 66 8B 0D 00000042           MOV CX, WORD PTR _search+00000042
00008: 0044 66 8B 15 00000040           MOV DX, WORD PTR _search+00000040
00008: 004B 66 39 D1                    CMP CX, DX
00008: 004E 7F 07                       JG L0002
00008: 0050                     L0001:

; 491:   {long error=1;}

00008: 0050 C7 45 FFFFFFD4 00000001     MOV DWORD PTR FFFFFFD4[EBP], 00000001
00008: 0057                     L0002:

; 492:   tb.p=p1;

00008: 0057 66 8B 45 08                 MOV AX, WORD PTR 00000008[EBP]
00008: 005B 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX

; 493:   tb.ct=-1;

00008: 005F 66 C7 45 FFFFFFF4 FFFFFFFF  MOV WORD PTR FFFFFFF4[EBP], FFFFFFFF

; 494:   tb.q=twall(p1,&(tb.t));

00008: 0065 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0068 50                          PUSH EAX
00008: 0069 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 006C E8 00000000                 CALL SHORT _twall
00008: 0071 59                          POP ECX
00008: 0072 59                          POP ECX
00008: 0073 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX

; 495:   if((add=bubble(tb))<MAXADD)

00008: 0077 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 007A FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 007D FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0080 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0083 E8 00000000                 CALL SHORT _bubble
00008: 0088 83 C4 10                    ADD ESP, 00000010
00008: 008B 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 008E 81 7D FFFFFFC8 00400000     CMP DWORD PTR FFFFFFC8[EBP], 00400000
00008: 0095 7D 3D                       JGE L0003

; 497:     size_al ch=add>>1;

00008: 0097 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 009A D1 FA                       SAR EDX, 00000001
00008: 009C 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX

; 498:     if(search.olymp[0][ch]<MAXADD)

00008: 009F 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 00A5 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 00A7 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00AA 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 00B1 73 21                       JAE L0004

; 500:       search.olymp[0][ch]=MAXADD;/* means that the local champion changes*/

00008: 00B3 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 00B9 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 00BB 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00BE C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 501:       change[nch]=ch;

00008: 00C5 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00008: 00C8 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 00CB 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 00CE 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 502:       nch++;

00008: 00D1 FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 503:      }

00008: 00D4                     L0004:

; 504:    }

00008: 00D4                     L0003:

; 505:   search.collp[p1]=-1;    

00008: 00D4 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 00DA 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00DD 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF

; 506:   if (q1<search.n)

00008: 00E3 0F BF 15 00000042           MOVSX EDX, WORD PTR _search+00000042
00008: 00EA 39 55 0C                    CMP DWORD PTR 0000000C[EBP], EDX
00008: 00ED 0F 8D 000000AB              JGE L0005

; 508:       search.collp[q1]=ct1; /*to make sure that we compute 

00008: 00F3 8B 35 00000030              MOV ESI, DWORD PTR _search+00000030
00008: 00F9 8B 5D 10                    MOV EBX, DWORD PTR 00000010[EBP]
00008: 00FC 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 00FF 66 89 1C 46                 MOV WORD PTR 00000000[ESI][EAX*2], BX

; 511:       search.collq[p1]=-1;

00008: 0103 8B 15 00000034              MOV EDX, DWORD PTR _search+00000034
00008: 0109 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 010C 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF

; 512:       search.collq[q1]=-1;

00008: 0112 8B 15 00000034              MOV EDX, DWORD PTR _search+00000034
00008: 0118 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 011B 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF

; 513:         tb.p=q1;

00008: 0121 66 8B 45 0C                 MOV AX, WORD PTR 0000000C[EBP]
00008: 0125 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX

; 514:         tb.ct=-1;

00008: 0129 66 C7 45 FFFFFFF4 FFFFFFFF  MOV WORD PTR FFFFFFF4[EBP], FFFFFFFF

; 515:         tb.q=twall(q1,&(tb.t));

00008: 012F 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0132 50                          PUSH EAX
00008: 0133 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0136 E8 00000000                 CALL SHORT _twall
00008: 013B 59                          POP ECX
00008: 013C 59                          POP ECX
00008: 013D 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX

; 516:        if((add=bubble(tb))<MAXADD)

00008: 0141 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0144 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0147 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 014A FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 014D E8 00000000                 CALL SHORT _bubble
00008: 0152 83 C4 10                    ADD ESP, 00000010
00008: 0155 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 0158 81 7D FFFFFFC8 00400000     CMP DWORD PTR FFFFFFC8[EBP], 00400000
00008: 015F 7D 3D                       JGE L0006

; 518:            size_al ch=add>>1;

00008: 0161 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 0164 D1 FA                       SAR EDX, 00000001
00008: 0166 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 519:            if(search.olymp[0][ch]<MAXADD)

00008: 0169 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 016F 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0171 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0174 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 017B 73 21                       JAE L0007

; 521:              search.olymp[0][ch]=MAXADD;

00008: 017D 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0183 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0185 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0188 C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 522:              change[nch]=ch;

00008: 018F 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0192 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0195 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0198 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 523:              nch++;

00008: 019B FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 524:             }

00008: 019E                     L0007:

; 525:         }   

00008: 019E                     L0006:

; 526:     }

00008: 019E                     L0005:

; 527:   for(i=0;i<search.np;i++)

00008: 019E C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000
00008: 01A5 E9 000000E9                 JMP L0008
00008: 01AA                     L0009:

; 529:       p2=search.atomp[i];

00008: 01AA 8B 1D 00000028              MOV EBX, DWORD PTR _search+00000028
00008: 01B0 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 01B3 0F BF 14 43                 MOVSX EDX, WORD PTR 00000000[EBX][EAX*2]
00008: 01B7 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 530:       ct=search.collp[p2];

00008: 01BA 8B 1D 00000030              MOV EBX, DWORD PTR _search+00000030
00008: 01C0 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 01C3 0F BF 14 43                 MOVSX EDX, WORD PTR 00000000[EBX][EAX*2]
00008: 01C7 89 55 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EDX

; 531:       search.collp[p2]=-1; 

00008: 01CA 8B 15 00000030              MOV EDX, DWORD PTR _search+00000030
00008: 01D0 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 01D3 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF

; 532:       if(ct>=0) /* the collision is not recalculated if ct is -2

00008: 01D9 83 7D FFFFFFC4 00           CMP DWORD PTR FFFFFFC4[EBP], 00000000
00008: 01DD 0F 8C 000000AD              JL L000A

; 534: 	if(tball(p2,p1,ct,&(tb.t)))

00008: 01E3 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 01E6 50                          PUSH EAX
00008: 01E7 FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 01EA FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01ED FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 01F0 E8 00000000                 CALL SHORT _tball
00008: 01F5 83 C4 10                    ADD ESP, 00000010
00008: 01F8 83 F8 00                    CMP EAX, 00000000
00008: 01FB 0F 84 0000008F              JE L000B

; 536: 	    tb.ct=ct;if(p1<p2){tb.p=p1;tb.q=p2;}else{tb.p=p2;tb.q=p1;}   

00008: 0201 66 8B 45 FFFFFFC4           MOV AX, WORD PTR FFFFFFC4[EBP]
00008: 0205 66 89 45 FFFFFFF4           MOV WORD PTR FFFFFFF4[EBP], AX
00008: 0209 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 020C 3B 45 FFFFFFC0              CMP EAX, DWORD PTR FFFFFFC0[EBP]
00008: 020F 7D 12                       JGE L000C
00008: 0211 66 8B 45 08                 MOV AX, WORD PTR 00000008[EBP]
00008: 0215 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX
00008: 0219 66 8B 45 FFFFFFC0           MOV AX, WORD PTR FFFFFFC0[EBP]
00008: 021D 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX
00008: 0221 EB 10                       JMP L000D
00008: 0223                     L000C:
00008: 0223 66 8B 45 FFFFFFC0           MOV AX, WORD PTR FFFFFFC0[EBP]
00008: 0227 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX
00008: 022B 66 8B 45 08                 MOV AX, WORD PTR 00000008[EBP]
00008: 022F 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX
00008: 0233                     L000D:

; 537: 	    if((add=bubble(tb))<MAXADD)

00008: 0233 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0236 FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0239 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 023C FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 023F E8 00000000                 CALL SHORT _bubble
00008: 0244 83 C4 10                    ADD ESP, 00000010
00008: 0247 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 024A 81 7D FFFFFFC8 00400000     CMP DWORD PTR FFFFFFC8[EBP], 00400000
00008: 0251 7D 3D                       JGE L000E

; 539: 		size_al ch=add>>1;

00008: 0253 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 0256 D1 FA                       SAR EDX, 00000001
00008: 0258 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 540: 		if(search.olymp[0][ch]<MAXADD)

00008: 025B 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0261 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0263 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0266 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 026D 73 21                       JAE L000F

; 542: 		    search.olymp[0][ch]=MAXADD;

00008: 026F 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0275 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0277 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 027A C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 543: 		    change[nch]=ch;

00008: 0281 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 0284 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0287 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 028A 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 544: 		    nch++;

00008: 028D FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 545: 		  }

00008: 0290                     L000F:

; 546:               }   

00008: 0290                     L000E:

; 547: 	  }

00008: 0290                     L000B:
00008: 0290                     L000A:

; 548:     }

00008: 0290 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0293                     L0008:
00008: 0293 0F BF 15 0000003E           MOVSX EDX, WORD PTR _search+0000003E
00008: 029A 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 029D 0F 8C FFFFFF07              JL L0009

; 550:  if (q1<search.n)

00008: 02A3 0F BF 15 00000042           MOVSX EDX, WORD PTR _search+00000042
00008: 02AA 39 55 0C                    CMP DWORD PTR 0000000C[EBP], EDX
00008: 02AD 0F 8D 00000105              JGE L0010

; 553:      for(i=0;i<search.nq;i++)

00008: 02B3 C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000
00008: 02BA E9 000000E9                 JMP L0011
00008: 02BF                     L0012:

; 555: 	 p2=search.atomq[i];

00008: 02BF 8B 1D 0000002C              MOV EBX, DWORD PTR _search+0000002C
00008: 02C5 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00008: 02C8 0F BF 14 43                 MOVSX EDX, WORD PTR 00000000[EBX][EAX*2]
00008: 02CC 89 55 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EDX

; 556: 	 ct=search.collq[p2];

00008: 02CF 8B 1D 00000034              MOV EBX, DWORD PTR _search+00000034
00008: 02D5 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 02D8 0F BF 14 43                 MOVSX EDX, WORD PTR 00000000[EBX][EAX*2]
00008: 02DC 89 55 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EDX

; 557: 	 search.collq[p2]=-1; 

00008: 02DF 8B 15 00000034              MOV EDX, DWORD PTR _search+00000034
00008: 02E5 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 02E8 66 C7 04 42 FFFFFFFF        MOV WORD PTR 00000000[EDX][EAX*2], FFFFFFFF

; 558: 	 if(ct>=0)

00008: 02EE 83 7D FFFFFFC4 00           CMP DWORD PTR FFFFFFC4[EBP], 00000000
00008: 02F2 0F 8C 000000AD              JL L0013

; 559: 	   if(tball(p2,q1,ct,&(tb.t)))

00008: 02F8 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 02FB 50                          PUSH EAX
00008: 02FC FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 02FF FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 0302 FF 75 FFFFFFC0              PUSH DWORD PTR FFFFFFC0[EBP]
00008: 0305 E8 00000000                 CALL SHORT _tball
00008: 030A 83 C4 10                    ADD ESP, 00000010
00008: 030D 83 F8 00                    CMP EAX, 00000000
00008: 0310 0F 84 0000008F              JE L0014

; 561: 	       tb.ct=ct;if(q1<p2){tb.p=q1;tb.q=p2;}else{tb.p=p2;tb.q=q1;}   

00008: 0316 66 8B 45 FFFFFFC4           MOV AX, WORD PTR FFFFFFC4[EBP]
00008: 031A 66 89 45 FFFFFFF4           MOV WORD PTR FFFFFFF4[EBP], AX
00008: 031E 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0321 3B 45 FFFFFFC0              CMP EAX, DWORD PTR FFFFFFC0[EBP]
00008: 0324 7D 12                       JGE L0015
00008: 0326 66 8B 45 0C                 MOV AX, WORD PTR 0000000C[EBP]
00008: 032A 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX
00008: 032E 66 8B 45 FFFFFFC0           MOV AX, WORD PTR FFFFFFC0[EBP]
00008: 0332 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX
00008: 0336 EB 10                       JMP L0016
00008: 0338                     L0015:
00008: 0338 66 8B 45 FFFFFFC0           MOV AX, WORD PTR FFFFFFC0[EBP]
00008: 033C 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX
00008: 0340 66 8B 45 0C                 MOV AX, WORD PTR 0000000C[EBP]
00008: 0344 66 89 45 FFFFFFF2           MOV WORD PTR FFFFFFF2[EBP], AX
00008: 0348                     L0016:

; 562: 	       if((add=bubble(tb))<MAXADD)

00008: 0348 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 034B FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 034E FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0351 FF 75 FFFFFFE8              PUSH DWORD PTR FFFFFFE8[EBP]
00008: 0354 E8 00000000                 CALL SHORT _bubble
00008: 0359 83 C4 10                    ADD ESP, 00000010
00008: 035C 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 035F 81 7D FFFFFFC8 00400000     CMP DWORD PTR FFFFFFC8[EBP], 00400000
00008: 0366 7D 3D                       JGE L0017

; 564: 		   size_al ch=add>>1;

00008: 0368 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 036B D1 FA                       SAR EDX, 00000001
00008: 036D 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 565: 		   if(search.olymp[0][ch]<MAXADD)

00008: 0370 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0376 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0378 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 037B 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 0382 73 21                       JAE L0018

; 567: 		       search.olymp[0][ch]=MAXADD;

00008: 0384 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 038A 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 038C 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 038F C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 568: 		       change[nch]=ch;

00008: 0396 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 0399 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 039C 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 039F 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 569: 		       nch++;

00008: 03A2 FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 570: 		     }

00008: 03A5                     L0018:

; 571: 		 }   

00008: 03A5                     L0017:

; 572: 	     }

00008: 03A5                     L0014:
00008: 03A5                     L0013:

; 573:        }

00008: 03A5 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 03A8                     L0011:
00008: 03A8 0F BF 15 00000040           MOVSX EDX, WORD PTR _search+00000040
00008: 03AF 39 55 FFFFFFBC              CMP DWORD PTR FFFFFFBC[EBP], EDX
00008: 03B2 0F 8C FFFFFF07              JL L0012

; 574:   }

00008: 03B8                     L0010:

; 575: search.nch=nch;    

00008: 03B8 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 03BB A3 00000018                 MOV DWORD PTR _search+00000018, EAX

; 576: olymp_sort();

00008: 03C0 E8 00000000                 CALL SHORT _olymp_sort

; 577: }

00000: 03C5                     L0000:
00000: 03C5                             epilog 
00000: 03C5 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 03C8 5E                          POP ESI
00000: 03C9 5B                          POP EBX
00000: 03CA 5D                          POP EBP
00000: 03CB C3                          RETN 

Function: _squeeze2

; 580: { 

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

; 582:   tlist **free=search.free;

00008: 001A A1 00000008                 MOV EAX, DWORD PTR _search+00000008
00008: 001F 89 45 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EAX

; 583:   short * atomp=search.atomp;

00008: 0022 A1 00000028                 MOV EAX, DWORD PTR _search+00000028
00008: 0027 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 584:   short * collp=search.collp;

00008: 002A A1 00000030                 MOV EAX, DWORD PTR _search+00000030
00008: 002F 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 585:   short np=0;

00008: 0032 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000

; 586:   size_al *change=search.change;

00008: 0039 A1 00000038                 MOV EAX, DWORD PTR _search+00000038
00008: 003E 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 587:   long nch=search.nch;

00008: 0041 A1 00000018                 MOV EAX, DWORD PTR _search+00000018
00008: 0046 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 588:   long address=a[p1].add;

00008: 0049 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 004C 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0053 29 D3                       SUB EBX, EDX
00008: 0055 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0058 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 005E 8B 84 DE 000000A0           MOV EAX, DWORD PTR 000000A0[ESI][EBX*8]
00008: 0065 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 589:   inpt=search.inpt[address];

00008: 0068 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 006E 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 0071 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0074 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 590: 	   if(p1==inpt->dt.p)

00008: 0077 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 007A 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 007E 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 0081 0F 85 000000BF              JNE L0001

; 592: 	     size_al ch=address>>1;

00008: 0087 8B 55 FFFFFFE8              MOV EDX, DWORD PTR FFFFFFE8[EBP]
00008: 008A D1 FA                       SAR EDX, 00000001
00008: 008C 89 55 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EDX

; 593: 	     if(search.olymp[0][ch]<MAXADD)

00008: 008F 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 0095 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0097 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 009A 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 00A1 0F 83 00000084              JAE L0002

; 595: 	       search.olymp[0][ch]=MAXADD;

00008: 00A7 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 00AD 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 00AF 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 00B2 C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 596: 	       change[nch]=ch;

00008: 00B9 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 00BC 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 00BF 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 00C2 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 597: 	       nch++;

00008: 00C5 FF 45 FFFFFFE4              INC DWORD PTR FFFFFFE4[EBP]

; 599:          while(p1==inpt->dt.p)

00008: 00C8 EB 61                       JMP L0002
00008: 00CA                     L0003:

; 601:          short p2=inpt->dt.q;

00008: 00CA 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 00CD 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 00D1 66 89 45 FFFFFFF0           MOV WORD PTR FFFFFFF0[EBP], AX

; 602: 	     if(p2<search.n)

00008: 00D5 66 8B 45 FFFFFFF0           MOV AX, WORD PTR FFFFFFF0[EBP]
00008: 00D9 66 3B 05 00000042           CMP AX, WORD PTR _search+00000042
00008: 00E0 7D 34                       JGE L0004

; 604: 	     if(collp[p2]<0)atomp[np++]=p2;

00008: 00E2 0F BF 55 FFFFFFF0           MOVSX EDX, WORD PTR FFFFFFF0[EBP]
00008: 00E6 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 00E9 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 00EE 7D 14                       JGE L0005
00008: 00F0 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 00F3 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 00F6 0F BF DA                    MOVSX EBX, DX
00008: 00F9 66 8B 4D FFFFFFF0           MOV CX, WORD PTR FFFFFFF0[EBP]
00008: 00FD 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 0100 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 0104                     L0005:

; 605: 	     collp[p2]=inpt->dt.ct;

00008: 0104 0F BF 75 FFFFFFF0           MOVSX ESI, WORD PTR FFFFFFF0[EBP]
00008: 0108 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 010B 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 010F 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0112 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 607: 	      }

00008: 0116                     L0004:

; 608:            *(--free)=inpt;

00008: 0116 83 6D FFFFFFD0 04           SUB DWORD PTR FFFFFFD0[EBP], 00000004
00008: 011A 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 011D 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0120 89 08                       MOV DWORD PTR 00000000[EAX], ECX

; 609:            inpt=inpt->pt;

00008: 0122 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0125 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 0128 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 610:           }

00008: 012B                     L0002:
00008: 012B 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 012E 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 0132 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 0135 74 FFFFFF93                 JE L0003

; 611:          search.inpt[address]=inpt;   

00008: 0137 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 013D 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0140 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0143 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 612: 	    }

00008: 0146                     L0001:

; 613: 	   pt1=inpt;

00008: 0146 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0149 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 614:        while((pt1->pt)!=NULL)

00008: 014C E9 00000087                 JMP L0006
00008: 0151                     L0007:

; 616:         pt=pt1->pt;

00008: 0151 8B 4D FFFFFFC8              MOV ECX, DWORD PTR FFFFFFC8[EBP]
00008: 0154 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 0157 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 617:         while((p1==pt->dt.p))

00008: 015A EB 61                       JMP L0008
00008: 015C                     L0009:

; 619: 	     short p2=pt->dt.q;

00008: 015C 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 015F 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 0163 66 89 45 FFFFFFF4           MOV WORD PTR FFFFFFF4[EBP], AX

; 620: 	     if(p2<search.n)

00008: 0167 66 8B 45 FFFFFFF4           MOV AX, WORD PTR FFFFFFF4[EBP]
00008: 016B 66 3B 05 00000042           CMP AX, WORD PTR _search+00000042
00008: 0172 7D 34                       JGE L000A

; 622: 	    if(collp[p2]<0)atomp[np++]=p2;

00008: 0174 0F BF 55 FFFFFFF4           MOVSX EDX, WORD PTR FFFFFFF4[EBP]
00008: 0178 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 017B 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 0180 7D 14                       JGE L000B
00008: 0182 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0185 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0188 0F BF DA                    MOVSX EBX, DX
00008: 018B 66 8B 4D FFFFFFF4           MOV CX, WORD PTR FFFFFFF4[EBP]
00008: 018F 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 0192 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 0196                     L000B:

; 623: 	    collp[p2]=pt->dt.ct;

00008: 0196 0F BF 75 FFFFFFF4           MOVSX ESI, WORD PTR FFFFFFF4[EBP]
00008: 019A 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 019D 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 01A1 8B 45 FFFFFFD8              MOV EAX, DWORD PTR FFFFFFD8[EBP]
00008: 01A4 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 625: 	      } 

00008: 01A8                     L000A:

; 626: 	       *(--free)=pt;

00008: 01A8 83 6D FFFFFFD0 04           SUB DWORD PTR FFFFFFD0[EBP], 00000004
00008: 01AC 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 01AF 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 01B2 89 08                       MOV DWORD PTR 00000000[EAX], ECX

; 627: 	       pt=pt->pt;

00008: 01B4 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 01B7 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 01BA 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX

; 629: 	      } 

00008: 01BD                     L0008:
00008: 01BD 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 01C0 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 01C4 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 01C7 74 FFFFFF93                 JE L0009

; 630:         pt1->pt=pt;

00008: 01C9 8B 4D FFFFFFC4              MOV ECX, DWORD PTR FFFFFFC4[EBP]
00008: 01CC 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01CF 89 48 10                    MOV DWORD PTR 00000010[EAX], ECX

; 631:         pt1=pt;

00008: 01D2 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 01D5 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 632:         }

00008: 01D8                     L0006:
00008: 01D8 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 01DB 83 78 10 00                 CMP DWORD PTR 00000010[EAX], 00000000
00008: 01DF 0F 85 FFFFFF6C              JNE L0007

; 633:  search.free=free;

00008: 01E5 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 01E8 A3 00000008                 MOV DWORD PTR _search+00000008, EAX

; 634:  search.nch=nch;

00008: 01ED 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 01F0 A3 00000018                 MOV DWORD PTR _search+00000018, EAX

; 635:  search.np=np;

00008: 01F5 66 8B 45 FFFFFFDC           MOV AX, WORD PTR FFFFFFDC[EBP]
00008: 01F9 66 A3 0000003E              MOV WORD PTR _search+0000003E, AX

; 637: }

00000: 01FF                     L0000:
00000: 01FF                             epilog 
00000: 01FF 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0202 5E                          POP ESI
00000: 0203 5B                          POP EBX
00000: 0204 5D                          POP EBP
00000: 0205 C3                          RETN 

Function: _squeeze1

; 671: { 

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

; 673:  tlist **free=search.free;

00008: 0018 A1 00000008                 MOV EAX, DWORD PTR _search+00000008
00008: 001D 89 45 FFFFFFAC              MOV DWORD PTR FFFFFFAC[EBP], EAX

; 675:  size_al *change=search.change;

00008: 0020 A1 00000038                 MOV EAX, DWORD PTR _search+00000038
00008: 0025 89 45 FFFFFFB4              MOV DWORD PTR FFFFFFB4[EBP], EAX

; 676:  long nch=search.nch;

00008: 0028 A1 00000018                 MOV EAX, DWORD PTR _search+00000018
00008: 002D 89 45 FFFFFFB8              MOV DWORD PTR FFFFFFB8[EBP], EAX

; 677:  short np=0;

00008: 0030 C7 45 FFFFFFBC 00000000     MOV DWORD PTR FFFFFFBC[EBP], 00000000

; 683:   i1=a[p1].i.x.i-1;

00008: 0037 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 003A 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0041 29 D3                       SUB EBX, EDX
00008: 0043 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0046 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 004C 8B 54 DE 30                 MOV EDX, DWORD PTR 00000030[ESI][EBX*8]
00008: 0050 4A                          DEC EDX
00008: 0051 89 55 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EDX

; 684:   j1=(a[p1].i.y.i-1)*search.x;

00008: 0054 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0057 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 005E 29 D3                       SUB EBX, EDX
00008: 0060 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0063 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0069 8B 54 DE 38                 MOV EDX, DWORD PTR 00000038[ESI][EBX*8]
00008: 006D 4A                          DEC EDX
00008: 006E 0F AF 15 0000001C           IMUL EDX, DWORD PTR _search+0000001C
00008: 0075 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 685:   i2=i1+2;

00008: 0078 8B 55 FFFFFFCC              MOV EDX, DWORD PTR FFFFFFCC[EBP]
00008: 007B 83 C2 02                    ADD EDX, 00000002
00008: 007E 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX

; 686:   j2=j1+(search.x<<1);

00008: 0081 8B 15 0000001C              MOV EDX, DWORD PTR _search+0000001C
00008: 0087 D1 E2                       SHL EDX, 00000001
00008: 0089 03 55 FFFFFFD0              ADD EDX, DWORD PTR FFFFFFD0[EBP]
00008: 008C 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 688: 	if(search.z==search.y){

00008: 008F 8B 0D 00000024              MOV ECX, DWORD PTR _search+00000024
00008: 0095 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 009B 39 D1                       CMP ECX, EDX
00008: 009D 75 2B                       JNE L0001

; 689:   		k1=a[p1].i.z.i*search.y;

00008: 009F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00A2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00A9 29 D3                       SUB EBX, EDX
00008: 00AB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00AE 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 00B4 8B 35 00000020              MOV ESI, DWORD PTR _search+00000020
00008: 00BA 0F AF 74 DF 40              IMUL ESI, DWORD PTR 00000040[EDI][EBX*8]
00008: 00BF 89 75 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], ESI

; 690:   		k2=k1;

00008: 00C2 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 00C5 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 691:   	}

00008: 00C8 EB 32                       JMP L0002
00008: 00CA                     L0001:

; 693: 		k1=(a[p1].i.z.i-1)*search.y;

00008: 00CA 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 00CD 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00D4 29 D3                       SUB EBX, EDX
00008: 00D6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00D9 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 00DF 8B 54 DE 40                 MOV EDX, DWORD PTR 00000040[ESI][EBX*8]
00008: 00E3 4A                          DEC EDX
00008: 00E4 0F AF 15 00000020           IMUL EDX, DWORD PTR _search+00000020
00008: 00EB 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 694:  		k2=k1+(search.y<<1);

00008: 00EE 8B 15 00000020              MOV EDX, DWORD PTR _search+00000020
00008: 00F4 D1 E2                       SHL EDX, 00000001
00008: 00F6 03 55 FFFFFFD4              ADD EDX, DWORD PTR FFFFFFD4[EBP]
00008: 00F9 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 695:   	}

00008: 00FC                     L0002:

; 697:  	for(k=k1;k<=k2;k+=search.y){ 

00008: 00FC 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 00FF 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 0102 E9 000003AA                 JMP L0003
00008: 0107                     L0004:

; 698: 		addressz=k;

00008: 0107 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 010A 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 699:       	if(addressz<0)

00008: 010D 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0111 7D 0C                       JGE L0005

; 700:       		addressz+=search.z;

00008: 0113 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0116 03 05 00000024              ADD EAX, DWORD PTR _search+00000024
00008: 011C 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 011F                     L0005:

; 701:       	if(addressz==search.z)

00008: 011F 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0122 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0128 75 07                       JNE L0006

; 702:       		addressz=0;

00008: 012A C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 0131                     L0006:

; 704:      	for(j=j1;j<=j2;j+=search.x){ 

00008: 0131 8B 45 FFFFFFD0              MOV EAX, DWORD PTR FFFFFFD0[EBP]
00008: 0134 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX
00008: 0137 E9 0000035D                 JMP L0007
00008: 013C                     L0008:

; 705: 	  		addressy=j; 

00008: 013C 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 013F 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 706: 	  		if(addressy<0)

00008: 0142 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0146 7D 0C                       JGE L0009

; 707: 	  			addressy+=search.y;

00008: 0148 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 014B 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 0151 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX
00008: 0154                     L0009:

; 708: 	  		if(addressy==search.y)

00008: 0154 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0157 3B 05 00000020              CMP EAX, DWORD PTR _search+00000020
00008: 015D 75 07                       JNE L000A

; 709: 	  			addressy=0;

00008: 015F C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0166                     L000A:

; 710: 	  		addressy+=addressz;

00008: 0166 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0169 03 45 FFFFFFE8              ADD EAX, DWORD PTR FFFFFFE8[EBP]
00008: 016C 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 712: 	  		for(i=i1;i<=i2;i++){ 

00008: 016F 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0172 89 45 FFFFFFC0              MOV DWORD PTR FFFFFFC0[EBP], EAX
00008: 0175 E9 00000307                 JMP L000B
00008: 017A                     L000C:

; 713: 	      		address=i; 

00008: 017A 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 017D 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 714: 	      		if(address<0)

00008: 0180 83 7D FFFFFFE4 00           CMP DWORD PTR FFFFFFE4[EBP], 00000000
00008: 0184 7D 0C                       JGE L000D

; 715: 	      			address+=search.x;

00008: 0186 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0189 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 018F 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX
00008: 0192                     L000D:

; 716: 	      		if(address==search.x)

00008: 0192 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0195 3B 05 0000001C              CMP EAX, DWORD PTR _search+0000001C
00008: 019B 75 07                       JNE L000E

; 717: 	      			address=0;

00008: 019D C7 45 FFFFFFE4 00000000     MOV DWORD PTR FFFFFFE4[EBP], 00000000
00008: 01A4                     L000E:

; 718: 	      		address+=addressy;

00008: 01A4 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 01A7 03 45 FFFFFFEC              ADD EAX, DWORD PTR FFFFFFEC[EBP]
00008: 01AA 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 720: 	   			inpt=search.inpt[address];

00008: 01AD 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 01B3 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 01B6 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 01B9 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 722: 	   			if((p1==inpt->dt.p)||(p1==inpt->dt.q)){ 

00008: 01BC 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 01BF 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 01C3 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 01C6 74 10                       JE L000F
00008: 01C8 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 01CB 0F BF 50 0A                 MOVSX EDX, WORD PTR 0000000A[EAX]
00008: 01CF 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 01D2 0F 85 00000123              JNE L0010
00008: 01D8                     L000F:

; 723: 			    	size_al ch=address>>1;

00008: 01D8 8B 55 FFFFFFE4              MOV EDX, DWORD PTR FFFFFFE4[EBP]
00008: 01DB D1 FA                       SAR EDX, 00000001
00008: 01DD 89 55 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EDX

; 724: 	     			if(search.olymp[0][ch]<MAXADD){

00008: 01E0 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 01E6 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 01E8 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 01EB 81 3C 82 00400000           CMP DWORD PTR 00000000[EDX][EAX*4], 00400000
00008: 01F2 0F 83 000000D4              JAE L0011

; 725: 			    		search.olymp[0][ch]=MAXADD;

00008: 01F8 8B 15 00000000              MOV EDX, DWORD PTR _search
00008: 01FE 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 0200 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0203 C7 04 82 00400000           MOV DWORD PTR 00000000[EDX][EAX*4], 00400000

; 726: 	       				change[nch]=ch;

00008: 020A 8B 55 FFFFFFF0              MOV EDX, DWORD PTR FFFFFFF0[EBP]
00008: 020D 8B 4D FFFFFFB8              MOV ECX, DWORD PTR FFFFFFB8[EBP]
00008: 0210 8B 45 FFFFFFB4              MOV EAX, DWORD PTR FFFFFFB4[EBP]
00008: 0213 89 14 88                    MOV DWORD PTR 00000000[EAX][ECX*4], EDX

; 727: 	       				nch++;

00008: 0216 FF 45 FFFFFFB8              INC DWORD PTR FFFFFFB8[EBP]

; 730: 	     			while((p1==inpt->dt.p)||(p1==inpt->dt.q)){

00008: 0219 E9 000000AE                 JMP L0011
00008: 021E                     L0012:

; 731:         				if(p1==inpt->dt.p){ 

00008: 021E 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 0221 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 0225 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 0228 75 4E                       JNE L0013

; 732: 					    	p2=inpt->dt.q;

00008: 022A 8B 4D FFFFFFA8              MOV ECX, DWORD PTR FFFFFFA8[EBP]
00008: 022D 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 0231 66 89 45 FFFFFFB0           MOV WORD PTR FFFFFFB0[EBP], AX

; 733: 	     					if(p2<search.n){

00008: 0235 66 8B 45 FFFFFFB0           MOV AX, WORD PTR FFFFFFB0[EBP]
00008: 0239 66 3B 05 00000042           CMP AX, WORD PTR _search+00000042
00008: 0240 7D 75                       JGE L0014

; 734: 	     					if(collp[p2]<0)atomp[np++]=p2;

00008: 0242 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 0246 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0249 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 024E 7D 14                       JGE L0015
00008: 0250 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0253 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0256 0F BF DA                    MOVSX EBX, DX
00008: 0259 66 8B 4D FFFFFFB0           MOV CX, WORD PTR FFFFFFB0[EBP]
00008: 025D 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0260 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 0264                     L0015:

; 735: 	     						collp[p2]=inpt->dt.ct;

00008: 0264 0F BF 75 FFFFFFB0           MOVSX ESI, WORD PTR FFFFFFB0[EBP]
00008: 0268 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 026B 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 026F 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0272 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 738: 	     				}

00008: 0276 EB 3F                       JMP L0014
00008: 0278                     L0013:

; 740: 	     					p2=inpt->dt.p;

00008: 0278 8B 4D FFFFFFA8              MOV ECX, DWORD PTR FFFFFFA8[EBP]
00008: 027B 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 027F 66 89 45 FFFFFFB0           MOV WORD PTR FFFFFFB0[EBP], AX

; 741: 	     					if(collp[p2]<0)atomp[np++]=p2;

00008: 0283 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 0287 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 028A 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 028F 7D 14                       JGE L0016
00008: 0291 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0294 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0297 0F BF DA                    MOVSX EBX, DX
00008: 029A 66 8B 4D FFFFFFB0           MOV CX, WORD PTR FFFFFFB0[EBP]
00008: 029E 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 02A1 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 02A5                     L0016:

; 742: 	     					collp[p2]=inpt->dt.ct;

00008: 02A5 0F BF 75 FFFFFFB0           MOVSX ESI, WORD PTR FFFFFFB0[EBP]
00008: 02A9 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 02AC 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 02B0 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 02B3 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 744: 	    				} 

00008: 02B7                     L0014:

; 745:            				*(--free)=inpt;

00008: 02B7 83 6D FFFFFFAC 04           SUB DWORD PTR FFFFFFAC[EBP], 00000004
00008: 02BB 8B 4D FFFFFFA8              MOV ECX, DWORD PTR FFFFFFA8[EBP]
00008: 02BE 8B 45 FFFFFFAC              MOV EAX, DWORD PTR FFFFFFAC[EBP]
00008: 02C1 89 08                       MOV DWORD PTR 00000000[EAX], ECX

; 746:            				inpt=inpt->pt;

00008: 02C3 8B 4D FFFFFFA8              MOV ECX, DWORD PTR FFFFFFA8[EBP]
00008: 02C6 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 02C9 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX

; 747:           			}

00008: 02CC                     L0011:
00008: 02CC 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 02CF 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 02D3 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 02D6 0F 84 FFFFFF42              JE L0012
00008: 02DC 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 02DF 0F BF 50 0A                 MOVSX EDX, WORD PTR 0000000A[EAX]
00008: 02E3 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 02E6 0F 84 FFFFFF32              JE L0012

; 749:          			search.inpt[address]=inpt;   

00008: 02EC 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 02F2 8B 4D FFFFFFA8              MOV ECX, DWORD PTR FFFFFFA8[EBP]
00008: 02F5 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 02F8 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 750: 	    		}

00008: 02FB                     L0010:

; 752: 	   			pt1=inpt;

00008: 02FB 8B 45 FFFFFFA8              MOV EAX, DWORD PTR FFFFFFA8[EBP]
00008: 02FE 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 753:        			while((pt1->pt)!=NULL){ 

00008: 0301 E9 0000016B                 JMP L0017
00008: 0306                     L0018:

; 754:         			p2=pt1->dt.p;

00008: 0306 8B 4D FFFFFFA4              MOV ECX, DWORD PTR FFFFFFA4[EBP]
00008: 0309 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 030D 66 89 45 FFFFFFB0           MOV WORD PTR FFFFFFB0[EBP], AX

; 755: 	      			if(collp[p2]<0){

00008: 0311 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 0315 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0318 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 031D 7D 67                       JGE L0019

; 756: 				    	collp[p2]=ecoll[a[p2].c][a[p1].c];

00008: 031F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0322 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0329 29 D3                       SUB EBX, EDX
00008: 032B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 032E 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0334 0F BF BC DE 000000A4        MOVSX EDI, WORD PTR 000000A4[ESI][EBX*8]
00008: 033C 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 0340 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0347 29 D3                       SUB EBX, EDX
00008: 0349 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 034C 8B 35 00000000              MOV ESI, DWORD PTR _a
00008: 0352 0F BF B4 DE 000000A4        MOVSX ESI, WORD PTR 000000A4[ESI][EBX*8]
00008: 035A 8B 1D 00000000              MOV EBX, DWORD PTR _ecoll
00008: 0360 8B 1C B3                    MOV EBX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0363 0F BF 75 FFFFFFB0           MOVSX ESI, WORD PTR FFFFFFB0[EBP]
00008: 0367 66 8B 1C BB                 MOV BX, WORD PTR 00000000[EBX][EDI*4]
00008: 036B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 036E 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 757: 	       				atomp[np++]=p2;

00008: 0372 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 0375 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 0378 0F BF DA                    MOVSX EBX, DX
00008: 037B 66 8B 4D FFFFFFB0           MOV CX, WORD PTR FFFFFFB0[EBP]
00008: 037F 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0382 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX

; 761: 	      			} 

00008: 0386                     L0019:

; 762:         			pt=pt1->pt;

00008: 0386 8B 4D FFFFFFA4              MOV ECX, DWORD PTR FFFFFFA4[EBP]
00008: 0389 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 038C 89 45 FFFFFFA0              MOV DWORD PTR FFFFFFA0[EBP], EAX

; 763:         			while((p1==pt->dt.p)||(p1==pt->dt.q)){ 

00008: 038F E9 000000AE                 JMP L001A
00008: 0394                     L001B:

; 764: 	       				if(p1==pt->dt.p){ 

00008: 0394 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 0397 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 039B 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 039E 75 4E                       JNE L001C

; 765: 	     					p2=pt->dt.q;

00008: 03A0 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 03A3 66 8B 41 0A                 MOV AX, WORD PTR 0000000A[ECX]
00008: 03A7 66 89 45 FFFFFFB0           MOV WORD PTR FFFFFFB0[EBP], AX

; 766: 	     					if(p2<search.n){

00008: 03AB 66 8B 45 FFFFFFB0           MOV AX, WORD PTR FFFFFFB0[EBP]
00008: 03AF 66 3B 05 00000042           CMP AX, WORD PTR _search+00000042
00008: 03B6 7D 75                       JGE L001D

; 767: 	     					if(collp[p2]<0)atomp[np++]=p2;

00008: 03B8 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 03BC 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 03BF 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 03C4 7D 14                       JGE L001E
00008: 03C6 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 03C9 FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 03CC 0F BF DA                    MOVSX EBX, DX
00008: 03CF 66 8B 4D FFFFFFB0           MOV CX, WORD PTR FFFFFFB0[EBP]
00008: 03D3 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 03D6 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 03DA                     L001E:

; 768: 	    						 collp[p2]=pt->dt.ct;

00008: 03DA 0F BF 75 FFFFFFB0           MOVSX ESI, WORD PTR FFFFFFB0[EBP]
00008: 03DE 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 03E1 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 03E5 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 03E8 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 773: 	     				}

00008: 03EC EB 3F                       JMP L001D
00008: 03EE                     L001C:

; 775: 					    	p2=pt->dt.p;

00008: 03EE 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 03F1 66 8B 41 08                 MOV AX, WORD PTR 00000008[ECX]
00008: 03F5 66 89 45 FFFFFFB0           MOV WORD PTR FFFFFFB0[EBP], AX

; 776: 					    	if(collp[p2]<0)atomp[np++]=p2;

00008: 03F9 0F BF 55 FFFFFFB0           MOVSX EDX, WORD PTR FFFFFFB0[EBP]
00008: 03FD 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0400 66 83 3C 50 00              CMP WORD PTR 00000000[EAX][EDX*2], 0000
00008: 0405 7D 14                       JGE L001F
00008: 0407 8B 55 FFFFFFBC              MOV EDX, DWORD PTR FFFFFFBC[EBP]
00008: 040A FF 45 FFFFFFBC              INC DWORD PTR FFFFFFBC[EBP]
00008: 040D 0F BF DA                    MOVSX EBX, DX
00008: 0410 66 8B 4D FFFFFFB0           MOV CX, WORD PTR FFFFFFB0[EBP]
00008: 0414 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00008: 0417 66 89 0C 58                 MOV WORD PTR 00000000[EAX][EBX*2], CX
00008: 041B                     L001F:

; 777: 	     					collp[p2]=pt->dt.ct;

00008: 041B 0F BF 75 FFFFFFB0           MOVSX ESI, WORD PTR FFFFFFB0[EBP]
00008: 041F 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 0422 66 8B 58 0C                 MOV BX, WORD PTR 0000000C[EAX]
00008: 0426 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0429 66 89 1C 70                 MOV WORD PTR 00000000[EAX][ESI*2], BX

; 779: 	    				}  

00008: 042D                     L001D:

; 780: 	       				*(--free)=pt;

00008: 042D 83 6D FFFFFFAC 04           SUB DWORD PTR FFFFFFAC[EBP], 00000004
00008: 0431 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 0434 8B 45 FFFFFFAC              MOV EAX, DWORD PTR FFFFFFAC[EBP]
00008: 0437 89 08                       MOV DWORD PTR 00000000[EAX], ECX

; 781: 	      				pt=pt->pt;

00008: 0439 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 043C 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 043F 89 45 FFFFFFA0              MOV DWORD PTR FFFFFFA0[EBP], EAX

; 783: 	      			} 

00008: 0442                     L001A:
00008: 0442 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 0445 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 0449 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 044C 0F 84 FFFFFF42              JE L001B
00008: 0452 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 0455 0F BF 50 0A                 MOVSX EDX, WORD PTR 0000000A[EAX]
00008: 0459 39 55 08                    CMP DWORD PTR 00000008[EBP], EDX
00008: 045C 0F 84 FFFFFF32              JE L001B

; 784:         			pt1->pt=pt;

00008: 0462 8B 4D FFFFFFA0              MOV ECX, DWORD PTR FFFFFFA0[EBP]
00008: 0465 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 0468 89 48 10                    MOV DWORD PTR 00000010[EAX], ECX

; 785:         			pt1=pt;

00008: 046B 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 046E 89 45 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EAX

; 786:         		}

00008: 0471                     L0017:
00008: 0471 8B 45 FFFFFFA4              MOV EAX, DWORD PTR FFFFFFA4[EBP]
00008: 0474 83 78 10 00                 CMP DWORD PTR 00000010[EAX], 00000000
00008: 0478 0F 85 FFFFFE88              JNE L0018

; 788: 	  }

00008: 047E FF 45 FFFFFFC0              INC DWORD PTR FFFFFFC0[EBP]
00008: 0481                     L000B:
00008: 0481 8B 45 FFFFFFC0              MOV EAX, DWORD PTR FFFFFFC0[EBP]
00008: 0484 3B 45 FFFFFFD8              CMP EAX, DWORD PTR FFFFFFD8[EBP]
00008: 0487 0F 8E FFFFFCED              JLE L000C

; 789:     }

00008: 048D 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0490 03 05 0000001C              ADD EAX, DWORD PTR _search+0000001C
00008: 0496 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX
00008: 0499                     L0007:
00008: 0499 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 049C 3B 45 FFFFFFDC              CMP EAX, DWORD PTR FFFFFFDC[EBP]
00008: 049F 0F 8E FFFFFC97              JLE L0008

; 790:   }  

00008: 04A5 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 04A8 03 05 00000020              ADD EAX, DWORD PTR _search+00000020
00008: 04AE 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX
00008: 04B1                     L0003:
00008: 04B1 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 04B4 3B 45 FFFFFFE0              CMP EAX, DWORD PTR FFFFFFE0[EBP]
00008: 04B7 0F 8E FFFFFC4A              JLE L0004

; 791:  search.free=free;

00008: 04BD 8B 45 FFFFFFAC              MOV EAX, DWORD PTR FFFFFFAC[EBP]
00008: 04C0 A3 00000008                 MOV DWORD PTR _search+00000008, EAX

; 792:  search.nch=nch;

00008: 04C5 8B 45 FFFFFFB8              MOV EAX, DWORD PTR FFFFFFB8[EBP]
00008: 04C8 A3 00000018                 MOV DWORD PTR _search+00000018, EAX

; 793:  return np;

00008: 04CD 8B 45 FFFFFFBC              MOV EAX, DWORD PTR FFFFFFBC[EBP]
00000: 04D0                     L0000:
00000: 04D0                             epilog 
00000: 04D0 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 04D3 5F                          POP EDI
00000: 04D4 5E                          POP ESI
00000: 04D5 5B                          POP EBX
00000: 04D6 5D                          POP EBP
00000: 04D7 C3                          RETN 

Function: _squeeze_table

; 796: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 08                    SUB ESP, 00000008
00000: 0008 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000D 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 0010 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0014                             prolog 

; 797:   tlist *inpt=search.inpt[search.olymp[search.final-1][0]];

00008: 0014 0F BF 35 0000003C           MOVSX ESI, WORD PTR _search+0000003C
00008: 001B 4E                          DEC ESI
00008: 001C 8B 1D 00000000              MOV EBX, DWORD PTR _search
00008: 0022 8B 14 B3                    MOV EDX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0025 8B 32                       MOV ESI, DWORD PTR 00000000[EDX]
00008: 0027 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 002D 8B 04 B3                    MOV EAX, DWORD PTR 00000000[EBX][ESI*4]
00008: 0030 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 798:   search.nch=0;

00008: 0033 C7 05 00000018 00000000     MOV DWORD PTR _search+00000018, 00000000

; 799:   *timea=inpt->dt.t;

00008: 003D 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0040 DD 00                       FLD QWORD PTR 00000000[EAX]
00007: 0042 8B 45 10                    MOV EAX, DWORD PTR 00000010[EBP]
00007: 0045 DD 18                       FSTP QWORD PTR 00000000[EAX]

; 800:   *p1=inpt->dt.p;

00008: 0047 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 004A 0F BF 50 08                 MOVSX EDX, WORD PTR 00000008[EAX]
00008: 004E 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0051 89 10                       MOV DWORD PTR 00000000[EAX], EDX

; 801:   *q1=inpt->dt.q;

00008: 0053 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0056 0F BF 50 0A                 MOVSX EDX, WORD PTR 0000000A[EAX]
00008: 005A 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 005D 89 10                       MOV DWORD PTR 00000000[EAX], EDX

; 802:   if((*q1)>=search.n)

00008: 005F 0F BF 15 00000042           MOVSX EDX, WORD PTR _search+00000042
00008: 0066 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0069 39 10                       CMP DWORD PTR 00000000[EAX], EDX
00008: 006B 7C 1A                       JL L0001

; 804:    squeeze2(*p1);

00008: 006D 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0070 8B 00                       MOV EAX, DWORD PTR 00000000[EAX]
00008: 0072 50                          PUSH EAX
00008: 0073 E8 00000000                 CALL SHORT _squeeze2
00008: 0078 59                          POP ECX

; 805:    return (long)(inpt->dt.ct);

00008: 0079 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 007C 0F BF 40 0C                 MOVSX EAX, WORD PTR 0000000C[EAX]
00000: 0080                             epilog 
00000: 0080 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0083 5E                          POP ESI
00000: 0084 5B                          POP EBX
00000: 0085 5D                          POP EBP
00000: 0086 C3                          RETN 
00008: 0087                     L0001:

; 807:  search.np=squeeze1(*p1,search.collp, search.atomp);

00008: 0087 A1 00000028                 MOV EAX, DWORD PTR _search+00000028
00008: 008C 50                          PUSH EAX
00008: 008D A1 00000030                 MOV EAX, DWORD PTR _search+00000030
00008: 0092 50                          PUSH EAX
00008: 0093 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0096 8B 00                       MOV EAX, DWORD PTR 00000000[EAX]
00008: 0098 50                          PUSH EAX
00008: 0099 E8 00000000                 CALL SHORT _squeeze1
00008: 009E 83 C4 0C                    ADD ESP, 0000000C
00008: 00A1 66 A3 0000003E              MOV WORD PTR _search+0000003E, AX

; 808:  search.nq=squeeze1(*q1,search.collq, search.atomq);

00008: 00A7 A1 0000002C                 MOV EAX, DWORD PTR _search+0000002C
00008: 00AC 50                          PUSH EAX
00008: 00AD A1 00000034                 MOV EAX, DWORD PTR _search+00000034
00008: 00B2 50                          PUSH EAX
00008: 00B3 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 00B6 8B 00                       MOV EAX, DWORD PTR 00000000[EAX]
00008: 00B8 50                          PUSH EAX
00008: 00B9 E8 00000000                 CALL SHORT _squeeze1
00008: 00BE 83 C4 0C                    ADD ESP, 0000000C
00008: 00C1 66 A3 00000040              MOV WORD PTR _search+00000040, AX

; 809:   return (long)(inpt->dt.ct);

00008: 00C7 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00CA 0F BF 40 0C                 MOVSX EAX, WORD PTR 0000000C[EAX]
00000: 00CE                     L0000:
00000: 00CE                             epilog 
00000: 00CE 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 00D1 5E                          POP ESI
00000: 00D2 5B                          POP EBX
00000: 00D3 5D                          POP EBP
00000: 00D4 C3                          RETN 

Function: _get_collp

; 813: short * get_collp(void){return search.collp;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 813: short * get_collp(void){return search.collp;}

00008: 0003 A1 00000030                 MOV EAX, DWORD PTR _search+00000030
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_collq

; 814: short * get_collq(void){return search.collq;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 814: short * get_collq(void){return search.collq;}

00008: 0003 A1 00000034                 MOV EAX, DWORD PTR _search+00000034
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_atomp

; 815: short * get_atomp(void){return search.atomp;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 815: short * get_atomp(void){return search.atomp;}

00008: 0003 A1 00000028                 MOV EAX, DWORD PTR _search+00000028
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_atomq

; 816: short * get_atomq(void){return search.atomq;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 816: short * get_atomq(void){return search.atomq;}

00008: 0003 A1 0000002C                 MOV EAX, DWORD PTR _search+0000002C
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _get_np

; 817: short get_np(void){return search.np;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 817: short get_np(void){return search.np;}

00008: 0003 66 A1 0000003E              MOV AX, WORD PTR _search+0000003E
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _get_nq

; 818: short get_nq(void){return search.nq;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 818: short get_nq(void){return search.nq;}

00008: 0003 66 A1 00000040              MOV AX, WORD PTR _search+00000040
00000: 0009                     L0000:
00000: 0009                             epilog 
00000: 0009 C9                          LEAVE 
00000: 000A C3                          RETN 

Function: _pairs

; 821: { 

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

; 822:   long n_bonds=0;

00008: 0016 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 825:   for (address=0;address<search.z;address++)

00008: 001D C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0024 EB 57                       JMP L0001
00008: 0026                     L0002:

; 826:     for( inpt1=search.inpt[address];inpt1;inpt1=inpt1->pt)

00008: 0026 8B 1D 0000000C              MOV EBX, DWORD PTR _search+0000000C
00008: 002C 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 002F 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0032 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 0035 EB 3D                       JMP L0003
00008: 0037                     L0004:

; 827:       if(inpt1->dt.q<search.n)

00008: 0037 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 003A 66 8B 48 0A                 MOV CX, WORD PTR 0000000A[EAX]
00008: 003E 66 8B 15 00000042           MOV DX, WORD PTR _search+00000042
00008: 0045 66 39 D1                    CMP CX, DX
00008: 0048 7D 21                       JGE L0005

; 830:  	n_bonds+=do_something(inpt1->dt.p,inpt1->dt.q,inpt1->dt.ct);	

00008: 004A 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 004D 66 8B 40 0C                 MOV AX, WORD PTR 0000000C[EAX]
00008: 0051 50                          PUSH EAX
00008: 0052 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0055 66 8B 40 0A                 MOV AX, WORD PTR 0000000A[EAX]
00008: 0059 50                          PUSH EAX
00008: 005A 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 005D 66 8B 40 08                 MOV AX, WORD PTR 00000008[EAX]
00008: 0061 50                          PUSH EAX
00008: 0062 FF 55 08                    CALL DWORD PTR 00000008[EBP]
00008: 0065 83 C4 0C                    ADD ESP, 0000000C
00008: 0068 01 45 FFFFFFF0              ADD DWORD PTR FFFFFFF0[EBP], EAX
00008: 006B                     L0005:
00008: 006B 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 006E 8B 41 10                    MOV EAX, DWORD PTR 00000010[ECX]
00008: 0071 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 0074                     L0003:
00008: 0074 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0078 75 FFFFFFBD                 JNE L0004
00008: 007A FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]
00008: 007D                     L0001:
00008: 007D 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0080 3B 05 00000024              CMP EAX, DWORD PTR _search+00000024
00008: 0086 7C FFFFFF9E                 JL L0002

; 831: return n_bonds;

00008: 0088 8B 45 FFFFFFF0              MOV EAX, DWORD PTR FFFFFFF0[EBP]
00000: 008B                     L0000:
00000: 008B                             epilog 
00000: 008B 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 008E 5B                          POP EBX
00000: 008F 5D                          POP EBP
00000: 0090 C3                          RETN 
