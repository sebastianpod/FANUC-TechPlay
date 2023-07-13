/PROG  PICK_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 5190;
CREATE		= DATE 18-06-26  TIME 15:08:10;
MODIFIED	= DATE 22-01-11  TIME 14:20:46;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 180;
MEMORY_SIZE	= 5530;
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
   1:  !Wywolanie pozycji bezpiecznej ;
   2:  CALL HOME_POS    ;
   3:  !Zatrzymanie licznika OK ;
   4:  TIMER[1]=STOP ;
   5:  !Zatrzymanie licznika NOK ;
   6:  TIMER[2]=STOP ;
   7:  !Spr warunku - koniec palety ;
   8:  IF (R[101:x axis pick pal]=20 AND R[102:y axis pick pal]=5) THEN ;
   9:  !Zerowanie osi X palety ;
  10:  R[101:x axis pick pal]=0    ;
  11:  !Zerowanie osi Y palety ;
  12:  R[102:y axis pick pal]=0    ;
  13:  !Spr warunku - koniec palety gora ;
  14:  IF (R[109:wrk up pick pal]=1) THEN ;
  15:  !Zmiana stat - paleta gora koniec ;
  16:  R[109:wrk up pick pal]=0    ;
  17:  !Zmiana stat - paleta dol start ;
  18:  R[110:wrk low pick pal]=1    ;
  19:  !Powrot palety gora do poz 0 ;
  20:  CALL PUSH_UPPER_PALET    ;
  21:  !Wyjazd palety dol do poz 1 ;
  22:  CALL PULL_LOWER_PALET    ;
  23:  !Alternatywa ;
  24:  ELSE ;
  25:  !Zmiana stat - paleta gora start ;
  26:  R[109:wrk up pick pal]=1    ;
  27:  !Zmiana stat - paleta dol koniec ;
  28:  R[110:wrk low pick pal]=0    ;
  29:  !Powrot palety dol do poz 0 ;
  30:  CALL PUSH_LOWER_PALET    ;
  31:  !Wyjazd palety gora do poz 1 ;
  32:  CALL PULL_UPPER_PALET    ;
  33:  ENDIF ;
  34:  ENDIF ;
  35:  !Inkr: rzad+1 jezeli nieparzysty ;
  36:  IF (R[101:x axis pick pal] MOD 2=0 AND R[102:y axis pick pal]=5) THEN ;
  37:  R[101:x axis pick pal]=R[101:x axis pick pal]+1    ;
  38:  R[102:y axis pick pal]=0    ;
  39:  ENDIF ;
  40:  !Inkr: rzad+1 jezeli parzysty ;
  41:  IF (R[101:x axis pick pal] MOD 2=1 AND R[102:y axis pick pal]=4) THEN ;
  42:  R[101:x axis pick pal]=R[101:x axis pick pal]+1    ;
  43:  R[102:y axis pick pal]=0    ;
  44:  ENDIF ;
  45:  !Ustawienie wartosci offsetow ;
  46:  PR[10,1:pick pair off]=18.1*R[101:x axis pick pal]    ;
  47:  PR[10,2:pick pair off]=56.75*R[102:y axis pick pal]    ;
  48:  PR[11:pick pair Z axis]=PR[10:pick pair off]    ;
  49:  PR[11,3:pick pair Z axis]=PR[11,3:pick pair Z axis]+80    ;
  50:  PR[12:pick unpair off]=PR[10:pick pair off]    ;
  51:  PR[12,2:pick unpair off]=PR[10,2:pick pair off]+28    ;
  52:  PR[13:pick unpair Z ax]=PR[12:pick unpair off]    ;
  53:  PR[13,3:pick unpair Z ax]=PR[13,3:pick unpair Z ax]+80    ;
  54:  !Jezeli gorna paleta w toku ;
  55:  IF (R[109:wrk up pick pal]=1) THEN ;
  56:  !Kontrola poprawnosci deklaracji ;
  57:  IF (R[43:pick up status]<>4 AND R[43:pick up status]<>5) THEN ;
  58:  !Komunikat dla operatora ;
  59:  MESSAGE[Ustaw R[43] = 4] ;
  60:  !Oczekiwanie na akcje operatora ;
  61:  WAIT R[43:pick up status]=4    ;
  62:  ENDIF ;
  63:  !Ustawienie UF palety upper pick ;
  64:  UFRAME_NUM=1 ;
  65:  !Rzad parzysty czy nieparzysty ;
  66:  IF (R[101:x axis pick pal] MOD 2=0) THEN ;
  67:  !Pozycja posrednia ;
  68:J P[80] 100% CNT100    ;
  69:  !Dojazd nad czesc ;
  70:J P[1] 100% CNT35 Offset,PR[11:pick pair Z axis]    ;
  71:  !Dojazd do czesci ;
  72:L P[1] 100mm/sec FINE Offset,PR[10:pick pair off]    ;
  73:  !Wywolanie zamkniecia chwytaka 1 ;
  74:  CALL CLOSE_CHUCK_1    ;
  75:  !Payload - chwytak 1 pelny ;
  76:  PAYLOAD[2] ;
  77:  !Resetowanie licznikow czasu ;
  78:  TIMER[1]=RESET ;
  79:  TIMER[2]=RESET ;
  80:  !Rozpoczecie zliczania czasu OK ;
  81:  TIMER[1]=START ;
  82:  !Rozpoczecie zliczania czasu NOK ;
  83:  TIMER[2]=START ;
  84:  !Opoznienie zabezpieczajace ;
  85:  WAIT    .50(sec) ;
  86:  !Odjazd nad czesc ;
  87:L P[1] 50mm/sec FINE Offset,PR[11:pick pair Z axis]    ;
  88:  !Pozycja posrednia ;
  89:J P[80] 100% CNT100    ;
  90:  ELSE ;
  91:  !Dojazd nad czesc ;
  92:J P[1] 100% CNT35 Offset,PR[13:pick unpair Z ax]    ;
  93:  !Dojazd do czesci ;
  94:L P[1] 100mm/sec FINE Offset,PR[12:pick unpair off]    ;
  95:  !Wywolanie zamkniecia chwytaka 1 ;
  96:  CALL CLOSE_CHUCK_1    ;
  97:  !Payload - chwytak 1 pelny ;
  98:  PAYLOAD[2] ;
  99:  !Resetowanie licznikow czasu ;
 100:  TIMER[1]=RESET ;
 101:  TIMER[2]=RESET ;
 102:  !Rozpoczecie zliczania czasu OK ;
 103:  TIMER[1]=START ;
 104:  !Rozpoczenie zliczania czasu NOK ;
 105:  TIMER[2]=START ;
 106:  !Opoznienie zabezpieczajace ;
 107:  WAIT    .50(sec) ;
 108:  !Odjazd nad czesc ;
 109:L P[1] 100mm/sec FINE Offset,PR[13:pick unpair Z ax]    ;
 110:  ENDIF ;
 111:  !Inkrementacja po osi Y ;
 112:  R[102:y axis pick pal]=R[102:y axis pick pal]+1    ;
 113:  !Alternatywa-dolna paleta w toku ;
 114:  ELSE ;
 115:  !Kontrola poprawnosci deklaracji ;
 116:  IF (R[44:pick low status]<>4 AND R[44:pick low status]<>5) THEN ;
 117:  !Komunikat dla operatora ;
 118:  MESSAGE[Ustaw R[44]=4] ;
 119:  !Oczekiwanie na akcje operatora ;
 120:  WAIT R[44:pick low status]=4    ;
 121:  ENDIF ;
 122:  !Ustawienie UF palety lower pick ;
 123:  UFRAME_NUM=2 ;
 124:  !??? ;
 125:  DO[11050]=ON ;
 126:  !Rzad parzysty czy nieparzyty ;
 127:  IF (R[101:x axis pick pal] MOD 2=0) THEN ;
 128:  !Dojazd nad czesc ;
 129:J P[2] 100% CNT35 Offset,PR[11:pick pair Z axis]    ;
 130:  !Dojazd do czesci ;
 131:L P[2] 100mm/sec FINE Offset,PR[10:pick pair off]    ;
 132:  !Wywolanie zamkniecia chwytaka 1 ;
 133:  CALL CLOSE_CHUCK_1    ;
 134:  !Payload - chwytak 1 pelny ;
 135:  PAYLOAD[2] ;
 136:  !Resetowanie licznikow czasu ;
 137:  TIMER[1]=RESET ;
 138:  TIMER[2]=RESET ;
 139:  !Rozpoczecie zliczania czasu OK ;
 140:  TIMER[1]=START ;
 141:  !Rozpoczecie zliczania czasu NOK ;
 142:  TIMER[2]=START ;
 143:  !Opoznienie zabezpieczajace ;
 144:  WAIT    .50(sec) ;
 145:  !Odjazd nad czesc ;
 146:L P[2] 100mm/sec FINE Offset,PR[11:pick pair Z axis]    ;
 147:  !Pozycja posrednia ;
 148:J P[3] 100% CNT50    ;
 149:  ELSE ;
 150:  !Dojazd nad czesc ;
 151:J P[2] 100% CNT35 Offset,PR[13:pick unpair Z ax]    ;
 152:  !Dojazd do czesci ;
 153:L P[2] 100mm/sec FINE Offset,PR[12:pick unpair off]    ;
 154:  !Wywolanie zamkniecia chwytaka 1 ;
 155:  CALL CLOSE_CHUCK_1    ;
 156:  !Payload - chwytak 1 pelny ;
 157:  PAYLOAD[2] ;
 158:  !Resetowanie licznikow czasu ;
 159:  TIMER[1]=RESET ;
 160:  TIMER[2]=RESET ;
 161:  !Rozpoczecie zliczania czasu OK ;
 162:  TIMER[1]=START ;
 163:  !Rozpoczecie zliczania czasu NOK ;
 164:  TIMER[2]=START ;
 165:  !Opoznienie zabezpieczajace ;
 166:  WAIT    .50(sec) ;
 167:  !Odjazd nad czesc ;
 168:L P[2] 100mm/sec FINE Offset,PR[13:pick unpair Z ax]    ;
 169:  !Pozycja posrednia ;
 170:J P[3] 100% CNT50    ;
 171:  ENDIF ;
 172:  !Inkrementacja po osi Y ;
 173:  R[102:y axis pick pal]=R[102:y axis pick pal]+1    ;
 174:  !??? ;
 175:  DO[11050]=OFF ;
 176:  ENDIF ;
 177:  !Przepisanie licznika czesci ;
 178:  R[8:part in chuck_1]=R[7:picked parts]    ;
 179:  R[7:picked parts]=0    ;
 180:  R[7:picked parts]=R[8:part in chuck_1]+1    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =     -.824  mm,	Y =      .158  mm,	Z =    -6.727  mm,
	W =    89.684 deg,	P =   -85.708 deg,	R =    89.572 deg
};
P[2]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =     1.635  mm,	Y =     -.336  mm,	Z =    -5.495  mm,
	W =   113.246 deg,	P =   -86.094 deg,	R =    65.853 deg
};
P[3]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -161.023  mm,	Y =   245.459  mm,	Z =   238.296  mm,
	W =    91.628 deg,	P =   -86.293 deg,	R =    86.799 deg
};
P[80:""]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -132.214  mm,	Y =   120.655  mm,	Z =    96.558  mm,
	W =    94.609 deg,	P =   -86.251 deg,	R =    83.146 deg
};
/END
