/PROG  PROCESS_EVAL
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "ProcessEvaluate";
PROG_SIZE	= 1660;
CREATE		= DATE 26-09-02  TIME 15:47:52;
MODIFIED	= DATE 26-09-21  TIME 16:32:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 80;
MEMORY_SIZE	= 1968;
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
   1:  !================================ ;
   2:  !==                            == ;
   3:  !== EVALUATES PROCESS QUALITY  == ;
   4:  !== SETS FINAL RESULT AND CODE == ;
   5:  !==                            == ;
   6:  !================================ ;
   7:   ;
   8:  !SET DEFAULT RESULT TO OK ;
   9:  R[4:PROCESS_RESULT]=1    ;
  10:  R[5:RESULT_CODE]=1    ;
  11:   ;
  12:  !== RESULT CODE DEFINITIONS == ;
  13:   ;
  14:  !0 = NOT_EVALUATED ;
  15:  !1 = PROCESS_OK ;
  16:  !2 = GLUE_APPLICATION_LOST ;
  17:  !3 = CYCLE_TIME_TOO_LOW ;
  18:  !4 = CYCLE_TIME_TOO_HIGH ;
  19:  !5 = GLUE_FLOW_TOO_LOW ;
  20:  !6 = GLUE_FLOW_TOO_HIGH ;
  21:   ;
  22:   ;
  23:  !EVALUATE COMPLETED PROCESS ;
  24:  IF (F[2:PROCESS_FINISHED]=ON) THEN ;
  25:   ;
  26:  !PRIORITY 1: FLOW TOO LOW ;
  27:  IF (F[5:GLUE_FLOW_BELOW_TOL]=ON) THEN ;
  28:   ;
  29:  R[4:PROCESS_RESULT]=2    ;
  30:  R[5:RESULT_CODE]=5    ;
  31:  UALM[4] ;
  32:   ;
  33:  ELSE ;
  34:   ;
  35:  !PRIORITY 2: FLOW TOO HIGH ;
  36:  IF (F[6:GLUE_FLOW_ABOVE_TOL]=ON) THEN ;
  37:   ;
  38:  R[4:PROCESS_RESULT]=2    ;
  39:  R[5:RESULT_CODE]=6    ;
  40:  UALM[5] ;
  41:   ;
  42:  ELSE ;
  43:   ;
  44:  !PRIORITY 3: TIME TOO LOW ;
  45:  IF (R[1:GLUE_CYCLE_TIME]<R[2:CYCLE_TIME_MIN]) THEN ;
  46:   ;
  47:  R[4:PROCESS_RESULT]=2    ;
  48:  R[5:RESULT_CODE]=3    ;
  49:  UALM[2] ;
  50:   ;
  51:  ELSE ;
  52:   ;
  53:  !PRIORITY 4: TIME TOO HIGH ;
  54:  IF (R[1:GLUE_CYCLE_TIME]>R[3:CYCLE_TIME_MAX]) THEN ;
  55:   ;
  56:  R[4:PROCESS_RESULT]=2    ;
  57:  R[5:RESULT_CODE]=4    ;
  58:  UALM[3] ;
  59:   ;
  60:  ELSE ;
  61:   ;
  62:  !PROCESS COMPLETED CORRECTLY ;
  63:  R[4:PROCESS_RESULT]=1    ;
  64:  R[5:RESULT_CODE]=1    ;
  65:   ;
  66:  ENDIF ;
  67:  ENDIF ;
  68:  ENDIF ;
  69:  ENDIF ;
  70:  ENDIF ;
  71:   ;
  72:  !CHECK PROCESS INTERRUPTION ;
  73:  IF (F[3:GLUE_APPLICATION_LOST]=ON) THEN ;
  74:   ;
  75:  !GLUE APPLICATION WAS LOST ;
  76:  R[4:PROCESS_RESULT]=2    ;
  77:  R[5:RESULT_CODE]=2    ;
  78:  UALM[1] ;
  79:   ;
  80:  ENDIF ;
/POS
/END
