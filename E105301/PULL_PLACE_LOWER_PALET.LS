/PROG  PULL_PLACE_LOWER_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1297;
CREATE		= DATE 18-02-28  TIME 14:45:46;
MODIFIED	= DATE 21-07-10  TIME 09:49:56;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 28;
MEMORY_SIZE	= 1581;
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
   3:  !Oczekiwanie na deklaracje ;
   4:  WAIT R[46:place low status]=3    ;
   5:  !Pozycja posrednia ;
   6:J P[1] 100% CNT100    ;
   7:  !Dojazd nad trzpien ;
   8:L P[2] 1000mm/sec FINE    ;
   9:  !Dojazd do trzpienia ;
  10:L P[3] 500mm/sec FINE    ;
  11:  !Wywolanie zamkniecia chwytaka 2 ;
  12:  CALL CLOSE_CHUCK_1    ;
  13:  !Opoznienie zabezpieczajace ;
  14:  WAIT    .50(sec) ;
  15:  !Dojazd do pozycji docelowej ;
  16:L P[4] 250mm/sec FINE    ;
  17:  !Wywolanie otwarcia chwytaka 2 ;
  18:  CALL OPEN_CHUCK_1    ;
  19:  !Opoznienie zabezpieczajace ;
  20:  WAIT    .50(sec) ;
  21:  !Odjazd nad trzpien ;
  22:L P[5] 1000mm/sec CNT100    ;
  23:  !??? ;
  24:  DO[11125]=OFF ;
  25:  !Stat-koniec-gotowa do deklaracji ;
  26:  R[46:place low status]=4    ;
  27:  !Wywolanie pozycji bezpiecznej ;
  28:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -41.285  mm,	Y =   574.439  mm,	Z =     1.977  mm,
	W =    91.647 deg,	P =   -86.305 deg,	R =    86.235 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   419.355  mm,	Y =   581.598  mm,	Z =  -158.000  mm,
	W =    95.781 deg,	P =   -87.413 deg,	R =    81.991 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   418.476  mm,	Y =   581.229  mm,	Z =  -211.798  mm,
	W =   106.484 deg,	P =   -86.754 deg,	R =    71.771 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -76.939  mm,	Y =   585.277  mm,	Z =  -211.488  mm,
	W =   103.866 deg,	P =   -85.900 deg,	R =    74.367 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -75.620  mm,	Y =   586.162  mm,	Z =  -162.000  mm,
	W =    95.790 deg,	P =   -87.412 deg,	R =    82.439 deg
};
/END
