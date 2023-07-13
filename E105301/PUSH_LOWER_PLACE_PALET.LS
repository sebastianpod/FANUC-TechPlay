/PROG  PUSH_LOWER_PLACE_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1307;
CREATE		= DATE 12-02-25  TIME 16:53:30;
MODIFIED	= DATE 21-07-10  TIME 09:50:02;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 29;
MEMORY_SIZE	= 1587;
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
   3:  !Pozycja posrednia ;
   4:J P[6] 100% CNT100    ;
   5:  !Dojazd nad trzpien ;
   6:L P[1] 1000mm/sec FINE    ;
   7:  !Dojazd do trzpienia ;
   8:L P[2] 500mm/sec FINE    ;
   9:  !Wywolanie zamkniecia chwytaka 2 ;
  10:  CALL CLOSE_CHUCK_1    ;
  11:  !Opoznienie zabezpieczajace ;
  12:  WAIT    .50(sec) ;
  13:  !Dojazd palety do poz docelowej ;
  14:L P[3] 250mm/sec FINE    ;
  15:  !Wywolanie otwarcia chwytaka 1 ;
  16:  CALL OPEN_CHUCK_1    ;
  17:  !Opoznienie zabezpieczajace ;
  18:  WAIT    .50(sec) ;
  19:  !Odjazd nad trzpien ;
  20:L P[4] 1000mm/sec FINE    ;
  21:  !Pozycja posrednia ;
  22:J P[1] 100% CNT100    ;
  23:  !??? ;
  24:  DO[11127]=OFF ;
  25:  DO[11128]=OFF ;
  26:  !Zmiana stst - paleta skonczona ;
  27:  R[46:place low status]=6    ;
  28:  !Wywolanie pozycji bezpiecznej ;
  29:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -75.620  mm,	Y =   586.162  mm,	Z =  -162.000  mm,
	W =    95.791 deg,	P =   -87.412 deg,	R =    82.439 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -76.939  mm,	Y =   585.277  mm,	Z =  -211.488  mm,
	W =   103.866 deg,	P =   -85.900 deg,	R =    74.367 deg
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
	X =   419.355  mm,	Y =   581.598  mm,	Z =  -158.000  mm,
	W =    95.781 deg,	P =   -87.413 deg,	R =    81.991 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -82.385  mm,	Y =   528.603  mm,	Z =   -58.645  mm,
	W =    91.172 deg,	P =   -86.129 deg,	R =    86.706 deg
};
/END
