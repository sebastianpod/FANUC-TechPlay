/PROG  IO_RESET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "I/OInit";
PROG_SIZE	= 431;
CREATE		= DATE 25-11-11  TIME 23:06:16;
MODIFIED	= DATE 25-12-03  TIME 06:59:28;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 11;
MEMORY_SIZE	= 759;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,*,*,*,*;
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
   1:  !Routine to reset flags ;
   2:  !Clear status for next part cycle ;
   3:   ;
   4:  !Clear box flag ;
   5:  DO[1:BOX]=OFF ;
   6:   ;
   7:  !Clear hex flag ;
   8:  DO[2:HEX]=OFF ;
   9:   ;
  10:  !Clear empty flag ;
  11:  DO[3:EMPTY]=OFF ;
/POS
/END
