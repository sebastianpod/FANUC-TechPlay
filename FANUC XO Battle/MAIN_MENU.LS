/PROG  MAIN_MENU
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "RunKarelMainMenu";
PROG_SIZE	= 414;
CREATE		= DATE 26-03-10  TIME 14:30:04;
MODIFIED	= DATE 26-03-10  TIME 16:19:32;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 9;
MEMORY_SIZE	= 758;
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
   1:  !This TP program starts the KAREL ;
   2:  !MAIN_MENU app which controls the ;
   3:  !arcade-style menu and animations ;
   4:  !The KAREL menu lets the player ;
   5:  !choose game mode (PvR or RvR) ;
   6:  !and select the player symbol ;
   7:   ;
   8:  CALL XO_MAIN_MENU    ;
   9:   ;
/POS
/END
