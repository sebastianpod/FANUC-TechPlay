/PROG  PLACE_PALET_HAND1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 7126;
CREATE		= DATE 21-03-24  TIME 12:17:24;
MODIFIED	= DATE 21-03-24  TIME 12:28:58;
FILE_NAME	= PLACE_PA;
VERSION		= 0;
LINE_COUNT	= 264;
MEMORY_SIZE	= 7646;
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
   1:  !Poczatek petli pracy programu ;
   2:  LBL[1] ;
   3:  !Zerowanie rej uniku ;
   4:  R[144:dodge on/off]=0    ;
   5:  !Zatrzymanie licznika czasu NOK ;
   6:  TIMER[2]=STOP ;
   7:  !Reset licznika czasu NOK ;
   8:  TIMER[2]=RESET ;
   9:  !Spr warunku - pusty pin ;
  10:  IF ((R[105:x axis place pal]=6 AND R[106:y axis place pal]=2) OR (R[105:x axis place pal]=16 AND R[106:y axis place pal]=2)) THEN ;
  11:  R[106:y axis place pal]=3    ;
  12:  ENDIF ;
  13:  !Ustawienie offsetow ;
  14:  PR[14,1:place pair off]=16.286*R[105:x axis place pal]    ;
  15:  PR[14,2:place pair off]=56.35*R[106:y axis place pal]    ;
  16:  PR[15:place pair Z]=PR[14:place pair off]    ;
  17:  PR[15,3:place pair Z]=PR[15,3:place pair Z]-50    ;
  18:  PR[16:place unpair off]=PR[14:place pair off]    ;
  19:  PR[16,2:place unpair off]=PR[16,2:place unpair off]+28.175    ;
  20:  PR[17:place unpair Z]=PR[16:place unpair off]    ;
  21:  PR[17,3:place unpair Z]=PR[17,3:place unpair Z]-50    ;
  22:  IF (R[111:wrk up place pal]=1) THEN ;
  23:  !Wywolanie UF palety upper place ;
  24:  UFRAME_NUM=3 ;
  25:  !Kontrola poprawnosci deklaracji ;
  26:  IF (R[45:place up status]<>4 AND R[45:place up status]<>5) THEN ;
  27:  !Komunikat dla operatora ;
  28:  MESSAGE[Ustaw R[45] = 4] ;
  29:  !Oczekiwanie na akcje operatora ;
  30:  WAIT R[45:place up status]=4    ;
  31:  ENDIF ;
  32:  !??? ;
  33:  DO[11043]=ON ;
  34:  !Spr warunku - rzad par/niepar ;
  35:  !Jesli nieparzysty ;
  36:  IF (R[105:x axis place pal] MOD 2=0) THEN ;
  37:  !Spr warunki - brak zakresu ruchu ;
  38:  IF ((R[105:x axis place pal]=20 AND R[106:y axis place pal]=3) OR (R[105:x axis place pal]=22 AND R[106:y axis place pal]=3)) THEN ;
  39:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  40:  R[106:y axis place pal]=0    ;
  41:  !Stat=wykonano unik ;
  42:  R[144:dodge on/off]=1    ;
  43:  ENDIF ;
  44:  !Spr warunku - czy koniec rzedu? ;
  45:  IF (R[106:y axis place pal]=5) THEN ;
  46:  !Inkrementacja - kolejny rzad ;
  47:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  48:  R[106:y axis place pal]=0    ;
  49:  !Powrot do poczatku petli pracy ;
  50:  JMP LBL[1] ;
  51:  ENDIF ;
  52:  !Pozycja posrednia ;
  53:J P[3] 100% CNT100    ;
  54:  !Dojazd nad pin do odkladania ;
  55:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  56:  !Dojazd dokladny ;
  57:L P[1] 250mm/sec FINE Offset,PR[14:place pair off]    ;
  58:  !Odlozenie czesci ;
  59:  CALL OPEN_CHUCK_1    ;
  60:  !Opoznienie zabezpieczajace ;
  61:  WAIT    .50(sec) ;
  62:  !Payload - oba chwytaki puste ;
  63:  PAYLOAD[1] ;
  64:  !Przepisanie wartosci licznika ;
  65:  R[2:parts ok]=R[9:part in chuck_2]    ;
  66:  R[9:part in chuck_2]=0    ;
  67:  !Jezeli uruchomiony Sintec ;
  68:  IF (R[80:pc enable]=1) THEN ;
  69:  R[59:req part ok plac]=1    ;
  70:  WAIT R[60:ackn part ok pld]=1    ;
  71:  R[59:req part ok plac]=0    ;
  72:  ENDIF ;
  73:  !Odjazd nad pin do odkladania ;
  74:L P[1] 500mm/sec FINE Offset,PR[15:place pair Z]    ;
  75:  !Pozycja posrednia ;
  76:J P[3] 100% CNT50    ;
  77:  !Inkrementacja po osi Y ;
  78:  !Spr warunku-czy pominieto rzad ;
  79:  IF (R[144:dodge on/off]<>1) THEN ;
  80:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
  81:  ENDIF ;
  82:  !Alternatywa - rzad parzysty ;
  83:  ELSE ;
  84:  !Spr warunku - brak zakresu ruchu ;
  85:  IF (R[105:x axis place pal]=21 AND R[106:y axis place pal]=2) THEN ;
  86:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  87:  R[106:y axis place pal]=0    ;
  88:  !Stat=wykonano unik ;
  89:  R[144:dodge on/off]=1    ;
  90:  ENDIF ;
  91:  !Inkrementacja - kolejny rzad ;
  92:  IF (R[106:y axis place pal]=4) THEN ;
  93:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  94:  R[106:y axis place pal]=0    ;
  95:  !Powrot do poczatku petli pracy ;
  96:  JMP LBL[1] ;
  97:  ENDIF ;
  98:  !Pozycja posrednia ;
  99:J P[3] 100% CNT100    ;
 100:  !Dojazd nad pin do odkladania ;
 101:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 102:  !Dojazd dokladny ;
 103:L P[1] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
 104:  !Odlozenie czesci ;
 105:  CALL OPEN_CHUCK_1    ;
 106:  !Opoznienie zabezpieczajace ;
 107:  WAIT    .50(sec) ;
 108:  !Payload - oba chwytaki puste ;
 109:  PAYLOAD[1] ;
 110:  !Przepisanie wartosc licznika ;
 111:  R[2:parts ok]=R[9:part in chuck_2]    ;
 112:  R[9:part in chuck_2]=0    ;
 113:  !Jezeli uruchomiony Sintec ;
 114:  IF (R[80:pc enable]=1) THEN ;
 115:  R[59:req part ok plac]=1    ;
 116:  WAIT R[60:ackn part ok pld]=1    ;
 117:  R[59:req part ok plac]=0    ;
 118:  ENDIF ;
 119:  !Odjazd nad pin do odkladania ;
 120:L P[1] 500mm/sec FINE Offset,PR[17:place unpair Z]    ;
 121:  !Inkrementacja po osi Y ;
 122:  //IF (R[144:dodge on/off]<>1) THEN ;
 123:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 124:  //ENDIF ;
 125:  !Pozycja posrednia ;
 126:J P[3] 100% CNT100    ;
 127:  !Inkr. globalnego licznika czesci ;
 128:  R[1:parts checked]=R[1:parts checked]+1    ;
 129:  !??? ;
 130:  DO[11043]=OFF ;
 131:  ENDIF ;
 132:  !Alternatywa - tacka dolna ;
 133:  ELSE ;
 134:  !Wywoladnie UF palety lower place ;
 135:  UFRAME_NUM=4 ;
 136:  !??? ;
 137:  DO[11044]=ON ;
 138:  !Kontrola poprawnosci deklaracji ;
 139:  IF (R[46:place low status]<>4 AND R[46:place low status]<>5) THEN ;
 140:  MESSAGE[Ustaw R[46]=4] ;
 141:  !Oczekiwanie na akcje operatora ;
 142:  WAIT R[46:place low status]=4    ;
 143:  ENDIF ;
 144:  !Pozycja posrednia ;
 145:J P[6] 100% CNT100    ;
 146:  !Spr warunku - rzad par/niepar ;
 147:  !Jesli nieparzysty ;
 148:  IF (R[105:x axis place pal] MOD 2=0) THEN ;
 149:  !Spr warunku - brak zakresu ruchu ;
 150:  IF (R[105:x axis place pal]=20 AND R[106:y axis place pal]=3 OR R[105:x axis place pal]=22 AND R[106:y axis place pal]=3) THEN ;
 151:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
 152:  R[106:y axis place pal]=0    ;
 153:  !Stat=wykonano unik ;
 154:  R[144:dodge on/off]=1    ;
 155:  ENDIF ;
 156:  !Spr warunku - czy koniec rzedu? ;
 157:  IF (R[106:y axis place pal]=5) THEN ;
 158:  !Inkrementacja - kolejcny rzad ;
 159:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
 160:  R[106:y axis place pal]=0    ;
 161:  !Powrot do poczatku petli pracy ;
 162:  JMP LBL[1] ;
 163:  ENDIF ;
 164:  !Dojazd nad pin do odkladania ;
 165:L P[2] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
 166:  !Dojazd dokladny ;
 167:L P[2] 250mm/sec FINE Offset,PR[14:place pair off]    ;
 168:  !Odlozenie czesci ;
 169:  CALL OPEN_CHUCK_1    ;
 170:  !Opoznienie zabezpieczajace ;
 171:  WAIT    .50(sec) ;
 172:  !Payload - oba chwytaki puste ;
 173:  PAYLOAD[1] ;
 174:  !Przepisanie wartosci licznika ;
 175:  R[2:parts ok]=R[9:part in chuck_2]    ;
 176:  R[9:part in chuck_2]=0    ;
 177:  !Jezeli uruchomiony Sintec? ;
 178:  IF (R[80:pc enable]=1) THEN ;
 179:  R[59:req part ok plac]=1    ;
 180:  WAIT R[60:ackn part ok pld]=1    ;
 181:  R[59:req part ok plac]=0    ;
 182:  ENDIF ;
 183:  !Odjazd nad pin do odkladania ;
 184:L P[2] 500mm/sec FINE Offset,PR[15:place pair Z]    ;
 185:  !Inkrementacja po osi Y ;
 186:  !Spr warunku-czy pominieto rzad ;
 187:  IF (R[144:dodge on/off]<>1) THEN ;
 188:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 189:  ENDIF ;
 190:  !Inkr globalnego licznika czesci ;
 191:  R[1:parts checked]=R[1:parts checked]+1    ;
 192:  ELSE ;
 193:  !Inkrementacja - kolejny rzad ;
 194:  IF (R[106:y axis place pal]=4) THEN ;
 195:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
 196:  R[106:y axis place pal]=0    ;
 197:  !Powrot do poczatku petli pracy ;
 198:  JMP LBL[1] ;
 199:  ENDIF ;
 200:  !Dojazd nad pin do odkladania ;
 201:L P[2] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 202:  !Dojazd dokladny ;
 203:L P[2] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
 204:  !Odlozenie czesci ;
 205:  CALL OPEN_CHUCK_1    ;
 206:  !Opoznienie zabezpieczajace ;
 207:  WAIT    .50(sec) ;
 208:  !Payload - oba chwytaki puste ;
 209:  PAYLOAD[1] ;
 210:  !Przepisanie licznika czesci ;
 211:  R[2:parts ok]=R[9:part in chuck_2]    ;
 212:  R[9:part in chuck_2]=0    ;
 213:  !Jezeli uruchomiony SINTEC ;
 214:  IF (R[80:pc enable]=1) THEN ;
 215:  R[59:req part ok plac]=1    ;
 216:  WAIT R[60:ackn part ok pld]=1    ;
 217:  R[59:req part ok plac]=0    ;
 218:  ENDIF ;
 219:  !Odjazd nad pin do odkladania ;
 220:L P[2] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 221:  !Inkrementacja po osi Y ;
 222:  !Spr warunku-czy pominieto rzad ;
 223:  IF (R[144:dodge on/off]<>1) THEN ;
 224:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 225:  ENDIF ;
 226:  !Inkr globalnego licznika czesci ;
 227:  R[1:parts checked]=R[1:parts checked]+1    ;
 228:  !??? ;
 229:  DO[11044]=OFF ;
 230:  ENDIF ;
 231:  !Pozycja posrednia ;
 232:J P[6] 100% CNT100    ;
 233:  !Wywolanie pozycji bezpiecznej ;
 234:  CALL HOME_POS    ;
 235:  ENDIF ;
 236:  !Jezeli ukonczono palete ;
 237:  IF (R[105:x axis place pal]=22 AND R[106:y axis place pal]=3) THEN ;
 238:  !Zerowanie osi X i Y ;
 239:  R[105:x axis place pal]=0    ;
 240:  R[106:y axis place pal]=0    ;
 241:  !Inkr globalnego licznika palet ;
 242:  R[10:id palet part ok]=R[10:id palet part ok]+1    ;
 243:  !Spr warunku - koniec palety gora ;
 244:  IF (R[111:wrk up place pal]=1) THEN ;
 245:  !Zmiana stat - paleta gora koniec ;
 246:  R[111:wrk up place pal]=0    ;
 247:  !Zmiana stat - paleta dol start ;
 248:  R[112:wrk low place pl]=1    ;
 249:  !Powrot palety gora do pozycji 0 ;
 250:  CALL PUSH_UPPER_PLACE_PALET    ;
 251:  !Wyjazd palety dol po pozycji 1 ;
 252:  CALL PULL_PLACE_LOWER_PALET    ;
 253:  !Alternatywa ;
 254:  ELSE ;
 255:  !Zmiana stat - paleta gora start ;
 256:  R[111:wrk up place pal]=1    ;
 257:  !Zmiana stst - paleta dol koniec ;
 258:  R[112:wrk low place pl]=0    ;
 259:  !Powrot palety dol do pozycji 0 ;
 260:  CALL PUSH_LOWER_PLACE_PALET    ;
 261:  !Wyjazd palety gora do pozycji 1 ;
 262:  CALL PULL_UPPER_PLACE_PALET    ;
 263:  ENDIF ;
 264:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =    -1.485  mm,	Y =     -.620  mm,	Z =    -9.680  mm,
	W =   -76.585 deg,	P =    87.339 deg,	R =   103.732 deg
};
P[2]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =    -2.239  mm,	Y =      .333  mm,	Z =    -7.821  mm,
	W =   -70.257 deg,	P =    87.113 deg,	R =   110.194 deg
};
P[3]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   478.302  mm,	Y =    90.610  mm,	Z =   -50.211  mm,
	W =  -133.709 deg,	P =    83.560 deg,	R =    42.811 deg
};
P[6]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   388.041  mm,	Y =    66.412  mm,	Z =   -86.165  mm,
	W =  -142.735 deg,	P =    88.261 deg,	R =    40.496 deg
};
/END
