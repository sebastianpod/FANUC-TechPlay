/PROG  SWITCH_TURN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "TogglePlayer";
PROG_SIZE	= 550;
CREATE		= DATE 26-07-09  TIME 16:12:18;
MODIFIED	= DATE 26-07-10  TIME 09:17:50;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 25;
MEMORY_SIZE	= 954;
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
   1:  !Switch active player ;
   2:  !1=Robot1 (O) ;
   3:  !2=Robot2 (X) ;
   4:   ;
   5:  !Check current turn ;
   6:  IF R[10:CURRENT_TURN]=1,JMP LBL[1] ;
   7:   ;
   8:  IF R[10:CURRENT_TURN]=2,JMP LBL[2] ;
   9:   ;
  10:  !Safety exit ;
  11:  JMP LBL[999] ;
  12:   ;
  13:  !Change R1 turn to R2 ;
  14:  LBL[1] ;
  15:  R[10:CURRENT_TURN]=2    ;
  16:  JMP LBL[999] ;
  17:   ;
  18:  !Change R2 turn to R1 ;
  19:  LBL[2] ;
  20:  R[10:CURRENT_TURN]=1    ;
  21:  JMP LBL[999] ;
  22:   ;
  23:  !Program exit ;
  24:  LBL[999] ;
  25:   ;
/POS
/END
