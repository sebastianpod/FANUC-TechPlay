/PROG  R1_MOVE_OUT_OF_CELL
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "CellRetreatR1";
PROG_SIZE	= 308;
CREATE		= DATE 26-07-05  TIME 20:49:14;
MODIFIED	= DATE 26-07-10  TIME 08:49:12;
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
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !Frames loading ;
   2:  UTOOL_NUM=1 ;
   3:  UFRAME_NUM=1 ;
   4:   ;
   5:  !------ Z OFFSET ------ ;
   6:  PR[2,3:R1_BOARD_OFFSET]=120    ;
   7:   ;
   8:  !Position above the cell ;
   9:J PR[1:R1_BOARD_BASE] 100% FINE Offset,PR[2:R1_BOARD_OFFSET]    ;
  10:   ;
/POS
/END
