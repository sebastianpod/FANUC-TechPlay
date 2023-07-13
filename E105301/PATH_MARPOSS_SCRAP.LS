/PROG  PATH_MARPOSS_SCRAP
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 563;
CREATE		= DATE 21-03-12  TIME 10:28:54;
MODIFIED	= DATE 21-04-17  TIME 10:46:10;
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
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -994.518  mm,	Y =    66.738  mm,	Z =     0.000  mm,
	W =    14.353 deg,	P =   -88.469 deg,	R =    20.208 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X = -1034.902  mm,	Y =   584.137  mm,	Z =     0.000  mm,
	W =   -19.944 deg,	P =   -88.971 deg,	R =   -10.321 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -825.338  mm,	Y =   921.182  mm,	Z =   172.754  mm,
	W =  -161.942 deg,	P =   -88.771 deg,	R =    74.637 deg
};
/END
