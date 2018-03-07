
Function: _init_gr

; 25: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 27:   if(good)

00008: 0012 83 3D 00000000 00           CMP DWORD PTR _good, 00000000
00008: 0019 74 32                       JE L0001

; 28:     for(i=0;i<maxl;i++)

00008: 001B C7 45 FFFFFFFC 00000000     MOV DWORD PTR FFFFFFFC[EBP], 00000000
00008: 0022 EB 1E                       JMP L0002
00008: 0024                     L0003:

; 29:       gr[i]=0;

00008: 0024 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000000
00008: 002A 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 002D C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 0035 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0038 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000
00008: 003F FF 45 FFFFFFFC              INC DWORD PTR FFFFFFFC[EBP]
00008: 0042                     L0002:
00008: 0042 8B 45 FFFFFFFC              MOV EAX, DWORD PTR FFFFFFFC[EBP]
00008: 0045 3B 05 00000000              CMP EAX, DWORD PTR _maxl
00008: 004B 7C FFFFFFD7                 JL L0003
00008: 004D                     L0001:

; 30:   return;

00000: 004D                     L0000:
00000: 004D                             epilog 
00000: 004D C9                          LEAVE 
00000: 004E C3                          RETN 

Function: _init_corr_func

; 34: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 60                    SUB ESP, 00000060
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 B9 00000018                 MOV ECX, 00000018
00000: 0015 F3 AB                       REP STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 37:   a=(moved_atom *)get_atom();

00008: 0018 E8 00000000                 CALL SHORT _get_atom
00008: 001D A3 00000000                 MOV DWORD PTR _a, EAX

; 38:   bound =get_bounds();

00008: 0022 E8 00000000                 CALL SHORT _get_bounds
00008: 0027 A3 00000000                 MOV DWORD PTR _bound, EAX

; 39:   nAtoms=get_atom_number();

00008: 002C E8 00000000                 CALL SHORT _get_atom_number
00008: 0031 66 A3 00000000              MOV WORD PTR _nAtoms, AX

; 40:   dim=get_dimension();

00008: 0037 E8 00000000                 CALL SHORT _get_dimension
00008: 003C 89 45 FFFFFFA8              MOV DWORD PTR FFFFFFA8[EBP], EAX
00008: 003F DB 45 FFFFFFA8              FILD DWORD PTR FFFFFFA8[EBP]
00007: 0042 DD 1D 00000000              FSTP QWORD PTR _dim

; 41:   if(bound[2].period==1)

00008: 0048 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 004E 83 7A 40 01                 CMP DWORD PTR 00000040[EDX], 00000001
00008: 0052 75 16                       JNE L0001

; 42:     dim=2;

00008: 0054 C7 05 00000004 40000000     MOV DWORD PTR _dim+00000004, 40000000
00008: 005E C7 05 00000000 00000000     MOV DWORD PTR _dim, 00000000
00008: 0068 EB 14                       JMP L0002
00008: 006A                     L0001:

; 44:     dim=3;

00008: 006A C7 05 00000004 40080000     MOV DWORD PTR _dim+00000004, 40080000
00008: 0074 C7 05 00000000 00000000     MOV DWORD PTR _dim, 00000000
00008: 007E                     L0002:

; 45:   do{

00008: 007E                     L0003:

; 46:     close_corr_func();

00008: 007E E8 00000000                 CALL SHORT _close_corr_func

; 47:     printf("Compute correlation function\n");

00008: 0083 68 00000000                 PUSH OFFSET @111
00008: 0088 E8 00000000                 CALL SHORT _printf
00008: 008D 59                          POP ECX

; 48:     if(!yes())return good;

00008: 008E E8 00000000                 CALL SHORT _yes
00008: 0093 83 F8 00                    CMP EAX, 00000000
00008: 0096 75 07                       JNE L0004
00008: 0098 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 009D                             epilog 
00000: 009D C9                          LEAVE 
00000: 009E C3                          RETN 
00008: 009F                     L0004:

; 50:     printf("What is file name?\n");

00008: 009F 68 00000000                 PUSH OFFSET @112
00008: 00A4 E8 00000000                 CALL SHORT _printf
00008: 00A9 59                          POP ECX

; 51:     scanf("%s",fname);

00008: 00AA 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 00AD 50                          PUSH EAX
00008: 00AE 68 00000000                 PUSH OFFSET @113
00008: 00B3 E8 00000000                 CALL SHORT _scanf
00008: 00B8 59                          POP ECX
00008: 00B9 59                          POP ECX

; 52:     path=fopen(fname,"w");

00008: 00BA 68 00000000                 PUSH OFFSET @114
00008: 00BF 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 00C2 50                          PUSH EAX
00008: 00C3 E8 00000000                 CALL SHORT _fopen
00008: 00C8 59                          POP ECX
00008: 00C9 59                          POP ECX
00008: 00CA A3 00000000                 MOV DWORD PTR _path, EAX

; 53:     if(!path)return good;

00008: 00CF 83 3D 00000000 00           CMP DWORD PTR _path, 00000000
00008: 00D6 75 07                       JNE L0005
00008: 00D8 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 00DD                             epilog 
00000: 00DD C9                          LEAVE 
00000: 00DE C3                          RETN 
00008: 00DF                     L0005:

; 55:     printf("Radial bin= %lf\n",bin);

00008: 00DF FF 35 00000004              PUSH DWORD PTR _bin+00000004
00008: 00E5 FF 35 00000000              PUSH DWORD PTR _bin
00008: 00EB 68 00000000                 PUSH OFFSET @115
00008: 00F0 E8 00000000                 CALL SHORT _printf
00008: 00F5 83 C4 0C                    ADD ESP, 0000000C

; 56:     if(!yes())

00008: 00F8 E8 00000000                 CALL SHORT _yes
00008: 00FD 83 F8 00                    CMP EAX, 00000000
00008: 0100 75 1C                       JNE L0006

; 58: 	printf("Radial bin= ?\n");

00008: 0102 68 00000000                 PUSH OFFSET @116
00008: 0107 E8 00000000                 CALL SHORT _printf
00008: 010C 59                          POP ECX

; 59: 	scanf("%lf",&bin);

00008: 010D 68 00000000                 PUSH OFFSET _bin
00008: 0112 68 00000000                 PUSH OFFSET @117
00008: 0117 E8 00000000                 CALL SHORT _scanf
00008: 011C 59                          POP ECX
00008: 011D 59                          POP ECX

; 60:       }

00008: 011E                     L0006:

; 62:     maxl=bound[0].length/(2*bin);

00008: 011E DD 05 00000000              FLD QWORD PTR .data+00000080
00007: 0124 DC 0D 00000000              FMUL QWORD PTR _bin
00007: 012A 8B 15 00000000              MOV EDX, DWORD PTR _bound
00007: 0130 DD 02                       FLD QWORD PTR 00000000[EDX]
00006: 0132 DE F1                       FDIVRP ST(1), ST
00007: 0134 D9 7D FFFFFFA4              FNSTCW WORD PTR FFFFFFA4[EBP]
00007: 0137 8B 55 FFFFFFA4              MOV EDX, DWORD PTR FFFFFFA4[EBP]
00007: 013A 80 4D FFFFFFA5 0C           OR BYTE PTR FFFFFFA5[EBP], 0C
00007: 013E D9 6D FFFFFFA4              FLDCW WORD PTR FFFFFFA4[EBP]
00007: 0141 DB 5D FFFFFFA8              FISTP DWORD PTR FFFFFFA8[EBP]
00008: 0144 89 55 FFFFFFA4              MOV DWORD PTR FFFFFFA4[EBP], EDX
00008: 0147 D9 6D FFFFFFA4              FLDCW WORD PTR FFFFFFA4[EBP]
00008: 014A 8B 55 FFFFFFA8              MOV EDX, DWORD PTR FFFFFFA8[EBP]
00008: 014D 89 15 00000000              MOV DWORD PTR _maxl, EDX

; 63:     gr =(double *)malloc((long)maxl*sizeof(double));

00008: 0153 8B 15 00000000              MOV EDX, DWORD PTR _maxl
00008: 0159 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 0160 52                          PUSH EDX
00008: 0161 E8 00000000                 CALL SHORT _malloc
00008: 0166 59                          POP ECX
00008: 0167 A3 00000000                 MOV DWORD PTR .bss+00000000, EAX

; 64:     if(!gr)return good;

00008: 016C 83 3D 00000000 00           CMP DWORD PTR .bss+00000000, 00000000
00008: 0173 75 07                       JNE L0007
00008: 0175 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 017A                             epilog 
00000: 017A C9                          LEAVE 
00000: 017B C3                          RETN 
00008: 017C                     L0007:

; 65:     for(i=0;i<maxl;i++)

00008: 017C C7 45 FFFFFFA0 00000000     MOV DWORD PTR FFFFFFA0[EBP], 00000000
00008: 0183 EB 1E                       JMP L0008
00008: 0185                     L0009:

; 66:       gr[i]=0;

00008: 0185 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000000
00008: 018B 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 018E C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 0196 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 0199 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000
00008: 01A0 FF 45 FFFFFFA0              INC DWORD PTR FFFFFFA0[EBP]
00008: 01A3                     L0008:
00008: 01A3 8B 45 FFFFFFA0              MOV EAX, DWORD PTR FFFFFFA0[EBP]
00008: 01A6 3B 05 00000000              CMP EAX, DWORD PTR _maxl
00008: 01AC 7C FFFFFFD7                 JL L0009

; 68:     printf("time between measurements= %lf\n",delta1);

00008: 01AE FF 35 00000004              PUSH DWORD PTR _delta1+00000004
00008: 01B4 FF 35 00000000              PUSH DWORD PTR _delta1
00008: 01BA 68 00000000                 PUSH OFFSET @118
00008: 01BF E8 00000000                 CALL SHORT _printf
00008: 01C4 83 C4 0C                    ADD ESP, 0000000C

; 69:     if(!yes())

00008: 01C7 E8 00000000                 CALL SHORT _yes
00008: 01CC 83 F8 00                    CMP EAX, 00000000
00008: 01CF 75 1C                       JNE L000A

; 71: 	printf("time between measurements= ?\n");

00008: 01D1 68 00000000                 PUSH OFFSET @119
00008: 01D6 E8 00000000                 CALL SHORT _printf
00008: 01DB 59                          POP ECX

; 72: 	scanf("%lf",&delta1);

00008: 01DC 68 00000000                 PUSH OFFSET _delta1
00008: 01E1 68 00000000                 PUSH OFFSET @117
00008: 01E6 E8 00000000                 CALL SHORT _scanf
00008: 01EB 59                          POP ECX
00008: 01EC 59                          POP ECX

; 73:       }

00008: 01ED                     L000A:

; 75:     printf("number of measurements= %ld\n",n_mes);

00008: 01ED A1 00000000                 MOV EAX, DWORD PTR _n_mes
00008: 01F2 50                          PUSH EAX
00008: 01F3 68 00000000                 PUSH OFFSET @120
00008: 01F8 E8 00000000                 CALL SHORT _printf
00008: 01FD 59                          POP ECX
00008: 01FE 59                          POP ECX

; 76:     if(!yes())

00008: 01FF E8 00000000                 CALL SHORT _yes
00008: 0204 83 F8 00                    CMP EAX, 00000000
00008: 0207 75 1C                       JNE L000B

; 78: 	printf("number of measurements= ?\n");

00008: 0209 68 00000000                 PUSH OFFSET @121
00008: 020E E8 00000000                 CALL SHORT _printf
00008: 0213 59                          POP ECX

; 79: 	scanf("%ld",&n_mes);

00008: 0214 68 00000000                 PUSH OFFSET _n_mes
00008: 0219 68 00000000                 PUSH OFFSET @122
00008: 021E E8 00000000                 CALL SHORT _scanf
00008: 0223 59                          POP ECX
00008: 0224 59                          POP ECX

; 80:       }

00008: 0225                     L000B:

; 82:     printf("File name for corr. func. =%s?\n",fname);

00008: 0225 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 0228 50                          PUSH EAX
00008: 0229 68 00000000                 PUSH OFFSET @123
00008: 022E E8 00000000                 CALL SHORT _printf
00008: 0233 59                          POP ECX
00008: 0234 59                          POP ECX

; 83:     printf("Radial bin= %lf\n",bin);

00008: 0235 FF 35 00000004              PUSH DWORD PTR _bin+00000004
00008: 023B FF 35 00000000              PUSH DWORD PTR _bin
00008: 0241 68 00000000                 PUSH OFFSET @115
00008: 0246 E8 00000000                 CALL SHORT _printf
00008: 024B 83 C4 0C                    ADD ESP, 0000000C

; 84:     printf("time between measurements= %lf\n",delta1);

00008: 024E FF 35 00000004              PUSH DWORD PTR _delta1+00000004
00008: 0254 FF 35 00000000              PUSH DWORD PTR _delta1
00008: 025A 68 00000000                 PUSH OFFSET @118
00008: 025F E8 00000000                 CALL SHORT _printf
00008: 0264 83 C4 0C                    ADD ESP, 0000000C

; 85:     printf("number of measurements= %ld\n",n_mes);

00008: 0267 A1 00000000                 MOV EAX, DWORD PTR _n_mes
00008: 026C 50                          PUSH EAX
00008: 026D 68 00000000                 PUSH OFFSET @120
00008: 0272 E8 00000000                 CALL SHORT _printf
00008: 0277 59                          POP ECX
00008: 0278 59                          POP ECX

; 86:   }while(!yes());

00008: 0279 E8 00000000                 CALL SHORT _yes
00008: 027E 83 F8 00                    CMP EAX, 00000000
00008: 0281 0F 84 FFFFFDF7              JE L0003

; 88:   delta2=0;

00008: 0287 C7 05 00000004 00000000     MOV DWORD PTR _delta2+00000004, 00000000
00008: 0291 C7 05 00000000 00000000     MOV DWORD PTR _delta2, 00000000

; 89:   i_mes=0;    

00008: 029B C7 05 00000000 00000000     MOV DWORD PTR _i_mes, 00000000

; 90:   good=1;

00008: 02A5 C7 05 00000000 00000001     MOV DWORD PTR _good, 00000001

; 91:   return good;

00008: 02AF A1 00000000                 MOV EAX, DWORD PTR _good
00000: 02B4                     L0000:
00000: 02B4                             epilog 
00000: 02B4 C9                          LEAVE 
00000: 02B5 C3                          RETN 

Function: _compute_gr

; 96: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 83 EC 68                    SUB ESP, 00000068
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0011 B9 0000001A                 MOV ECX, 0000001A
00000: 0016 F3 AB                       REP STOSD 
00000: 0018                             prolog 

; 98:   double lx=bound[0].length;

00008: 0018 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 001E DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 0020 DD 5D FFFFFFA4              FSTP QWORD PTR FFFFFFA4[EBP]

; 99:   double ly=bound[1].length;

00008: 0023 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0029 DD 42 18                    FLD QWORD PTR 00000018[EDX]
00007: 002C DD 5D FFFFFFAC              FSTP QWORD PTR FFFFFFAC[EBP]

; 100:   double lz=bound[2].length;

00008: 002F 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0035 DD 42 30                    FLD QWORD PTR 00000030[EDX]
00007: 0038 DD 5D FFFFFFB4              FSTP QWORD PTR FFFFFFB4[EBP]

; 101:   double lx2=lx/2;

00008: 003B DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00007: 003E DC 0D 00000000              FMUL QWORD PTR .data+00000128
00007: 0044 DD 5D FFFFFFBC              FSTP QWORD PTR FFFFFFBC[EBP]

; 102:   double ly2=ly/2;

00008: 0047 DD 45 FFFFFFAC              FLD QWORD PTR FFFFFFAC[EBP]
00007: 004A DC 0D 00000000              FMUL QWORD PTR .data+00000128
00007: 0050 DD 5D FFFFFFC4              FSTP QWORD PTR FFFFFFC4[EBP]

; 103:   double lz2=lz/2;

00008: 0053 DD 45 FFFFFFB4              FLD QWORD PTR FFFFFFB4[EBP]
00007: 0056 DC 0D 00000000              FMUL QWORD PTR .data+00000128
00007: 005C DD 5D FFFFFFCC              FSTP QWORD PTR FFFFFFCC[EBP]

; 104:   long maxl=lx/2;

00008: 005F DD 45 FFFFFFA4              FLD QWORD PTR FFFFFFA4[EBP]
00007: 0062 DC 0D 00000000              FMUL QWORD PTR .data+00000128
00007: 0068 D9 7D FFFFFFA0              FNSTCW WORD PTR FFFFFFA0[EBP]
00007: 006B 8B 55 FFFFFFA0              MOV EDX, DWORD PTR FFFFFFA0[EBP]
00007: 006E 80 4D FFFFFFA1 0C           OR BYTE PTR FFFFFFA1[EBP], 0C
00007: 0072 D9 6D FFFFFFA0              FLDCW WORD PTR FFFFFFA0[EBP]
00007: 0075 DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0078 89 55 FFFFFFA0              MOV DWORD PTR FFFFFFA0[EBP], EDX
00008: 007B D9 6D FFFFFFA0              FLDCW WORD PTR FFFFFFA0[EBP]
00008: 007E 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 0081 89 55 FFFFFF98              MOV DWORD PTR FFFFFF98[EBP], EDX

; 105:   moveatoms(); 

00008: 0084 E8 00000000                 CALL SHORT _moveatoms

; 106:   for(i=0;i<nAtoms;i++)

00008: 0089 C7 45 FFFFFF90 00000000     MOV DWORD PTR FFFFFF90[EBP], 00000000
00008: 0090 E9 000001BE                 JMP L0001
00008: 0095                     L0002:

; 108:       for(j=0;j<nAtoms;j++)

00008: 0095 C7 45 FFFFFF94 00000000     MOV DWORD PTR FFFFFF94[EBP], 00000000
00008: 009C E9 0000019F                 JMP L0003
00008: 00A1                     L0004:

; 109:         if(j!=i)

00008: 00A1 8B 45 FFFFFF94              MOV EAX, DWORD PTR FFFFFF94[EBP]
00008: 00A4 3B 45 FFFFFF90              CMP EAX, DWORD PTR FFFFFF90[EBP]
00008: 00A7 0F 84 00000190              JE L0005

; 113: 	    rx=a[i].r.x-a[j].r.x;

00008: 00AD 8B 55 FFFFFF94              MOV EDX, DWORD PTR FFFFFF94[EBP]
00008: 00B0 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 00B7 29 D6                       SUB ESI, EDX
00008: 00B9 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00BC 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 00C2 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 00C5 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 00CC 29 D3                       SUB EBX, EDX
00008: 00CE 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00D1 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 00D7 DD 44 DA 48                 FLD QWORD PTR 00000048[EDX][EBX*8]
00007: 00DB DC 64 F7 48                 FSUB QWORD PTR 00000048[EDI][ESI*8]
00007: 00DF DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]

; 114: 	    ry=a[i].r.y-a[j].r.y;

00008: 00E2 8B 55 FFFFFF94              MOV EDX, DWORD PTR FFFFFF94[EBP]
00008: 00E5 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 00EC 29 D6                       SUB ESI, EDX
00008: 00EE 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00F1 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 00F7 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 00FA 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0101 29 D3                       SUB EBX, EDX
00008: 0103 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0106 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 010C DD 44 DA 50                 FLD QWORD PTR 00000050[EDX][EBX*8]
00007: 0110 DC 64 F7 50                 FSUB QWORD PTR 00000050[EDI][ESI*8]
00007: 0114 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]

; 115: 	    rz=a[i].r.z-a[j].r.z;

00008: 0117 8B 55 FFFFFF94              MOV EDX, DWORD PTR FFFFFF94[EBP]
00008: 011A 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0121 29 D6                       SUB ESI, EDX
00008: 0123 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0126 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 012C 8B 55 FFFFFF90              MOV EDX, DWORD PTR FFFFFF90[EBP]
00008: 012F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0136 29 D3                       SUB EBX, EDX
00008: 0138 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 013B 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0141 DD 44 DA 58                 FLD QWORD PTR 00000058[EDX][EBX*8]
00007: 0145 DC 64 F7 58                 FSUB QWORD PTR 00000058[EDI][ESI*8]
00007: 0149 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 116: 	    if(rx<-lx2)rx+=lx;

00008: 014C DD 45 FFFFFFBC              FLD QWORD PTR FFFFFFBC[EBP]
00007: 014F D9 E0                       FCHS 
00007: 0151 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00006: 0154 F1DF                        FCOMIP ST, ST(1), L0006
00007: 0156 DD D8                       FSTP ST
00008: 0158 7A 0B                       JP L0006
00008: 015A 73 09                       JAE L0006
00008: 015C DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 015F DC 45 FFFFFFA4              FADD QWORD PTR FFFFFFA4[EBP]
00007: 0162 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 0165                     L0006:

; 117: 	    if(rx>lx2)rx-=lx;

00008: 0165 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0168 DD 45 FFFFFFBC              FLD QWORD PTR FFFFFFBC[EBP]
00006: 016B F1DF                        FCOMIP ST, ST(1), L0007
00007: 016D DD D8                       FSTP ST
00008: 016F 7A 0B                       JP L0007
00008: 0171 73 09                       JAE L0007
00008: 0173 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00007: 0176 DC 65 FFFFFFA4              FSUB QWORD PTR FFFFFFA4[EBP]
00007: 0179 DD 5D FFFFFFD4              FSTP QWORD PTR FFFFFFD4[EBP]
00008: 017C                     L0007:

; 118: 	    if(ry<-ly2)ry+=ly;

00008: 017C DD 45 FFFFFFC4              FLD QWORD PTR FFFFFFC4[EBP]
00007: 017F D9 E0                       FCHS 
00007: 0181 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00006: 0184 F1DF                        FCOMIP ST, ST(1), L0008
00007: 0186 DD D8                       FSTP ST
00008: 0188 7A 0B                       JP L0008
00008: 018A 73 09                       JAE L0008
00008: 018C DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 018F DC 45 FFFFFFAC              FADD QWORD PTR FFFFFFAC[EBP]
00007: 0192 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 0195                     L0008:

; 119: 	    if(ry>ly2)ry-=ly;

00008: 0195 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 0198 DD 45 FFFFFFC4              FLD QWORD PTR FFFFFFC4[EBP]
00006: 019B F1DF                        FCOMIP ST, ST(1), L0009
00007: 019D DD D8                       FSTP ST
00008: 019F 7A 0B                       JP L0009
00008: 01A1 73 09                       JAE L0009
00008: 01A3 DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 01A6 DC 65 FFFFFFAC              FSUB QWORD PTR FFFFFFAC[EBP]
00007: 01A9 DD 5D FFFFFFDC              FSTP QWORD PTR FFFFFFDC[EBP]
00008: 01AC                     L0009:

; 120: 	    if(rz<-lz2)rz+=lz;

00008: 01AC DD 45 FFFFFFCC              FLD QWORD PTR FFFFFFCC[EBP]
00007: 01AF D9 E0                       FCHS 
00007: 01B1 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00006: 01B4 F1DF                        FCOMIP ST, ST(1), L000A
00007: 01B6 DD D8                       FSTP ST
00008: 01B8 7A 0B                       JP L000A
00008: 01BA 73 09                       JAE L000A
00008: 01BC DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 01BF DC 45 FFFFFFB4              FADD QWORD PTR FFFFFFB4[EBP]
00007: 01C2 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 01C5                     L000A:

; 121: 	    if(rz>lz2)rz-=lz;

00008: 01C5 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 01C8 DD 45 FFFFFFCC              FLD QWORD PTR FFFFFFCC[EBP]
00006: 01CB F1DF                        FCOMIP ST, ST(1), L000B
00007: 01CD DD D8                       FSTP ST
00008: 01CF 7A 0B                       JP L000B
00008: 01D1 73 09                       JAE L000B
00008: 01D3 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 01D6 DC 65 FFFFFFB4              FSUB QWORD PTR FFFFFFB4[EBP]
00007: 01D9 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 01DC                     L000B:

; 122: 	    dd=(long)(sqrt(rx*rx+ry*ry+rz*rz)/bin);

00008: 01DC DD 45 FFFFFFDC              FLD QWORD PTR FFFFFFDC[EBP]
00007: 01DF D8 C8                       FMUL ST, ST
00007: 01E1 DD 45 FFFFFFD4              FLD QWORD PTR FFFFFFD4[EBP]
00006: 01E4 D8 C8                       FMUL ST, ST
00006: 01E6 DE C1                       FADDP ST(1), ST
00007: 01E8 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00006: 01EB D8 C8                       FMUL ST, ST
00006: 01ED DE C1                       FADDP ST(1), ST
00007: 01EF 50                          PUSH EAX
00007: 01F0 50                          PUSH EAX
00007: 01F1 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 01F4 E8 00000000                 CALL SHORT _sqrt
00007: 01F9 59                          POP ECX
00007: 01FA 59                          POP ECX
00007: 01FB DC 35 00000000              FDIV QWORD PTR _bin
00007: 0201 D9 7D FFFFFFA0              FNSTCW WORD PTR FFFFFFA0[EBP]
00007: 0204 8B 55 FFFFFFA0              MOV EDX, DWORD PTR FFFFFFA0[EBP]
00007: 0207 80 4D FFFFFFA1 0C           OR BYTE PTR FFFFFFA1[EBP], 0C
00007: 020B D9 6D FFFFFFA0              FLDCW WORD PTR FFFFFFA0[EBP]
00007: 020E DB 5D FFFFFFEC              FISTP DWORD PTR FFFFFFEC[EBP]
00008: 0211 89 55 FFFFFFA0              MOV DWORD PTR FFFFFFA0[EBP], EDX
00008: 0214 D9 6D FFFFFFA0              FLDCW WORD PTR FFFFFFA0[EBP]
00008: 0217 8B 55 FFFFFFEC              MOV EDX, DWORD PTR FFFFFFEC[EBP]
00008: 021A 89 55 FFFFFF9C              MOV DWORD PTR FFFFFF9C[EBP], EDX

; 123:             if(dd<maxl)

00008: 021D 8B 45 FFFFFF9C              MOV EAX, DWORD PTR FFFFFF9C[EBP]
00008: 0220 3B 45 FFFFFF98              CMP EAX, DWORD PTR FFFFFF98[EBP]
00008: 0223 7D 18                       JGE L000C

; 124: 	      gr[dd]++;

00008: 0225 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000000
00008: 022B 8B 45 FFFFFF9C              MOV EAX, DWORD PTR FFFFFF9C[EBP]
00008: 022E DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 0231 D8 05 00000000              FADD DWORD PTR .data+00000130
00007: 0237 8B 45 FFFFFF9C              MOV EAX, DWORD PTR FFFFFF9C[EBP]
00007: 023A DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]
00008: 023D                     L000C:

; 125: 	  }

00008: 023D                     L0005:
00008: 023D FF 45 FFFFFF94              INC DWORD PTR FFFFFF94[EBP]
00008: 0240                     L0003:
00008: 0240 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 0247 39 55 FFFFFF94              CMP DWORD PTR FFFFFF94[EBP], EDX
00008: 024A 0F 8C FFFFFE51              JL L0004

; 126:     }

00008: 0250 FF 45 FFFFFF90              INC DWORD PTR FFFFFF90[EBP]
00008: 0253                     L0001:
00008: 0253 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 025A 39 55 FFFFFF90              CMP DWORD PTR FFFFFF90[EBP], EDX
00008: 025D 0F 8C FFFFFE32              JL L0002

; 127: }

00000: 0263                     L0000:
00000: 0263                             epilog 
00000: 0263 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0266 5F                          POP EDI
00000: 0267 5E                          POP ESI
00000: 0268 5B                          POP EBX
00000: 0269 5D                          POP EBP
00000: 026A C3                          RETN 

Function: _sqrt

; 552: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: if(x >=0.0)

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 05 00000000              FLD QWORD PTR .data+00000138
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

Function: _corr_func

; 131: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 132:   if(good)

00008: 0012 83 3D 00000000 00           CMP DWORD PTR _good, 00000000
00008: 0019 0F 84 00000096              JE L0001

; 134:       delta2+=delta;

00008: 001F DD 05 00000000              FLD QWORD PTR _delta2
00007: 0025 DC 45 08                    FADD QWORD PTR 00000008[EBP]
00007: 0028 DD 1D 00000000              FSTP QWORD PTR _delta2

; 135:       if (delta2>delta1)

00008: 002E DD 05 00000000              FLD QWORD PTR _delta2
00007: 0034 DD 05 00000000              FLD QWORD PTR _delta1
00006: 003A F1DF                        FCOMIP ST, ST(1), L0002
00007: 003C DD D8                       FSTP ST
00008: 003E 7A 75                       JP L0002
00008: 0040 73 73                       JAE L0002

; 137: 	  delta2-=delta1;

00008: 0042 DD 05 00000000              FLD QWORD PTR _delta2
00007: 0048 DC 25 00000000              FSUB QWORD PTR _delta1
00007: 004E DD 1D 00000000              FSTP QWORD PTR _delta2

; 138: 	  compute_gr();

00008: 0054 E8 00000000                 CALL SHORT _compute_gr

; 139: 	  i_mes++;

00008: 0059 FF 05 00000000              INC DWORD PTR _i_mes

; 140: 	  if(i_mes==n_mes)

00008: 005F 8B 0D 00000000              MOV ECX, DWORD PTR _i_mes
00008: 0065 8B 15 00000000              MOV EDX, DWORD PTR _n_mes
00008: 006B 39 D1                       CMP ECX, EDX
00008: 006D 75 46                       JNE L0003

; 142: 	      i_mes=0;

00008: 006F C7 05 00000000 00000000     MOV DWORD PTR _i_mes, 00000000

; 143:               fprintf(path,"\n%lf %lf\n",get_time(),delta1);

00008: 0079 E8 00000000                 CALL SHORT _get_time
00007: 007E DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]
00008: 0081 FF 35 00000004              PUSH DWORD PTR _delta1+00000004
00008: 0087 FF 35 00000000              PUSH DWORD PTR _delta1
00008: 008D FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0090 FF 75 FFFFFFF8              PUSH DWORD PTR FFFFFFF8[EBP]
00008: 0093 68 00000000                 PUSH OFFSET @167
00008: 0098 A1 00000000                 MOV EAX, DWORD PTR _path
00008: 009D 50                          PUSH EAX
00008: 009E E8 00000000                 CALL SHORT _fprintf
00008: 00A3 83 C4 18                    ADD ESP, 00000018

; 144: 	      good=write_gr();

00008: 00A6 E8 00000000                 CALL SHORT _write_gr
00008: 00AB A3 00000000                 MOV DWORD PTR _good, EAX

; 145: 	      init_gr();

00008: 00B0 E8 00000000                 CALL SHORT _init_gr

; 146: 	    }      

00008: 00B5                     L0003:

; 147: 	}

00008: 00B5                     L0002:

; 148:     }

00008: 00B5                     L0001:

; 149: }

00000: 00B5                     L0000:
00000: 00B5                             epilog 
00000: 00B5 C9                          LEAVE 
00000: 00B6 C3                          RETN 

Function: _write_gr

; 152: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 81 EC 00000228              SUB ESP, 00000228
00000: 0009 57                          PUSH EDI
00000: 000A B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000F 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0013 B9 0000008A                 MOV ECX, 0000008A
00000: 0018 F3 AB                       REP STOSD 
00000: 001A 5F                          POP EDI
00000: 001B                             prolog 

; 156:   int fErr=noErr;

00008: 001B C7 85 FFFFFDE400000000      MOV DWORD PTR FFFFFDE4[EBP], 00000000

; 158:   pi=4*atan((double)1);

00008: 0025 FF 35 00000004              PUSH DWORD PTR .data+00000150+00000004
00008: 002B FF 35 00000000              PUSH DWORD PTR .data+00000150
00008: 0031 E8 00000000                 CALL SHORT _atan
00007: 0036 59                          POP ECX
00007: 0037 59                          POP ECX
00007: 0038 DC 0D 00000000              FMUL QWORD PTR .data+00000158
00007: 003E DD 9D FFFFFDE8              FSTP QWORD PTR FFFFFDE8[EBP]

; 159:   for(i=1;i<maxl;i++)

00008: 0044 C7 85 FFFFFDE000000001      MOV DWORD PTR FFFFFDE0[EBP], 00000001
00008: 004E E9 00000195                 JMP L0001
00008: 0053                     L0002:

; 162:       if(dim>2)dummy=gr[i]/((4*i*(i+1)+1.3333333333)*pi*n_mes*nAtoms);

00008: 0053 DD 05 00000000              FLD QWORD PTR _dim
00007: 0059 DD 05 00000000              FLD QWORD PTR .data+00000080
00006: 005F F1DF                        FCOMIP ST, ST(1), L0003
00007: 0061 DD D8                       FSTP ST
00008: 0063 7A 67                       JP L0003
00008: 0065 73 65                       JAE L0003
00008: 0067 8B 95 FFFFFDE0              MOV EDX, DWORD PTR FFFFFDE0[EBP]
00008: 006D 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0074 8B 8D FFFFFDE0              MOV ECX, DWORD PTR FFFFFDE0[EBP]
00008: 007A 41                          INC ECX
00008: 007B 0F AF D1                    IMUL EDX, ECX
00008: 007E 89 95 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EDX
00008: 0084 DB 85 FFFFFDF8              FILD DWORD PTR FFFFFDF8[EBP]
00007: 008A DC 05 00000000              FADD QWORD PTR .data+00000160
00007: 0090 DC 8D FFFFFDE8              FMUL QWORD PTR FFFFFDE8[EBP]
00007: 0096 DB 05 00000000              FILD DWORD PTR _n_mes
00006: 009C DE C9                       FMULP ST(1), ST
00007: 009E 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00007: 00A5 89 95 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EDX
00007: 00AB DB 85 FFFFFDF8              FILD DWORD PTR FFFFFDF8[EBP]
00006: 00B1 DE C9                       FMULP ST(1), ST
00007: 00B3 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000000
00007: 00B9 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00007: 00BF DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 00C2 DE F1                       FDIVRP ST(1), ST
00007: 00C4 DD 9D FFFFFDF0              FSTP QWORD PTR FFFFFDF0[EBP]
00008: 00CA EB 54                       JMP L0004
00008: 00CC                     L0003:

; 163:       else dummy=gr[i]/((2*i+1)*pi*n_mes*nAtoms);

00008: 00CC 8B 95 FFFFFDE0              MOV EDX, DWORD PTR FFFFFDE0[EBP]
00008: 00D2 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00D9 42                          INC EDX
00008: 00DA 89 95 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EDX
00008: 00E0 DB 85 FFFFFDF8              FILD DWORD PTR FFFFFDF8[EBP]
00007: 00E6 DC 8D FFFFFDE8              FMUL QWORD PTR FFFFFDE8[EBP]
00007: 00EC DB 05 00000000              FILD DWORD PTR _n_mes
00006: 00F2 DE C9                       FMULP ST(1), ST
00007: 00F4 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00007: 00FB 89 95 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EDX
00007: 0101 DB 85 FFFFFDF8              FILD DWORD PTR FFFFFDF8[EBP]
00006: 0107 DE C9                       FMULP ST(1), ST
00007: 0109 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000000
00007: 010F 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00007: 0115 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 0118 DE F1                       FDIVRP ST(1), ST
00007: 011A DD 9D FFFFFDF0              FSTP QWORD PTR FFFFFDF0[EBP]
00008: 0120                     L0004:

; 164:       nbyte=sprintf(&s[0],"%lf %le \n",i*bin,dummy);

00008: 0120 FF B5 FFFFFDF4              PUSH DWORD PTR FFFFFDF4[EBP]
00008: 0126 FF B5 FFFFFDF0              PUSH DWORD PTR FFFFFDF0[EBP]
00008: 012C 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00008: 0132 89 85 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EAX
00008: 0138 DB 85 FFFFFDF8              FILD DWORD PTR FFFFFDF8[EBP]
00007: 013E DC 0D 00000000              FMUL QWORD PTR _bin
00007: 0144 50                          PUSH EAX
00007: 0145 50                          PUSH EAX
00007: 0146 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0149 68 00000000                 PUSH OFFSET @184
00008: 014E 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0154 50                          PUSH EAX
00008: 0155 E8 00000000                 CALL SHORT _sprintf
00008: 015A 83 C4 18                    ADD ESP, 00000018
00008: 015D 89 85 FFFFFDDC              MOV DWORD PTR FFFFFDDC[EBP], EAX

; 165:       if(nbyte<=0){fclose(path);free(gr); return 0;}

00008: 0163 83 BD FFFFFDDC00            CMP DWORD PTR FFFFFDDC[EBP], 00000000
00008: 016A 7F 1F                       JG L0005
00008: 016C A1 00000000                 MOV EAX, DWORD PTR _path
00008: 0171 50                          PUSH EAX
00008: 0172 E8 00000000                 CALL SHORT _fclose
00008: 0177 59                          POP ECX
00008: 0178 A1 00000000                 MOV EAX, DWORD PTR .bss+00000000
00008: 017D 50                          PUSH EAX
00008: 017E E8 00000000                 CALL SHORT _free
00008: 0183 59                          POP ECX
00008: 0184 B8 00000000                 MOV EAX, 00000000
00000: 0189                             epilog 
00000: 0189 C9                          LEAVE 
00000: 018A C3                          RETN 
00008: 018B                     L0005:

; 166:       fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 018B A1 00000000                 MOV EAX, DWORD PTR _path
00008: 0190 50                          PUSH EAX
00008: 0191 FF B5 FFFFFDDC              PUSH DWORD PTR FFFFFDDC[EBP]
00008: 0197 6A 01                       PUSH 00000001
00008: 0199 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 019F 50                          PUSH EAX
00008: 01A0 E8 00000000                 CALL SHORT _fwrite
00008: 01A5 83 C4 10                    ADD ESP, 00000010
00008: 01A8 39 85 FFFFFDDC              CMP DWORD PTR FFFFFDDC[EBP], EAX
00008: 01AE 0F 95 C2                    SETNE DL
00008: 01B1 83 E2 01                    AND EDX, 00000001
00008: 01B4 89 95 FFFFFDE4              MOV DWORD PTR FFFFFDE4[EBP], EDX

; 167:       if(fErr){fclose(path);free(gr);return 0;}

00008: 01BA 83 BD FFFFFDE400            CMP DWORD PTR FFFFFDE4[EBP], 00000000
00008: 01C1 74 1F                       JE L0006
00008: 01C3 A1 00000000                 MOV EAX, DWORD PTR _path
00008: 01C8 50                          PUSH EAX
00008: 01C9 E8 00000000                 CALL SHORT _fclose
00008: 01CE 59                          POP ECX
00008: 01CF A1 00000000                 MOV EAX, DWORD PTR .bss+00000000
00008: 01D4 50                          PUSH EAX
00008: 01D5 E8 00000000                 CALL SHORT _free
00008: 01DA 59                          POP ECX
00008: 01DB B8 00000000                 MOV EAX, 00000000
00000: 01E0                             epilog 
00000: 01E0 C9                          LEAVE 
00000: 01E1 C3                          RETN 
00008: 01E2                     L0006:

; 168:     }

00008: 01E2 FF 85 FFFFFDE0              INC DWORD PTR FFFFFDE0[EBP]
00008: 01E8                     L0001:
00008: 01E8 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00008: 01EE 3B 05 00000000              CMP EAX, DWORD PTR _maxl
00008: 01F4 0F 8C FFFFFE59              JL L0002

; 169:   return 1;

00008: 01FA B8 00000001                 MOV EAX, 00000001
00000: 01FF                     L0000:
00000: 01FF                             epilog 
00000: 01FF C9                          LEAVE 
00000: 0200 C3                          RETN 

Function: _atan

; 932:  {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 936: 	fld x

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]

; 937: 	fld1

00007: 0006 D9 E8                       FLD1 

; 938: 	fpatan

00006: 0008 D9 F3                       FPATAN 

; 939: 	fstp x

00007: 000A DD 5D 08                    FSTP QWORD PTR 00000008[EBP]

; 941:  return x ;

00008: 000D DD 45 08                    FLD QWORD PTR 00000008[EBP]
00000: 0010                     L0000:
00000: 0010                             epilog 
00000: 0010 C9                          LEAVE 
00000: 0011 C3                          RETN 

Function: _close_corr_func

; 174: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 175:   if(good)

00008: 0003 83 3D 00000000 00           CMP DWORD PTR _good, 00000000
00008: 000A 74 24                       JE L0001

; 177:       good=0;

00008: 000C C7 05 00000000 00000000     MOV DWORD PTR _good, 00000000

; 178:       free(gr);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR .bss+00000000
00008: 001B 50                          PUSH EAX
00008: 001C E8 00000000                 CALL SHORT _free
00008: 0021 59                          POP ECX

; 179:       fclose(path);

00008: 0022 A1 00000000                 MOV EAX, DWORD PTR _path
00008: 0027 50                          PUSH EAX
00008: 0028 E8 00000000                 CALL SHORT _fclose
00008: 002D 59                          POP ECX

; 180:       return;

00000: 002E                             epilog 
00000: 002E C9                          LEAVE 
00000: 002F C3                          RETN 
00008: 0030                     L0001:

; 182: }

00000: 0030                     L0000:
00000: 0030                             epilog 
00000: 0030 C9                          LEAVE 
00000: 0031 C3                          RETN 
