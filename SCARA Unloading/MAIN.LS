/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 7869;
CREATE		= DATE 25-11-16  TIME 19:35:54;
MODIFIED	= DATE 25-11-16  TIME 19:35:54;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 220;
MEMORY_SIZE	= 8285;
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
   4:  !This program will be overwritten ;
   5:  UTOOL_NUM[GP1]=1 ;
   6:  UFRAME_NUM[GP1]=1 ;
   7:  LBL[999] ;
   8:J P[1] 100% CNT100    ;
   9:  IF DO[1:LEFT TRAY 1]=ON,JMP LBL[101] ;
  10:  IF DO[1:LEFT TRAY 1]=OFF,JMP LBL[102] ;
  11:  LBL[101] ;
  12:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  13:  CALL PROG_OFFSET    ;
  14:  UTOOL_NUM[GP1]=1 ;
  15:  UFRAME_NUM[GP1]=1 ;
  16:J P[2] 100% CNT100    ;
  17:  WAIT    .10(sec) ;
  18:  CALL PROG_VIS    ;
  19:  UTOOL_NUM[GP1]=1 ;
  20:  UFRAME_NUM[GP1]=1 ;
  21:L P[3] 2000mm/sec FINE VOFFSET,VR[1]    ;
  22:  ! Pickup ('5050008') From ('Rotat ;
  23:  !WAIT 0.00 (sec) ;
  24:L P[4] 3500mm/sec FINE VOFFSET,VR[1]    ;
  25:  ! MoveTo-Drop ('5050008') From (' ;
  26:J P[5] 100% FINE Offset,PR[1]    ;
  27:J P[6] 100% FINE Offset,PR[1]    ;
  28:  ! Drop ('5050008') From ('GP: 1 - ;
  29:  !WAIT 0.00 (sec) ;
  30:J P[7] 100% CNT100 Offset,PR[1]    ;
  31:  ENDFOR ;
  32:  DO[1:LEFT TRAY 1]=OFF ;
  33:  LBL[102] ;
  34:  IF DO[2:LEFT TRAY 2]=ON,JMP LBL[202] ;
  35:  IF DO[2:LEFT TRAY 2]=OFF,JMP LBL[203] ;
  36:  LBL[202] ;
  37:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  38:  CALL PROG_OFFSET    ;
  39:  UTOOL_NUM[GP1]=1 ;
  40:  UFRAME_NUM[GP1]=1 ;
  41:J P[8] 100% CNT100    ;
  42:  WAIT    .10(sec) ;
  43:  CALL PROG_VIS    ;
  44:  UTOOL_NUM[GP1]=1 ;
  45:  UFRAME_NUM[GP1]=1 ;
  46:  ! MoveTo-Pickup ('5050008') From  ;
  47:J P[9] 100% FINE VOFFSET,VR[1]    ;
  48:L P[10] 3500mm/sec FINE ACC90 VOFFSET,VR[1]    ;
  49:  ! Pickup ('5050008') From ('Rotat ;
  50:  !WAIT 0.00 (sec) ;
  51:L P[11] 3500mm/sec FINE VOFFSET,VR[1]    ;
  52:  ! MoveTo-Drop ('5050008') From (' ;
  53:J P[12] 100% FINE Offset,PR[1]    ;
  54:L P[13] 3500mm/sec FINE Offset,PR[1]    ;
  55:  ! Drop ('5050008') From ('GP: 1 - ;
  56:  !WAIT 0.00 (sec) ;
  57:L P[14] 3500mm/sec FINE Offset,PR[1]    ;
  58:  ENDFOR ;
  59:  DO[2:LEFT TRAY 2]=OFF ;
  60:  LBL[203] ;
  61:  IF DO[3:LEFT TRAY 3]=ON,JMP LBL[303] ;
  62:  IF DO[3:LEFT TRAY 3]=OFF,JMP LBL[304] ;
  63:  LBL[303] ;
  64:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  65:  CALL PROG_OFFSET    ;
  66:  UTOOL_NUM[GP1]=1 ;
  67:  UFRAME_NUM[GP1]=1 ;
  68:J P[15] 100% CNT100    ;
  69:  WAIT    .10(sec) ;
  70:  CALL PROG_VIS    ;
  71:  UTOOL_NUM[GP1]=1 ;
  72:  UFRAME_NUM[GP1]=1 ;
  73:  ! MoveTo-Pickup ('5050008') From  ;
  74:J P[16] 100% CNT100 VOFFSET,VR[1]    ;
  75:L P[17] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
  76:  ! Pickup ('5050008') From ('Rotat ;
  77:  !WAIT 0.00 (sec) ;
  78:J P[18] 100% CNT100 VOFFSET,VR[1]    ;
  79:  ! MoveTo-Drop ('5050008') From (' ;
  80:J P[19] 100% FINE Offset,PR[1]    ;
  81:L P[20] 3500mm/sec CNT100 Offset,PR[1]    ;
  82:  ! Drop ('5050008') From ('GP: 1 - ;
  83:  !WAIT 0.00 (sec) ;
  84:J P[21] 100% CNT100 Offset,PR[1]    ;
  85:  ENDFOR ;
  86:  DO[3:LEFT TRAY 3]=OFF ;
  87:  LBL[304] ;
  88:  IF DO[4:LEFT TRAY 4]=ON,JMP LBL[404] ;
  89:  IF DO[4:LEFT TRAY 4]=OFF,JMP LBL[99] ;
  90:  LBL[404] ;
  91:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
  92:  CALL PROG_OFFSET    ;
  93:  UTOOL_NUM[GP1]=1 ;
  94:  UFRAME_NUM[GP1]=1 ;
  95:J P[22] 100% CNT100    ;
  96:  WAIT    .10(sec) ;
  97:  CALL PROG_VIS    ;
  98:  UTOOL_NUM[GP1]=1 ;
  99:  UFRAME_NUM[GP1]=1 ;
 100:  ! MoveTo-Pickup ('5050008') From  ;
 101:J P[23] 100% CNT100 VOFFSET,VR[1]    ;
 102:L P[24] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 103:  ! Pickup ('5050008') From ('Rotat ;
 104:  !WAIT 0.00 (sec) ;
 105:L P[25] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 106:  ! MoveTo-Drop ('5050008') From (' ;
 107:J P[26] 100% FINE Offset,PR[1]    ;
 108:L P[27] 3500mm/sec FINE Offset,PR[1]    ;
 109:  ! Drop ('5050008') From ('GP: 1 - ;
 110:  !WAIT 0.00 (sec) ;
 111:L P[28] 3500mm/sec FINE    ;
 112:  ENDFOR ;
 113:  DO[4:LEFT TRAY 4]=OFF ;
 114:  LBL[99] ;
 115:J P[29] 100% CNT100    ;
 116:  IF RO[5]=ON,JMP LBL[111] ;
 117:  IF DO[5:RIGHT TRAY 1]=OFF,JMP LBL[112] ;
 118:  LBL[111] ;
 119:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 120:  CALL PROG_OFFSET_REVERSE    ;
 121:  UTOOL_NUM[GP1]=1 ;
 122:  UFRAME_NUM[GP1]=1 ;
 123:J P[30] 100% CNT100    ;
 124:  WAIT    .10(sec) ;
 125:  CALL PROG_VIS    ;
 126:  UTOOL_NUM[GP1]=1 ;
 127:  UFRAME_NUM[GP1]=1 ;
 128:  ! MoveTo-Pickup ('5050008') From  ;
 129:J P[31] 100% CNT100 VOFFSET,VR[1]    ;
 130:L P[32] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 131:  ! Pickup ('5050008') From ('Rotat ;
 132:  !WAIT 0.00 (sec) ;
 133:L P[33] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 134:  ! MoveTo-Drop ('5050008') From (' ;
 135:J P[34] 100% FINE Offset,PR[1]    ;
 136:L P[35] 3500mm/sec FINE Offset,PR[1]    ;
 137:  ! Drop ('5050008') From ('GP: 1 - ;
 138:  !WAIT 0.00 (sec) ;
 139:L P[36] 3500mm/sec FINE Offset,PR[1]    ;
 140:  ENDFOR ;
 141:  DO[5:RIGHT TRAY 1]=OFF ;
 142:  LBL[112] ;
 143:  IF DO[6:RIGHT TRAY 2]=ON,JMP LBL[212] ;
 144:  IF DO[6:RIGHT TRAY 2]=OFF,JMP LBL[213] ;
 145:  LBL[212] ;
 146:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 147:  CALL PROG_OFFSET_REVERSE    ;
 148:  UTOOL_NUM[GP1]=1 ;
 149:  UFRAME_NUM[GP1]=1 ;
 150:J P[37] 100% CNT100    ;
 151:  CALL PROG_VIS    ;
 152:  UTOOL_NUM[GP1]=1 ;
 153:  UFRAME_NUM[GP1]=1 ;
 154:  ! MoveTo-Pickup ('5050008') From  ;
 155:J P[38] 100% CNT100 VOFFSET,VR[1]    ;
 156:L P[39] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 157:  ! Pickup ('5050008') From ('Rotat ;
 158:  !WAIT 0.00 (sec) ;
 159:L P[40] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 160:  ! MoveTo-Drop ('5050008') From (' ;
 161:J P[41] 100% FINE Offset,PR[1]    ;
 162:L P[42] 3500mm/sec FINE    ;
 163:  ! Drop ('5050008') From ('GP: 1 - ;
 164:  !WAIT 0.00 (sec) ;
 165:L P[43] 3500mm/sec CNT100    ;
 166:  ENDFOR ;
 167:  DO[6:RIGHT TRAY 2]=OFF ;
 168:  LBL[213] ;
 169:  IF DO[7:RIGHT TRAY 3]=ON,JMP LBL[313] ;
 170:  IF DO[7:RIGHT TRAY 3]=OFF,JMP LBL[314] ;
 171:  LBL[313] ;
 172:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 173:  CALL PROG_OFFSET_REVERSE    ;
 174:  UTOOL_NUM[GP1]=1 ;
 175:  UFRAME_NUM[GP1]=1 ;
 176:J P[44] 100% CNT100    ;
 177:  CALL PROG_VIS    ;
 178:  UTOOL_NUM[GP1]=1 ;
 179:  UFRAME_NUM[GP1]=1 ;
 180:  ! MoveTo-Pickup ('5050008') From  ;
 181:J P[45] 100% CNT100 VOFFSET,VR[1]    ;
 182:L P[46] 3500mm/sec FINE    ;
 183:  ! Pickup ('5050008') From ('Rotat ;
 184:  !WAIT 0.00 (sec) ;
 185:L P[47] 3500mm/sec CNT100    ;
 186:  ! MoveTo-Drop ('5050008') From (' ;
 187:J P[48] 100% CNT100 Offset,PR[1]    ;
 188:L P[49] 3500mm/sec FINE Offset,PR[1]    ;
 189:  ! Drop ('5050008') From ('GP: 1 - ;
 190:  !WAIT 0.00 (sec) ;
 191:L P[50] 3500mm/sec CNT100    ;
 192:  ENDFOR ;
 193:  DO[7:RIGHT TRAY 3]=OFF ;
 194:  LBL[314] ;
 195:  IF DO[8:RIGHT TRAY 4]=ON,JMP LBL[414] ;
 196:  IF DO[8:RIGHT TRAY 4]=OFF,JMP LBL[999] ;
 197:  LBL[414] ;
 198:  FOR R[1:MAIN COUNTER]=1 TO 60 ;
 199:  CALL PROG_OFFSET_REVERSE    ;
 200:  UTOOL_NUM[GP1]=1 ;
 201:  UFRAME_NUM[GP1]=1 ;
 202:J P[51] 100% CNT100    ;
 203:  CALL PROG_VIS    ;
 204:  UTOOL_NUM[GP1]=1 ;
 205:  UFRAME_NUM[GP1]=1 ;
 206:  ! MoveTo-Pickup ('5050008') From  ;
 207:J P[52] 100% CNT100 VOFFSET,VR[1]    ;
 208:L P[53] 3500mm/sec FINE VOFFSET,VR[1]    ;
 209:  ! Pickup ('5050008') From ('Rotat ;
 210:  !WAIT 0.00 (sec) ;
 211:L P[54] 3500mm/sec CNT100    ;
 212:  ! MoveTo-Drop ('5050008') From (' ;
 213:J P[55] 100% FINE Offset,PR[1]    ;
 214:L P[56] 3500mm/sec FINE Offset,PR[1]    ;
 215:  ! Drop ('5050008') From ('GP: 1 - ;
 216:  !WAIT 0.00 (sec) ;
 217:L P[57] 3500mm/sec CNT100    ;
 218:  ENDFOR ;
 219:  DO[8:RIGHT TRAY 4]=OFF ;
 220:  JMP LBL[999] ;
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
