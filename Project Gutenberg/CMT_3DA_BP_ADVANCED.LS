/PROG  CMT_3DA_BP_ADVANCED
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Comment P & PR";
PROG_SIZE	= 816;
CREATE		= DATE 19-12-26  TIME 15:28:06;
MODIFIED	= DATE 19-12-26  TIME 15:28:06;
FILE_NAME	= CMT_3DA_;
VERSION		= 0;
LINE_COUNT	= 20;
MEMORY_SIZE	= 1116;
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
/APPL
/MN
   1:  !BPCMTAD.PC enters comments into ;
   2:  !registers (R) and position ;
   3:  !registers (PR) used in ;
   4:  !V_3DA_BP_MAIN.TP,  ;
   5:  !V_3DA_BP_SUB.TP and ;
   6:  !V_3DA_FOV.TP. ;
   7:   ;
   8:  !Arg.1:Start index number of R ;
   9:  !      (8 comments are entered ;
  10:  !      into R in serial number.) ;
  11:  !Arg.2:Start index number of PR ;
  12:  !      (4 comments are entered ;
  13:  !      into PR in serial number.) ;
  14:   ;
  15:  !4th PR number should be set on ;
  16:  !the number of Tofs on Approach ;
  17:  !Setup in PICK Position List ;
  18:  !in PARTS LIST MANAGER. ;
  19:   ;
  20:  CALL BPCMTAD(1,20) ;
/POS
/END
