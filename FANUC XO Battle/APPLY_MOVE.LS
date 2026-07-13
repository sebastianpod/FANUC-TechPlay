/PROG  APPLY_MOVE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "WriteMoveToBoard";
PROG_SIZE	= 844;
CREATE		= DATE 26-07-05  TIME 21:29:50;
MODIFIED	= DATE 26-07-09  TIME 10:43:52;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 42;
MEMORY_SIZE	= 1176;
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
   2:  !Write selected cell to board ;
   3:  !R[13] = selected cell (1..9) ;
   4:  !Writes curr symbol to the board ;
   5:  !Each cell stored in R[1]..R[9] ;
   6:   ;
   7:  IF (R[13:SELECTED_CELL]=1) THEN ;
   8:  R[1:CELL_1.1]=R[10:CURRENT_TURN]    ;
   9:  ENDIF ;
  10:   ;
  11:  IF (R[13:SELECTED_CELL]=2) THEN ;
  12:  R[2:CELL_1.2]=R[10:CURRENT_TURN]    ;
  13:  ENDIF ;
  14:   ;
  15:  IF (R[13:SELECTED_CELL]=3) THEN ;
  16:  R[3:CELL_1.3]=R[10:CURRENT_TURN]    ;
  17:  ENDIF ;
  18:   ;
  19:  IF (R[13:SELECTED_CELL]=4) THEN ;
  20:  R[4:CELL_2.1]=R[10:CURRENT_TURN]    ;
  21:  ENDIF ;
  22:   ;
  23:  IF (R[13:SELECTED_CELL]=5) THEN ;
  24:  R[5:CELL_2.2]=R[10:CURRENT_TURN]    ;
  25:  ENDIF ;
  26:   ;
  27:  IF (R[13:SELECTED_CELL]=6) THEN ;
  28:  R[6:CELL_2.3]=R[10:CURRENT_TURN]    ;
  29:  ENDIF ;
  30:   ;
  31:  IF (R[13:SELECTED_CELL]=7) THEN ;
  32:  R[7:CELL_3.1]=R[10:CURRENT_TURN]    ;
  33:  ENDIF ;
  34:   ;
  35:  IF (R[13:SELECTED_CELL]=8) THEN ;
  36:  R[8:CELL_3.2]=R[10:CURRENT_TURN]    ;
  37:  ENDIF ;
  38:   ;
  39:  IF (R[13:SELECTED_CELL]=9) THEN ;
  40:  R[9:CELL_3.3]=R[10:CURRENT_TURN]    ;
  41:  ENDIF ;
  42:   ;
/POS
/END
