
Function: _add_movie_param

; 43: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 44:   param[0]+=dat0;

00008: 0003 DD 05 00000000              FLD QWORD PTR _param
00007: 0009 DC 45 08                    FADD QWORD PTR 00000008[EBP]
00007: 000C DD 1D 00000000              FSTP QWORD PTR _param

; 45:   param[1]+=dat1;

00008: 0012 DD 05 00000008              FLD QWORD PTR _param+00000008
00007: 0018 DC 45 10                    FADD QWORD PTR 00000010[EBP]
00007: 001B DD 1D 00000008              FSTP QWORD PTR _param+00000008

; 46:   param[2]+=dat2;

00008: 0021 DD 05 00000010              FLD QWORD PTR _param+00000010
00007: 0027 DC 45 18                    FADD QWORD PTR 00000018[EBP]
00007: 002A DD 1D 00000010              FSTP QWORD PTR _param+00000010

; 47:   param[3]+=dat3;

00008: 0030 DD 05 00000018              FLD QWORD PTR _param+00000018
00007: 0036 DC 45 20                    FADD QWORD PTR 00000020[EBP]
00007: 0039 DD 1D 00000018              FSTP QWORD PTR _param+00000018

; 48:   n_mes++;

00008: 003F FF 05 00000000              INC DWORD PTR _n_mes

; 49:   return;

00000: 0045                     L0000:
00000: 0045                             epilog 
00000: 0045 C9                          LEAVE 
00000: 0046 C3                          RETN 

Function: _init_movie_param

; 53: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 54:   param[0]=0;

00008: 0003 C7 05 00000004 00000000     MOV DWORD PTR _param+00000004, 00000000
00008: 000D C7 05 00000000 00000000     MOV DWORD PTR _param, 00000000

; 55:   param[1]=0;

00008: 0017 C7 05 0000000C 00000000     MOV DWORD PTR _param+0000000C, 00000000
00008: 0021 C7 05 00000008 00000000     MOV DWORD PTR _param+00000008, 00000000

; 56:   param[2]=0;

00008: 002B C7 05 00000014 00000000     MOV DWORD PTR _param+00000014, 00000000
00008: 0035 C7 05 00000010 00000000     MOV DWORD PTR _param+00000010, 00000000

; 57:   param[3]=0;

00008: 003F C7 05 0000001C 00000000     MOV DWORD PTR _param+0000001C, 00000000
00008: 0049 C7 05 00000018 00000000     MOV DWORD PTR _param+00000018, 00000000

; 58:   n_mes=0;

00008: 0053 C7 05 00000000 00000000     MOV DWORD PTR _n_mes, 00000000

; 59:   return;

00000: 005D                     L0000:
00000: 005D                             epilog 
00000: 005D C9                          LEAVE 
00000: 005E C3                          RETN 

Function: _write_java

; 63: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 66:   if(s+nbyte>movie_buffer+buffer_length){fErr=1;return s;}

00008: 0013 8B 0D 00000000              MOV ECX, DWORD PTR .bss+0000000c
00008: 0019 03 0D 00000000              ADD ECX, DWORD PTR _buffer_length
00008: 001F 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0022 03 55 10                    ADD EDX, DWORD PTR 00000010[EBP]
00008: 0025 39 CA                       CMP EDX, ECX
00008: 0027 76 13                       JBE L0001
00008: 0029 C7 05 00000000 00000001     MOV DWORD PTR _fErr, 00000001
00008: 0033 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00000: 0036                             epilog 
00000: 0036 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0039 5B                          POP EBX
00000: 003A 5D                          POP EBP
00000: 003B C3                          RETN 
00008: 003C                     L0001:

; 67:   if(bo||order)

00008: 003C 83 3D 00000000 00           CMP DWORD PTR .bss+00000000, 00000000
00008: 0043 75 06                       JNE L0002
00008: 0045 83 7D 14 00                 CMP DWORD PTR 00000014[EBP], 00000000
00008: 0049 74 2E                       JE L0003
00008: 004B                     L0002:

; 69:       s1=(char *)input;

00008: 004B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 004E 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 70:       for(i=0;i<nbyte;i++)

00008: 0051 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0058 EB 15                       JMP L0004
00008: 005A                     L0005:

; 71: 	s[i]=s1[i];

00008: 005A 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 005D 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0060 8A 1C 08                    MOV BL, BYTE PTR 00000000[EAX][ECX]
00008: 0063 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 0066 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0069 88 1C 08                    MOV BYTE PTR 00000000[EAX][ECX], BL
00008: 006C FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]
00008: 006F                     L0004:
00008: 006F 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0072 3B 45 10                    CMP EAX, DWORD PTR 00000010[EBP]
00008: 0075 7C FFFFFFE3                 JL L0005

; 72:     }

00008: 0077 EB 32                       JMP L0006
00008: 0079                     L0003:

; 75:       s1=((char *)input) + nbyte-1;

00008: 0079 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 007C 03 55 10                    ADD EDX, DWORD PTR 00000010[EBP]
00008: 007F 4A                          DEC EDX
00008: 0080 89 55 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EDX

; 76:       for(i=0;i<nbyte;i++)

00008: 0083 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000
00008: 008A EB 17                       JMP L0007
00008: 008C                     L0008:

; 77: 	s[i]=s1[-i];

00008: 008C 8B 5D FFFFFFF4              MOV EBX, DWORD PTR FFFFFFF4[EBP]
00008: 008F F7 DB                       NEG EBX
00008: 0091 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0094 8A 1C 18                    MOV BL, BYTE PTR 00000000[EAX][EBX]
00008: 0097 8B 4D FFFFFFF4              MOV ECX, DWORD PTR FFFFFFF4[EBP]
00008: 009A 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 009D 88 1C 08                    MOV BYTE PTR 00000000[EAX][ECX], BL
00008: 00A0 FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]
00008: 00A3                     L0007:
00008: 00A3 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00A6 3B 45 10                    CMP EAX, DWORD PTR 00000010[EBP]
00008: 00A9 7C FFFFFFE1                 JL L0008

; 78:     }

00008: 00AB                     L0006:

; 79:   return s+nbyte;

00008: 00AB 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 00AE 03 45 10                    ADD EAX, DWORD PTR 00000010[EBP]
00000: 00B1                     L0000:
00000: 00B1                             epilog 
00000: 00B1 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00B4 5B                          POP EBX
00000: 00B5 5D                          POP EBP
00000: 00B6 C3                          RETN 

Function: _write_movie_header

; 85: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 28                    SUB ESP, 00000028
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 B9 0000000A                 MOV ECX, 0000000A
00000: 0017 F3 AB                       REP STOSD 
00000: 0019 5F                          POP EDI
00000: 001A                             prolog 

; 92:   bo=byte_order();

00008: 001A E8 00000000                 CALL SHORT _byte_order
00008: 001F A3 00000000                 MOV DWORD PTR .bss+00000000, EAX

; 93:   a= (moved_iatom *)get_atom();

00008: 0024 E8 00000000                 CALL SHORT _get_atom
00008: 0029 A3 00000000                 MOV DWORD PTR .bss+00000004, EAX

; 94:   n1= get_atom_number();

00008: 002E E8 00000000                 CALL SHORT _get_atom_number
00008: 0033 A3 00000000                 MOV DWORD PTR _n1, EAX

; 95:   sam=(moved_iatom *)get_sample_atoms();

00008: 0038 E8 00000000                 CALL SHORT _get_sample_atoms
00008: 003D A3 00000000                 MOV DWORD PTR .bss+00000008, EAX

; 96:   nat=get_atom_types();

00008: 0042 E8 00000000                 CALL SHORT _get_atom_types
00008: 0047 66 A3 00000000              MOV WORD PTR _nat, AX

; 97:   path=movie_path;

00008: 004D 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0050 89 15 00000000              MOV DWORD PTR _path, EDX

; 98:   dim=get_dimension();

00008: 0056 E8 00000000                 CALL SHORT _get_dimension
00008: 005B A3 00000000                 MOV DWORD PTR _dim, EAX

; 99:   bound=get_bounds();

00008: 0060 E8 00000000                 CALL SHORT _get_bounds
00008: 0065 A3 00000000                 MOV DWORD PTR _bound, EAX

; 100:   max_bonds=getMaxBonds();

00008: 006A E8 00000000                 CALL SHORT _getMaxBonds
00008: 006F A3 00000000                 MOV DWORD PTR _max_bonds, EAX

; 101:   init_movie_param();

00008: 0074 E8 00000000                 CALL SHORT _init_movie_param

; 102:   n0=1;

00008: 0079 C7 05 00000000 00000001     MOV DWORD PTR _n0, 00000001

; 103:   n=n1;

00008: 0083 66 8B 15 00000000           MOV DX, WORD PTR _n1
00008: 008A 66 89 15 00000000           MOV WORD PTR _n, DX

; 104:   if(is_rms())

00008: 0091 E8 00000000                 CALL SHORT _is_rms
00008: 0096 83 F8 00                    CMP EAX, 00000000
00008: 0099 74 16                       JE L0001

; 106:       n=n_rms();

00008: 009B E8 00000000                 CALL SHORT _n_rms
00008: 00A0 66 A3 00000000              MOV WORD PTR _n, AX

; 107:       n0=n0_rms()+1;

00008: 00A6 E8 00000000                 CALL SHORT _n0_rms
00008: 00AB 40                          INC EAX
00008: 00AC A3 00000000                 MOV DWORD PTR _n0, EAX

; 108:     }

00008: 00B1                     L0001:

; 109:   do{

00008: 00B1                     L0002:

; 110:     printf("number of atoms in the movie %d\n",n);

00008: 00B1 0F BF 05 00000000           MOVSX EAX, WORD PTR _n
00008: 00B8 50                          PUSH EAX
00008: 00B9 68 00000000                 PUSH OFFSET @112
00008: 00BE E8 00000000                 CALL SHORT _printf
00008: 00C3 59                          POP ECX
00008: 00C4 59                          POP ECX

; 111:     printf("start to write from %d\n",n0);

00008: 00C5 A1 00000000                 MOV EAX, DWORD PTR _n0
00008: 00CA 50                          PUSH EAX
00008: 00CB 68 00000000                 PUSH OFFSET @113
00008: 00D0 E8 00000000                 CALL SHORT _printf
00008: 00D5 59                          POP ECX
00008: 00D6 59                          POP ECX

; 112:     printf("number of parameters%d\n",param_number);

00008: 00D7 0F BF 05 00000000           MOVSX EAX, WORD PTR _param_number
00008: 00DE 50                          PUSH EAX
00008: 00DF 68 00000000                 PUSH OFFSET @114
00008: 00E4 E8 00000000                 CALL SHORT _printf
00008: 00E9 59                          POP ECX
00008: 00EA 59                          POP ECX

; 113:     if(!yes())

00008: 00EB E8 00000000                 CALL SHORT _yes
00008: 00F0 83 F8 00                    CMP EAX, 00000000
00008: 00F3 75 54                       JNE L0003

; 115: 	printf("start to write from ?\n");

00008: 00F5 68 00000000                 PUSH OFFSET @115
00008: 00FA E8 00000000                 CALL SHORT _printf
00008: 00FF 59                          POP ECX

; 116: 	scanf("%d",&n0);

00008: 0100 68 00000000                 PUSH OFFSET _n0
00008: 0105 68 00000000                 PUSH OFFSET @116
00008: 010A E8 00000000                 CALL SHORT _scanf
00008: 010F 59                          POP ECX
00008: 0110 59                          POP ECX

; 117: 	printf("what is number of atoms?\n");

00008: 0111 68 00000000                 PUSH OFFSET @117
00008: 0116 E8 00000000                 CALL SHORT _printf
00008: 011B 59                          POP ECX

; 118: 	scanf("%hd",&n);

00008: 011C 68 00000000                 PUSH OFFSET _n
00008: 0121 68 00000000                 PUSH OFFSET @118
00008: 0126 E8 00000000                 CALL SHORT _scanf
00008: 012B 59                          POP ECX
00008: 012C 59                          POP ECX

; 119: 	printf("what is number of parameters?\n");

00008: 012D 68 00000000                 PUSH OFFSET @119
00008: 0132 E8 00000000                 CALL SHORT _printf
00008: 0137 59                          POP ECX

; 120: 	scanf("%hd",&param_number);

00008: 0138 68 00000000                 PUSH OFFSET _param_number
00008: 013D 68 00000000                 PUSH OFFSET @118
00008: 0142 E8 00000000                 CALL SHORT _scanf
00008: 0147 59                          POP ECX
00008: 0148 59                          POP ECX

; 121:       }

00008: 0149                     L0003:

; 122:     if(n0<1)n0=1;

00008: 0149 83 3D 00000000 01           CMP DWORD PTR _n0, 00000001
00008: 0150 7D 0A                       JGE L0004
00008: 0152 C7 05 00000000 00000001     MOV DWORD PTR _n0, 00000001
00008: 015C                     L0004:

; 123:     if(n0>n1)n0=n1;

00008: 015C 8B 0D 00000000              MOV ECX, DWORD PTR _n0
00008: 0162 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 0168 39 D1                       CMP ECX, EDX
00008: 016A 7E 0C                       JLE L0005
00008: 016C 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 0172 89 15 00000000              MOV DWORD PTR _n0, EDX
00008: 0178                     L0005:

; 124:     if(n<1)n=1;

00008: 0178 66 83 3D 00000000 01        CMP WORD PTR _n, 0001
00008: 0180 7D 09                       JGE L0006
00008: 0182 66 C7 05 00000000 0001      MOV WORD PTR _n, 0001
00008: 018B                     L0006:

; 125:     if(n>n1-n0+1)n=n1-n0+1;

00008: 018B 8B 15 00000000              MOV EDX, DWORD PTR _n1
00008: 0191 2B 15 00000000              SUB EDX, DWORD PTR _n0
00008: 0197 42                          INC EDX
00008: 0198 0F BF 0D 00000000           MOVSX ECX, WORD PTR _n
00008: 019F 39 D1                       CMP ECX, EDX
00008: 01A1 7E 16                       JLE L0007
00008: 01A3 66 8B 15 00000000           MOV DX, WORD PTR _n1
00008: 01AA 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 01B1 42                          INC EDX
00008: 01B2 66 89 15 00000000           MOV WORD PTR _n, DX
00008: 01B9                     L0007:

; 126:     printf("start to write from %d\n",n0);

00008: 01B9 A1 00000000                 MOV EAX, DWORD PTR _n0
00008: 01BE 50                          PUSH EAX
00008: 01BF 68 00000000                 PUSH OFFSET @113
00008: 01C4 E8 00000000                 CALL SHORT _printf
00008: 01C9 59                          POP ECX
00008: 01CA 59                          POP ECX

; 127:     printf("number of atoms=%hd\n",n);

00008: 01CB 0F BF 05 00000000           MOVSX EAX, WORD PTR _n
00008: 01D2 50                          PUSH EAX
00008: 01D3 68 00000000                 PUSH OFFSET @120
00008: 01D8 E8 00000000                 CALL SHORT _printf
00008: 01DD 59                          POP ECX
00008: 01DE 59                          POP ECX

; 128:   }while(!yes());

00008: 01DF E8 00000000                 CALL SHORT _yes
00008: 01E4 83 F8 00                    CMP EAX, 00000000
00008: 01E7 0F 84 FFFFFEC4              JE L0002

; 129:   n0--;

00008: 01ED FF 0D 00000000              DEC DWORD PTR _n0

; 130:   a+=n0;  

00008: 01F3 8B 15 00000000              MOV EDX, DWORD PTR _n0
00008: 01F9 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 01FF 01 15 00000000              ADD DWORD PTR .bss+00000004, EDX

; 131:   n1=n0+n;

00008: 0205 0F BF 15 00000000           MOVSX EDX, WORD PTR _n
00008: 020C 03 15 00000000              ADD EDX, DWORD PTR _n0
00008: 0212 89 15 00000000              MOV DWORD PTR _n1, EDX

; 132:   printf("change write parameters for text files?\n");

00008: 0218 68 00000000                 PUSH OFFSET @121
00008: 021D E8 00000000                 CALL SHORT _printf
00008: 0222 59                          POP ECX

; 133:   if(yes())set_write_param(n0,n,1); /* setting parameters for text writing */

00008: 0223 E8 00000000                 CALL SHORT _yes
00008: 0228 83 F8 00                    CMP EAX, 00000000
00008: 022B 74 18                       JE L0008
00008: 022D 6A 01                       PUSH 00000001
00008: 022F 0F BF 05 00000000           MOVSX EAX, WORD PTR _n
00008: 0236 50                          PUSH EAX
00008: 0237 A1 00000000                 MOV EAX, DWORD PTR _n0
00008: 023C 50                          PUSH EAX
00008: 023D E8 00000000                 CALL SHORT _set_write_param
00008: 0242 83 C4 0C                    ADD ESP, 0000000C
00008: 0245                     L0008:

; 134:   if(!strcmp(password,"BCPkina"))

00008: 0245 68 00000000                 PUSH OFFSET @1
00008: 024A A1 00000000                 MOV EAX, DWORD PTR _password
00008: 024F 50                          PUSH EAX
00008: 0250 E8 00000000                 CALL SHORT _strcmp
00008: 0255 59                          POP ECX
00008: 0256 59                          POP ECX
00008: 0257 83 F8 00                    CMP EAX, 00000000
00008: 025A 75 14                       JNE L0009

; 136:       version=1;

00008: 025C 66 C7 05 00000000 0001      MOV WORD PTR .bss+00000010, 0001

; 137:       printf("version 1\n");

00008: 0265 68 00000000                 PUSH OFFSET @122
00008: 026A E8 00000000                 CALL SHORT _printf
00008: 026F 59                          POP ECX

; 138:     }

00008: 0270                     L0009:

; 139:   buffer_length=(n*(dim+1)+nat+100)*sizeof(short)+

00008: 0270 8B 1D 00000000              MOV EBX, DWORD PTR _dim
00008: 0276 43                          INC EBX
00008: 0277 0F BF 15 00000000           MOVSX EDX, WORD PTR _n
00008: 027E 0F AF DA                    IMUL EBX, EDX
00008: 0281 0F BF 15 00000000           MOVSX EDX, WORD PTR _nat
00008: 0288 01 D3                       ADD EBX, EDX
00008: 028A 83 C3 64                    ADD EBX, 00000064
00008: 028D 8D 1C 5D 00000000           LEA EBX, [00000000][EBX*2]
00008: 0294 8B 15 00000000              MOV EDX, DWORD PTR _max_bonds
00008: 029A 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 02A1 01 D3                       ADD EBX, EDX
00008: 02A3 0F BF 15 00000000           MOVSX EDX, WORD PTR _nat
00008: 02AA 83 C2 68                    ADD EDX, 00000068
00008: 02AD 8D 14 D5 00000000           LEA EDX, [00000000][EDX*8]
00008: 02B4 01 D3                       ADD EBX, EDX
00008: 02B6 81 C3 00000400              ADD EBX, 00000400
00008: 02BC 89 1D 00000000              MOV DWORD PTR _buffer_length, EBX

; 144:   if(!movie_buffer)movie_buffer=(char *)malloc(buffer_length*sizeof(char));

00008: 02C2 83 3D 00000000 00           CMP DWORD PTR .bss+0000000c, 00000000
00008: 02C9 75 11                       JNE L000A
00008: 02CB A1 00000000                 MOV EAX, DWORD PTR _buffer_length
00008: 02D0 50                          PUSH EAX
00008: 02D1 E8 00000000                 CALL SHORT _malloc
00008: 02D6 59                          POP ECX
00008: 02D7 A3 00000000                 MOV DWORD PTR .bss+0000000c, EAX
00008: 02DC                     L000A:

; 145:   if(!movie_buffer)

00008: 02DC 83 3D 00000000 00           CMP DWORD PTR .bss+0000000c, 00000000
00008: 02E3 75 20                       JNE L000B

; 147:       StopAlert(MEMORY_ALRT);

00008: 02E5 6A 02                       PUSH 00000002
00008: 02E7 E8 00000000                 CALL SHORT _StopAlert
00008: 02EC 59                          POP ECX

; 148:       fclose(path);

00008: 02ED A1 00000000                 MOV EAX, DWORD PTR _path
00008: 02F2 50                          PUSH EAX
00008: 02F3 E8 00000000                 CALL SHORT _fclose
00008: 02F8 59                          POP ECX

; 149:       return 0;

00008: 02F9 B8 00000000                 MOV EAX, 00000000
00000: 02FE                             epilog 
00000: 02FE 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0301 5E                          POP ESI
00000: 0302 5B                          POP EBX
00000: 0303 5D                          POP EBP
00000: 0304 C3                          RETN 
00008: 0305                     L000B:

; 151:   fErr=0;

00008: 0305 C7 05 00000000 00000000     MOV DWORD PTR _fErr, 00000000

; 152:   s=movie_buffer;

00008: 030F A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 0314 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 155:   nbyte=strlen(password);

00008: 0317 A1 00000000                 MOV EAX, DWORD PTR _password
00008: 031C 50                          PUSH EAX
00008: 031D E8 00000000                 CALL SHORT _strlen
00008: 0322 59                          POP ECX
00008: 0323 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 156:   s=write_java(s,password,nbyte,1);

00008: 0326 6A 01                       PUSH 00000001
00008: 0328 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 032B A1 00000000                 MOV EAX, DWORD PTR _password
00008: 0330 50                          PUSH EAX
00008: 0331 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0334 E8 00000000                 CALL SHORT _write_java
00008: 0339 83 C4 10                    ADD ESP, 00000010
00008: 033C 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 159:   s_dummy=0;

00008: 033F 66 C7 45 FFFFFFE6 0000      MOV WORD PTR FFFFFFE6[EBP], 0000

; 160:   s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0345 6A 00                       PUSH 00000000
00008: 0347 6A 02                       PUSH 00000002
00008: 0349 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 034C 50                          PUSH EAX
00008: 034D FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0350 E8 00000000                 CALL SHORT _write_java
00008: 0355 83 C4 10                    ADD ESP, 00000010
00008: 0358 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 163:   for(i=0;i<3;i++)

00008: 035B C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 0362 EB 44                       JMP L000C
00008: 0364                     L000D:

; 165:       dummy=bound[i].length;

00008: 0364 8B 5D FFFFFFDC              MOV EBX, DWORD PTR FFFFFFDC[EBP]
00008: 0367 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 036A 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0370 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 0373 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 166:       if(i>=dim)dummy=0;

00008: 0376 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0379 3B 05 00000000              CMP EAX, DWORD PTR _dim
00008: 037F 7C 0E                       JL L000E
00008: 0381 C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0388 C7 45 FFFFFFE8 00000000     MOV DWORD PTR FFFFFFE8[EBP], 00000000
00008: 038F                     L000E:

; 167:       s=write_java(s,&dummy,sizeof(dummy),0);

00008: 038F 6A 00                       PUSH 00000000
00008: 0391 6A 08                       PUSH 00000008
00008: 0393 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0396 50                          PUSH EAX
00008: 0397 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 039A E8 00000000                 CALL SHORT _write_java
00008: 039F 83 C4 10                    ADD ESP, 00000010
00008: 03A2 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 168:     }

00008: 03A5 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 03A8                     L000C:
00008: 03A8 83 7D FFFFFFDC 03           CMP DWORD PTR FFFFFFDC[EBP], 00000003
00008: 03AC 7C FFFFFFB6                 JL L000D

; 171:   dummy=get_movie_dt();

00008: 03AE E8 00000000                 CALL SHORT _get_movie_dt
00007: 03B3 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 172:   s=write_java(s,&dummy,sizeof(dummy),0);

00008: 03B6 6A 00                       PUSH 00000000
00008: 03B8 6A 08                       PUSH 00000008
00008: 03BA 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 03BD 50                          PUSH EAX
00008: 03BE FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 03C1 E8 00000000                 CALL SHORT _write_java
00008: 03C6 83 C4 10                    ADD ESP, 00000010
00008: 03C9 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 175:   s=write_java(s,&nat,sizeof(nat),0);

00008: 03CC 6A 00                       PUSH 00000000
00008: 03CE 6A 02                       PUSH 00000002
00008: 03D0 68 00000000                 PUSH OFFSET _nat
00008: 03D5 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 03D8 E8 00000000                 CALL SHORT _write_java
00008: 03DD 83 C4 10                    ADD ESP, 00000010
00008: 03E0 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 178:   for (i=1;i<=nat;i++)

00008: 03E3 C7 45 FFFFFFDC 00000001     MOV DWORD PTR FFFFFFDC[EBP], 00000001
00008: 03EA EB 3A                       JMP L000F
00008: 03EC                     L0010:

; 180:       s_dummy=sam[i].c;

00008: 03EC 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 03EF 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 03F6 29 D3                       SUB EBX, EDX
00008: 03F8 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 03FB 8B 35 00000000              MOV ESI, DWORD PTR .bss+00000008
00008: 0401 66 8B 94 DE 000000A4        MOV DX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0409 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 181:       s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 040D 6A 00                       PUSH 00000000
00008: 040F 6A 02                       PUSH 00000002
00008: 0411 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 0414 50                          PUSH EAX
00008: 0415 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0418 E8 00000000                 CALL SHORT _write_java
00008: 041D 83 C4 10                    ADD ESP, 00000010
00008: 0420 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 182:     }

00008: 0423 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0426                     L000F:
00008: 0426 0F BF 15 00000000           MOVSX EDX, WORD PTR _nat
00008: 042D 39 55 FFFFFFDC              CMP DWORD PTR FFFFFFDC[EBP], EDX
00008: 0430 7E FFFFFFBA                 JLE L0010

; 185:   for (i=1;i<=nat;i++)

00008: 0432 C7 45 FFFFFFDC 00000001     MOV DWORD PTR FFFFFFDC[EBP], 00000001
00008: 0439 EB 38                       JMP L0011
00008: 043B                     L0012:

; 187:       dummy=sam[i].s;

00008: 043B 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 043E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0445 29 D3                       SUB EBX, EDX
00008: 0447 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 044A 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000008
00008: 0450 DD 84 DA 00000098           FLD QWORD PTR 00000098[EDX][EBX*8]
00007: 0457 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 188:       s=write_java(s,&dummy,sizeof(dummy),0);

00008: 045A 6A 00                       PUSH 00000000
00008: 045C 6A 08                       PUSH 00000008
00008: 045E 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0461 50                          PUSH EAX
00008: 0462 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0465 E8 00000000                 CALL SHORT _write_java
00008: 046A 83 C4 10                    ADD ESP, 00000010
00008: 046D 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 189:     }

00008: 0470 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0473                     L0011:
00008: 0473 0F BF 15 00000000           MOVSX EDX, WORD PTR _nat
00008: 047A 39 55 FFFFFFDC              CMP DWORD PTR FFFFFFDC[EBP], EDX
00008: 047D 7E FFFFFFBC                 JLE L0012

; 192:    s=write_java(s,&n,sizeof(n),0);

00008: 047F 6A 00                       PUSH 00000000
00008: 0481 6A 02                       PUSH 00000002
00008: 0483 68 00000000                 PUSH OFFSET _n
00008: 0488 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 048B E8 00000000                 CALL SHORT _write_java
00008: 0490 83 C4 10                    ADD ESP, 00000010
00008: 0493 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 195:   for (i=0;i<n;i++)

00008: 0496 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 049D EB 3A                       JMP L0013
00008: 049F                     L0014:

; 197:       s_dummy=a[i].c;

00008: 049F 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 04A2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 04A9 29 D3                       SUB EBX, EDX
00008: 04AB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 04AE 8B 35 00000000              MOV ESI, DWORD PTR .bss+00000004
00008: 04B4 66 8B 94 DE 000000A4        MOV DX, WORD PTR 000000A4[ESI][EBX*8]
00008: 04BC 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 198:       s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 04C0 6A 00                       PUSH 00000000
00008: 04C2 6A 02                       PUSH 00000002
00008: 04C4 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 04C7 50                          PUSH EAX
00008: 04C8 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 04CB E8 00000000                 CALL SHORT _write_java
00008: 04D0 83 C4 10                    ADD ESP, 00000010
00008: 04D3 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 199:     }

00008: 04D6 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 04D9                     L0013:
00008: 04D9 0F BF 15 00000000           MOVSX EDX, WORD PTR _n
00008: 04E0 39 55 FFFFFFDC              CMP DWORD PTR FFFFFFDC[EBP], EDX
00008: 04E3 7C FFFFFFBA                 JL L0014

; 202:   for (i=n0;i<n1;i++)

00008: 04E5 A1 00000000                 MOV EAX, DWORD PTR _n0
00008: 04EA 89 45 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EAX
00008: 04ED E9 000000A6                 JMP L0015
00008: 04F2                     L0016:

; 204:       int index=-1;

00008: 04F2 C7 45 FFFFFFF4 FFFFFFFF     MOV DWORD PTR FFFFFFF4[EBP], FFFFFFFF

; 205:       s_dummy=i-n0;

00008: 04F9 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 04FC 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 0503 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 206:       s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0507 6A 00                       PUSH 00000000
00008: 0509 6A 02                       PUSH 00000002
00008: 050B 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 050E 50                          PUSH EAX
00008: 050F FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0512 E8 00000000                 CALL SHORT _write_java
00008: 0517 83 C4 10                    ADD ESP, 00000010
00008: 051A 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 207:       do

00008: 051D                     L0017:

; 209: 	  j=nextFriend(i,&index);

00008: 051D 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0520 50                          PUSH EAX
00008: 0521 FF 75 FFFFFFDC              PUSH DWORD PTR FFFFFFDC[EBP]
00008: 0524 E8 00000000                 CALL SHORT _nextFriend
00008: 0529 59                          POP ECX
00008: 052A 59                          POP ECX
00008: 052B 89 45 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EAX

; 210: 	  if(index==-1)break;

00008: 052E 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 0532 74 3D                       JE L0018

; 211: 	  if((j>i)&&(j<n1))

00008: 0534 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0537 3B 45 FFFFFFDC              CMP EAX, DWORD PTR FFFFFFDC[EBP]
00008: 053A 7E 2F                       JLE L0019
00008: 053C 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 053F 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 0545 7D 24                       JGE L0019

; 213: 	      s_dummy=j-n0;

00008: 0547 8B 55 FFFFFFE0              MOV EDX, DWORD PTR FFFFFFE0[EBP]
00008: 054A 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 0551 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 214: 	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0555 6A 00                       PUSH 00000000
00008: 0557 6A 02                       PUSH 00000002
00008: 0559 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 055C 50                          PUSH EAX
00008: 055D FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0560 E8 00000000                 CALL SHORT _write_java
00008: 0565 83 C4 10                    ADD ESP, 00000010
00008: 0568 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 215: 	    }

00008: 056B                     L0019:

; 216: 	}while(index>-1);

00008: 056B 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 056F 7F FFFFFFAC                 JG L0017
00008: 0571                     L0018:

; 217:       s_dummy=i-n0;

00008: 0571 8B 55 FFFFFFDC              MOV EDX, DWORD PTR FFFFFFDC[EBP]
00008: 0574 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 057B 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 218:       s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 057F 6A 00                       PUSH 00000000
00008: 0581 6A 02                       PUSH 00000002
00008: 0583 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 0586 50                          PUSH EAX
00008: 0587 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 058A E8 00000000                 CALL SHORT _write_java
00008: 058F 83 C4 10                    ADD ESP, 00000010
00008: 0592 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 219:     }

00008: 0595 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0598                     L0015:
00008: 0598 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 059B 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 05A1 0F 8C FFFFFF4B              JL L0016

; 222:   s_dummy=param_number;/* fix it 5*/

00008: 05A7 66 8B 15 00000000           MOV DX, WORD PTR _param_number
00008: 05AE 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 223:   s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 05B2 6A 00                       PUSH 00000000
00008: 05B4 6A 02                       PUSH 00000002
00008: 05B6 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 05B9 50                          PUSH EAX
00008: 05BA FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 05BD E8 00000000                 CALL SHORT _write_java
00008: 05C2 83 C4 10                    ADD ESP, 00000010
00008: 05C5 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 224:   for(i=0;i<param_number;i++)

00008: 05C8 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 05CF EB 53                       JMP L001A
00008: 05D1                     L001B:

; 226:       nbyte=strlen(param_names[i]);

00008: 05D1 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 05D4 8B 04 85 00000000           MOV EAX, DWORD PTR _param_names[EAX*4]
00008: 05DB 50                          PUSH EAX
00008: 05DC E8 00000000                 CALL SHORT _strlen
00008: 05E1 59                          POP ECX
00008: 05E2 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 227:       s_dummy=nbyte;

00008: 05E5 66 8B 45 FFFFFFD4           MOV AX, WORD PTR FFFFFFD4[EBP]
00008: 05E9 66 89 45 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], AX

; 228:       s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 05ED 6A 00                       PUSH 00000000
00008: 05EF 6A 02                       PUSH 00000002
00008: 05F1 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 05F4 50                          PUSH EAX
00008: 05F5 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 05F8 E8 00000000                 CALL SHORT _write_java
00008: 05FD 83 C4 10                    ADD ESP, 00000010
00008: 0600 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 229:       s=write_java(s,param_names[i],nbyte,1);

00008: 0603 6A 01                       PUSH 00000001
00008: 0605 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0608 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 060B 8B 04 85 00000000           MOV EAX, DWORD PTR _param_names[EAX*4]
00008: 0612 50                          PUSH EAX
00008: 0613 FF 75 FFFFFFD8              PUSH DWORD PTR FFFFFFD8[EBP]
00008: 0616 E8 00000000                 CALL SHORT _write_java
00008: 061B 83 C4 10                    ADD ESP, 00000010
00008: 061E 89 45 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EAX

; 230:     }

00008: 0621 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 0624                     L001A:
00008: 0624 0F BF 15 00000000           MOVSX EDX, WORD PTR _param_number
00008: 062B 39 55 FFFFFFDC              CMP DWORD PTR FFFFFFDC[EBP], EDX
00008: 062E 7C FFFFFFA1                 JL L001B

; 232:  for(i=0;i<3;i++)

00008: 0630 C7 45 FFFFFFDC 00000000     MOV DWORD PTR FFFFFFDC[EBP], 00000000
00008: 0637 EB 22                       JMP L001C
00008: 0639                     L001D:

; 234:      scale_factor[i]=((double)65536)/bound[i].length; 

00008: 0639 8B 5D FFFFFFDC              MOV EBX, DWORD PTR FFFFFFDC[EBP]
00008: 063C 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 063F 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0645 DD 05 00000000              FLD QWORD PTR .data+00000160
00007: 064B DC 34 DA                    FDIV QWORD PTR 00000000[EDX][EBX*8]
00007: 064E 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00007: 0651 DD 1C C5 00000000           FSTP QWORD PTR _scale_factor[EAX*8]

; 235:    } 

00008: 0658 FF 45 FFFFFFDC              INC DWORD PTR FFFFFFDC[EBP]
00008: 065B                     L001C:
00008: 065B 83 7D FFFFFFDC 03           CMP DWORD PTR FFFFFFDC[EBP], 00000003
00008: 065F 7C FFFFFFD8                 JL L001D

; 236:   nbyte=s-movie_buffer;

00008: 0661 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00008: 0664 2B 15 00000000              SUB EDX, DWORD PTR .bss+0000000c
00008: 066A 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 237:   fErr=((nbyte!=fwrite(movie_buffer,1,nbyte,path))||fErr);

00008: 066D BB 00000001                 MOV EBX, 00000001
00008: 0672 A1 00000000                 MOV EAX, DWORD PTR _path
00008: 0677 50                          PUSH EAX
00008: 0678 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 067B 6A 01                       PUSH 00000001
00008: 067D A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 0682 50                          PUSH EAX
00008: 0683 E8 00000000                 CALL SHORT _fwrite
00008: 0688 83 C4 10                    ADD ESP, 00000010
00008: 068B 39 45 FFFFFFD4              CMP DWORD PTR FFFFFFD4[EBP], EAX
00008: 068E 75 0E                       JNE L001E
00008: 0690 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 0697 75 05                       JNE L001E
00008: 0699 BB 00000000                 MOV EBX, 00000000
00008: 069E                     L001E:
00008: 069E 89 1D 00000000              MOV DWORD PTR _fErr, EBX

; 238:   setNewTypes(0);

00008: 06A4 6A 00                       PUSH 00000000
00008: 06A6 E8 00000000                 CALL SHORT _setNewTypes
00008: 06AB 59                          POP ECX

; 239:   setNewBonds(0);

00008: 06AC 6A 00                       PUSH 00000000
00008: 06AE E8 00000000                 CALL SHORT _setNewBonds
00008: 06B3 59                          POP ECX

; 240:   if(fErr!=noErr){fclose(path);return 0;}

00008: 06B4 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 06BB 74 18                       JE L001F
00008: 06BD A1 00000000                 MOV EAX, DWORD PTR _path
00008: 06C2 50                          PUSH EAX
00008: 06C3 E8 00000000                 CALL SHORT _fclose
00008: 06C8 59                          POP ECX
00008: 06C9 B8 00000000                 MOV EAX, 00000000
00000: 06CE                             epilog 
00000: 06CE 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 06D1 5E                          POP ESI
00000: 06D2 5B                          POP EBX
00000: 06D3 5D                          POP EBP
00000: 06D4 C3                          RETN 
00008: 06D5                     L001F:

; 241:   frame=0;

00008: 06D5 C7 05 00000000 00000000     MOV DWORD PTR _frame, 00000000

; 242:   return 1;

00008: 06DF B8 00000001                 MOV EAX, 00000001
00000: 06E4                     L0000:
00000: 06E4                             epilog 
00000: 06E4 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 06E7 5E                          POP ESI
00000: 06E8 5B                          POP EBX
00000: 06E9 5D                          POP EBP
00000: 06EA C3                          RETN 

Function: _write_movie_frame

; 247: { 

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

; 249:   char * s=movie_buffer;

00008: 001A A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 001F 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 253:   moveatoms(); 

00008: 0022 E8 00000000                 CALL SHORT _moveatoms

; 254:   frame++;

00008: 0027 FF 05 00000000              INC DWORD PTR _frame

; 258:   s[0]=(char)getNewTypes();

00008: 002D E8 00000000                 CALL SHORT _getNewTypes
00008: 0032 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 0035 88 01                       MOV BYTE PTR 00000000[ECX], AL

; 262:   if(s[0])

00008: 0037 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 003A 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 003D 74 54                       JE L0001

; 264:       s++;

00008: 003F FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 265:       for (i=0;i<n;i++)

00008: 0042 C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 0049 EB 3A                       JMP L0002
00008: 004B                     L0003:

; 267: 	  s_dummy=a[i].c;

00008: 004B 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 004E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0055 29 D3                       SUB EBX, EDX
00008: 0057 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 005A 8B 35 00000000              MOV ESI, DWORD PTR .bss+00000004
00008: 0060 66 8B 94 DE 000000A4        MOV DX, WORD PTR 000000A4[ESI][EBX*8]
00008: 0068 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 268: 	  s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 006C 6A 00                       PUSH 00000000
00008: 006E 6A 02                       PUSH 00000002
00008: 0070 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 0073 50                          PUSH EAX
00008: 0074 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0077 E8 00000000                 CALL SHORT _write_java
00008: 007C 83 C4 10                    ADD ESP, 00000010
00008: 007F 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 269: 	}

00008: 0082 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 0085                     L0002:
00008: 0085 0F BF 15 00000000           MOVSX EDX, WORD PTR _n
00008: 008C 39 55 FFFFFFC4              CMP DWORD PTR FFFFFFC4[EBP], EDX
00008: 008F 7C FFFFFFBA                 JL L0003

; 270:     }

00008: 0091 EB 03                       JMP L0004
00008: 0093                     L0001:

; 272:     s++;

00008: 0093 FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]
00008: 0096                     L0004:

; 276:   s[0]=(char)getNewBonds();

00008: 0096 E8 00000000                 CALL SHORT _getNewBonds
00008: 009B 8B 4D FFFFFFCC              MOV ECX, DWORD PTR FFFFFFCC[EBP]
00008: 009E 88 01                       MOV BYTE PTR 00000000[ECX], AL

; 280:   if(s[0])

00008: 00A0 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00A3 80 38 00                    CMP BYTE PTR 00000000[EAX], 00
00008: 00A6 0F 84 000000C7              JE L0005

; 282:     s++;

00008: 00AC FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]

; 284:     for (i=n0;i<n1;i++)

00008: 00AF A1 00000000                 MOV EAX, DWORD PTR _n0
00008: 00B4 89 45 FFFFFFC4              MOV DWORD PTR FFFFFFC4[EBP], EAX
00008: 00B7 E9 000000A6                 JMP L0006
00008: 00BC                     L0007:

; 286: 	int index=-1;

00008: 00BC C7 45 FFFFFFF4 FFFFFFFF     MOV DWORD PTR FFFFFFF4[EBP], FFFFFFFF

; 287: 	s_dummy=i-n0;

00008: 00C3 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 00C6 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 00CD 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 288: 	s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 00D1 6A 00                       PUSH 00000000
00008: 00D3 6A 02                       PUSH 00000002
00008: 00D5 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 00D8 50                          PUSH EAX
00008: 00D9 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 00DC E8 00000000                 CALL SHORT _write_java
00008: 00E1 83 C4 10                    ADD ESP, 00000010
00008: 00E4 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 289: 	do

00008: 00E7                     L0008:

; 291: 	    j=nextFriend(i,&index);

00008: 00E7 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 00EA 50                          PUSH EAX
00008: 00EB FF 75 FFFFFFC4              PUSH DWORD PTR FFFFFFC4[EBP]
00008: 00EE E8 00000000                 CALL SHORT _nextFriend
00008: 00F3 59                          POP ECX
00008: 00F4 59                          POP ECX
00008: 00F5 89 45 FFFFFFC8              MOV DWORD PTR FFFFFFC8[EBP], EAX

; 292: 	    if(index==-1)break;

00008: 00F8 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 00FC 74 3D                       JE L0009

; 293: 	    if((j>i)&&(j<n1))

00008: 00FE 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0101 3B 45 FFFFFFC4              CMP EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0104 7E 2F                       JLE L000A
00008: 0106 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0109 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 010F 7D 24                       JGE L000A

; 295: 		s_dummy=j-n0;

00008: 0111 8B 55 FFFFFFC8              MOV EDX, DWORD PTR FFFFFFC8[EBP]
00008: 0114 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 011B 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 296: 		s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 011F 6A 00                       PUSH 00000000
00008: 0121 6A 02                       PUSH 00000002
00008: 0123 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 0126 50                          PUSH EAX
00008: 0127 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 012A E8 00000000                 CALL SHORT _write_java
00008: 012F 83 C4 10                    ADD ESP, 00000010
00008: 0132 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 297: 	      }

00008: 0135                     L000A:

; 298: 	  }while(index>-1);

00008: 0135 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 0139 7F FFFFFFAC                 JG L0008
00008: 013B                     L0009:

; 299: 	s_dummy=i-n0;

00008: 013B 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 013E 66 2B 15 00000000           SUB DX, WORD PTR _n0
00008: 0145 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 300: 	s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0149 6A 00                       PUSH 00000000
00008: 014B 6A 02                       PUSH 00000002
00008: 014D 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 0150 50                          PUSH EAX
00008: 0151 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0154 E8 00000000                 CALL SHORT _write_java
00008: 0159 83 C4 10                    ADD ESP, 00000010
00008: 015C 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 301:       }

00008: 015F FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 0162                     L0006:
00008: 0162 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00008: 0165 3B 05 00000000              CMP EAX, DWORD PTR _n1
00008: 016B 0F 8C FFFFFF4B              JL L0007

; 302:   }

00008: 0171 EB 03                       JMP L000B
00008: 0173                     L0005:

; 304:     s++;

00008: 0173 FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]
00008: 0176                     L000B:

; 307:     for(i=0;i<n;i++)

00008: 0176 C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 017D E9 000000D1                 JMP L000C
00008: 0182                     L000D:

; 308:       for(j=0;j<dim;j++)

00008: 0182 C7 45 FFFFFFC8 00000000     MOV DWORD PTR FFFFFFC8[EBP], 00000000
00008: 0189 E9 000000B3                 JMP L000E
00008: 018E                     L000F:

; 310: 	  if(version==1)

00008: 018E 66 83 3D 00000000 01        CMP WORD PTR .bss+00000010, 0001
00008: 0196 75 57                       JNE L0010

; 312: 	      s_dummy=(unsigned short)(a[i].r[j]*scale_factor[0]);

00008: 0198 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 019B 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01A2 29 D3                       SUB EBX, EDX
00008: 01A4 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01A7 03 5D FFFFFFC8              ADD EBX, DWORD PTR FFFFFFC8[EBP]
00008: 01AA 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000004
00008: 01B0 DD 05 00000000              FLD QWORD PTR _scale_factor
00007: 01B6 DC 4C DA 48                 FMUL QWORD PTR 00000048[EDX][EBX*8]
00007: 01BA D9 7D FFFFFFD4              FNSTCW WORD PTR FFFFFFD4[EBP]
00007: 01BD 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00007: 01C0 80 4D FFFFFFD5 0C           OR BYTE PTR FFFFFFD5[EBP], 0C
00007: 01C4 D9 6D FFFFFFD4              FLDCW WORD PTR FFFFFFD4[EBP]
00007: 01C7 DB 5D FFFFFFD8              FISTP DWORD PTR FFFFFFD8[EBP]
00008: 01CA 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX
00008: 01CD D9 6D FFFFFFD4              FLDCW WORD PTR FFFFFFD4[EBP]
00008: 01D0 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00008: 01D3 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 313: 	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 01D7 6A 00                       PUSH 00000000
00008: 01D9 6A 02                       PUSH 00000002
00008: 01DB 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 01DE 50                          PUSH EAX
00008: 01DF FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 01E2 E8 00000000                 CALL SHORT _write_java
00008: 01E7 83 C4 10                    ADD ESP, 00000010
00008: 01EA 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 314: 	    }

00008: 01ED EB 4F                       JMP L0011
00008: 01EF                     L0010:

; 317: 	      s_dummy=(unsigned short)a[i].r[j];

00008: 01EF 8B 55 FFFFFFC4              MOV EDX, DWORD PTR FFFFFFC4[EBP]
00008: 01F2 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 01F9 29 D3                       SUB EBX, EDX
00008: 01FB 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 01FE 03 5D FFFFFFC8              ADD EBX, DWORD PTR FFFFFFC8[EBP]
00008: 0201 8B 15 00000000              MOV EDX, DWORD PTR .bss+00000004
00008: 0207 DD 44 DA 48                 FLD QWORD PTR 00000048[EDX][EBX*8]
00007: 020B D9 7D FFFFFFD4              FNSTCW WORD PTR FFFFFFD4[EBP]
00007: 020E 8B 55 FFFFFFD4              MOV EDX, DWORD PTR FFFFFFD4[EBP]
00007: 0211 80 4D FFFFFFD5 0C           OR BYTE PTR FFFFFFD5[EBP], 0C
00007: 0215 D9 6D FFFFFFD4              FLDCW WORD PTR FFFFFFD4[EBP]
00007: 0218 DB 5D FFFFFFD8              FISTP DWORD PTR FFFFFFD8[EBP]
00008: 021B 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX
00008: 021E D9 6D FFFFFFD4              FLDCW WORD PTR FFFFFFD4[EBP]
00008: 0221 8B 55 FFFFFFD8              MOV EDX, DWORD PTR FFFFFFD8[EBP]
00008: 0224 66 89 55 FFFFFFE6           MOV WORD PTR FFFFFFE6[EBP], DX

; 318: 	      s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0228 6A 00                       PUSH 00000000
00008: 022A 6A 02                       PUSH 00000002
00008: 022C 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 022F 50                          PUSH EAX
00008: 0230 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 0233 E8 00000000                 CALL SHORT _write_java
00008: 0238 83 C4 10                    ADD ESP, 00000010
00008: 023B 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 319: 	    }

00008: 023E                     L0011:

; 320: 	}

00008: 023E FF 45 FFFFFFC8              INC DWORD PTR FFFFFFC8[EBP]
00008: 0241                     L000E:
00008: 0241 8B 45 FFFFFFC8              MOV EAX, DWORD PTR FFFFFFC8[EBP]
00008: 0244 3B 05 00000000              CMP EAX, DWORD PTR _dim
00008: 024A 0F 8C FFFFFF3E              JL L000F
00008: 0250 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 0253                     L000C:
00008: 0253 0F BF 15 00000000           MOVSX EDX, WORD PTR _n
00008: 025A 39 55 FFFFFFC4              CMP DWORD PTR FFFFFFC4[EBP], EDX
00008: 025D 0F 8C FFFFFF1F              JL L000D

; 322: for(i=0;i<param_number;i++){

00008: 0263 C7 45 FFFFFFC4 00000000     MOV DWORD PTR FFFFFFC4[EBP], 00000000
00008: 026A EB 49                       JMP L0012
00008: 026C                     L0013:
00008: 026C D9 EE                       FLDZ 

; 323: dummy=n_mes? param[i]/n_mes:0;

00007: 026E 83 3D 00000000 00           CMP DWORD PTR _n_mes, 00000000
00007: 0275 74 16                       JE L0014
00007: 0277 DB 05 00000000              FILD DWORD PTR _n_mes
00006: 027D 8B 45 FFFFFFC4              MOV EAX, DWORD PTR FFFFFFC4[EBP]
00006: 0280 DD 04 C5 00000000           FLD QWORD PTR _param[EAX*8]
00005: 0287 DE F1                       FDIVRP ST(1), ST
00006: 0289 DD D9                       FSTP ST(1)
00007: 028B EB 08                       JMP L0015
00007: 028D                     L0014:
00007: 028D DD 05 00000000              FLD QWORD PTR .data+00000168
00006: 0293 DD D9                       FSTP ST(1)
00007: 0295                     L0015:
00007: 0295 D9 C0                       FLD ST
00006: 0297 DD 5D FFFFFFE8              FSTP QWORD PTR FFFFFFE8[EBP]

; 325: s=write_java(s,&dummy,sizeof(dummy),0);

00007: 029A 6A 00                       PUSH 00000000
00007: 029C 6A 08                       PUSH 00000008
00007: 029E 8D 45 FFFFFFE8              LEA EAX, DWORD PTR FFFFFFE8[EBP]
00007: 02A1 50                          PUSH EAX
00007: 02A2 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00007: 02A5 DD D8                       FSTP ST
00008: 02A7 E8 00000000                 CALL SHORT _write_java
00008: 02AC 83 C4 10                    ADD ESP, 00000010
00008: 02AF 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 326: }

00008: 02B2 FF 45 FFFFFFC4              INC DWORD PTR FFFFFFC4[EBP]
00008: 02B5                     L0012:
00008: 02B5 0F BF 15 00000000           MOVSX EDX, WORD PTR _param_number
00008: 02BC 39 55 FFFFFFC4              CMP DWORD PTR FFFFFFC4[EBP], EDX
00008: 02BF 7C FFFFFFAB                 JL L0013

; 327: init_movie_param();

00008: 02C1 E8 00000000                 CALL SHORT _init_movie_param

; 329:   s_dummy=0;

00008: 02C6 66 C7 45 FFFFFFE6 0000      MOV WORD PTR FFFFFFE6[EBP], 0000

; 330:   s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 02CC 6A 00                       PUSH 00000000
00008: 02CE 6A 02                       PUSH 00000002
00008: 02D0 8D 45 FFFFFFE6              LEA EAX, DWORD PTR FFFFFFE6[EBP]
00008: 02D3 50                          PUSH EAX
00008: 02D4 FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 02D7 E8 00000000                 CALL SHORT _write_java
00008: 02DC 83 C4 10                    ADD ESP, 00000010
00008: 02DF 89 45 FFFFFFCC              MOV DWORD PTR FFFFFFCC[EBP], EAX

; 331:   nbyte=s-movie_buffer;  

00008: 02E2 8B 55 FFFFFFCC              MOV EDX, DWORD PTR FFFFFFCC[EBP]
00008: 02E5 2B 15 00000000              SUB EDX, DWORD PTR .bss+0000000c
00008: 02EB 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 332:   fErr=(nbyte!=fwrite(movie_buffer,1,nbyte,path))||fErr;

00008: 02EE BB 00000001                 MOV EBX, 00000001
00008: 02F3 A1 00000000                 MOV EAX, DWORD PTR _path
00008: 02F8 50                          PUSH EAX
00008: 02F9 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 02FC 6A 01                       PUSH 00000001
00008: 02FE A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 0303 50                          PUSH EAX
00008: 0304 E8 00000000                 CALL SHORT _fwrite
00008: 0309 83 C4 10                    ADD ESP, 00000010
00008: 030C 39 45 FFFFFFD0              CMP DWORD PTR FFFFFFD0[EBP], EAX
00008: 030F 75 0E                       JNE L0016
00008: 0311 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 0318 75 05                       JNE L0016
00008: 031A BB 00000000                 MOV EBX, 00000000
00008: 031F                     L0016:
00008: 031F 89 1D 00000000              MOV DWORD PTR _fErr, EBX

; 333:   if(!fErr){return 1;}

00008: 0325 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 032C 75 0C                       JNE L0017
00008: 032E B8 00000001                 MOV EAX, 00000001
00000: 0333                             epilog 
00000: 0333 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0336 5E                          POP ESI
00000: 0337 5B                          POP EBX
00000: 0338 5D                          POP EBP
00000: 0339 C3                          RETN 
00008: 033A                     L0017:

; 334:   closemovie(path);

00008: 033A A1 00000000                 MOV EAX, DWORD PTR _path
00008: 033F 50                          PUSH EAX
00008: 0340 E8 00000000                 CALL SHORT _closemovie
00008: 0345 59                          POP ECX

; 335:   return 0;

00008: 0346 B8 00000000                 MOV EAX, 00000000
00000: 034B                     L0000:
00000: 034B                             epilog 
00000: 034B 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 034E 5E                          POP ESI
00000: 034F 5B                          POP EBX
00000: 0350 5D                          POP EBP
00000: 0351 C3                          RETN 

Function: _byte_order

; 344: { unsigned short i=1;

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 344: { unsigned short i=1;

00008: 0013 66 C7 45 FFFFFFFA 0001      MOV WORD PTR FFFFFFFA[EBP], 0001

; 346:   s=(char*)&i;

00008: 0019 8D 55 FFFFFFFA              LEA EDX, DWORD PTR FFFFFFFA[EBP]
00008: 001C 89 55 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EDX

; 347:   if(s[1]>s[0])return 1;

00008: 001F 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0022 8A 58 01                    MOV BL, BYTE PTR 00000001[EAX]
00008: 0025 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00008: 0028 8A 10                       MOV DL, BYTE PTR 00000000[EAX]
00008: 002A 38 D3                       CMP BL, DL
00008: 002C 76 0B                       JBE L0001
00008: 002E B8 00000001                 MOV EAX, 00000001
00000: 0033                             epilog 
00000: 0033 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0036 5B                          POP EBX
00000: 0037 5D                          POP EBP
00000: 0038 C3                          RETN 
00008: 0039                     L0001:

; 348:   return 0;

00008: 0039 B8 00000000                 MOV EAX, 00000000
00000: 003E                     L0000:
00000: 003E                             epilog 
00000: 003E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0041 5B                          POP EBX
00000: 0042 5D                          POP EBP
00000: 0043 C3                          RETN 

Function: _closemovie

; 352: {

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

; 354:   int l_pass=strlen(password);           

00008: 0016 A1 00000000                 MOV EAX, DWORD PTR _password
00008: 001B 50                          PUSH EAX
00008: 001C E8 00000000                 CALL SHORT _strlen
00008: 0021 59                          POP ECX
00008: 0022 89 45 FFFFFFF0              MOV DWORD PTR FFFFFFF0[EBP], EAX

; 356:   char * s=movie_buffer;

00008: 0025 A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 002A 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 357:   fseek(movie_file,l_pass,SEEK_SET);

00008: 002D 6A 00                       PUSH 00000000
00008: 002F FF 75 FFFFFFF0              PUSH DWORD PTR FFFFFFF0[EBP]
00008: 0032 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0035 E8 00000000                 CALL SHORT _fseek
00008: 003A 83 C4 0C                    ADD ESP, 0000000C

; 358:   s_dummy=frame;

00008: 003D 66 8B 15 00000000           MOV DX, WORD PTR _frame
00008: 0044 66 89 55 FFFFFFFA           MOV WORD PTR FFFFFFFA[EBP], DX

; 359:   s=write_java(s,&s_dummy,sizeof(s_dummy),0);

00008: 0048 6A 00                       PUSH 00000000
00008: 004A 6A 02                       PUSH 00000002
00008: 004C 8D 45 FFFFFFFA              LEA EAX, DWORD PTR FFFFFFFA[EBP]
00008: 004F 50                          PUSH EAX
00008: 0050 FF 75 FFFFFFF4              PUSH DWORD PTR FFFFFFF4[EBP]
00008: 0053 E8 00000000                 CALL SHORT _write_java
00008: 0058 83 C4 10                    ADD ESP, 00000010
00008: 005B 89 45 FFFFFFF4              MOV DWORD PTR FFFFFFF4[EBP], EAX

; 360:   nbyte=s-movie_buffer;

00008: 005E 8B 55 FFFFFFF4              MOV EDX, DWORD PTR FFFFFFF4[EBP]
00008: 0061 2B 15 00000000              SUB EDX, DWORD PTR .bss+0000000c
00008: 0067 89 55 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EDX

; 361:   fErr=(nbyte!=fwrite(movie_buffer,1,nbyte,movie_file))||fErr;

00008: 006A BB 00000001                 MOV EBX, 00000001
00008: 006F FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 0072 FF 75 FFFFFFEC              PUSH DWORD PTR FFFFFFEC[EBP]
00008: 0075 6A 01                       PUSH 00000001
00008: 0077 A1 00000000                 MOV EAX, DWORD PTR .bss+0000000c
00008: 007C 50                          PUSH EAX
00008: 007D E8 00000000                 CALL SHORT _fwrite
00008: 0082 83 C4 10                    ADD ESP, 00000010
00008: 0085 39 45 FFFFFFEC              CMP DWORD PTR FFFFFFEC[EBP], EAX
00008: 0088 75 0E                       JNE L0001
00008: 008A 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 0091 75 05                       JNE L0001
00008: 0093 BB 00000000                 MOV EBX, 00000000
00008: 0098                     L0001:
00008: 0098 89 1D 00000000              MOV DWORD PTR _fErr, EBX

; 362:   fErr=fclose(movie_file)||fErr;

00008: 009E BB 00000001                 MOV EBX, 00000001
00008: 00A3 FF 75 08                    PUSH DWORD PTR 00000008[EBP]
00008: 00A6 E8 00000000                 CALL SHORT _fclose
00008: 00AB 59                          POP ECX
00008: 00AC 83 F8 00                    CMP EAX, 00000000
00008: 00AF 75 0E                       JNE L0002
00008: 00B1 83 3D 00000000 00           CMP DWORD PTR _fErr, 00000000
00008: 00B8 75 05                       JNE L0002
00008: 00BA BB 00000000                 MOV EBX, 00000000
00008: 00BF                     L0002:
00008: 00BF 89 1D 00000000              MOV DWORD PTR _fErr, EBX

; 363:   return fErr; 

00008: 00C5 A1 00000000                 MOV EAX, DWORD PTR _fErr
00000: 00CA                     L0000:
00000: 00CA                             epilog 
00000: 00CA 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00CD 5B                          POP EBX
00000: 00CE 5D                          POP EBP
00000: 00CF C3                          RETN 
