/PROG  CYCLE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "ProductionCycle";
PROG_SIZE	= 854;
CREATE		= DATE 26-08-16  TIME 20:45:50;
MODIFIED	= DATE 26-09-21  TIME 16:13:32;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 29;
MEMORY_SIZE	= 1142;
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
   1:   ;
   2:  !================================ ;
   3:  !==                            == ;
   4:  !== RUNS GLUING PROCESS        == ;
   5:  !== STORES PROCESS DATA        == ;
   6:  !== EVALUATES FINAL RESULT     == ;
   7:  !==                            == ;
   8:  !================================ ;
   9:   ;
  10:  !START CYCLE TIME MEASUREMENT ;
  11:  TIMER[1]=RESET ;
  12:  TIMER[1]=START ;
  13:   ;
  14:  !EXECUTE SELECTED PROCESS ;
  15:  R[4:PROCESS_RESULT]=0    ;
  16:  SELECT R[10:PRODUCT_ID]=1,CALL LEFT_DOOR_GLUING ;
  17:   ;
  18:  SELECT R[10:PRODUCT_ID]=2,CALL RIGHT_DOOR_GLUING ;
  19:   ;
  20:  !STORE CYCLE TIME RESULT ;
  21:  TIMER[1]=STOP ;
  22:  R[1:GLUE_CYCLE_TIME]=TIMER[1]    ;
  23:   ;
  24:  !RETURN ROBOT TO SAFE POSITION ;
  25:  CALL HOME    ;
  26:   ;
  27:  !EVALUATE PROCESS RESULT ;
  28:  CALL PROCESS_EVAL    ;
  29:   ;
/POS
/END
