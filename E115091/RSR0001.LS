/PROG  RSR0001
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 528;
CREATE		= DATE 19-11-23  TIME 19:50:24;
MODIFIED	= DATE 22-03-17  TIME 09:44:30;
FILE_NAME	= RSR0001;
VERSION		= 0;
LINE_COUNT	= 17;
MEMORY_SIZE	= 848;
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
/APPL
/MN
   1:  !Wczytanie UF1 ;
   2:  !Zdefiniowanie UF ;
   3:  UFRAME_NUM=0 ;
   4:  !Kontrola wyboru chwytaka ;
   5:  WAIT R[2:UT NUM]<>0    ;
   6:  !Zdefiniowanie UT ;
   7:  UTOOL_NUM=R[2:UT NUM] ;
   8:  !Start tylko w SAFTY POS ;
   9:  //WAIT DO[10]=ON    ;
  10:  !Wybrano PF5458 ;
  11:  IF (R[10:PF5458]=1) THEN ;
  12:  CALL JOB5458    ;
  13:  ENDIF ;
  14:  !Wybrano PF5715 ;
  15:  IF (R[11:PF5715]=1) THEN ;
  16:  CALL JOB5715    ;
  17:  ENDIF ;
/POS
/END
