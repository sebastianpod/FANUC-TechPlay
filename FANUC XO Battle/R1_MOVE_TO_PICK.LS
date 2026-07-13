/PROG  R1_MOVE_TO_PICK
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "PickApproachR1";
PROG_SIZE	= 636;
CREATE		= DATE 26-07-05  TIME 20:49:28;
MODIFIED	= DATE 26-07-06  TIME 12:13:40;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 10;
MEMORY_SIZE	= 968;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !Frames loading ;
   2:  UTOOL_NUM=1 ;
   3:  UFRAME_NUM=1 ;
   4:   ;
   5:  !Auxilary position ;
   6:J P[1] 100% FINE    ;
   7:   ;
   8:  !Target position ;
   9:J P[2] 100% FINE    ;
  10:   ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -516.400  mm,	Y =  -866.400  mm,	Z =   317.000  mm,
	W =  -180.000 deg,	P =     -.000 deg,	R =  -180.000 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -516.400  mm,	Y =  -866.400  mm,	Z =    84.000  mm,
	W =  -180.000 deg,	P =     -.000 deg,	R =  -180.000 deg
};
/END
