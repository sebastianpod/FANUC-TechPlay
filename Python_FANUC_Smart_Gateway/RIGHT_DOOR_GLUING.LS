/PROG  RIGHT_DOOR_GLUING
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "RightTrajectory";
PROG_SIZE	= 4954;
CREATE		= DATE 26-08-16  TIME 21:29:44;
MODIFIED	= DATE 26-09-21  TIME 16:13:12;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 198;
MEMORY_SIZE	= 5566;
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
   1:   ;
   2:  !================================ ;
   3:  !==                            == ;
   4:  !== EXECUTES GLUING TRAJECTORY == ;
   5:  !== MONITORS GLUE APPLICATION  == ;
   6:  !== HANDLES PROCESS RECOVERY   == ;
   7:  !==                            == ;
   8:  !================================ ;
   9:   ;
  10:  !RESET PROCESS STATUS FLAGS ;
  11:  F[2:PROCESS_FINISHED]=(OFF) ;
  12:  F[3:GLUE_APPLICATION_LOST]=(OFF) ;
  13:  F[5:GLUE_FLOW_BELOW_TOL]=(OFF) ;
  14:  F[6:GLUE_FLOW_ABOVE_TOL]=(OFF) ;
  15:   ;
  16:  !LOAD LEFT TABLE USER FRAME ;
  17:  UFRAME_NUM=2 ;
  18:   ;
  19:  !EXECUTE PROCESS WITH TOOL 1 ;
  20:  IF (R[11:TOOL_NUM]=1) THEN ;
  21:   ;
  22:  !LOAD GLUEGUN GREEN PAYLOAD ;
  23:  PAYLOAD[1:GlueGun_Green] ;
  24:   ;
  25:  !LOAD UTOOL BASED ON USER CHOICE ;
  26:  UTOOL_NUM=R[11:TOOL_NUM] ;
  27:   ;
  28:  !MOVE TO APPROACH POINT ;
  29:L P[11] 1000mm/sec FINE    ;
  30:   ;
  31:  !MOVE TO TRAJECTORY START ;
  32:L P[1] R[12:SPEED]mm/sec FINE    ;
  33:   ;
  34:  !START GLUE APPLICATION ;
  35:  DO[10:GLUE_APPLICATION]=ON ;
  36:  WAIT    .50(sec) ;
  37:   ;
  38:  !MONITOR GLUE APPLICATION ;
  39:  !SKIP TO RECOVERY IF LOST ;
  40:  SKIP CONDITION DO[10:GLUE_APPLICATION]=OFF    ;
  41:   ;
  42:  !CONTINUE WHILE GLUE IS ON ;
  43:  !SKIP OCCURS IF GLUE SIGNAL ;
  44:  !CHANGES TO OFF DURING MOVE ;
  45:L P[2] R[12:SPEED]mm/sec CNT100 Skip,LBL[103]    ;
  46:  JMP LBL[900] ;
  47:   ;
  48:  LBL[103] ;
  49:L P[3] R[12:SPEED]mm/sec CNT100 Skip,LBL[104]    ;
  50:  JMP LBL[900] ;
  51:   ;
  52:  LBL[104] ;
  53:L P[4] R[12:SPEED]mm/sec CNT100 Skip,LBL[105]    ;
  54:  JMP LBL[900] ;
  55:   ;
  56:  LBL[105] ;
  57:L P[5] R[12:SPEED]mm/sec CNT100 Skip,LBL[106]    ;
  58:  JMP LBL[900] ;
  59:   ;
  60:  LBL[106] ;
  61:L P[6] R[12:SPEED]mm/sec CNT100 Skip,LBL[107]    ;
  62:  JMP LBL[900] ;
  63:   ;
  64:  LBL[107] ;
  65:L P[7] R[12:SPEED]mm/sec CNT100 Skip,LBL[108]    ;
  66:  JMP LBL[900] ;
  67:   ;
  68:  LBL[108] ;
  69:L P[8] R[12:SPEED]mm/sec CNT100 Skip,LBL[109]    ;
  70:  JMP LBL[900] ;
  71:   ;
  72:  LBL[109] ;
  73:  !MOVE TO TRAJECTORY FINISH POINT ;
  74:L P[9] R[12:SPEED]mm/sec FINE Skip,LBL[110]    ;
  75:  JMP LBL[900] ;
  76:   ;
  77:  LBL[900] ;
  78:   ;
  79:  !GLUE APPLICATION LOST ;
  80:  F[3:GLUE_APPLICATION_LOST]=(ON) ;
  81:   ;
  82:  !STORE INTERRUPTION POSITION ;
  83:  PR[2:WRKZONE_RECOVERY]=LPOS    ;
  84:   ;
  85:  !RETRACT SAFELY FROM PART ;
  86:  PR[2,3:WRKZONE_RECOVERY]=PR[2,3:WRKZONE_RECOVERY]+100    ;
  87:   ;
  88:L PR[2:WRKZONE_RECOVERY] 100mm/sec FINE    ;
  89:   ;
  90:  !EXIT PROCESS ;
  91:  JMP LBL[999] ;
  92:   ;
  93:  LBL[110] ;
  94:   ;
  95:  !STOP GLUE APPLICATION ;
  96:  DO[10:GLUE_APPLICATION]=OFF ;
  97:  WAIT    .50(sec) ;
  98:   ;
  99:  !MOVE TO EXIT POINT ;
 100:L P[10] 1000mm/sec FINE    ;
 101:   ;
 102:  !MARK PROCESS AS COMPLETED ;
 103:  F[2:PROCESS_FINISHED]=(ON) ;
 104:   ;
 105:  ENDIF ;
 106:   ;
 107:  !EXECUTE PROCESS WITH TOOL 2 ;
 108:  IF (R[11:TOOL_NUM]=2) THEN ;
 109:   ;
 110:  !LOAD GLUEGUN BLUE PAYLOAD ;
 111:  PAYLOAD[2:GlueGun_Blue] ;
 112:   ;
 113:  !LOAD UTOOL BASED ON USER CHOICE ;
 114:  UTOOL_NUM=R[11:TOOL_NUM] ;
 115:   ;
 116:  !MOVE TO APPROACH POINT ;
 117:L P[13] 1000mm/sec FINE    ;
 118:   ;
 119:  !MOVE TO TRAJCETORY START ;
 120:L P[12] R[12:SPEED]mm/sec FINE    ;
 121:   ;
 122:  !START GLUE APPLICATION ;
 123:  DO[10:GLUE_APPLICATION]=ON ;
 124:  WAIT    .50(sec) ;
 125:   ;
 126:  !MONITOR GLUE APPLICATION ;
 127:  !SKIP TO RECOVERY IF LOST ;
 128:  SKIP CONDITION DO[10:GLUE_APPLICATION]=OFF    ;
 129:   ;
 130:  !CONTINUE WHILE GLUE IS ON ;
 131:  !SKIP OCCURS IF GLUE SIGNAL ;
 132:  !CHANGES TO OFF DURING MOVE ;
 133:L P[14] R[12:SPEED]mm/sec CNT100 Skip,LBL[115]    ;
 134:  JMP LBL[901] ;
 135:   ;
 136:  LBL[115] ;
 137:L P[15] R[12:SPEED]mm/sec CNT100 Skip,LBL[116]    ;
 138:  JMP LBL[901] ;
 139:   ;
 140:  LBL[116] ;
 141:L P[16] R[12:SPEED]mm/sec CNT100 Skip,LBL[117]    ;
 142:  JMP LBL[901] ;
 143:   ;
 144:  LBL[117] ;
 145:L P[17] R[12:SPEED]mm/sec CNT100 Skip,LBL[118]    ;
 146:  JMP LBL[901] ;
 147:   ;
 148:  LBL[118] ;
 149:L P[18] R[12:SPEED]mm/sec CNT100 Skip,LBL[119]    ;
 150:  JMP LBL[901] ;
 151:   ;
 152:  LBL[119] ;
 153:L P[19] R[12:SPEED]mm/sec CNT100 Skip,LBL[120]    ;
 154:  JMP LBL[901] ;
 155:   ;
 156:  LBL[120] ;
 157:L P[20] R[12:SPEED]mm/sec CNT100 Skip,LBL[122]    ;
 158:  JMP LBL[901] ;
 159:   ;
 160:  LBL[122] ;
 161:   ;
 162:  !MOVE TO TRAJECTORY FINISH POINT ;
 163:L P[22] R[12:SPEED]mm/sec CNT100 Skip,LBL[121]    ;
 164:  JMP LBL[901] ;
 165:   ;
 166:  LBL[901] ;
 167:   ;
 168:  !GLUE APPLICATION LOST ;
 169:  F[3:GLUE_APPLICATION_LOST]=(ON) ;
 170:   ;
 171:  !STORE INTERRUPTION POSITION ;
 172:  PR[2:WRKZONE_RECOVERY]=LPOS    ;
 173:   ;
 174:  !RETRACT SAFELY FROM PART ;
 175:  PR[2,3:WRKZONE_RECOVERY]=PR[2,3:WRKZONE_RECOVERY]+100    ;
 176:   ;
 177:L PR[2:WRKZONE_RECOVERY] 100mm/sec FINE    ;
 178:   ;
 179:  !EXIT PROCESS ;
 180:  JMP LBL[999] ;
 181:   ;
 182:  LBL[121] ;
 183:   ;
 184:  !STOP GLUE APPLICATION ;
 185:  DO[10:GLUE_APPLICATION]=OFF ;
 186:  WAIT    .50(sec) ;
 187:   ;
 188:  !MOVE TO EXIT POINT ;
 189:L P[21] 1000mm/sec FINE    ;
 190:   ;
 191:  !MARK PROCESS AS COMPLETED ;
 192:  F[2:PROCESS_FINISHED]=(ON) ;
 193:   ;
 194:  ENDIF ;
 195:   ;
 196:  !EXIT LABEL ;
 197:  LBL[999] ;
 198:   ;
/POS
P[1]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   737.146  mm,	Y =   274.697  mm,	Z =     2.641  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[2]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   774.394  mm,	Y =   432.696  mm,	Z =     2.641  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[3]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   793.139  mm,	Y =   510.275  mm,	Z =    52.107  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[4]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   178.139  mm,	Y =   510.275  mm,	Z =    52.107  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[5]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   153.174  mm,	Y =   434.538  mm,	Z =     5.627  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[6]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   153.174  mm,	Y =   275.538  mm,	Z =     5.627  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[7]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   135.353  mm,	Y =   180.736  mm,	Z =    38.777  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[8]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   730.353  mm,	Y =   180.736  mm,	Z =    38.777  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[9]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   737.146  mm,	Y =   274.697  mm,	Z =     2.641  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[10]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   737.146  mm,	Y =   274.697  mm,	Z =    89.641  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[11]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   737.146  mm,	Y =   274.697  mm,	Z =    89.641  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[12]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   149.901  mm,	Y =   272.308  mm,	Z =     4.006  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[13]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   149.901  mm,	Y =   272.308  mm,	Z =    77.006  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[14]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   149.901  mm,	Y =   436.308  mm,	Z =     4.006  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[15]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   168.795  mm,	Y =   510.019  mm,	Z =    51.245  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[16]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   797.280  mm,	Y =   510.018  mm,	Z =    51.242  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[17]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   783.285  mm,	Y =   432.018  mm,	Z =     2.062  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[18]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   756.965  mm,	Y =   275.527  mm,	Z =     2.063  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[19]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   737.229  mm,	Y =   179.429  mm,	Z =    37.666  mm,
	W =  -179.999 deg,	P =      .000 deg,	R =    90.000 deg
};
P[20]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   140.640  mm,	Y =   179.429  mm,	Z =    37.671  mm,
	W =  -179.999 deg,	P =      .000 deg,	R =    90.000 deg
};
P[21]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   149.901  mm,	Y =   272.308  mm,	Z =    77.006  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
P[22]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   149.901  mm,	Y =   272.308  mm,	Z =     4.006  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =    90.000 deg
};
/END
