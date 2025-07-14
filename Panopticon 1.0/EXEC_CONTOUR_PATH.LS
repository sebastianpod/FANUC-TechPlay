/PROG  EXEC_CONTOUR_PATH
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "AutoContour";
PROG_SIZE	= 1034;
CREATE		= DATE 25-07-10  TIME 08:14:42;
MODIFIED	= DATE 25-07-13  TIME 22:36:50;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 24;
MEMORY_SIZE	= 1318;
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
/APPL

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
   1:  !**** TRACE RECOGNIZED SHAPE **** ;
   2:   ;
   3:  !Program executes PR-based path ;
   4:  !Loop count taken from R[1] reg ;
   5:  !Each PR = one object's vertex ;
   6:  !Coords from read_coords.kl prog ;
   7:  !read_coords.kl reads CSV file ;
   8:  !CSV made by readout.py script ;
   9:  !Script converts pixel coords ;
  10:  !To robot position in UserFrame1 ;
  11:   ;
  12:  UFRAME_NUM=1 ;
  13:  UTOOL_NUM=1 ;
  14:   ;
  15:  FOR R[2:Loop counter]=1 TO R[1:Points loaded] ;
  16:   ;
  17:L P[1] 250mm/sec FINE Offset,PR[R[2]] Wjnt    ;
  18:  ENDFOR ;
  19:   ;
  20:  !Close contour ;
  21:L P[1] 250mm/sec FINE Offset,PR[1] Wjnt    ;
  22:   ;
  23:  CALL HOME_POSITION    ;
  24:   ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =     0.000  mm,
	W =     0.000 deg,	P =     0.000 deg,	R =     0.000 deg
};
/END
