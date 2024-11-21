/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 588;
CREATE		= DATE 24-09-09  TIME 22:15:44;
MODIFIED	= DATE 24-11-01  TIME 22:01:54;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 13;
MEMORY_SIZE	= 916;
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
   1:  !******************************** ;
   2:  !*                              * ;
   3:  !* Project name: Telemach       * ;
   4:  !* Author: Sebastian PODSIADLO  * ;
   5:  !* version: 1.00                * ;
   6:  !* last update: 01.11.2024      * ;
   7:  !*                              * ;
   8:  !******************************** ;
   9:   ;
  10:  !Program with argument ;
  11:  !0 - skip training ;
  12:  !<> 0 - perform training ;
  13:  CALL CYCLE(1) ;
/POS
/END