/PROG  CYCLE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 888;
CREATE		= DATE 24-09-09  TIME 22:59:48;
MODIFIED	= DATE 24-11-12  TIME 10:12:40;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 31;
MEMORY_SIZE	= 1160;
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
   1:  !******************************** ;
   2:  !*                              * ;
   3:  !* Cycle program                * ;
   4:  !* exec training if required    * ;
   5:  !* then proceeds to testing     * ;
   6:  !* with predictive offsets      * ;
   7:  !*                              * ;
   8:  !******************************** ;
   9:   ;
  10:  !Init ;
  11:  R[1:PosRegControlBit]=0    ;
  12:  R[100:TrainingLoop]=0    ;
  13:  R[101:TestingLoop]=0    ;
  14:   ;
  15:  !Position check ;
  16:  IF (DO[1]<>ON) THEN ;
  17:  CALL HOMING    ;
  18:  ENDIF ;
  19:   ;
  20:  !Check if training is required ;
  21:  IF (AR[1]<>0) THEN ;
  22:   ;
  23:  !Num of data to collect ;
  24:  !Definied by the argument ;
  25:  CALL TRAINING(1000) ;
  26:   ;
  27:  ENDIF ;
  28:   ;
  29:  !Continue with testing phase ;
  30:  CALL TESTING    ;
  31:   ;
/POS
/END
