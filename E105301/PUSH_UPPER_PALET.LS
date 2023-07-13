/PROG  PUSH_UPPER_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1200;
CREATE		= DATE 12-02-19  TIME 10:05:08;
MODIFIED	= DATE 21-07-10  TIME 09:52:12;
FILE_NAME	= PUSH_UPP;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 1504;
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
   1:  !Dojazd nad trzpien ;
   2:L P[2] 1000mm/sec CNT100    ;
   3:  !Dojazd do trzpienia ;
   4:L P[1] 500mm/sec FINE    ;
   5:  !Wywolanie zamkniecia chwytaka 1 ;
   6:  CALL CLOSE_CHUCK_1    ;
   7:  !Opoznienie zabezpieczajace ;
   8:  WAIT    .50(sec) ;
   9:  !Dojazd palety do poz docelowej ;
  10:L P[8] 250mm/sec FINE    ;
  11:  !Wywolanie otwarcia chwytaka 1 ;
  12:  CALL OPEN_CHUCK_1    ;
  13:  !Opoznienie zabezpieczajace ;
  14:  WAIT    .50(sec) ;
  15:  !Odjazd nad trzpien ;
  16:L P[7] 1000mm/sec FINE    ;
  17:  !Pozycja posrednia ;
  18:J P[2] 100% CNT100    ;
  19:  DO[11114]=OFF ;
  20:  !Stat-koniec-gotowa do deklaracji ;
  21:  R[43:pick up status]=6    ;
  22:  !Wywolanie pozycji bezpiecznej ;
  23:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -82.972  mm,	Y =   114.014  mm,	Z =   -31.643  mm,
	W =    94.605 deg,	P =   -86.716 deg,	R =    85.075 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -84.008  mm,	Y =   112.978  mm,	Z =    19.000  mm,
	W =    94.609 deg,	P =   -86.716 deg,	R =    85.071 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   428.305  mm,	Y =   112.979  mm,	Z =    19.000  mm,
	W =    94.611 deg,	P =   -86.716 deg,	R =    85.068 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   428.305  mm,	Y =   113.036  mm,	Z =   -32.322  mm,
	W =    94.610 deg,	P =   -86.716 deg,	R =    85.069 deg
};
/END
