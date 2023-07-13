/PROG  JOB_KOGAME_FC
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 8531;
CREATE		= DATE 20-07-17  TIME 10:55:28;
MODIFIED	= DATE 21-03-25  TIME 08:51:32;
FILE_NAME	= PR_VICI_;
VERSION		= 0;
LINE_COUNT	= 370;
MEMORY_SIZE	= 9107;
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
 100:  !Wywolanie sciezki Pick-Kogame ;
 101:  CALL PATH_PICK_KOGAME    ;
 102:  !Pozycja startowa Kogame ;
 103:  CALL HOME_POS_KOGAME    ;
 104:  !Pozycja posrednia ;
 105:J P[1] 100% CNT100    ;
 106:  !Czy Kogame gotowe do pracy ;
 107:  WAIT (DI[194:cmm out of area]=ON)    ;
 108:  !Dojazd po czesc ;
 109:L P[2] 4000mm/sec FINE    ;
 110:  !Wywolanie zamkniecia chwytaka 2 ;
 111:  CALL CLOSE_CHUCK_2    ;
 112:  !Payload - oba chwytaki pelne ;
 113:  PAYLOAD[4] ;
 114:  !Przepisanie licznika ;
 115:  R[9:part in chuck_2]=R[5:kogame checked]    ;
 116:  !Opoznienie zabezpieczajace ;
 117:  WAIT    .20(sec) ;
 118:  !Otwarcie zacisku Kogame ;
 119:  CALL KOGAME_OPEN_CHUCK    ;
 120:  !Czy otwarto zacisk ;
 121:  WAIT DI[198:open kog]=ON    ;
 122:  !Zerowanie offsetu ;
 123:  PR[21]=LPOS-LPOS    ;
 124:  !Ustawienie offsetu ;
 125:  PR[21,3]=30    ;
 126:  !Pozycjonowanie do zacisku ;
 127:L P[2] 2000mm/sec FINE Offset,PR[21]    ;
 128:L P[4] 4000mm/sec FINE    ;
 129:  !Dojazd do zacisku ;
 130:L P[5] 500mm/sec FINE    ;
 131:  !Opoznienie zabezpieczajace ;
 132:  WAIT    .50(sec) ;
 133:  !Zamkniecie zacisku Kogame ;
 134:  CALL KOGAME_CLOSE_CHUCK    ;
 135:  !Opoznienie zabezpieczajace ;
 136:  WAIT    .20(sec) ;
 137:  !Wywolanie otwarcia chwytaka 1 ;
 138:  CALL OPEN_CHUCK_1    ;
 139:  !Przepisanie licznika czesci ;
 140:  R[5:kogame checked]=R[8:part in chuck_1]    ;
 141:  R[8:part in chuck_1]=0    ;
 142:  !Opoznienie zabezpieczajace ;
 143:  WAIT    .50(sec) ;
 144:  !Payload - chwytak 2 pelny ;
 145:  PAYLOAD[3] ;
 146:  !Odjazd od zacisku ;
 147:L P[6] 4000mm/sec CNT100    ;
 148:  !Inicjacja Kogame ;
 149:  DO[154:ackn kog]=ON ;
 150:  !Jesli uruchomiony SINTEC ;
 151:  IF (R[80:pc enable]=1) THEN ;
 152:  WAIT R[53:req pc kog]=0    ;
 153:  WAIT R[55:ackn kog pc]=0    ;
 154:  ENDIF ;
 155:  !??? ;
 156:  DO[11049]=OFF ;
 157:  DO[11050]=OFF ;
 158:  !Start pomiaru Kogame ;
 159:  DO[153:start kog]=ON ;
 160:  !Opoznienie sygnalowe ;
 161:  WAIT    .50(sec) ;
 162:  !??? ;
 163:  IF (R[5:kogame checked] MOD 4=0) THEN ;
 164:  DO[11045]=ON ;
 165:  ENDIF ;
 166:  IF (R[5:kogame checked] MOD 4=1) THEN ;
 167:  DO[11046]=ON ;
 168:  ENDIF ;
 169:  IF (R[5:kogame checked] MOD 4=2) THEN ;
 170:  DO[11047]=ON ;
 171:  ENDIF ;
 172:  IF (R[5:kogame checked] MOD 4=3) THEN ;
 173:  DO[11048]=ON ;
 174:  ENDIF ;
 175:  !Pozycja startowa Kogame ;
 176:  CALL HOME_POS_KOGAME    ;
 177:  !Functional station ;
 178:  !Uruchomienie dozownika oleju ;
 179:  DO[19:blow]=ON ;
 180:  !Koniec trybu pomiaru Kogame ;
 181:  DO[153:start kog]=OFF ;
 182:  !Zerowanie offsetu ;
 183:  PR[30]=LPOS-LPOS    ;
 184:  !Pozycje posrednie ;
 185:J P[7] 100% CNT100 RO[3]=ON    ;
 186:J P[8] 100% CNT100    ;
 187:  !Ustawienie offsetu ;
 188:  PR[30,2]=(-150)    ;
 189:  !Dojazd pod stacje ;
 190:J P[9] 100% CNT100    ;
 191:  !Czy zakonczono kontrole FC ;
 192:  WAIT DO[11004]=ON    ;
 193:  !Dojazd po czesc ;
 194:L P[10] 1000mm/sec FINE    ;
 195:  !Wywolanie zamkniecia chwytaka 1 ;
 196:  CALL CLOSE_CHUCK_1    ;
 197:  !Opoznienie zabezpieczajace ;
 198:  WAIT    .20(sec) ;
 199:  !Przepisanie licznika czesci ;
 200:  R[8:part in chuck_1]=R[4:funct. checked]    ;
 201:  !Otwarcie zacisku FC ;
 202:  CALL FC_OPEN    ;
 203:  !Opoznienie zabezpieczajace ;
 204:  WAIT    .20(sec) ;
 205:  !Payload - oba chwytaki pelne ;
 206:  PAYLOAD[4] ;
 207:  !Zerowanie offsetu ;
 208:  PR[30,2]=0    ;
 209:  !Ustawienie offsetu ;
 210:  PR[30,3]=14    ;
 211:  !Odjazd nad zacisk ;
 212:L P[10] 1000mm/sec FINE Offset,PR[30]    ;
 213:  !Ustawienie offsetu ;
 214:  PR[30,1]=(-55)    ;
 215:  !Pozycjnowanie nad zaciskiem ;
 216:L P[12] 1000mm/sec CNT50    ;
 217:  !Dojazd do zacisku ;
 218:L P[13] 200mm/sec FINE    ;
 219:  !Opoznienie zabezpieczajace ;
 220:  WAIT    .30(sec) ;
 221:  !Wywolanie otwarcia chwytaka 2 ;
 222:  CALL OPEN_CHUCK_2    ;
 223:  !Przepisanie licznika czesci ;
 224:  R[4:funct. checked]=R[9:part in chuck_2]    ;
 225:  R[9:part in chuck_2]=0    ;
 226:  !Opoznienie zabezpieczajace ;
 227:  WAIT    .30(sec) ;
 228:  !Payload - Chwytak 1 pelny ;
 229:  PAYLOAD[2] ;
 230:  !Zamkniecie zacisku FC ;
 231:  CALL FC_CLOSE    ;
 232:  !Opoznienie zabezpieczajace ;
 233:  WAIT    .30(sec) ;
 234:  !Odjazd od stacji FC ;
 235:J P[14] 100% CNT50    ;
 236:  !Ustawienie offsetu ;
 237:  PR[30,3]=(-110)    ;
 238:  PR[30,2]=0    ;
 239:  PR[30,1]=0    ;
 240:  !Odjazd od stolu FC ;
 241:L P[15] 2000mm/sec CNT50 Tool_Offset,PR[30]    ;
 242:  !Jesli uruchomiono SINTEC ;
 243:  IF (R[80:pc enable]=1) THEN ;
 244:  WAIT R[56:req pc fc]=0    ;
 245:  WAIT R[58:ackn fc pc]=0    ;
 246:  ENDIF ;
 247:  !??? ;
 248:  DO[11074]=OFF ;
 249:  DO[11075]=OFF ;
 250:  DO[11007]=OFF ;
 251:  DO[11063]=OFF ;
 252:  !Inicjacja kontroli FC ;
 253:  DO[11009]=ON ;
 254:  !Opoznienie sygnalowe ;
 255:  WAIT    .10(sec) ;
 256:  !Stacja FC = OFF ;
 257:  DO[11009]=(OFF) ;
 258:  !Zamkniecie zaworu dozownik oleju ;
 259:  DO[18:oil]=OFF ;
 260:  !??? ;
 261:  IF (R[4:funct. checked] MOD 4=0) THEN ;
 262:  DO[11054]=ON ;
 263:  ENDIF ;
 264:  IF (R[4:funct. checked] MOD 4=1) THEN ;
 265:  DO[11055]=ON ;
 266:  ENDIF ;
 267:  IF (R[4:funct. checked] MOD 4=2) THEN ;
 268:  DO[11056]=ON ;
 269:  ENDIF ;
 270:  IF (R[4:funct. checked] MOD 4=3) THEN ;
 271:  DO[11065]=ON ;
 272:  ENDIF ;
 273:  !Final Check ;
 274:  !Sprawdzanie warunkow: OK czy NOK ;
 275:  IF (R[8:part in chuck_1] MOD 4=0) THEN ;
 276:  IF (DO[11057]=ON AND DO[11058]=OFF AND DO[11081]=ON AND DO[11082]=OFF) THEN ;
 277:  R[30:part ok]=1    ;
 278:  R[31:part nok]=0    ;
 279:  DO[11057]=OFF ;
 280:  DO[11058]=OFF ;
 281:  DO[11081]=OFF ;
 282:  DO[11082]=OFF ;
 283:  R[32]=1    ;
 284:  ELSE ;
 285:  R[30:part ok]=0    ;
 286:  R[31:part nok]=1    ;
 287:  DO[11057]=OFF ;
 288:  DO[11058]=OFF ;
 289:  DO[11081]=OFF ;
 290:  DO[11082]=OFF ;
 291:  R[32]=1    ;
 292:  ENDIF ;
 293:  ENDIF ;
 294:  IF (R[9:part in chuck_2] MOD 4=1) THEN ;
 295:  IF (DO[11059]=ON AND DO[11060]=OFF AND DO[11083]=ON AND DO[11084]=OFF) THEN ;
 296:  R[30:part ok]=1    ;
 297:  R[31:part nok]=0    ;
 298:  DO[11059]=OFF ;
 299:  DO[11060]=OFF ;
 300:  DO[11083]=OFF ;
 301:  DO[11084]=OFF ;
 302:  R[32]=1    ;
 303:  ELSE ;
 304:  R[30:part ok]=0    ;
 305:  R[31:part nok]=1    ;
 306:  DO[11059]=OFF ;
 307:  DO[11060]=OFF ;
 308:  DO[11083]=OFF ;
 309:  DO[11084]=OFF ;
 310:  R[32]=1    ;
 311:  ENDIF ;
 312:  ENDIF ;
 313:  IF (R[9:part in chuck_2] MOD 4=2) THEN ;
 314:  IF (DO[11061]=ON AND DO[11062]=OFF AND DO[11085]=ON AND DO[11086]=OFF) THEN ;
 315:  R[30:part ok]=1    ;
 316:  R[31:part nok]=0    ;
 317:  DO[11061]=OFF ;
 318:  DO[11062]=OFF ;
 319:  DO[11085]=OFF ;
 320:  DO[11086]=OFF ;
 321:  R[32]=1    ;
 322:  ELSE ;
 323:  R[30:part ok]=0    ;
 324:  R[31:part nok]=1    ;
 325:  DO[11061]=OFF ;
 326:  DO[11062]=OFF ;
 327:  DO[11085]=OFF ;
 328:  DO[11086]=OFF ;
 329:  R[32]=1    ;
 330:  ENDIF ;
 331:  ENDIF ;
 332:  IF (R[8:part in chuck_1] MOD 2=1) THEN ;
 333:  IF (DO[11021]=ON AND DO[11022]=OFF AND DO[11023]=ON AND DO[11024]=OFF) THEN ;
 334:  R[30:part ok]=1    ;
 335:  R[31:part nok]=0    ;
 336:  DO[11021]=OFF ;
 337:  DO[11022]=OFF ;
 338:  DO[11023]=OFF ;
 339:  DO[11024]=OFF ;
 340:  R[32]=1    ;
 341:  ELSE ;
 342:  R[30:part ok]=0    ;
 343:  R[31:part nok]=1    ;
 344:  DO[11021]=OFF ;
 345:  DO[11022]=OFF ;
 346:  DO[11023]=OFF ;
 347:  DO[11024]=OFF ;
 348:  R[32]=1    ;
 349:  ENDIF ;
 350:  ENDIF ;
 351:  !Odkladanie czesci ;
 352:  !Jezeli czesc OK ;
 353:  IF (R[30:part ok]=1 AND R[31:part nok]=0) THEN ;
 354:  !Wywolanie sciezki FC-Place OK ;
 355:  CALL PATH_FUNC_PLACE    ;
 356:  !Wywolanie prog odkladanie OK ;
 357:  CALL PLACE_PALET_HAND1    ;
 358:  !Alternatywa ;
 359:  ELSE ;
 360:  !Wywolanie sciezki FC-SCRAP PAL ;
 361:  CALL PATH_FUNC_SCRAP    ;
 362:  !Wywolanie prog odkladanie NOK ;
 363:  CALL PLACE_SCRAP    ;
 364:  !Wywolanie sciezki SCRAP-PICK ;
 365:  CALL PATH_SCRAP_PICK    ;
 366:  !Powrot do poczatku petli pracy ;
 367:  JMP LBL[1] ;
 368:  ENDIF ;
 369:  !Powrot do poczatku petli pracy ;
 370:  JMP LBL[1] ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1261.283  mm,	Y =   250.512  mm,	Z =   104.652  mm,
	W =   -88.217 deg,	P =    84.298 deg,	R =    92.649 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1370.617  mm,	Y =   252.279  mm,	Z =   105.962  mm,
	W =   -88.273 deg,	P =    84.301 deg,	R =    92.596 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1368.602  mm,	Y =   197.062  mm,	Z =   136.000  mm,
	W =   -89.393 deg,	P =    85.021 deg,	R =    91.514 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1368.602  mm,	Y =   197.062  mm,	Z =   104.268  mm,
	W =   -89.393 deg,	P =    85.021 deg,	R =    91.514 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 1',
	X = -1233.143  mm,	Y =   197.156  mm,	Z =   104.656  mm,
	W =   -88.262 deg,	P =    84.300 deg,	R =    92.604 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -970.167  mm,	Y =   462.280  mm,	Z =    12.968  mm,
	W =    85.563 deg,	P =   -84.476 deg,	R =   -78.952 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -707.928  mm,	Y =   847.578  mm,	Z =    13.198  mm,
	W =    84.436 deg,	P =   -85.186 deg,	R =  -136.124 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -575.498  mm,	Y =   852.358  mm,	Z =     1.801  mm,
	W =   -53.788 deg,	P =   -89.265 deg,	R =   -53.973 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -516.056  mm,	Y =  1005.798  mm,	Z =    11.040  mm,
	W =    90.432 deg,	P =   -86.694 deg,	R =   161.888 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -569.757  mm,	Y =  1021.353  mm,	Z =    24.000  mm,
	W =    90.448 deg,	P =   -86.693 deg,	R =   161.878 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -569.757  mm,	Y =  1021.353  mm,	Z =    10.748  mm,
	W =    90.448 deg,	P =   -86.693 deg,	R =   161.878 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -583.369  mm,	Y =   958.271  mm,	Z =    10.743  mm,
	W =    90.456 deg,	P =   -86.693 deg,	R =   161.869 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -531.660  mm,	Y =   949.057  mm,	Z =    11.488  mm,
	W =    77.575 deg,	P =   -87.372 deg,	R =   172.087 deg
};
/END
