/PROG  R2_HOME_POSITION
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "SafePositionR2";
PROG_SIZE	= 537;
CREATE		= DATE 26-07-06  TIME 10:33:02;
MODIFIED	= DATE 26-07-09  TIME 10:07:26;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 7;
MEMORY_SIZE	= 881;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,1,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !Frame loading ;
   2:  UTOOL_NUM=1 ;
   3:  UFRAME_NUM=1 ;
   4:   ;
   5:  !Home position ;
   6:J P[1] 100% FINE    ;
   7:   ;
/POS
P[1]{
   GP2:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   330.000  mm,	Y =  1169.970  mm,	Z =   292.970  mm,
	W =   180.000 deg,	P =      .000 deg,	R =   -90.000 deg
};
/END
