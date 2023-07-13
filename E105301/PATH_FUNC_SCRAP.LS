/PROG  PATH_FUNC_SCRAP
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 563;
CREATE		= DATE 18-02-28  TIME 12:14:24;
MODIFIED	= DATE 21-02-01  TIME 12:48:34;
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
   1:J P[3] 100% CNT100    ;
   2:J P[1] 100% CNT100    ;
   3:J P[2] 100% CNT100    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -702.938  mm,	Y =   841.982  mm,	Z =   172.754  mm,
	W =  -161.941 deg,	P =   -88.772 deg,	R =    71.468 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -825.338  mm,	Y =   921.182  mm,	Z =   172.754  mm,
	W =  -161.942 deg,	P =   -88.771 deg,	R =    74.637 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -635.344  mm,	Y =   798.265  mm,	Z =     8.219  mm,
	W =    57.813 deg,	P =   -86.424 deg,	R =  -158.513 deg
};
/END
