/PROG  PUSH_LOWER_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1239;
CREATE		= DATE 12-02-19  TIME 10:07:00;
MODIFIED	= DATE 21-07-10  TIME 09:48:46;
FILE_NAME	= PUSH_UPP;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 1543;
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
   2:L P[6] 1000mm/sec CNT100    ;
   3:  !Dojazd do trzpienia ;
   4:L P[3] 500mm/sec FINE    ;
   5:  !Wywolanie zamkniecia chwytaka 1 ;
   6:  CALL CLOSE_CHUCK_1    ;
   7:  !Opoznienie zabezpieczajace ;
   8:  WAIT    .50(sec) ;
   9:  !Dojazd palety do poz docelowej ;
  10:L P[4] 250mm/sec FINE    ;
  11:  !Wywolanie otwarcia chwytaka 1 ;
  12:  CALL OPEN_CHUCK_1    ;
  13:  !Opoznienie zabezpieczajace ;
  14:  WAIT    .50(sec) ;
  15:  !Odjazd nad trzpien ;
  16:L P[5] 1000mm/sec FINE    ;
  17:  !Pozycja posrednia ;
  18:J P[2] 100% CNT100    ;
  19:  DO[11118]=OFF ;
  20:  !Stat-koniec-gotowa do deklaracji ;
  21:  R[44:pick low status]=6    ;
  22:  !Wywolanie pozycji bezpiecznej ;
  23:  CALL HOME_POS    ;
/POS
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   137.893  mm,	Y =    95.441  mm,	Z =  -152.136  mm,
	W =    93.794 deg,	P =   -86.567 deg,	R =    84.538 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -74.180  mm,	Y =   114.583  mm,	Z =  -215.217  mm,
	W =   101.941 deg,	P =   -85.830 deg,	R =    78.070 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   417.395  mm,	Y =   113.401  mm,	Z =  -213.065  mm,
	W =    97.550 deg,	P =   -86.543 deg,	R =    82.458 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   418.228  mm,	Y =   112.945  mm,	Z =  -163.000  mm,
	W =    97.494 deg,	P =   -86.545 deg,	R =    82.517 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -75.960  mm,	Y =   113.617  mm,	Z =  -164.000  mm,
	W =    97.490 deg,	P =   -86.545 deg,	R =    82.520 deg
};
/END
