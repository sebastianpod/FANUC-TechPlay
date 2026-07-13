/PROG  CHECK_DRAW
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "DrawDetection";
PROG_SIZE	= 718;
CREATE		= DATE 26-03-10  TIME 20:36:56;
MODIFIED	= DATE 26-07-09  TIME 11:23:50;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 27;
MEMORY_SIZE	= 1114;
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
   1:  !Detects draw state only ;
   2:  !if no win is present. ;
   3:  !Verifies all 9 cells are ;
   4:  !non-zero (board is full). ;
   5:  !Sets R[11] = 2 (draw) ;
   6:   ;
   7:  !Check for win ;
   8:  IF R[11:WIN_STATUS]=1,JMP LBL[999] ;
   9:   ;
  10:  !Check for empty cells ;
  11:  IF R[1:CELL_1.1]=0,JMP LBL[999] ;
  12:  IF R[2:CELL_1.2]=0,JMP LBL[999] ;
  13:  IF R[3:CELL_1.3]=0,JMP LBL[999] ;
  14:  IF R[4:CELL_2.1]=0,JMP LBL[999] ;
  15:  IF R[5:CELL_2.2]=0,JMP LBL[999] ;
  16:  IF R[6:CELL_2.3]=0,JMP LBL[999] ;
  17:  IF R[7:CELL_3.1]=0,JMP LBL[999] ;
  18:  IF R[8:CELL_3.2]=0,JMP LBL[999] ;
  19:  IF R[9:CELL_3.3]=0,JMP LBL[999] ;
  20:   ;
  21:  !If reached here: draw! ;
  22:  R[11:WIN_STATUS]=2    ;
  23:  DO[3:DRAW]=ON ;
  24:   ;
  25:  !Exit label ;
  26:  LBL[999] ;
  27:   ;
/POS
/END
