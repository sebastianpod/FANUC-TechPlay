/PROG  SELECT_BLISTER
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 336;
CREATE		= DATE 21-02-09  TIME 12:32:58;
MODIFIED	= DATE 21-02-09  TIME 12:32:58;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 12;
MEMORY_SIZE	= 660;
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
   1:  IF (R[52:Blister OK 1]<>2 AND R[53:Blister OK 2]<>2) THEN ;
   2:  IF (R[52:Blister OK 1]=1) THEN ;
   3:  R[52:Blister OK 1]=2    ;
   4:  ELSE ;
   5:  IF (R[53:Blister OK 2]=1) THEN ;
   6:  R[53:Blister OK 2]=2    ;
   7:  ENDIF ;
   8:  ENDIF ;
   9:  R[20:Palet loaded]=0    ;
  10:  ELSE ;
  11:  R[20:Palet loaded]=1    ;
  12:  ENDIF ;
/POS
/END
