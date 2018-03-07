
Function: _is_nucleus

; 37: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 38:   return nucleus;

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _nucleus
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _nonnative

; 42: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 43:   int  nnn=0;

00008: 0012 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000

; 44:   well_type k=ct;

00008: 0019 0F BF 55 10                 MOVSX EDX, WORD PTR 00000010[EBP]
00008: 001D 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX

; 45:   if((p>-1)&&(q>-1)&&(is_internal(k))&&(!is_bond(k))) 

00008: 0020 66 83 7D 08 FFFFFFFF        CMP WORD PTR 00000008[EBP], FFFFFFFF
00008: 0025 7E 3D                       JLE L0001
00008: 0027 66 83 7D 0C FFFFFFFF        CMP WORD PTR 0000000C[EBP], FFFFFFFF
00008: 002C 7E 36                       JLE L0001
00008: 002E FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0031 E8 00000000                 CALL SHORT _is_internal
00008: 0036 59                          POP ECX
00008: 0037 83 F8 00                    CMP EAX, 00000000
00008: 003A 74 28                       JE L0001
00008: 003C FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 003F E8 00000000                 CALL SHORT _is_bond
00008: 0044 59                          POP ECX
00008: 0045 83 F8 00                    CMP EAX, 00000000
00008: 0048 75 1A                       JNE L0001

; 47:      if(etot(k)<0)nnn++;

00008: 004A FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 004D E8 00000000                 CALL SHORT _etot
00007: 0052 59                          POP ECX
00007: 0053 DD 05 00000000              FLD QWORD PTR .data+00000010
00006: 0059 F1DF                        FCOMIP ST, ST(1), L0002
00007: 005B DD D8                       FSTP ST
00008: 005D 7A 05                       JP L0002
00008: 005F 76 03                       JBE L0002
00008: 0061 FF 45 FFFFFFF8              INC DWORD PTR FFFFFFF8[EBP]
00008: 0064                     L0002:

; 48:     }

00008: 0064                     L0001:

; 49: return nnn;    

00008: 0064 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00000: 0067                     L0000:
00000: 0067                             epilog 
00000: 0067 C9                          LEAVE 
00000: 0068 C3                          RETN 

Function: _close_rms

; 54: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 55:   if(good)

00008: 0003 83 3D 00000000 00           CMP DWORD PTR .bss+00000008, 00000000
00008: 000A 74 61                       JE L0001

; 57:       good=0;

00008: 000C C7 05 00000000 00000000     MOV DWORD PTR .bss+00000008, 00000000

; 58:       fclose(echo_path);

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 001B 50                          PUSH EAX
00008: 001C E8 00000000                 CALL SHORT _fclose
00008: 0021 59                          POP ECX

; 59:       if(x)

00008: 0022 83 3D 00000000 00           CMP DWORD PTR _x, 00000000
00008: 0029 74 42                       JE L0002

; 61: 	  free(x[0]);

00008: 002B 8B 15 00000000              MOV EDX, DWORD PTR _x
00008: 0031 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 0033 50                          PUSH EAX
00008: 0034 E8 00000000                 CALL SHORT _free
00008: 0039 59                          POP ECX

; 62: 	  free(y[0]);

00008: 003A 8B 15 00000000              MOV EDX, DWORD PTR _y
00008: 0040 8B 02                       MOV EAX, DWORD PTR 00000000[EDX]
00008: 0042 50                          PUSH EAX
00008: 0043 E8 00000000                 CALL SHORT _free
00008: 0048 59                          POP ECX

; 63: 	  free(x);

00008: 0049 A1 00000000                 MOV EAX, DWORD PTR _x
00008: 004E 50                          PUSH EAX
00008: 004F E8 00000000                 CALL SHORT _free
00008: 0054 59                          POP ECX

; 64: 	  free(y);

00008: 0055 A1 00000000                 MOV EAX, DWORD PTR _y
00008: 005A 50                          PUSH EAX
00008: 005B E8 00000000                 CALL SHORT _free
00008: 0060 59                          POP ECX

; 65: 	  free(dr);

00008: 0061 A1 00000000                 MOV EAX, DWORD PTR _dr
00008: 0066 50                          PUSH EAX
00008: 0067 E8 00000000                 CALL SHORT _free
00008: 006C 59                          POP ECX

; 66: 	}

00008: 006D                     L0002:

; 67:     }

00008: 006D                     L0001:

; 68: return;

00000: 006D                     L0000:
00000: 006D                             epilog 
00000: 006D C9                          LEAVE 
00000: 006E C3                          RETN 

Function: _init_rms

; 72: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 81 EC 00000088              SUB ESP, 00000088
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0014 B9 00000022                 MOV ECX, 00000022
00000: 0019 F3 AB                       REP STOSD 
00000: 001B                             prolog 

; 77:   good=0;

00008: 001B C7 05 00000000 00000000     MOV DWORD PTR .bss+00000008, 00000000

; 78:   a=(moved_atom *)get_atom();

00008: 0025 E8 00000000                 CALL SHORT _get_atom
00008: 002A A3 00000000                 MOV DWORD PTR _a, EAX

; 79:   bound =get_bounds();

00008: 002F E8 00000000                 CALL SHORT _get_bounds
00008: 0034 A3 00000000                 MOV DWORD PTR _bound, EAX

; 80:   printf("We do not compute rms\n");

00008: 0039 68 00000000                 PUSH OFFSET @215
00008: 003E E8 00000000                 CALL SHORT _printf
00008: 0043 59                          POP ECX

; 81:   if(yes())return good;

00008: 0044 E8 00000000                 CALL SHORT _yes
00008: 0049 83 F8 00                    CMP EAX, 00000000
00008: 004C 74 0D                       JE L0001
00008: 004E A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0053                             epilog 
00000: 0053 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0056 5F                          POP EDI
00000: 0057 5E                          POP ESI
00000: 0058 5B                          POP EBX
00000: 0059 5D                          POP EBP
00000: 005A C3                          RETN 
00008: 005B                     L0001:

; 83:   i_mes=0;    

00008: 005B C7 05 00000000 00000000     MOV DWORD PTR _i_mes, 00000000

; 85:   printf("What is rms file name?\n");

00008: 0065 68 00000000                 PUSH OFFSET @216
00008: 006A E8 00000000                 CALL SHORT _printf
00008: 006F 59                          POP ECX

; 86:   scanf("%s",name);

00008: 0070 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 0073 50                          PUSH EAX
00008: 0074 68 00000000                 PUSH OFFSET @217
00008: 0079 E8 00000000                 CALL SHORT _scanf
00008: 007E 59                          POP ECX
00008: 007F 59                          POP ECX

; 87:   if(!open_rms_file(name))return good;

00008: 0080 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 0083 50                          PUSH EAX
00008: 0084 E8 00000000                 CALL SHORT _open_rms_file
00008: 0089 59                          POP ECX
00008: 008A 83 F8 00                    CMP EAX, 00000000
00008: 008D 75 0D                       JNE L0002
00008: 008F A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0094                             epilog 
00000: 0094 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0097 5F                          POP EDI
00000: 0098 5E                          POP ESI
00000: 0099 5B                          POP EBX
00000: 009A 5D                          POP EBP
00000: 009B C3                          RETN 
00008: 009C                     L0002:

; 89:   printf("What is contact outputfile\n");

00008: 009C 68 00000000                 PUSH OFFSET @218
00008: 00A1 E8 00000000                 CALL SHORT _printf
00008: 00A6 59                          POP ECX

; 90:   scanf("%s",cont_file_name);

00008: 00A7 68 00000000                 PUSH OFFSET _cont_file_name
00008: 00AC 68 00000000                 PUSH OFFSET @217
00008: 00B1 E8 00000000                 CALL SHORT _scanf
00008: 00B6 59                          POP ECX
00008: 00B7 59                          POP ECX

; 92:     printf("time between measurements= %lf\n",delta1);

00008: 00B8 FF 35 00000004              PUSH DWORD PTR _delta1+00000004
00008: 00BE FF 35 00000000              PUSH DWORD PTR _delta1
00008: 00C4 68 00000000                 PUSH OFFSET @219
00008: 00C9 E8 00000000                 CALL SHORT _printf
00008: 00CE 83 C4 0C                    ADD ESP, 0000000C

; 93:     if(!yes())

00008: 00D1 E8 00000000                 CALL SHORT _yes
00008: 00D6 83 F8 00                    CMP EAX, 00000000
00008: 00D9 75 1C                       JNE L0003

; 95: 	printf("time between measurements= ?\n");

00008: 00DB 68 00000000                 PUSH OFFSET @220
00008: 00E0 E8 00000000                 CALL SHORT _printf
00008: 00E5 59                          POP ECX

; 96: 	scanf("%lf",&delta1);

00008: 00E6 68 00000000                 PUSH OFFSET _delta1
00008: 00EB 68 00000000                 PUSH OFFSET @221
00008: 00F0 E8 00000000                 CALL SHORT _scanf
00008: 00F5 59                          POP ECX
00008: 00F6 59                          POP ECX

; 97:       }

00008: 00F7                     L0003:

; 99:     printf("number of measurements= %ld\n",n_mes);

00008: 00F7 A1 00000000                 MOV EAX, DWORD PTR _n_mes
00008: 00FC 50                          PUSH EAX
00008: 00FD 68 00000000                 PUSH OFFSET @222
00008: 0102 E8 00000000                 CALL SHORT _printf
00008: 0107 59                          POP ECX
00008: 0108 59                          POP ECX

; 100:     if(!yes())

00008: 0109 E8 00000000                 CALL SHORT _yes
00008: 010E 83 F8 00                    CMP EAX, 00000000
00008: 0111 75 1C                       JNE L0004

; 102: 	printf("number of measurements= ?\n");

00008: 0113 68 00000000                 PUSH OFFSET @223
00008: 0118 E8 00000000                 CALL SHORT _printf
00008: 011D 59                          POP ECX

; 103: 	scanf("%ld",&n_mes);

00008: 011E 68 00000000                 PUSH OFFSET _n_mes
00008: 0123 68 00000000                 PUSH OFFSET @224
00008: 0128 E8 00000000                 CALL SHORT _scanf
00008: 012D 59                          POP ECX
00008: 012E 59                          POP ECX

; 104:       }

00008: 012F                     L0004:

; 107:   infile=0;

00008: 012F C7 85 FFFFFF6C00000000      MOV DWORD PTR FFFFFF6C[EBP], 00000000

; 108:   printf("We do not use native file\n");

00008: 0139 68 00000000                 PUSH OFFSET @225
00008: 013E E8 00000000                 CALL SHORT _printf
00008: 0143 59                          POP ECX

; 109:   if(!yes())

00008: 0144 E8 00000000                 CALL SHORT _yes
00008: 0149 83 F8 00                    CMP EAX, 00000000
00008: 014C 75 31                       JNE L0005

; 111:       printf("native file name?\n");

00008: 014E 68 00000000                 PUSH OFFSET @226
00008: 0153 E8 00000000                 CALL SHORT _printf
00008: 0158 59                          POP ECX

; 112:       scanf("%s",name);

00008: 0159 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 015C 50                          PUSH EAX
00008: 015D 68 00000000                 PUSH OFFSET @217
00008: 0162 E8 00000000                 CALL SHORT _scanf
00008: 0167 59                          POP ECX
00008: 0168 59                          POP ECX

; 113:       infile=fopen(name,"r");

00008: 0169 68 00000000                 PUSH OFFSET @227
00008: 016E 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 0171 50                          PUSH EAX
00008: 0172 E8 00000000                 CALL SHORT _fopen
00008: 0177 59                          POP ECX
00008: 0178 59                          POP ECX
00008: 0179 89 85 FFFFFF6C              MOV DWORD PTR FFFFFF6C[EBP], EAX

; 114:     }

00008: 017F                     L0005:

; 115:   printf("E_max?\n");

00008: 017F 68 00000000                 PUSH OFFSET @228
00008: 0184 E8 00000000                 CALL SHORT _printf
00008: 0189 59                          POP ECX

; 116:   scanf("%lf",&E_max);

00008: 018A 68 00000000                 PUSH OFFSET _E_max
00008: 018F 68 00000000                 PUSH OFFSET @221
00008: 0194 E8 00000000                 CALL SHORT _scanf
00008: 0199 59                          POP ECX
00008: 019A 59                          POP ECX

; 117:   printf("E_min?\n");

00008: 019B 68 00000000                 PUSH OFFSET @229
00008: 01A0 E8 00000000                 CALL SHORT _printf
00008: 01A5 59                          POP ECX

; 118:   scanf("%lf",&E_min);

00008: 01A6 68 00000000                 PUSH OFFSET _E_min
00008: 01AB 68 00000000                 PUSH OFFSET @221
00008: 01B0 E8 00000000                 CALL SHORT _scanf
00008: 01B5 59                          POP ECX
00008: 01B6 59                          POP ECX

; 119:   when_file=0; 

00008: 01B7 C7 05 00000000 00000000     MOV DWORD PTR _when_file, 00000000

; 120:   printf("We do not use when file\n");

00008: 01C1 68 00000000                 PUSH OFFSET @230
00008: 01C6 E8 00000000                 CALL SHORT _printf
00008: 01CB 59                          POP ECX

; 121:   if(!yes())

00008: 01CC E8 00000000                 CALL SHORT _yes
00008: 01D1 83 F8 00                    CMP EAX, 00000000
00008: 01D4 75 30                       JNE L0006

; 123:       printf("when file name?\n");

00008: 01D6 68 00000000                 PUSH OFFSET @231
00008: 01DB E8 00000000                 CALL SHORT _printf
00008: 01E0 59                          POP ECX

; 124:       scanf("%s",name);

00008: 01E1 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 01E4 50                          PUSH EAX
00008: 01E5 68 00000000                 PUSH OFFSET @217
00008: 01EA E8 00000000                 CALL SHORT _scanf
00008: 01EF 59                          POP ECX
00008: 01F0 59                          POP ECX

; 125:       when_file=fopen(name,"r");

00008: 01F1 68 00000000                 PUSH OFFSET @227
00008: 01F6 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 01F9 50                          PUSH EAX
00008: 01FA E8 00000000                 CALL SHORT _fopen
00008: 01FF 59                          POP ECX
00008: 0200 59                          POP ECX
00008: 0201 A3 00000000                 MOV DWORD PTR _when_file, EAX

; 126:     }

00008: 0206                     L0006:

; 127:   if(infile){

00008: 0206 83 BD FFFFFF6C00            CMP DWORD PTR FFFFFF6C[EBP], 00000000
00008: 020D 0F 84 00000448              JE L0007

; 128:     fscanf(infile,"%ld %ld %lf",&nn,&n01,&box);

00008: 0213 68 00000000                 PUSH OFFSET _box
00008: 0218 68 00000000                 PUSH OFFSET _n01
00008: 021D 68 00000000                 PUSH OFFSET _nn
00008: 0222 68 00000000                 PUSH OFFSET @232
00008: 0227 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 022D E8 00000000                 CALL SHORT _fscanf
00008: 0232 83 C4 14                    ADD ESP, 00000014

; 129:     n0=n01-1;

00008: 0235 8B 15 00000000              MOV EDX, DWORD PTR _n01
00008: 023B 4A                          DEC EDX
00008: 023C 89 15 00000000              MOV DWORD PTR _n0, EDX

; 130:     box2=box/2;

00008: 0242 DD 05 00000000              FLD QWORD PTR _box
00007: 0248 DC 0D 00000000              FMUL QWORD PTR .data+00000170
00007: 024E DD 9D FFFFFF7C              FSTP QWORD PTR FFFFFF7C[EBP]

; 131:     x=(double **)malloc(nn*sizeof(double*));

00008: 0254 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 025A 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0261 52                          PUSH EDX
00008: 0262 E8 00000000                 CALL SHORT _malloc
00008: 0267 59                          POP ECX
00008: 0268 A3 00000000                 MOV DWORD PTR _x, EAX

; 132:     if(!x)return 0;

00008: 026D 83 3D 00000000 00           CMP DWORD PTR _x, 00000000
00008: 0274 75 0D                       JNE L0008
00008: 0276 B8 00000000                 MOV EAX, 00000000
00000: 027B                             epilog 
00000: 027B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 027E 5F                          POP EDI
00000: 027F 5E                          POP ESI
00000: 0280 5B                          POP EBX
00000: 0281 5D                          POP EBP
00000: 0282 C3                          RETN 
00008: 0283                     L0008:

; 133:     x[0]=(double *)malloc(nn*3*sizeof(double));

00008: 0283 8B 1D 00000000              MOV EBX, DWORD PTR _nn
00008: 0289 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 028C 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 0293 53                          PUSH EBX
00008: 0294 E8 00000000                 CALL SHORT _malloc
00008: 0299 59                          POP ECX
00008: 029A 8B 15 00000000              MOV EDX, DWORD PTR _x
00008: 02A0 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 134:     if(!x[0])return 0;

00008: 02A2 8B 15 00000000              MOV EDX, DWORD PTR _x
00008: 02A8 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 02AB 75 0D                       JNE L0009
00008: 02AD B8 00000000                 MOV EAX, 00000000
00000: 02B2                             epilog 
00000: 02B2 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02B5 5F                          POP EDI
00000: 02B6 5E                          POP ESI
00000: 02B7 5B                          POP EBX
00000: 02B8 5D                          POP EBP
00000: 02B9 C3                          RETN 
00008: 02BA                     L0009:

; 135:     y=(double **)malloc(nn*sizeof(double*));

00008: 02BA 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 02C0 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 02C7 52                          PUSH EDX
00008: 02C8 E8 00000000                 CALL SHORT _malloc
00008: 02CD 59                          POP ECX
00008: 02CE A3 00000000                 MOV DWORD PTR _y, EAX

; 136:     if(!y)return 0;

00008: 02D3 83 3D 00000000 00           CMP DWORD PTR _y, 00000000
00008: 02DA 75 0D                       JNE L000A
00008: 02DC B8 00000000                 MOV EAX, 00000000
00000: 02E1                             epilog 
00000: 02E1 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 02E4 5F                          POP EDI
00000: 02E5 5E                          POP ESI
00000: 02E6 5B                          POP EBX
00000: 02E7 5D                          POP EBP
00000: 02E8 C3                          RETN 
00008: 02E9                     L000A:

; 137:     y[0]=(double *)malloc(nn*3*sizeof(double));

00008: 02E9 8B 1D 00000000              MOV EBX, DWORD PTR _nn
00008: 02EF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 02F2 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 02F9 53                          PUSH EBX
00008: 02FA E8 00000000                 CALL SHORT _malloc
00008: 02FF 59                          POP ECX
00008: 0300 8B 15 00000000              MOV EDX, DWORD PTR _y
00008: 0306 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 138:     if(!y[0])return 0;

00008: 0308 8B 15 00000000              MOV EDX, DWORD PTR _y
00008: 030E 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 0311 75 0D                       JNE L000B
00008: 0313 B8 00000000                 MOV EAX, 00000000
00000: 0318                             epilog 
00000: 0318 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 031B 5F                          POP EDI
00000: 031C 5E                          POP ESI
00000: 031D 5B                          POP EBX
00000: 031E 5D                          POP EBP
00000: 031F C3                          RETN 
00008: 0320                     L000B:

; 139:     dr=(double *)malloc(nn*sizeof(double));

00008: 0320 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 0326 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 032D 52                          PUSH EDX
00008: 032E E8 00000000                 CALL SHORT _malloc
00008: 0333 59                          POP ECX
00008: 0334 A3 00000000                 MOV DWORD PTR _dr, EAX

; 140:     if(!dr)return 0;

00008: 0339 83 3D 00000000 00           CMP DWORD PTR _dr, 00000000
00008: 0340 75 0D                       JNE L000C
00008: 0342 B8 00000000                 MOV EAX, 00000000
00000: 0347                             epilog 
00000: 0347 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 034A 5F                          POP EDI
00000: 034B 5E                          POP ESI
00000: 034C 5B                          POP EBX
00000: 034D 5D                          POP EBP
00000: 034E C3                          RETN 
00008: 034F                     L000C:

; 141:     dr[0]=0;

00008: 034F 8B 15 00000000              MOV EDX, DWORD PTR _dr
00008: 0355 C7 42 04 00000000           MOV DWORD PTR 00000004[EDX], 00000000
00008: 035C C7 02 00000000              MOV DWORD PTR 00000000[EDX], 00000000

; 142:     for(i=1;i<nn;i++)

00008: 0362 C7 85 FFFFFF7000000001      MOV DWORD PTR FFFFFF70[EBP], 00000001
00008: 036C EB 6B                       JMP L000D
00008: 036E                     L000E:

; 144: 	dr[i]=0;

00008: 036E 8B 15 00000000              MOV EDX, DWORD PTR _dr
00008: 0374 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 037A C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 0382 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0388 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000

; 145: 	y[i]=y[i-1]+3;

00008: 038F 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 0395 4E                          DEC ESI
00008: 0396 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 039C 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 039F 83 C6 18                    ADD ESI, 00000018
00008: 03A2 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 03A8 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 03AE 89 34 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ESI

; 146: 	x[i]=x[i-1]+3;

00008: 03B1 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 03B7 4E                          DEC ESI
00008: 03B8 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 03BE 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 03C1 83 C6 18                    ADD ESI, 00000018
00008: 03C4 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 03CA 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 03D0 89 34 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ESI

; 147:       }

00008: 03D3 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 03D9                     L000D:
00008: 03D9 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 03DF 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 03E5 7C FFFFFF87                 JL L000E

; 149:     for(i=0;i<nn;i++)

00008: 03E7 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 03F1 EB 76                       JMP L000F
00008: 03F3                     L0010:

; 150:       for(j=0;j<3;j++)

00008: 03F3 C7 85 FFFFFF7400000000      MOV DWORD PTR FFFFFF74[EBP], 00000000
00008: 03FD EB 5B                       JMP L0011
00008: 03FF                     L0012:

; 152: 	  fscanf(infile,"%lf",&(x[i][j]));

00008: 03FF 8B 9D FFFFFF74              MOV EBX, DWORD PTR FFFFFF74[EBP]
00008: 0405 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 040C 8B 35 00000000              MOV ESI, DWORD PTR _x
00008: 0412 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0418 03 1C 86                    ADD EBX, DWORD PTR 00000000[ESI][EAX*4]
00008: 041B 53                          PUSH EBX
00008: 041C 68 00000000                 PUSH OFFSET @221
00008: 0421 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0427 E8 00000000                 CALL SHORT _fscanf
00008: 042C 83 C4 0C                    ADD ESP, 0000000C

; 153: 	  if(feof(infile)){fclose(infile);return 0;}

00008: 042F 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0435 80 78 0C 00                 CMP BYTE PTR 0000000C[EAX], 00
00008: 0439 74 19                       JE L0013
00008: 043B FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0441 E8 00000000                 CALL SHORT _fclose
00008: 0446 59                          POP ECX
00008: 0447 B8 00000000                 MOV EAX, 00000000
00000: 044C                             epilog 
00000: 044C 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 044F 5F                          POP EDI
00000: 0450 5E                          POP ESI
00000: 0451 5B                          POP EBX
00000: 0452 5D                          POP EBP
00000: 0453 C3                          RETN 
00008: 0454                     L0013:

; 154: 	}

00008: 0454 FF 85 FFFFFF74              INC DWORD PTR FFFFFF74[EBP]
00008: 045A                     L0011:
00008: 045A 83 BD FFFFFF7403            CMP DWORD PTR FFFFFF74[EBP], 00000003
00008: 0461 7C FFFFFF9C                 JL L0012
00008: 0463 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 0469                     L000F:
00008: 0469 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 046F 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0475 0F 8C FFFFFF78              JL L0010

; 155:     fclose(infile);

00008: 047B FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0481 E8 00000000                 CALL SHORT _fclose
00008: 0486 59                          POP ECX

; 157:     for(i=1;i<nn;i++)

00008: 0487 C7 85 FFFFFF7000000001      MOV DWORD PTR FFFFFF70[EBP], 00000001
00008: 0491 E9 000000F8                 JMP L0014
00008: 0496                     L0015:

; 158:       for(j=0;j<3;j++)

00008: 0496 C7 85 FFFFFF7400000000      MOV DWORD PTR FFFFFF74[EBP], 00000000
00008: 04A0 E9 000000D6                 JMP L0016
00008: 04A5                     L0017:

; 160: 	  if(x[i][j]-x[i-1][j]>box2)x[i][j]-=box;

00008: 04A5 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 04AB 4E                          DEC ESI
00008: 04AC 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 04B2 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 04B5 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 04BB 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 04C1 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04C4 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 04CA DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 04CD 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 04D3 DC 24 C6                    FSUB QWORD PTR 00000000[ESI][EAX*8]
00007: 04D6 DD 85 FFFFFF7C              FLD QWORD PTR FFFFFF7C[EBP]
00006: 04DC F1DF                        FCOMIP ST, ST(1), L0018
00007: 04DE DD D8                       FSTP ST
00008: 04E0 7A 29                       JP L0018
00008: 04E2 73 27                       JAE L0018
00008: 04E4 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 04EA 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 04F0 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04F3 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 04F9 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 04FC DC 25 00000000              FSUB QWORD PTR _box
00007: 0502 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 0508 DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]
00008: 050B                     L0018:

; 161: 	  if(x[i][j]-x[i-1][j]<-box2)x[i][j]+=box;

00008: 050B 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 0511 4E                          DEC ESI
00008: 0512 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 0518 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 051B 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 0521 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0527 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 052A 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 0530 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 0533 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 0539 DC 24 C6                    FSUB QWORD PTR 00000000[ESI][EAX*8]
00007: 053C DD 85 FFFFFF7C              FLD QWORD PTR FFFFFF7C[EBP]
00006: 0542 D9 E0                       FCHS 
00006: 0544 D9 C9                       FXCH ST(1)
00006: 0546 F1DF                        FCOMIP ST, ST(1), L0019
00007: 0548 DD D8                       FSTP ST
00008: 054A 7A 29                       JP L0019
00008: 054C 73 27                       JAE L0019
00008: 054E 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 0554 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 055A 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 055D 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00008: 0563 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 0566 DC 05 00000000              FADD QWORD PTR _box
00007: 056C 8B 85 FFFFFF74              MOV EAX, DWORD PTR FFFFFF74[EBP]
00007: 0572 DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]
00008: 0575                     L0019:

; 162: 	}

00008: 0575 FF 85 FFFFFF74              INC DWORD PTR FFFFFF74[EBP]
00008: 057B                     L0016:
00008: 057B 83 BD FFFFFF7403            CMP DWORD PTR FFFFFF74[EBP], 00000003
00008: 0582 0F 8C FFFFFF1D              JL L0017
00008: 0588 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 058E                     L0014:
00008: 058E 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0594 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 059A 0F 8C FFFFFEF6              JL L0015

; 164:     for(i=0;i<3;i++)

00008: 05A0 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 05AA E9 0000009D                 JMP L001A
00008: 05AF                     L001B:

; 166: 	double ax=0;

00008: 05AF DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 05B5 DD 5D FFFFFF84              FSTP QWORD PTR FFFFFF84[EBP]

; 167: 	for(k=0;k<nn;k++)

00008: 05B8 C7 85 FFFFFF7800000000      MOV DWORD PTR FFFFFF78[EBP], 00000000
00008: 05C2 EB 24                       JMP L001C
00008: 05C4                     L001D:

; 169: 	    ax+=x[k][i];

00008: 05C4 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 05CA 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 05D0 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 05D3 DD 45 FFFFFF84              FLD QWORD PTR FFFFFF84[EBP]
00007: 05D6 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 05DC DC 04 C2                    FADD QWORD PTR 00000000[EDX][EAX*8]
00007: 05DF DD 5D FFFFFF84              FSTP QWORD PTR FFFFFF84[EBP]

; 170: 	  }

00008: 05E2 FF 85 FFFFFF78              INC DWORD PTR FFFFFF78[EBP]
00008: 05E8                     L001C:
00008: 05E8 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 05EE 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 05F4 7C FFFFFFCE                 JL L001D

; 171: 	ax/=nn;

00008: 05F6 DB 05 00000000              FILD DWORD PTR _nn
00007: 05FC DC 7D FFFFFF84              FDIVR QWORD PTR FFFFFF84[EBP]
00007: 05FF DD 5D FFFFFF84              FSTP QWORD PTR FFFFFF84[EBP]

; 172: 	for(k=0;k<nn;k++)

00008: 0602 C7 85 FFFFFF7800000000      MOV DWORD PTR FFFFFF78[EBP], 00000000
00008: 060C EB 2A                       JMP L001E
00008: 060E                     L001F:

; 174: 	    x[k][i]-=ax;

00008: 060E 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 0614 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 061A 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 061D 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0623 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 0626 DC 65 FFFFFF84              FSUB QWORD PTR FFFFFF84[EBP]
00007: 0629 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00007: 062F DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]

; 175: 	  }

00008: 0632 FF 85 FFFFFF78              INC DWORD PTR FFFFFF78[EBP]
00008: 0638                     L001E:
00008: 0638 8B 85 FFFFFF78              MOV EAX, DWORD PTR FFFFFF78[EBP]
00008: 063E 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0644 7C FFFFFFC8                 JL L001F

; 176:       }

00008: 0646 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 064C                     L001A:
00008: 064C 83 BD FFFFFF7003            CMP DWORD PTR FFFFFF70[EBP], 00000003
00008: 0653 0F 8C FFFFFF56              JL L001B

; 177:   }

00008: 0659 EB 77                       JMP L0020
00008: 065B                     L0007:

; 180:       x=0;

00008: 065B C7 05 00000000 00000000     MOV DWORD PTR _x, 00000000

; 181:       y=0;

00008: 0665 C7 05 00000000 00000000     MOV DWORD PTR _y, 00000000

; 182:       dr=0;

00008: 066F C7 05 00000000 00000000     MOV DWORD PTR _dr, 00000000

; 183:       box=0;

00008: 0679 C7 05 00000004 00000000     MOV DWORD PTR _box+00000004, 00000000
00008: 0683 C7 05 00000000 00000000     MOV DWORD PTR _box, 00000000

; 184:       printf("start to write from ?\n");

00008: 068D 68 00000000                 PUSH OFFSET @233
00008: 0692 E8 00000000                 CALL SHORT _printf
00008: 0697 59                          POP ECX

; 185:       scanf("%ld",&n01);

00008: 0698 68 00000000                 PUSH OFFSET _n01
00008: 069D 68 00000000                 PUSH OFFSET @224
00008: 06A2 E8 00000000                 CALL SHORT _scanf
00008: 06A7 59                          POP ECX
00008: 06A8 59                          POP ECX

; 186:       n0=n01-1;

00008: 06A9 8B 15 00000000              MOV EDX, DWORD PTR _n01
00008: 06AF 4A                          DEC EDX
00008: 06B0 89 15 00000000              MOV DWORD PTR _n0, EDX

; 187:       printf("what is number atoms?\n");

00008: 06B6 68 00000000                 PUSH OFFSET @234
00008: 06BB E8 00000000                 CALL SHORT _printf
00008: 06C0 59                          POP ECX

; 188:       scanf("%ld",&nn);

00008: 06C1 68 00000000                 PUSH OFFSET _nn
00008: 06C6 68 00000000                 PUSH OFFSET @224
00008: 06CB E8 00000000                 CALL SHORT _scanf
00008: 06D0 59                          POP ECX
00008: 06D1 59                          POP ECX

; 189:     }

00008: 06D2                     L0020:

; 190:   nn1=nn-1;

00008: 06D2 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 06D8 4A                          DEC EDX
00008: 06D9 89 15 00000000              MOV DWORD PTR _nn1, EDX

; 191:   ncont=(nn1*nn)>>1;

00008: 06DF 8B 15 00000000              MOV EDX, DWORD PTR _nn1
00008: 06E5 0F AF 15 00000000           IMUL EDX, DWORD PTR _nn
00008: 06EC D1 FA                       SAR EDX, 00000001
00008: 06EE 89 15 00000000              MOV DWORD PTR _ncont, EDX

; 192:   cont=(int **)malloc(nn*sizeof(int*));

00008: 06F4 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 06FA 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0701 52                          PUSH EDX
00008: 0702 E8 00000000                 CALL SHORT _malloc
00008: 0707 59                          POP ECX
00008: 0708 A3 00000000                 MOV DWORD PTR _cont, EAX

; 193:   if(!cont)return 0;

00008: 070D 83 3D 00000000 00           CMP DWORD PTR _cont, 00000000
00008: 0714 75 0D                       JNE L0021
00008: 0716 B8 00000000                 MOV EAX, 00000000
00000: 071B                             epilog 
00000: 071B 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 071E 5F                          POP EDI
00000: 071F 5E                          POP ESI
00000: 0720 5B                          POP EBX
00000: 0721 5D                          POP EBP
00000: 0722 C3                          RETN 
00008: 0723                     L0021:

; 194:   cont[0]=(int *)malloc(ncont*sizeof(long));

00008: 0723 8B 15 00000000              MOV EDX, DWORD PTR _ncont
00008: 0729 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0730 52                          PUSH EDX
00008: 0731 E8 00000000                 CALL SHORT _malloc
00008: 0736 59                          POP ECX
00008: 0737 8B 15 00000000              MOV EDX, DWORD PTR _cont
00008: 073D 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 195:   if(!cont[0])return 0;

00008: 073F 8B 15 00000000              MOV EDX, DWORD PTR _cont
00008: 0745 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 0748 75 0D                       JNE L0022
00008: 074A B8 00000000                 MOV EAX, 00000000
00000: 074F                             epilog 
00000: 074F 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0752 5F                          POP EDI
00000: 0753 5E                          POP ESI
00000: 0754 5B                          POP EBX
00000: 0755 5D                          POP EBP
00000: 0756 C3                          RETN 
00008: 0757                     L0022:

; 196:   for(i=0;i<nn-1;i++)

00008: 0757 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 0761 EB 32                       JMP L0023
00008: 0763                     L0024:

; 197:     cont[i+1]=cont[i]+i;

00008: 0763 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 0769 8D 34 B5 00000000           LEA ESI, [00000000][ESI*4]
00008: 0770 8B 1D 00000000              MOV EBX, DWORD PTR _cont
00008: 0776 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 077C 03 34 83                    ADD ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 077F 8B BD FFFFFF70              MOV EDI, DWORD PTR FFFFFF70[EBP]
00008: 0785 47                          INC EDI
00008: 0786 8B 1D 00000000              MOV EBX, DWORD PTR _cont
00008: 078C 89 34 BB                    MOV DWORD PTR 00000000[EBX][EDI*4], ESI
00008: 078F FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 0795                     L0023:
00008: 0795 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 079B 4A                          DEC EDX
00008: 079C 39 95 FFFFFF70              CMP DWORD PTR FFFFFF70[EBP], EDX
00008: 07A2 7C FFFFFFBF                 JL L0024

; 198:   for(i=0;i<ncont;i++)

00008: 07A4 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 07AE EB 1B                       JMP L0025
00008: 07B0                     L0026:

; 199:     cont[0][i]=0;

00008: 07B0 8B 15 00000000              MOV EDX, DWORD PTR _cont
00008: 07B6 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 07B8 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 07BE C7 04 82 00000000           MOV DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 07C5 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 07CB                     L0025:
00008: 07CB 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 07D1 3B 05 00000000              CMP EAX, DWORD PTR _ncont
00008: 07D7 7C FFFFFFD7                 JL L0026

; 201:   contE=(double **)malloc(nn*sizeof(double*));

00008: 07D9 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 07DF 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 07E6 52                          PUSH EDX
00008: 07E7 E8 00000000                 CALL SHORT _malloc
00008: 07EC 59                          POP ECX
00008: 07ED A3 00000000                 MOV DWORD PTR _contE, EAX

; 202:   if(!cont)return 0;

00008: 07F2 83 3D 00000000 00           CMP DWORD PTR _cont, 00000000
00008: 07F9 75 0D                       JNE L0027
00008: 07FB B8 00000000                 MOV EAX, 00000000
00000: 0800                             epilog 
00000: 0800 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0803 5F                          POP EDI
00000: 0804 5E                          POP ESI
00000: 0805 5B                          POP EBX
00000: 0806 5D                          POP EBP
00000: 0807 C3                          RETN 
00008: 0808                     L0027:

; 203:   contE[0]=(double *)malloc(ncont*sizeof(double));

00008: 0808 8B 15 00000000              MOV EDX, DWORD PTR _ncont
00008: 080E 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 0815 52                          PUSH EDX
00008: 0816 E8 00000000                 CALL SHORT _malloc
00008: 081B 59                          POP ECX
00008: 081C 8B 15 00000000              MOV EDX, DWORD PTR _contE
00008: 0822 89 02                       MOV DWORD PTR 00000000[EDX], EAX

; 204:   if(!contE[0])return 0;

00008: 0824 8B 15 00000000              MOV EDX, DWORD PTR _contE
00008: 082A 83 3A 00                    CMP DWORD PTR 00000000[EDX], 00000000
00008: 082D 75 0D                       JNE L0028
00008: 082F B8 00000000                 MOV EAX, 00000000
00000: 0834                             epilog 
00000: 0834 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0837 5F                          POP EDI
00000: 0838 5E                          POP ESI
00000: 0839 5B                          POP EBX
00000: 083A 5D                          POP EBP
00000: 083B C3                          RETN 
00008: 083C                     L0028:

; 205:   for(i=0;i<nn-1;i++)

00008: 083C C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 0846 EB 32                       JMP L0029
00008: 0848                     L002A:

; 206:     contE[i+1]=contE[i]+i;

00008: 0848 8B B5 FFFFFF70              MOV ESI, DWORD PTR FFFFFF70[EBP]
00008: 084E 8D 34 F5 00000000           LEA ESI, [00000000][ESI*8]
00008: 0855 8B 1D 00000000              MOV EBX, DWORD PTR _contE
00008: 085B 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0861 03 34 83                    ADD ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0864 8B BD FFFFFF70              MOV EDI, DWORD PTR FFFFFF70[EBP]
00008: 086A 47                          INC EDI
00008: 086B 8B 1D 00000000              MOV EBX, DWORD PTR _contE
00008: 0871 89 34 BB                    MOV DWORD PTR 00000000[EBX][EDI*4], ESI
00008: 0874 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 087A                     L0029:
00008: 087A 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 0880 4A                          DEC EDX
00008: 0881 39 95 FFFFFF70              CMP DWORD PTR FFFFFF70[EBP], EDX
00008: 0887 7C FFFFFFBF                 JL L002A

; 207:   for(i=0;i<ncont;i++)

00008: 0889 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 0893 EB 29                       JMP L002B
00008: 0895                     L002C:

; 208:     contE[0][i]=0;

00008: 0895 8B 15 00000000              MOV EDX, DWORD PTR _contE
00008: 089B 8B 12                       MOV EDX, DWORD PTR 00000000[EDX]
00008: 089D 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 08A3 C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 08AB 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 08B1 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000
00008: 08B8 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 08BE                     L002B:
00008: 08BE 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 08C4 3B 05 00000000              CMP EAX, DWORD PTR _ncont
00008: 08CA 7C FFFFFFC9                 JL L002C

; 210:   good=nn;

00008: 08CC 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 08D2 89 15 00000000              MOV DWORD PTR .bss+00000008, EDX

; 211:   nnuc=0;

00008: 08D8 C7 05 00000000 00000000     MOV DWORD PTR _nnuc, 00000000

; 212:   printf("No nucleus file is opened\n");

00008: 08E2 68 00000000                 PUSH OFFSET @235
00008: 08E7 E8 00000000                 CALL SHORT _printf
00008: 08EC 59                          POP ECX

; 213:   if(yes())return good;

00008: 08ED E8 00000000                 CALL SHORT _yes
00008: 08F2 83 F8 00                    CMP EAX, 00000000
00008: 08F5 74 0D                       JE L002D
00008: 08F7 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 08FC                             epilog 
00000: 08FC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 08FF 5F                          POP EDI
00000: 0900 5E                          POP ESI
00000: 0901 5B                          POP EBX
00000: 0902 5D                          POP EBP
00000: 0903 C3                          RETN 
00008: 0904                     L002D:

; 214:   printf("nucleous file name?\n");

00008: 0904 68 00000000                 PUSH OFFSET @236
00008: 0909 E8 00000000                 CALL SHORT _printf
00008: 090E 59                          POP ECX

; 215:   scanf("%s",name);

00008: 090F 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 0912 50                          PUSH EAX
00008: 0913 68 00000000                 PUSH OFFSET @217
00008: 0918 E8 00000000                 CALL SHORT _scanf
00008: 091D 59                          POP ECX
00008: 091E 59                          POP ECX

; 216:   infile=fopen(name,"r");

00008: 091F 68 00000000                 PUSH OFFSET @227
00008: 0924 8D 45 FFFFFF90              LEA EAX, DWORD PTR FFFFFF90[EBP]
00008: 0927 50                          PUSH EAX
00008: 0928 E8 00000000                 CALL SHORT _fopen
00008: 092D 59                          POP ECX
00008: 092E 59                          POP ECX
00008: 092F 89 85 FFFFFF6C              MOV DWORD PTR FFFFFF6C[EBP], EAX

; 217:   if(!infile)return good;

00008: 0935 83 BD FFFFFF6C00            CMP DWORD PTR FFFFFF6C[EBP], 00000000
00008: 093C 75 0D                       JNE L002E
00008: 093E A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0943                             epilog 
00000: 0943 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0946 5F                          POP EDI
00000: 0947 5E                          POP ESI
00000: 0948 5B                          POP EBX
00000: 0949 5D                          POP EBP
00000: 094A C3                          RETN 
00008: 094B                     L002E:

; 218:   fscanf(infile,"%ld",&nnuc);

00008: 094B 68 00000000                 PUSH OFFSET _nnuc
00008: 0950 68 00000000                 PUSH OFFSET @224
00008: 0955 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 095B E8 00000000                 CALL SHORT _fscanf
00008: 0960 83 C4 0C                    ADD ESP, 0000000C

; 219:   if(nnuc<=0){fclose(infile);nnuc=0;return good;}

00008: 0963 83 3D 00000000 00           CMP DWORD PTR _nnuc, 00000000
00008: 096A 7F 23                       JG L002F
00008: 096C FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0972 E8 00000000                 CALL SHORT _fclose
00008: 0977 59                          POP ECX
00008: 0978 C7 05 00000000 00000000     MOV DWORD PTR _nnuc, 00000000
00008: 0982 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0987                             epilog 
00000: 0987 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 098A 5F                          POP EDI
00000: 098B 5E                          POP ESI
00000: 098C 5B                          POP EBX
00000: 098D 5D                          POP EBP
00000: 098E C3                          RETN 
00008: 098F                     L002F:

; 220:   nuc1=(long *)malloc(nnuc*sizeof(long));

00008: 098F 8B 15 00000000              MOV EDX, DWORD PTR _nnuc
00008: 0995 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 099C 52                          PUSH EDX
00008: 099D E8 00000000                 CALL SHORT _malloc
00008: 09A2 59                          POP ECX
00008: 09A3 A3 00000000                 MOV DWORD PTR _nuc1, EAX

; 221:   if(!nuc1){fclose(infile);nnuc=0;return good;}

00008: 09A8 83 3D 00000000 00           CMP DWORD PTR _nuc1, 00000000
00008: 09AF 75 23                       JNE L0030
00008: 09B1 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 09B7 E8 00000000                 CALL SHORT _fclose
00008: 09BC 59                          POP ECX
00008: 09BD C7 05 00000000 00000000     MOV DWORD PTR _nnuc, 00000000
00008: 09C7 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 09CC                             epilog 
00000: 09CC 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 09CF 5F                          POP EDI
00000: 09D0 5E                          POP ESI
00000: 09D1 5B                          POP EBX
00000: 09D2 5D                          POP EBP
00000: 09D3 C3                          RETN 
00008: 09D4                     L0030:

; 222:   nuc2=(long *)malloc(nnuc*sizeof(long));

00008: 09D4 8B 15 00000000              MOV EDX, DWORD PTR _nnuc
00008: 09DA 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 09E1 52                          PUSH EDX
00008: 09E2 E8 00000000                 CALL SHORT _malloc
00008: 09E7 59                          POP ECX
00008: 09E8 A3 00000000                 MOV DWORD PTR _nuc2, EAX

; 223:   if(!nuc2){fclose(infile);nnuc=0;return good;}

00008: 09ED 83 3D 00000000 00           CMP DWORD PTR _nuc2, 00000000
00008: 09F4 75 23                       JNE L0031
00008: 09F6 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 09FC E8 00000000                 CALL SHORT _fclose
00008: 0A01 59                          POP ECX
00008: 0A02 C7 05 00000000 00000000     MOV DWORD PTR _nnuc, 00000000
00008: 0A0C A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0A11                             epilog 
00000: 0A11 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0A14 5F                          POP EDI
00000: 0A15 5E                          POP ESI
00000: 0A16 5B                          POP EBX
00000: 0A17 5D                          POP EBP
00000: 0A18 C3                          RETN 
00008: 0A19                     L0031:

; 224:   for(i=0;i<nnuc;i++)

00008: 0A19 C7 85 FFFFFF7000000000      MOV DWORD PTR FFFFFF70[EBP], 00000000
00008: 0A23 EB 71                       JMP L0032
00008: 0A25                     L0033:

; 226:       fscanf(infile,"%ld %ld",&(nuc1[i]),&(nuc2[i]));

00008: 0A25 8B 95 FFFFFF70              MOV EDX, DWORD PTR FFFFFF70[EBP]
00008: 0A2B 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0A32 03 15 00000000              ADD EDX, DWORD PTR _nuc2
00008: 0A38 52                          PUSH EDX
00008: 0A39 8B 95 FFFFFF70              MOV EDX, DWORD PTR FFFFFF70[EBP]
00008: 0A3F 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0A46 03 15 00000000              ADD EDX, DWORD PTR _nuc1
00008: 0A4C 52                          PUSH EDX
00008: 0A4D 68 00000000                 PUSH OFFSET @237
00008: 0A52 FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0A58 E8 00000000                 CALL SHORT _fscanf
00008: 0A5D 83 C4 10                    ADD ESP, 00000010

; 227:       if(feof(infile)){fclose(infile);nnuc=i;return good;}

00008: 0A60 8B 85 FFFFFF6C              MOV EAX, DWORD PTR FFFFFF6C[EBP]
00008: 0A66 80 78 0C 00                 CMP BYTE PTR 0000000C[EAX], 00
00008: 0A6A 74 24                       JE L0034
00008: 0A6C FF B5 FFFFFF6C              PUSH DWORD PTR FFFFFF6C[EBP]
00008: 0A72 E8 00000000                 CALL SHORT _fclose
00008: 0A77 59                          POP ECX
00008: 0A78 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0A7E A3 00000000                 MOV DWORD PTR _nnuc, EAX
00008: 0A83 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0A88                             epilog 
00000: 0A88 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0A8B 5F                          POP EDI
00000: 0A8C 5E                          POP ESI
00000: 0A8D 5B                          POP EBX
00000: 0A8E 5D                          POP EBP
00000: 0A8F C3                          RETN 
00008: 0A90                     L0034:

; 228:     }

00008: 0A90 FF 85 FFFFFF70              INC DWORD PTR FFFFFF70[EBP]
00008: 0A96                     L0032:
00008: 0A96 8B 85 FFFFFF70              MOV EAX, DWORD PTR FFFFFF70[EBP]
00008: 0A9C 3B 05 00000000              CMP EAX, DWORD PTR _nnuc
00008: 0AA2 7C FFFFFF81                 JL L0033

; 229:   return good;

00008: 0AA4 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0AA9                     L0000:
00000: 0AA9                             epilog 
00000: 0AA9 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0AAC 5F                          POP EDI
00000: 0AAD 5E                          POP ESI
00000: 0AAE 5B                          POP EBX
00000: 0AAF 5D                          POP EBP
00000: 0AB0 C3                          RETN 

Function: _get_T

; 235: {

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

; 237:   double T=0;

00008: 0019 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 001F DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 239:   for(i=0;i<nn;i++)

00008: 0022 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 0029 EB 67                       JMP L0001
00008: 002B                     L0002:

; 240:     for(j=0;j<3;j++)

00008: 002B C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0032 EB 55                       JMP L0003
00008: 0034                     L0004:

; 242: 	v=((iatom *)a)[n0+i].v[j];

00008: 0034 8B 15 00000000              MOV EDX, DWORD PTR _n0
00008: 003A 03 55 FFFFFFDC              ADD EDX, DWORD PTR FFFFFFDC[EBP]
00008: 003D 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0044 29 D3                       SUB EBX, EDX
00008: 0046 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0049 03 5D FFFFFFE0              ADD EBX, DWORD PTR FFFFFFE0[EBP]
00008: 004C 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0052 DD 44 DA 18                 FLD QWORD PTR 00000018[EDX][EBX*8]
00007: 0056 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 243: 	T+=v*v*a[n0+i].m;

00008: 0059 8B 15 00000000              MOV EDX, DWORD PTR _n0
00008: 005F 03 55 FFFFFFDC              ADD EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0062 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0069 29 D3                       SUB EBX, EDX
00008: 006B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 006E 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0074 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 0077 D8 C8                       FMUL ST, ST
00007: 0079 DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 0080 DC 45 FFFFFFE4              FADD QWORD PTR FFFFFFE4[EBP]
00007: 0083 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 244:       }

00008: 0086 FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 0089                     L0003:
00008: 0089 83 7D FFFFFFE0 03           CMP DWORD PTR FFFFFFE0[EBP], 00000003
00008: 008D 7C FFFFFFA5                 JL L0004
00008: 008F FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0092                     L0001:
00008: 0092 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0095 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 009B 7C FFFFFF8E                 JL L0002

; 245:   T=T/(2*nn);

00008: 009D 8B 15 00000000              MOV EDX, DWORD PTR _nn
00008: 00A3 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00AA 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX
00008: 00AD DB 45 FFFFFFF4              FILD DWORD PTR FFFFFFF4[EBP]
00007: 00B0 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00006: 00B3 DE F1                       FDIVRP ST(1), ST
00007: 00B5 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 246: return T;

00008: 00B8 DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00000: 00BB                     L0000:
00000: 00BB                             epilog 
00000: 00BB 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00BE 5B                          POP EBX
00000: 00BF 5D                          POP EBP
00000: 00C0 C3                          RETN 

Function: _get_rms

; 255: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006 81 EC 00000258              SUB ESP, 00000258
00000: 000C B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0011 8D 3C 24                    LEA EDI, DWORD PTR 00000000[ESP]
00000: 0014 B9 00000096                 MOV ECX, 00000096
00000: 0019 F3 AB                       REP STOSD 
00000: 001B                             prolog 

; 259:   double sum=0;

00008: 001B DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 0021 DD 9D FFFFFDBC              FSTP QWORD PTR FFFFFDBC[EBP]

; 260:   int save=0;

00008: 0027 C7 85 FFFFFDAC00000000      MOV DWORD PTR FFFFFDAC[EBP], 00000000

; 261:   moveatoms();

00008: 0031 E8 00000000                 CALL SHORT _moveatoms

; 264:   if((energy>=E_min)&&(energy<=E_max))save=1;

00008: 0036 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0039 DD 05 00000000              FLD QWORD PTR _E_min
00006: 003F F1DF                        FCOMIP ST, ST(1), L0001
00007: 0041 DD D8                       FSTP ST
00008: 0043 7A 1D                       JP L0001
00008: 0045 77 1B                       JA L0001
00008: 0047 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 004A DD 05 00000000              FLD QWORD PTR _E_max
00006: 0050 F1DF                        FCOMIP ST, ST(1), L0001
00007: 0052 DD D8                       FSTP ST
00008: 0054 7A 0C                       JP L0001
00008: 0056 72 0A                       JB L0001
00008: 0058 C7 85 FFFFFDAC00000001      MOV DWORD PTR FFFFFDAC[EBP], 00000001
00008: 0062                     L0001:

; 265:   if(energy<-1000000.0)save=1;

00008: 0062 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0065 DD 05 00000000              FLD QWORD PTR .data+000001e8
00006: 006B F1DF                        FCOMIP ST, ST(1), L0002
00007: 006D DD D8                       FSTP ST
00008: 006F 7A 0C                       JP L0002
00008: 0071 76 0A                       JBE L0002
00008: 0073 C7 85 FFFFFDAC00000001      MOV DWORD PTR FFFFFDAC[EBP], 00000001
00008: 007D                     L0002:

; 266:   if(when_file)

00008: 007D 83 3D 00000000 00           CMP DWORD PTR _when_file, 00000000
00008: 0084 74 48                       JE L0003

; 269:       fscanf(when_file,"%d",&save1);

00008: 0086 8D 45 FFFFFFF0              LEA EAX, DWORD PTR FFFFFFF0[EBP]
00008: 0089 50                          PUSH EAX
00008: 008A 68 00000000                 PUSH OFFSET @533
00008: 008F A1 00000000                 MOV EAX, DWORD PTR _when_file
00008: 0094 50                          PUSH EAX
00008: 0095 E8 00000000                 CALL SHORT _fscanf
00008: 009A 83 C4 0C                    ADD ESP, 0000000C

; 270:       save&=save1;

00008: 009D 8B 85 FFFFFDAC              MOV EAX, DWORD PTR FFFFFDAC[EBP]
00008: 00A3 23 45 FFFFFFF0              AND EAX, DWORD PTR FFFFFFF0[EBP]
00008: 00A6 89 85 FFFFFDAC              MOV DWORD PTR FFFFFDAC[EBP], EAX

; 272:       if(feof(when_file))

00008: 00AC 8B 15 00000000              MOV EDX, DWORD PTR _when_file
00008: 00B2 80 7A 0C 00                 CMP BYTE PTR 0000000C[EDX], 00
00008: 00B6 74 16                       JE L0004

; 274: 	  fclose(when_file);

00008: 00B8 A1 00000000                 MOV EAX, DWORD PTR _when_file
00008: 00BD 50                          PUSH EAX
00008: 00BE E8 00000000                 CALL SHORT _fclose
00008: 00C3 59                          POP ECX

; 275: 	  when_file=0;

00008: 00C4 C7 05 00000000 00000000     MOV DWORD PTR _when_file, 00000000

; 276: 	}

00008: 00CE                     L0004:

; 277:     }

00008: 00CE                     L0003:

; 280:   if(save)

00008: 00CE 83 BD FFFFFDAC00            CMP DWORD PTR FFFFFDAC[EBP], 00000000
00008: 00D5 0F 84 00000100              JE L0005

; 282:       int contCount=0;

00008: 00DB C7 85 FFFFFDB000000000      MOV DWORD PTR FFFFFDB0[EBP], 00000000

; 283:       for(i=1;i<nn;i++)

00008: 00E5 C7 85 FFFFFDA000000001      MOV DWORD PTR FFFFFDA0[EBP], 00000001
00008: 00EF E9 000000BC                 JMP L0006
00008: 00F4                     L0007:

; 284:       for(j=0;j<i;j++)

00008: 00F4 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 00FE E9 00000095                 JMP L0008
00008: 0103                     L0009:

; 286:           int dummy=contact(j+n0,i+n0);

00008: 0103 8B 95 FFFFFDA0              MOV EDX, DWORD PTR FFFFFDA0[EBP]
00008: 0109 03 15 00000000              ADD EDX, DWORD PTR _n0
00008: 010F 52                          PUSH EDX
00008: 0110 8B 95 FFFFFDA4              MOV EDX, DWORD PTR FFFFFDA4[EBP]
00008: 0116 03 15 00000000              ADD EDX, DWORD PTR _n0
00008: 011C 52                          PUSH EDX
00008: 011D E8 00000000                 CALL SHORT _contact
00008: 0122 59                          POP ECX
00008: 0123 59                          POP ECX
00008: 0124 89 85 FFFFFDB4              MOV DWORD PTR FFFFFDB4[EBP], EAX

; 287:           contCount+=dummy;

00008: 012A 8B 85 FFFFFDB0              MOV EAX, DWORD PTR FFFFFDB0[EBP]
00008: 0130 03 85 FFFFFDB4              ADD EAX, DWORD PTR FFFFFDB4[EBP]
00008: 0136 89 85 FFFFFDB0              MOV DWORD PTR FFFFFDB0[EBP], EAX

; 288: 	  cont[i][j]+=dummy;

00008: 013C 8B 1D 00000000              MOV EBX, DWORD PTR _cont
00008: 0142 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0148 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 014B 8B 8D FFFFFDB4              MOV ECX, DWORD PTR FFFFFDB4[EBP]
00008: 0151 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0157 01 0C 83                    ADD DWORD PTR 00000000[EBX][EAX*4], ECX

; 289:           contE[i][j]-=energy*dummy;

00008: 015A 8B 1D 00000000              MOV EBX, DWORD PTR _contE
00008: 0160 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0166 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0169 8B 85 FFFFFDB4              MOV EAX, DWORD PTR FFFFFDB4[EBP]
00008: 016F 89 85 FFFFFE24              MOV DWORD PTR FFFFFE24[EBP], EAX
00008: 0175 DB 85 FFFFFE24              FILD DWORD PTR FFFFFE24[EBP]
00007: 017B DC 4D 08                    FMUL QWORD PTR 00000008[EBP]
00007: 017E 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0184 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 0187 DE E1                       FSUBRP ST(1), ST
00007: 0189 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 018F DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]

; 290: 	}

00008: 0192 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0198                     L0008:
00008: 0198 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 019E 3B 85 FFFFFDA0              CMP EAX, DWORD PTR FFFFFDA0[EBP]
00008: 01A4 0F 8C FFFFFF59              JL L0009
00008: 01AA FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 01B0                     L0006:
00008: 01B0 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 01B6 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 01BC 0F 8C FFFFFF32              JL L0007

; 291:       printf("%d %lf\n",contCount,energy);

00008: 01C2 FF 75 0C                    PUSH DWORD PTR 0000000C[EBP]
00008: 01C5 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 01C8 FF B5 FFFFFDB0              PUSH DWORD PTR FFFFFDB0[EBP]
00008: 01CE 68 00000000                 PUSH OFFSET @534
00008: 01D3 E8 00000000                 CALL SHORT _printf
00008: 01D8 83 C4 10                    ADD ESP, 00000010

; 292:   }

00008: 01DB                     L0005:

; 293:       nucleus=0;

00008: 01DB C7 05 00000000 00000000     MOV DWORD PTR _nucleus, 00000000

; 294:       for(i=0;i<nnuc;i++)

00008: 01E5 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 01EF EB 44                       JMP L000A
00008: 01F1                     L000B:

; 295: 	if(contact(nuc1[i]+n0,nuc2[i]+n0))nucleus++;

00008: 01F1 8B 35 00000000              MOV ESI, DWORD PTR _nuc2
00008: 01F7 8B 1D 00000000              MOV EBX, DWORD PTR _n0
00008: 01FD 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0203 03 1C 86                    ADD EBX, DWORD PTR 00000000[ESI][EAX*4]
00008: 0206 53                          PUSH EBX
00008: 0207 8B 35 00000000              MOV ESI, DWORD PTR _nuc1
00008: 020D 8B 1D 00000000              MOV EBX, DWORD PTR _n0
00008: 0213 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0219 03 1C 86                    ADD EBX, DWORD PTR 00000000[ESI][EAX*4]
00008: 021C 53                          PUSH EBX
00008: 021D E8 00000000                 CALL SHORT _contact
00008: 0222 59                          POP ECX
00008: 0223 59                          POP ECX
00008: 0224 83 F8 00                    CMP EAX, 00000000
00008: 0227 74 06                       JE L000C
00008: 0229 FF 05 00000000              INC DWORD PTR _nucleus
00008: 022F                     L000C:
00008: 022F FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0235                     L000A:
00008: 0235 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 023B 3B 05 00000000              CMP EAX, DWORD PTR _nnuc
00008: 0241 7C FFFFFFAE                 JL L000B

; 297:   if(!y)return 0;

00008: 0243 83 3D 00000000 00           CMP DWORD PTR _y, 00000000
00008: 024A 75 0E                       JNE L000D
00008: 024C DD 05 00000000              FLD QWORD PTR .data+00000010
00000: 0252                             epilog 
00000: 0252 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 0255 5F                          POP EDI
00000: 0256 5E                          POP ESI
00000: 0257 5B                          POP EBX
00000: 0258 5D                          POP EBP
00000: 0259 C3                          RETN 
00008: 025A                     L000D:

; 301:   for(i=0;i<nn;i++)

00008: 025A C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0264 EB 61                       JMP L000E
00008: 0266                     L000F:

; 302:       for(j=0;j<3;j++)

00008: 0266 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0270 EB 46                       JMP L0010
00008: 0272                     L0011:

; 303: 	y[i][j]=((moved_iatom *)a)[n0+i].r[j];

00008: 0272 8B 15 00000000              MOV EDX, DWORD PTR _n0
00008: 0278 03 95 FFFFFDA0              ADD EDX, DWORD PTR FFFFFDA0[EBP]
00008: 027E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0285 29 D3                       SUB EBX, EDX
00008: 0287 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 028A 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0290 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0296 8B 35 00000000              MOV ESI, DWORD PTR _y
00008: 029C 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 02A2 8B 14 86                    MOV EDX, DWORD PTR 00000000[ESI][EAX*4]
00008: 02A5 DD 44 DF 48                 FLD QWORD PTR 00000048[EDI][EBX*8]
00007: 02A9 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 02AF DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]
00008: 02B2 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 02B8                     L0010:
00008: 02B8 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 02BF 7C FFFFFFB1                 JL L0011
00008: 02C1 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 02C7                     L000E:
00008: 02C7 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 02CD 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 02D3 7C FFFFFF91                 JL L000F

; 307:   for(i=1;i<nn;i++)

00008: 02D5 C7 85 FFFFFDA000000001      MOV DWORD PTR FFFFFDA0[EBP], 00000001
00008: 02DF E9 00000136                 JMP L0012
00008: 02E4                     L0013:

; 308:     for(j=0;j<3;j++)

00008: 02E4 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 02EE E9 00000114                 JMP L0014
00008: 02F3                     L0015:

; 310: 	if(y[i][j]-y[i-1][j]>bound[j].length*0.5)y[i][j]-=bound[j].length;

00008: 02F3 8B B5 FFFFFDA0              MOV ESI, DWORD PTR FFFFFDA0[EBP]
00008: 02F9 4E                          DEC ESI
00008: 02FA 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0300 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 0303 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0309 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 030F 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0312 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0318 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 031B 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0321 DC 24 C6                    FSUB QWORD PTR 00000000[ESI][EAX*8]
00007: 0324 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00007: 032A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 032D 8B 15 00000000              MOV EDX, DWORD PTR _bound
00007: 0333 DD 05 00000000              FLD QWORD PTR .data+00000170
00006: 0339 DC 0C DA                    FMUL QWORD PTR 00000000[EDX][EBX*8]
00006: 033C D9 C9                       FXCH ST(1)
00006: 033E F1DF                        FCOMIP ST, ST(1), L0016
00007: 0340 DD D8                       FSTP ST
00008: 0342 7A 35                       JP L0016
00008: 0344 76 33                       JBE L0016
00008: 0346 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 034C 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0352 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0355 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 035B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 035E 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0364 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 036A DD 04 C6                    FLD QWORD PTR 00000000[ESI][EAX*8]
00007: 036D DC 24 DA                    FSUB QWORD PTR 00000000[EDX][EBX*8]
00007: 0370 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0376 DD 1C C6                    FSTP QWORD PTR 00000000[ESI][EAX*8]
00008: 0379                     L0016:

; 311: 	if(y[i][j]-y[i-1][j]<-bound[j].length*0.5)y[i][j]+=bound[j].length;

00008: 0379 8B B5 FFFFFDA0              MOV ESI, DWORD PTR FFFFFDA0[EBP]
00008: 037F 4E                          DEC ESI
00008: 0380 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0386 8B 34 B3                    MOV ESI, DWORD PTR 00000000[EBX][ESI*4]
00008: 0389 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 038F 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0395 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0398 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 039E DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 03A1 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 03A7 DC 24 C6                    FSUB QWORD PTR 00000000[ESI][EAX*8]
00007: 03AA 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00007: 03B0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 03B3 8B 15 00000000              MOV EDX, DWORD PTR _bound
00007: 03B9 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00006: 03BC D9 E0                       FCHS 
00006: 03BE DC 0D 00000000              FMUL QWORD PTR .data+00000170
00006: 03C4 D9 C9                       FXCH ST(1)
00006: 03C6 F1DF                        FCOMIP ST, ST(1), L0017
00007: 03C8 DD D8                       FSTP ST
00008: 03CA 7A 35                       JP L0017
00008: 03CC 73 33                       JAE L0017
00008: 03CE 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 03D4 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 03DA 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 03DD 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 03E3 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03E6 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 03EC 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 03F2 DD 04 C6                    FLD QWORD PTR 00000000[ESI][EAX*8]
00007: 03F5 DC 04 DA                    FADD QWORD PTR 00000000[EDX][EBX*8]
00007: 03F8 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 03FE DD 1C C6                    FSTP QWORD PTR 00000000[ESI][EAX*8]
00008: 0401                     L0017:

; 312:       }

00008: 0401 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0407                     L0014:
00008: 0407 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 040E 0F 8C FFFFFEDF              JL L0015
00008: 0414 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 041A                     L0012:
00008: 041A 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0420 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0426 0F 8C FFFFFEB8              JL L0013

; 315:   for(i=0;i<3;i++)

00008: 042C C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0436 E9 000000AF                 JMP L0018
00008: 043B                     L0019:

; 317:       double ay=0;

00008: 043B DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 0441 DD 9D FFFFFDC4              FSTP QWORD PTR FFFFFDC4[EBP]

; 318:       for(k=0;k<nn;k++)

00008: 0447 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 0451 EB 2A                       JMP L001A
00008: 0453                     L001B:

; 320: 	  ay+=y[k][i];

00008: 0453 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0459 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 045F 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0462 DD 85 FFFFFDC4              FLD QWORD PTR FFFFFDC4[EBP]
00007: 0468 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 046E DC 04 C2                    FADD QWORD PTR 00000000[EDX][EAX*8]
00007: 0471 DD 9D FFFFFDC4              FSTP QWORD PTR FFFFFDC4[EBP]

; 321: 	}

00008: 0477 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 047D                     L001A:
00008: 047D 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0483 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0489 7C FFFFFFC8                 JL L001B

; 322:       ay/=nn;

00008: 048B DB 05 00000000              FILD DWORD PTR _nn
00007: 0491 DC BD FFFFFDC4              FDIVR QWORD PTR FFFFFDC4[EBP]
00007: 0497 DD 9D FFFFFDC4              FSTP QWORD PTR FFFFFDC4[EBP]

; 324:       for(k=0;k<nn;k++)

00008: 049D C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 04A7 EB 2D                       JMP L001C
00008: 04A9                     L001D:

; 326: 	  y[k][i]-=ay;

00008: 04A9 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 04AF 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 04B5 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 04B8 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 04BE DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 04C1 DC A5 FFFFFDC4              FSUB QWORD PTR FFFFFDC4[EBP]
00007: 04C7 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 04CD DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]

; 327: 	}

00008: 04D0 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 04D6                     L001C:
00008: 04D6 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 04DC 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 04E2 7C FFFFFFC5                 JL L001D

; 328:     }

00008: 04E4 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 04EA                     L0018:
00008: 04EA 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 04F1 0F 8C FFFFFF44              JL L0019

; 329:   gr=0;

00008: 04F7 C7 05 00000004 00000000     MOV DWORD PTR _gr+00000004, 00000000
00008: 0501 C7 05 00000000 00000000     MOV DWORD PTR _gr, 00000000

; 330:   for(i=0;i<3;i++)

00008: 050B C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0515 EB 62                       JMP L001E
00008: 0517                     L001F:

; 331:     for(k=0;k<nn;k++)

00008: 0517 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 0521 EB 42                       JMP L0020
00008: 0523                     L0021:

; 332:       gr+=y[k][i]*y[k][i];

00008: 0523 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0529 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 052F 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0532 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0538 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 053E 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0541 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0547 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 054A 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0550 DC 0C C6                    FMUL QWORD PTR 00000000[ESI][EAX*8]
00007: 0553 DC 05 00000000              FADD QWORD PTR _gr
00007: 0559 DD 1D 00000000              FSTP QWORD PTR _gr
00008: 055F FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 0565                     L0020:
00008: 0565 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 056B 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0571 7C FFFFFFB0                 JL L0021
00008: 0573 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0579                     L001E:
00008: 0579 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0580 7C FFFFFF95                 JL L001F

; 334:   gr=sqrt(gr/nn);

00008: 0582 DB 05 00000000              FILD DWORD PTR _nn
00007: 0588 DD 05 00000000              FLD QWORD PTR _gr
00006: 058E DE F1                       FDIVRP ST(1), ST
00007: 0590 50                          PUSH EAX
00007: 0591 50                          PUSH EAX
00007: 0592 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0595 E8 00000000                 CALL SHORT _sqrt
00007: 059A 59                          POP ECX
00007: 059B 59                          POP ECX
00007: 059C DD 1D 00000000              FSTP QWORD PTR _gr

; 336:   for(i=0;i<3;i++)

00008: 05A2 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 05AC E9 000000AC                 JMP L0022
00008: 05B1                     L0023:

; 337:     for(j=0;j<3;j++)

00008: 05B1 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 05BB E9 0000008A                 JMP L0024
00008: 05C0                     L0025:

; 339: 	double  rij=0;

00008: 05C0 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 05C6 DD 9D FFFFFDCC              FSTP QWORD PTR FFFFFDCC[EBP]

; 340: 	for(k=0;k<nn;k++)

00008: 05CC C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 05D6 EB 42                       JMP L0026
00008: 05D8                     L0027:

; 342: 	    rij+=y[k][i]*x[k][j];

00008: 05D8 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 05DE 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 05E4 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 05E7 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 05ED 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 05F3 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 05F6 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 05FC DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 05FF 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0605 DC 0C C6                    FMUL QWORD PTR 00000000[ESI][EAX*8]
00007: 0608 DC 85 FFFFFDCC              FADD QWORD PTR FFFFFDCC[EBP]
00007: 060E DD 9D FFFFFDCC              FSTP QWORD PTR FFFFFDCC[EBP]

; 344: 	  }

00008: 0614 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 061A                     L0026:
00008: 061A 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0620 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0626 7C FFFFFFB0                 JL L0027

; 345: 	r[i][j]=rij;

00008: 0628 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 062E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0631 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0637 DD 85 FFFFFDCC              FLD QWORD PTR FFFFFDCC[EBP]
00007: 063D DD 9C DD FFFFFE2C           FSTP QWORD PTR FFFFFE2C[EBP][EBX*8]

; 346:       }

00008: 0644 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 064A                     L0024:
00008: 064A 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0651 0F 8C FFFFFF69              JL L0025
00008: 0657 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 065D                     L0022:
00008: 065D 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0664 0F 8C FFFFFF47              JL L0023

; 349:   for(i=0;i<3;i++)

00008: 066A C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0674 E9 000000A3                 JMP L0028
00008: 0679                     L0029:

; 350:     for(j=0;j<3;j++)

00008: 0679 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0683 E9 00000081                 JMP L002A
00008: 0688                     L002B:

; 352: 	double  rij=0;

00008: 0688 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 068E DD 9D FFFFFDD4              FSTP QWORD PTR FFFFFDD4[EBP]

; 353: 	for(k=0;k<3;k++)

00008: 0694 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 069E EB 3E                       JMP L002C
00008: 06A0                     L002D:

; 355: 	    rij+=r[k][i]*r[k][j];

00008: 06A0 8B B5 FFFFFDA8              MOV ESI, DWORD PTR FFFFFDA8[EBP]
00008: 06A6 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 06A9 03 B5 FFFFFDA4              ADD ESI, DWORD PTR FFFFFDA4[EBP]
00008: 06AF 8B 9D FFFFFDA8              MOV EBX, DWORD PTR FFFFFDA8[EBP]
00008: 06B5 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 06B8 03 9D FFFFFDA0              ADD EBX, DWORD PTR FFFFFDA0[EBP]
00008: 06BE DD 84 DD FFFFFE2C           FLD QWORD PTR FFFFFE2C[EBP][EBX*8]
00007: 06C5 DC 8C F5 FFFFFE2C           FMUL QWORD PTR FFFFFE2C[EBP][ESI*8]
00007: 06CC DC 85 FFFFFDD4              FADD QWORD PTR FFFFFDD4[EBP]
00007: 06D2 DD 9D FFFFFDD4              FSTP QWORD PTR FFFFFDD4[EBP]

; 356: 	  }

00008: 06D8 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 06DE                     L002C:
00008: 06DE 83 BD FFFFFDA803            CMP DWORD PTR FFFFFDA8[EBP], 00000003
00008: 06E5 7C FFFFFFB9                 JL L002D

; 357: 	rr[i][j]=rij;

00008: 06E7 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 06ED 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 06F0 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 06F6 DD 85 FFFFFDD4              FLD QWORD PTR FFFFFDD4[EBP]
00007: 06FC DD 9C DD FFFFFE74           FSTP QWORD PTR FFFFFE74[EBP][EBX*8]

; 358:       }

00008: 0703 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0709                     L002A:
00008: 0709 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0710 0F 8C FFFFFF72              JL L002B
00008: 0716 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 071C                     L0028:
00008: 071C 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0723 0F 8C FFFFFF50              JL L0029

; 361:   p[0]=1;

00008: 0729 C7 85 FFFFFED83FF00000      MOV DWORD PTR FFFFFED8[EBP], 3FF00000
00008: 0733 C7 85 FFFFFED400000000      MOV DWORD PTR FFFFFED4[EBP], 00000000

; 362:   p[1]=-(rr[0][0]+rr[1][1]+rr[2][2]);

00008: 073D DD 85 FFFFFE74              FLD QWORD PTR FFFFFE74[EBP]
00007: 0743 DC 85 FFFFFE94              FADD QWORD PTR FFFFFE94[EBP]
00007: 0749 DC 85 FFFFFEB4              FADD QWORD PTR FFFFFEB4[EBP]
00007: 074F D9 E0                       FCHS 
00007: 0751 DD 9D FFFFFEDC              FSTP QWORD PTR FFFFFEDC[EBP]

; 363:   p[2] =rr[1][1]*rr[2][2]-rr[1][2]*rr[2][1];

00008: 0757 DD 85 FFFFFE9C              FLD QWORD PTR FFFFFE9C[EBP]
00007: 075D DC 8D FFFFFEAC              FMUL QWORD PTR FFFFFEAC[EBP]
00007: 0763 DD 85 FFFFFE94              FLD QWORD PTR FFFFFE94[EBP]
00006: 0769 DC 8D FFFFFEB4              FMUL QWORD PTR FFFFFEB4[EBP]
00006: 076F DE E1                       FSUBRP ST(1), ST
00007: 0771 DD 9D FFFFFEE4              FSTP QWORD PTR FFFFFEE4[EBP]

; 364:   p[2]+=rr[2][2]*rr[0][0]-rr[2][0]*rr[0][2];

00008: 0777 DD 85 FFFFFEA4              FLD QWORD PTR FFFFFEA4[EBP]
00007: 077D DC 8D FFFFFE84              FMUL QWORD PTR FFFFFE84[EBP]
00007: 0783 DD 85 FFFFFEB4              FLD QWORD PTR FFFFFEB4[EBP]
00006: 0789 DC 8D FFFFFE74              FMUL QWORD PTR FFFFFE74[EBP]
00006: 078F DE E1                       FSUBRP ST(1), ST
00007: 0791 DC 85 FFFFFEE4              FADD QWORD PTR FFFFFEE4[EBP]
00007: 0797 DD 9D FFFFFEE4              FSTP QWORD PTR FFFFFEE4[EBP]

; 365:   p[2]+=rr[1][1]*rr[0][0]-rr[1][0]*rr[0][1];

00008: 079D DD 85 FFFFFE8C              FLD QWORD PTR FFFFFE8C[EBP]
00007: 07A3 DC 8D FFFFFE7C              FMUL QWORD PTR FFFFFE7C[EBP]
00007: 07A9 DD 85 FFFFFE94              FLD QWORD PTR FFFFFE94[EBP]
00006: 07AF DC 8D FFFFFE74              FMUL QWORD PTR FFFFFE74[EBP]
00006: 07B5 DE E1                       FSUBRP ST(1), ST
00007: 07B7 DC 85 FFFFFEE4              FADD QWORD PTR FFFFFEE4[EBP]
00007: 07BD DD 9D FFFFFEE4              FSTP QWORD PTR FFFFFEE4[EBP]

; 366:   p[3] =rr[0][0]*(rr[1][1]*rr[2][2]-rr[1][2]*rr[2][1]);

00008: 07C3 DD 85 FFFFFE9C              FLD QWORD PTR FFFFFE9C[EBP]
00007: 07C9 DC 8D FFFFFEAC              FMUL QWORD PTR FFFFFEAC[EBP]
00007: 07CF DD 85 FFFFFE94              FLD QWORD PTR FFFFFE94[EBP]
00006: 07D5 DC 8D FFFFFEB4              FMUL QWORD PTR FFFFFEB4[EBP]
00006: 07DB DE E1                       FSUBRP ST(1), ST
00007: 07DD DC 8D FFFFFE74              FMUL QWORD PTR FFFFFE74[EBP]
00007: 07E3 DD 9D FFFFFEEC              FSTP QWORD PTR FFFFFEEC[EBP]

; 367:   p[3]-=rr[0][1]*(rr[1][0]*rr[2][2]-rr[1][2]*rr[2][0]);

00008: 07E9 DD 85 FFFFFE9C              FLD QWORD PTR FFFFFE9C[EBP]
00007: 07EF DC 8D FFFFFEA4              FMUL QWORD PTR FFFFFEA4[EBP]
00007: 07F5 DD 85 FFFFFE8C              FLD QWORD PTR FFFFFE8C[EBP]
00006: 07FB DC 8D FFFFFEB4              FMUL QWORD PTR FFFFFEB4[EBP]
00006: 0801 DE E1                       FSUBRP ST(1), ST
00007: 0803 DC 8D FFFFFE7C              FMUL QWORD PTR FFFFFE7C[EBP]
00007: 0809 DD 85 FFFFFEEC              FLD QWORD PTR FFFFFEEC[EBP]
00006: 080F DE E1                       FSUBRP ST(1), ST
00007: 0811 DD 9D FFFFFEEC              FSTP QWORD PTR FFFFFEEC[EBP]

; 368:   p[3]+=rr[0][2]*(rr[1][0]*rr[2][1]-rr[1][1]*rr[2][0]);

00008: 0817 DD 85 FFFFFE94              FLD QWORD PTR FFFFFE94[EBP]
00007: 081D DC 8D FFFFFEA4              FMUL QWORD PTR FFFFFEA4[EBP]
00007: 0823 DD 85 FFFFFE8C              FLD QWORD PTR FFFFFE8C[EBP]
00006: 0829 DC 8D FFFFFEAC              FMUL QWORD PTR FFFFFEAC[EBP]
00006: 082F DE E1                       FSUBRP ST(1), ST
00007: 0831 DC 8D FFFFFE84              FMUL QWORD PTR FFFFFE84[EBP]
00007: 0837 DC 85 FFFFFEEC              FADD QWORD PTR FFFFFEEC[EBP]
00007: 083D DD 9D FFFFFEEC              FSTP QWORD PTR FFFFFEEC[EBP]

; 369:   p[3]=-p[3];

00008: 0843 DD 85 FFFFFEEC              FLD QWORD PTR FFFFFEEC[EBP]
00007: 0849 D9 E0                       FCHS 
00007: 084B DD 9D FFFFFEEC              FSTP QWORD PTR FFFFFEEC[EBP]

; 375:     double z=-p[1];

00008: 0851 DD 85 FFFFFEDC              FLD QWORD PTR FFFFFEDC[EBP]
00007: 0857 D9 E0                       FCHS 
00007: 0859 DD 9D FFFFFDDC              FSTP QWORD PTR FFFFFDDC[EBP]

; 376:     for(i=2;i<4;i++)

00008: 085F C7 85 FFFFFDA000000002      MOV DWORD PTR FFFFFDA0[EBP], 00000002
00008: 0869 EB 5C                       JMP L002E
00008: 086B                     L002F:

; 377:       if(z<fabs(p[i]))z=fabs(p[i]);

00008: 086B 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0871 FF B4 C5 FFFFFED8           PUSH DWORD PTR FFFFFED8[EBP][EAX*8]
00008: 0878 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 087E FF B4 C5 FFFFFED4           PUSH DWORD PTR FFFFFED4[EBP][EAX*8]
00008: 0885 E8 00000000                 CALL SHORT _fabs
00007: 088A 59                          POP ECX
00007: 088B 59                          POP ECX
00007: 088C DD 85 FFFFFDDC              FLD QWORD PTR FFFFFDDC[EBP]
00006: 0892 F1DF                        FCOMIP ST, ST(1), L0030
00007: 0894 DD D8                       FSTP ST
00008: 0896 7A 29                       JP L0030
00008: 0898 73 27                       JAE L0030
00008: 089A 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 08A0 FF B4 C5 FFFFFED8           PUSH DWORD PTR FFFFFED8[EBP][EAX*8]
00008: 08A7 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 08AD FF B4 C5 FFFFFED4           PUSH DWORD PTR FFFFFED4[EBP][EAX*8]
00008: 08B4 E8 00000000                 CALL SHORT _fabs
00007: 08B9 59                          POP ECX
00007: 08BA 59                          POP ECX
00007: 08BB DD 9D FFFFFDDC              FSTP QWORD PTR FFFFFDDC[EBP]
00008: 08C1                     L0030:
00008: 08C1 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 08C7                     L002E:
00008: 08C7 83 BD FFFFFDA004            CMP DWORD PTR FFFFFDA0[EBP], 00000004
00008: 08CE 7C FFFFFF9B                 JL L002F

; 378:     k=3;

00008: 08D0 C7 85 FFFFFDA800000003      MOV DWORD PTR FFFFFDA8[EBP], 00000003

; 380:     for(i=0;i<2;i++)

00008: 08DA C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 08E4 E9 00000155                 JMP L0031
00008: 08E9                     L0032:

; 384: 	do 

00008: 08E9                     L0033:

; 386: 	    q[0]=p[0];

00008: 08E9 DD 85 FFFFFED4              FLD QWORD PTR FFFFFED4[EBP]
00007: 08EF DD 9D FFFFFEF4              FSTP QWORD PTR FFFFFEF4[EBP]

; 387: 	    q1=p[0];

00008: 08F5 DD 85 FFFFFED4              FLD QWORD PTR FFFFFED4[EBP]
00007: 08FB DD 9D FFFFFDE4              FSTP QWORD PTR FFFFFDE4[EBP]

; 388: 	    for(j=1;j<k;j++)

00008: 0901 C7 85 FFFFFDA400000001      MOV DWORD PTR FFFFFDA4[EBP], 00000001
00008: 090B EB 53                       JMP L0034
00008: 090D                     L0035:

; 390: 		q[j]=q[j-1]*z+p[j];

00008: 090D 8B 95 FFFFFDA4              MOV EDX, DWORD PTR FFFFFDA4[EBP]
00008: 0913 4A                          DEC EDX
00008: 0914 DD 85 FFFFFDDC              FLD QWORD PTR FFFFFDDC[EBP]
00007: 091A DC 8C D5 FFFFFEF4           FMUL QWORD PTR FFFFFEF4[EBP][EDX*8]
00007: 0921 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0927 DC 84 C5 FFFFFED4           FADD QWORD PTR FFFFFED4[EBP][EAX*8]
00007: 092E 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0934 DD 9C C5 FFFFFEF4           FSTP QWORD PTR FFFFFEF4[EBP][EAX*8]

; 391: 		q1=q1*z+q[j];

00008: 093B DD 85 FFFFFDE4              FLD QWORD PTR FFFFFDE4[EBP]
00007: 0941 DC 8D FFFFFDDC              FMUL QWORD PTR FFFFFDDC[EBP]
00007: 0947 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 094D DC 84 C5 FFFFFEF4           FADD QWORD PTR FFFFFEF4[EBP][EAX*8]
00007: 0954 DD 9D FFFFFDE4              FSTP QWORD PTR FFFFFDE4[EBP]

; 392: 	      }

00008: 095A FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0960                     L0034:
00008: 0960 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0966 3B 85 FFFFFDA8              CMP EAX, DWORD PTR FFFFFDA8[EBP]
00008: 096C 7C FFFFFF9F                 JL L0035

; 393: 	    q[k]=q[k-1]*z+p[k];

00008: 096E 8B 95 FFFFFDA8              MOV EDX, DWORD PTR FFFFFDA8[EBP]
00008: 0974 4A                          DEC EDX
00008: 0975 DD 85 FFFFFDDC              FLD QWORD PTR FFFFFDDC[EBP]
00007: 097B DC 8C D5 FFFFFEF4           FMUL QWORD PTR FFFFFEF4[EBP][EDX*8]
00007: 0982 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0988 DC 84 C5 FFFFFED4           FADD QWORD PTR FFFFFED4[EBP][EAX*8]
00007: 098F 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0995 DD 9C C5 FFFFFEF4           FSTP QWORD PTR FFFFFEF4[EBP][EAX*8]

; 394: 	    dz=q[k]/q1;

00008: 099C 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 09A2 DD 84 C5 FFFFFEF4           FLD QWORD PTR FFFFFEF4[EBP][EAX*8]
00007: 09A9 DC B5 FFFFFDE4              FDIV QWORD PTR FFFFFDE4[EBP]
00007: 09AF DD 9D FFFFFDEC              FSTP QWORD PTR FFFFFDEC[EBP]

; 395: 	    z=z-dz;

00008: 09B5 DD 85 FFFFFDDC              FLD QWORD PTR FFFFFDDC[EBP]
00007: 09BB DC A5 FFFFFDEC              FSUB QWORD PTR FFFFFDEC[EBP]
00007: 09C1 DD 9D FFFFFDDC              FSTP QWORD PTR FFFFFDDC[EBP]

; 396: 	  }while(dz>1.0e-14*z);

00008: 09C7 DD 05 00000000              FLD QWORD PTR .data+00000200
00007: 09CD DC 8D FFFFFDDC              FMUL QWORD PTR FFFFFDDC[EBP]
00007: 09D3 DD 85 FFFFFDEC              FLD QWORD PTR FFFFFDEC[EBP]
00006: 09D9 F1DF                        FCOMIP ST, ST(1), L0033
00007: 09DB DD D8                       FSTP ST
00008: 09DD 7A 06                       JP L0074
00008: 09DF 0F 87 FFFFFF04              JA L0033
00008: 09E5                     L0074:

; 397: 	p[k]=z;

00008: 09E5 DD 85 FFFFFDDC              FLD QWORD PTR FFFFFDDC[EBP]
00007: 09EB 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 09F1 DD 9C C5 FFFFFED4           FSTP QWORD PTR FFFFFED4[EBP][EAX*8]

; 398: 	for(j=0;j<k;j++)

00008: 09F8 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0A02 EB 20                       JMP L0036
00008: 0A04                     L0037:

; 399: 	  p[j]=q[j];

00008: 0A04 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0A0A DD 84 C5 FFFFFEF4           FLD QWORD PTR FFFFFEF4[EBP][EAX*8]
00007: 0A11 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0A17 DD 9C C5 FFFFFED4           FSTP QWORD PTR FFFFFED4[EBP][EAX*8]
00008: 0A1E FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0A24                     L0036:
00008: 0A24 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0A2A 3B 85 FFFFFDA8              CMP EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0A30 7C FFFFFFD2                 JL L0037

; 400: 	k--;

00008: 0A32 FF 8D FFFFFDA8              DEC DWORD PTR FFFFFDA8[EBP]

; 401:       }

00008: 0A38 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0A3E                     L0031:
00008: 0A3E 83 BD FFFFFDA002            CMP DWORD PTR FFFFFDA0[EBP], 00000002
00008: 0A45 0F 8C FFFFFE9E              JL L0032

; 402:     p[1]=-p[1]/p[0];

00008: 0A4B DD 85 FFFFFEDC              FLD QWORD PTR FFFFFEDC[EBP]
00007: 0A51 D9 E0                       FCHS 
00007: 0A53 DC B5 FFFFFED4              FDIV QWORD PTR FFFFFED4[EBP]
00007: 0A59 DD 9D FFFFFEDC              FSTP QWORD PTR FFFFFEDC[EBP]

; 408:   for(k=0;k<nn;k++)

00008: 0A5F C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 0A69 E9 0000008F                 JMP L0038
00008: 0A6E                     L0039:

; 409:     for(i=0;i<3;i++)

00008: 0A6E C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0A78 EB 74                       JMP L003A
00008: 0A7A                     L003B:

; 410:       sum+=x[k][i]*x[k][i]+ y[k][i]*y[k][i]; 

00008: 0A7A 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0A80 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0A86 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 0A89 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 0A8F 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0A95 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0A98 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0A9E DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00007: 0AA1 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0AA7 DC 0C C6                    FMUL QWORD PTR 00000000[ESI][EAX*8]
00007: 0AAA 8B 1D 00000000              MOV EBX, DWORD PTR _x
00007: 0AB0 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0AB6 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00007: 0AB9 8B 1D 00000000              MOV EBX, DWORD PTR _x
00007: 0ABF 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0AC5 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00007: 0AC8 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0ACE DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 0AD1 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00006: 0AD7 DC 0C C6                    FMUL QWORD PTR 00000000[ESI][EAX*8]
00006: 0ADA DE C1                       FADDP ST(1), ST
00007: 0ADC DC 85 FFFFFDBC              FADD QWORD PTR FFFFFDBC[EBP]
00007: 0AE2 DD 9D FFFFFDBC              FSTP QWORD PTR FFFFFDBC[EBP]
00008: 0AE8 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0AEE                     L003A:
00008: 0AEE 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0AF5 7C FFFFFF83                 JL L003B
00008: 0AF7 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 0AFD                     L0038:
00008: 0AFD 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0B03 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0B09 0F 8C FFFFFF5F              JL L0039

; 412:   sum*=0.5;

00008: 0B0F DD 85 FFFFFDBC              FLD QWORD PTR FFFFFDBC[EBP]
00007: 0B15 DC 0D 00000000              FMUL QWORD PTR .data+00000170
00007: 0B1B DD 9D FFFFFDBC              FSTP QWORD PTR FFFFFDBC[EBP]

; 414:   for(i=0;i<3;i++)

00008: 0B21 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0B2B EB 48                       JMP L003C
00008: 0B2D                     L003D:

; 416:       mu[i]=sqrt(p[i+1]);

00008: 0B2D 8B 95 FFFFFDA0              MOV EDX, DWORD PTR FFFFFDA0[EBP]
00008: 0B33 42                          INC EDX
00008: 0B34 FF B4 D5 FFFFFED8           PUSH DWORD PTR FFFFFED8[EBP][EDX*8]
00008: 0B3B FF B4 D5 FFFFFED4           PUSH DWORD PTR FFFFFED4[EBP][EDX*8]
00008: 0B42 E8 00000000                 CALL SHORT _sqrt
00007: 0B47 59                          POP ECX
00007: 0B48 59                          POP ECX
00007: 0B49 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0B4F DD 9C C5 FFFFFEBC           FSTP QWORD PTR FFFFFEBC[EBP][EAX*8]

; 417:       sum-=mu[i];

00008: 0B56 DD 85 FFFFFDBC              FLD QWORD PTR FFFFFDBC[EBP]
00007: 0B5C 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0B62 DC A4 C5 FFFFFEBC           FSUB QWORD PTR FFFFFEBC[EBP][EAX*8]
00007: 0B69 DD 9D FFFFFDBC              FSTP QWORD PTR FFFFFDBC[EBP]

; 418:     }    

00008: 0B6F FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0B75                     L003C:
00008: 0B75 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0B7C 7C FFFFFFAF                 JL L003D

; 424:   for(k=0;k<3;k++)

00008: 0B7E C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 0B88 E9 0000050A                 JMP L003E
00008: 0B8D                     L003F:

; 428:       for(i=0;i<3;i++)

00008: 0B8D C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0B97 EB 78                       JMP L0040
00008: 0B99                     L0041:

; 430: 	  for(j=0;j<3;j++)

00008: 0B99 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0BA3 EB 32                       JMP L0042
00008: 0BA5                     L0043:

; 431: 	    b[i][j]=rr[i][j];

00008: 0BA5 8B B5 FFFFFDA0              MOV ESI, DWORD PTR FFFFFDA0[EBP]
00008: 0BAB 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0BAE 03 B5 FFFFFDA4              ADD ESI, DWORD PTR FFFFFDA4[EBP]
00008: 0BB4 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0BBA 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0BBD 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0BC3 DD 84 F5 FFFFFE74           FLD QWORD PTR FFFFFE74[EBP][ESI*8]
00007: 0BCA DD 9C DD FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EBX*8]
00008: 0BD1 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0BD7                     L0042:
00008: 0BD7 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0BDE 7C FFFFFFC5                 JL L0043

; 432: 	  b[i][i]-=p[k+1];

00008: 0BE0 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0BE6 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0BE9 03 9D FFFFFDA0              ADD EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0BEF 8B 95 FFFFFDA8              MOV EDX, DWORD PTR FFFFFDA8[EBP]
00008: 0BF5 42                          INC EDX
00008: 0BF6 DD 84 DD FFFFFF5C           FLD QWORD PTR FFFFFF5C[EBP][EBX*8]
00007: 0BFD DC A4 D5 FFFFFED4           FSUB QWORD PTR FFFFFED4[EBP][EDX*8]
00007: 0C04 DD 9C DD FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EBX*8]

; 433: 	}

00008: 0C0B FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0C11                     L0040:
00008: 0C11 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0C18 0F 8C FFFFFF7B              JL L0041

; 434:       bmax=0;

00008: 0C1E DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 0C24 DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 435:       imax=-1;

00008: 0C2A C7 85 FFFFFDB8FFFFFFFF      MOV DWORD PTR FFFFFDB8[EBP], FFFFFFFF

; 436:       for(j=0;j<3;j++)

00008: 0C34 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0C3E EB 62                       JMP L0044
00008: 0C40                     L0045:

; 437: 	if(fabs(b[j][0])>bmax)

00008: 0C40 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0C46 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0C49 FF B4 DD FFFFFF60           PUSH DWORD PTR FFFFFF60[EBP][EBX*8]
00008: 0C50 FF B4 DD FFFFFF5C           PUSH DWORD PTR FFFFFF5C[EBP][EBX*8]
00008: 0C57 E8 00000000                 CALL SHORT _fabs
00007: 0C5C 59                          POP ECX
00007: 0C5D 59                          POP ECX
00007: 0C5E DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00006: 0C64 F1DF                        FCOMIP ST, ST(1), L0046
00007: 0C66 DD D8                       FSTP ST
00008: 0C68 7A 32                       JP L0046
00008: 0C6A 73 30                       JAE L0046

; 439: 	    bmax=fabs(b[j][0]);

00008: 0C6C 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0C72 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0C75 FF B4 DD FFFFFF60           PUSH DWORD PTR FFFFFF60[EBP][EBX*8]
00008: 0C7C FF B4 DD FFFFFF5C           PUSH DWORD PTR FFFFFF5C[EBP][EBX*8]
00008: 0C83 E8 00000000                 CALL SHORT _fabs
00007: 0C88 59                          POP ECX
00007: 0C89 59                          POP ECX
00007: 0C8A DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 440: 	    imax=j;

00008: 0C90 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0C96 89 85 FFFFFDB8              MOV DWORD PTR FFFFFDB8[EBP], EAX

; 441: 	  }

00008: 0C9C                     L0046:
00008: 0C9C FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0CA2                     L0044:
00008: 0CA2 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0CA9 7C FFFFFF95                 JL L0045

; 442:       if(bmax)

00008: 0CAB DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00007: 0CB1 DD 05 00000000              FLD QWORD PTR .data+00000010
00006: 0CB7 F1DF                        FCOMIP ST, ST(1), L0047
00007: 0CB9 DD D8                       FSTP ST
00008: 0CBB 7A 06                       JP L0075
00008: 0CBD 0F 84 00000274              JE L0047
00008: 0CC3                     L0075:

; 444: 	  if(imax)

00008: 0CC3 83 BD FFFFFDB800            CMP DWORD PTR FFFFFDB8[EBP], 00000000
00008: 0CCA 74 6D                       JE L0048

; 445: 	    for(i=0;i<3;i++)

00008: 0CCC C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 0CD6 EB 58                       JMP L0049
00008: 0CD8                     L004A:

; 447: 		double c=b[0][i];

00008: 0CD8 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00008: 0CDE DD 84 C5 FFFFFF5C           FLD QWORD PTR FFFFFF5C[EBP][EAX*8]
00007: 0CE5 DD 9D FFFFFDFC              FSTP QWORD PTR FFFFFDFC[EBP]

; 448: 		b[0][i]=b[imax][i];

00008: 0CEB 8B 9D FFFFFDB8              MOV EBX, DWORD PTR FFFFFDB8[EBP]
00008: 0CF1 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0CF4 03 9D FFFFFDA0              ADD EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0CFA DD 84 DD FFFFFF5C           FLD QWORD PTR FFFFFF5C[EBP][EBX*8]
00007: 0D01 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 0D07 DD 9C C5 FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EAX*8]

; 449: 		b[imax][i]=c;  

00008: 0D0E 8B 9D FFFFFDB8              MOV EBX, DWORD PTR FFFFFDB8[EBP]
00008: 0D14 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0D17 03 9D FFFFFDA0              ADD EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0D1D DD 85 FFFFFDFC              FLD QWORD PTR FFFFFDFC[EBP]
00007: 0D23 DD 9C DD FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EBX*8]

; 450: 	      }

00008: 0D2A FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0D30                     L0049:
00008: 0D30 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0D37 7C FFFFFF9F                 JL L004A
00008: 0D39                     L0048:

; 452: 	  for(i=1;i<3;i++) 

00008: 0D39 C7 85 FFFFFDA000000001      MOV DWORD PTR FFFFFDA0[EBP], 00000001
00008: 0D43 EB 6F                       JMP L004B
00008: 0D45                     L004C:

; 454: 	      bmax=-b[i][0]/b[0][0];       

00008: 0D45 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0D4B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0D4E DD 84 DD FFFFFF5C           FLD QWORD PTR FFFFFF5C[EBP][EBX*8]
00007: 0D55 D9 E0                       FCHS 
00007: 0D57 DC B5 FFFFFF5C              FDIV QWORD PTR FFFFFF5C[EBP]
00007: 0D5D DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 455: 	      for(j=0;j<3;j++)

00008: 0D63 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0D6D EB 36                       JMP L004D
00008: 0D6F                     L004E:

; 456: 		b[i][j]+=bmax*b[0][j];        

00008: 0D6F 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 0D75 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0D78 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0D7E DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00007: 0D84 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 0D8A DC 8C C5 FFFFFF5C           FMUL QWORD PTR FFFFFF5C[EBP][EAX*8]
00007: 0D91 DC 84 DD FFFFFF5C           FADD QWORD PTR FFFFFF5C[EBP][EBX*8]
00007: 0D98 DD 9C DD FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EBX*8]
00008: 0D9F FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0DA5                     L004D:
00008: 0DA5 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0DAC 7C FFFFFFC1                 JL L004E

; 457: 	    }

00008: 0DAE FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 0DB4                     L004B:
00008: 0DB4 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 0DBB 7C FFFFFF88                 JL L004C

; 458: 	  bmax=0;

00008: 0DBD DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 0DC3 DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 459: 	  imax=-1;

00008: 0DC9 C7 85 FFFFFDB8FFFFFFFF      MOV DWORD PTR FFFFFDB8[EBP], FFFFFFFF

; 460: 	  for(j=1;j<3;j++)

00008: 0DD3 C7 85 FFFFFDA400000001      MOV DWORD PTR FFFFFDA4[EBP], 00000001
00008: 0DDD EB 62                       JMP L004F
00008: 0DDF                     L0050:

; 461: 	    if(fabs(b[j][1])>bmax)

00008: 0DDF 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0DE5 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0DE8 FF B4 DD FFFFFF68           PUSH DWORD PTR FFFFFF68[EBP][EBX*8]
00008: 0DEF FF B4 DD FFFFFF64           PUSH DWORD PTR FFFFFF64[EBP][EBX*8]
00008: 0DF6 E8 00000000                 CALL SHORT _fabs
00007: 0DFB 59                          POP ECX
00007: 0DFC 59                          POP ECX
00007: 0DFD DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00006: 0E03 F1DF                        FCOMIP ST, ST(1), L0051
00007: 0E05 DD D8                       FSTP ST
00008: 0E07 7A 32                       JP L0051
00008: 0E09 73 30                       JAE L0051

; 463: 		bmax=fabs(b[j][1]);

00008: 0E0B 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0E11 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0E14 FF B4 DD FFFFFF68           PUSH DWORD PTR FFFFFF68[EBP][EBX*8]
00008: 0E1B FF B4 DD FFFFFF64           PUSH DWORD PTR FFFFFF64[EBP][EBX*8]
00008: 0E22 E8 00000000                 CALL SHORT _fabs
00007: 0E27 59                          POP ECX
00007: 0E28 59                          POP ECX
00007: 0E29 DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 464: 		imax=j;

00008: 0E2F 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0E35 89 85 FFFFFDB8              MOV DWORD PTR FFFFFDB8[EBP], EAX

; 465: 	      }

00008: 0E3B                     L0051:
00008: 0E3B FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0E41                     L004F:
00008: 0E41 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0E48 7C FFFFFF95                 JL L0050

; 466: 	  if(bmax)

00008: 0E4A DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00007: 0E50 DD 05 00000000              FLD QWORD PTR .data+00000010
00006: 0E56 F1DF                        FCOMIP ST, ST(1), L0052
00007: 0E58 DD D8                       FSTP ST
00008: 0E5A 7A 02                       JP L0076
00008: 0E5C 74 53                       JE L0052
00008: 0E5E                     L0076:

; 468: 	     aa[2][k]=1;

00008: 0E5E 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0E64 C7 84 C5 FFFFFF483FF00000   MOV DWORD PTR FFFFFF48[EBP][EAX*8], 3FF00000
00008: 0E6F 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0E75 C7 84 C5 FFFFFF4400000000   MOV DWORD PTR FFFFFF44[EBP][EAX*8], 00000000

; 469:              aa[1][k]=-b[imax][2]/b[imax][1];

00008: 0E80 8B B5 FFFFFDB8              MOV ESI, DWORD PTR FFFFFDB8[EBP]
00008: 0E86 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0E89 8B 9D FFFFFDB8              MOV EBX, DWORD PTR FFFFFDB8[EBP]
00008: 0E8F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0E92 DD 84 DD FFFFFF6C           FLD QWORD PTR FFFFFF6C[EBP][EBX*8]
00007: 0E99 D9 E0                       FCHS 
00007: 0E9B DC B4 F5 FFFFFF64           FDIV QWORD PTR FFFFFF64[EBP][ESI*8]
00007: 0EA2 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0EA8 DD 9C C5 FFFFFF2C           FSTP QWORD PTR FFFFFF2C[EBP][EAX*8]

; 470: 	    }

00008: 0EAF EB 44                       JMP L0053
00008: 0EB1                     L0052:

; 473: 	      aa[2][k]=0;

00008: 0EB1 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0EB7 C7 84 C5 FFFFFF4800000000   MOV DWORD PTR FFFFFF48[EBP][EAX*8], 00000000
00008: 0EC2 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0EC8 C7 84 C5 FFFFFF4400000000   MOV DWORD PTR FFFFFF44[EBP][EAX*8], 00000000

; 474: 	      aa[1][k]=1;

00008: 0ED3 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0ED9 C7 84 C5 FFFFFF303FF00000   MOV DWORD PTR FFFFFF30[EBP][EAX*8], 3FF00000
00008: 0EE4 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0EEA C7 84 C5 FFFFFF2C00000000   MOV DWORD PTR FFFFFF2C[EBP][EAX*8], 00000000

; 475: 	    }

00008: 0EF5                     L0053:

; 476: 	  aa[0][k]=-(aa[1][k]*b[0][1]+aa[2][k]*b[0][2])/b[0][0];

00008: 0EF5 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0EFB DD 84 C5 FFFFFF44           FLD QWORD PTR FFFFFF44[EBP][EAX*8]
00007: 0F02 DC 8D FFFFFF6C              FMUL QWORD PTR FFFFFF6C[EBP]
00007: 0F08 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0F0E DD 84 C5 FFFFFF2C           FLD QWORD PTR FFFFFF2C[EBP][EAX*8]
00006: 0F15 DC 8D FFFFFF64              FMUL QWORD PTR FFFFFF64[EBP]
00006: 0F1B DE C1                       FADDP ST(1), ST
00007: 0F1D D9 E0                       FCHS 
00007: 0F1F DC B5 FFFFFF5C              FDIV QWORD PTR FFFFFF5C[EBP]
00007: 0F25 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 0F2B DD 9C C5 FFFFFF14           FSTP QWORD PTR FFFFFF14[EBP][EAX*8]

; 477: 	}

00008: 0F32 E9 0000015A                 JMP L0054
00008: 0F37                     L0047:

; 480: 	  aa[0][k]=1;

00008: 0F37 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0F3D C7 84 C5 FFFFFF183FF00000   MOV DWORD PTR FFFFFF18[EBP][EAX*8], 3FF00000
00008: 0F48 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 0F4E C7 84 C5 FFFFFF1400000000   MOV DWORD PTR FFFFFF14[EBP][EAX*8], 00000000

; 481: 	  bmax=0;

00008: 0F59 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 0F5F DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 482: 	  imax=-1;

00008: 0F65 C7 85 FFFFFDB8FFFFFFFF      MOV DWORD PTR FFFFFDB8[EBP], FFFFFFFF

; 483: 	  for(j=0;j<3;j++)

00008: 0F6F C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 0F79 EB 62                       JMP L0055
00008: 0F7B                     L0056:

; 484: 	    if(fabs(b[j][1])>bmax)

00008: 0F7B 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0F81 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0F84 FF B4 DD FFFFFF68           PUSH DWORD PTR FFFFFF68[EBP][EBX*8]
00008: 0F8B FF B4 DD FFFFFF64           PUSH DWORD PTR FFFFFF64[EBP][EBX*8]
00008: 0F92 E8 00000000                 CALL SHORT _fabs
00007: 0F97 59                          POP ECX
00007: 0F98 59                          POP ECX
00007: 0F99 DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00006: 0F9F F1DF                        FCOMIP ST, ST(1), L0057
00007: 0FA1 DD D8                       FSTP ST
00008: 0FA3 7A 32                       JP L0057
00008: 0FA5 73 30                       JAE L0057

; 486: 		bmax=fabs(b[j][1]);

00008: 0FA7 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 0FAD 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0FB0 FF B4 DD FFFFFF68           PUSH DWORD PTR FFFFFF68[EBP][EBX*8]
00008: 0FB7 FF B4 DD FFFFFF64           PUSH DWORD PTR FFFFFF64[EBP][EBX*8]
00008: 0FBE E8 00000000                 CALL SHORT _fabs
00007: 0FC3 59                          POP ECX
00007: 0FC4 59                          POP ECX
00007: 0FC5 DD 9D FFFFFDF4              FSTP QWORD PTR FFFFFDF4[EBP]

; 487: 		imax=j;

00008: 0FCB 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00008: 0FD1 89 85 FFFFFDB8              MOV DWORD PTR FFFFFDB8[EBP], EAX

; 488: 	      }

00008: 0FD7                     L0057:
00008: 0FD7 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 0FDD                     L0055:
00008: 0FDD 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 0FE4 7C FFFFFF95                 JL L0056

; 489: 	  if(bmax)

00008: 0FE6 DD 85 FFFFFDF4              FLD QWORD PTR FFFFFDF4[EBP]
00007: 0FEC DD 05 00000000              FLD QWORD PTR .data+00000010
00006: 0FF2 F1DF                        FCOMIP ST, ST(1), L0058
00007: 0FF4 DD D8                       FSTP ST
00008: 0FF6 7A 02                       JP L0077
00008: 0FF8 74 53                       JE L0058
00008: 0FFA                     L0077:

; 491: 	      aa[2][k]=1;

00008: 0FFA 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1000 C7 84 C5 FFFFFF483FF00000   MOV DWORD PTR FFFFFF48[EBP][EAX*8], 3FF00000
00008: 100B 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1011 C7 84 C5 FFFFFF4400000000   MOV DWORD PTR FFFFFF44[EBP][EAX*8], 00000000

; 492: 	      aa[1][k]=-b[imax][2]/b[imax][1];

00008: 101C 8B B5 FFFFFDB8              MOV ESI, DWORD PTR FFFFFDB8[EBP]
00008: 1022 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 1025 8B 9D FFFFFDB8              MOV EBX, DWORD PTR FFFFFDB8[EBP]
00008: 102B 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 102E DD 84 DD FFFFFF6C           FLD QWORD PTR FFFFFF6C[EBP][EBX*8]
00007: 1035 D9 E0                       FCHS 
00007: 1037 DC B4 F5 FFFFFF64           FDIV QWORD PTR FFFFFF64[EBP][ESI*8]
00007: 103E 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 1044 DD 9C C5 FFFFFF2C           FSTP QWORD PTR FFFFFF2C[EBP][EAX*8]

; 493: 	    }

00008: 104B EB 44                       JMP L0059
00008: 104D                     L0058:

; 496: 	      aa[2][k]=0;

00008: 104D 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1053 C7 84 C5 FFFFFF4800000000   MOV DWORD PTR FFFFFF48[EBP][EAX*8], 00000000
00008: 105E 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1064 C7 84 C5 FFFFFF4400000000   MOV DWORD PTR FFFFFF44[EBP][EAX*8], 00000000

; 497: 	      aa[1][k]=1;

00008: 106F 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1075 C7 84 C5 FFFFFF303FF00000   MOV DWORD PTR FFFFFF30[EBP][EAX*8], 3FF00000
00008: 1080 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1086 C7 84 C5 FFFFFF2C00000000   MOV DWORD PTR FFFFFF2C[EBP][EAX*8], 00000000

; 498: 	    }

00008: 1091                     L0059:

; 499: 	}

00008: 1091                     L0054:

; 500:     }

00008: 1091 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 1097                     L003E:
00008: 1097 83 BD FFFFFDA803            CMP DWORD PTR FFFFFDA8[EBP], 00000003
00008: 109E 0F 8C FFFFFAE9              JL L003F

; 502:   for(k=0;k<3;k++)

00008: 10A4 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 10AE E9 000000C4                 JMP L005A
00008: 10B3                     L005B:

; 504:  	  double ak=0;

00008: 10B3 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 10B9 DD 9D FFFFFE04              FSTP QWORD PTR FFFFFE04[EBP]

; 505: 	  for(j=0;j<3;j++)

00008: 10BF C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 10C9 EB 3E                       JMP L005C
00008: 10CB                     L005D:

; 506: 	    ak+=aa[j][k]*aa[j][k];

00008: 10CB 8B B5 FFFFFDA4              MOV ESI, DWORD PTR FFFFFDA4[EBP]
00008: 10D1 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 10D4 03 B5 FFFFFDA8              ADD ESI, DWORD PTR FFFFFDA8[EBP]
00008: 10DA 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 10E0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 10E3 03 9D FFFFFDA8              ADD EBX, DWORD PTR FFFFFDA8[EBP]
00008: 10E9 DD 84 DD FFFFFF14           FLD QWORD PTR FFFFFF14[EBP][EBX*8]
00007: 10F0 DC 8C F5 FFFFFF14           FMUL QWORD PTR FFFFFF14[EBP][ESI*8]
00007: 10F7 DC 85 FFFFFE04              FADD QWORD PTR FFFFFE04[EBP]
00007: 10FD DD 9D FFFFFE04              FSTP QWORD PTR FFFFFE04[EBP]
00008: 1103 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 1109                     L005C:
00008: 1109 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 1110 7C FFFFFFB9                 JL L005D

; 507: 	  ak=1/sqrt(ak);

00008: 1112 FF B5 FFFFFE08              PUSH DWORD PTR FFFFFE08[EBP]
00008: 1118 FF B5 FFFFFE04              PUSH DWORD PTR FFFFFE04[EBP]
00008: 111E E8 00000000                 CALL SHORT _sqrt
00007: 1123 59                          POP ECX
00007: 1124 59                          POP ECX
00007: 1125 DD 05 00000000              FLD QWORD PTR .data+00000208
00006: 112B DE F1                       FDIVRP ST(1), ST
00007: 112D DD 9D FFFFFE04              FSTP QWORD PTR FFFFFE04[EBP]

; 508: 	  for(j=0;j<3;j++)

00008: 1133 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 113D EB 29                       JMP L005E
00008: 113F                     L005F:

; 509: 	    aa[j][k]*=ak;

00008: 113F 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 1145 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 1148 03 9D FFFFFDA8              ADD EBX, DWORD PTR FFFFFDA8[EBP]
00008: 114E DD 84 DD FFFFFF14           FLD QWORD PTR FFFFFF14[EBP][EBX*8]
00007: 1155 DC 8D FFFFFE04              FMUL QWORD PTR FFFFFE04[EBP]
00007: 115B DD 9C DD FFFFFF14           FSTP QWORD PTR FFFFFF14[EBP][EBX*8]
00008: 1162 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 1168                     L005E:
00008: 1168 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 116F 7C FFFFFFCE                 JL L005F

; 510:     }

00008: 1171 FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 1177                     L005A:
00008: 1177 83 BD FFFFFDA803            CMP DWORD PTR FFFFFDA8[EBP], 00000003
00008: 117E 0F 8C FFFFFF2F              JL L005B

; 513:   for(k=0;k<3;k++)

00008: 1184 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 118E E9 000000B0                 JMP L0060
00008: 1193                     L0061:

; 515:       for(i=0;i<3;i++)

00008: 1193 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 119D E9 0000008E                 JMP L0062
00008: 11A2                     L0063:

; 517: 	  double bki=0;

00008: 11A2 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 11A8 DD 9D FFFFFE0C              FSTP QWORD PTR FFFFFE0C[EBP]

; 518: 	  for(j=0;j<3;j++)

00008: 11AE C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 11B8 EB 3E                       JMP L0064
00008: 11BA                     L0065:

; 519: 	    bki+=r[i][j]*aa[j][k];

00008: 11BA 8B B5 FFFFFDA4              MOV ESI, DWORD PTR FFFFFDA4[EBP]
00008: 11C0 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 11C3 03 B5 FFFFFDA8              ADD ESI, DWORD PTR FFFFFDA8[EBP]
00008: 11C9 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 11CF 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 11D2 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 11D8 DD 84 DD FFFFFE2C           FLD QWORD PTR FFFFFE2C[EBP][EBX*8]
00007: 11DF DC 8C F5 FFFFFF14           FMUL QWORD PTR FFFFFF14[EBP][ESI*8]
00007: 11E6 DC 85 FFFFFE0C              FADD QWORD PTR FFFFFE0C[EBP]
00007: 11EC DD 9D FFFFFE0C              FSTP QWORD PTR FFFFFE0C[EBP]
00008: 11F2 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 11F8                     L0064:
00008: 11F8 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 11FF 7C FFFFFFB9                 JL L0065

; 520: 	  b[i][k]=bki/mu[k];

00008: 1201 DD 85 FFFFFE0C              FLD QWORD PTR FFFFFE0C[EBP]
00007: 1207 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 120D DC B4 C5 FFFFFEBC           FDIV QWORD PTR FFFFFEBC[EBP][EAX*8]
00007: 1214 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00007: 121A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 121D 03 9D FFFFFDA8              ADD EBX, DWORD PTR FFFFFDA8[EBP]
00007: 1223 DD 9C DD FFFFFF5C           FSTP QWORD PTR FFFFFF5C[EBP][EBX*8]

; 521: 	}

00008: 122A FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 1230                     L0062:
00008: 1230 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 1237 0F 8C FFFFFF65              JL L0063

; 522:     }

00008: 123D FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 1243                     L0060:
00008: 1243 83 BD FFFFFDA803            CMP DWORD PTR FFFFFDA8[EBP], 00000003
00008: 124A 0F 8C FFFFFF43              JL L0061

; 525:   for(i=0;i<3;i++)

00008: 1250 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 125A E9 0000009D                 JMP L0066
00008: 125F                     L0067:

; 527:       for(j=0;j<3;j++)

00008: 125F C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 1269 EB 7E                       JMP L0068
00008: 126B                     L0069:

; 529: 	  double uij=0;

00008: 126B DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 1271 DD 9D FFFFFE14              FSTP QWORD PTR FFFFFE14[EBP]

; 530: 	  for(k=0;k<3;k++)

00008: 1277 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 1281 EB 3E                       JMP L006A
00008: 1283                     L006B:

; 531: 	    uij+=b[i][k]*aa[j][k];

00008: 1283 8B B5 FFFFFDA4              MOV ESI, DWORD PTR FFFFFDA4[EBP]
00008: 1289 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 128C 03 B5 FFFFFDA8              ADD ESI, DWORD PTR FFFFFDA8[EBP]
00008: 1292 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 1298 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 129B 03 9D FFFFFDA8              ADD EBX, DWORD PTR FFFFFDA8[EBP]
00008: 12A1 DD 84 DD FFFFFF5C           FLD QWORD PTR FFFFFF5C[EBP][EBX*8]
00007: 12A8 DC 8C F5 FFFFFF14           FMUL QWORD PTR FFFFFF14[EBP][ESI*8]
00007: 12AF DC 85 FFFFFE14              FADD QWORD PTR FFFFFE14[EBP]
00007: 12B5 DD 9D FFFFFE14              FSTP QWORD PTR FFFFFE14[EBP]
00008: 12BB FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 12C1                     L006A:
00008: 12C1 83 BD FFFFFDA803            CMP DWORD PTR FFFFFDA8[EBP], 00000003
00008: 12C8 7C FFFFFFB9                 JL L006B

; 532: 	  u[i][j]=uij;

00008: 12CA 8B 9D FFFFFDA0              MOV EBX, DWORD PTR FFFFFDA0[EBP]
00008: 12D0 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 12D3 03 9D FFFFFDA4              ADD EBX, DWORD PTR FFFFFDA4[EBP]
00008: 12D9 DD 85 FFFFFE14              FLD QWORD PTR FFFFFE14[EBP]
00007: 12DF DD 5C DD FFFFFFA4           FSTP QWORD PTR FFFFFFA4[EBP][EBX*8]

; 533: 	}

00008: 12E3 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 12E9                     L0068:
00008: 12E9 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 12F0 0F 8C FFFFFF75              JL L0069

; 534:     }

00008: 12F6 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 12FC                     L0066:
00008: 12FC 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 1303 0F 8C FFFFFF56              JL L0067

; 536:   if(save)

00008: 1309 83 BD FFFFFDAC00            CMP DWORD PTR FFFFFDAC[EBP], 00000000
00008: 1310 0F 84 000000FD              JE L006C

; 540:     for(k=0;k<nn;k++)

00008: 1316 C7 85 FFFFFDA800000000      MOV DWORD PTR FFFFFDA8[EBP], 00000000
00008: 1320 E9 000000DC                 JMP L006D
00008: 1325                     L006E:

; 542: 	for(j=0;j<3;j++)

00008: 1325 C7 85 FFFFFDA400000000      MOV DWORD PTR FFFFFDA4[EBP], 00000000
00008: 132F E9 000000BA                 JMP L006F
00008: 1334                     L0070:

; 544: 	    double ykj=0;

00008: 1334 DD 05 00000000              FLD QWORD PTR .data+00000010
00007: 133A DD 9D FFFFFE1C              FSTP QWORD PTR FFFFFE1C[EBP]

; 545: 	    for(i=0;i<3;i++)

00008: 1340 C7 85 FFFFFDA000000000      MOV DWORD PTR FFFFFDA0[EBP], 00000000
00008: 134A EB 3D                       JMP L0071
00008: 134C                     L0072:

; 546: 	      ykj+=u[j][i]*x[k][i];

00008: 134C 8B 1D 00000000              MOV EBX, DWORD PTR _x
00008: 1352 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1358 8B 34 83                    MOV ESI, DWORD PTR 00000000[EBX][EAX*4]
00008: 135B 8B 9D FFFFFDA4              MOV EBX, DWORD PTR FFFFFDA4[EBP]
00008: 1361 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 1364 03 9D FFFFFDA0              ADD EBX, DWORD PTR FFFFFDA0[EBP]
00008: 136A DD 44 DD FFFFFFA4           FLD QWORD PTR FFFFFFA4[EBP][EBX*8]
00007: 136E 8B 85 FFFFFDA0              MOV EAX, DWORD PTR FFFFFDA0[EBP]
00007: 1374 DC 0C C6                    FMUL QWORD PTR 00000000[ESI][EAX*8]
00007: 1377 DC 85 FFFFFE1C              FADD QWORD PTR FFFFFE1C[EBP]
00007: 137D DD 9D FFFFFE1C              FSTP QWORD PTR FFFFFE1C[EBP]
00008: 1383 FF 85 FFFFFDA0              INC DWORD PTR FFFFFDA0[EBP]
00008: 1389                     L0071:
00008: 1389 83 BD FFFFFDA003            CMP DWORD PTR FFFFFDA0[EBP], 00000003
00008: 1390 7C FFFFFFBA                 JL L0072

; 547: 	    dr[k]+=(ykj-y[k][j])*(ykj-y[k][j]);

00008: 1392 8B 1D 00000000              MOV EBX, DWORD PTR _y
00008: 1398 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 139E 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 13A1 DD 85 FFFFFE1C              FLD QWORD PTR FFFFFE1C[EBP]
00007: 13A7 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00007: 13AD DC 24 C2                    FSUB QWORD PTR 00000000[EDX][EAX*8]
00007: 13B0 8B 1D 00000000              MOV EBX, DWORD PTR _y
00007: 13B6 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 13BC 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00007: 13BF DD 85 FFFFFE1C              FLD QWORD PTR FFFFFE1C[EBP]
00006: 13C5 8B 85 FFFFFDA4              MOV EAX, DWORD PTR FFFFFDA4[EBP]
00006: 13CB DC 24 C2                    FSUB QWORD PTR 00000000[EDX][EAX*8]
00006: 13CE DE C9                       FMULP ST(1), ST
00007: 13D0 8B 15 00000000              MOV EDX, DWORD PTR _dr
00007: 13D6 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 13DC DC 04 C2                    FADD QWORD PTR 00000000[EDX][EAX*8]
00007: 13DF 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00007: 13E5 DD 1C C2                    FSTP QWORD PTR 00000000[EDX][EAX*8]

; 548: 	  }

00008: 13E8 FF 85 FFFFFDA4              INC DWORD PTR FFFFFDA4[EBP]
00008: 13EE                     L006F:
00008: 13EE 83 BD FFFFFDA403            CMP DWORD PTR FFFFFDA4[EBP], 00000003
00008: 13F5 0F 8C FFFFFF39              JL L0070

; 549:       }

00008: 13FB FF 85 FFFFFDA8              INC DWORD PTR FFFFFDA8[EBP]
00008: 1401                     L006D:
00008: 1401 8B 85 FFFFFDA8              MOV EAX, DWORD PTR FFFFFDA8[EBP]
00008: 1407 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 140D 0F 8C FFFFFF12              JL L006E
00008: 1413                     L006C:

; 553:   if(save)return sum;

00008: 1413 83 BD FFFFFDAC00            CMP DWORD PTR FFFFFDAC[EBP], 00000000
00008: 141A 74 0E                       JE L0073
00008: 141C DD 85 FFFFFDBC              FLD QWORD PTR FFFFFDBC[EBP]
00000: 1422                             epilog 
00000: 1422 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1425 5F                          POP EDI
00000: 1426 5E                          POP ESI
00000: 1427 5B                          POP EBX
00000: 1428 5D                          POP EBP
00000: 1429 C3                          RETN 
00008: 142A                     L0073:

; 554:  else return -sum;

00008: 142A DD 85 FFFFFDBC              FLD QWORD PTR FFFFFDBC[EBP]
00007: 1430 D9 E0                       FCHS 
00000: 1432                     L0000:
00000: 1432                             epilog 
00000: 1432 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 1435 5F                          POP EDI
00000: 1436 5E                          POP ESI
00000: 1437 5B                          POP EBX
00000: 1438 5D                          POP EBP
00000: 1439 C3                          RETN 

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

Function: _sqrt

; 552: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: if(x >=0.0)

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 05 00000000              FLD QWORD PTR .data+00000010
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

Function: _save_rms

; 560: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 81 EC 00000230              SUB ESP, 00000230
00000: 000A 57                          PUSH EDI
00000: 000B B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 0010 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0014 B9 0000008C                 MOV ECX, 0000008C
00000: 0019 F3 AB                       REP STOSD 
00000: 001B 5F                          POP EDI
00000: 001C                             prolog 

; 564:   int fErr=noErr;

00008: 001C C7 85 FFFFFDD800000000      MOV DWORD PTR FFFFFDD8[EBP], 00000000

; 565:   long maxl=bound[0].length/2;

00008: 0026 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 002C DD 02                       FLD QWORD PTR 00000000[EDX]
00007: 002E DC 0D 00000000              FMUL QWORD PTR .data+00000170
00007: 0034 D9 BD FFFFFDE8              FNSTCW WORD PTR FFFFFDE8[EBP]
00007: 003A 8B 95 FFFFFDE8              MOV EDX, DWORD PTR FFFFFDE8[EBP]
00007: 0040 80 8D FFFFFDE90C            OR BYTE PTR FFFFFDE9[EBP], 0C
00007: 0047 D9 AD FFFFFDE8              FLDCW WORD PTR FFFFFDE8[EBP]
00007: 004D DB 9D FFFFFDF4              FISTP DWORD PTR FFFFFDF4[EBP]
00008: 0053 89 95 FFFFFDE8              MOV DWORD PTR FFFFFDE8[EBP], EDX
00008: 0059 D9 AD FFFFFDE8              FLDCW WORD PTR FFFFFDE8[EBP]
00008: 005F 8B 95 FFFFFDF4              MOV EDX, DWORD PTR FFFFFDF4[EBP]
00008: 0065 89 95 FFFFFDDC              MOV DWORD PTR FFFFFDDC[EBP], EDX

; 566:   long n_mes1=i_mes;

00008: 006B A1 00000000                 MOV EAX, DWORD PTR _i_mes
00008: 0070 89 85 FFFFFDE0              MOV DWORD PTR FFFFFDE0[EBP], EAX

; 568:   path=fopen(cont_file_name,"wb");

00008: 0076 68 00000000                 PUSH OFFSET @581
00008: 007B 68 00000000                 PUSH OFFSET _cont_file_name
00008: 0080 E8 00000000                 CALL SHORT _fopen
00008: 0085 59                          POP ECX
00008: 0086 59                          POP ECX
00008: 0087 89 85 FFFFFDE4              MOV DWORD PTR FFFFFDE4[EBP], EAX

; 569:   if(!path)return 1;  

00008: 008D 83 BD FFFFFDE400            CMP DWORD PTR FFFFFDE4[EBP], 00000000
00008: 0094 75 0B                       JNE L0001
00008: 0096 B8 00000001                 MOV EAX, 00000001
00000: 009B                             epilog 
00000: 009B 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 009E 5B                          POP EBX
00000: 009F 5D                          POP EBP
00000: 00A0 C3                          RETN 
00008: 00A1                     L0001:

; 570:     if(n_mes1 && dr)

00008: 00A1 83 BD FFFFFDE000            CMP DWORD PTR FFFFFDE0[EBP], 00000000
00008: 00A8 0F 84 000001B3              JE L0002
00008: 00AE 83 3D 00000000 00           CMP DWORD PTR _dr, 00000000
00008: 00B5 0F 84 000001A6              JE L0002

; 572: 	  nbyte=sprintf(&s[0],"//rms time=%lf\n",get_time());

00008: 00BB E8 00000000                 CALL SHORT _get_time
00007: 00C0 DD 9D FFFFFDEC              FSTP QWORD PTR FFFFFDEC[EBP]
00008: 00C6 FF B5 FFFFFDF0              PUSH DWORD PTR FFFFFDF0[EBP]
00008: 00CC FF B5 FFFFFDEC              PUSH DWORD PTR FFFFFDEC[EBP]
00008: 00D2 68 00000000                 PUSH OFFSET @582
00008: 00D7 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 00DD 50                          PUSH EAX
00008: 00DE E8 00000000                 CALL SHORT _sprintf
00008: 00E3 83 C4 10                    ADD ESP, 00000010
00008: 00E6 89 85 FFFFFDCC              MOV DWORD PTR FFFFFDCC[EBP], EAX

; 573: 	  if(nbyte<=0){fclose(path); return 1;}

00008: 00EC 83 BD FFFFFDCC00            CMP DWORD PTR FFFFFDCC[EBP], 00000000
00008: 00F3 7F 17                       JG L0003
00008: 00F5 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 00FB E8 00000000                 CALL SHORT _fclose
00008: 0100 59                          POP ECX
00008: 0101 B8 00000001                 MOV EAX, 00000001
00000: 0106                             epilog 
00000: 0106 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0109 5B                          POP EBX
00000: 010A 5D                          POP EBP
00000: 010B C3                          RETN 
00008: 010C                     L0003:

; 574: 	  fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 010C FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0112 FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 0118 6A 01                       PUSH 00000001
00008: 011A 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 0120 50                          PUSH EAX
00008: 0121 E8 00000000                 CALL SHORT _fwrite
00008: 0126 83 C4 10                    ADD ESP, 00000010
00008: 0129 39 85 FFFFFDCC              CMP DWORD PTR FFFFFDCC[EBP], EAX
00008: 012F 0F 95 C2                    SETNE DL
00008: 0132 83 E2 01                    AND EDX, 00000001
00008: 0135 89 95 FFFFFDD8              MOV DWORD PTR FFFFFDD8[EBP], EDX

; 575: 	  if(fErr){fclose(path);return 1;}

00008: 013B 83 BD FFFFFDD800            CMP DWORD PTR FFFFFDD8[EBP], 00000000
00008: 0142 74 17                       JE L0004
00008: 0144 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 014A E8 00000000                 CALL SHORT _fclose
00008: 014F 59                          POP ECX
00008: 0150 B8 00000001                 MOV EAX, 00000001
00000: 0155                             epilog 
00000: 0155 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0158 5B                          POP EBX
00000: 0159 5D                          POP EBP
00000: 015A C3                          RETN 
00008: 015B                     L0004:

; 576: 	  for(i=0;i<nn;i++)

00008: 015B C7 85 FFFFFDD000000000      MOV DWORD PTR FFFFFDD0[EBP], 00000000
00008: 0165 E9 000000E5                 JMP L0005
00008: 016A                     L0006:

; 578: 	      nbyte=sprintf(&s[0],"%ld %le \n",i+n01,dr[i]/n_mes1);

00008: 016A 8B 15 00000000              MOV EDX, DWORD PTR _dr
00008: 0170 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00008: 0176 89 85 FFFFFDF4              MOV DWORD PTR FFFFFDF4[EBP], EAX
00008: 017C DB 85 FFFFFDF4              FILD DWORD PTR FFFFFDF4[EBP]
00007: 0182 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00007: 0188 DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 018B DE F1                       FDIVRP ST(1), ST
00007: 018D 50                          PUSH EAX
00007: 018E 50                          PUSH EAX
00007: 018F DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0192 8B 95 FFFFFDD0              MOV EDX, DWORD PTR FFFFFDD0[EBP]
00008: 0198 03 15 00000000              ADD EDX, DWORD PTR _n01
00008: 019E 52                          PUSH EDX
00008: 019F 68 00000000                 PUSH OFFSET @583
00008: 01A4 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 01AA 50                          PUSH EAX
00008: 01AB E8 00000000                 CALL SHORT _sprintf
00008: 01B0 83 C4 14                    ADD ESP, 00000014
00008: 01B3 89 85 FFFFFDCC              MOV DWORD PTR FFFFFDCC[EBP], EAX

; 579:               dr[i]=0;

00008: 01B9 8B 15 00000000              MOV EDX, DWORD PTR _dr
00008: 01BF 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 01C5 C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 01CD 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 01D3 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000

; 580: 	      if(nbyte<=0){fclose(path); return 1;}

00008: 01DA 83 BD FFFFFDCC00            CMP DWORD PTR FFFFFDCC[EBP], 00000000
00008: 01E1 7F 17                       JG L0007
00008: 01E3 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 01E9 E8 00000000                 CALL SHORT _fclose
00008: 01EE 59                          POP ECX
00008: 01EF B8 00000001                 MOV EAX, 00000001
00000: 01F4                             epilog 
00000: 01F4 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 01F7 5B                          POP EBX
00000: 01F8 5D                          POP EBP
00000: 01F9 C3                          RETN 
00008: 01FA                     L0007:

; 581: 	      fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 01FA FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0200 FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 0206 6A 01                       PUSH 00000001
00008: 0208 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 020E 50                          PUSH EAX
00008: 020F E8 00000000                 CALL SHORT _fwrite
00008: 0214 83 C4 10                    ADD ESP, 00000010
00008: 0217 39 85 FFFFFDCC              CMP DWORD PTR FFFFFDCC[EBP], EAX
00008: 021D 0F 95 C2                    SETNE DL
00008: 0220 83 E2 01                    AND EDX, 00000001
00008: 0223 89 95 FFFFFDD8              MOV DWORD PTR FFFFFDD8[EBP], EDX

; 582: 	      if(fErr){fclose(path);return 1;}

00008: 0229 83 BD FFFFFDD800            CMP DWORD PTR FFFFFDD8[EBP], 00000000
00008: 0230 74 17                       JE L0008
00008: 0232 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0238 E8 00000000                 CALL SHORT _fclose
00008: 023D 59                          POP ECX
00008: 023E B8 00000001                 MOV EAX, 00000001
00000: 0243                             epilog 
00000: 0243 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0246 5B                          POP EBX
00000: 0247 5D                          POP EBP
00000: 0248 C3                          RETN 
00008: 0249                     L0008:

; 583: 	    };

00008: 0249 FF 85 FFFFFDD0              INC DWORD PTR FFFFFDD0[EBP]
00008: 024F                     L0005:
00008: 024F 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 0255 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 025B 0F 8C FFFFFF09              JL L0006

; 584: 	}

00008: 0261                     L0002:

; 585:   if(n_mes1)

00008: 0261 83 BD FFFFFDE000            CMP DWORD PTR FFFFFDE0[EBP], 00000000
00008: 0268 0F 84 00000221              JE L0009

; 587:       nbyte=sprintf(&s[0],"//contacts \n");

00008: 026E 68 00000000                 PUSH OFFSET @584
00008: 0273 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 0279 50                          PUSH EAX
00008: 027A E8 00000000                 CALL SHORT _sprintf
00008: 027F 59                          POP ECX
00008: 0280 59                          POP ECX
00008: 0281 89 85 FFFFFDCC              MOV DWORD PTR FFFFFDCC[EBP], EAX

; 588:       if(nbyte<=0){fclose(path); return 1;}

00008: 0287 83 BD FFFFFDCC00            CMP DWORD PTR FFFFFDCC[EBP], 00000000
00008: 028E 7F 17                       JG L000A
00008: 0290 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0296 E8 00000000                 CALL SHORT _fclose
00008: 029B 59                          POP ECX
00008: 029C B8 00000001                 MOV EAX, 00000001
00000: 02A1                             epilog 
00000: 02A1 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 02A4 5B                          POP EBX
00000: 02A5 5D                          POP EBP
00000: 02A6 C3                          RETN 
00008: 02A7                     L000A:

; 589:       fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 02A7 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 02AD FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 02B3 6A 01                       PUSH 00000001
00008: 02B5 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 02BB 50                          PUSH EAX
00008: 02BC E8 00000000                 CALL SHORT _fwrite
00008: 02C1 83 C4 10                    ADD ESP, 00000010
00008: 02C4 39 85 FFFFFDCC              CMP DWORD PTR FFFFFDCC[EBP], EAX
00008: 02CA 0F 95 C2                    SETNE DL
00008: 02CD 83 E2 01                    AND EDX, 00000001
00008: 02D0 89 95 FFFFFDD8              MOV DWORD PTR FFFFFDD8[EBP], EDX

; 590:       if(fErr){fclose(path);return 1;}

00008: 02D6 83 BD FFFFFDD800            CMP DWORD PTR FFFFFDD8[EBP], 00000000
00008: 02DD 74 17                       JE L000B
00008: 02DF FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 02E5 E8 00000000                 CALL SHORT _fclose
00008: 02EA 59                          POP ECX
00008: 02EB B8 00000001                 MOV EAX, 00000001
00000: 02F0                             epilog 
00000: 02F0 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 02F3 5B                          POP EBX
00000: 02F4 5D                          POP EBP
00000: 02F5 C3                          RETN 
00008: 02F6                     L000B:

; 591:       for(i=1;i<nn;i++)

00008: 02F6 C7 85 FFFFFDD000000001      MOV DWORD PTR FFFFFDD0[EBP], 00000001
00008: 0300 E9 00000178                 JMP L000C
00008: 0305                     L000D:

; 592: 	for(j=0;j<i;j++)

00008: 0305 C7 85 FFFFFDD400000000      MOV DWORD PTR FFFFFDD4[EBP], 00000000
00008: 030F E9 00000151                 JMP L000E
00008: 0314                     L000F:

; 594: 	    nbyte=sprintf(&s[0],"%ld %ld %le %le \n",

00008: 0314 8B 1D 00000000              MOV EBX, DWORD PTR _contE
00008: 031A 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 0320 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0323 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00008: 0329 89 85 FFFFFDF4              MOV DWORD PTR FFFFFDF4[EBP], EAX
00008: 032F DB 85 FFFFFDF4              FILD DWORD PTR FFFFFDF4[EBP]
00007: 0335 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00007: 033B DD 04 C2                    FLD QWORD PTR 00000000[EDX][EAX*8]
00006: 033E DE F1                       FDIVRP ST(1), ST
00007: 0340 50                          PUSH EAX
00007: 0341 50                          PUSH EAX
00007: 0342 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0345 8B 1D 00000000              MOV EBX, DWORD PTR _cont
00008: 034B 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 0351 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0354 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00008: 035A DB 04 82                    FILD DWORD PTR 00000000[EDX][EAX*4]
00007: 035D 8B 85 FFFFFDE0              MOV EAX, DWORD PTR FFFFFDE0[EBP]
00007: 0363 89 85 FFFFFDF4              MOV DWORD PTR FFFFFDF4[EBP], EAX
00007: 0369 DB 85 FFFFFDF4              FILD DWORD PTR FFFFFDF4[EBP]
00006: 036F DE F9                       FDIVP ST(1), ST
00007: 0371 50                          PUSH EAX
00007: 0372 50                          PUSH EAX
00007: 0373 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 0376 8B 95 FFFFFDD0              MOV EDX, DWORD PTR FFFFFDD0[EBP]
00008: 037C 03 15 00000000              ADD EDX, DWORD PTR _n01
00008: 0382 52                          PUSH EDX
00008: 0383 8B 95 FFFFFDD4              MOV EDX, DWORD PTR FFFFFDD4[EBP]
00008: 0389 03 15 00000000              ADD EDX, DWORD PTR _n01
00008: 038F 52                          PUSH EDX
00008: 0390 68 00000000                 PUSH OFFSET @585
00008: 0395 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 039B 50                          PUSH EAX
00008: 039C E8 00000000                 CALL SHORT _sprintf
00008: 03A1 83 C4 20                    ADD ESP, 00000020
00008: 03A4 89 85 FFFFFDCC              MOV DWORD PTR FFFFFDCC[EBP], EAX

; 597:             cont[i][j]=0;

00008: 03AA 8B 1D 00000000              MOV EBX, DWORD PTR _cont
00008: 03B0 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 03B6 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 03B9 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00008: 03BF C7 04 82 00000000           MOV DWORD PTR 00000000[EDX][EAX*4], 00000000

; 598:             contE[i][j]=0;

00008: 03C6 8B 1D 00000000              MOV EBX, DWORD PTR _contE
00008: 03CC 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 03D2 8B 14 83                    MOV EDX, DWORD PTR 00000000[EBX][EAX*4]
00008: 03D5 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00008: 03DB C7 44 C2 04 00000000        MOV DWORD PTR 00000004[EDX][EAX*8], 00000000
00008: 03E3 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00008: 03E9 C7 04 C2 00000000           MOV DWORD PTR 00000000[EDX][EAX*8], 00000000

; 599: 	    if(nbyte<=0){fclose(path); return 1;}

00008: 03F0 83 BD FFFFFDCC00            CMP DWORD PTR FFFFFDCC[EBP], 00000000
00008: 03F7 7F 17                       JG L0010
00008: 03F9 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 03FF E8 00000000                 CALL SHORT _fclose
00008: 0404 59                          POP ECX
00008: 0405 B8 00000001                 MOV EAX, 00000001
00000: 040A                             epilog 
00000: 040A 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 040D 5B                          POP EBX
00000: 040E 5D                          POP EBP
00000: 040F C3                          RETN 
00008: 0410                     L0010:

; 600: 	    fErr=(fwrite(&s[0],1,nbyte,path)!=nbyte);

00008: 0410 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0416 FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 041C 6A 01                       PUSH 00000001
00008: 041E 8D 85 FFFFFDFC              LEA EAX, DWORD PTR FFFFFDFC[EBP]
00008: 0424 50                          PUSH EAX
00008: 0425 E8 00000000                 CALL SHORT _fwrite
00008: 042A 83 C4 10                    ADD ESP, 00000010
00008: 042D 39 85 FFFFFDCC              CMP DWORD PTR FFFFFDCC[EBP], EAX
00008: 0433 0F 95 C2                    SETNE DL
00008: 0436 83 E2 01                    AND EDX, 00000001
00008: 0439 89 95 FFFFFDD8              MOV DWORD PTR FFFFFDD8[EBP], EDX

; 601: 	    if(fErr){fclose(path);return 1;}

00008: 043F 83 BD FFFFFDD800            CMP DWORD PTR FFFFFDD8[EBP], 00000000
00008: 0446 74 17                       JE L0011
00008: 0448 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 044E E8 00000000                 CALL SHORT _fclose
00008: 0453 59                          POP ECX
00008: 0454 B8 00000001                 MOV EAX, 00000001
00000: 0459                             epilog 
00000: 0459 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 045C 5B                          POP EBX
00000: 045D 5D                          POP EBP
00000: 045E C3                          RETN 
00008: 045F                     L0011:

; 602: 	  }

00008: 045F FF 85 FFFFFDD4              INC DWORD PTR FFFFFDD4[EBP]
00008: 0465                     L000E:
00008: 0465 8B 85 FFFFFDD4              MOV EAX, DWORD PTR FFFFFDD4[EBP]
00008: 046B 3B 85 FFFFFDD0              CMP EAX, DWORD PTR FFFFFDD0[EBP]
00008: 0471 0F 8C FFFFFE9D              JL L000F
00008: 0477 FF 85 FFFFFDD0              INC DWORD PTR FFFFFDD0[EBP]
00008: 047D                     L000C:
00008: 047D 8B 85 FFFFFDD0              MOV EAX, DWORD PTR FFFFFDD0[EBP]
00008: 0483 3B 05 00000000              CMP EAX, DWORD PTR _nn
00008: 0489 0F 8C FFFFFE76              JL L000D

; 603:     }

00008: 048F                     L0009:

; 604:   fclose(path);

00008: 048F FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 0495 E8 00000000                 CALL SHORT _fclose
00008: 049A 59                          POP ECX

; 605:   return 1;

00008: 049B B8 00000001                 MOV EAX, 00000001
00000: 04A0                     L0000:
00000: 04A0                             epilog 
00000: 04A0 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 04A3 5B                          POP EBX
00000: 04A4 5D                          POP EBP
00000: 04A5 C3                          RETN 

Function: _is_rms

; 609: {return good;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 609: {return good;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR .bss+00000008
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _n_rms

; 612: {return nn;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 612: {return nn;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _nn
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _n0_rms

; 615: {return n0;}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 615: {return n0;}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _n0
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _contact

; 619: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 620:   well_type ct=bond((short)i,(short)j);

00008: 0012 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0015 50                          PUSH EAX
00008: 0016 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0019 50                          PUSH EAX
00008: 001A E8 00000000                 CALL SHORT _bond
00008: 001F 59                          POP ECX
00008: 0020 59                          POP ECX
00008: 0021 0F BF D0                    MOVSX EDX, AX
00008: 0024 89 55 FFFFFFFC              MOV DWORD PTR FFFFFFFC[EBP], EDX

; 621:   if(ct<0)return 0;

00008: 0027 83 7D FFFFFFFC 00           CMP DWORD PTR FFFFFFFC[EBP], 00000000
00008: 002B 7D 07                       JGE L0001
00008: 002D B8 00000000                 MOV EAX, 00000000
00000: 0032                             epilog 
00000: 0032 C9                          LEAVE 
00000: 0033 C3                          RETN 
00008: 0034                     L0001:

; 622:   if((!is_bond(ct))&&is_internal(ct))

00008: 0034 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0037 E8 00000000                 CALL SHORT _is_bond
00008: 003C 59                          POP ECX
00008: 003D 83 F8 00                    CMP EAX, 00000000
00008: 0040 75 33                       JNE L0002
00008: 0042 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0045 E8 00000000                 CALL SHORT _is_internal
00008: 004A 59                          POP ECX
00008: 004B 83 F8 00                    CMP EAX, 00000000
00008: 004E 74 25                       JE L0002

; 624:       if(etot(ct)>0)return 1;

00008: 0050 FF 75 FFFFFFFC              PUSH DWORD PTR FFFFFFFC[EBP]
00008: 0053 E8 00000000                 CALL SHORT _etot
00007: 0058 59                          POP ECX
00007: 0059 DD 05 00000000              FLD QWORD PTR .data+00000010
00006: 005F F1DF                        FCOMIP ST, ST(1), L0003
00007: 0061 DD D8                       FSTP ST
00008: 0063 7A 09                       JP L0003
00008: 0065 73 07                       JAE L0003
00008: 0067 B8 00000001                 MOV EAX, 00000001
00000: 006C                             epilog 
00000: 006C C9                          LEAVE 
00000: 006D C3                          RETN 
00008: 006E                     L0003:

; 625:       else return -1;

00008: 006E B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0073                             epilog 
00000: 0073 C9                          LEAVE 
00000: 0074 C3                          RETN 
00008: 0075                     L0002:

; 627:   return 0;

00008: 0075 B8 00000000                 MOV EAX, 00000000
00000: 007A                     L0000:
00000: 007A                             epilog 
00000: 007A C9                          LEAVE 
00000: 007B C3                          RETN 

Function: _open_rms_file

; 631: {

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

; 634:   int fErr=noErr;

00008: 001B C7 85 FFFFFDFC00000000      MOV DWORD PTR FFFFFDFC[EBP], 00000000

; 635:   last_time=get_time();

00008: 0025 E8 00000000                 CALL SHORT _get_time
00007: 002A DD 1D 00000000              FSTP QWORD PTR .bss+00000000

; 636:   if(good)

00008: 0030 83 3D 00000000 00           CMP DWORD PTR .bss+00000008, 00000000
00008: 0037 74 05                       JE L0001

; 637:      close_rms(); 

00008: 0039 E8 00000000                 CALL SHORT _close_rms
00008: 003E                     L0001:

; 638:   echo_path=fopen(fname,"wb");

00008: 003E 68 00000000                 PUSH OFFSET @581
00008: 0043 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0046 50                          PUSH EAX
00008: 0047 E8 00000000                 CALL SHORT _fopen
00008: 004C 59                          POP ECX
00008: 004D 59                          POP ECX
00008: 004E A3 00000000                 MOV DWORD PTR _echo_path, EAX

; 639:   if(!echo_path)return 0;

00008: 0053 83 3D 00000000 00           CMP DWORD PTR _echo_path, 00000000
00008: 005A 75 07                       JNE L0002
00008: 005C B8 00000000                 MOV EAX, 00000000
00000: 0061                             epilog 
00000: 0061 C9                          LEAVE 
00000: 0062 C3                          RETN 
00008: 0063                     L0002:

; 641:   nbyte=sprintf(s,

00008: 0063 68 00000000                 PUSH OFFSET @623
00008: 0068 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 006E 50                          PUSH EAX
00008: 006F E8 00000000                 CALL SHORT _sprintf
00008: 0074 59                          POP ECX
00008: 0075 59                          POP ECX
00008: 0076 89 85 FFFFFDF8              MOV DWORD PTR FFFFFDF8[EBP], EAX

; 643:   if(nbyte<=0){ fclose(echo_path);return 0;}

00008: 007C 83 BD FFFFFDF800            CMP DWORD PTR FFFFFDF8[EBP], 00000000
00008: 0083 7F 13                       JG L0003
00008: 0085 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 008A 50                          PUSH EAX
00008: 008B E8 00000000                 CALL SHORT _fclose
00008: 0090 59                          POP ECX
00008: 0091 B8 00000000                 MOV EAX, 00000000
00000: 0096                             epilog 
00000: 0096 C9                          LEAVE 
00000: 0097 C3                          RETN 
00008: 0098                     L0003:

; 644:   if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}

00008: 0098 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 009D 50                          PUSH EAX
00008: 009E FF B5 FFFFFDF8              PUSH DWORD PTR FFFFFDF8[EBP]
00008: 00A4 6A 01                       PUSH 00000001
00008: 00A6 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 00AC 50                          PUSH EAX
00008: 00AD E8 00000000                 CALL SHORT _fwrite
00008: 00B2 83 C4 10                    ADD ESP, 00000010
00008: 00B5 39 85 FFFFFDF8              CMP DWORD PTR FFFFFDF8[EBP], EAX
00008: 00BB 74 13                       JE L0004
00008: 00BD A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 00C2 50                          PUSH EAX
00008: 00C3 E8 00000000                 CALL SHORT _fclose
00008: 00C8 59                          POP ECX
00008: 00C9 B8 00000000                 MOV EAX, 00000000
00000: 00CE                             epilog 
00000: 00CE C9                          LEAVE 
00000: 00CF C3                          RETN 
00008: 00D0                     L0004:

; 645:   else return 1;

00008: 00D0 B8 00000001                 MOV EAX, 00000001
00000: 00D5                     L0000:
00000: 00D5                             epilog 
00000: 00D5 C9                          LEAVE 
00000: 00D6 C3                          RETN 

Function: _write_rms_echo

; 651: { long nbyte;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 81 EC 00000248              SUB ESP, 00000248
00000: 0009 57                          PUSH EDI
00000: 000A B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000F 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0013 B9 00000092                 MOV ECX, 00000092
00000: 0018 F3 AB                       REP STOSD 
00000: 001A 5F                          POP EDI
00000: 001B                             prolog 

; 653:   moveatoms();  

00008: 001B E8 00000000                 CALL SHORT _moveatoms

; 655:   long nnn=pairs(nonnative);

00008: 0020 68 00000000                 PUSH OFFSET _nonnative
00008: 0025 E8 00000000                 CALL SHORT _pairs
00008: 002A 59                          POP ECX
00008: 002B 89 85 FFFFFDC0              MOV DWORD PTR FFFFFDC0[EBP], EAX

; 656:   double time=get_mes_time();

00008: 0031 E8 00000000                 CALL SHORT _get_mes_time
00007: 0036 DD 9D FFFFFDC8              FSTP QWORD PTR FFFFFDC8[EBP]

; 657:   double energy=countenergy();

00008: 003C E8 00000000                 CALL SHORT _countenergy
00007: 0041 DD 9D FFFFFDD0              FSTP QWORD PTR FFFFFDD0[EBP]

; 658:   double temp=get_temp();

00008: 0047 E8 00000000                 CALL SHORT _get_temp
00007: 004C DD 9D FFFFFDD8              FSTP QWORD PTR FFFFFDD8[EBP]

; 659:   double rms=get_rms(energy);

00008: 0052 FF B5 FFFFFDD4              PUSH DWORD PTR FFFFFDD4[EBP]
00008: 0058 FF B5 FFFFFDD0              PUSH DWORD PTR FFFFFDD0[EBP]
00008: 005E E8 00000000                 CALL SHORT _get_rms
00007: 0063 59                          POP ECX
00007: 0064 59                          POP ECX
00007: 0065 DD 9D FFFFFDE0              FSTP QWORD PTR FFFFFDE0[EBP]

; 660:   double T=2*get_T()*get_corr()/3;

00008: 006B E8 00000000                 CALL SHORT _get_corr
00007: 0070 DD 9D FFFFFDF0              FSTP QWORD PTR FFFFFDF0[EBP]
00008: 0076 E8 00000000                 CALL SHORT _get_T
00007: 007B DC 0D 00000000              FMUL QWORD PTR .data+000002a0
00007: 0081 DC 8D FFFFFDF0              FMUL QWORD PTR FFFFFDF0[EBP]
00007: 0087 DD 9D FFFFFDF8              FSTP QWORD PTR FFFFFDF8[EBP]
00008: 008D DD 85 FFFFFDF8              FLD QWORD PTR FFFFFDF8[EBP]
00007: 0093 DC 0D 00000000              FMUL QWORD PTR .data+000002a8
00007: 0099 DD 9D FFFFFDE8              FSTP QWORD PTR FFFFFDE8[EBP]

; 661:   int nucleus=is_nucleus();

00008: 009F E8 00000000                 CALL SHORT _is_nucleus
00008: 00A4 89 85 FFFFFDC4              MOV DWORD PTR FFFFFDC4[EBP], EAX

; 662:     nbyte=sprintf(&s[0],"%12.4lf\11%10.4lf\11%10.3lf\11%4ld\11%10.3lf\11%10.3lf\11%12.5lf %1d\n"

00008: 00AA FF B5 FFFFFDC4              PUSH DWORD PTR FFFFFDC4[EBP]
00008: 00B0 FF B5 FFFFFDEC              PUSH DWORD PTR FFFFFDEC[EBP]
00008: 00B6 FF B5 FFFFFDE8              PUSH DWORD PTR FFFFFDE8[EBP]
00008: 00BC FF 35 00000004              PUSH DWORD PTR _gr+00000004
00008: 00C2 FF 35 00000000              PUSH DWORD PTR _gr
00008: 00C8 FF B5 FFFFFDE4              PUSH DWORD PTR FFFFFDE4[EBP]
00008: 00CE FF B5 FFFFFDE0              PUSH DWORD PTR FFFFFDE0[EBP]
00008: 00D4 FF B5 FFFFFDC0              PUSH DWORD PTR FFFFFDC0[EBP]
00008: 00DA FF B5 FFFFFDD4              PUSH DWORD PTR FFFFFDD4[EBP]
00008: 00E0 FF B5 FFFFFDD0              PUSH DWORD PTR FFFFFDD0[EBP]
00008: 00E6 FF B5 FFFFFDDC              PUSH DWORD PTR FFFFFDDC[EBP]
00008: 00EC FF B5 FFFFFDD8              PUSH DWORD PTR FFFFFDD8[EBP]
00008: 00F2 FF B5 FFFFFDCC              PUSH DWORD PTR FFFFFDCC[EBP]
00008: 00F8 FF B5 FFFFFDC8              PUSH DWORD PTR FFFFFDC8[EBP]
00008: 00FE 68 00000000                 PUSH OFFSET @635
00008: 0103 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0109 50                          PUSH EAX
00008: 010A E8 00000000                 CALL SHORT _sprintf
00008: 010F 83 C4 40                    ADD ESP, 00000040
00008: 0112 89 85 FFFFFDBC              MOV DWORD PTR FFFFFDBC[EBP], EAX

; 664:   if(nbyte<=0){ fclose(echo_path);return 0;}

00008: 0118 83 BD FFFFFDBC00            CMP DWORD PTR FFFFFDBC[EBP], 00000000
00008: 011F 7F 13                       JG L0001
00008: 0121 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0126 50                          PUSH EAX
00008: 0127 E8 00000000                 CALL SHORT _fclose
00008: 012C 59                          POP ECX
00008: 012D B8 00000000                 MOV EAX, 00000000
00000: 0132                             epilog 
00000: 0132 C9                          LEAVE 
00000: 0133 C3                          RETN 
00008: 0134                     L0001:

; 665:   if(fwrite(&s[0],1,nbyte,echo_path)!=nbyte){fclose(echo_path);return 0;}

00008: 0134 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 0139 50                          PUSH EAX
00008: 013A FF B5 FFFFFDBC              PUSH DWORD PTR FFFFFDBC[EBP]
00008: 0140 6A 01                       PUSH 00000001
00008: 0142 8D 85 FFFFFE00              LEA EAX, DWORD PTR FFFFFE00[EBP]
00008: 0148 50                          PUSH EAX
00008: 0149 E8 00000000                 CALL SHORT _fwrite
00008: 014E 83 C4 10                    ADD ESP, 00000010
00008: 0151 39 85 FFFFFDBC              CMP DWORD PTR FFFFFDBC[EBP], EAX
00008: 0157 74 13                       JE L0002
00008: 0159 A1 00000000                 MOV EAX, DWORD PTR _echo_path
00008: 015E 50                          PUSH EAX
00008: 015F E8 00000000                 CALL SHORT _fclose
00008: 0164 59                          POP ECX
00008: 0165 B8 00000000                 MOV EAX, 00000000
00000: 016A                             epilog 
00000: 016A C9                          LEAVE 
00000: 016B C3                          RETN 
00008: 016C                     L0002:

; 667:     return 1;

00008: 016C B8 00000001                 MOV EAX, 00000001
00000: 0171                     L0000:
00000: 0171                             epilog 
00000: 0171 C9                          LEAVE 
00000: 0172 C3                          RETN 

Function: _rms

; 672: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 08                    SUB ESP, 00000008
00000: 0006 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000B 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000E 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0012                             prolog 

; 673:   if(good)

00008: 0012 83 3D 00000000 00           CMP DWORD PTR .bss+00000008, 00000000
00008: 0019 74 5C                       JE L0001

; 675:       double new_time=get_time(); 

00008: 001B E8 00000000                 CALL SHORT _get_time
00007: 0020 DD 5D FFFFFFF8              FSTP QWORD PTR FFFFFFF8[EBP]

; 676:       if (new_time-last_time>delta1)

00008: 0023 DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 0026 DC 25 00000000              FSUB QWORD PTR .bss+00000000
00007: 002C DD 05 00000000              FLD QWORD PTR _delta1
00006: 0032 F1DF                        FCOMIP ST, ST(1), L0002
00007: 0034 DD D8                       FSTP ST
00008: 0036 7A 3F                       JP L0002
00008: 0038 73 3D                       JAE L0002

; 678: 	  last_time=new_time;

00008: 003A DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00007: 003D DD 1D 00000000              FSTP QWORD PTR .bss+00000000

; 679: 	  good=write_rms_echo();  

00008: 0043 E8 00000000                 CALL SHORT _write_rms_echo
00008: 0048 A3 00000000                 MOV DWORD PTR .bss+00000008, EAX

; 680: 	  i_mes++;

00008: 004D FF 05 00000000              INC DWORD PTR _i_mes

; 681: 	  if(i_mes==n_mes)

00008: 0053 8B 0D 00000000              MOV ECX, DWORD PTR _i_mes
00008: 0059 8B 15 00000000              MOV EDX, DWORD PTR _n_mes
00008: 005F 39 D1                       CMP ECX, EDX
00008: 0061 75 14                       JNE L0003

; 683: 	      good=save_rms();

00008: 0063 E8 00000000                 CALL SHORT _save_rms
00008: 0068 A3 00000000                 MOV DWORD PTR .bss+00000008, EAX

; 684: 	      i_mes=0;

00008: 006D C7 05 00000000 00000000     MOV DWORD PTR _i_mes, 00000000

; 685: 	    }      

00008: 0077                     L0003:

; 686: 	}

00008: 0077                     L0002:

; 687:     }

00008: 0077                     L0001:

; 688: }

00000: 0077                     L0000:
00000: 0077                             epilog 
00000: 0077 C9                          LEAVE 
00000: 0078 C3                          RETN 
