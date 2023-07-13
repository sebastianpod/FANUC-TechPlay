/PROG  PLACE_SCRAP
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3568;
CREATE		= DATE 18-11-16  TIME 18:13:42;
MODIFIED	= DATE 22-08-31  TIME 09:56:42;
FILE_NAME	= PLACE_PA;
VERSION		= 0;
LINE_COUNT	= 126;
MEMORY_SIZE	= 3960;
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
   7:  !Ustawienie offsetow ;
   8:  PR[14,1:place pair off]=18*R[113:x axis scrap pal]    ;
   9:  PR[14,2:place pair off]=56.5*R[114:y axis scrap pat]    ;
  10:  PR[15:place pair Z]=PR[14:place pair off]    ;
  11:  PR[15,3:place pair Z]=PR[15,3:place pair Z]-45    ;
  12:  PR[16:place unpair off]=PR[14:place pair off]    ;
  13:  PR[16,2:place unpair off]=PR[16,2:place unpair off]+27.75    ;
  14:  PR[17:place unpair Z]=PR[16:place unpair off]    ;
  15:  PR[17,3:place unpair Z]=PR[17,3:place unpair Z]-45    ;
  16:  !Wywolanie UF Scrap palet ;
  17:  UFRAME_NUM=8 ;
  18:  !Spr warunku - czy koniec palety ;
  19:  IF (R[113:x axis scrap pal]=20 AND R[114:y axis scrap pat]=4) THEN ;
  20:  !Zerowanie osi X i Y ;
  21:  R[113:x axis scrap pal]=0    ;
  22:  R[114:y axis scrap pat]=0    ;
  23:  !Inkr globalnego licznika pal NOK ;
  24:  R[11:id palet part nk]=R[11:id palet part nk]+1    ;
  25:  R[70:NOK_part_id]=1    ;
  26:  R[47]=3    ;
  27:  ENDIF ;
  28:  !Czy paleta zostala ukonczona? ;
  29:  IF (R[47]<>3) THEN ;
  30:  !Oczekiwanie na deklaracje palety ;
  31:  WAIT R[47]=3    ;
  32:  ENDIF ;
  33:  !Rzad parzysty czy nieparzysty? ;
  34:  IF (R[113:x axis scrap pal] MOD 2=0) THEN ;
  35:  !Spr warunku - czy koniec rzedu? ;
  36:  IF (R[114:y axis scrap pat]=5) THEN ;
  37:  !Inkrementacja - kolejny rzad ;
  38:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
  39:  !Zerowanie osi Y ;
  40:  R[114:y axis scrap pat]=0    ;
  41:  !Powrot do poczatku petli pracy ;
  42:  JMP LBL[1] ;
  43:  ENDIF ;
  44:  !Dojazd nad pin do odkladania ;
  45:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  46:  !Dojazd dokladny ;
  47:L P[1] 250mm/sec FINE Offset,PR[14:place pair off]    ;
  48:  !Odlozenie czesci ;
  49:  CALL OPEN_CHUCK_2    ;
  50:  !Opoznienie zabezpieczajace ;
  51:  WAIT    .50(sec) ;
  52:  !Payload - oba chwytaki puste ;
  53:  PAYLOAD[1] ;
  54:  !Przepisanie licznika czesci ;
  55:  R[3:parts nok]=R[9:part in chuck_2]    ;
  56:  R[9:part in chuck_2]=0    ;
  57:  !Jezeli uruchomiony SINTEC ;
  58:  IF (R[80:pc enable]=1) THEN ;
  59:  R[61:req part nok pl]=1    ;
  60:  WAIT R[62:ackn part nok pd]=1    ;
  61:  R[61:req part nok pl]=0    ;
  62:  ENDIF ;
  63:  !Odjazd nad pin do odkladania ;
  64:L P[1] 4000mm/sec FINE Offset,PR[15:place pair Z]    ;
  65:  !Pozycja posrednia ;
  66:J P[2] 100% CNT100    ;
  67:  !Inkr po osi Y - kolejny pin ;
  68:  R[114:y axis scrap pat]=R[114:y axis scrap pat]+1    ;
  69:  ELSE ;
  70:  !Jezeli ostani pin w rzedzie ;
  71:  IF (R[114:y axis scrap pat]=4) THEN ;
  72:  !Inkrementacja - kolejny rzad ;
  73:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
  74:  !Zerowanie osi Y ;
  75:  R[114:y axis scrap pat]=0    ;
  76:  !Powrot do poczatku petli pracy ;
  77:  JMP LBL[1] ;
  78:  ENDIF ;
  79:  !Dojazd nad pin (rzad parzysty) ;
  80:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
  81:  !Dojazd dokladny (rzad parzysty) ;
  82:L P[1] 250mm/sec FINE Offset,PR[16:place unpair off]    ;
  83:  !Odlozenie czesci ;
  84:  CALL OPEN_CHUCK_2    ;
  85:  !Opoznienie zabezpieczajace ;
  86:  WAIT    .50(sec) ;
  87:  !Payload - oba chwytaki puste ;
  88:  PAYLOAD[1] ;
  89:  !Przepisanie licznika czesci ;
  90:  R[3:parts nok]=R[9:part in chuck_2]    ;
  91:  R[9:part in chuck_2]=0    ;
  92:  !Jezeli uruchomiony SIBTEC ;
  93:  IF (R[80:pc enable]=1) THEN ;
  94:  R[61:req part nok pl]=1    ;
  95:  WAIT R[62:ackn part nok pd]=1    ;
  96:  R[61:req part nok pl]=0    ;
  97:  ENDIF ;
  98:  !Odjazd nad pin (rzad parzysty) ;
  99:L P[1] 4000mm/sec FINE Offset,PR[17:place unpair Z]    ;
 100:  !Inkrementacja - kolejny pin ;
 101:  R[114:y axis scrap pat]=R[114:y axis scrap pat]+1    ;
 102:  !Pozycja posrednia ;
 103:J P[2] 100% CNT100    ;
 104:  !Inkr globalnego licznika czesci ;
 105:  R[1:parts checked]=R[1:parts checked]+1    ;
 106:  ENDIF ;
 107:  !Jezeli koniec palety ;
 108:  IF (R[113:x axis scrap pal]=20 AND R[114:y axis scrap pat]=4) THEN ;
 109:  !Zerowanie osi X i Y ;
 110:  R[113:x axis scrap pal]=0    ;
 111:  R[114:y axis scrap pat]=0    ;
 112:  !Inkr licznika palet NOK ;
 113:  R[11:id palet part nk]=R[11:id palet part nk]+1    ;
 114:  !Zmiana stat - paleta skonczona ;
 115:  R[47]=5    ;
 116:  ENDIF ;
 117:  !Spr warunku-brak zakresu ruchu ;
 118:  IF (R[113:x axis scrap pal]=0 AND R[114:y axis scrap pat]=4) THEN ;
 119:  R[113:x axis scrap pal]=R[113:x axis scrap pal]+1    ;
 120:  R[114:y axis scrap pat]=0    ;
 121:  ENDIF ;
 122:  IF (R[70:NOK_part_id]=96) THEN ;
 123:  R[70:NOK_part_id]=1    ;
 124:  ELSE ;
 125:  R[70:NOK_part_id]=R[70:NOK_part_id]+1    ;
 126:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =    -1.710  mm,	Y =    54.953  mm,	Z =   -16.440  mm,
	W =   -74.285 deg,	P =    87.270 deg,	R =   104.941 deg
};
P[2]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   417.204  mm,	Y =    67.793  mm,	Z =   -58.978  mm,
	W =  -110.454 deg,	P =    86.362 deg,	R =    67.750 deg
};
/END
