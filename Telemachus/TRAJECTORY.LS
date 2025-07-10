/PROG  TRAJECTORY
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 821;
CREATE		= DATE 24-09-09  TIME 22:19:26;
MODIFIED	= DATE 25-07-10  TIME 23:25:42;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 14;
MEMORY_SIZE	= 1137;
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
   1:  !Trajectory program for model ;
   2:  !Used in training and testing ;
   3:  !R[1] = Target position ;
   4:  !R[2] = Forecast Position ;
   5:  !Main prog selects R[1]/R[2] ;
   6:  !Used to validate predictions ;
   7:   ;
   8:  !*********** WARNING! *********** ;
   9:   ;
  10:  !Check positions before use! ;
  11:  !Program created in dev setup ;
  12:   ;
  13:J P[1] 100% FINE Tool_Offset,PR[R[1]]    ;
  14:   ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =     0.000 deg,	P =     0.000 deg,	R =     0.000 deg
};
/END
