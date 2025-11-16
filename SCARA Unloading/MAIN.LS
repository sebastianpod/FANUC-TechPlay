/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 7827;
CREATE		= DATE 25-11-16  TIME 19:57:56;
MODIFIED	= DATE 25-11-16  TIME 19:57:56;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 219;
MEMORY_SIZE	= 8247;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !FANUC America Corp. ;
   2:  !ROBOGUIDE Generated This TPP ;
   3:  !Run SimPRO.cf to setup frame and ;
   4:  UTOOL_NUM[GP1]=1 ;
   5:  UFRAME_NUM[GP1]=1 ;
   6:  LBL[999] ;
   7:J P[1] 100% CNT100    ;
   8:  IF DO[1:LEFT TRAY 1]=ON,JMP LBL[101] ;
   9:  IF DO[1:LEFT TRAY 1]=OFF,JMP LBL[102] ;
  10:  LBL[101] ;
  11:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  12:  CALL PROG_OFFSET    ;
  13:  UTOOL_NUM[GP1]=1 ;
  14:  UFRAME_NUM[GP1]=1 ;
  15:J P[2] 100% CNT100    ;
  16:  WAIT    .10(sec) ;
  17:  CALL PROG_VIS    ;
  18:  UTOOL_NUM[GP1]=1 ;
  19:  UFRAME_NUM[GP1]=1 ;
  20:L P[3] 2000mm/sec FINE VOFFSET,VR[1]    ;
  21:  ! Pickup ('5050008') From ('Rotat ;
  22:  !WAIT 0.00 (sec) ;
  23:L P[4] 3500mm/sec FINE VOFFSET,VR[1]    ;
  24:  ! MoveTo-Drop ('5050008') From (' ;
  25:J P[5] 100% FINE Offset,PR[1]    ;
  26:J P[6] 100% FINE Offset,PR[1]    ;
  27:  ! Drop ('5050008') From ('GP: 1 - ;
  28:  !WAIT 0.00 (sec) ;
  29:J P[7] 100% CNT100 Offset,PR[1]    ;
  30:  ENDFOR ;
  31:  DO[1:LEFT TRAY 1]=OFF ;
  32:  LBL[102] ;
  33:  IF DO[2:LEFT TRAY 2]=ON,JMP LBL[202] ;
  34:  IF DO[2:LEFT TRAY 2]=OFF,JMP LBL[203] ;
  35:  LBL[202] ;
  36:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  37:  CALL PROG_OFFSET    ;
  38:  UTOOL_NUM[GP1]=1 ;
  39:  UFRAME_NUM[GP1]=1 ;
  40:J P[8] 100% CNT100    ;
  41:  WAIT    .10(sec) ;
  42:  CALL PROG_VIS    ;
  43:  UTOOL_NUM[GP1]=1 ;
  44:  UFRAME_NUM[GP1]=1 ;
  45:  ! MoveTo-Pickup ('5050008') From  ;
  46:J P[9] 100% FINE VOFFSET,VR[1]    ;
  47:L P[10] 3500mm/sec FINE ACC90 VOFFSET,VR[1]    ;
  48:  ! Pickup ('5050008') From ('Rotat ;
  49:  !WAIT 0.00 (sec) ;
  50:L P[11] 3500mm/sec FINE VOFFSET,VR[1]    ;
  51:  ! MoveTo-Drop ('5050008') From (' ;
  52:J P[12] 100% FINE Offset,PR[1]    ;
  53:L P[13] 3500mm/sec FINE Offset,PR[1]    ;
  54:  ! Drop ('5050008') From ('GP: 1 - ;
  55:  !WAIT 0.00 (sec) ;
  56:L P[14] 3500mm/sec FINE Offset,PR[1]    ;
  57:  ENDFOR ;
  58:  DO[2:LEFT TRAY 2]=OFF ;
  59:  LBL[203] ;
  60:  IF DO[3:LEFT TRAY 3]=ON,JMP LBL[303] ;
  61:  IF DO[3:LEFT TRAY 3]=OFF,JMP LBL[304] ;
  62:  LBL[303] ;
  63:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  64:  CALL PROG_OFFSET    ;
  65:  UTOOL_NUM[GP1]=1 ;
  66:  UFRAME_NUM[GP1]=1 ;
  67:J P[15] 100% CNT100    ;
  68:  WAIT    .10(sec) ;
  69:  CALL PROG_VIS    ;
  70:  UTOOL_NUM[GP1]=1 ;
  71:  UFRAME_NUM[GP1]=1 ;
  72:  ! MoveTo-Pickup ('5050008') From  ;
  73:J P[16] 100% CNT100 VOFFSET,VR[1]    ;
  74:L P[17] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
  75:  ! Pickup ('5050008') From ('Rotat ;
  76:  !WAIT 0.00 (sec) ;
  77:J P[18] 100% CNT100 VOFFSET,VR[1]    ;
  78:  ! MoveTo-Drop ('5050008') From (' ;
  79:J P[19] 100% FINE Offset,PR[1]    ;
  80:L P[20] 3500mm/sec CNT100 Offset,PR[1]    ;
  81:  ! Drop ('5050008') From ('GP: 1 - ;
  82:  !WAIT 0.00 (sec) ;
  83:J P[21] 100% CNT100 Offset,PR[1]    ;
  84:  ENDFOR ;
  85:  DO[3:LEFT TRAY 3]=OFF ;
  86:  LBL[304] ;
  87:  IF DO[4:LEFT TRAY 4]=ON,JMP LBL[404] ;
  88:  IF DO[4:LEFT TRAY 4]=OFF,JMP LBL[99] ;
  89:  LBL[404] ;
  90:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  91:  CALL PROG_OFFSET    ;
  92:  UTOOL_NUM[GP1]=1 ;
  93:  UFRAME_NUM[GP1]=1 ;
  94:J P[22] 100% CNT100    ;
  95:  WAIT    .10(sec) ;
  96:  CALL PROG_VIS    ;
  97:  UTOOL_NUM[GP1]=1 ;
  98:  UFRAME_NUM[GP1]=1 ;
  99:  ! MoveTo-Pickup ('5050008') From  ;
 100:J P[23] 100% CNT100 VOFFSET,VR[1]    ;
 101:L P[24] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 102:  ! Pickup ('5050008') From ('Rotat ;
 103:  !WAIT 0.00 (sec) ;
 104:L P[25] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 105:  ! MoveTo-Drop ('5050008') From (' ;
 106:J P[26] 100% FINE Offset,PR[1]    ;
 107:L P[27] 3500mm/sec FINE Offset,PR[1]    ;
 108:  ! Drop ('5050008') From ('GP: 1 - ;
 109:  !WAIT 0.00 (sec) ;
 110:L P[28] 3500mm/sec FINE    ;
 111:  ENDFOR ;
 112:  DO[4:LEFT TRAY 4]=OFF ;
 113:  LBL[99] ;
 114:J P[29] 100% CNT100    ;
 115:  IF RO[5]=ON,JMP LBL[111] ;
 116:  IF DO[5:RIGHT TRAY 1]=OFF,JMP LBL[112] ;
 117:  LBL[111] ;
 118:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 119:  CALL PROG_OFFSET_REVERSE    ;
 120:  UTOOL_NUM[GP1]=1 ;
 121:  UFRAME_NUM[GP1]=1 ;
 122:J P[30] 100% CNT100    ;
 123:  WAIT    .10(sec) ;
 124:  CALL PROG_VIS    ;
 125:  UTOOL_NUM[GP1]=1 ;
 126:  UFRAME_NUM[GP1]=1 ;
 127:  ! MoveTo-Pickup ('5050008') From  ;
 128:J P[31] 100% CNT100 VOFFSET,VR[1]    ;
 129:L P[32] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 130:  ! Pickup ('5050008') From ('Rotat ;
 131:  !WAIT 0.00 (sec) ;
 132:L P[33] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 133:  ! MoveTo-Drop ('5050008') From (' ;
 134:J P[34] 100% FINE Offset,PR[1]    ;
 135:L P[35] 3500mm/sec FINE Offset,PR[1]    ;
 136:  ! Drop ('5050008') From ('GP: 1 - ;
 137:  !WAIT 0.00 (sec) ;
 138:L P[36] 3500mm/sec FINE Offset,PR[1]    ;
 139:  ENDFOR ;
 140:  DO[5:RIGHT TRAY 1]=OFF ;
 141:  LBL[112] ;
 142:  IF DO[6:RIGHT TRAY 2]=ON,JMP LBL[212] ;
 143:  IF DO[6:RIGHT TRAY 2]=OFF,JMP LBL[213] ;
 144:  LBL[212] ;
 145:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 146:  CALL PROG_OFFSET_REVERSE    ;
 147:  UTOOL_NUM[GP1]=1 ;
 148:  UFRAME_NUM[GP1]=1 ;
 149:J P[37] 100% CNT100    ;
 150:  CALL PROG_VIS    ;
 151:  UTOOL_NUM[GP1]=1 ;
 152:  UFRAME_NUM[GP1]=1 ;
 153:  ! MoveTo-Pickup ('5050008') From  ;
 154:J P[38] 100% CNT100 VOFFSET,VR[1]    ;
 155:L P[39] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 156:  ! Pickup ('5050008') From ('Rotat ;
 157:  !WAIT 0.00 (sec) ;
 158:L P[40] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 159:  ! MoveTo-Drop ('5050008') From (' ;
 160:J P[41] 100% FINE Offset,PR[1]    ;
 161:L P[42] 3500mm/sec FINE    ;
 162:  ! Drop ('5050008') From ('GP: 1 - ;
 163:  !WAIT 0.00 (sec) ;
 164:L P[43] 3500mm/sec CNT100    ;
 165:  ENDFOR ;
 166:  DO[6:RIGHT TRAY 2]=OFF ;
 167:  LBL[213] ;
 168:  IF DO[7:RIGHT TRAY 3]=ON,JMP LBL[313] ;
 169:  IF DO[7:RIGHT TRAY 3]=OFF,JMP LBL[314] ;
 170:  LBL[313] ;
 171:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 172:  CALL PROG_OFFSET_REVERSE    ;
 173:  UTOOL_NUM[GP1]=1 ;
 174:  UFRAME_NUM[GP1]=1 ;
 175:J P[44] 100% CNT100    ;
 176:  CALL PROG_VIS    ;
 177:  UTOOL_NUM[GP1]=1 ;
 178:  UFRAME_NUM[GP1]=1 ;
 179:  ! MoveTo-Pickup ('5050008') From  ;
 180:J P[45] 100% CNT100 VOFFSET,VR[1]    ;
 181:L P[46] 3500mm/sec FINE    ;
 182:  ! Pickup ('5050008') From ('Rotat ;
 183:  !WAIT 0.00 (sec) ;
 184:L P[47] 3500mm/sec CNT100    ;
 185:  ! MoveTo-Drop ('5050008') From (' ;
 186:J P[48] 100% CNT100 Offset,PR[1]    ;
 187:L P[49] 3500mm/sec FINE Offset,PR[1]    ;
 188:  ! Drop ('5050008') From ('GP: 1 - ;
 189:  !WAIT 0.00 (sec) ;
 190:L P[50] 3500mm/sec CNT100    ;
 191:  ENDFOR ;
 192:  DO[7:RIGHT TRAY 3]=OFF ;
 193:  LBL[314] ;
 194:  IF DO[8:RIGHT TRAY 4]=ON,JMP LBL[414] ;
 195:  IF DO[8:RIGHT TRAY 4]=OFF,JMP LBL[999] ;
 196:  LBL[414] ;
 197:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 198:  CALL PROG_OFFSET_REVERSE    ;
 199:  UTOOL_NUM[GP1]=1 ;
 200:  UFRAME_NUM[GP1]=1 ;
 201:J P[51] 100% CNT100    ;
 202:  CALL PROG_VIS    ;
 203:  UTOOL_NUM[GP1]=1 ;
 204:  UFRAME_NUM[GP1]=1 ;
 205:  ! MoveTo-Pickup ('5050008') From  ;
 206:J P[52] 100% CNT100 VOFFSET,VR[1]    ;
 207:L P[53] 3500mm/sec FINE VOFFSET,VR[1]    ;
 208:  ! Pickup ('5050008') From ('Rotat ;
 209:  !WAIT 0.00 (sec) ;
 210:L P[54] 3500mm/sec CNT100    ;
 211:  ! MoveTo-Drop ('5050008') From (' ;
 212:J P[55] 100% FINE Offset,PR[1]    ;
 213:L P[56] 3500mm/sec FINE Offset,PR[1]    ;
 214:  ! Drop ('5050008') From ('GP: 1 - ;
 215:  !WAIT 0.00 (sec) ;
 216:L P[57] 3500mm/sec CNT100    ;
 217:  ENDFOR ;
 218:  DO[8:RIGHT TRAY 4]=OFF ;
 219:  JMP LBL[999] ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =    92.000  mm,	Y =   -64.380  mm,	Z =   149.900  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -31.200 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[20]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[21]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[22]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[23]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[24]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[25]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[26]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[27]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[28]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[29]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =    92.000  mm,	Y =   -64.380  mm,	Z =   149.900  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -31.200 deg
};
P[30]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[31]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[32]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[33]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[34]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[35]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[36]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[37]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[38]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[39]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[40]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[41]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[42]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[43]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[44]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[45]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[46]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[47]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[48]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[49]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[50]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[51]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[52]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[53]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[54]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[55]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[56]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[57]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
/END
