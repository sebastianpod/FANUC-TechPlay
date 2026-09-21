/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "MainCycleProgram";
PROG_SIZE	= 1192;
CREATE		= DATE 26-08-11  TIME 14:25:10;
MODIFIED	= DATE 26-09-20  TIME 20:59:00;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 45;
MEMORY_SIZE	= 1676;
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
   2:  !******************************* ;
   3:  !*                             * ;
   4:  !* PY FANUC SMART GATEWAY      * ;
   5:  !* VERSION : 1.0               * ;
   6:  !* AUTHOR : S.PODSIADLO        * ;
   7:  !*                             * ;
   8:  !******************************* ;
   9:   ;
  10:  !=============================== ;
  11:  !==                           == ;
  12:  !== RECEIVES PYTHON REQUESTS  == ;
  13:  !== EXECUTES ROBOT ACTIONS    == ;
  14:  !== RETURNS PROCESS RESULTS   == ;
  15:  !==                           == ;
  16:  !=============================== ;
  17:   ;
  18:  !INITIALIZE PROCESS VARIABLES ;
  19:  CALL INIT_VAR    ;
  20:   ;
  21:  !SERVER LOOP ;
  22:  LBL[1] ;
  23:   ;
  24:  !PROCESS SOCKET REQUESTS ;
  25:  CALL GATEWAY_SERVER    ;
  26:   ;
  27:  !EXECUTE PROCESS REQUEST ;
  28:  IF (F[1:PROCESS_REQUEST]) THEN ;
  29:   ;
  30:  F[1:PROCESS_REQUEST]=(OFF) ;
  31:  CALL CYCLE    ;
  32:   ;
  33:  ENDIF ;
  34:   ;
  35:  !EXECUTE ROBOT RECOVERY ;
  36:  IF (F[4:RECOVERY_REQUEST]=ON) THEN ;
  37:   ;
  38:  F[4:RECOVERY_REQUEST]=(OFF) ;
  39:  CALL HOME    ;
  40:   ;
  41:  ENDIF ;
  42:   ;
  43:  !WAIT FOR NEXT CLIENT REQUEST ;
  44:  JMP LBL[1] ;
  45:   ;
/POS
/END
