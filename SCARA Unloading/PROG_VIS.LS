/PROG  PROG_VIS
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 470;
CREATE		= DATE 22-06-13  TIME 13:16:06;
MODIFIED	= DATE 25-11-16  TIME 19:35:46;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 11;
MEMORY_SIZE	= 930;
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
   1:  !Calls vision for part detection ;
   2:  !Part offset is stored in VR[1] ;
   3:  !Error handling included: ;
   4:  !On error go to LBL[100] ;
   5:  !In sim, part is always found ;
   6:  !so LBL at start ensures repeated ;
   7:  !search until success ;
   8:   ;
   9:  LBL[100] ;
  10:  VISION RUN_FIND 'PART_DETECTION'    ;
  11:  VISION GET_OFFSET 'PART_DETECTION' VR[1] JMP LBL[100] ;
/POS
/END
