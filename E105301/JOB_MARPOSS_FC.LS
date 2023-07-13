/PROG  JOB_MARPOSS_FC
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 9074;
CREATE		= DATE 20-07-17  TIME 10:54:26;
MODIFIED	= DATE 22-05-11  TIME 10:06:06;
FILE_NAME	= PR_VICI_;
VERSION		= 0;
LINE_COUNT	= 403;
MEMORY_SIZE	= 9630;
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
 107:  !Oczekiwanie na gotowosc Marposs ;
 108:  WAIT DI[191:ready marposs]=ON    ;
 109:  !Zerowanie licznika ;
 110:  R[9:part in chuck_2]=0    ;
 111:  !Ustawienie offsetu Marposs ;
 112:  PR[20,2]=32    ;
 113:  !Pozycja posrednia ;
 114:J P[1] 100% CNT50 Offset,PR[20]    ;
 115:  !Dojazd do czesci ;
 116:J P[2] 100% FINE    ;
 117:  !Wywolanie zamkniecie chwytaka 2 ;
 118:  CALL CLOSE_CHUCK_2    ;
 119:  !Payload - oba chwytaki pelne ;
 120:  PAYLOAD[4] ;
 121:  !Opoznienie zabezpieczajace ;
 122:  WAIT    .20(sec) ;
 123:  !Przepisanie wartosci ;
 124:  R[9:part in chuck_2]=R[6:hommel checked]    ;
 125:  !Otwarcie cylindra Marposs ;
 126:  DO[147:cyl op/closed]=ON ;
 127:  !Czy cylinder w pozycji UP ;
 128:  WAIT DI[186:up cylinder marposs]=ON    ;
 129:  !Zerowanie licznika Marposs ;
 130:  R[6:hommel checked]=0    ;
 131:  !Offset w osi Z-wysokosc cylindra ;
 132:  PR[20,3]=14    ;
 133:  !Zerowanie offsetu osi Y ;
 134:  PR[20,2]=0    ;
 135:  !Odjazd z gore ;
 136:J P[3] 100% FINE Offset,PR[20]    ;
 137:  !Ustawienie offsetu ;
 138:  PR[20,2]=50    ;
 139:  !Pozycja nowej szt w osi cyl ;
 140:J P[3] 100% FINE Offset,PR[20]    ;
 141:  PR[20,1]=(-58)    ;
 142:J P[3] 100% FINE Offset,PR[20]    ;
 143:  PR[23]=LPOS-LPOS    ;
 144:  PR[23,2]=72    ;
 145:  PR[23,3]=5    ;
 146:  PR[22,3]=20    ;
 147:L P[4] 250mm/sec FINE Offset,PR[22]    ;
 148:L P[5] 100mm/sec FINE    ;
 149:  !Zamkniecie cylindra Marposs ;
 150:  DO[147:cyl op/closed]=OFF ;
 151:  !Czy cylinder w pozycji DOWN ;
 152:  WAIT DI[189:down cylinder marposs]=ON    ;
 153:  !Wywolanie otwarcia chwytaka 1 ;
 154:  CALL OPEN_CHUCK_1    ;
 155:  !Payload - chwytak 2 pelny ;
 156:  PAYLOAD[3] ;
 157:  !Przepisanie licznika ;
 158:  R[6:hommel checked]=R[9:part in chuck_2]+1    ;
 159:  R[6:hommel checked]=R[8:part in chuck_1]    ;
 160:  R[8:part in chuck_1]=0    ;
 161:  !Ustawienie offsetu ;
 162:  PR[22,2]=150    ;
 163:  !Wyjazd z Marposs ;
 164:L P[5] 4000mm/sec CNT100 Offset,PR[22]    ;
 165:  !Czy Marposs gotowy do pracy ;
 166:  WAIT DI[191:ready marposs]=ON    ;
 167:  !Jesli uruchomiaony SINTEC ;
 168:  IF (R[80:pc enable]=1) THEN ;
 169:  WAIT R[50:req pc marposs]=0    ;
 170:  WAIT R[52:ackn marposs pc]=0    ;
 171:  ENDIF ;
 172:  !??? ;
 173:  DO[11089]=OFF ;
 174:  DO[11090]=OFF ;
 175:  !??? ;
 176:  R[50:req pc marposs]=1    ;
 177:  !Start pomiaru Marposs ;
 178:  DO[148:start marposs]=ON ;
 179:  !Opoznienie sygnalowe ;
 180:  WAIT    .20(sec) ;
 181:  !Koniec trybu pomiaru Marposs ;
 182:  DO[148:start marposs]=OFF ;
 183:  !??? ;
 184:  IF (R[6:hommel checked] MOD 4=0) THEN ;
 185:  DO[11051]=ON ;
 186:  ENDIF ;
 187:  IF (R[6:hommel checked] MOD 4=1) THEN ;
 188:  DO[11052]=ON ;
 189:  ENDIF ;
 190:  IF (R[6:hommel checked] MOD 4=2) THEN ;
 191:  DO[11053]=ON ;
 192:  ENDIF ;
 193:  IF (R[6:hommel checked] MOD 4=3) THEN ;
 194:  DO[11064]=ON ;
 195:  ENDIF ;
 196:  !Functional station ;
 197:  !Uruchomienie dozownika oleju ;
 198:  DO[18:oil]=ON ;
 199:  !Zerowanie offsetu ;
 200:  PR[30]=LPOS-LPOS    ;
 201:  !Pozycje posrednie ;
 202:J P[9] 100% CNT100 RO[2]=OFF    ;
 203:J P[10] 100% CNT100    ;
 204:  !Ustawienie offsetu ;
 205:  PR[30,2]=(-150)    ;
 206:  !Dojazd pod stacje ;
 207:J P[11] 100% CNT100    ;
 208:  !Czy zakonczono kontrole FC ;
 209:  WAIT DO[11004]=ON    ;
 210:  !Dojazd po czesc ;
 211:L P[12] 1000mm/sec FINE    ;
 212:  !Przepisanie wartosci licznika ;
 213:  R[9:part in chuck_2]=R[4:funct. checked]    ;
 214:  R[4:funct. checked]=0    ;
 215:  !Wywolanie zamkniecia chwytaka 1 ;
 216:  CALL CLOSE_CHUCK_1    ;
 217:  !Opoznienie zabezpieczajace ;
 218:  WAIT    .20(sec) ;
 219:  !Otwarcie zacisku FC ;
 220:  CALL FC_OPEN    ;
 221:  !Opoznienie zabezpieczajace ;
 222:  WAIT    .20(sec) ;
 223:  !Payload - oba chwytaki pelne ;
 224:  PAYLOAD[4] ;
 225:  !Zerowanie offsetu ;
 226:  PR[30,2]=0    ;
 227:  !Ustawienie offsetu ;
 228:  PR[30,3]=14    ;
 229:  !Odjazd nad zacisk ;
 230:L P[12] 1000mm/sec FINE Offset,PR[30]    ;
 231:  !Ustawienie offsetu ;
 232:  PR[30,1]=(-55)    ;
 233:  !Pozycjnowanie nad zaciskiem ;
 234:L P[14] 1000mm/sec CNT50    ;
 235:  !Dojazd do zacisku ;
 236:L P[15] 200mm/sec FINE    ;
 237:  !Opoznienie zabezpieczajace ;
 238:  WAIT    .30(sec) ;
 239:  !Wywolanie otwarcia chwytaka 2 ;
 240:  CALL OPEN_CHUCK_2    ;
 241:  !Opoznienie zabezpieczajace ;
 242:  WAIT    .30(sec) ;
 243:  !Payload - Chwytak 2 pelny ;
 244:  PAYLOAD[3] ;
 245:  !Zamkniecie zacisku FC ;
 246:  CALL FC_CLOSE    ;
 247:  !Opoznienie zabezpieczajace ;
 248:  WAIT    .30(sec) ;
 249:  !Odjazd od stacji FC ;
 250:J P[16] 100% CNT50    ;
 251:  !Ustawienie offsetu ;
 252:  PR[30,3]=(-50)    ;
 253:  PR[30,2]=0    ;
 254:  PR[30,1]=0    ;
 255:  !Odjazd od stolu FC ;
 256:L P[16] 2000mm/sec CNT50 Tool_Offset,PR[30]    ;
 257:  !Przepisanie stanu licznika ;
 258:  R[4:funct. checked]=R[8:part in chuck_1]+0    ;
 259:  R[8:part in chuck_1]=0    ;
 260:  !Jesli uruchomiono SINTEC ;
 261:  IF (R[80:pc enable]=1) THEN ;
 262:  WAIT R[56:req pc fc]=0    ;
 263:  WAIT R[58:ackn fc pc]=0    ;
 264:  ENDIF ;
 265:  !??? ;
 266:  DO[11074]=OFF ;
 267:  DO[11075]=OFF ;
 268:  DO[11007]=OFF ;
 269:  DO[11063]=OFF ;
 270:  !Inicjacja kontroli FC ;
 271:  DO[11009]=ON ;
 272:  !Opoznienie sygnalowe ;
 273:  WAIT    .10(sec) ;
 274:  !Stacja FC = OFF ;
 275:  DO[11009]=(OFF) ;
 276:  !Zamkniecie zaworu dozownik oleju ;
 277:  DO[18:oil]=OFF ;
 278:  !??? ;
 279:  IF (R[4:funct. checked] MOD 4=0) THEN ;
 280:  DO[11054]=ON ;
 281:  ENDIF ;
 282:  IF (R[4:funct. checked] MOD 4=1) THEN ;
 283:  DO[11055]=ON ;
 284:  ENDIF ;
 285:  IF (R[4:funct. checked] MOD 4=2) THEN ;
 286:  DO[11056]=ON ;
 287:  ENDIF ;
 288:  IF (R[4:funct. checked] MOD 4=3) THEN ;
 289:  DO[11065]=ON ;
 290:  ENDIF ;
 291:  !Final Check ;
 292:  !Sprawdzanie warunkow: OK czy NOK ;
 293:  IF (R[8:part in chuck_1] MOD 4=0) THEN ;
 294:  IF (DO[11097]=ON AND DO[11098]=OFF AND DO[11081]=ON AND DO[11082]=OFF) THEN ;
 295:  R[30:part ok]=1    ;
 296:  R[31:part nok]=0    ;
 297:  DO[11097]=OFF ;
 298:  DO[11098]=OFF ;
 299:  DO[11057]=OFF ;
 300:  DO[11058]=OFF ;
 301:  DO[11081]=OFF ;
 302:  DO[11082]=OFF ;
 303:  R[32]=1    ;
 304:  ELSE ;
 305:  R[30:part ok]=0    ;
 306:  R[31:part nok]=1    ;
 307:  DO[11097]=OFF ;
 308:  DO[11098]=OFF ;
 309:  DO[11057]=OFF ;
 310:  DO[11058]=OFF ;
 311:  DO[11081]=OFF ;
 312:  DO[11082]=OFF ;
 313:  R[32]=1    ;
 314:  ENDIF ;
 315:  ENDIF ;
 316:  IF (R[8:part in chuck_1] MOD 4=1) THEN ;
 317:  IF (DO[11099]=ON AND DO[11100]=OFF AND DO[11083]=ON AND DO[11084]=OFF) THEN ;
 318:  R[30:part ok]=1    ;
 319:  R[31:part nok]=0    ;
 320:  DO[11099]=OFF ;
 321:  DO[11100]=OFF ;
 322:  DO[11059]=OFF ;
 323:  DO[11060]=OFF ;
 324:  DO[11083]=OFF ;
 325:  DO[11084]=OFF ;
 326:  R[32]=1    ;
 327:  ELSE ;
 328:  R[30:part ok]=0    ;
 329:  R[31:part nok]=1    ;
 330:  DO[11099]=OFF ;
 331:  DO[11100]=OFF ;
 332:  DO[11059]=OFF ;
 333:  DO[11060]=OFF ;
 334:  DO[11083]=OFF ;
 335:  DO[11084]=OFF ;
 336:  R[32]=1    ;
 337:  ENDIF ;
 338:  ENDIF ;
 339:  IF (R[8:part in chuck_1] MOD 4=2) THEN ;
 340:  IF (DO[11101]=ON AND DO[11102]=OFF AND DO[11085]=ON AND DO[11086]=OFF) THEN ;
 341:  R[30:part ok]=1    ;
 342:  R[31:part nok]=0    ;
 343:  DO[11101]=OFF ;
 344:  DO[11102]=OFF ;
 345:  DO[11061]=OFF ;
 346:  DO[11062]=OFF ;
 347:  DO[11085]=OFF ;
 348:  DO[11086]=OFF ;
 349:  ELSE ;
 350:  R[30:part ok]=0    ;
 351:  R[31:part nok]=1    ;
 352:  DO[11101]=OFF ;
 353:  DO[11102]=OFF ;
 354:  DO[11061]=OFF ;
 355:  DO[11062]=OFF ;
 356:  DO[11085]=OFF ;
 357:  DO[11086]=OFF ;
 358:  R[32]=1    ;
 359:  ENDIF ;
 360:  ENDIF ;
 361:  IF (R[8:part in chuck_1] MOD 4=3) THEN ;
 362:  IF (DO[11031]=ON AND DO[11032]=OFF AND DO[11023]=ON AND DO[11024]=OFF) THEN ;
 363:  R[30:part ok]=1    ;
 364:  R[31:part nok]=0    ;
 365:  DO[11031]=OFF ;
 366:  DO[11032]=OFF ;
 367:  DO[11021]=OFF ;
 368:  DO[11022]=OFF ;
 369:  DO[11023]=OFF ;
 370:  DO[11024]=OFF ;
 371:  R[32]=1    ;
 372:  ELSE ;
 373:  R[30:part ok]=0    ;
 374:  R[31:part nok]=1    ;
 375:  DO[11031]=OFF ;
 376:  DO[11032]=OFF ;
 377:  DO[11021]=OFF ;
 378:  DO[11022]=OFF ;
 379:  DO[11023]=OFF ;
 380:  DO[11024]=OFF ;
 381:  R[32]=1    ;
 382:  ENDIF ;
 383:  ENDIF ;
 384:  !Odkladanie czesci ;
 385:  !Jezeli czesc OK ;
 386:  IF (R[30:part ok]=1 AND R[31:part nok]=0) THEN ;
 387:  !Wywolanie sciezki FC-Place OK ;
 388:  CALL PATH_FUNC_PLACE    ;
 389:  !Wywolanie prog odkladanie OK ;
 390:  CALL PLACE_PALET    ;
 391:  !Alternatywa ;
 392:  ELSE ;
 393:  !Wywolanie sciezki FC-SCRAP PAL ;
 394:  CALL PATH_FUNC_SCRAP    ;
 395:  !Wywolanie prog odkladanie NOK ;
 396:  CALL PLACE_SCRAP    ;
 397:  !Wywolanie sciezki SCRAP-PICK ;
 398:  CALL PATH_SCRAP_PICK    ;
 399:  !Powrot do poczatku petli pracy ;
 400:  JMP LBL[1] ;
 401:  ENDIF ;
 402:  !Powrot do poczatku petli pracy ;
 403:  JMP LBL[1] ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -545.451  mm,	Y =  -161.773  mm,	Z =   -33.904  mm,
	W =    91.935 deg,	P =   -84.485 deg,	R =    -3.668 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -547.275  mm,	Y =  -331.271  mm,	Z =   -71.056  mm,
	W =   136.794 deg,	P =   -88.300 deg,	R =   -48.505 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -547.275  mm,	Y =  -331.272  mm,	Z =   -71.056  mm,
	W =   136.794 deg,	P =   -88.300 deg,	R =   -48.504 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -602.275  mm,	Y =  -331.272  mm,	Z =   -71.056  mm,
	W =   136.794 deg,	P =   -88.300 deg,	R =   -48.504 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -602.275  mm,	Y =  -329.601  mm,	Z =   -70.179  mm,
	W =   136.792 deg,	P =   -88.300 deg,	R =   -48.503 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -970.167  mm,	Y =   462.280  mm,	Z =    12.968  mm,
	W =    85.563 deg,	P =   -84.476 deg,	R =   -78.952 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -519.126  mm,	Y =   757.162  mm,	Z =    13.269  mm,
	W =    86.731 deg,	P =   -85.478 deg,	R =  -162.152 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -504.753  mm,	Y =   862.933  mm,	Z =    10.822  mm,
	W =    87.264 deg,	P =   -85.492 deg,	R =  -169.082 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -521.475  mm,	Y =   955.606  mm,	Z =   -13.665  mm,
	W =  -137.050 deg,	P =   -89.462 deg,	R =    33.977 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -576.945  mm,	Y =   966.493  mm,	Z =      .335  mm,
	W =  -137.034 deg,	P =   -89.462 deg,	R =    33.960 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -574.353  mm,	Y =   965.973  mm,	Z =   -14.179  mm,
	W =  -137.029 deg,	P =   -89.462 deg,	R =    33.956 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -585.136  mm,	Y =   916.260  mm,	Z =   -14.193  mm,
	W =  -137.088 deg,	P =   -89.461 deg,	R =    34.015 deg
};
/END
