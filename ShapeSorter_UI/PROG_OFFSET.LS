/PROG  PROG_OFFSET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "PlacingOffset";
PROG_SIZE	= 1275;
CREATE		= DATE 25-11-19  TIME 21:16:28;
MODIFIED	= DATE 25-12-02  TIME 22:47:20;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 36;
MEMORY_SIZE	= 1631;
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

AUTO_SINGULARITY_HEADER;
  ENABLE_SINGULARITY_AVOIDANCE   : FALSE;

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;


PLTZ_MODE_HEADER;
 PLTZ_MODE_ENABLE   : FALSE;
 J4TURN  : ZERORAD;
 ORIENT  : DOWNWARDS;
/MN
   1:  !Drop-off 4x4 grid user frame ;
   2:  UFRAME_NUM=1 ;
   3:  UTOOL_NUM=1 ;
   4:   ;
   5:  !Routine to calculate offset ;
   6:  !for a 4x4 grid pattern ;
   7:   ;
   8:  !Check if current cell ;
   9:  !has an active element ;
  10:  IF (R[R[20]]<>3) THEN ;
  11:   ;
  12:  !Calculate row and column ;
  13:  R[21:COL NUM]=R[20:MAIN LOOP IND]-1    ;
  14:  R[21:COL NUM]=R[21:COL NUM] MOD 4    ;
  15:   ;
  16:  R[22:ROW NUM]=R[20:MAIN LOOP IND]-1    ;
  17:  R[22:ROW NUM]=R[22:ROW NUM] DIV 4    ;
  18:   ;
  19:  !Set pos offset based on grid ;
  20:  PR[1:4x4 grid offset]=LPOS-LPOS    ;
  21:   ;
  22:  R[23:TEMP_X]=R[21:COL NUM]*200    ;
  23:   ;
  24:  PR[1,1:4x4 grid offset]=PR[1,1:4x4 grid offset]+R[23:TEMP_X]    ;
  25:   ;
  26:  R[24:TEMP_Y]=R[22:ROW NUM]*200    ;
  27:   ;
  28:  PR[1,2:4x4 grid offset]=PR[1,2:4x4 grid offset]+R[24:TEMP_Y]    ;
  29:   ;
  30:  !Pos above the drop-off pos ;
  31:J P[2] 100% FINE Offset,PR[1:4x4 grid offset]    ;
  32:   ;
  33:  !Offsetted drop-off position ;
  34:L P[1] 1000mm/sec FINE Offset,PR[1:4x4 grid offset]    ;
  35:   ;
  36:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =      .000  mm,	Y =     -.000  mm,	Z =     6.000  mm,
	W =      .000 deg,	P =      .000 deg,	R =      .000 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =      .000  mm,	Y =     -.000  mm,	Z =  -200.000  mm,
	W =      .000 deg,	P =      .000 deg,	R =      .000 deg
};
/END
