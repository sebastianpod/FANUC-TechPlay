/PROG  ARIADNE_CORE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Teleoperations";
PROG_SIZE	= 1504;
CREATE		= DATE 26-05-21  TIME 14:43:18;
MODIFIED	= DATE 26-05-22  TIME 13:49:38;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 49;
MEMORY_SIZE	= 1956;
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
   1:  !******************************** ;
   2:  !*                              * ;
   3:  !*---------- ARIADNE -----------* ;
   4:  !*                              * ;
   5:  !*VERSION : 1.1                 * ;
   6:  !*AUTHOR  : S. PODSIADLO        * ;
   7:  !*DATE    : 2026-05-23          * ;
   8:  !*                              * ;
   9:  !******************************** ;
  10:   ;
  11:  !******************************** ;
  12:  !*--------- UPDATE v1.1 --------* ;
  13:  !******************************** ;
  14:  !- XY radial bound (WORLD XY) ;
  15:  !- Demo-safe workspace limiter ;
  16:  !- Avoids unreachable corners ;
  17:   ;
  18:  !******************************** ;
  19:  !*----- TELEOPERATION LOOP -----* ;
  20:  !******************************** ;
  21:   ;
  22:  !This program runs teleoperation ;
  23:  !loop: it exchanges data with ;
  24:  !Python, receives an XYZ offset, ;
  25:  !computes a new target position ;
  26:  !and moves the robot ;
  27:   ;
  28:  !Call Home Position ;
  29:  UTOOL_NUM=0 ;
  30:  UFRAME_NUM=0 ;
  31:   ;
  32:J PR[1] 100% FINE    ;
  33:  !Claer target position register ;
  34:  PR[10]=LPOS-LPOS    ;
  35:   ;
  36:  !Main Loop ;
  37:  LBL[1] ;
  38:   ;
  39:  !Send robot's curr pos to Python ;
  40:  CALL ROBOT_TO_PY    ;
  41:   ;
  42:  !Receive target pos from Python ;
  43:  CALL PY_TO_ROBOT    ;
  44:   ;
  45:  !Move to the target position ;
  46:J PR[10] 100% FINE    ;
  47:   ;
  48:  JMP LBL[1] ;
  49:   ;
/POS
/END
