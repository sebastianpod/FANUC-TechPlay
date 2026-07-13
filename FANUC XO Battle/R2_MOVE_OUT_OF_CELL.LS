/PROG  R2_MOVE_OUT_OF_CELL
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "CellRetreatR2";
PROG_SIZE	= 308;
CREATE		= DATE 26-07-10  TIME 08:49:26;
MODIFIED	= DATE 26-07-10  TIME 08:57:14;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 10;
MEMORY_SIZE	= 640;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,1,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !Frames loading ;
   2:  UTOOL_NUM=1 ;
   3:  UFRAME_NUM=1 ;
   4:   ;
   5:  !------ Z OFFSET ------ ;
   6:  PR[4,3:R2_BOARD_OFFSET]=120    ;
   7:   ;
   8:  !Position above the cell ;
   9:J PR[3:R2_BOARD_BASE] 100% FINE Offset,PR[4:R2_BOARD_OFFSET]    ;
  10:   ;
/POS
/END
