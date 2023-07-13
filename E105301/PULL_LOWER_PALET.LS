/PROG  PULL_LOWER_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1293;
CREATE		= DATE 18-04-09  TIME 09:11:44;
MODIFIED	= DATE 21-07-10  TIME 09:48:36;
FILE_NAME	= PUSH_LOW;
VERSION		= 0;
LINE_COUNT	= 26;
MEMORY_SIZE	= 1585;
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
   1:  !Sprawdzenie stanu czujnika ;
   2:  WAIT DO[11119]=ON    ;
   3:  !Pozycja posrednia ;
   4:J P[1] 100% CNT100    ;
   5:  !Dojazd nad trzpien ;
   6:L P[2] 1000mm/sec CNT100    ;
   7:  !Dojazd do trzpienia ;
   8:L P[3] 500mm/sec FINE    ;
   9:  !Wywolanie zamkniecia chwytaka 1 ;
  10:  CALL CLOSE_CHUCK_1    ;
  11:  !Opoznienie zabezpieczajace ;
  12:  WAIT    .50(sec) ;
  13:  !Dojazd palety do poz docelowej ;
  14:L P[4] 250mm/sec FINE    ;
  15:  !Wywolanie otwarcia chwytaka 1 ;
  16:  CALL OPEN_CHUCK_1    ;
  17:  !Opoznienie zabezpieczajce ;
  18:  WAIT    .50(sec) ;
  19:  !Odjazd nad trzpien ;
  20:L P[5] 1000mm/sec FINE    ;
  21:  !Status - paleta w toku ;
  22:  R[44:pick low status]=4    ;
  23:  DO[11119]=OFF ;
  24:  DO[11120]=OFF ;
  25:  !Wywolanie pozycji bezpiecznej ;
  26:  CALL HOME_POS    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -71.205  mm,	Y =   164.102  mm,	Z =   113.173  mm,
	W =    11.721 deg,	P =   -88.980 deg,	R =   168.997 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   418.228  mm,	Y =   112.945  mm,	Z =  -163.000  mm,
	W =    97.494 deg,	P =   -86.545 deg,	R =    82.517 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   417.395  mm,	Y =   113.401  mm,	Z =  -213.065  mm,
	W =    97.550 deg,	P =   -86.543 deg,	R =    82.458 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -74.180  mm,	Y =   114.583  mm,	Z =  -215.217  mm,
	W =   101.941 deg,	P =   -85.830 deg,	R =    78.070 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -75.960  mm,	Y =   113.617  mm,	Z =  -164.000  mm,
	W =    97.490 deg,	P =   -86.545 deg,	R =    82.520 deg
};
/END
