/PROG  BG_SEL_MACH
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1494;
CREATE		= DATE 18-07-25  TIME 09:17:38;
MODIFIED	= DATE 18-07-25  TIME 09:17:38;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 88;
MEMORY_SIZE	= 1770;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  IF (R[20:selected marposs]=1 AND R[21:selected kog]=0 AND R[22:selected fc]=0) THEN ;
   2:   ;
   3:  R[13:marposs works]=1    ;
   4:  R[14:kog works]=0    ;
   5:  R[15:fc works]=0    ;
   6:  R[16:marposs kog wk]=0    ;
   7:  R[17:marposs fc work]=0    ;
   8:  R[18:kog fc work]=0    ;
   9:  R[19:marposs kog fc k]=0    ;
  10:   ;
  11:  ENDIF ;
  12:   ;
  13:  IF (R[20:selected marposs]=0 AND R[21:selected kog]=1 AND R[22:selected fc]=0) THEN ;
  14:   ;
  15:  R[13:marposs works]=0    ;
  16:  R[14:kog works]=1    ;
  17:  R[15:fc works]=0    ;
  18:  R[16:marposs kog wk]=0    ;
  19:  R[17:marposs fc work]=0    ;
  20:  R[18:kog fc work]=0    ;
  21:  R[19:marposs kog fc k]=0    ;
  22:   ;
  23:  ENDIF ;
  24:   ;
  25:  IF (R[20:selected marposs]=0 AND R[21:selected kog]=0 AND R[22:selected fc]=1) THEN ;
  26:   ;
  27:  R[13:marposs works]=0    ;
  28:  R[14:kog works]=0    ;
  29:  R[15:fc works]=1    ;
  30:  R[16:marposs kog wk]=0    ;
  31:  R[17:marposs fc work]=0    ;
  32:  R[18:kog fc work]=0    ;
  33:  R[19:marposs kog fc k]=0    ;
  34:   ;
  35:  ENDIF ;
  36:   ;
  37:  IF (R[20:selected marposs]=1 AND R[21:selected kog]=1 AND R[22:selected fc]=0) THEN ;
  38:   ;
  39:  R[13:marposs works]=0    ;
  40:  R[14:kog works]=0    ;
  41:  R[15:fc works]=0    ;
  42:  R[16:marposs kog wk]=1    ;
  43:  R[17:marposs fc work]=0    ;
  44:  R[18:kog fc work]=0    ;
  45:  R[19:marposs kog fc k]=0    ;
  46:   ;
  47:  ENDIF ;
  48:   ;
  49:   ;
  50:  IF (R[20:selected marposs]=1 AND R[21:selected kog]=0 AND R[22:selected fc]=1) THEN ;
  51:   ;
  52:  R[13:marposs works]=0    ;
  53:  R[14:kog works]=0    ;
  54:  R[15:fc works]=0    ;
  55:  R[16:marposs kog wk]=0    ;
  56:  R[17:marposs fc work]=1    ;
  57:  R[18:kog fc work]=0    ;
  58:  R[19:marposs kog fc k]=0    ;
  59:   ;
  60:  ENDIF ;
  61:   ;
  62:  IF (R[20:selected marposs]=0 AND R[21:selected kog]=1 AND R[22:selected fc]=1) THEN ;
  63:   ;
  64:  R[13:marposs works]=0    ;
  65:  R[14:kog works]=0    ;
  66:  R[15:fc works]=0    ;
  67:  R[16:marposs kog wk]=0    ;
  68:  R[17:marposs fc work]=0    ;
  69:  R[18:kog fc work]=1    ;
  70:  R[19:marposs kog fc k]=0    ;
  71:   ;
  72:  ENDIF ;
  73:   ;
  74:   ;
  75:  IF (R[20:selected marposs]=1 AND R[21:selected kog]=1 AND R[22:selected fc]=1) THEN ;
  76:   ;
  77:  R[13:marposs works]=0    ;
  78:  R[14:kog works]=0    ;
  79:  R[15:fc works]=0    ;
  80:  R[16:marposs kog wk]=0    ;
  81:  R[17:marposs fc work]=0    ;
  82:  R[18:kog fc work]=0    ;
  83:  R[19:marposs kog fc k]=1    ;
  84:   ;
  85:  ENDIF ;
  86:   ;
  87:   ;
  88:   ;
/POS
/END
