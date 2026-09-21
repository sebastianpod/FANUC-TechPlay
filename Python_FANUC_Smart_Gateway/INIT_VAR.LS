/PROG  INIT_VAR
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Initialisation";
PROG_SIZE	= 666;
CREATE		= DATE 26-08-16  TIME 21:33:18;
MODIFIED	= DATE 26-09-03  TIME 09:08:08;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 24;
MEMORY_SIZE	= 942;
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
   1:   ;
   2:  !================================ ;
   3:  !==                            == ;
   4:  !== RESET ALL PROCESS FLAGS    == ;
   5:  !== RESET RESULTS & REGISTERS  == ;
   6:  !== PREPARE SYSTEM FOR STARTUP == ;
   7:  !==                            == ;
   8:  !================================ ;
   9:   ;
  10:  F[1:PROCESS_REQUEST]=(OFF) ;
  11:  F[2:PROCESS_FINISHED]=(OFF) ;
  12:  F[3:GLUE_APPLICATION_LOST]=(OFF) ;
  13:  R[4:PROCESS_RESULT]=0    ;
  14:  F[5:GLUE_FLOW_BELOW_TOL]=(OFF) ;
  15:  F[6:GLUE_FLOW_ABOVE_TOL]=(OFF) ;
  16:   ;
  17:  R[4:PROCESS_RESULT]=0    ;
  18:  R[5:RESULT_CODE]=0    ;
  19:  R[8:ACTUAL_GLUE_FLOW]=0    ;
  20:  R[9:LAST_FLOW_UPDATE]=0    ;
  21:  R[10:PRODUCT_ID]=0    ;
  22:  R[11:TOOL_NUM]=0    ;
  23:  R[12:SPEED]=0    ;
  24:   ;
/POS
/END
