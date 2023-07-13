/PROG  AZZERAMEN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 368;
CREATE		= DATE 18-06-11  TIME 17:15:50;
MODIFIED	= DATE 18-06-20  TIME 15:03:08;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 15;
MEMORY_SIZE	= 680;
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
   1:  IF (R[12:zeroing id]=1) THEN ;
   2:  R[10:id palet part ok]=0    ;
   3:  R[7:picked parts]=0    ;
   4:  R[1:parts checked]=0    ;
   5:  R[2:parts ok]=0    ;
   6:  R[3:parts nok]=0    ;
   7:  R[4:funct. checked]=0    ;
   8:  R[5:kogame checked]=0    ;
   9:  R[6:hommel checked]=0    ;
  10:  R[8:part in chuck_1]=0    ;
  11:  R[9:part in chuck_2]=0    ;
  12:  R[63]=0    ;
  13:  R[10:id palet part ok]=0    ;
  14:   ;
  15:  ENDIF ;
/POS
/END
