/PROG  GET_CUR_POS_UF
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 594;
CREATE		= DATE 25-01-27  TIME 21:57:10;
MODIFIED	= DATE 25-01-29  TIME 14:45:32;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 14;
MEMORY_SIZE	= 910;
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
   3:  !* This prog saves curr pos     * ;
   4:  !* in active UF and store it    * ;
   5:  !* in the PosReg.               * ;
   6:  !* The program was created      * ;
   7:  !* due to the limitation        * ;
   8:  !* of the Karel language        * ;
   9:  !*                              * ;
  10:  !******************************** ;
  11:   ;
  12:  UFRAME_NUM=1 ;
  13:  PR[1]=LPOS    ;
  14:   ;
/POS
/END
