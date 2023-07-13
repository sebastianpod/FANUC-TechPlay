/PROG  PATH_MARPOSS_PLACE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 506;
CREATE		= DATE 21-03-12  TIME 10:19:30;
MODIFIED	= DATE 21-03-12  TIME 10:22:12;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 2;
MEMORY_SIZE	= 870;
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
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -259.229  mm,	Y =    19.219  mm,	Z =    41.640  mm,
	W =    65.619 deg,	P =   -88.627 deg,	R =    67.483 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -121.338  mm,	Y =   352.453  mm,	Z =    37.099  mm,
	W =    89.000 deg,	P =   -89.036 deg,	R =    87.762 deg
};
/END
