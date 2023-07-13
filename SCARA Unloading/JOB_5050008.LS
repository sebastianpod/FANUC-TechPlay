/PROG  JOB_5050008
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 7934;
CREATE		= DATE 23-07-13  TIME 13:33:02;
MODIFIED	= DATE 23-07-13  TIME 13:33:02;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 221;
MEMORY_SIZE	= 8346;
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
   8:  IF DO[1]=ON,JMP LBL[101] ;
   9:  IF DO[1]=OFF,JMP LBL[102] ;
  10:  LBL[101] ;
  11:  FOR R[1]=1 TO 60 ;
  12:  CALL PROG_OFFSET    ;
  13:  UTOOL_NUM[GP1]=1 ;
  14:  UFRAME_NUM[GP1]=1 ;
  15:J P[2] 100% CNT100    ;
  16:  WAIT    .10(sec) ;
  17:  CALL PROG_VIS    ;
  18:  UTOOL_NUM[GP1]=1 ;
  19:  UFRAME_NUM[GP1]=1 ;
  20:  ! MoveTo-Pickup ('5050008') From  ;
  21:J P[3] 100% FINE VOFFSET,VR[1]    ;
  22:L P[4] 3500mm/sec FINE VOFFSET,VR[1]    ;
  23:  ! Pickup ('5050008') From ('Rotat ;
  24:  !WAIT 0.00 (sec) ;
  25:L P[5] 3500mm/sec FINE VOFFSET,VR[1]    ;
  26:  ! MoveTo-Drop ('5050008') From (' ;
  27:J P[6] 100% FINE Offset,PR[1]    ;
  28:J P[7] 100% FINE Offset,PR[1]    ;
  29:  ! Drop ('5050008') From ('GP: 1 - ;
  30:  !WAIT 0.00 (sec) ;
  31:J P[8] 100% CNT100 Offset,PR[1]    ;
  32:  ENDFOR ;
  33:  DO[1]=OFF ;
  34:  LBL[102] ;
  35:  IF DO[2]=ON,JMP LBL[202] ;
  36:  IF DO[2]=OFF,JMP LBL[203] ;
  37:  LBL[202] ;
  38:  FOR R[1]=1 TO 60 ;
  39:  CALL PROG_OFFSET    ;
  40:  UTOOL_NUM[GP1]=1 ;
  41:  UFRAME_NUM[GP1]=1 ;
  42:J P[9] 100% CNT100    ;
  43:  WAIT    .10(sec) ;
  44:  CALL PROG_VIS    ;
  45:  UTOOL_NUM[GP1]=1 ;
  46:  UFRAME_NUM[GP1]=1 ;
  47:  ! MoveTo-Pickup ('5050008') From  ;
  48:J P[10] 100% FINE VOFFSET,VR[1]    ;
  49:L P[11] 3500mm/sec FINE ACC90 VOFFSET,VR[1]    ;
  50:  ! Pickup ('5050008') From ('Rotat ;
  51:  !WAIT 0.00 (sec) ;
  52:L P[12] 3500mm/sec FINE VOFFSET,VR[1]    ;
  53:  ! MoveTo-Drop ('5050008') From (' ;
  54:J P[13] 100% FINE Offset,PR[1]    ;
  55:L P[14] 3500mm/sec FINE Offset,PR[1]    ;
  56:  ! Drop ('5050008') From ('GP: 1 - ;
  57:  !WAIT 0.00 (sec) ;
  58:L P[15] 3500mm/sec FINE Offset,PR[1]    ;
  59:  ENDFOR ;
  60:  DO[2]=OFF ;
  61:  LBL[203] ;
  62:  IF DO[3]=ON,JMP LBL[303] ;
  63:  IF DO[3]=OFF,JMP LBL[304] ;
  64:  LBL[303] ;
  65:  FOR R[1]=1 TO 60 ;
  66:  CALL PROG_OFFSET    ;
  67:  UTOOL_NUM[GP1]=1 ;
  68:  UFRAME_NUM[GP1]=1 ;
  69:J P[16] 100% CNT100    ;
  70:  WAIT    .10(sec) ;
  71:  CALL PROG_VIS    ;
  72:  UTOOL_NUM[GP1]=1 ;
  73:  UFRAME_NUM[GP1]=1 ;
  74:  ! MoveTo-Pickup ('5050008') From  ;
  75:J P[17] 100% CNT100 VOFFSET,VR[1]    ;
  76:L P[18] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
  77:  ! Pickup ('5050008') From ('Rotat ;
  78:  !WAIT 0.00 (sec) ;
  79:J P[19] 100% CNT100 VOFFSET,VR[1]    ;
  80:  ! MoveTo-Drop ('5050008') From (' ;
  81:J P[20] 100% FINE Offset,PR[1]    ;
  82:L P[21] 3500mm/sec CNT100 Offset,PR[1]    ;
  83:  ! Drop ('5050008') From ('GP: 1 - ;
  84:  !WAIT 0.00 (sec) ;
  85:J P[22] 100% CNT100 Offset,PR[1]    ;
  86:  ENDFOR ;
  87:  DO[3]=OFF ;
  88:  LBL[304] ;
  89:  IF DO[4]=ON,JMP LBL[404] ;
  90:  IF DO[4]=OFF,JMP LBL[99] ;
  91:  LBL[404] ;
  92:  FOR R[1]=1 TO 60 ;
  93:  CALL PROG_OFFSET    ;
  94:  UTOOL_NUM[GP1]=1 ;
  95:  UFRAME_NUM[GP1]=1 ;
  96:J P[23] 100% CNT100    ;
  97:  WAIT    .10(sec) ;
  98:  CALL PROG_VIS    ;
  99:  UTOOL_NUM[GP1]=1 ;
 100:  UFRAME_NUM[GP1]=1 ;
 101:  ! MoveTo-Pickup ('5050008') From  ;
 102:J P[24] 100% CNT100 VOFFSET,VR[1]    ;
 103:L P[25] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 104:  ! Pickup ('5050008') From ('Rotat ;
 105:  !WAIT 0.00 (sec) ;
 106:L P[26] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 107:  ! MoveTo-Drop ('5050008') From (' ;
 108:J P[27] 100% FINE Offset,PR[1]    ;
 109:L P[28] 3500mm/sec FINE Offset,PR[1]    ;
 110:  ! Drop ('5050008') From ('GP: 1 - ;
 111:  !WAIT 0.00 (sec) ;
 112:L P[29] 3500mm/sec FINE    ;
 113:  ENDFOR ;
 114:  DO[4]=OFF ;
 115:  LBL[99] ;
 116:J P[30] 100% CNT100    ;
 117:  IF RO[5]=ON,JMP LBL[111] ;
 118:  IF DO[5]=OFF,JMP LBL[112] ;
 119:  LBL[111] ;
 120:  FOR R[1]=1 TO 60 ;
 121:  CALL PROG_OFFSET_REVERSE    ;
 122:  UTOOL_NUM[GP1]=1 ;
 123:  UFRAME_NUM[GP1]=1 ;
 124:J P[31] 100% CNT100    ;
 125:  WAIT    .10(sec) ;
 126:  CALL PROG_VIS    ;
 127:  UTOOL_NUM[GP1]=1 ;
 128:  UFRAME_NUM[GP1]=1 ;
 129:  ! MoveTo-Pickup ('5050008') From  ;
 130:J P[32] 100% CNT100 VOFFSET,VR[1]    ;
 131:L P[33] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 132:  ! Pickup ('5050008') From ('Rotat ;
 133:  !WAIT 0.00 (sec) ;
 134:L P[34] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 135:  ! MoveTo-Drop ('5050008') From (' ;
 136:J P[35] 100% FINE Offset,PR[1]    ;
 137:L P[36] 3500mm/sec FINE Offset,PR[1]    ;
 138:  ! Drop ('5050008') From ('GP: 1 - ;
 139:  !WAIT 0.00 (sec) ;
 140:L P[37] 3500mm/sec FINE Offset,PR[1]    ;
 141:  ENDFOR ;
 142:  DO[5]=OFF ;
 143:  LBL[112] ;
 144:  IF DO[6]=ON,JMP LBL[212] ;
 145:  IF DO[6]=OFF,JMP LBL[213] ;
 146:  LBL[212] ;
 147:  FOR R[1]=1 TO 60 ;
 148:  CALL PROG_OFFSET_REVERSE    ;
 149:  UTOOL_NUM[GP1]=1 ;
 150:  UFRAME_NUM[GP1]=1 ;
 151:J P[38] 100% CNT100    ;
 152:  CALL PROG_VIS    ;
 153:  UTOOL_NUM[GP1]=1 ;
 154:  UFRAME_NUM[GP1]=1 ;
 155:  ! MoveTo-Pickup ('5050008') From  ;
 156:J P[39] 100% CNT100 VOFFSET,VR[1]    ;
 157:L P[40] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 158:  ! Pickup ('5050008') From ('Rotat ;
 159:  !WAIT 0.00 (sec) ;
 160:L P[41] 3500mm/sec CNT100 VOFFSET,VR[1]    ;
 161:  ! MoveTo-Drop ('5050008') From (' ;
 162:J P[42] 100% FINE Offset,PR[1]    ;
 163:L P[43] 3500mm/sec FINE    ;
 164:  ! Drop ('5050008') From ('GP: 1 - ;
 165:  !WAIT 0.00 (sec) ;
 166:L P[44] 3500mm/sec CNT100    ;
 167:  ENDFOR ;
 168:  DO[6]=OFF ;
 169:  LBL[213] ;
 170:  IF DO[7]=ON,JMP LBL[313] ;
 171:  IF DO[7]=OFF,JMP LBL[314] ;
 172:  LBL[313] ;
 173:  FOR R[1]=1 TO 60 ;
 174:  CALL PROG_OFFSET_REVERSE    ;
 175:  UTOOL_NUM[GP1]=1 ;
 176:  UFRAME_NUM[GP1]=1 ;
 177:J P[45] 100% CNT100    ;
 178:  CALL PROG_VIS    ;
 179:  UTOOL_NUM[GP1]=1 ;
 180:  UFRAME_NUM[GP1]=1 ;
 181:  ! MoveTo-Pickup ('5050008') From  ;
 182:J P[46] 100% CNT100 VOFFSET,VR[1]    ;
 183:L P[47] 3500mm/sec FINE    ;
 184:  ! Pickup ('5050008') From ('Rotat ;
 185:  !WAIT 0.00 (sec) ;
 186:L P[48] 3500mm/sec CNT100    ;
 187:  ! MoveTo-Drop ('5050008') From (' ;
 188:J P[49] 100% CNT100 Offset,PR[1]    ;
 189:L P[50] 3500mm/sec FINE Offset,PR[1]    ;
 190:  ! Drop ('5050008') From ('GP: 1 - ;
 191:  !WAIT 0.00 (sec) ;
 192:L P[51] 3500mm/sec CNT100    ;
 193:  ENDFOR ;
 194:  DO[7]=OFF ;
 195:  LBL[314] ;
 196:  IF DO[8]=ON,JMP LBL[414] ;
 197:  IF DO[8]=OFF,JMP LBL[999] ;
 198:  LBL[414] ;
 199:  FOR R[1]=1 TO 60 ;
 200:  CALL PROG_OFFSET_REVERSE    ;
 201:  UTOOL_NUM[GP1]=1 ;
 202:  UFRAME_NUM[GP1]=1 ;
 203:J P[52] 100% CNT100    ;
 204:  CALL PROG_VIS    ;
 205:  UTOOL_NUM[GP1]=1 ;
 206:  UFRAME_NUM[GP1]=1 ;
 207:  ! MoveTo-Pickup ('5050008') From  ;
 208:J P[53] 100% CNT100 VOFFSET,VR[1]    ;
 209:L P[54] 3500mm/sec FINE VOFFSET,VR[1]    ;
 210:  ! Pickup ('5050008') From ('Rotat ;
 211:  !WAIT 0.00 (sec) ;
 212:L P[55] 3500mm/sec CNT100    ;
 213:  ! MoveTo-Drop ('5050008') From (' ;
 214:J P[56] 100% FINE Offset,PR[1]    ;
 215:L P[57] 3500mm/sec FINE Offset,PR[1]    ;
 216:  ! Drop ('5050008') From ('GP: 1 - ;
 217:  !WAIT 0.00 (sec) ;
 218:L P[58] 3500mm/sec CNT100    ;
 219:  ENDFOR ;
 220:  DO[8]=OFF ;
 221:  JMP LBL[999] ;
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
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[20]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[21]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[22]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =     0.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[23]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[24]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[25]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[26]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[27]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[28]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[29]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =   250.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[30]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =    92.000  mm,	Y =   -64.380  mm,	Z =   149.900  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -31.200 deg
};
P[31]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[32]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[33]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[34]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[35]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[36]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[37]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[38]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[39]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
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
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[42]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[43]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[44]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =     0.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[45]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
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
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[48]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[49]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[50]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[51]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -920.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[52]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -688.150  mm,	Y =   209.620  mm,	Z =   150.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
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
	X =  -458.000  mm,	Y =    54.620  mm,	Z =    54.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[55]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X =  -458.000  mm,	Y =    54.620  mm,	Z =   100.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[56]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[57]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =     0.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[58]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'R, 0, 0, 0',
	X = -1170.000  mm,	Y =   350.000  mm,	Z =    50.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
/END
