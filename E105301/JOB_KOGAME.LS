/PROG  JOB_KOGAME
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 6466;
CREATE		= DATE 22-04-28  TIME 12:24:48;
MODIFIED	= DATE 23-07-06  TIME 15:09:02;
FILE_NAME	= JOB_MARP;
VERSION		= 0;
LINE_COUNT	= 299;
MEMORY_SIZE	= 7054;
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
   1:  !Wywolanie pozycji bezpiecznej ;
   2:  CALL HOME_POS    ;
   3:  !Stat-palety gotowe do deklaracji ;
   4:  R[43:pick up status]=6    ;
   5:  R[44:pick low status]=6    ;
   6:  R[45:place up status]=6    ;
   7:  R[46:place low status]=6    ;
   8:  !Zerowanie stanow wyjsc cyfrowych ;
   9:  DO[11007]=OFF ;
  10:  DO[11013]=OFF ;
  11:  DO[11014]=OFF ;
  12:  DO[11015]=OFF ;
  13:  DO[11021]=OFF ;
  14:  DO[11022]=OFF ;
  15:  DO[11023]=OFF ;
  16:  DO[11024]=OFF ;
  17:  DO[11031]=OFF ;
  18:  DO[11032]=OFF ;
  19:  DO[11036]=OFF ;
  20:  DO[11037]=OFF ;
  21:  DO[11041]=OFF ;
  22:  DO[11042]=OFF ;
  23:  DO[11043]=OFF ;
  24:  DO[11044]=OFF ;
  25:  DO[11045]=OFF ;
  26:  DO[11046]=OFF ;
  27:  DO[11047]=OFF ;
  28:  DO[11048]=OFF ;
  29:  DO[11049]=OFF ;
  30:  DO[11050]=OFF ;
  31:  DO[11051]=OFF ;
  32:  DO[11052]=OFF ;
  33:  DO[11053]=OFF ;
  34:  DO[11054]=OFF ;
  35:  DO[11055]=OFF ;
  36:  DO[11056]=OFF ;
  37:  DO[11057]=OFF ;
  38:  DO[11058]=OFF ;
  39:  DO[11059]=OFF ;
  40:  DO[11060]=OFF ;
  41:  DO[11061]=OFF ;
  42:  DO[11062]=OFF ;
  43:  DO[11063]=OFF ;
  44:  DO[11064]=OFF ;
  45:  DO[11065]=OFF ;
  46:  DO[11081]=OFF ;
  47:  DO[11082]=OFF ;
  48:  DO[11083]=OFF ;
  49:  DO[11084]=OFF ;
  50:  DO[11085]=OFF ;
  51:  DO[11086]=OFF ;
  52:  DO[11089]=OFF ;
  53:  DO[11090]=OFF ;
  54:  DO[11097]=OFF ;
  55:  DO[11098]=OFF ;
  56:  DO[11099]=OFF ;
  57:  DO[11100]=OFF ;
  58:  DO[11101]=OFF ;
  59:  DO[11102]=OFF ;
  60:  !??? ;
  61:  R[103:no of upper pick]=0    ;
  62:  R[104:no of lower pick]=0    ;
  63:  !Zerowanie poz. na pick palet ;
  64:  R[105:x axis place pal]=0    ;
  65:  R[106:y axis place pal]=0    ;
  66:  !??? ;
  67:  R[107:no of upper plae]=0    ;
  68:  R[108:no of lower plae]=0    ;
  69:  !Przygotowanie do deklaracji ;
  70:  R[109:wrk up pick pal]=1    ;
  71:  R[110:wrk low pick pal]=0    ;
  72:  R[111:wrk up place pal]=1    ;
  73:  R[112:wrk low place pl]=0    ;
  74:  !Zerowanie poz. na scrap palet ;
  75:  R[113:x axis scrap pal]=0    ;
  76:  R[114:y axis scrap pat]=0    ;
  77:  !??? ;
  78:  R[115]=1    ;
  79:  R[116]=0    ;
  80:  R[117]=3    ;
  81:  R[118]=0    ;
  82:  !Zerowanie poz. na pick palet ;
  83:  R[101:x axis pick pal]=0    ;
  84:  R[102:y axis pick pal]=0    ;
  85:  !Zerowanie rej pozycji pick palet ;
  86:  PR[10:pick pair off]=LPOS-LPOS    ;
  87:  PR[11:pick pair Z axis]=LPOS-LPOS    ;
  88:  PR[12:pick unpair off]=LPOS-LPOS    ;
  89:  PR[13:pick unpair Z ax]=LPOS-LPOS    ;
  90:  PR[14:place pair off]=LPOS-LPOS    ;
  91:  PR[15:place pair Z]=LPOS-LPOS    ;
  92:  PR[16:place unpair off]=LPOS-LPOS    ;
  93:  PR[17:place unpair Z]=LPOS-LPOS    ;
  94:  !Poczatek petli pracy ;
  95:  LBL[1] ;
  96:  !Wywolanie spr statusu palet ;
  97:  CALL FIX_PALET    ;
  98:  !Wywolanie prog pobieranie (pick) ;
  99:  CALL PICK_PALET    ;
 100:  CALL PATH_PICK_MARPOSS    ;
 101:  !Marposs ;
 102:  !Zerowanie rej poz dla Marposs ;
 103:  PR[20]=LPOS-LPOS    ;
 104:  PR[22]=LPOS-LPOS    ;
 105:  !Wywolanie poz startowej Marposs ;
 106:  CALL HOME_POS_MARPOSS    ;
 107:  !Ko-Ga-Me ;
 108:  !Wywolanie sciezki Marposs-Kogame ;
 109:  CALL PATH_MARPOSS_KOGAME    ;
 110:  !Pozycja startowa Kogame ;
 111:  CALL HOME_POS_KOGAME    ;
 112:  !Zerowanie licznika ;
 113:  R[8:part in chuck_1]=0    ;
 114:  !Pozycja posrednia ;
 115:J P[8] 100% CNT100    ;
 116:  !Czy Kogame gotowe do pracy ;
 117:  WAIT (DI[194:cmm out of area]=ON)    ;
 118:  !Dojazd po czesc ;
 119:L P[9] 4000mm/sec FINE    ;
 120:  !Wywolanie zamkniecia chwytaka 1 ;
 121:  CALL CLOSE_CHUCK_1    ;
 122:  !Payload - oba chwytaki pelne ;
 123:  PAYLOAD[4] ;
 124:  !Przepisanie licznika ;
 125:  R[8:part in chuck_1]=R[5:kogame checked]    ;
 126:  R[5:kogame checked]=0    ;
 127:  !Opoznienie zabezpieczajace ;
 128:  WAIT    .20(sec) ;
 129:  !Otwarcie zacisku Kogame ;
 130:  CALL KOGAME_OPEN_CHUCK    ;
 131:  !Czy otwarto zacisk ;
 132:  WAIT DI[198:open kog]=ON    ;
 133:  !Zerowanie offsetu ;
 134:  PR[21]=LPOS-LPOS    ;
 135:  !Ustawienie offsetu ;
 136:  PR[21,3]=70    ;
 137:  !Pozycjonowanie do zacisku ;
 138:L P[10] 2000mm/sec FINE    ;
 139:L P[14] 4000mm/sec FINE    ;
 140:  !Dojazd do zacisku ;
 141:L P[11] 500mm/sec FINE    ;
 142:  !Opoznienie zabezpieczajace ;
 143:  WAIT    .50(sec) ;
 144:  !Zamkniecie zacisku Kogame ;
 145:  CALL KOGAME_CLOSE_CHUCK    ;
 146:  !Opoznienie zabezpieczajace ;
 147:  WAIT    .20(sec) ;
 148:  !Wywolanie otwarcia chwytaka 2 ;
 149:  CALL OPEN_CHUCK_2    ;
 150:  !Opoznienie zabezpieczajace ;
 151:  WAIT    .50(sec) ;
 152:  !Przepisanie licznika ;
 153:  R[5:kogame checked]=R[9:part in chuck_2]    ;
 154:  R[9:part in chuck_2]=0    ;
 155:  !Payload - chwytak 1 pelny ;
 156:  PAYLOAD[2] ;
 157:  !Odjazd od zacisku ;
 158:L P[15] 4000mm/sec CNT100    ;
 159:  !Inicjacja Kogame ;
 160:  DO[154:ackn kog]=ON ;
 161:  !Jesli uruchomiony SINTEC ;
 162:  IF (R[80:pc enable]=1) THEN ;
 163:  WAIT R[53:req pc kog]=0    ;
 164:  WAIT R[55:ackn kog pc]=0    ;
 165:  ENDIF ;
 166:  !??? ;
 167:  DO[11049]=OFF ;
 168:  DO[11050]=OFF ;
 169:  !Start pomiaru Kogame ;
 170:  DO[153:start kog]=ON ;
 171:  !Opoznienie sygnalowe ;
 172:  WAIT    .50(sec) ;
 173:  !??? ;
 174:  IF (R[5:kogame checked] MOD 4=0) THEN ;
 175:  DO[11045]=ON ;
 176:  ENDIF ;
 177:  IF (R[5:kogame checked] MOD 4=1) THEN ;
 178:  DO[11046]=ON ;
 179:  ENDIF ;
 180:  IF (R[5:kogame checked] MOD 4=2) THEN ;
 181:  DO[11047]=ON ;
 182:  ENDIF ;
 183:  IF (R[5:kogame checked] MOD 4=3) THEN ;
 184:  DO[11048]=ON ;
 185:  ENDIF ;
 186:  !Final Check ;
 187:  !Sprawdzanie warunkow: OK czy NOK ;
 188:  IF (R[9:part in chuck_2] MOD 4=0) THEN ;
 189:  IF (DO[11057]=ON AND DO[11058]=OFF) THEN ;
 190:  R[30:part ok]=1    ;
 191:  R[31:part nok]=0    ;
 192:  DO[11097]=OFF ;
 193:  DO[11098]=OFF ;
 194:  DO[11057]=OFF ;
 195:  DO[11058]=OFF ;
 196:  DO[11081]=OFF ;
 197:  DO[11082]=OFF ;
 198:  R[32]=1    ;
 199:  ELSE ;
 200:  R[30:part ok]=0    ;
 201:  R[31:part nok]=1    ;
 202:  DO[11097]=OFF ;
 203:  DO[11098]=OFF ;
 204:  DO[11057]=OFF ;
 205:  DO[11058]=OFF ;
 206:  DO[11081]=OFF ;
 207:  DO[11082]=OFF ;
 208:  R[32]=1    ;
 209:  ENDIF ;
 210:  ENDIF ;
 211:  IF (R[9:part in chuck_2] MOD 4=1) THEN ;
 212:  IF (DO[11059]=ON AND DO[11060]=OFF) THEN ;
 213:  R[30:part ok]=1    ;
 214:  R[31:part nok]=0    ;
 215:  DO[11099]=OFF ;
 216:  DO[11100]=OFF ;
 217:  DO[11059]=OFF ;
 218:  DO[11060]=OFF ;
 219:  DO[11083]=OFF ;
 220:  DO[11084]=OFF ;
 221:  R[32]=1    ;
 222:  ELSE ;
 223:  R[30:part ok]=0    ;
 224:  R[31:part nok]=1    ;
 225:  DO[11099]=OFF ;
 226:  DO[11100]=OFF ;
 227:  DO[11059]=OFF ;
 228:  DO[11060]=OFF ;
 229:  DO[11083]=OFF ;
 230:  DO[11084]=OFF ;
 231:  R[32]=1    ;
 232:  ENDIF ;
 233:  ENDIF ;
 234:  IF (R[9:part in chuck_2] MOD 4=2) THEN ;
 235:  IF (DO[11061]=ON AND DO[11062]=OFF) THEN ;
 236:  R[30:part ok]=1    ;
 237:  R[31:part nok]=0    ;
 238:  DO[11101]=OFF ;
 239:  DO[11102]=OFF ;
 240:  DO[11061]=OFF ;
 241:  DO[11062]=OFF ;
 242:  DO[11085]=OFF ;
 243:  DO[11086]=OFF ;
 244:  R[32]=1    ;
 245:  ELSE ;
 246:  R[30:part ok]=0    ;
 247:  R[31:part nok]=1    ;
 248:  DO[11101]=OFF ;
 249:  DO[11102]=OFF ;
 250:  DO[11061]=OFF ;
 251:  DO[11062]=OFF ;
 252:  DO[11085]=OFF ;
 253:  DO[11086]=OFF ;
 254:  R[32]=1    ;
 255:  ENDIF ;
 256:  ENDIF ;
 257:  IF (R[9:part in chuck_2] MOD 4=3) THEN ;
 258:  IF (DO[11021]=ON AND DO[11022]=OFF) THEN ;
 259:  R[30:part ok]=1    ;
 260:  R[31:part nok]=0    ;
 261:  DO[11031]=OFF ;
 262:  DO[11032]=OFF ;
 263:  DO[11021]=OFF ;
 264:  DO[11022]=OFF ;
 265:  DO[11023]=OFF ;
 266:  DO[11024]=OFF ;
 267:  R[32]=1    ;
 268:  ELSE ;
 269:  R[30:part ok]=0    ;
 270:  R[31:part nok]=1    ;
 271:  DO[11031]=OFF ;
 272:  DO[11032]=OFF ;
 273:  DO[11021]=OFF ;
 274:  DO[11022]=OFF ;
 275:  DO[11023]=OFF ;
 276:  DO[11024]=OFF ;
 277:  R[32]=1    ;
 278:  ENDIF ;
 279:  ENDIF ;
 280:  !Odkladanie czesci ;
 281:  !Jezeli czesc OK ;
 282:  IF (R[30:part ok]=1 AND R[31:part nok]=0) THEN ;
 283:  !Wywolanie sciezki FC-Place OK ;
 284:  CALL PATH_KOG_PLACE    ;
 285:  !Wywolanie prog odkladanie OK ;
 286:  CALL PLACE_PALET    ;
 287:  !Alternatywa ;
 288:  ELSE ;
 289:  !Wywolanie sciezki FC-SCRAP PAL ;
 290:  CALL PATH_KOG_SCRAP    ;
 291:  !Wywolanie prog odkladanie NOK ;
 292:  CALL PLACE_SCRAP    ;
 293:  !Wywolanie sciezki SCRAP-PICK ;
 294:  CALL PATH_SCRAP_PICK    ;
 295:  !Powrot do poczatku petli pracy ;
 296:  JMP LBL[1] ;
 297:  ENDIF ;
 298:  !Powrot do poczatku petli pracy ;
 299:  JMP LBL[1] ;
/POS
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1261.284  mm,	Y =   196.656  mm,	Z =   104.652  mm,
	W =   -88.217 deg,	P =    84.298 deg,	R =    92.650 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1368.212  mm,	Y =   198.131  mm,	Z =   112.611  mm,
	W =   -88.246 deg,	P =    84.297 deg,	R =    92.621 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1370.458  mm,	Y =   197.103  mm,	Z =   161.232  mm,
	W =   -88.093 deg,	P =    84.783 deg,	R =    92.843 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1370.499  mm,	Y =   252.544  mm,	Z =   120.204  mm,
	W =   -89.378 deg,	P =    85.020 deg,	R =    91.538 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1369.229  mm,	Y =   252.522  mm,	Z =   162.459  mm,
	W =   -89.353 deg,	P =    85.020 deg,	R =    91.565 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1237.045  mm,	Y =   251.978  mm,	Z =   106.748  mm,
	W =   -61.584 deg,	P =    84.176 deg,	R =   119.221 deg
};
/END
