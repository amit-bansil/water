
Function: _getnewBonds

; 17: static bond_type newBonds; extern bond_type getnewBonds(){ return newBonds; }

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 17: static bond_type newBonds; extern bond_type getnewBonds(){ return newBonds; }

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _newBonds
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getnewTypes

; 18: static bond_type newTypes; extern bond_type getnewTypes(){ return newTypes; } /*fix it 6*/

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 18: static bond_type newTypes; extern bond_type getnewTypes(){ return newTypes; } /*fix it 6*/

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _newTypes
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _allocBonds

; 22: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 24:   nAtom=n;

00008: 0013 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0016 89 15 00000000              MOV DWORD PTR _nAtom, EDX

; 25:   if(!nrt)

00008: 001C 83 7D 10 00                 CMP DWORD PTR 00000010[EBP], 00000000
00008: 0020 75 12                       JNE L0001

; 26:     nFriend=2*numbond;

00008: 0022 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0025 8D 14 55 00000000           LEA EDX, [00000000][EDX*2]
00008: 002C 89 15 00000000              MOV DWORD PTR _nFriend, EDX
00008: 0032 EB 24                       JMP L0002
00008: 0034                     L0001:

; 29:       nFriend=NBONDS*nAtom;

00008: 0034 8B 15 00000000              MOV EDX, DWORD PTR _nAtom
00008: 003A 8D 1C 95 00000000           LEA EBX, [00000000][EDX*4]
00008: 0041 8D 1C 5B                    LEA EBX, DWORD PTR 00000000[EBX][EBX*2]
00008: 0044 89 1D 00000000              MOV DWORD PTR _nFriend, EBX

; 30:       if(lbt)

00008: 004A 83 7D 14 00                 CMP DWORD PTR 00000014[EBP], 00000000
00008: 004E 74 08                       JE L0003

; 31: 	nFriend=lbt;

00008: 0050 8B 45 14                    MOV EAX, DWORD PTR 00000014[EBP]
00008: 0053 A3 00000000                 MOV DWORD PTR _nFriend, EAX
00008: 0058                     L0003:

; 32:     }

00008: 0058                     L0002:

; 33:   nTotal=nFriend+nAtom;

00008: 0058 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 005E 03 15 00000000              ADD EDX, DWORD PTR _nAtom
00008: 0064 89 15 00000000              MOV DWORD PTR _nTotal, EDX

; 34:   next =(bond_type *)malloc((nTotal)*sizeof(bond_type));

00008: 006A 8B 15 00000000              MOV EDX, DWORD PTR _nTotal
00008: 0070 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0077 52                          PUSH EDX
00008: 0078 E8 00000000                 CALL SHORT _malloc
00008: 007D 59                          POP ECX
00008: 007E A3 00000000                 MOV DWORD PTR _next, EAX

; 35:   if(!(next))return 0; 

00008: 0083 83 3D 00000000 00           CMP DWORD PTR _next, 00000000
00008: 008A 75 0B                       JNE L0004
00008: 008C B8 00000000                 MOV EAX, 00000000
00000: 0091                             epilog 
00000: 0091 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0094 5B                          POP EBX
00000: 0095 5D                          POP EBP
00000: 0096 C3                          RETN 
00008: 0097                     L0004:

; 36:   first=next+nFriend;

00008: 0097 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 009D 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 00A4 03 15 00000000              ADD EDX, DWORD PTR _next
00008: 00AA 89 15 00000000              MOV DWORD PTR _first, EDX

; 37:   for(i = 0; i <nAtom ; i++)

00008: 00B0 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000
00008: 00B7 EB 13                       JMP L0005
00008: 00B9                     L0006:

; 38:     first[i] = -1;

00008: 00B9 8B 15 00000000              MOV EDX, DWORD PTR _first
00008: 00BF 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 00C2 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF
00008: 00C9 FF 45 FFFFFFF8              INC DWORD PTR FFFFFFF8[EBP]
00008: 00CC                     L0005:
00008: 00CC 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 00CF 3B 05 00000000              CMP EAX, DWORD PTR _nAtom
00008: 00D5 7C FFFFFFE2                 JL L0006

; 39:   freeCount=nFriend;

00008: 00D7 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 00DD 89 15 00000000              MOV DWORD PTR _freeCount, EDX

; 40:   if(!freeCount)return 1;

00008: 00E3 83 3D 00000000 00           CMP DWORD PTR _freeCount, 00000000
00008: 00EA 75 0B                       JNE L0007
00008: 00EC B8 00000001                 MOV EAX, 00000001
00000: 00F1                             epilog 
00000: 00F1 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 00F4 5B                          POP EBX
00000: 00F5 5D                          POP EBP
00000: 00F6 C3                          RETN 
00008: 00F7                     L0007:

; 41:   friend =(bond_type *)malloc(nFriend*sizeof(bond_type));

00008: 00F7 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 00FD 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0104 52                          PUSH EDX
00008: 0105 E8 00000000                 CALL SHORT _malloc
00008: 010A 59                          POP ECX
00008: 010B A3 00000000                 MOV DWORD PTR _friend, EAX

; 42:   if(!(friend))return 0;

00008: 0110 83 3D 00000000 00           CMP DWORD PTR _friend, 00000000
00008: 0117 75 0B                       JNE L0008
00008: 0119 B8 00000000                 MOV EAX, 00000000
00000: 011E                             epilog 
00000: 011E 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0121 5B                          POP EBX
00000: 0122 5D                          POP EBP
00000: 0123 C3                          RETN 
00008: 0124                     L0008:

; 43:   freeInd =(bond_type *)malloc(nFriend*sizeof(bond_type));

00008: 0124 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 012A 8D 14 95 00000000           LEA EDX, [00000000][EDX*4]
00008: 0131 52                          PUSH EDX
00008: 0132 E8 00000000                 CALL SHORT _malloc
00008: 0137 59                          POP ECX
00008: 0138 A3 00000000                 MOV DWORD PTR _freeInd, EAX

; 44:   if(!(freeInd))return 0;

00008: 013D 83 3D 00000000 00           CMP DWORD PTR _freeInd, 00000000
00008: 0144 75 0B                       JNE L0009
00008: 0146 B8 00000000                 MOV EAX, 00000000
00000: 014B                             epilog 
00000: 014B 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 014E 5B                          POP EBX
00000: 014F 5D                          POP EBP
00000: 0150 C3                          RETN 
00008: 0151                     L0009:

; 46:   for(i = 0; i <freeCount ; i++)

00008: 0151 C7 45 FFFFFFF8 00000000     MOV DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0158 EB 22                       JMP L000A
00008: 015A                     L000B:

; 48:       freeInd[i] = i;

00008: 015A 8B 1D 00000000              MOV EBX, DWORD PTR _freeInd
00008: 0160 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 0163 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0166 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 49:       friend[i]=-1;

00008: 0169 8B 15 00000000              MOV EDX, DWORD PTR _friend
00008: 016F 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0172 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF

; 50:     }

00008: 0179 FF 45 FFFFFFF8              INC DWORD PTR FFFFFFF8[EBP]
00008: 017C                     L000A:
00008: 017C 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 017F 3B 05 00000000              CMP EAX, DWORD PTR _freeCount
00008: 0185 7C FFFFFFD3                 JL L000B

; 51:   return 1;

00008: 0187 B8 00000001                 MOV EAX, 00000001
00000: 018C                     L0000:
00000: 018C                             epilog 
00000: 018C 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 018F 5B                          POP EBX
00000: 0190 5D                          POP EBP
00000: 0191 C3                          RETN 

Function: _setBond

; 54: { 

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

; 60:   int res=0;

00008: 0019 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 61:   if (friend1==friend2)return 0;

00008: 0020 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0023 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0026 75 0C                       JNE L0001
00008: 0028 B8 00000000                 MOV EAX, 00000000
00000: 002D                             epilog 
00000: 002D 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0030 5E                          POP ESI
00000: 0031 5B                          POP EBX
00000: 0032 5D                          POP EBP
00000: 0033 C3                          RETN 
00008: 0034                     L0001:

; 62:   for(i=0;i<2;i++)

00008: 0034 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 003B E9 000000D4                 JMP L0002
00008: 0040                     L0003:

; 64:       if(i)

00008: 0040 83 7D FFFFFFE0 00           CMP DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0044 74 14                       JE L0004

; 66: 	  index=friend1+nFriend;

00008: 0046 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0049 03 15 00000000              ADD EDX, DWORD PTR _nFriend
00008: 004F 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 67: 	  newfriend=friend2;

00008: 0052 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0055 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 68: 	}

00008: 0058 EB 12                       JMP L0005
00008: 005A                     L0004:

; 71: 	  index=friend2+nFriend;

00008: 005A 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 005D 03 15 00000000              ADD EDX, DWORD PTR _nFriend
00008: 0063 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 72: 	  newfriend=friend1;

00008: 0066 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0069 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 73: 	}

00008: 006C                     L0005:

; 74:       found=0;

00008: 006C C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 75:       while(next[index]>=0)

00008: 0073 EB 29                       JMP L0006
00008: 0075                     L0007:

; 77: 	  index=next[index];

00008: 0075 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 007B 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 007E 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0081 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 78: 	  if(friend[index]==newfriend){found=1;break;}

00008: 0084 8B 1D 00000000              MOV EBX, DWORD PTR _friend
00008: 008A 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 008D 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 0090 3B 04 8B                    CMP EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0093 75 09                       JNE L0008
00008: 0095 C7 45 FFFFFFF0 00000001     MOV DWORD PTR FFFFFFF0[EBP], 00000001
00008: 009C EB 0F                       JMP L0009
00008: 009E                     L0008:

; 79: 	}

00008: 009E                     L0006:
00008: 009E 8B 15 00000000              MOV EDX, DWORD PTR _next
00008: 00A4 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00A7 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 00AB 7D FFFFFFC8                 JGE L0007
00008: 00AD                     L0009:

; 80:       if(!found)

00008: 00AD 83 7D FFFFFFF0 00           CMP DWORD PTR FFFFFFF0[EBP], 00000000
00008: 00B1 75 5E                       JNE L000A

; 82: 	  if(!(freeCount))return -1;

00008: 00B3 83 3D 00000000 00           CMP DWORD PTR _freeCount, 00000000
00008: 00BA 75 0C                       JNE L000B
00008: 00BC B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 00C1                             epilog 
00000: 00C1 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 00C4 5E                          POP ESI
00000: 00C5 5B                          POP EBX
00000: 00C6 5D                          POP EBP
00000: 00C7 C3                          RETN 
00008: 00C8                     L000B:

; 83: 	  (freeCount)--;

00008: 00C8 FF 0D 00000000              DEC DWORD PTR _freeCount

; 84: 	  newindex=freeInd[freeCount];

00008: 00CE 8B 35 00000000              MOV ESI, DWORD PTR _freeCount
00008: 00D4 8B 1D 00000000              MOV EBX, DWORD PTR _freeInd
00008: 00DA 8B 04 B3                    MOV EAX, DWORD PTR 00000000[EBX][ESI*4]
00008: 00DD 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 85: 	  next[index]=newindex;

00008: 00E0 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 00E6 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 00E9 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00EC 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 86: 	  next[newindex]=-1;

00008: 00EF 8B 15 00000000              MOV EDX, DWORD PTR _next
00008: 00F5 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00F8 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF

; 87: 	  friend[newindex]=newfriend;

00008: 00FF 8B 1D 00000000              MOV EBX, DWORD PTR _friend
00008: 0105 8B 4D FFFFFFEC              MOV ECX, DWORD PTR FFFFFFEC[EBP]
00008: 0108 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 010B 89 0C 83                    MOV DWORD PTR 00000000[EBX][EAX*4], ECX

; 88: 	  res++;

00008: 010E FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]

; 89: 	}

00008: 0111                     L000A:

; 90:     }

00008: 0111 FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 0114                     L0002:
00008: 0114 83 7D FFFFFFE0 02           CMP DWORD PTR FFFFFFE0[EBP], 00000002
00008: 0118 0F 8C FFFFFF22              JL L0003

; 91:   if(res>0)newBonds=1;

00008: 011E 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0122 7E 0A                       JLE L000C
00008: 0124 C7 05 00000000 00000001     MOV DWORD PTR _newBonds, 00000001
00008: 012E                     L000C:

; 92:   return res;

00008: 012E 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00000: 0131                     L0000:
00000: 0131                             epilog 
00000: 0131 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0134 5E                          POP ESI
00000: 0135 5B                          POP EBX
00000: 0136 5D                          POP EBP
00000: 0137 C3                          RETN 

Function: _breakBond

; 96: { 

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

; 102:   int res=0;

00008: 0019 C7 45 FFFFFFF4 00000000     MOV DWORD PTR FFFFFFF4[EBP], 00000000

; 103:   for(i=0;i<2;i++)

00008: 0020 C7 45 FFFFFFE0 00000000     MOV DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0027 E9 000000C6                 JMP L0001
00008: 002C                     L0002:

; 105:       if(i)

00008: 002C 83 7D FFFFFFE0 00           CMP DWORD PTR FFFFFFE0[EBP], 00000000
00008: 0030 74 14                       JE L0003

; 107: 	  index=friend1+nFriend;

00008: 0032 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0035 03 15 00000000              ADD EDX, DWORD PTR _nFriend
00008: 003B 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 108: 	  oldfriend=friend2;

00008: 003E 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0041 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 109: 	}

00008: 0044 EB 12                       JMP L0004
00008: 0046                     L0003:

; 112: 	  index=friend2+nFriend;

00008: 0046 8B 55 0C                    MOV EDX, DWORD PTR 0000000C[EBP]
00008: 0049 03 15 00000000              ADD EDX, DWORD PTR _nFriend
00008: 004F 89 55 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EDX

; 113: 	  oldfriend=friend1;

00008: 0052 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0055 89 45 FFFFFFEC              MOV DWORD PTR FFFFFFEC[EBP], EAX

; 114: 	}

00008: 0058                     L0004:

; 115:       found=0;

00008: 0058 C7 45 FFFFFFF0 00000000     MOV DWORD PTR FFFFFFF0[EBP], 00000000

; 116:       while(next[index]>=0)

00008: 005F EB 7B                       JMP L0005
00008: 0061                     L0006:

; 118: 	  oldindex=next[index];

00008: 0061 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 0067 8B 4D FFFFFFE4              MOV ECX, DWORD PTR FFFFFFE4[EBP]
00008: 006A 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 006D 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 119: 	  if(friend[oldindex]==oldfriend)

00008: 0070 8B 1D 00000000              MOV EBX, DWORD PTR _friend
00008: 0076 8B 4D FFFFFFE8              MOV ECX, DWORD PTR FFFFFFE8[EBP]
00008: 0079 8B 45 FFFFFFEC              MOV EAX, DWORD PTR FFFFFFEC[EBP]
00008: 007C 3B 04 8B                    CMP EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 007F 75 55                       JNE L0007

; 121: 	      res++;

00008: 0081 FF 45 FFFFFFF4              INC DWORD PTR FFFFFFF4[EBP]

; 122:               next[index]=next[oldindex];

00008: 0084 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 008A 8B 35 00000000              MOV ESI, DWORD PTR _next
00008: 0090 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 0093 8B 1C 83                    MOV EBX, DWORD PTR 00000000[EBX][EAX*4]
00008: 0096 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 0099 89 1C 86                    MOV DWORD PTR 00000000[ESI][EAX*4], EBX

; 123:               next[oldindex]=-1;

00008: 009C 8B 15 00000000              MOV EDX, DWORD PTR _next
00008: 00A2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00A5 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF

; 124:               friend[oldindex]=-1;

00008: 00AC 8B 15 00000000              MOV EDX, DWORD PTR _friend
00008: 00B2 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00B5 C7 04 82 FFFFFFFF           MOV DWORD PTR 00000000[EDX][EAX*4], FFFFFFFF

; 125:               freeInd[freeCount]=oldindex;

00008: 00BC 8B 35 00000000              MOV ESI, DWORD PTR _freeCount
00008: 00C2 8B 1D 00000000              MOV EBX, DWORD PTR _freeInd
00008: 00C8 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00CB 89 04 B3                    MOV DWORD PTR 00000000[EBX][ESI*4], EAX

; 126:               freeCount++;

00008: 00CE FF 05 00000000              INC DWORD PTR _freeCount

; 127: 	      break;

00008: 00D4 EB 19                       JMP L0008
00008: 00D6                     L0007:

; 129: 	  index=oldindex;

00008: 00D6 8B 45 FFFFFFE8              MOV EAX, DWORD PTR FFFFFFE8[EBP]
00008: 00D9 89 45 FFFFFFE4              MOV DWORD PTR FFFFFFE4[EBP], EAX

; 130: 	}

00008: 00DC                     L0005:
00008: 00DC 8B 15 00000000              MOV EDX, DWORD PTR _next
00008: 00E2 8B 45 FFFFFFE4              MOV EAX, DWORD PTR FFFFFFE4[EBP]
00008: 00E5 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 00E9 0F 8D FFFFFF72              JGE L0006
00008: 00EF                     L0008:

; 131:     }

00008: 00EF FF 45 FFFFFFE0              INC DWORD PTR FFFFFFE0[EBP]
00008: 00F2                     L0001:
00008: 00F2 83 7D FFFFFFE0 02           CMP DWORD PTR FFFFFFE0[EBP], 00000002
00008: 00F6 0F 8C FFFFFF30              JL L0002

; 132:   if(res>0)newBonds=1;

00008: 00FC 83 7D FFFFFFF4 00           CMP DWORD PTR FFFFFFF4[EBP], 00000000
00008: 0100 7E 0A                       JLE L0009
00008: 0102 C7 05 00000000 00000001     MOV DWORD PTR _newBonds, 00000001
00008: 010C                     L0009:

; 133:   return res;

00008: 010C 8B 45 FFFFFFF4              MOV EAX, DWORD PTR FFFFFFF4[EBP]
00000: 010F                     L0000:
00000: 010F                             epilog 
00000: 010F 8D 65 FFFFFFF8              LEA ESP, DWORD PTR FFFFFFF8[EBP]
00000: 0112 5E                          POP ESI
00000: 0113 5B                          POP EBX
00000: 0114 5D                          POP EBP
00000: 0115 C3                          RETN 

Function: _setNewBonds

; 138: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 139:   newBonds = value;

00008: 0003 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0006 89 15 00000000              MOV DWORD PTR _newBonds, EDX

; 140: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _setNewTypes

; 143: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 144:   newTypes = value;

00008: 0003 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0006 89 15 00000000              MOV DWORD PTR _newTypes, EDX

; 145: }

00000: 000C                     L0000:
00000: 000C                             epilog 
00000: 000C C9                          LEAVE 
00000: 000D C3                          RETN 

Function: _getNewBonds

; 148: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 149:   return (int)newBonds;

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _newBonds
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _getNewTypes

; 153: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 154:   return (int)newTypes;

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _newTypes
00000: 0008                     L0000:
00000: 0008                             epilog 
00000: 0008 C9                          LEAVE 
00000: 0009 C3                          RETN 

Function: _isFriend

; 158: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 159:   bond_type index=nFriend+atomNumber;

00008: 0013 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 0019 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 001C 89 55 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EDX

; 160:   if(atomNumber == friendNumber)

00008: 001F 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0022 3B 45 0C                    CMP EAX, DWORD PTR 0000000C[EBP]
00008: 0025 75 36                       JNE L0001

; 161:     return 1;

00008: 0027 B8 00000001                 MOV EAX, 00000001
00000: 002C                             epilog 
00000: 002C 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 002F 5B                          POP EBX
00000: 0030 5D                          POP EBP
00000: 0031 C3                          RETN 
00008: 0032                     L0002:

; 164:       index=next[index];

00008: 0032 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 0038 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 003B 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 003E 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 165:       if(friend[index]==friendNumber)return 1;

00008: 0041 8B 1D 00000000              MOV EBX, DWORD PTR _friend
00008: 0047 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 004A 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 004D 3B 04 8B                    CMP EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0050 75 0B                       JNE L0003
00008: 0052 B8 00000001                 MOV EAX, 00000001
00000: 0057                             epilog 
00000: 0057 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 005A 5B                          POP EBX
00000: 005B 5D                          POP EBP
00000: 005C C3                          RETN 
00008: 005D                     L0003:

; 166:     }

00008: 005D                     L0001:
00008: 005D 8B 15 00000000              MOV EDX, DWORD PTR _next
00008: 0063 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0066 83 3C 82 00                 CMP DWORD PTR 00000000[EDX][EAX*4], 00000000
00008: 006A 7D FFFFFFC6                 JGE L0002

; 167:   return 0;

00008: 006C B8 00000000                 MOV EAX, 00000000
00000: 0071                     L0000:
00000: 0071                             epilog 
00000: 0071 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0074 5B                          POP EBX
00000: 0075 5D                          POP EBP
00000: 0076 C3                          RETN 

Function: _nextFriend

; 171: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 53                          PUSH EBX
00000: 0004 83 EC 08                    SUB ESP, 00000008
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 89 04 24                    MOV DWORD PTR 00000000[ESP], EAX
00000: 000F 89 44 24 04                 MOV DWORD PTR 00000004[ESP], EAX
00000: 0013                             prolog 

; 173:   if(index[0]==-1)

00008: 0013 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0016 83 38 FFFFFFFF              CMP DWORD PTR 00000000[EAX], FFFFFFFF
00008: 0019 75 0E                       JNE L0001

; 174:     newindex=nFriend+atomNumber;

00008: 001B 8B 15 00000000              MOV EDX, DWORD PTR _nFriend
00008: 0021 03 55 08                    ADD EDX, DWORD PTR 00000008[EBP]
00008: 0024 89 55 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EDX
00008: 0027 EB 08                       JMP L0002
00008: 0029                     L0001:

; 176:     newindex=index[0];

00008: 0029 8B 4D 0C                    MOV ECX, DWORD PTR 0000000C[EBP]
00008: 002C 8B 01                       MOV EAX, DWORD PTR 00000000[ECX]
00008: 002E 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX
00008: 0031                     L0002:

; 177:   if((newindex<0)||(newindex>=nTotal)){index[0]=-1;return -1;}

00008: 0031 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0035 7C 0B                       JL L0003
00008: 0037 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 003A 3B 05 00000000              CMP EAX, DWORD PTR _nTotal
00008: 0040 7C 14                       JL L0004
00008: 0042                     L0003:
00008: 0042 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0045 C7 00 FFFFFFFF              MOV DWORD PTR 00000000[EAX], FFFFFFFF
00008: 004B B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0050                             epilog 
00000: 0050 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0053 5B                          POP EBX
00000: 0054 5D                          POP EBP
00000: 0055 C3                          RETN 
00008: 0056                     L0004:

; 179:   newindex=next[newindex];

00008: 0056 8B 1D 00000000              MOV EBX, DWORD PTR _next
00008: 005C 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 005F 8B 04 8B                    MOV EAX, DWORD PTR 00000000[EBX][ECX*4]
00008: 0062 89 45 FFFFFFF8              MOV DWORD PTR FFFFFFF8[EBP], EAX

; 180:   if(newindex<0)

00008: 0065 83 7D FFFFFFF8 00           CMP DWORD PTR FFFFFFF8[EBP], 00000000
00008: 0069 7D 14                       JGE L0005

; 181:     {index[0]=-1;return -1;}

00008: 006B 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 006E C7 00 FFFFFFFF              MOV DWORD PTR 00000000[EAX], FFFFFFFF
00008: 0074 B8 FFFFFFFF                 MOV EAX, FFFFFFFF
00000: 0079                             epilog 
00000: 0079 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 007C 5B                          POP EBX
00000: 007D 5D                          POP EBP
00000: 007E C3                          RETN 
00008: 007F                     L0005:

; 183:     {index[0]=newindex;return friend[newindex];}

00008: 007F 8B 4D FFFFFFF8              MOV ECX, DWORD PTR FFFFFFF8[EBP]
00008: 0082 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0085 89 08                       MOV DWORD PTR 00000000[EAX], ECX
00008: 0087 8B 15 00000000              MOV EDX, DWORD PTR _friend
00008: 008D 8B 45 FFFFFFF8              MOV EAX, DWORD PTR FFFFFFF8[EBP]
00008: 0090 8B 04 82                    MOV EAX, DWORD PTR 00000000[EDX][EAX*4]
00000: 0093                     L0000:
00000: 0093                             epilog 
00000: 0093 8D 65 FFFFFFFC              LEA ESP, DWORD PTR FFFFFFFC[EBP]
00000: 0096 5B                          POP EBX
00000: 0097 5D                          POP EBP
00000: 0098 C3                          RETN 

Function: _getMaxBonds

; 187: {return (int)(nFriend>>1);}

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 187: {return (int)(nFriend>>1);}

00008: 0003 A1 00000000                 MOV EAX, DWORD PTR _nFriend
00008: 0008 D1 F8                       SAR EAX, 00000001
00000: 000A                     L0000:
00000: 000A                             epilog 
00000: 000A C9                          LEAVE 
00000: 000B C3                          RETN 
