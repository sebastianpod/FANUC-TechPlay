/PROG  PATH_FUNC_PLACE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 620;
CREATE		= DATE 18-02-28  TIME 12:02:30;
MODIFIED	= DATE 21-01-17  TIME 14:43:26;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 4;
MEMORY_SIZE	= 976;
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
   1:J P[1] 100% CNT100    ;
   2:J P[2] 100% CNT100    ;
   3:J P[3] 100% CNT100    ;
   4:J P[4] 100% CNT100    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -600.308  mm,	Y =   791.115  mm,	Z =    50.641  mm,
	W =    -7.322 deg,	P =   -87.577 deg,	R =   -86.721 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -970.163  mm,	Y =   484.862  mm,	Z =    61.393  mm,
	W =    42.832 deg,	P =   -82.117 deg,	R =   -45.872 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -756.165  mm,	Y =   -75.905  mm,	Z =    55.918  mm,
	W =    47.880 deg,	P =   -82.681 deg,	R =    44.146 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -120.856  mm,	Y =   472.514  mm,	Z =    51.516  mm,
	W =    46.608 deg,	P =   -83.505 deg,	R =   136.862 deg
};
/END
