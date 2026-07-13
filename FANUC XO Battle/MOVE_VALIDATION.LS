/PROG  MOVE_VALIDATION
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "ValidateInput";
PROG_SIZE	= 1158;
CREATE		= DATE 26-07-05  TIME 21:29:14;
MODIFIED	= DATE 26-07-09  TIME 10:37:52;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 54;
MEMORY_SIZE	= 1574;
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
   2:  !Validate selection before move ;
   3:  !R[13] = selected cell (1..9) ;
   4:  !Rejects move if cell is ;
   5:  !already occupied ;
   6:  !If invalid -> resets R[13] ;
   7:  !and waits again ;
   8:   ;
   9:  !Main validation loop ;
  10:  LBL[1] ;
  11:   ;
  12:  !Wait for cell selection ;
  13:  WAIT R[13:SELECTED_CELL]<>0    ;
  14:   ;
  15:  !Check if occupied ;
  16:  IF (R[1:CELL_1.1]<>0 AND R[13:SELECTED_CELL]=1) THEN ;
  17:  R[13:SELECTED_CELL]=0    ;
  18:  ENDIF ;
  19:   ;
  20:  IF (R[2:CELL_1.2]<>0 AND R[13:SELECTED_CELL]=2) THEN ;
  21:  R[13:SELECTED_CELL]=0    ;
  22:  ENDIF ;
  23:   ;
  24:  IF (R[3:CELL_1.3]<>0 AND R[13:SELECTED_CELL]=3) THEN ;
  25:  R[13:SELECTED_CELL]=0    ;
  26:  ENDIF ;
  27:   ;
  28:  IF (R[4:CELL_2.1]<>0 AND R[13:SELECTED_CELL]=4) THEN ;
  29:  R[13:SELECTED_CELL]=0    ;
  30:  ENDIF ;
  31:   ;
  32:  IF (R[5:CELL_2.2]<>0 AND R[13:SELECTED_CELL]=5) THEN ;
  33:  R[13:SELECTED_CELL]=0    ;
  34:  ENDIF ;
  35:   ;
  36:  IF (R[6:CELL_2.3]<>0 AND R[13:SELECTED_CELL]=6) THEN ;
  37:  R[13:SELECTED_CELL]=0    ;
  38:  ENDIF ;
  39:   ;
  40:  IF (R[7:CELL_3.1]<>0 AND R[13:SELECTED_CELL]=7) THEN ;
  41:  R[13:SELECTED_CELL]=0    ;
  42:  ENDIF ;
  43:   ;
  44:  IF (R[8:CELL_3.2]<>0 AND R[13:SELECTED_CELL]=8) THEN ;
  45:  R[13:SELECTED_CELL]=0    ;
  46:  ENDIF ;
  47:   ;
  48:  IF (R[9:CELL_3.3]<>0 AND R[13:SELECTED_CELL]=9) THEN ;
  49:  R[13:SELECTED_CELL]=0    ;
  50:  ENDIF ;
  51:   ;
  52:  !If invalid, repeat selection ;
  53:  IF R[13:SELECTED_CELL]=0,JMP LBL[1] ;
  54:   ;
/POS
/END
