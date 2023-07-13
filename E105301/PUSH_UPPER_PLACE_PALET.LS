/PROG  PUSH_UPPER_PLACE_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1208;
CREATE		= DATE 12-02-25  TIME 16:06:18;
MODIFIED	= DATE 21-06-12  TIME 10:48:22;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 26;
MEMORY_SIZE	= 1500;
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
   3:  !Dojazd nad trzpien ;
   4:L P[1] 1000mm/sec FINE    ;
   5:  !Dojazd do trzpienia ;
   6:L P[4] 500mm/sec FINE    ;
   7:  !Wywolanie zamkniecia chwytaka 1 ;
   8:  CALL CLOSE_CHUCK_1    ;
   9:  !Opoznienie zabezpieczajace ;
  10:  WAIT    .50(sec) ;
  11:  !Dojazd do pozycji docelowej ;
  12:L P[2] 250mm/sec FINE    ;
  13:  !Wywolanie otwarcia chwytaka 1 ;
  14:  CALL OPEN_CHUCK_1    ;
  15:  !Opoznienie zabezpieczajace ;
  16:  WAIT    .50(sec) ;
  17:  !Odjazd nad trzpien ;
  18:L P[3] 1000mm/sec FINE    ;
  19:  !Pozycja posrednia ;
  20:J P[1] 100% CNT100    ;
  21:  !??? ;
  22:  DO[11122]=OFF ;
  23:  !Stat-koniec-gotowa do deklaracji ;
  24:  R[45:place up status]=6    ;
  25:  !Wywolanie pozycji bezpiecznej ;
  26:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -85.382  mm,	Y =   584.988  mm,	Z =    20.000  mm,
	W =    98.947 deg,	P =   -86.977 deg,	R =    80.197 deg
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
	X =   432.599  mm,	Y =   581.336  mm,	Z =    22.000  mm,
	W =   109.205 deg,	P =   -88.517 deg,	R =    69.945 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -84.159  mm,	Y =   584.267  mm,	Z =   -31.025  mm,
	W =   120.884 deg,	P =   -86.215 deg,	R =    58.289 deg
};
/END
