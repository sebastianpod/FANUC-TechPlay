/PROG  HOME_POS_BLISTER_1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 600;
CREATE		= DATE 21-02-08  TIME 12:53:24;
MODIFIED	= DATE 21-02-10  TIME 14:47:14;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 6;
MEMORY_SIZE	= 948;
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
   1:  !Spr warunku - ktore narzedzie ;
   2:  IF (R[2:UT NUM]=1) THEN ;
   3:J P[1] 100% CNT100    ;
   4:  ELSE ;
   5:J P[2] 100% CNT100    ;
   6:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 1',
	X =   134.831  mm,	Y =   134.784  mm,	Z =   209.664  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =      .000 deg
};
P[2]{
   GP1:
	UF : 2, UT : 2,		CONFIG : 'N U T, 0, 0, 1',
	X =   134.831  mm,	Y =   134.784  mm,	Z =   182.664  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =      .000 deg
};
/END
