
Function: _yes

; 32: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003 83 EC 50                    SUB ESP, 00000050
00000: 0006 57                          PUSH EDI
00000: 0007 B8 CCCCCCCC                 MOV EAX, CCCCCCCC
00000: 000C 8D 7C 24 04                 LEA EDI, DWORD PTR 00000004[ESP]
00000: 0010 B9 00000014                 MOV ECX, 00000014
00000: 0015 F3 AB                       REP STOSD 
00000: 0017 5F                          POP EDI
00000: 0018                             prolog 

; 34:   do

00008: 0018                     L0001:

; 36:       printf("Is This OK ? (y/n) \n");

00008: 0018 68 00000000                 PUSH OFFSET @13
00008: 001D E8 00000000                 CALL SHORT _printf
00008: 0022 59                          POP ECX

; 37:       reply[0]=(char)0;

00008: 0023 C6 45 FFFFFFB0 00           MOV BYTE PTR FFFFFFB0[EBP], 00

; 38:       scanf("%s",&reply);

00008: 0027 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 002A 50                          PUSH EAX
00008: 002B 68 00000000                 PUSH OFFSET @14
00008: 0030 E8 00000000                 CALL SHORT _scanf
00008: 0035 59                          POP ECX
00008: 0036 59                          POP ECX

; 39:     }

00008: 0037 68 00000000                 PUSH OFFSET @15
00008: 003C 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 003F 50                          PUSH EAX
00008: 0040 E8 00000000                 CALL SHORT _strcmp
00008: 0045 59                          POP ECX
00008: 0046 59                          POP ECX
00008: 0047 83 F8 00                    CMP EAX, 00000000
00008: 004A 74 15                       JE L0002
00008: 004C 68 00000000                 PUSH OFFSET @16
00008: 0051 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 0054 50                          PUSH EAX
00008: 0055 E8 00000000                 CALL SHORT _strcmp
00008: 005A 59                          POP ECX
00008: 005B 59                          POP ECX
00008: 005C 83 F8 00                    CMP EAX, 00000000
00008: 005F 75 FFFFFFB7                 JNE L0001
00008: 0061                     L0002:

; 41:   if(!strcmp(reply,"y"))

00008: 0061 68 00000000                 PUSH OFFSET @15
00008: 0066 8D 45 FFFFFFB0              LEA EAX, DWORD PTR FFFFFFB0[EBP]
00008: 0069 50                          PUSH EAX
00008: 006A E8 00000000                 CALL SHORT _strcmp
00008: 006F 59                          POP ECX
00008: 0070 59                          POP ECX
00008: 0071 83 F8 00                    CMP EAX, 00000000
00008: 0074 75 07                       JNE L0003

; 42:     return 1;

00008: 0076 B8 00000001                 MOV EAX, 00000001
00000: 007B                             epilog 
00000: 007B C9                          LEAVE 
00000: 007C C3                          RETN 
00008: 007D                     L0003:

; 44:     return 0;

00008: 007D B8 00000000                 MOV EAX, 00000000
00000: 0082                     L0000:
00000: 0082                             epilog 
00000: 0082 C9                          LEAVE 
00000: 0083 C3                          RETN 

Function: _options_dialog

; 47: {

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

; 51:   coeff=get_coeff();

00008: 0017 E8 00000000                 CALL SHORT _get_coeff
00007: 001C DD 1D 00000000              FSTP QWORD PTR _coeff

; 52:   temp_limit=get_temp_limit();

00008: 0022 E8 00000000                 CALL SHORT _get_temp_limit
00007: 0027 DD 1D 00000000              FSTP QWORD PTR _temp_limit

; 53:   deltall=get_delta_ll();

00008: 002D E8 00000000                 CALL SHORT _get_delta_ll
00008: 0032 A3 00000000                 MOV DWORD PTR _deltall, EAX

; 54:   pressure=get_pressure();

00008: 0037 E8 00000000                 CALL SHORT _get_pressure
00007: 003C DD 1D 00000000              FSTP QWORD PTR _pressure

; 55:   temp=get_temp();

00008: 0042 E8 00000000                 CALL SHORT _get_temp
00007: 0047 DD 1D 00000000              FSTP QWORD PTR _temp

; 56:   old_temp=temp;		 

00008: 004D DD 05 00000000              FLD QWORD PTR _temp
00007: 0053 DD 5D FFFFFFF0              FSTP QWORD PTR FFFFFFF0[EBP]

; 57:   rate=get_rate();

00008: 0056 E8 00000000                 CALL SHORT _get_rate
00007: 005B DD 1D 00000000              FSTP QWORD PTR _rate

; 58:   frate=get_frate();

00008: 0061 E8 00000000                 CALL SHORT _get_frate
00007: 0066 DD 1D 00000000              FSTP QWORD PTR _frate

; 59:   mfrate=get_mfrate();	

00008: 006C E8 00000000                 CALL SHORT _get_mfrate
00007: 0071 DD 1D 00000000              FSTP QWORD PTR _mfrate

; 60:   time=get_time();

00008: 0077 E8 00000000                 CALL SHORT _get_time
00007: 007C DD 1D 00000000              FSTP QWORD PTR _time

; 61:   gr=get_gr();

00008: 0082 E8 00000000                 CALL SHORT _get_gr
00007: 0087 DD 1D 00000000              FSTP QWORD PTR _gr

; 62:   energy=countenergy();

00008: 008D E8 00000000                 CALL SHORT _countenergy
00007: 0092 DD 1D 00000000              FSTP QWORD PTR _energy

; 64:   do

00008: 0098                     L0001:

; 66:       if(!t_is_open)

00008: 0098 83 3D 00000000 00           CMP DWORD PTR _t_is_open, 00000000
00008: 009F 75 0D                       JNE L0002

; 67: 	printf("I am not saving text\n");

00008: 00A1 68 00000000                 PUSH OFFSET @86
00008: 00A6 E8 00000000                 CALL SHORT _printf
00008: 00AB 59                          POP ECX
00008: 00AC EB 35                       JMP L0003
00008: 00AE                     L0002:

; 70: 	  printf("I am saving text to the file\n");

00008: 00AE 68 00000000                 PUSH OFFSET @87
00008: 00B3 E8 00000000                 CALL SHORT _printf
00008: 00B8 59                          POP ECX

; 71: 	  printf("%s\n",text_name);

00008: 00B9 68 00000000                 PUSH OFFSET _text_name
00008: 00BE 68 00000000                 PUSH OFFSET @88
00008: 00C3 E8 00000000                 CALL SHORT _printf
00008: 00C8 59                          POP ECX
00008: 00C9 59                          POP ECX

; 72: 	  printf("Text update rate=%lf \n",rate);

00008: 00CA FF 35 00000004              PUSH DWORD PTR _rate+00000004
00008: 00D0 FF 35 00000000              PUSH DWORD PTR _rate
00008: 00D6 68 00000000                 PUSH OFFSET @89
00008: 00DB E8 00000000                 CALL SHORT _printf
00008: 00E0 83 C4 0C                    ADD ESP, 0000000C

; 73: 	}

00008: 00E3                     L0003:

; 74:       if(!is_open)

00008: 00E3 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 00EA 75 0D                       JNE L0004

; 75: 	printf("I am not saving data\n");

00008: 00EC 68 00000000                 PUSH OFFSET @90
00008: 00F1 E8 00000000                 CALL SHORT _printf
00008: 00F6 59                          POP ECX
00008: 00F7 EB 35                       JMP L0005
00008: 00F9                     L0004:

; 78: 	  printf("I am saving data to the file\n");

00008: 00F9 68 00000000                 PUSH OFFSET @91
00008: 00FE E8 00000000                 CALL SHORT _printf
00008: 0103 59                          POP ECX

; 79: 	  printf("%s\n",echo_name);

00008: 0104 68 00000000                 PUSH OFFSET _echo_name
00008: 0109 68 00000000                 PUSH OFFSET @88
00008: 010E E8 00000000                 CALL SHORT _printf
00008: 0113 59                          POP ECX
00008: 0114 59                          POP ECX

; 80: 	  printf("File update rate=%lf \n",frate);

00008: 0115 FF 35 00000004              PUSH DWORD PTR _frate+00000004
00008: 011B FF 35 00000000              PUSH DWORD PTR _frate
00008: 0121 68 00000000                 PUSH OFFSET @92
00008: 0126 E8 00000000                 CALL SHORT _printf
00008: 012B 83 C4 0C                    ADD ESP, 0000000C

; 81: 	}

00008: 012E                     L0005:

; 83:       if(!m_is_open)

00008: 012E 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 0135 75 0D                       JNE L0006

; 84: 	printf("I am not saving movie\n");

00008: 0137 68 00000000                 PUSH OFFSET @93
00008: 013C E8 00000000                 CALL SHORT _printf
00008: 0141 59                          POP ECX
00008: 0142 EB 35                       JMP L0007
00008: 0144                     L0006:

; 87: 	  printf("I am saving movie to the file\n");

00008: 0144 68 00000000                 PUSH OFFSET @94
00008: 0149 E8 00000000                 CALL SHORT _printf
00008: 014E 59                          POP ECX

; 88: 	  printf("%s\n",movie_name);

00008: 014F 68 00000000                 PUSH OFFSET _movie_name
00008: 0154 68 00000000                 PUSH OFFSET @88
00008: 0159 E8 00000000                 CALL SHORT _printf
00008: 015E 59                          POP ECX
00008: 015F 59                          POP ECX

; 89: 	  printf("Movie update rate=%lf \n",mfrate);

00008: 0160 FF 35 00000004              PUSH DWORD PTR _mfrate+00000004
00008: 0166 FF 35 00000000              PUSH DWORD PTR _mfrate
00008: 016C 68 00000000                 PUSH OFFSET @95
00008: 0171 E8 00000000                 CALL SHORT _printf
00008: 0176 83 C4 0C                    ADD ESP, 0000000C

; 90: 	}

00008: 0179                     L0007:

; 91:       printf("Simulation time=%lf \n",time);

00008: 0179 FF 35 00000004              PUSH DWORD PTR _time+00000004
00008: 017F FF 35 00000000              PUSH DWORD PTR _time
00008: 0185 68 00000000                 PUSH OFFSET @96
00008: 018A E8 00000000                 CALL SHORT _printf
00008: 018F 83 C4 0C                    ADD ESP, 0000000C

; 92:       printf("Instant Temperature=%lf \n",temp);

00008: 0192 FF 35 00000004              PUSH DWORD PTR _temp+00000004
00008: 0198 FF 35 00000000              PUSH DWORD PTR _temp
00008: 019E 68 00000000                 PUSH OFFSET @97
00008: 01A3 E8 00000000                 CALL SHORT _printf
00008: 01A8 83 C4 0C                    ADD ESP, 0000000C

; 93:       printf("Instant Potential energy=%lf \n",energy);

00008: 01AB FF 35 00000004              PUSH DWORD PTR _energy+00000004
00008: 01B1 FF 35 00000000              PUSH DWORD PTR _energy
00008: 01B7 68 00000000                 PUSH OFFSET @98
00008: 01BC E8 00000000                 CALL SHORT _printf
00008: 01C1 83 C4 0C                    ADD ESP, 0000000C

; 94:       printf("Largest molecule radius=%lf \n",gr);

00008: 01C4 FF 35 00000004              PUSH DWORD PTR _gr+00000004
00008: 01CA FF 35 00000000              PUSH DWORD PTR _gr
00008: 01D0 68 00000000                 PUSH OFFSET @99
00008: 01D5 E8 00000000                 CALL SHORT _printf
00008: 01DA 83 C4 0C                    ADD ESP, 0000000C

; 97:       printf("Termal coefficient=%lf \n",coeff);

00008: 01DD FF 35 00000004              PUSH DWORD PTR _coeff+00000004
00008: 01E3 FF 35 00000000              PUSH DWORD PTR _coeff
00008: 01E9 68 00000000                 PUSH OFFSET @100
00008: 01EE E8 00000000                 CALL SHORT _printf
00008: 01F3 83 C4 0C                    ADD ESP, 0000000C

; 98:       if(coeff)printf("Temperature limit=%lf \n",temp_limit);

00008: 01F6 DD 05 00000000              FLD QWORD PTR _coeff
00007: 01FC DD 05 00000000              FLD QWORD PTR .data+000001a8
00006: 0202 F1DF                        FCOMIP ST, ST(1), L0008
00007: 0204 DD D8                       FSTP ST
00008: 0206 7A 02                       JP L0024
00008: 0208 74 19                       JE L0008
00008: 020A                     L0024:
00008: 020A FF 35 00000004              PUSH DWORD PTR _temp_limit+00000004
00008: 0210 FF 35 00000000              PUSH DWORD PTR _temp_limit
00008: 0216 68 00000000                 PUSH OFFSET @101
00008: 021B E8 00000000                 CALL SHORT _printf
00008: 0220 83 C4 0C                    ADD ESP, 0000000C
00008: 0223                     L0008:

; 99:       reply=yes();

00008: 0223 E8 00000000                 CALL SHORT _yes
00008: 0228 89 45 FFFFFFE8              MOV DWORD PTR FFFFFFE8[EBP], EAX

; 100:       if(!reply)

00008: 022B 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 022F 0F 85 0000036D              JNE L0009

; 103: 	  if(!t_is_open)

00008: 0235 83 3D 00000000 00           CMP DWORD PTR _t_is_open, 00000000
00008: 023C 75 0D                       JNE L000A

; 104: 	    printf("I am not saving text\n");

00008: 023E 68 00000000                 PUSH OFFSET @86
00008: 0243 E8 00000000                 CALL SHORT _printf
00008: 0248 59                          POP ECX
00008: 0249 EB 1C                       JMP L000B
00008: 024B                     L000A:

; 107: 	      printf("I am saving text to the file\n");

00008: 024B 68 00000000                 PUSH OFFSET @87
00008: 0250 E8 00000000                 CALL SHORT _printf
00008: 0255 59                          POP ECX

; 108: 	      printf("%s\n",text_name);

00008: 0256 68 00000000                 PUSH OFFSET _text_name
00008: 025B 68 00000000                 PUSH OFFSET @88
00008: 0260 E8 00000000                 CALL SHORT _printf
00008: 0265 59                          POP ECX
00008: 0266 59                          POP ECX

; 109: 	    }

00008: 0267                     L000B:

; 110: 	  if(!yes())t_is_open=set_text_name(t_is_open,text_name);

00008: 0267 E8 00000000                 CALL SHORT _yes
00008: 026C 83 F8 00                    CMP EAX, 00000000
00008: 026F 75 17                       JNE L000C
00008: 0271 68 00000000                 PUSH OFFSET _text_name
00008: 0276 A1 00000000                 MOV EAX, DWORD PTR _t_is_open
00008: 027B 50                          PUSH EAX
00008: 027C E8 00000000                 CALL SHORT _set_text_name
00008: 0281 59                          POP ECX
00008: 0282 59                          POP ECX
00008: 0283 A3 00000000                 MOV DWORD PTR _t_is_open, EAX
00008: 0288                     L000C:

; 111: 	  if(t_is_open)

00008: 0288 83 3D 00000000 00           CMP DWORD PTR _t_is_open, 00000000
00008: 028F 74 3F                       JE L000D

; 113: 	      printf("Text update rate=%lf \n",rate);

00008: 0291 FF 35 00000004              PUSH DWORD PTR _rate+00000004
00008: 0297 FF 35 00000000              PUSH DWORD PTR _rate
00008: 029D 68 00000000                 PUSH OFFSET @89
00008: 02A2 E8 00000000                 CALL SHORT _printf
00008: 02A7 83 C4 0C                    ADD ESP, 0000000C

; 114: 	      if(!yes())

00008: 02AA E8 00000000                 CALL SHORT _yes
00008: 02AF 83 F8 00                    CMP EAX, 00000000
00008: 02B2 75 1C                       JNE L000E

; 116: 		  printf("What is new rate ?\n");

00008: 02B4 68 00000000                 PUSH OFFSET @102
00008: 02B9 E8 00000000                 CALL SHORT _printf
00008: 02BE 59                          POP ECX

; 117: 		  scanf("%lf",&rate);

00008: 02BF 68 00000000                 PUSH OFFSET _rate
00008: 02C4 68 00000000                 PUSH OFFSET @103
00008: 02C9 E8 00000000                 CALL SHORT _scanf
00008: 02CE 59                          POP ECX
00008: 02CF 59                          POP ECX

; 118: 		}

00008: 02D0                     L000E:

; 119: 	    }

00008: 02D0                     L000D:

; 121: 	  if(!is_open)

00008: 02D0 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 02D7 75 0D                       JNE L000F

; 122: 	    printf("I am not saving data\n");

00008: 02D9 68 00000000                 PUSH OFFSET @90
00008: 02DE E8 00000000                 CALL SHORT _printf
00008: 02E3 59                          POP ECX
00008: 02E4 EB 1C                       JMP L0010
00008: 02E6                     L000F:

; 125: 	      printf("I am saving data to the file\n");

00008: 02E6 68 00000000                 PUSH OFFSET @91
00008: 02EB E8 00000000                 CALL SHORT _printf
00008: 02F0 59                          POP ECX

; 126: 	      printf("%s\n",echo_name);

00008: 02F1 68 00000000                 PUSH OFFSET _echo_name
00008: 02F6 68 00000000                 PUSH OFFSET @88
00008: 02FB E8 00000000                 CALL SHORT _printf
00008: 0300 59                          POP ECX
00008: 0301 59                          POP ECX

; 127: 	    }

00008: 0302                     L0010:

; 128: 	  if(!yes())is_open=open_echo_file(is_open,echo_name);

00008: 0302 E8 00000000                 CALL SHORT _yes
00008: 0307 83 F8 00                    CMP EAX, 00000000
00008: 030A 75 17                       JNE L0011
00008: 030C 68 00000000                 PUSH OFFSET _echo_name
00008: 0311 A1 00000000                 MOV EAX, DWORD PTR _is_open
00008: 0316 50                          PUSH EAX
00008: 0317 E8 00000000                 CALL SHORT _open_echo_file
00008: 031C 59                          POP ECX
00008: 031D 59                          POP ECX
00008: 031E A3 00000000                 MOV DWORD PTR _is_open, EAX
00008: 0323                     L0011:

; 129: 	  if(is_open)

00008: 0323 83 3D 00000000 00           CMP DWORD PTR _is_open, 00000000
00008: 032A 74 3F                       JE L0012

; 131: 	      printf("File update rate=%lf \n",frate);

00008: 032C FF 35 00000004              PUSH DWORD PTR _frate+00000004
00008: 0332 FF 35 00000000              PUSH DWORD PTR _frate
00008: 0338 68 00000000                 PUSH OFFSET @92
00008: 033D E8 00000000                 CALL SHORT _printf
00008: 0342 83 C4 0C                    ADD ESP, 0000000C

; 132: 	      if(!yes())

00008: 0345 E8 00000000                 CALL SHORT _yes
00008: 034A 83 F8 00                    CMP EAX, 00000000
00008: 034D 75 1C                       JNE L0013

; 134: 		  printf("What is new rate ?\n");

00008: 034F 68 00000000                 PUSH OFFSET @102
00008: 0354 E8 00000000                 CALL SHORT _printf
00008: 0359 59                          POP ECX

; 135: 		  scanf("%lf",&frate);

00008: 035A 68 00000000                 PUSH OFFSET _frate
00008: 035F 68 00000000                 PUSH OFFSET @103
00008: 0364 E8 00000000                 CALL SHORT _scanf
00008: 0369 59                          POP ECX
00008: 036A 59                          POP ECX

; 136: 		}

00008: 036B                     L0013:

; 137: 	    }

00008: 036B                     L0012:

; 139: 	  if(!m_is_open)

00008: 036B 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 0372 75 0D                       JNE L0014

; 140: 	    printf("I am not saving movie\n");

00008: 0374 68 00000000                 PUSH OFFSET @93
00008: 0379 E8 00000000                 CALL SHORT _printf
00008: 037E 59                          POP ECX
00008: 037F EB 1C                       JMP L0015
00008: 0381                     L0014:

; 143: 	      printf("I am saving movie to the file\n");

00008: 0381 68 00000000                 PUSH OFFSET @94
00008: 0386 E8 00000000                 CALL SHORT _printf
00008: 038B 59                          POP ECX

; 144: 	      printf("%s\n",movie_name);

00008: 038C 68 00000000                 PUSH OFFSET _movie_name
00008: 0391 68 00000000                 PUSH OFFSET @88
00008: 0396 E8 00000000                 CALL SHORT _printf
00008: 039B 59                          POP ECX
00008: 039C 59                          POP ECX

; 145: 	    }

00008: 039D                     L0015:

; 146:           must_open=0;

00008: 039D C7 45 FFFFFFEC 00000000     MOV DWORD PTR FFFFFFEC[EBP], 00000000

; 147: 	  if(!yes())must_open=1;

00008: 03A4 E8 00000000                 CALL SHORT _yes
00008: 03A9 83 F8 00                    CMP EAX, 00000000
00008: 03AC 75 07                       JNE L0016
00008: 03AE C7 45 FFFFFFEC 00000001     MOV DWORD PTR FFFFFFEC[EBP], 00000001
00008: 03B5                     L0016:

; 148: 	  if(m_is_open||must_open)

00008: 03B5 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 03BC 75 06                       JNE L0017
00008: 03BE 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 03C2 74 79                       JE L0018
00008: 03C4                     L0017:

; 150: 	      printf("Movie update rate=%lf \n",mfrate);

00008: 03C4 FF 35 00000004              PUSH DWORD PTR _mfrate+00000004
00008: 03CA FF 35 00000000              PUSH DWORD PTR _mfrate
00008: 03D0 68 00000000                 PUSH OFFSET @95
00008: 03D5 E8 00000000                 CALL SHORT _printf
00008: 03DA 83 C4 0C                    ADD ESP, 0000000C

; 151: 	      if(!yes())

00008: 03DD E8 00000000                 CALL SHORT _yes
00008: 03E2 83 F8 00                    CMP EAX, 00000000
00008: 03E5 75 56                       JNE L0019

; 153: 		  printf("What is new rate ?\n");

00008: 03E7 68 00000000                 PUSH OFFSET @102
00008: 03EC E8 00000000                 CALL SHORT _printf
00008: 03F1 59                          POP ECX

; 154: 		  scanf("%lf",&mfrate);

00008: 03F2 68 00000000                 PUSH OFFSET _mfrate
00008: 03F7 68 00000000                 PUSH OFFSET @103
00008: 03FC E8 00000000                 CALL SHORT _scanf
00008: 0401 59                          POP ECX
00008: 0402 59                          POP ECX

; 155: 		  set_mfrate(mfrate);

00008: 0403 FF 35 00000004              PUSH DWORD PTR _mfrate+00000004
00008: 0409 FF 35 00000000              PUSH DWORD PTR _mfrate
00008: 040F E8 00000000                 CALL SHORT _set_mfrate
00008: 0414 59                          POP ECX
00008: 0415 59                          POP ECX

; 156:                   must_open=1;

00008: 0416 C7 45 FFFFFFEC 00000001     MOV DWORD PTR FFFFFFEC[EBP], 00000001

; 157: 		  if(m_is_open)m_is_open=open_movie_file(m_is_open,movie_name);

00008: 041D 83 3D 00000000 00           CMP DWORD PTR _m_is_open, 00000000
00008: 0424 74 17                       JE L001A
00008: 0426 68 00000000                 PUSH OFFSET _movie_name
00008: 042B A1 00000000                 MOV EAX, DWORD PTR _m_is_open
00008: 0430 50                          PUSH EAX
00008: 0431 E8 00000000                 CALL SHORT _open_movie_file
00008: 0436 59                          POP ECX
00008: 0437 59                          POP ECX
00008: 0438 A3 00000000                 MOV DWORD PTR _m_is_open, EAX
00008: 043D                     L001A:

; 158: 		}

00008: 043D                     L0019:

; 159: 	    }

00008: 043D                     L0018:

; 160: 	  if(must_open)m_is_open=open_movie_file(m_is_open,movie_name);

00008: 043D 83 7D FFFFFFEC 00           CMP DWORD PTR FFFFFFEC[EBP], 00000000
00008: 0441 74 17                       JE L001B
00008: 0443 68 00000000                 PUSH OFFSET _movie_name
00008: 0448 A1 00000000                 MOV EAX, DWORD PTR _m_is_open
00008: 044D 50                          PUSH EAX
00008: 044E E8 00000000                 CALL SHORT _open_movie_file
00008: 0453 59                          POP ECX
00008: 0454 59                          POP ECX
00008: 0455 A3 00000000                 MOV DWORD PTR _m_is_open, EAX
00008: 045A                     L001B:

; 162: 	  printf("Simulation time=%lf \n",time);

00008: 045A FF 35 00000004              PUSH DWORD PTR _time+00000004
00008: 0460 FF 35 00000000              PUSH DWORD PTR _time
00008: 0466 68 00000000                 PUSH OFFSET @96
00008: 046B E8 00000000                 CALL SHORT _printf
00008: 0470 83 C4 0C                    ADD ESP, 0000000C

; 163: 	  if(!yes())

00008: 0473 E8 00000000                 CALL SHORT _yes
00008: 0478 83 F8 00                    CMP EAX, 00000000
00008: 047B 75 1C                       JNE L001C

; 165: 	      printf("What is new time ?\n");

00008: 047D 68 00000000                 PUSH OFFSET @104
00008: 0482 E8 00000000                 CALL SHORT _printf
00008: 0487 59                          POP ECX

; 166: 	      scanf("%lf",&time);

00008: 0488 68 00000000                 PUSH OFFSET _time
00008: 048D 68 00000000                 PUSH OFFSET @103
00008: 0492 E8 00000000                 CALL SHORT _scanf
00008: 0497 59                          POP ECX
00008: 0498 59                          POP ECX

; 167: 	    }

00008: 0499                     L001C:

; 169: 	  printf("Temperature=%lf \n",temp);

00008: 0499 FF 35 00000004              PUSH DWORD PTR _temp+00000004
00008: 049F FF 35 00000000              PUSH DWORD PTR _temp
00008: 04A5 68 00000000                 PUSH OFFSET @105
00008: 04AA E8 00000000                 CALL SHORT _printf
00008: 04AF 83 C4 0C                    ADD ESP, 0000000C

; 170: 	  if(!yes())

00008: 04B2 E8 00000000                 CALL SHORT _yes
00008: 04B7 83 F8 00                    CMP EAX, 00000000
00008: 04BA 75 1C                       JNE L001D

; 172: 	      printf("What is new temperature ?\n");

00008: 04BC 68 00000000                 PUSH OFFSET @106
00008: 04C1 E8 00000000                 CALL SHORT _printf
00008: 04C6 59                          POP ECX

; 173: 	      scanf("%lf",&temp);

00008: 04C7 68 00000000                 PUSH OFFSET _temp
00008: 04CC 68 00000000                 PUSH OFFSET @103
00008: 04D1 E8 00000000                 CALL SHORT _scanf
00008: 04D6 59                          POP ECX
00008: 04D7 59                          POP ECX

; 174: 	    }

00008: 04D8                     L001D:

; 176: 	  printf("Termal coefficient=%lf \n",coeff);

00008: 04D8 FF 35 00000004              PUSH DWORD PTR _coeff+00000004
00008: 04DE FF 35 00000000              PUSH DWORD PTR _coeff
00008: 04E4 68 00000000                 PUSH OFFSET @100
00008: 04E9 E8 00000000                 CALL SHORT _printf
00008: 04EE 83 C4 0C                    ADD ESP, 0000000C

; 177: 	  if(!yes())

00008: 04F1 E8 00000000                 CALL SHORT _yes
00008: 04F6 83 F8 00                    CMP EAX, 00000000
00008: 04F9 75 1C                       JNE L001E

; 179: 	      printf("What is new coeff. ?\n");

00008: 04FB 68 00000000                 PUSH OFFSET @107
00008: 0500 E8 00000000                 CALL SHORT _printf
00008: 0505 59                          POP ECX

; 180: 	      scanf("%lf",&coeff);

00008: 0506 68 00000000                 PUSH OFFSET _coeff
00008: 050B 68 00000000                 PUSH OFFSET @103
00008: 0510 E8 00000000                 CALL SHORT _scanf
00008: 0515 59                          POP ECX
00008: 0516 59                          POP ECX

; 181: 	    }

00008: 0517                     L001E:

; 182: 	  if(coeff)

00008: 0517 DD 05 00000000              FLD QWORD PTR _coeff
00007: 051D DD 05 00000000              FLD QWORD PTR .data+000001a8
00006: 0523 F1DF                        FCOMIP ST, ST(1), L001F
00007: 0525 DD D8                       FSTP ST
00008: 0527 7A 02                       JP L0025
00008: 0529 74 77                       JE L001F
00008: 052B                     L0025:

; 184: 	      printf("Limiting Temperature=%lf \n",temp_limit);

00008: 052B FF 35 00000004              PUSH DWORD PTR _temp_limit+00000004
00008: 0531 FF 35 00000000              PUSH DWORD PTR _temp_limit
00008: 0537 68 00000000                 PUSH OFFSET @108
00008: 053C E8 00000000                 CALL SHORT _printf
00008: 0541 83 C4 0C                    ADD ESP, 0000000C

; 185: 	      if(!yes())

00008: 0544 E8 00000000                 CALL SHORT _yes
00008: 0549 83 F8 00                    CMP EAX, 00000000
00008: 054C 75 1C                       JNE L0020

; 187: 		  printf("What is Lim. Temp. ?\n");

00008: 054E 68 00000000                 PUSH OFFSET @109
00008: 0553 E8 00000000                 CALL SHORT _printf
00008: 0558 59                          POP ECX

; 188: 		  scanf("%lf",&temp_limit);

00008: 0559 68 00000000                 PUSH OFFSET _temp_limit
00008: 055E 68 00000000                 PUSH OFFSET @103
00008: 0563 E8 00000000                 CALL SHORT _scanf
00008: 0568 59                          POP ECX
00008: 0569 59                          POP ECX

; 189: 		}

00008: 056A                     L0020:

; 190: 	      printf("delta_ll=%ld \n",deltall);

00008: 056A A1 00000000                 MOV EAX, DWORD PTR _deltall
00008: 056F 50                          PUSH EAX
00008: 0570 68 00000000                 PUSH OFFSET @110
00008: 0575 E8 00000000                 CALL SHORT _printf
00008: 057A 59                          POP ECX
00008: 057B 59                          POP ECX

; 191: 	      if(!yes())

00008: 057C E8 00000000                 CALL SHORT _yes
00008: 0581 83 F8 00                    CMP EAX, 00000000
00008: 0584 75 1C                       JNE L0021

; 193: 		  printf("What is delta ll ?\n");

00008: 0586 68 00000000                 PUSH OFFSET @111
00008: 058B E8 00000000                 CALL SHORT _printf
00008: 0590 59                          POP ECX

; 194: 		  scanf("%ld",&deltall);

00008: 0591 68 00000000                 PUSH OFFSET _deltall
00008: 0596 68 00000000                 PUSH OFFSET @112
00008: 059B E8 00000000                 CALL SHORT _scanf
00008: 05A0 59                          POP ECX
00008: 05A1 59                          POP ECX

; 195: 		}

00008: 05A2                     L0021:

; 196: 	    }

00008: 05A2                     L001F:

; 197: 	}

00008: 05A2                     L0009:

; 198:     }

00008: 05A2 83 7D FFFFFFE8 00           CMP DWORD PTR FFFFFFE8[EBP], 00000000
00008: 05A6 0F 84 FFFFFAEC              JE L0001

; 201:   set_rate(rate);

00008: 05AC FF 35 00000004              PUSH DWORD PTR _rate+00000004
00008: 05B2 FF 35 00000000              PUSH DWORD PTR _rate
00008: 05B8 E8 00000000                 CALL SHORT _set_rate
00008: 05BD 59                          POP ECX
00008: 05BE 59                          POP ECX

; 202:   if(old_temp!=temp)set_temp(temp);

00008: 05BF DD 45 FFFFFFF0              FLD QWORD PTR FFFFFFF0[EBP]
00007: 05C2 DD 05 00000000              FLD QWORD PTR _temp
00006: 05C8 F1DF                        FCOMIP ST, ST(1), L0022
00007: 05CA DD D8                       FSTP ST
00008: 05CC 7A 02                       JP L0026
00008: 05CE 74 13                       JE L0022
00008: 05D0                     L0026:
00008: 05D0 FF 35 00000004              PUSH DWORD PTR _temp+00000004
00008: 05D6 FF 35 00000000              PUSH DWORD PTR _temp
00008: 05DC E8 00000000                 CALL SHORT _set_temp
00008: 05E1 59                          POP ECX
00008: 05E2 59                          POP ECX
00008: 05E3                     L0022:

; 203:   set_frate(frate);

00008: 05E3 FF 35 00000004              PUSH DWORD PTR _frate+00000004
00008: 05E9 FF 35 00000000              PUSH DWORD PTR _frate
00008: 05EF E8 00000000                 CALL SHORT _set_frate
00008: 05F4 59                          POP ECX
00008: 05F5 59                          POP ECX

; 204:   set_time(time);

00008: 05F6 FF 35 00000004              PUSH DWORD PTR _time+00000004
00008: 05FC FF 35 00000000              PUSH DWORD PTR _time
00008: 0602 E8 00000000                 CALL SHORT _set_time
00008: 0607 59                          POP ECX
00008: 0608 59                          POP ECX

; 205:   set_coeff(coeff);

00008: 0609 FF 35 00000004              PUSH DWORD PTR _coeff+00000004
00008: 060F FF 35 00000000              PUSH DWORD PTR _coeff
00008: 0615 E8 00000000                 CALL SHORT _set_coeff
00008: 061A 59                          POP ECX
00008: 061B 59                          POP ECX

; 206:   if (coeff)

00008: 061C DD 05 00000000              FLD QWORD PTR _coeff
00007: 0622 DD 05 00000000              FLD QWORD PTR .data+000001a8
00006: 0628 F1DF                        FCOMIP ST, ST(1), L0023
00007: 062A DD D8                       FSTP ST
00008: 062C 7A 02                       JP L0027
00008: 062E 74 1F                       JE L0023
00008: 0630                     L0027:

; 208:       set_temp_limit(temp_limit);

00008: 0630 FF 35 00000004              PUSH DWORD PTR _temp_limit+00000004
00008: 0636 FF 35 00000000              PUSH DWORD PTR _temp_limit
00008: 063C E8 00000000                 CALL SHORT _set_temp_limit
00008: 0641 59                          POP ECX
00008: 0642 59                          POP ECX

; 209:       set_delta_ll(deltall);

00008: 0643 A1 00000000                 MOV EAX, DWORD PTR _deltall
00008: 0648 50                          PUSH EAX
00008: 0649 E8 00000000                 CALL SHORT _set_delta_ll
00008: 064E 59                          POP ECX

; 210:     }  

00008: 064F                     L0023:

; 213:     printf("What is maxtime?\n");

00008: 064F 68 00000000                 PUSH OFFSET @113
00008: 0654 E8 00000000                 CALL SHORT _printf
00008: 0659 59                          POP ECX

; 214:     scanf("%lf",&maxtime);

00008: 065A 8D 45 FFFFFFF8              LEA EAX, DWORD PTR FFFFFFF8[EBP]
00008: 065D 50                          PUSH EAX
00008: 065E 68 00000000                 PUSH OFFSET @103
00008: 0663 E8 00000000                 CALL SHORT _scanf
00008: 0668 59                          POP ECX
00008: 0669 59                          POP ECX

; 215:     return maxtime;

00008: 066A DD 45 FFFFFFF8              FLD QWORD PTR FFFFFFF8[EBP]
00000: 066D                     L0000:
00000: 066D                             epilog 
00000: 066D C9                          LEAVE 
00000: 066E C3                          RETN 

Function: _too_close_dialog

; 222: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 223:   printf("Atoms %d and %d are too close\n",i+1,j+1);

00008: 0003 8B 45 0C                    MOV EAX, DWORD PTR 0000000C[EBP]
00008: 0006 40                          INC EAX
00008: 0007 50                          PUSH EAX
00008: 0008 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 000B 40                          INC EAX
00008: 000C 50                          PUSH EAX
00008: 000D 68 00000000                 PUSH OFFSET @118
00008: 0012 E8 00000000                 CALL SHORT _printf
00008: 0017 83 C4 0C                    ADD ESP, 0000000C

; 224:   return;

00000: 001A                     L0000:
00000: 001A                             epilog 
00000: 001A C9                          LEAVE 
00000: 001B C3                          RETN 

Function: _text_error_dialog

; 228: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 229:   printf("Wrong format at line %ld\n",i);

00008: 0003 8B 45 08                    MOV EAX, DWORD PTR 00000008[EBP]
00008: 0006 50                          PUSH EAX
00008: 0007 68 00000000                 PUSH OFFSET @123
00008: 000C E8 00000000                 CALL SHORT _printf
00008: 0011 59                          POP ECX
00008: 0012 59                          POP ECX

; 230:   return;

00000: 0013                     L0000:
00000: 0013                             epilog 
00000: 0013 C9                          LEAVE 
00000: 0014 C3                          RETN 

Function: _StopAlert

; 233: {

00000: 0000 55                          PUSH EBP
00000: 0001 89 E5                       MOV EBP, ESP
00000: 0003                             prolog 

; 234:   switch (i)

00008: 0003 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0006 8B 55 08                    MOV EDX, DWORD PTR 00000008[EBP]
00008: 0009 4A                          DEC EDX
00008: 000A 83 FA 03                    CMP EDX, 00000003
00008: 000D 77 39                       JA L0001
00008: 000F FF 24 95 00000000           JMP DWORD PTR @133[EDX*4], 03827078
00008: 0016                     L0002:

; 237:       printf("File has wrong format\n");

00008: 0016 68 00000000                 PUSH OFFSET @134
00008: 001B E8 00000000                 CALL SHORT _printf
00008: 0020 59                          POP ECX

; 238:       break;

00008: 0021 EB 25                       JMP L0001
00008: 0023                     L0003:

; 240:       printf("Not enough memory\n");

00008: 0023 68 00000000                 PUSH OFFSET @135
00008: 0028 E8 00000000                 CALL SHORT _printf
00008: 002D 59                          POP ECX

; 241:       break;

00008: 002E EB 18                       JMP L0001
00008: 0030                     L0004:

; 243:       printf("Temperature should be positive\n");

00008: 0030 68 00000000                 PUSH OFFSET @136
00008: 0035 E8 00000000                 CALL SHORT _printf
00008: 003A 59                          POP ECX

; 244:       break;

00008: 003B EB 0B                       JMP L0001
00008: 003D                     L0005:

; 246:       printf("Wrong value\n");

00008: 003D 68 00000000                 PUSH OFFSET @137
00008: 0042 E8 00000000                 CALL SHORT _printf
00008: 0047 59                          POP ECX

; 248:     }

00008: 0048                     L0001:

; 249: }

00000: 0048                     L0000:
00000: 0048                             epilog 
00000: 0048 C9                          LEAVE 
00000: 0049 C3                          RETN 
