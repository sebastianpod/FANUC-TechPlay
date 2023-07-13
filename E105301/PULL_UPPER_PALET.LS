/PROG  PULL_UPPER_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1237;
CREATE		= DATE 12-02-19  TIME 10:05:28;
MODIFIED	= DATE 22-02-22  TIME 10:11:30;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 26;
MEMORY_SIZE	= 1529;
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
   1:  !Sprawdzenie stanu czujnika ;
   2:  WAIT DO[11116]=ON    ;
   3:  !Pozycja posrednia ;
   4:J P[5] 100% CNT100    ;
   5:  !Dojazd nad trzpien ;
   6:J P[1] 100% FINE    ;
   7:  !Dojazd do trzpienia ;
   8:L P[2] 250mm/sec FINE    ;
   9:  !Wywolanie zamkniecia chwytaka 1 ;
  10:  CALL CLOSE_CHUCK_1    ;
  11:  !Opoznienie zabezpieczajace ;
  12:  WAIT    .50(sec) ;
  13:  !Dojazd palety do poz docelowej ;
  14:L P[3] 100mm/sec FINE ACC75    ;
  15:  !Wywolanie otwarcia chwytaka 1 ;
  16:  CALL OPEN_CHUCK_1    ;
  17:  !Opoznienie zabezpieczajce ;
  18:  WAIT    .50(sec) ;
  19:  !Odjazd nad trzpien ;
  20:L P[4] 1000mm/sec FINE    ;
  21:  !Status - paleta w toku ;
  22:  R[43:pick up status]=4    ;
  23:  DO[11115]=OFF ;
  24:  DO[11116]=OFF ;
  25:  !Wywolanie pozycji bezpiecznej ;
  26:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   428.305  mm,	Y =   112.979  mm,	Z =    19.000  mm,
	W =    94.611 deg,	P =   -86.716 deg,	R =    85.068 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   428.305  mm,	Y =   113.036  mm,	Z =   -32.322  mm,
	W =    94.610 deg,	P =   -86.716 deg,	R =    85.069 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -82.972  mm,	Y =   114.014  mm,	Z =   -31.643  mm,
	W =    94.605 deg,	P =   -86.716 deg,	R =    85.075 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -84.008  mm,	Y =   112.978  mm,	Z =    19.000  mm,
	W =    94.609 deg,	P =   -86.716 deg,	R =    85.071 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   181.608  mm,	Y =   107.816  mm,	Z =   127.619  mm,
	W =    96.033 deg,	P =   -87.110 deg,	R =    83.441 deg
};
/END
