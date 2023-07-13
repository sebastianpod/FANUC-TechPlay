/PROG  JOB_MARPOSS_KOGAME_FC
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 11557;
CREATE		= DATE 20-07-17  TIME 10:56:04;
MODIFIED	= DATE 22-07-16  TIME 10:48:54;
FILE_NAME	= PR_VICI_;
VERSION		= 0;
LINE_COUNT	= 500;
MEMORY_SIZE	= 12157;
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
 114:J P[12] 100% CNT50 Offset,PR[20]    ;
 115:  !Dojazd do czesci ;
 116:J P[12] 100% FINE    ;
 117:  !Wywolanie zamkniecie chwytaka 2 ;
 118:  CALL CLOSE_CHUCK_2    ;
 119:  !Payload - oba chwytaki pelne ;
 120:  PAYLOAD[4] ;
 121:  !Opoznienie zabezpieczajace ;
 122:  WAIT    .20(sec) ;
 123:  !Pobieranie wyniku Marposs ;
 124:  CALL MARPOSS_RESULTS_CHECK    ;
 125:  !Przepisanie wartosci ;
 126:  R[9:part in chuck_2]=R[6:hommel checked]    ;
 127:  !Otwarcie cylindra Marposs ;
 128:  DO[147:cyl op/closed]=ON ;
 129:  !Czy cylinder w pozycji UP ;
 130:  WAIT DI[186:up cylinder marposs]=ON    ;
 131:  !Zerowanie licznika Marposs ;
 132:  R[6:hommel checked]=0    ;
 133:  !Offset w osi Z-wysokosc cylindra ;
 134:  PR[20,3]=12    ;
 135:  !Zerowanie offsetu osi Y ;
 136:  PR[20,2]=0    ;
 137:  !Odjazd z gore ;
 138:J P[12] 100% FINE Offset,PR[20]    ;
 139:  !Ustawienie offsetu ;
 140:  PR[20,2]=50    ;
 141:  !Pozycja nowej szt w osi cyl ;
 142:J P[12] 100% FINE Offset,PR[20]    ;
 143:  PR[20,1]=(-58)    ;
 144:J P[12] 100% FINE Offset,PR[20]    ;
 145:  PR[23]=LPOS-LPOS    ;
 146:  PR[23,2]=72    ;
 147:  PR[23,3]=5    ;
 148:  PR[22,3]=12    ;
 149:L P[13] 250mm/sec FINE Offset,PR[22]    ;
 150:L P[13] 100mm/sec FINE    ;
 151:  !Zamkniecie cylindra Marposs ;
 152:  DO[147:cyl op/closed]=OFF ;
 153:  !Czy cylinder w pozycji DOWN ;
 154:  WAIT DI[189:down cylinder marposs]=ON    ;
 155:  !Opoznienie zabezpieczajace ;
 156:  WAIT    .20(sec) ;
 157:  !Wywolanie otwarcia chwytaka 1 ;
 158:  CALL OPEN_CHUCK_1    ;
 159:  !Payload - chwytak 2 pelny ;
 160:  PAYLOAD[3] ;
 161:  !Przepisanie licznika ;
 162:  R[6:hommel checked]=R[9:part in chuck_2]+1    ;
 163:  R[6:hommel checked]=R[8:part in chuck_1]    ;
 164:  R[8:part in chuck_1]=0    ;
 165:  !Ustawienie offsetu ;
 166:  PR[22,2]=150    ;
 167:  !Wyjazd z Marposs ;
 168:L P[13] 4000mm/sec CNT100 Offset,PR[22]    ;
 169:  !Czy Marposs gotowy do pracy ;
 170:  WAIT DI[191:ready marposs]=ON    ;
 171:  !Jesli uruchomiaony SINTEC ;
 172:  IF (R[80:pc enable]=1) THEN ;
 173:  WAIT R[50:req pc marposs]=0    ;
 174:  WAIT R[52:ackn marposs pc]=0    ;
 175:  ENDIF ;
 176:  !??? ;
 177:  DO[11089]=OFF ;
 178:  DO[11090]=OFF ;
 179:  !??? ;
 180:  R[50:req pc marposs]=1    ;
 181:  !Start pomiaru Marposs ;
 182:  DO[148:start marposs]=ON ;
 183:  !Opoznienie sygnalowe ;
 184:  WAIT    .20(sec) ;
 185:  !Koniec trybu pomiaru Marposs ;
 186:  DO[148:start marposs]=OFF ;
 187:  !??? ;
 188:  IF (R[6:hommel checked] MOD 4=0) THEN ;
 189:  DO[11051]=ON ;
 190:  ENDIF ;
 191:  IF (R[6:hommel checked] MOD 4=1) THEN ;
 192:  DO[11052]=ON ;
 193:  ENDIF ;
 194:  IF (R[6:hommel checked] MOD 4=2) THEN ;
 195:  DO[11053]=ON ;
 196:  ENDIF ;
 197:  IF (R[6:hommel checked] MOD 4=3) THEN ;
 198:  DO[11064]=ON ;
 199:  ENDIF ;
 200:  !Ko-Ga-Me ;
 201:  !Wywolanie sciezki Marposs-Kogame ;
 202:  CALL PATH_MARPOSS_KOGAME    ;
 203:  !Pozycja startowa Kogame ;
 204:  CALL HOME_POS_KOGAME    ;
 205:  !Zerowanie licznika ;
 206:  R[8:part in chuck_1]=0    ;
 207:  !Pozycja posrednia ;
 208:J P[8] 100% CNT100    ;
 209:  !Czy Kogame gotowe do pracy ;
 210:  WAIT (DI[194:cmm out of area]=ON)    ;
 211:  !Dojazd po czesc ;
 212:L P[9] 4000mm/sec FINE    ;
 213:  !Wywolanie zamkniecia chwytaka 1 ;
 214:  CALL CLOSE_CHUCK_1    ;
 215:  !Payload - oba chwytaki pelne ;
 216:  PAYLOAD[4] ;
 217:  !Przepisanie licznika ;
 218:  R[8:part in chuck_1]=R[5:kogame checked]    ;
 219:  R[5:kogame checked]=0    ;
 220:  !Opoznienie zabezpieczajace ;
 221:  WAIT    .20(sec) ;
 222:  !Otwarcie zacisku Kogame ;
 223:  CALL KOGAME_OPEN_CHUCK    ;
 224:  !Czy otwarto zacisk ;
 225:  WAIT DI[198:open kog]=ON    ;
 226:  !Zerowanie offsetu ;
 227:  PR[21]=LPOS-LPOS    ;
 228:  !Ustawienie offsetu ;
 229:  PR[21,3]=70    ;
 230:  !Pozycjonowanie do zacisku ;
 231:L P[10] 2000mm/sec FINE    ;
 232:L P[14] 4000mm/sec FINE    ;
 233:  !Dojazd do zacisku ;
 234:L P[11] 500mm/sec FINE    ;
 235:  !Opoznienie zabezpieczajace ;
 236:  WAIT    .50(sec) ;
 237:  !Zamkniecie zacisku Kogame ;
 238:  CALL KOGAME_CLOSE_CHUCK    ;
 239:  !Opoznienie zabezpieczajace ;
 240:  WAIT    .20(sec) ;
 241:  !Wywolanie otwarcia chwytaka 2 ;
 242:  CALL OPEN_CHUCK_2    ;
 243:  !Opoznienie zabezpieczajace ;
 244:  WAIT    .50(sec) ;
 245:  !Przepisanie licznika ;
 246:  R[5:kogame checked]=R[9:part in chuck_2]    ;
 247:  R[9:part in chuck_2]=0    ;
 248:  !Payload - chwytak 1 pelny ;
 249:  PAYLOAD[2] ;
 250:  !Odjazd od zacisku ;
 251:L P[15] 4000mm/sec CNT100    ;
 252:  !Inicjacja Kogame ;
 253:  DO[154:ackn kog]=ON ;
 254:  !Jesli uruchomiony SINTEC ;
 255:  IF (R[80:pc enable]=1) THEN ;
 256:  WAIT R[53:req pc kog]=0    ;
 257:  WAIT R[55:ackn kog pc]=0    ;
 258:  ENDIF ;
 259:  !??? ;
 260:  DO[11049]=OFF ;
 261:  DO[11050]=OFF ;
 262:  !Start pomiaru Kogame ;
 263:  DO[153:start kog]=ON ;
 264:  !Opoznienie sygnalowe ;
 265:  WAIT    .50(sec) ;
 266:  !??? ;
 267:  IF (R[5:kogame checked] MOD 4=0) THEN ;
 268:  DO[11045]=ON ;
 269:  ENDIF ;
 270:  IF (R[5:kogame checked] MOD 4=1) THEN ;
 271:  DO[11046]=ON ;
 272:  ENDIF ;
 273:  IF (R[5:kogame checked] MOD 4=2) THEN ;
 274:  DO[11047]=ON ;
 275:  ENDIF ;
 276:  IF (R[5:kogame checked] MOD 4=3) THEN ;
 277:  DO[11048]=ON ;
 278:  ENDIF ;
 279:  !Functional station ;
 280:  !Uruchomienie dozownika oleju ;
 281:  DO[18:oil]=ON ;
 282:  !Koniec trybu pomiaru Kogame ;
 283:  DO[153:start kog]=OFF ;
 284:  !Zerowanie offsetu ;
 285:  PR[30]=LPOS-LPOS    ;
 286:  !Pozycje posrednie ;
 287:J P[3] 100% CNT100 RO[2]=ON    ;
 288:J P[4] 100% CNT100    ;
 289:  !Ustawienie offsetu ;
 290:  PR[30,2]=(-150)    ;
 291:  !Dojazd pod stacje ;
 292:J P[1] 100% CNT100    ;
 293:  !Czy zakonczono kontrole FC ;
 294:  WAIT DO[11004]=ON    ;
 295:  !Dojazd po czesc ;
 296:J P[19] 100% FINE    ;
 297:J P[18] 100% FINE    ;
 298:L P[5] 1000mm/sec FINE    ;
 299:  !Przepisanie wartosci licznika ;
 300:  R[9:part in chuck_2]=R[4:funct. checked]    ;
 301:  R[4:funct. checked]=0    ;
 302:  !Wywolanie zamkniecia chwytaka 2 ;
 303:  CALL CLOSE_CHUCK_2    ;
 304:  !Opoznienie zabezpieczajace ;
 305:  WAIT    .20(sec) ;
 306:  !Otwarcie zacisku FC ;
 307:  CALL FC_OPEN    ;
 308:  !Opoznienie zabezpieczajace ;
 309:  WAIT    .20(sec) ;
 310:  !Payload - oba chwytaki pelne ;
 311:  PAYLOAD[4] ;
 312:  !Zerowanie offsetu ;
 313:  PR[30,2]=0    ;
 314:  !Ustawienie offsetu ;
 315:  PR[30,3]=20    ;
 316:  !Odjazd nad zacisk ;
 317:L P[5] 1000mm/sec FINE Offset,PR[30]    ;
 318:  !Ustawienie offsetu ;
 319:  PR[30,1]=(-55)    ;
 320:  !Pozycjnowanie nad zaciskiem ;
 321:L P[2] 1000mm/sec CNT50    ;
 322:  !Dojazd do zacisku ;
 323:L P[6] 200mm/sec FINE    ;
 324:  !Opoznienie zabezpieczajace ;
 325:  WAIT    .30(sec) ;
 326:  !Wywolanie otwarcia chwytaka 1 ;
 327:  CALL OPEN_CHUCK_1    ;
 328:  !Opoznienie zabezpieczajace ;
 329:  WAIT    .30(sec) ;
 330:  !Payload - Chwytak 2 pelny ;
 331:  PAYLOAD[3] ;
 332:  !Zamkniecie zacisku FC ;
 333:  CALL FC_CLOSE    ;
 334:  !Opoznienie zabezpieczajace ;
 335:  WAIT    .30(sec) ;
 336:  !Pozycje posrednie ;
 337:J P[16] 100% FINE    ;
 338:J P[17] 100% CNT100    ;
 339:  !Odjazd od stacji FC ;
 340:J P[7] 100% CNT50    ;
 341:  !Ustawienie offsetu ;
 342:  PR[30,3]=(-110)    ;
 343:  PR[30,2]=0    ;
 344:  PR[30,1]=0    ;
 345:  !Odjazd od stolu FC ;
 346:L P[7] 2000mm/sec CNT50 Tool_Offset,PR[30]    ;
 347:  !Przepisanie stanu licznika ;
 348:  R[4:funct. checked]=R[8:part in chuck_1]+0    ;
 349:  R[8:part in chuck_1]=0    ;
 350:  !Jesli uruchomiono SINTEC ;
 351:  IF (R[80:pc enable]=1) THEN ;
 352:  WAIT R[56:req pc fc]=0    ;
 353:  WAIT R[58:ackn fc pc]=0    ;
 354:  ENDIF ;
 355:  !??? ;
 356:  DO[11074]=OFF ;
 357:  DO[11075]=OFF ;
 358:  DO[11007]=OFF ;
 359:  DO[11063]=OFF ;
 360:  !Inicjacja kontroli FC ;
 361:  DO[11009]=ON ;
 362:  !Opoznienie sygnalowe ;
 363:  WAIT    .10(sec) ;
 364:  !Stacja FC = OFF ;
 365:  DO[11009]=(OFF) ;
 366:  !Zamkniecie zaworu dozownik oleju ;
 367:  DO[18:oil]=OFF ;
 368:  !??? ;
 369:  IF (R[4:funct. checked] MOD 4=0) THEN ;
 370:  DO[11054]=ON ;
 371:  ENDIF ;
 372:  IF (R[4:funct. checked] MOD 4=1) THEN ;
 373:  DO[11055]=ON ;
 374:  ENDIF ;
 375:  IF (R[4:funct. checked] MOD 4=2) THEN ;
 376:  DO[11056]=ON ;
 377:  ENDIF ;
 378:  IF (R[4:funct. checked] MOD 4=3) THEN ;
 379:  DO[11065]=ON ;
 380:  ENDIF ;
 381:  !Final Check ;
 382:  !Sprawdzanie warunkow: OK czy NOK ;
 383:  IF (R[9:part in chuck_2] MOD 4=0) THEN ;
 384:  IF (R[90]=1 AND DO[11057]=ON AND DO[11058]=OFF AND DO[11081]=ON AND DO[11082]=OFF) THEN ;
 385:  R[30:part ok]=1    ;
 386:  R[31:part nok]=0    ;
 387:  R[90]=0    ;
 388:  DO[11097]=OFF ;
 389:  DO[11098]=OFF ;
 390:  DO[11057]=OFF ;
 391:  DO[11058]=OFF ;
 392:  DO[11081]=OFF ;
 393:  DO[11082]=OFF ;
 394:  R[32]=1    ;
 395:  ELSE ;
 396:  R[30:part ok]=0    ;
 397:  R[31:part nok]=1    ;
 398:  CALL DATA_COLLECT    ;
 399:  R[90]=0    ;
 400:  DO[11097]=OFF ;
 401:  DO[11098]=OFF ;
 402:  DO[11057]=OFF ;
 403:  DO[11058]=OFF ;
 404:  DO[11081]=OFF ;
 405:  DO[11082]=OFF ;
 406:  R[32]=1    ;
 407:  ENDIF ;
 408:  ENDIF ;
 409:  IF (R[9:part in chuck_2] MOD 4=1) THEN ;
 410:  IF (R[91]=1 AND DO[11059]=ON AND DO[11060]=OFF AND DO[11083]=ON AND DO[11084]=OFF) THEN ;
 411:  R[30:part ok]=1    ;
 412:  R[31:part nok]=0    ;
 413:  R[91]=0    ;
 414:  DO[11099]=OFF ;
 415:  DO[11100]=OFF ;
 416:  DO[11059]=OFF ;
 417:  DO[11060]=OFF ;
 418:  DO[11083]=OFF ;
 419:  DO[11084]=OFF ;
 420:  R[32]=1    ;
 421:  ELSE ;
 422:  R[30:part ok]=0    ;
 423:  R[31:part nok]=1    ;
 424:  DO[11099]=OFF ;
 425:  DO[11100]=OFF ;
 426:  DO[11059]=OFF ;
 427:  DO[11060]=OFF ;
 428:  DO[11083]=OFF ;
 429:  DO[11084]=OFF ;
 430:  R[32]=1    ;
 431:  ENDIF ;
 432:  ENDIF ;
 433:  IF (R[9:part in chuck_2] MOD 4=2) THEN ;
 434:  IF (R[92]=1 AND DO[11061]=ON AND DO[11062]=OFF AND DO[11085]=ON AND DO[11086]=OFF) THEN ;
 435:  R[30:part ok]=1    ;
 436:  R[31:part nok]=0    ;
 437:  R[92]=0    ;
 438:  DO[11101]=OFF ;
 439:  DO[11102]=OFF ;
 440:  DO[11061]=OFF ;
 441:  DO[11062]=OFF ;
 442:  DO[11085]=OFF ;
 443:  DO[11086]=OFF ;
 444:  R[32]=1    ;
 445:  ELSE ;
 446:  R[30:part ok]=0    ;
 447:  R[31:part nok]=1    ;
 448:  DO[11101]=OFF ;
 449:  DO[11102]=OFF ;
 450:  DO[11061]=OFF ;
 451:  DO[11062]=OFF ;
 452:  DO[11085]=OFF ;
 453:  DO[11086]=OFF ;
 454:  R[32]=1    ;
 455:  ENDIF ;
 456:  ENDIF ;
 457:  IF (R[9:part in chuck_2] MOD 4=3) THEN ;
 458:  IF (R[93]=1 AND DO[11021]=ON AND DO[11022]=OFF AND DO[11023]=ON AND DO[11024]=OFF) THEN ;
 459:  R[30:part ok]=1    ;
 460:  R[31:part nok]=0    ;
 461:  R[93]=0    ;
 462:  DO[11031]=OFF ;
 463:  DO[11032]=OFF ;
 464:  DO[11021]=OFF ;
 465:  DO[11022]=OFF ;
 466:  DO[11023]=OFF ;
 467:  DO[11024]=OFF ;
 468:  R[32]=1    ;
 469:  ELSE ;
 470:  R[30:part ok]=0    ;
 471:  R[31:part nok]=1    ;
 472:  DO[11031]=OFF ;
 473:  DO[11032]=OFF ;
 474:  DO[11021]=OFF ;
 475:  DO[11022]=OFF ;
 476:  DO[11023]=OFF ;
 477:  DO[11024]=OFF ;
 478:  R[32]=1    ;
 479:  ENDIF ;
 480:  ENDIF ;
 481:  !Odkladanie czesci ;
 482:  !Jezeli czesc OK ;
 483:  IF (R[30:part ok]=1 AND R[31:part nok]=0) THEN ;
 484:  !Wywolanie sciezki FC-Place OK ;
 485:  CALL PATH_FUNC_PLACE    ;
 486:  !Wywolanie prog odkladanie OK ;
 487:  CALL PLACE_PALET    ;
 488:  !Alternatywa ;
 489:  ELSE ;
 490:  !Wywolanie sciezki FC-SCRAP PAL ;
 491:  CALL PATH_FUNC_SCRAP    ;
 492:  !Wywolanie prog odkladanie NOK ;
 493:  CALL PLACE_SCRAP    ;
 494:  !Wywolanie sciezki SCRAP-PICK ;
 495:  CALL PATH_SCRAP_PICK    ;
 496:  !Powrot do poczatku petli pracy ;
 497:  JMP LBL[1] ;
 498:  ENDIF ;
 499:  !Powrot do poczatku petli pracy ;
 500:  JMP LBL[1] ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -626.992  mm,	Y =   852.358  mm,	Z =   -18.935  mm,
	W =   -53.806 deg,	P =   -89.265 deg,	R =   -53.955 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -516.060  mm,	Y =  1004.028  mm,	Z =    25.000  mm,
	W =    77.610 deg,	P =   -87.373 deg,	R =   172.049 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -955.191  mm,	Y =   462.280  mm,	Z =    12.968  mm,
	W =    85.563 deg,	P =   -84.476 deg,	R =   -78.952 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -707.928  mm,	Y =   847.578  mm,	Z =    13.198  mm,
	W =    84.436 deg,	P =   -85.186 deg,	R =  -136.124 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -567.927  mm,	Y =  1023.533  mm,	Z =      .868  mm,
	W =    77.587 deg,	P =   -87.371 deg,	R =   172.083 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -516.059  mm,	Y =  1004.028  mm,	Z =      .667  mm,
	W =    77.605 deg,	P =   -87.373 deg,	R =   172.054 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -531.660  mm,	Y =   949.057  mm,	Z =    11.488  mm,
	W =    77.575 deg,	P =   -87.372 deg,	R =   172.087 deg
};
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
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -574.162  mm,	Y =  -272.309  mm,	Z =    -9.500  mm,
	W =    96.313 deg,	P =   -85.126 deg,	R =    -8.081 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -629.083  mm,	Y =  -270.418  mm,	Z =    -8.769  mm,
	W =    96.374 deg,	P =   -85.122 deg,	R =    -8.143 deg
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
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -516.060  mm,	Y =  1004.027  mm,	Z =    16.110  mm,
	W =    77.606 deg,	P =   -87.373 deg,	R =   172.054 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -516.060  mm,	Y =   961.576  mm,	Z =    16.110  mm,
	W =    77.600 deg,	P =   -87.373 deg,	R =   172.059 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -567.927  mm,	Y =  1023.531  mm,	Z =    11.371  mm,
	W =    77.583 deg,	P =   -87.371 deg,	R =   172.087 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -572.847  mm,	Y =   993.133  mm,	Z =     9.865  mm,
	W =   -53.792 deg,	P =   -89.265 deg,	R =   -53.968 deg
};
/END
