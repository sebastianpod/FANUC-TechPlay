/PROG  PLACE_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 6166;
CREATE		= DATE 18-02-20  TIME 09:27:52;
MODIFIED	= DATE 22-02-23  TIME 12:04:30;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 225;
MEMORY_SIZE	= 6714;
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
/MN
   1:  !Poczatek petli pracy programu ;
   2:  LBL[1] ;
   3:  !Zatrzymanie licznika czasu NOK ;
   4:  TIMER[2]=STOP ;
   5:  !Reset licznika czasu NOK ;
   6:  TIMER[2]=RESET ;
   7:  !Ustawienie offsetow ;
   8:  PR[14,1:place pair off]=18*R[105:x axis place pal]    ;
   9:  PR[14,2:place pair off]=56.5*R[106:y axis place pal]    ;
  10:  PR[15:place pair Z]=PR[14:place pair off]    ;
  11:  PR[15,3:place pair Z]=PR[15,3:place pair Z]-45    ;
  12:  PR[16:place unpair off]=PR[14:place pair off]    ;
  13:  PR[16,2:place unpair off]=PR[16,2:place unpair off]+27.75    ;
  14:  PR[17:place unpair Z]=PR[16:place unpair off]    ;
  15:  PR[17,3:place unpair Z]=PR[17,3:place unpair Z]-45    ;
  16:  IF (R[111:wrk up place pal]=1) THEN ;
  17:  !Wywolanie UF palety upper place ;
  18:  UFRAME_NUM=3 ;
  19:  !Kontrola poprawnosci deklaracji ;
  20:  IF (R[45:place up status]<>4 AND R[45:place up status]<>5) THEN ;
  21:  !Komunikat dla operatora ;
  22:  MESSAGE[Ustaw R[45] = 4] ;
  23:  !Oczekiwanie na akcje operatora ;
  24:  WAIT R[45:place up status]=4    ;
  25:  ENDIF ;
  26:  !??? ;
  27:  DO[11043]=ON ;
  28:  !Spr warunku - rzad par/niepar ;
  29:  !Jesli nieparzysty ;
  30:  IF (R[105:x axis place pal] MOD 2=0) THEN ;
  31:  !Spr warunku - czy koniec rzedu? ;
  32:  IF (R[106:y axis place pal]=5 OR R[106:y axis place pal]=4 AND R[105:x axis place pal]=16 OR R[106:y axis place pal]=2 AND R[105:x axis place pal]=17) THEN ;
  33:  !Inkrementacja - kolejny rzad ;
  34:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  35:  R[106:y axis place pal]=0    ;
  36:  !Powrot do poczatku petli pracy ;
  37:  JMP LBL[1] ;
  38:  ENDIF ;
  39:  !Pozycja posrednia ;
  40:J P[3] 100% CNT100    ;
  41:  !Dojazd nad pin do odkladania ;
  42:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  43:  !Dojazd dokladny ;
  44:L P[1] 250mm/sec FINE Offset,PR[14:place pair off]    ;
  45:  !Odlozenie czesci ;
  46:  CALL OPEN_CHUCK_2    ;
  47:  !Opoznienie zabezpieczajace ;
  48:  WAIT    .50(sec) ;
  49:  !Payload - oba chwytaki puste ;
  50:  PAYLOAD[1] ;
  51:  !Przepisanie wartosci licznika ;
  52:  R[2:parts ok]=R[9:part in chuck_2]    ;
  53:  R[9:part in chuck_2]=0    ;
  54:  !Jezeli uruchomiony Sintec ;
  55:  IF (R[80:pc enable]=1) THEN ;
  56:  R[59:req part ok plac]=1    ;
  57:  WAIT R[60:ackn part ok pld]=1    ;
  58:  R[59:req part ok plac]=0    ;
  59:  ENDIF ;
  60:  !Odjazd nad pin do odkladania ;
  61:L P[1] 500mm/sec FINE Offset,PR[15:place pair Z]    ;
  62:  !Pozycja posrednia ;
  63:J P[3] 100% CNT50    ;
  64:  !Inkrementacja po osi Y ;
  65:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
  66:  !Alternatywa - rzad parzysty ;
  67:  ELSE ;
  68:  !Inkrementacja - kolejny rzad ;
  69:  IF (R[106:y axis place pal]=4 OR R[105:x axis place pal]=2 AND R[106:y axis place pal]=17) THEN ;
  70:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
  71:  R[106:y axis place pal]=0    ;
  72:  !Powrot do poczatku petli pracy ;
  73:  JMP LBL[1] ;
  74:  ENDIF ;
  75:  !Pozycja posrednia ;
  76:J P[3] 100% CNT100    ;
  77:  !Dojazd nad pin do odkladania ;
  78:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
  79:  !Dojazd dokladny ;
  80:L P[1] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
  81:  !Odlozenie czesci ;
  82:  CALL OPEN_CHUCK_2    ;
  83:  !Opoznienie zabezpieczajace ;
  84:  WAIT    .50(sec) ;
  85:  !Payload - oba chwytaki puste ;
  86:  PAYLOAD[1] ;
  87:  !Przepisanie wartosc licznika ;
  88:  R[2:parts ok]=R[9:part in chuck_2]    ;
  89:  R[9:part in chuck_2]=0    ;
  90:  !Jezeli uruchomiony Sintec ;
  91:  IF (R[80:pc enable]=1) THEN ;
  92:  R[59:req part ok plac]=1    ;
  93:  WAIT R[60:ackn part ok pld]=1    ;
  94:  R[59:req part ok plac]=0    ;
  95:  ENDIF ;
  96:  !Odjazd nad pin do odkladania ;
  97:L P[1] 500mm/sec FINE Offset,PR[17:place unpair Z]    ;
  98:  !Inkrementacja po osi Y ;
  99:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 100:  !Pozycja posrednia ;
 101:J P[3] 100% CNT100    ;
 102:  !Inkr. globalnego licznika czesci ;
 103:  R[1:parts checked]=R[1:parts checked]+1    ;
 104:  !??? ;
 105:  DO[11043]=OFF ;
 106:  ENDIF ;
 107:  !Alternatywa - tacka dolna ;
 108:  ELSE ;
 109:  !Wywoladnie UF palety lower place ;
 110:  UFRAME_NUM=4 ;
 111:  !??? ;
 112:  DO[11044]=ON ;
 113:  !Kontrola poprawnosci deklaracji ;
 114:  IF (R[46:place low status]<>4 AND R[46:place low status]<>5) THEN ;
 115:  MESSAGE[Ustaw R[46]=4] ;
 116:  !Oczekiwanie na akcje operatora ;
 117:  WAIT R[46:place low status]=4    ;
 118:  ENDIF ;
 119:  !Pozycja posrednia ;
 120:J P[6] 100% CNT100    ;
 121:  !Spr warunku - rzad par/niepar ;
 122:  !Jesli nieparzysty ;
 123:  IF (R[105:x axis place pal] MOD 2=0) THEN ;
 124:  !Spr warunku - czy koniec rzedu? ;
 125:  IF (R[106:y axis place pal]=5 OR R[106:y axis place pal]=4 AND R[105:x axis place pal]=16) THEN ;
 126:  !Inkrementacja - kolejcny rzad ;
 127:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
 128:  R[106:y axis place pal]=0    ;
 129:  !Powrot do poczatku petli pracy ;
 130:  JMP LBL[1] ;
 131:  ENDIF ;
 132:  !Dojazd nad pin do odkladania ;
 133:L P[2] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
 134:  !Dojazd dokladny ;
 135:L P[2] 250mm/sec FINE Offset,PR[14:place pair off]    ;
 136:  !Odlozenie czesci ;
 137:  CALL OPEN_CHUCK_2    ;
 138:  !Opoznienie zabezpieczajace ;
 139:  WAIT    .50(sec) ;
 140:  !Payload - oba chwytaki puste ;
 141:  PAYLOAD[1] ;
 142:  !Przepisanie wartosci licznika ;
 143:  R[2:parts ok]=R[9:part in chuck_2]    ;
 144:  R[9:part in chuck_2]=0    ;
 145:  !Jezeli uruchomiony Sintec? ;
 146:  IF (R[80:pc enable]=1) THEN ;
 147:  R[59:req part ok plac]=1    ;
 148:  WAIT R[60:ackn part ok pld]=1    ;
 149:  R[59:req part ok plac]=0    ;
 150:  ENDIF ;
 151:  !Odjazd nad pin do odkladania ;
 152:L P[2] 500mm/sec FINE Offset,PR[15:place pair Z]    ;
 153:  !Inkrementacja po osi Y ;
 154:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 155:  !Alternatywa - rzad parzysty ;
 156:  ELSE ;
 157:  !Inkrementacja - kolejny rzad ;
 158:  IF (R[106:y axis place pal]=4) THEN ;
 159:  R[105:x axis place pal]=R[105:x axis place pal]+1    ;
 160:  R[106:y axis place pal]=0    ;
 161:  !Powrot do poczatku petli pracy ;
 162:  JMP LBL[1] ;
 163:  ENDIF ;
 164:  !Dojazd nad pin do odkladania ;
 165:L P[2] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 166:  !Dojazd dokladny ;
 167:L P[2] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
 168:  !Odlozenie czesci ;
 169:  CALL OPEN_CHUCK_2    ;
 170:  !Opoznienie zabezpieczajace ;
 171:  WAIT    .50(sec) ;
 172:  !Payload - oba chwytaki puste ;
 173:  PAYLOAD[1] ;
 174:  !Przepisanie licznika czesci ;
 175:  R[2:parts ok]=R[9:part in chuck_2]    ;
 176:  R[9:part in chuck_2]=0    ;
 177:  !Jezeli uruchomiony SINTEC ;
 178:  IF (R[80:pc enable]=1) THEN ;
 179:  R[59:req part ok plac]=1    ;
 180:  WAIT R[60:ackn part ok pld]=1    ;
 181:  R[59:req part ok plac]=0    ;
 182:  ENDIF ;
 183:  !Odjazd nad pin do odkladania ;
 184:L P[2] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 185:  !Inkrementacja po osi Y ;
 186:  R[106:y axis place pal]=R[106:y axis place pal]+1    ;
 187:  !Inkr globalnego licznika czesci ;
 188:  R[1:parts checked]=R[1:parts checked]+1    ;
 189:  !??? ;
 190:  DO[11044]=OFF ;
 191:  ENDIF ;
 192:  !Pozycja posrednia ;
 193:J P[6] 100% CNT100    ;
 194:  !Wywolanie pozycji bezpiecznej ;
 195:  CALL HOME_POS    ;
 196:  ENDIF ;
 197:  !Jezeli ukonczono palete ;
 198:  IF (R[105:x axis place pal]=18 AND R[106:y axis place pal]=4) THEN ;
 199:  !Zerowanie osi X i Y ;
 200:  R[105:x axis place pal]=0    ;
 201:  R[106:y axis place pal]=0    ;
 202:  !Inkr globalnego licznika palet ;
 203:  R[10:id palet part ok]=R[10:id palet part ok]+1    ;
 204:  !Spr warunku - koniec palety gora ;
 205:  IF (R[111:wrk up place pal]=1) THEN ;
 206:  !Zmiana stat - paleta gora koniec ;
 207:  R[111:wrk up place pal]=0    ;
 208:  !Zmiana stat - paleta dol start ;
 209:  R[112:wrk low place pl]=1    ;
 210:  !Powrot palety gora do pozycji 0 ;
 211:  CALL PUSH_UPPER_PLACE_PALET    ;
 212:  !Wyjazd palety dol po pozycji 1 ;
 213:  CALL PULL_PLACE_LOWER_PALET    ;
 214:  !Alternatywa ;
 215:  ELSE ;
 216:  !Zmiana stat - paleta gora start ;
 217:  R[111:wrk up place pal]=1    ;
 218:  !Zmiana stst - paleta dol koniec ;
 219:  R[112:wrk low place pl]=0    ;
 220:  !Powrot palety dol do pozycji 0 ;
 221:  CALL PUSH_LOWER_PLACE_PALET    ;
 222:  !Wyjazd palety gora do pozycji 1 ;
 223:  CALL PULL_UPPER_PLACE_PALET    ;
 224:  ENDIF ;
 225:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =    -4.534  mm,	Y =    54.396  mm,	Z =    -9.684  mm,
	W =   -76.567 deg,	P =    87.332 deg,	R =   103.750 deg
};
P[2]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =    -3.276  mm,	Y =    52.360  mm,	Z =   -18.108  mm,
	W =   -70.233 deg,	P =    87.089 deg,	R =   110.217 deg
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
