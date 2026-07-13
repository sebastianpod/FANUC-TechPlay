/PROG  CHECK_TURN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "TurnDetection";
PROG_SIZE	= 554;
CREATE		= DATE 26-07-09  TIME 16:05:14;
MODIFIED	= DATE 26-07-09  TIME 16:11:58;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 834;
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
/MN
   1:  !Check active player turn ;
   2:  !Reads R[10:CURRENT_TURN] ;
   3:  !Sets turn outputs for SIM ;
   4:   ;
   5:  !Robot 1 turn ;
   6:  IF (R[10:CURRENT_TURN]=1) THEN ;
   7:  DO[4:R1_TURN]=ON ;
   8:  ENDIF ;
   9:   ;
  10:  !Robot 2 turn ;
  11:  IF (R[10:CURRENT_TURN]=2) THEN ;
  12:  DO[5:R2_TURN]=ON ;
  13:  ENDIF ;
  14:   ;
  15:  !Clear inactive turn output ;
  16:  IF (R[10:CURRENT_TURN]<>1) THEN ;
  17:  DO[4:R1_TURN]=OFF ;
  18:  ENDIF ;
  19:   ;
  20:  IF (R[10:CURRENT_TURN]<>2) THEN ;
  21:  DO[5:R2_TURN]=OFF ;
  22:  ENDIF ;
  23:   ;
/POS
/END
