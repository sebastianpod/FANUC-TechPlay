/PROG  SELECT_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 264;
CREATE		= DATE 21-02-09  TIME 12:33:18;
MODIFIED	= DATE 21-02-09  TIME 12:35:56;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 8;
MEMORY_SIZE	= 604;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  IF (R[51:Palet 1]<>2) THEN ;
   2:  IF (R[51:Palet 1]=1) THEN ;
   3:  R[51:Palet 1]=2    ;
   4:  ENDIF ;
   5:  R[20:Palet loaded]=0    ;
   6:  ELSE ;
   7:  R[20:Palet loaded]=2    ;
   8:  ENDIF ;
/POS
/END
