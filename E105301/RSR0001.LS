/PROG  RSR0001
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 794;
CREATE		= DATE 18-09-05  TIME 00:00:00;
MODIFIED	= DATE 20-07-17  TIME 10:57:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 28;
MEMORY_SIZE	= 1110;
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
   1:  !Wybrano stacje Marposs ;
   2:  IF (R[13:marposs works]=1) THEN ;
   3:  CALL JOB_MARPOSS    ;
   4:  ENDIF ;
   5:  !Wybrano stacje Kogame ;
   6:  IF (R[14:kog works]=1) THEN ;
   7:  CALL JOB_KOGAME    ;
   8:  ENDIF ;
   9:  !Wybrano stacje FC ;
  10:  IF (R[15:fc works]=1) THEN ;
  11:  CALL JOB_FC    ;
  12:  ENDIF ;
  13:  !Wybrano stacje Marposs+Kogame ;
  14:  IF (R[16:marposs kog wk]=1) THEN ;
  15:  CALL PR_VICI_KOG    ;
  16:  ENDIF ;
  17:  !Wybrano stacje Marposs+FC ;
  18:  IF (R[17:marposs fc work]=1) THEN ;
  19:  CALL JOB_MARPOSS_FC    ;
  20:  ENDIF ;
  21:  !Wybrano stacje Kogame+FC ;
  22:  IF (R[18:kog fc work]=1) THEN ;
  23:  CALL JOB_KOGAME_FC    ;
  24:  ENDIF ;
  25:  !Wybrano stacje Marposs+Kogame+FC ;
  26:  IF (R[19:marposs kog fc k]=1) THEN ;
  27:  CALL JOB_MARPOSS_KOGAME_FC    ;
  28:  ENDIF ;
/POS
/END
