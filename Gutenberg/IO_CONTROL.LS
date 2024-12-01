/PROG  IO_CONTROL	  Macro
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1605;
CREATE		= DATE 22-07-11  TIME 09:03:22;
MODIFIED	= DATE 24-12-01  TIME 16:21:00;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 99;
MEMORY_SIZE	= 1965;
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

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
   1:  IF (R[R[99]]=1) THEN ;
   2:  DO[1:LETTER A]=ON ;
   3:  ENDIF ;
   4:   ;
   5:  IF (R[R[99]]=2) THEN ;
   6:  DO[2:LETTER B]=ON ;
   7:  ENDIF ;
   8:   ;
   9:  IF (R[R[99]]=3) THEN ;
  10:  DO[3:LETTER C]=ON ;
  11:  ENDIF ;
  12:   ;
  13:  IF (R[R[99]]=4) THEN ;
  14:  DO[4:LETTER D]=ON ;
  15:  ENDIF ;
  16:   ;
  17:  IF (R[R[99]]=5) THEN ;
  18:  DO[5:LETTER E]=ON ;
  19:  ENDIF ;
  20:   ;
  21:  IF (R[R[99]]=6) THEN ;
  22:  DO[6:LETTER F]=ON ;
  23:  ENDIF ;
  24:   ;
  25:  IF (R[R[99]]=7) THEN ;
  26:  DO[7:LETTER G]=ON ;
  27:  ENDIF ;
  28:   ;
  29:  IF (R[R[99]]=8) THEN ;
  30:  DO[8:LETTER H]=ON ;
  31:  ENDIF ;
  32:   ;
  33:  IF (R[R[99]]=9) THEN ;
  34:  DO[9:LETTER I]=ON ;
  35:  ENDIF ;
  36:   ;
  37:  IF (R[R[99]]=10) THEN ;
  38:  DO[10:LETTER J]=ON ;
  39:  ENDIF ;
  40:   ;
  41:  IF (R[R[99]]=11) THEN ;
  42:  DO[11:LETTER K]=ON ;
  43:  ENDIF ;
  44:   ;
  45:  IF (R[R[99]]=12) THEN ;
  46:  DO[12:LETTER L]=ON ;
  47:  ENDIF ;
  48:   ;
  49:  IF (R[R[99]]=13) THEN ;
  50:  DO[13:LETTER M]=ON ;
  51:  ENDIF ;
  52:   ;
  53:  IF (R[R[99]]=14) THEN ;
  54:  DO[14:LETTER N]=ON ;
  55:  ENDIF ;
  56:   ;
  57:  IF (R[R[99]]=15) THEN ;
  58:  DO[15:LETTER O]=ON ;
  59:  ENDIF ;
  60:   ;
  61:  IF (R[R[99]]=16) THEN ;
  62:  DO[16:LETTER P]=ON ;
  63:  ENDIF ;
  64:  IF (R[R[99]]=17) THEN ;
  65:  DO[17:LETTER R]=ON ;
  66:  ENDIF ;
  67:   ;
  68:  IF (R[R[99]]=18) THEN ;
  69:  DO[18:LETTER S]=ON ;
  70:  ENDIF ;
  71:   ;
  72:  IF (R[R[99]]=19) THEN ;
  73:  DO[19:LETTER T]=ON ;
  74:  ENDIF ;
  75:   ;
  76:  IF (R[R[99]]=20) THEN ;
  77:  DO[20:LETTER U]=ON ;
  78:  ENDIF ;
  79:   ;
  80:  IF (R[R[99]]=21) THEN ;
  81:  DO[21:LETTER W]=ON ;
  82:  ENDIF ;
  83:   ;
  84:  IF (R[R[99]]=22) THEN ;
  85:  DO[22:LETTER X]=ON ;
  86:  ENDIF ;
  87:   ;
  88:  IF (R[R[99]]=23) THEN ;
  89:  DO[23:LETTER Y]=ON ;
  90:  ENDIF ;
  91:   ;
  92:  IF (R[R[99]]=24) THEN ;
  93:  DO[24:LETTER Z]=ON ;
  94:  ENDIF ;
  95:   ;
  96:  IF (R[R[99]]=0) THEN ;
  97:  DO[25:SPACE]=ON ;
  98:  ENDIF ;
  99:   ;
/POS
/END
