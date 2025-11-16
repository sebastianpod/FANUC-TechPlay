/PROG  PROG_OFFSET_REVERSE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 860;
CREATE		= DATE 22-06-14  TIME 13:30:28;
MODIFIED	= DATE 25-11-16  TIME 19:20:22;
FILE_NAME	= PROG_OFF;
VERSION		= 0;
LINE_COUNT	= 33;
MEMORY_SIZE	= 1228;
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
/MN
   1:  !Routine to calculate offset ;
   2:  !for a 5-column grid pattern ;
   3:   ;
   4:  !R[1] IS THE MAIN COUNTER ;
   5:  !TRACKING THE CURRENT TREY INDEX ;
   6:   ;
   7:  !If first cell zero the pos reg ;
   8:  IF (R[1:MAIN COUNTER]=1) THEN ;
   9:  PR[1]=LPOS-LPOS    ;
  10:   ;
  11:  ELSE ;
  12:   ;
  13:  !MOD 5 result ;
  14:  !Detects 5-cell row jump ;
  15:  R[2:MOD ROW JUMP]=R[1:MAIN COUNTER] MOD 5    ;
  16:   ;
  17:  IF (R[2:MOD ROW JUMP]=1) THEN ;
  18:   ;
  19:  !Next row. Y axis offset = 24mm ;
  20:  PR[1,2]=PR[1,2]+24    ;
  21:   ;
  22:  !Next row's first cell ;
  23:  !X axis offset = 0mm ;
  24:  PR[1,1]=0    ;
  25:   ;
  26:  ELSE ;
  27:   ;
  28:  !Same row - next cell ;
  29:  !X axis offset = -48mm ;
  30:  PR[1,1]=PR[1,1]-48    ;
  31:   ;
  32:  ENDIF ;
  33:  ENDIF ;
/POS
/END
