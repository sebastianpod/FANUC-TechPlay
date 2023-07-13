/PROG  PATH_SCRAP_PICK
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 563;
CREATE		= DATE 18-02-28  TIME 12:17:46;
MODIFIED	= DATE 21-01-15  TIME 08:43:14;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 3;
MEMORY_SIZE	= 923;
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
/POS
P[1]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   448.956  mm,	Y =    38.278  mm,	Z =  -109.944  mm,
	W =  -170.494 deg,	P =    85.694 deg,	R =    14.902 deg
};
P[2]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  1331.360  mm,	Y =    91.748  mm,	Z =   -46.924  mm,
	W =   -99.188 deg,	P =    86.417 deg,	R =   -79.449 deg
};
P[3]{
   GP1:
	UF : 8, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  1113.791  mm,	Y =  -568.427  mm,	Z =   -37.843  mm,
	W =   -80.786 deg,	P =    86.430 deg,	R =  -158.574 deg
};
/END
