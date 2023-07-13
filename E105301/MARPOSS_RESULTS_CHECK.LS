/PROG  MARPOSS_RESULTS_CHECK
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 716;
CREATE		= DATE 22-06-15  TIME 10:13:36;
MODIFIED	= DATE 22-06-15  TIME 10:17:36;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 41;
MEMORY_SIZE	= 1052;
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
   1:  WAIT DI[191:ready marposs]=ON    ;
   2:  IF (R[6:hommel checked] MOD 4=0) THEN ;
   3:  IF (DI[185:good marposs]=ON) THEN ;
   4:  R[90]=1    ;
   5:  ELSE ;
   6:  R[90]=0    ;
   7:  ENDIF ;
   8:  ENDIF ;
   9:   ;
  10:  IF (R[6:hommel checked] MOD 4=1) THEN ;
  11:  IF (DI[185:good marposs]=ON) THEN ;
  12:  R[91]=1    ;
  13:  ELSE ;
  14:  R[91]=0    ;
  15:  ENDIF ;
  16:  ENDIF ;
  17:   ;
  18:  IF (R[6:hommel checked] MOD 4=2) THEN ;
  19:  IF (DI[185:good marposs]=ON) THEN ;
  20:  R[92]=1    ;
  21:  ELSE ;
  22:  R[92]=0    ;
  23:  ENDIF ;
  24:  ENDIF ;
  25:   ;
  26:  IF (R[6:hommel checked] MOD 4=3) THEN ;
  27:  IF (DI[185:good marposs]=ON) THEN ;
  28:  R[93]=1    ;
  29:  ELSE ;
  30:  R[93]=0    ;
  31:  ENDIF ;
  32:  ENDIF ;
  33:   ;
  34:   ;
  35:   ;
  36:   ;
  37:   ;
  38:   ;
  39:   ;
  40:   ;
  41:   ;
/POS
/END
