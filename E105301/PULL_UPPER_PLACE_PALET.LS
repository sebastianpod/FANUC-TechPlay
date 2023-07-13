/PROG  PULL_UPPER_PLACE_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1315;
CREATE		= DATE 12-02-25  TIME 15:48:12;
MODIFIED	= DATE 22-02-22  TIME 10:12:22;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 29;
MEMORY_SIZE	= 1595;
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
   3:  !Sprawdzenie stanu czujnika ;
   4:  WAIT DO[11124]=ON    ;
   5:  !Pozycja posrednia ;
   6:J P[5] 100% CNT100    ;
   7:  !Dojazd nad trzpien ;
   8:L P[1] 1000mm/sec FINE    ;
   9:  !Dojazd do trzpienia ;
  10:L P[2] 500mm/sec FINE    ;
  11:  !Wywolanie zamkniecia chwytaka 1 ;
  12:  CALL CLOSE_CHUCK_1    ;
  13:  !Opoznienie zabezpieczajace ;
  14:  WAIT    .50(sec) ;
  15:  !Dojazd do pozycji docelowej ;
  16:L P[3] 100mm/sec FINE ACC75    ;
  17:  !Wywolanie otwarcia chwytaka 1 ;
  18:  CALL OPEN_CHUCK_1    ;
  19:  !Opoznienie zabezpieczajace ;
  20:  WAIT    .50(sec) ;
  21:  !Odjazd nad trzpien ;
  22:L P[4] 1000mm/sec FINE    ;
  23:  !Stat-koniec-gotowa do deklaracji ;
  24:  R[45:place up status]=4    ;
  25:  !??? ;
  26:  DO[11123]=OFF ;
  27:  DO[11124]=OFF ;
  28:  !Wywolanie pozycji bezpiecznej ;
  29:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   432.599  mm,	Y =   581.336  mm,	Z =    22.000  mm,
	W =   109.205 deg,	P =   -88.517 deg,	R =    69.945 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   431.502  mm,	Y =   581.443  mm,	Z =   -31.131  mm,
	W =   116.103 deg,	P =   -87.150 deg,	R =    63.071 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -83.783  mm,	Y =   584.522  mm,	Z =   -31.346  mm,
	W =   120.930 deg,	P =   -86.212 deg,	R =    58.243 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -85.382  mm,	Y =   584.988  mm,	Z =    20.000  mm,
	W =    98.947 deg,	P =   -86.977 deg,	R =    80.197 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =     5.978  mm,	Y =   527.187  mm,	Z =    94.346  mm,
	W =    90.628 deg,	P =   -86.560 deg,	R =    87.471 deg
};
/END
