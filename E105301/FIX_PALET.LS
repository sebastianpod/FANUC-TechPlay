/PROG  FIX_PALET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 520;
CREATE		= DATE 18-02-12  TIME 14:22:14;
MODIFIED	= DATE 19-11-02  TIME 11:54:32;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 13;
MEMORY_SIZE	= 872;
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
   1:  IF ((R[109:wrk up pick pal]=1 AND DI[183:forward up pick]=OFF AND DI[204:backward up pick]=ON)) THEN ;
   2:  WAIT DO[11116]=ON    ;
   3:  CALL PULL_UPPER_PALET    ;
   4:  ENDIF ;
   5:  IF ((R[110:wrk low pick pal]=1 AND DI[183:forward up pick]=OFF AND DI[204:backward up pick]=ON AND DI[178:forward low pick]=OFF AND DI[208:backward low pick]=ON)) THEN ;
   6:  CALL PULL_LOWER_PALET    ;
   7:  ENDIF ;
   8:  IF ((R[111:wrk up place pal]=1 AND DI[202:forward up place]=OFF AND DI[207:backward up place]=ON)) THEN ;
   9:  CALL PULL_UPPER_PLACE_PALET    ;
  10:  ENDIF ;
  11:  IF ((R[112:wrk low place pl]=1 AND DI[202:forward up place]=OFF AND DI[207:backward up place]=ON AND DI[181:forward low place]=OFF AND DI[206:backward low place]=ON)) THEN ;
  12:  CALL PULL_PLACE_LOWER_PALET    ;
  13:  ENDIF ;
/POS
/END
