
Function: _resetAll

; 25: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004                             prolog 

; 26:   sx=0;

00008: 0004 C7 05 00000004 00000000     MOV DWORD PTR _sx+00000004, 00000000
00008: 000E C7 05 00000000 00000000     MOV DWORD PTR _sx, 00000000

; 27:   sy=0;

00008: 0018 C7 05 00000004 00000000     MOV DWORD PTR _sy+00000004, 00000000
00008: 0022 C7 05 00000000 00000000     MOV DWORD PTR _sy, 00000000

; 28:   sz=0;

00008: 002C C7 05 00000004 00000000     MOV DWORD PTR _sz+00000004, 00000000
00008: 0036 C7 05 00000000 00000000     MOV DWORD PTR _sz, 00000000

; 29:   ssx=0;

00008: 0040 C7 05 00000004 00000000     MOV DWORD PTR _ssx+00000004, 00000000
00008: 004A C7 05 00000000 00000000     MOV DWORD PTR _ssx, 00000000

; 30:   ssy=0;

00008: 0054 C7 05 00000004 00000000     MOV DWORD PTR _ssy+00000004, 00000000
00008: 005E C7 05 00000000 00000000     MOV DWORD PTR _ssy, 00000000

; 31:   ssz=0;

00008: 0068 C7 05 00000004 00000000     MOV DWORD PTR _ssz+00000004, 00000000
00008: 0072 C7 05 00000000 00000000     MOV DWORD PTR _ssz, 00000000

; 32:   mass=a[k].m;

00008: 007C 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 007F 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 0086 29 D3                       SUB EBX, EDX
00008: 0088 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 008B 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0091 DD 84 DA 00000088           FLD QWORD PTR 00000088[EDX][EBX*8]
00007: 0098 DD 1D 00000000              FSTP QWORD PTR _mass

; 33:   r[k].x=0;

00008: 009E 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00A1 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00A4 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 00AA C7 44 DA 04 00000000        MOV DWORD PTR 00000004[EDX][EBX*8], 00000000
00008: 00B2 C7 04 DA 00000000           MOV DWORD PTR 00000000[EDX][EBX*8], 00000000

; 34:   r[k].y=0;

00008: 00B9 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00BC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00BF 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 00C5 C7 44 DA 0C 00000000        MOV DWORD PTR 0000000C[EDX][EBX*8], 00000000
00008: 00CD C7 44 DA 08 00000000        MOV DWORD PTR 00000008[EDX][EBX*8], 00000000

; 35:   r[k].z=0;

00008: 00D5 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00D8 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00DB 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 00E1 C7 44 DA 14 00000000        MOV DWORD PTR 00000014[EDX][EBX*8], 00000000
00008: 00E9 C7 44 DA 10 00000000        MOV DWORD PTR 00000010[EDX][EBX*8], 00000000

; 36: }

00000: 00F1                     L0000:
00000: 00F1                             epilog 
00000: 00F1 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00F4 5B                          POP EBX
00000: 00F5 5D                          POP EBP
00000: 00F6 C3                          RETN 

Function: _sumAll

; 39: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 57                          PUSH EDI
00000: 0006                             prolog 

; 40:   sx+=r[k].x*a[k].m;

00008: 0006 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0009 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0010 29 D6                       SUB ESI, EDX
00008: 0012 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0015 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 001B 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 001E 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0021 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 0027 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 002A DC 8C F7 00000088           FMUL QWORD PTR 00000088[EDI][ESI*8]
00007: 0031 DC 05 00000000              FADD QWORD PTR _sx
00007: 0037 DD 1D 00000000              FSTP QWORD PTR _sx

; 41:   sy+=r[k].y*a[k].m;

00008: 003D 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0040 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 0047 29 D6                       SUB ESI, EDX
00008: 0049 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 004C 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 0052 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0055 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0058 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 005E DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 0062 DC 8C F7 00000088           FMUL QWORD PTR 00000088[EDI][ESI*8]
00007: 0069 DC 05 00000000              FADD QWORD PTR _sy
00007: 006F DD 1D 00000000              FSTP QWORD PTR _sy

; 42:   sz+=r[k].z*a[k].m;

00008: 0075 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0078 8D 34 D5 00000000           LEA ESI, [00000000][EDX*8]
00008: 007F 29 D6                       SUB ESI, EDX
00008: 0081 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0084 8B 3D 00000000              MOV EDI, DWORD PTR _a
00008: 008A 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 008D 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0090 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 0096 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 009A DC 8C F7 00000088           FMUL QWORD PTR 00000088[EDI][ESI*8]
00007: 00A1 DC 05 00000000              FADD QWORD PTR _sz
00007: 00A7 DD 1D 00000000              FSTP QWORD PTR _sz

; 43:   ssx+=r[k].x*r[k].x*a[k].m;

00008: 00AD 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 00B0 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00B3 8B 3D 00000000              MOV EDI, DWORD PTR _r
00008: 00B9 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 00BC 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 00BF 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 00C5 DD 04 DA                    FLD QWORD PTR 00000000[EDX][EBX*8]
00007: 00C8 DC 0C F7                    FMUL QWORD PTR 00000000[EDI][ESI*8]
00007: 00CB 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00007: 00CE 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 00D5 29 D3                       SUB EBX, EDX
00007: 00D7 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 00DA 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 00E0 DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 00E7 DC 05 00000000              FADD QWORD PTR _ssx
00007: 00ED DD 1D 00000000              FSTP QWORD PTR _ssx

; 44:   ssy+=r[k].y*r[k].y*a[k].m;

00008: 00F3 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 00F6 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 00F9 8B 3D 00000000              MOV EDI, DWORD PTR _r
00008: 00FF 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0102 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0105 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 010B DD 44 DA 08                 FLD QWORD PTR 00000008[EDX][EBX*8]
00007: 010F DC 4C F7 08                 FMUL QWORD PTR 00000008[EDI][ESI*8]
00007: 0113 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00007: 0116 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 011D 29 D3                       SUB EBX, EDX
00007: 011F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0122 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 0128 DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 012F DC 05 00000000              FADD QWORD PTR _ssy
00007: 0135 DD 1D 00000000              FSTP QWORD PTR _ssy

; 45:   ssz+=r[k].z*r[k].z*a[k].m;

00008: 013B 8B 75 08                    MOV ESI, DWORD PTR 00000008[EBP]
00008: 013E 8D 34 76                    LEA ESI, DWORD PTR 00000000[ESI][ESI*2]
00008: 0141 8B 3D 00000000              MOV EDI, DWORD PTR _r
00008: 0147 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 014A 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 014D 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 0153 DD 44 DA 10                 FLD QWORD PTR 00000010[EDX][EBX*8]
00007: 0157 DC 4C F7 10                 FMUL QWORD PTR 00000010[EDI][ESI*8]
00007: 015B 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00007: 015E 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00007: 0165 29 D3                       SUB EBX, EDX
00007: 0167 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 016A 8B 15 00000000              MOV EDX, DWORD PTR _a
00007: 0170 DC 8C DA 00000088           FMUL QWORD PTR 00000088[EDX][EBX*8]
00007: 0177 DC 05 00000000              FADD QWORD PTR _ssz
00007: 017D DD 1D 00000000              FSTP QWORD PTR _ssz

; 46:   mass+=a[k].m;

00008: 0183 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0186 8D 1C D5 00000000           LEA EBX, [00000000][EDX*8]
00008: 018D 29 D3                       SUB EBX, EDX
00008: 018F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0192 8B 15 00000000              MOV EDX, DWORD PTR _a
00008: 0198 DD 05 00000000              FLD QWORD PTR _mass
00007: 019E DC 84 DA 00000088           FADD QWORD PTR 00000088[EDX][EBX*8]
00007: 01A5 DD 1D 00000000              FSTP QWORD PTR _mass

; 47:   return; 

00000: 01AB                     L0000:
00000: 01AB                             epilog 
00000: 01AB 8D 65 FFFFFFF4              LEA ESP, DWORD PTR FFFFFFF4[EBP]
00000: 01AE 5F                          POP EDI
00000: 01AF 5E                          POP ESI
00000: 01B0 5B                          POP EBX
00000: 01B1 5D                          POP EBP
00000: 01B2 C3                          RETN 

Function: _newCoord

; 52: {  

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

; 55:   moved_atom * a2=a+i; 	

00008: 0019 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 001C 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0022 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 0028 89 55 FFFFFFDC              MOV DWORD PTR FFFFFFDC[EBP], EDX

; 56:   moved_atom * a1=a+j;    

00008: 002B 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 002E 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 0034 03 15 00000000              ADD EDX, DWORD PTR _a
00008: 003A 89 55 FFFFFFE0              MOV DWORD PTR FFFFFFE0[EBP], EDX

; 57:   x=a1->r.x-a2->r.x;

00008: 003D 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 0040 DD 40 48                    FLD QWORD PTR 00000048[EAX]
00007: 0043 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00007: 0046 DC 60 48                    FSUB QWORD PTR 00000048[EAX]
00007: 0049 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]

; 58:   y=a1->r.y-a2->r.y;

00008: 004C 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 004F DD 40 50                    FLD QWORD PTR 00000050[EAX]
00007: 0052 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00007: 0055 DC 60 50                    FSUB QWORD PTR 00000050[EAX]
00007: 0058 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]

; 59:   z=a1->r.z-a2->r.z;

00008: 005B 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 005E DD 40 58                    FLD QWORD PTR 00000058[EAX]
00007: 0061 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00007: 0064 DC 60 58                    FSUB QWORD PTR 00000058[EAX]
00007: 0067 DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]

; 60:   ix=a1->i.x.i-a2->i.x.i;

00008: 006A 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 006D 66 8B 50 30                 MOV DX, WORD PTR 00000030[EAX]
00008: 0071 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0074 66 2B 50 30                 SUB DX, WORD PTR 00000030[EAX]
00008: 0078 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 61:   iy=a1->i.y.i-a2->i.y.i;

00008: 007B 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 007E 66 8B 50 38                 MOV DX, WORD PTR 00000038[EAX]
00008: 0082 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0085 66 2B 50 38                 SUB DX, WORD PTR 00000038[EAX]
00008: 0089 89 55 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EDX

; 62:   iz=a1->i.z.i-a2->i.z.i;

00008: 008C 8B 45 FFFFFFE0              MOV EAX, DWORD PTR FFFFFFE0[EBP]
00008: 008F 66 8B 50 40                 MOV DX, WORD PTR 00000040[EAX]
00008: 0093 8B 45 FFFFFFDC              MOV EAX, DWORD PTR FFFFFFDC[EBP]
00008: 0096 66 2B 50 40                 SUB DX, WORD PTR 00000040[EAX]
00008: 009A 89 55 FFFFFFD8              MOV DWORD PTR FFFFFFD8[EBP], EDX

; 63:   if (ix>1)x-=bound[0].length;

00008: 009D 66 83 7D FFFFFFD0 01        CMP WORD PTR FFFFFFD0[EBP], 0001
00008: 00A2 7E 0E                       JLE L0001
00008: 00A4 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 00AA DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 00AD DC 22                       FSUB QWORD PTR 00000000[EDX]
00007: 00AF DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 00B2                     L0001:

; 64:   if (ix<-1)x+=bound[0].length;

00008: 00B2 66 83 7D FFFFFFD0 FFFFFFFF  CMP WORD PTR FFFFFFD0[EBP], FFFFFFFF
00008: 00B7 7D 0E                       JGE L0002
00008: 00B9 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 00BF DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 00C2 DC 02                       FADD QWORD PTR 00000000[EDX]
00007: 00C4 DD 5D FFFFFFE4              FSTP QWORD PTR FFFFFFE4[EBP]
00008: 00C7                     L0002:

; 65:   if (iy>1)y-=bound[1].length;

00008: 00C7 66 83 7D FFFFFFD4 01        CMP WORD PTR FFFFFFD4[EBP], 0001
00008: 00CC 7E 0F                       JLE L0003
00008: 00CE 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 00D4 DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 00D7 DC 62 18                    FSUB QWORD PTR 00000018[EDX]
00007: 00DA DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]
00008: 00DD                     L0003:

; 66:   if (iy<-1)y+=bound[1].length;

00008: 00DD 66 83 7D FFFFFFD4 FFFFFFFF  CMP WORD PTR FFFFFFD4[EBP], FFFFFFFF
00008: 00E2 7D 0F                       JGE L0004
00008: 00E4 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 00EA DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 00ED DC 42 18                    FADD QWORD PTR 00000018[EDX]
00007: 00F0 DD 5D FFFFFFEC              FSTP QWORD PTR FFFFFFEC[EBP]
00008: 00F3                     L0004:

; 67:   if (iz>1)z-=bound[2].length;

00008: 00F3 66 83 7D FFFFFFD8 01        CMP WORD PTR FFFFFFD8[EBP], 0001
00008: 00F8 7E 0F                       JLE L0005
00008: 00FA 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0100 DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 0103 DC 62 30                    FSUB QWORD PTR 00000030[EDX]
00007: 0106 DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]
00008: 0109                     L0005:

; 68:   if (iz<-1)z+=bound[2].length;

00008: 0109 66 83 7D FFFFFFD8 FFFFFFFF  CMP WORD PTR FFFFFFD8[EBP], FFFFFFFF
00008: 010E 7D 0F                       JGE L0006
00008: 0110 8B 15 00000000              MOV EDX, DWORD PTR _bound
00008: 0116 DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 0119 DC 42 30                    FADD QWORD PTR 00000030[EDX]
00007: 011C DD 5D FFFFFFF4              FSTP QWORD PTR FFFFFFF4[EBP]
00008: 011F                     L0006:

; 69:   r[j].x=r[i].x+x;

00008: 011F 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0122 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0125 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 012B DD 45 FFFFFFE4              FLD QWORD PTR FFFFFFE4[EBP]
00007: 012E DC 04 DA                    FADD QWORD PTR 00000000[EDX][EBX*8]
00007: 0131 8B 5D 0C                    MOV EBX, DWORD PTR 0000000C[EBP]
00007: 0134 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0137 8B 15 00000000              MOV EDX, DWORD PTR _r
00007: 013D DD 1C DA                    FSTP QWORD PTR 00000000[EDX][EBX*8]

; 70:   r[j].y=r[i].y+y;

00008: 0140 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0143 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0146 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 014C DD 45 FFFFFFEC              FLD QWORD PTR FFFFFFEC[EBP]
00007: 014F DC 44 DA 08                 FADD QWORD PTR 00000008[EDX][EBX*8]
00007: 0153 8B 5D 0C                    MOV EBX, DWORD PTR 0000000C[EBP]
00007: 0156 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 0159 8B 15 00000000              MOV EDX, DWORD PTR _r
00007: 015F DD 5C DA 08                 FSTP QWORD PTR 00000008[EDX][EBX*8]

; 71:   r[j].z=r[i].z+z; 

00008: 0163 8B 5D 08                    MOV EBX, DWORD PTR 00000008[EBP]
00008: 0166 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0169 8B 15 00000000              MOV EDX, DWORD PTR _r
00008: 016F DD 45 FFFFFFF4              FLD QWORD PTR FFFFFFF4[EBP]
00007: 0172 DC 44 DA 10                 FADD QWORD PTR 00000010[EDX][EBX*8]
00007: 0176 8B 5D 0C                    MOV EBX, DWORD PTR 0000000C[EBP]
00007: 0179 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00007: 017C 8B 15 00000000              MOV EDX, DWORD PTR _r
00007: 0182 DD 5C DA 10                 FSTP QWORD PTR 00000010[EDX][EBX*8]

; 72: }

00000: 0186                     L0000:
00000: 0186                             epilog 
00000: 0186 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0189 5B                          POP EBX
00000: 018A 5D                          POP EBP
00000: 018B C3                          RETN 

Function: _init_clusters

; 75: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004                             prolog 

; 76:   a=(moved_atom *)get_atom();

00008: 0004 E8 00000000                 CALL SHORT _get_atom
00008: 0009 A3 00000000                 MOV DWORD PTR _a, EAX

; 77:   bound =get_bounds();

00008: 000E E8 00000000                 CALL SHORT _get_bounds
00008: 0013 A3 00000000                 MOV DWORD PTR _bound, EAX

; 78:   nAtoms=get_atom_number();

00008: 0018 E8 00000000                 CALL SHORT _get_atom_number
00008: 001D 66 A3 00000000              MOV WORD PTR _nAtoms, AX

; 79:   good=0;

00008: 0023 C7 05 00000000 00000000     MOV DWORD PTR _good, 00000000

; 80:   threshold=0;

00008: 002D C7 05 00000004 00000000     MOV DWORD PTR _threshold+00000004, 00000000
00008: 0037 C7 05 00000000 00000000     MOV DWORD PTR _threshold, 00000000

; 81:   if(!(r=(crd *) malloc(nAtoms*sizeof(crd))))return good;

00008: 0041 0F BF 1D 00000000           MOVSX EBX, WORD PTR _nAtoms
00008: 0048 8D 1C DD 00000000           LEA EBX, [00000000][EBX*8]
00008: 004F 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0052 53                          PUSH EBX
00008: 0053 E8 00000000                 CALL SHORT _malloc
00008: 0058 59                          POP ECX
00008: 0059 A3 00000000                 MOV DWORD PTR _r, EAX
00008: 005E 83 3D 00000000 00           CMP DWORD PTR _r, 00000000
00008: 0065 75 0B                       JNE L0001
00008: 0067 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 006C                             epilog 
00000: 006C 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 006F 5B                          POP EBX
00000: 0070 5D                          POP EBP
00000: 0071 C3                          RETN 
00008: 0072                     L0001:

; 82:   if(!(burn=(short *) malloc((nAtoms+1)*sizeof(short))))return good;

00008: 0072 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 0079 42                          INC EDX
00008: 007A 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 0081 52                          PUSH EDX
00008: 0082 E8 00000000                 CALL SHORT _malloc
00008: 0087 59                          POP ECX
00008: 0088 A3 00000000                 MOV DWORD PTR _burn, EAX
00008: 008D 83 3D 00000000 00           CMP DWORD PTR _burn, 00000000
00008: 0094 75 0B                       JNE L0002
00008: 0096 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 009B                             epilog 
00000: 009B 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 009E 5B                          POP EBX
00000: 009F 5D                          POP EBP
00000: 00A0 C3                          RETN 
00008: 00A1                     L0002:

; 83:   if(!(mols=(short *) malloc((nAtoms+1)*sizeof(short))))return good;

00008: 00A1 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 00A8 42                          INC EDX
00008: 00A9 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 00B0 52                          PUSH EDX
00008: 00B1 E8 00000000                 CALL SHORT _malloc
00008: 00B6 59                          POP ECX
00008: 00B7 A3 00000000                 MOV DWORD PTR _mols, EAX
00008: 00BC 83 3D 00000000 00           CMP DWORD PTR _mols, 00000000
00008: 00C3 75 0B                       JNE L0003
00008: 00C5 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 00CA                             epilog 
00000: 00CA 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00CD 5B                          POP EBX
00000: 00CE 5D                          POP EBP
00000: 00CF C3                          RETN 
00008: 00D0                     L0003:

; 84:   printf("Compute gyration radius\n");

00008: 00D0 68 00000000                 PUSH OFFSET @112
00008: 00D5 E8 00000000                 CALL SHORT _printf
00008: 00DA 59                          POP ECX

; 85:   if(!yes())return good;

00008: 00DB E8 00000000                 CALL SHORT _yes
00008: 00E0 83 F8 00                    CMP EAX, 00000000
00008: 00E3 75 0B                       JNE L0004
00008: 00E5 A1 00000000                 MOV EAX, DWORD PTR _good
00000: 00EA                             epilog 
00000: 00EA 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00ED 5B                          POP EBX
00000: 00EE 5D                          POP EBP
00000: 00EF C3                          RETN 
00008: 00F0                     L0004:

; 86:     printf("Minimal Molecular Mass= %lf\n",threshold);

00008: 00F0 FF 35 00000004              PUSH DWORD PTR _threshold+00000004
00008: 00F6 FF 35 00000000              PUSH DWORD PTR _threshold
00008: 00FC 68 00000000                 PUSH OFFSET @113
00008: 0101 E8 00000000                 CALL SHORT _printf
00008: 0106 83 C4 0C                    ADD ESP, 0000000C

; 87:    if(!yes())

00008: 0109 E8 00000000                 CALL SHORT _yes
00008: 010E 83 F8 00                    CMP EAX, 00000000
00008: 0111 75 1C                       JNE L0005

; 89:        printf("Minimal Molecular Mass= ?\n");

00008: 0113 68 00000000                 PUSH OFFSET @114
00008: 0118 E8 00000000                 CALL SHORT _printf
00008: 011D 59                          POP ECX

; 90:        scanf("%lf",&threshold);

00008: 011E 68 00000000                 PUSH OFFSET _threshold
00008: 0123 68 00000000                 PUSH OFFSET @115
00008: 0128 E8 00000000                 CALL SHORT _scanf
00008: 012D 59                          POP ECX
00008: 012E 59                          POP ECX

; 91:      }

00008: 012F                     L0005:

; 92:     printf("Minimal Molecular Mass= %lf\n",threshold);

00008: 012F FF 35 00000004              PUSH DWORD PTR _threshold+00000004
00008: 0135 FF 35 00000000              PUSH DWORD PTR _threshold
00008: 013B 68 00000000                 PUSH OFFSET @113
00008: 0140 E8 00000000                 CALL SHORT _printf
00008: 0145 83 C4 0C                    ADD ESP, 0000000C

; 93:   n0=0;

00008: 0148 66 C7 05 00000000 0000      MOV WORD PTR _n0, 0000

; 94:   if(is_rms())

00008: 0151 E8 00000000                 CALL SHORT _is_rms
00008: 0156 83 F8 00                    CMP EAX, 00000000
00008: 0159 74 29                       JE L0006

; 96: 	nAtoms=n_rms();

00008: 015B E8 00000000                 CALL SHORT _n_rms
00008: 0160 66 A3 00000000              MOV WORD PTR _nAtoms, AX

; 97:         n0=n0_rms();

00008: 0166 E8 00000000                 CALL SHORT _n0_rms
00008: 016B 66 A3 00000000              MOV WORD PTR _n0, AX

; 98: 	a+=n0; 

00008: 0171 0F BF 15 00000000           MOVSX EDX, WORD PTR _n0
00008: 0178 69 D2 000000A8              IMUL EDX, EDX, 000000A8
00008: 017E 01 15 00000000              ADD DWORD PTR _a, EDX

; 99:       }

00008: 0184                     L0006:

; 100:   good=1;

00008: 0184 C7 05 00000000 00000001     MOV DWORD PTR _good, 00000001

; 101:   return good;

00008: 018E A1 00000000                 MOV EAX, DWORD PTR _good
00000: 0193                     L0000:
00000: 0193                             epilog 
00000: 0193 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0196 5B                          POP EBX
00000: 0197 5D                          POP EBP
00000: 0198 C3                          RETN 

Function: _get_gr

; 105: { 

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 56                          PUSH ESI
00000: 0005 83 EC 30                    SUB ESP, 00000030
00000: 0008 57                          PUSH EDI
00000: 0009 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000E 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0012 B9 0000000C                 MOV ECX, 0000000C
00000: 0017 F3 AB                       REP STOSD 
00000: 0019 5F                          POP EDI
00000: 001A                             prolog 

; 108:   if(!good)return (double)get_ll();

00008: 001A 83 3D 00000000 00           CMP DWORD PTR _good, 00000000
00008: 0021 75 12                       JNE L0001
00008: 0023 E8 00000000                 CALL SHORT _get_ll
00008: 0028 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX
00008: 002B DB 45 FFFFFFE8              FILD DWORD PTR FFFFFFE8[EBP]
00000: 002E                             epilog 
00000: 002E 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0031 5E                          POP ESI
00000: 0032 5B                          POP EBX
00000: 0033 5D                          POP EBP
00000: 0034 C3                          RETN 
00008: 0035                     L0001:

; 109:   moveatoms();

00008: 0035 E8 00000000                 CALL SHORT _moveatoms

; 110:   for(i = 0; i <= nAtoms; i++)

00008: 003A C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0041 EB 12                       JMP L0002
00008: 0043                     L0003:

; 111:     mols[i] = -1;

00008: 0043 8B 5D FFFFFFF4              MOV EBX, DWORD PTR FFFFFFF4[EBP]
00008: 0046 8B 15 00000000              MOV EDX, DWORD PTR _mols
00008: 004C 66 C7 04 5A FFFFFFFF        MOV WORD PTR 00000000[EDX][EBX*2], FFFFFFFF
00008: 0052 FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]
00008: 0055                     L0002:
00008: 0055 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 005C 39 55 FFFFFFF4              CMP DWORD PTR FFFFFFF4[EBP], EDX
00008: 005F 7E FFFFFFE2                 JLE L0003

; 112:   gr=0;

00008: 0061 DD 05 00000000              FLD QWORD PTR .data+00000060
00007: 0067 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 113:   totalMass=0;

00008: 006A DD 05 00000000              FLD QWORD PTR .data+00000060
00007: 0070 DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 114:   clNumber = 0;

00008: 0073 66 C7 05 00000000 0000      MOV WORD PTR _clNumber, 0000

; 115:   index = 0;

00008: 007C C7 45 FFFFFFCC 00000000     MOV DWORD PTR FFFFFFCC[EBP], 00000000

; 116:   while(index < nAtoms)

00008: 0083 E9 00000188                 JMP L0004
00008: 0088                     L0005:

; 119: 	index++;

00008: 0088 FF 45 FFFFFFCC              INC DWORD PTR FFFFFFCC[EBP]
00008: 008B                     L0006:
00008: 008B 8B 15 00000000              MOV EDX, DWORD PTR _mols
00008: 0091 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 0094 66 83 3C 42 00              CMP WORD PTR 00000000[EDX][EAX*2], 0000
00008: 0099 7D FFFFFFED                 JGE L0005

; 120:       if(index >= nAtoms)

00008: 009B 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 00A2 39 55 FFFFFFCC              CMP DWORD PTR FFFFFFCC[EBP], EDX
00008: 00A5 0F 8D 00000175              JGE L0007

; 123:       burnNumber = 1;

00008: 00AB 66 C7 05 00000000 0001      MOV WORD PTR _burnNumber, 0001

; 124:       clNumber++;

00008: 00B4 66 FF 05 00000000           INC WORD PTR _clNumber

; 125:       mols[index] = clNumber;

00008: 00BB 8B 35 00000000              MOV ESI, DWORD PTR _mols
00008: 00C1 66 8B 1D 00000000           MOV BX, WORD PTR _clNumber
00008: 00C8 8B 45 FFFFFFCC              MOV EAX, DWORD PTR FFFFFFCC[EBP]
00008: 00CB 66 89 1C 46                 MOV WORD PTR 00000000[ESI][EAX*2], BX

; 126:       burn[0] = index;

00008: 00CF 8B 15 00000000              MOV EDX, DWORD PTR _burn
00008: 00D5 66 8B 45 FFFFFFCC           MOV AX, WORD PTR FFFFFFCC[EBP]
00008: 00D9 66 89 02                    MOV WORD PTR 00000000[EDX], AX

; 127:       resetAll(index);

00008: 00DC FF 75 FFFFFFCC              PUSH DWORD PTR FFFFFFCC[EBP]
00008: 00DF E8 00000000                 CALL SHORT _resetAll
00008: 00E4 59                          POP ECX

; 129:       while(burnNumber > 0)

00008: 00E5 E9 000000BC                 JMP L0008
00008: 00EA                     L0009:

; 131: 	  burnNumber--;

00008: 00EA 66 FF 0D 00000000           DEC WORD PTR _burnNumber

; 132: 	  atomIndex = burn[burnNumber];

00008: 00F1 0F BF 35 00000000           MOVSX ESI, WORD PTR _burnNumber
00008: 00F8 8B 1D 00000000              MOV EBX, DWORD PTR _burn
00008: 00FE 0F BF 14 73                 MOVSX EDX, WORD PTR 00000000[EBX][ESI*2]
00008: 0102 89 55 FFFFFFD0              MOV DWORD PTR FFFFFFD0[EBP], EDX

; 133: 	  i=-1;

00008: 0105 C7 45 FFFFFFF4 FFFFFFFF     MOV DWORD PTR FFFFFFF4[EBP], FFFFFFFF

; 134: 	  do

00008: 010C                     L000A:

; 136: 	      friendIndex = nextFriend(atomIndex+n0,&i)-n0;

00008: 010C 8D 45 FFFFFFF4              LEA EAX, DWORD PTR FFFFFFF4[EBP]
00008: 010F 50                          PUSH EAX
00008: 0110 0F BF 15 00000000           MOVSX EDX, WORD PTR _n0
00008: 0117 03 55 FFFFFFD0              ADD EDX, DWORD PTR FFFFFFD0[EBP]
00008: 011A 52                          PUSH EDX
00008: 011B E8 00000000                 CALL SHORT _nextFriend
00008: 0120 59                          POP ECX
00008: 0121 59                          POP ECX
00008: 0122 0F BF 15 00000000           MOVSX EDX, WORD PTR _n0
00008: 0129 29 D0                       SUB EAX, EDX
00008: 012B 89 45 FFFFFFD4              MOV DWORD PTR FFFFFFD4[EBP], EAX

; 137:               if(i==-1)break;

00008: 012E 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 0132 74 72                       JE L000B

; 138:               if((friendIndex>=0)&&(friendIndex<nAtoms))

00008: 0134 83 7D FFFFFFD4 00           CMP DWORD PTR FFFFFFD4[EBP], 00000000
00008: 0138 7C 62                       JL L000C
00008: 013A 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 0141 39 55 FFFFFFD4              CMP DWORD PTR FFFFFFD4[EBP], EDX
00008: 0144 7D 56                       JGE L000C

; 140: 		  if(mols[friendIndex]==-1)

00008: 0146 8B 15 00000000              MOV EDX, DWORD PTR _mols
00008: 014C 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 014F 66 83 3C 42 FFFFFFFF        CMP WORD PTR 00000000[EDX][EAX*2], FFFFFFFF
00008: 0154 75 46                       JNE L000D

; 142: 		      burn[burnNumber] = friendIndex;

00008: 0156 0F BF 35 00000000           MOVSX ESI, WORD PTR _burnNumber
00008: 015D 8B 1D 00000000              MOV EBX, DWORD PTR _burn
00008: 0163 66 8B 45 FFFFFFD4           MOV AX, WORD PTR FFFFFFD4[EBP]
00008: 0167 66 89 04 73                 MOV WORD PTR 00000000[EBX][ESI*2], AX

; 143: 		      mols[friendIndex] = clNumber;

00008: 016B 8B 35 00000000              MOV ESI, DWORD PTR _mols
00008: 0171 66 8B 1D 00000000           MOV BX, WORD PTR _clNumber
00008: 0178 8B 45 FFFFFFD4              MOV EAX, DWORD PTR FFFFFFD4[EBP]
00008: 017B 66 89 1C 46                 MOV WORD PTR 00000000[ESI][EAX*2], BX

; 144: 		      burnNumber++;  

00008: 017F 66 FF 05 00000000           INC WORD PTR _burnNumber

; 145: 		      newCoord(atomIndex,friendIndex);

00008: 0186 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0189 FF 75 FFFFFFD0              PUSH DWORD PTR FFFFFFD0[EBP]
00008: 018C E8 00000000                 CALL SHORT _newCoord
00008: 0191 59                          POP ECX
00008: 0192 59                          POP ECX

; 146: 		      sumAll(friendIndex);

00008: 0193 FF 75 FFFFFFD4              PUSH DWORD PTR FFFFFFD4[EBP]
00008: 0196 E8 00000000                 CALL SHORT _sumAll
00008: 019B 59                          POP ECX

; 147: 		    }

00008: 019C                     L000D:

; 148: 		}

00008: 019C                     L000C:

; 149: 	    }

00008: 019C 83 7D FFFFFFF4 FFFFFFFF     CMP DWORD PTR FFFFFFF4[EBP], FFFFFFFF
00008: 01A0 0F 8F FFFFFF66              JG L000A
00008: 01A6                     L000B:

; 151: 	}

00008: 01A6                     L0008:
00008: 01A6 66 83 3D 00000000 00        CMP WORD PTR _burnNumber, 0000
00008: 01AE 0F 8F FFFFFF36              JG L0009

; 152:       if(mass>=threshold)

00008: 01B4 DD 05 00000000              FLD QWORD PTR _mass
00007: 01BA DD 05 00000000              FLD QWORD PTR _threshold
00006: 01C0 F1DF                        FCOMIP ST, ST(1), L000E
00007: 01C2 DD D8                       FSTP ST
00008: 01C4 7A 4A                       JP L000E
00008: 01C6 77 48                       JA L000E

; 154: 	  gr+=ssx +ssy +ssz-(sx*sx+sy*sy+sz*sz)/mass;

00008: 01C8 DD 05 00000000              FLD QWORD PTR _sy
00007: 01CE D8 C8                       FMUL ST, ST
00007: 01D0 DD 05 00000000              FLD QWORD PTR _sx
00006: 01D6 D8 C8                       FMUL ST, ST
00006: 01D8 DE C1                       FADDP ST(1), ST
00007: 01DA DD 05 00000000              FLD QWORD PTR _sz
00006: 01E0 D8 C8                       FMUL ST, ST
00006: 01E2 DE C1                       FADDP ST(1), ST
00007: 01E4 DC 35 00000000              FDIV QWORD PTR _mass
00007: 01EA DD 05 00000000              FLD QWORD PTR _ssx
00006: 01F0 DC 05 00000000              FADD QWORD PTR _ssy
00006: 01F6 DC 05 00000000              FADD QWORD PTR _ssz
00006: 01FC DE E1                       FSUBRP ST(1), ST
00007: 01FE DC 45 FFFFFFD8              FADD QWORD PTR FFFFFFD8[EBP]
00007: 0201 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]

; 155: 	  totalMass+=mass;

00008: 0204 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 0207 DC 05 00000000              FADD QWORD PTR _mass
00007: 020D DD 5D FFFFFFE0              FSTP QWORD PTR FFFFFFE0[EBP]

; 156: 	}

00008: 0210                     L000E:

; 157:     }

00008: 0210                     L0004:
00008: 0210 0F BF 15 00000000           MOVSX EDX, WORD PTR _nAtoms
00008: 0217 39 55 FFFFFFCC              CMP DWORD PTR FFFFFFCC[EBP], EDX
00008: 021A 0F 8C FFFFFE6B              JL L0006
00008: 0220                     L0007:

; 158:   if(totalMass)   

00008: 0220 DD 45 FFFFFFE0              FLD QWORD PTR FFFFFFE0[EBP]
00007: 0223 DD 05 00000000              FLD QWORD PTR .data+00000060
00006: 0229 F1DF                        FCOMIP ST, ST(1), L000F
00007: 022B DD D8                       FSTP ST
00008: 022D 7A 02                       JP L0011
00008: 022F 74 17                       JE L000F
00008: 0231                     L0011:

; 159:     gr=sqrt(gr/totalMass);

00008: 0231 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00007: 0234 DC 75 FFFFFFE0              FDIV QWORD PTR FFFFFFE0[EBP]
00007: 0237 50                          PUSH EAX
00007: 0238 50                          PUSH EAX
00007: 0239 DD 1C 24                    FSTP QWORD PTR 00000000[ESP]
00008: 023C E8 00000000                 CALL SHORT _sqrt
00007: 0241 59                          POP ECX
00007: 0242 59                          POP ECX
00007: 0243 DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]
00008: 0246 EB 09                       JMP L0010
00008: 0248                     L000F:

; 161:     gr=0;

00008: 0248 DD 05 00000000              FLD QWORD PTR .data+00000060
00007: 024E DD 5D FFFFFFD8              FSTP QWORD PTR FFFFFFD8[EBP]
00008: 0251                     L0010:

; 162:   return gr;

00008: 0251 DD 45 FFFFFFD8              FLD QWORD PTR FFFFFFD8[EBP]
00000: 0254                     L0000:
00000: 0254                             epilog 
00000: 0254 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0257 5E                          POP ESI
00000: 0258 5B                          POP EBX
00000: 0259 5D                          POP EBP
00000: 025A C3                          RETN 

Function: _sqrt

; 552: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 554: if(x >=0.0)

00008: 0003 DD 45 08                    FLD QWORD PTR 00000008[EBP]
00007: 0006 DD 05 00000000              FLD QWORD PTR .data+00000060
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
