/PROG  R1_MOVE_TO_CELL
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "CellApproachR1";
PROG_SIZE	= 878;
CREATE		= DATE 26-07-05  TIME 20:49:00;
MODIFIED	= DATE 26-07-10  TIME 07:42:30;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 37;
MEMORY_SIZE	= 1230;
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
   1:  !Frames loading ;
   2:  UTOOL_NUM=1 ;
   3:  UFRAME_NUM=1 ;
   4:   ;
   5:  !Reset offset ;
   6:  PR[2:R1_BOARD_OFFSET]=LPOS-LPOS    ;
   7:   ;
   8:  !------ X OFFSET ------ ;
   9:  IF ((R[13:SELECTED_CELL]=2) OR (R[13:SELECTED_CELL]=5) OR (R[13:SELECTED_CELL]=8)) THEN ;
  10:  PR[2,1:R1_BOARD_OFFSET]=333    ;
  11:  ENDIF ;
  12:   ;
  13:  IF ((R[13:SELECTED_CELL]=3) OR (R[13:SELECTED_CELL]=6) OR (R[13:SELECTED_CELL]=9)) THEN ;
  14:  PR[2,1:R1_BOARD_OFFSET]=666    ;
  15:  ENDIF ;
  16:   ;
  17:  !------ Y OFFSET ------ ;
  18:  IF ((R[13:SELECTED_CELL]=4) OR (R[13:SELECTED_CELL]=5) OR (R[13:SELECTED_CELL]=6)) THEN ;
  19:  PR[2,2:R1_BOARD_OFFSET]=333    ;
  20:  ENDIF ;
  21:   ;
  22:  IF ((R[13:SELECTED_CELL]=7) OR (R[13:SELECTED_CELL]=8) OR (R[13:SELECTED_CELL]=9)) THEN ;
  23:  PR[2,2:R1_BOARD_OFFSET]=666    ;
  24:  ENDIF ;
  25:   ;
  26:  !------ Z OFFSET ------ ;
  27:  PR[2,3:R1_BOARD_OFFSET]=120    ;
  28:   ;
  29:  !Auxilary position ;
  30:J PR[1:R1_BOARD_BASE] 100% FINE Offset,PR[2:R1_BOARD_OFFSET]    ;
  31:   ;
  32:  !Z offset reset ;
  33:  PR[2,3:R1_BOARD_OFFSET]=0    ;
  34:   ;
  35:  !Target position ;
  36:J PR[1:R1_BOARD_BASE] 100% FINE Offset,PR[2:R1_BOARD_OFFSET]    ;
  37:   ;
/POS
/END
