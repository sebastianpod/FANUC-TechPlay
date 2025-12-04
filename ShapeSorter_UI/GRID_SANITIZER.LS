/PROG  GRID_SANITIZER
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "GridValueMonitor";
PROG_SIZE	= 1548;
CREATE		= DATE 25-12-03  TIME 08:20:34;
MODIFIED	= DATE 25-12-03  TIME 08:43:40;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 75;
MEMORY_SIZE	= 1876;
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
   1:   ;
   2:  !Monitor R[1]-R[16] for valid ;
   3:  !product (1=BOX,2=HEX,3=EMPTY) ;
   4:  !If value is outside range ;
   5:  !set register to 3 (EMPTY) ;
   6:   ;
   7:  !Background Logic does not allow ;
   8:  !FOR loops or iterative commands ;
   9:  !Each register must be checked ;
  10:  !individually using IF statements ;
  11:   ;
  12:  IF (R[1:1,1]<1 OR R[1:1,1]>3) THEN ;
  13:  R[1:1,1]=3    ;
  14:  ENDIF ;
  15:   ;
  16:  IF (R[2:1,2]<1 OR R[2:1,2]>3) THEN ;
  17:  R[2:1,2]=3    ;
  18:  ENDIF ;
  19:   ;
  20:  IF (R[3:1,3]<1 OR R[3:1,3]>3) THEN ;
  21:  R[3:1,3]=3    ;
  22:  ENDIF ;
  23:   ;
  24:  IF (R[4:1,4]<1 OR R[4:1,4]>3) THEN ;
  25:  R[4:1,4]=3    ;
  26:  ENDIF ;
  27:   ;
  28:  IF (R[5:2,1]<1 OR R[5:2,1]>3) THEN ;
  29:  R[5:2,1]=3    ;
  30:  ENDIF ;
  31:   ;
  32:  IF (R[6:2,2]<1 OR R[6:2,2]>3) THEN ;
  33:  R[6:2,2]=3    ;
  34:  ENDIF ;
  35:   ;
  36:  IF (R[7:2,3]<1 OR R[7:2,3]>3) THEN ;
  37:  R[7:2,3]=3    ;
  38:  ENDIF ;
  39:   ;
  40:  IF (R[8:2,4]<1 OR R[8:2,4]>3) THEN ;
  41:  R[8:2,4]=3    ;
  42:  ENDIF ;
  43:   ;
  44:  IF (R[9:3,1]<1 OR R[9:3,1]>3) THEN ;
  45:  R[9:3,1]=3    ;
  46:  ENDIF ;
  47:   ;
  48:  IF (R[10:3,2]<1 OR R[10:3,2]>3) THEN ;
  49:  R[10:3,2]=3    ;
  50:  ENDIF ;
  51:   ;
  52:  IF (R[11:3,3]<1 OR R[11:3,3]>3) THEN ;
  53:  R[11:3,3]=3    ;
  54:  ENDIF ;
  55:   ;
  56:  IF (R[12:3,4]<1 OR R[12:3,4]>3) THEN ;
  57:  R[12:3,4]=3    ;
  58:  ENDIF ;
  59:   ;
  60:  IF (R[13:4,1]<1 OR R[13:4,1]>3) THEN ;
  61:  R[13:4,1]=3    ;
  62:  ENDIF ;
  63:   ;
  64:  IF (R[14:4,2]<1 OR R[14:4,2]>3) THEN ;
  65:  R[14:4,2]=3    ;
  66:  ENDIF ;
  67:   ;
  68:  IF (R[15:4,3]<1 OR R[15:4,3]>3) THEN ;
  69:  R[15:4,3]=3    ;
  70:  ENDIF ;
  71:   ;
  72:  IF (R[16:4,4]<1 OR R[16:4,4]>3) THEN ;
  73:  R[16:4,4]=3    ;
  74:  ENDIF ;
  75:   ;
/POS
/END
