/PROG  JOB_FC
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3790;
CREATE		= DATE 20-07-17  TIME 10:47:34;
MODIFIED	= DATE 20-07-17  TIME 10:47:34;
FILE_NAME	= PR_VICI_;
VERSION		= 0;
LINE_COUNT	= 186;
MEMORY_SIZE	= 4246;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/APPL
/MN
   1:  CALL HOME_POS    ;
   2:  R[43:pick up status]=6    ;
   3:  R[44:pick low status]=6    ;
   4:  R[45:place up status]=6    ;
   5:  R[46:place low status]=6    ;
   6:   ;
   7:  DO[11007]=OFF ;
   8:  DO[11013]=OFF ;
   9:  DO[11014]=OFF ;
  10:  DO[11015]=OFF ;
  11:  DO[11021]=OFF ;
  12:  DO[11022]=OFF ;
  13:  DO[11023]=OFF ;
  14:  DO[11024]=OFF ;
  15:  DO[11031]=OFF ;
  16:  DO[11032]=OFF ;
  17:  DO[11036]=OFF ;
  18:  DO[11037]=OFF ;
  19:  DO[11041]=OFF ;
  20:  DO[11042]=OFF ;
  21:  DO[11043]=OFF ;
  22:  DO[11044]=OFF ;
  23:  DO[11045]=OFF ;
  24:  DO[11046]=OFF ;
  25:  DO[11047]=OFF ;
  26:  DO[11048]=OFF ;
  27:  DO[11049]=OFF ;
  28:  DO[11050]=OFF ;
  29:  DO[11051]=OFF ;
  30:  DO[11052]=OFF ;
  31:  DO[11053]=OFF ;
  32:  DO[11054]=OFF ;
  33:  DO[11055]=OFF ;
  34:  DO[11056]=OFF ;
  35:  DO[11057]=OFF ;
  36:  DO[11058]=OFF ;
  37:  DO[11059]=OFF ;
  38:  DO[11060]=OFF ;
  39:  DO[11061]=OFF ;
  40:  DO[11062]=OFF ;
  41:  DO[11063]=OFF ;
  42:  DO[11064]=OFF ;
  43:  DO[11065]=OFF ;
  44:  DO[11081]=OFF ;
  45:  DO[11082]=OFF ;
  46:  DO[11083]=OFF ;
  47:  DO[11084]=OFF ;
  48:  DO[11085]=OFF ;
  49:  DO[11086]=OFF ;
  50:  DO[11089]=OFF ;
  51:  DO[11090]=OFF ;
  52:  DO[11097]=OFF ;
  53:  DO[11098]=OFF ;
  54:  DO[11099]=OFF ;
  55:  DO[11100]=OFF ;
  56:  DO[11101]=OFF ;
  57:  DO[11102]=OFF ;
  58:   ;
  59:  R[103:no of upper pick]=0    ;
  60:  R[104:no of lower pick]=0    ;
  61:  R[105:x axis place pal]=0    ;
  62:  R[106:y axis place pal]=0    ;
  63:  R[107:no of upper plae]=0    ;
  64:  R[108:no of lower plae]=0    ;
  65:  R[109:wrk up pick pal]=1    ;
  66:  R[110:wrk low pick pal]=0    ;
  67:  R[111:wrk up place pal]=1    ;
  68:  R[112:wrk low place pl]=0    ;
  69:  R[113:x axis scrap pal]=0    ;
  70:  R[114:y axis scrap pat]=0    ;
  71:  R[115]=1    ;
  72:  R[116]=0    ;
  73:  R[117]=3    ;
  74:  R[118]=0    ;
  75:   ;
  76:  LBL[3] ;
  77:  R[101:x axis pick pal]=0    ;
  78:  R[102:y axis pick pal]=0    ;
  79:  PR[10:pick pair off]=LPOS-LPOS    ;
  80:  PR[11:pick pair Z axis]=LPOS-LPOS    ;
  81:  PR[12:pick unpair off]=LPOS-LPOS    ;
  82:  PR[13:pick unpair Z ax]=LPOS-LPOS    ;
  83:  PR[14:place pair off]=LPOS-LPOS    ;
  84:  PR[15:place pair Z]=LPOS-LPOS    ;
  85:  PR[16:place unpair off]=LPOS-LPOS    ;
  86:  PR[17:place unpair Z]=LPOS-LPOS    ;
  87:  LBL[1] ;
  88:   ;
  89:   ;
  90:   ;
  91:  CALL FIX_PALET    ;
  92:   ;
  93:  CALL PICK_PALET_SLEEVE    ;
  94:   ;
  95:  CALL PATH_PICK_HOMMEL    ;
  96:  !FC ;
  97:J P[8] 100% CNT30    ;
  98:J P[9] 100% CNT5    ;
  99:J P[10] 100% CNT5    ;
 100:J P[11] 100% CNT30    ;
 101:J P[12] 100% CNT30    ;
 102:   ;
 103:   ;
 104:L P[2] 1200mm/sec FINE    ;
 105:   ;
 106:   ;
 107:  WAIT R[26:stato bit]=0    ;
 108:   ;
 109:   ;
 110:L P[1] 100mm/sec FINE    ;
 111:   ;
 112:  R[26:stato bit]=1    ;
 113:   ;
 114:   ;
 115:   ;
 116:  WAIT R[26:stato bit]=2    ;
 117:  CALL OPEN_CHUCK_1    ;
 118:  WAIT   1.00(sec) ;
 119:   ;
 120:L P[2] 250mm/sec FINE    ;
 121:  R[26:stato bit]=3    ;
 122:   ;
 123:  WAIT R[26:stato bit]=4    ;
 124:L P[1] 250mm/sec FINE    ;
 125:   ;
 126:  CALL CLOSE_CHUCK_1    ;
 127:  R[26:stato bit]=5    ;
 128:  WAIT R[26:stato bit]=6    ;
 129:L P[2] 250mm/sec FINE    ;
 130:   ;
 131:  R[26:stato bit]=0    ;
 132:   ;
 133:   ;
 134:   ;
 135:   ;
 136:   ;
 137:   ;
 138:   ;
 139:   ;
 140:   ;
 141:  !final check ;
 142:   ;
 143:  !DEPOSITO PEZZO ;
 144:   ;
 145:  IF (R[27:ok bit]=1) THEN ;
 146:J P[3] 30% CNT100    ;
 147:   ;
 148:J P[4] 30% CNT100    ;
 149:J P[5] 30% CNT100    ;
 150:J P[6] 30% CNT100    ;
 151:J P[7] 30% CNT100    ;
 152:   ;
 153:   ;
 154:   ;
 155:   ;
 156:   ;
 157:   ;
 158:   ;
 159:  CALL PLACE_PALET_SLEEVE    ;
 160:   ;
 161:  ELSE ;
 162:   ;
 163:J P[13] 30% CNT100    ;
 164:L P[18] 500mm/sec CNT100    ;
 165:L P[19] 250mm/sec FINE    ;
 166:  CALL OPEN_CHUCK_1    ;
 167:   ;
 168:L P[20] 500mm/sec FINE    ;
 169:   ;
 170:   ;
 171:   ;
 172:J P[14] 30% CNT100    ;
 173:J P[15] 30% CNT100    ;
 174:J P[16] 30% CNT100    ;
 175:J P[17] 30% CNT100    ;
 176:   ;
 177:   ;
 178:   ;
 179:   ;
 180:   ;
 181:   ;
 182:   ;
 183:  JMP LBL[1] ;
 184:   ;
 185:  ENDIF ;
 186:  JMP LBL[1] ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -841.401  mm,	Y =  1032.239  mm,	Z =    35.724  mm,
	W =  -179.571 deg,	P =     1.245 deg,	R =     4.480 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -841.402  mm,	Y =  1032.239  mm,	Z =   110.201  mm,
	W =  -179.571 deg,	P =     1.245 deg,	R =     4.480 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -832.271  mm,	Y =   616.928  mm,	Z =   110.106  mm,
	W =   179.623 deg,	P =      .626 deg,	R =     1.230 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -848.038  mm,	Y =   319.642  mm,	Z =    90.190  mm,
	W =   179.999 deg,	P =      .262 deg,	R =    50.125 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -508.458  mm,	Y =    77.096  mm,	Z =    85.579  mm,
	W =   179.687 deg,	P =     -.537 deg,	R =   135.614 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -300.052  mm,	Y =   198.968  mm,	Z =    83.818  mm,
	W =   179.190 deg,	P =     -.562 deg,	R =  -178.092 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =   -77.538  mm,	Y =   618.412  mm,	Z =    82.127  mm,
	W =   179.190 deg,	P =     -.562 deg,	R =  -178.092 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -500.734  mm,	Y =    47.683  mm,	Z =   114.028  mm,
	W =    76.423 deg,	P =   -85.494 deg,	R =   -24.921 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -881.563  mm,	Y =   344.755  mm,	Z =   119.053  mm,
	W =    68.086 deg,	P =   -86.170 deg,	R =  -108.113 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -924.781  mm,	Y =   210.105  mm,	Z =    40.502  mm,
	W =  -168.984 deg,	P =   -62.097 deg,	R =   166.424 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -853.735  mm,	Y =   661.462  mm,	Z =    41.333  mm,
	W =  -167.691 deg,	P =   -61.758 deg,	R =    98.442 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -854.380  mm,	Y =   682.502  mm,	Z =    48.876  mm,
	W =  -179.048 deg,	P =     -.911 deg,	R =     2.604 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -832.271  mm,	Y =   616.928  mm,	Z =   110.106  mm,
	W =   179.623 deg,	P =      .626 deg,	R =     1.230 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -848.038  mm,	Y =   319.642  mm,	Z =    90.190  mm,
	W =   179.999 deg,	P =      .262 deg,	R =    50.125 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -508.458  mm,	Y =    77.096  mm,	Z =    85.579  mm,
	W =   179.687 deg,	P =     -.537 deg,	R =   135.614 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X =  -300.052  mm,	Y =   198.968  mm,	Z =    83.818  mm,
	W =   179.190 deg,	P =     -.562 deg,	R =  -178.092 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -318.485  mm,	Y =    88.377  mm,	Z =    83.818  mm,
	W =  -144.284 deg,	P =   -49.287 deg,	R =  -106.857 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X = -1060.429  mm,	Y =   575.118  mm,	Z =    35.571  mm,
	W =   179.638 deg,	P =      .621 deg,	R =     2.708 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X = -1084.044  mm,	Y =   573.581  mm,	Z =   -29.325  mm,
	W =   179.638 deg,	P =      .621 deg,	R =     2.708 deg
};
P[20]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, -1, 0',
	X = -1060.429  mm,	Y =   575.118  mm,	Z =    35.571  mm,
	W =   179.638 deg,	P =      .621 deg,	R =     2.708 deg
};
/END
