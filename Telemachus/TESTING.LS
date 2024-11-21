/PROG  TESTING
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 678;
CREATE		= DATE 24-10-18  TIME 23:00:44;
MODIFIED	= DATE 24-10-25  TIME 23:34:10;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 19;
MEMORY_SIZE	= 990;
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
   3:  !* This program moves robot arm * ;
   4:  !* to positions with offsets    * ;
   5:  !* determined by a pred mod     * ;
   6:  !* The program ensures precise  * ;
   7:  !* positioning based on the     * ;
   8:  !* model's predictions          * ;
   9:  !*                              * ;
  10:  !******************************** ;
  11:   ;
  12:  UTOOL_NUM=1 ;
  13:  UFRAME_NUM=0 ;
  14:  R[1:PosRegControlBit]=2    ;
  15:  PR[2:ForecastOffset]=LPOS-LPOS    ;
  16:   ;
  17:  CALL MODELTOPOS    ;
  18:  CALL TRAJECTORY    ;
  19:   ;
/POS
/END
