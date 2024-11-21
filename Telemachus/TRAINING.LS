/PROG  TRAINING
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 962;
CREATE		= DATE 24-10-14  TIME 09:48:54;
MODIFIED	= DATE 24-10-25  TIME 23:22:22;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 35;
MEMORY_SIZE	= 1346;
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
   3:  !* This program collects data   * ;
   4:  !* for calcs in an ext Python   * ;
   5:  !* pred model. The num of data  * ;
   6:  !* to be collected is defined   * ;
   7:  !* by the user through an arg   * ;
   8:  !*                              * ;
   9:  !******************************** ;
  10:   ;
  11:  !Exception handling ;
  12:  !Check if the argument > 1 ;
  13:  IF (AR[1]<=1 OR AR[1] MOD 1<>0) THEN ;
  14:   ;
  15:  !Display error message ;
  16:  UALM[1] ;
  17:  !Abort program ;
  18:  ABORT ;
  19:   ;
  20:  ENDIF ;
  21:   ;
  22:  UTOOL_NUM=1 ;
  23:  UFRAME_NUM=0 ;
  24:  R[1:PosRegControlBit]=1    ;
  25:   ;
  26:  !Data collecting loop ;
  27:  !Number of exec defined by arg ;
  28:  FOR R[100:TrainingLoop]=0 TO AR[1] ;
  29:   ;
  30:  CALL TRAJECTORY    ;
  31:  CALL GET_DATA    ;
  32:  CALL HOMING    ;
  33:   ;
  34:  ENDFOR ;
  35:   ;
/POS
/END
