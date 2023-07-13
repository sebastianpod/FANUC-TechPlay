/PROG  PLACE_SCRAP_HAND1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3594;
CREATE		= DATE 21-03-24  TIME 12:17:50;
MODIFIED	= DATE 21-03-24  TIME 12:17:50;
FILE_NAME	= PLACE_SC;
VERSION		= 0;
LINE_COUNT	= 124;
MEMORY_SIZE	= 3994;
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
   1:  !Poczatek petli pracy palety ;
   2:  LBL[1] ;
   3:  !Zatrzymanie licznika czasu OK ;
   4:  TIMER[1]=STOP ;
   5:  !Zatrzymanie licznika czasu NOK ;
   6:  TIMER[1]=RESET ;
   7:  !Spr warunku - pominiecie pustego ;
   8:  IF ((R[113:x axis scrap pal]=6 AND R[114:y axis scrap pat]=2) OR (R[113:x axis scrap pal]=16 AND R[114:y axis scrap pat]=2)) THEN ;
   9:  R[114:y axis scrap pat]=3    ;
  10:  ENDIF ;
  11:  !Ustawienie offsetow ;
  12:  PR[14,1:place pair off]=16.286*R[113:x axis scrap pal]    ;
  13:  PR[14,2:place pair off]=56.35*R[114:y axis scrap pat]    ;
  14:  PR[15:place pair Z]=PR[14:place pair off]    ;
  15:  PR[15,3:place pair Z]=PR[15,3:place pair Z]-50    ;
  16:  PR[16:place unpair off]=PR[14:place pair off]    ;
  17:  PR[16,2:place unpair off]=PR[16,2:place unpair off]+28.175    ;
  18:  PR[17:place unpair Z]=PR[16:place unpair off]    ;
  19:  PR[17,3:place unpair Z]=PR[17,3:place unpair Z]-50    ;
  20:  !Wywolanie UF Scrap palet ;
  21:  UFRAME_NUM=8 ;
  22:  !Spr warunku - czy koniec palety ;
  23:  IF (R[113:x axis scrap pal]=22 AND R[114:y axis scrap pat]=5) THEN ;
  24:  !Zerowanie osi X i Y ;
  25:  R[113:x axis scrap pal]=0    ;
  26:  R[114:y axis scrap pat]=0    ;
  27:  !Inkr globalnego licznika pal NOK ;
  28:  R[11:id palet part nk]=R[11:id palet part nk]+1    ;
  29:  R[47]=3    ;
  30:  ENDIF ;
  31:  !Czy paleta zostala ukonczona? ;
  32:  IF (R[47]<>3) THEN ;
  33:  !Oczekiwanie na deklaracje palety ;
  34:  WAIT R[47]=3    ;
  35:  ENDIF ;
  36:  !Rzad parzysty czy nieparzysty? ;
  37:  IF (R[113:x axis scrap pal] MOD 2=0) THEN ;
  38:  !Spr warunku - czy koniec rzedu? ;
  39:  IF (R[114:y axis scrap pat]=5) THEN ;
  40:  !Inkrementacja - kolejny rzad ;
  41:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
  42:  !Zerowanie osi Y ;
  43:  R[114:y axis scrap pat]=0    ;
  44:  !Powrot do poczatku petli pracy ;
  45:  JMP LBL[1] ;
  46:  ENDIF ;
  47:  !Dojazd nad pin do odkladania ;
  48:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  49:  !Dojazd dokladny ;
  50:L P[1] 250mm/sec FINE Offset,PR[14:place pair off]    ;
  51:  !Odlozenie czesci ;
  52:  CALL OPEN_CHUCK_2    ;
  53:  !Opoznienie zabezpieczajace ;
  54:  WAIT    .50(sec) ;
  55:  !Payload - oba chwytaki puste ;
  56:  PAYLOAD[1] ;
  57:  !Przepisanie licznika czesci ;
  58:  R[3:parts nok]=R[9:part in chuck_2]    ;
  59:  R[9:part in chuck_2]=0    ;
  60:  !Jezeli uruchomiony SINTEC ;
  61:  IF (R[80:pc enable]=1) THEN ;
  62:  R[61:req part nok pl]=1    ;
  63:  WAIT R[62:ackn part nok pd]=1    ;
  64:  R[61:req part nok pl]=0    ;
  65:  ENDIF ;
  66:  !Odjazd nad pin do odkladania ;
  67:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  68:  !Pozycja posrednia ;
  69:J P[2] 100% CNT100    ;
  70:  !Inkr po osi Y - kolejny pin ;
  71:  R[114:y axis scrap pat]=R[114:y axis scrap pat]+1    ;
  72:  ELSE ;
  73:  !Jezeli ostani pin w rzedzie ;
  74:  IF (R[114:y axis scrap pat]=4) THEN ;
  75:  !Inkrementacja - kolejny rzad ;
  76:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
  77:  !Zerowanie osi Y ;
  78:  R[114:y axis scrap pat]=0    ;
  79:  !Powrot do poczatku petli pracy ;
  80:  JMP LBL[1] ;
  81:  ENDIF ;
  82:  !Dojazd nad pin (rzad parzysty) ;
  83:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
  84:  !Dojazd dokladny (rzad parzysty) ;
  85:L P[1] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
  86:  !Odlozenie czesci ;
  87:  CALL OPEN_CHUCK_2    ;
  88:  !Opoznienie zabezpieczajace ;
  89:  WAIT    .50(sec) ;
  90:  !Payload - oba chwytaki puste ;
  91:  PAYLOAD[1] ;
  92:  !Przepisanie licznika czesci ;
  93:  R[3:parts nok]=R[9:part in chuck_2]    ;
  94:  R[9:part in chuck_2]=0    ;
  95:  !Jezeli uruchomiony SIBTEC ;
  96:  IF (R[80:pc enable]=1) THEN ;
  97:  R[61:req part nok pl]=1    ;
  98:  WAIT R[62:ackn part nok pd]=1    ;
  99:  R[61:req part nok pl]=0    ;
 100:  ENDIF ;
 101:  !Odjazd nad pin (rzad parzysty) ;
 102:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 103:  !Inkrementacja - kolejny pin ;
 104:  R[114:y axis scrap pat]=R[114:y axis scrap pat]+1    ;
 105:  !Pozycja posrednia ;
 106:J P[2] 100% CNT100    ;
 107:  !Inkr globalnego licznika czesci ;
 108:  R[1:parts checked]=R[1:parts checked]+1    ;
 109:  ENDIF ;
 110:  !Jezeli koniec palety ;
 111:  IF (R[113:x axis scrap pal]=22 AND R[114:y axis scrap pat]=5) THEN ;
 112:  !Zerowanie osi X i Y ;
 113:  R[113:x axis scrap pal]=0    ;
 114:  R[114:y axis scrap pat]=0    ;
 115:  !Inkr licznika palet NOK ;
 116:  R[11:id palet part nk]=R[11:id palet part nk]+1    ;
 117:  !Zmiana stat - paleta skonczona ;
 118:  R[47]=5    ;
 119:  ENDIF ;
 120:  !Spr warunku-brak zakresu ruchu ;
 121:  IF (R[113:x axis scrap pal]=0 AND R[114:y axis scrap pat]=4) THEN ;
 122:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
 123:  R[114:y axis scrap pat]=0    ;
 124:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =     -.589  mm,	Y =    49.957  mm,	Z =   -12.103  mm,
	W =  -112.710 deg,	P =    87.335 deg,	R =    67.194 deg
};
P[2]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   417.204  mm,	Y =    67.793  mm,	Z =   -58.978  mm,
	W =  -110.454 deg,	P =    86.362 deg,	R =    67.750 deg
};
/END
