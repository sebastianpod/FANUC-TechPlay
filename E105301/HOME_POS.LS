/PROG  HOME_POS
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 639;
CREATE		= DATE 12-02-18  TIME 15:20:12;
MODIFIED	= DATE 21-01-31  TIME 11:13:52;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 9;
MEMORY_SIZE	= 975;
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
   1:  !Wywolanie UT=1 ;
   2:  UTOOL_NUM=1 ;
   3:  !Wywolanie UF=1 ;
   4:  UFRAME_NUM=1 ;
   5:  !Payload chwytaki puste ;
   6:  PAYLOAD[1] ;
   7:J P[2] 100% CNT100 RO[2]=ON RO[3]=ON    ;
   8:  !Czy osiagnieto pozycje bezpiecza ;
   9:  WAIT DO[101:Home position]=ON    ;
/POS
P[2]{
   GP1:
	UF : 1, UT : 1,	
	J1=   125.946 deg,	J2=   -23.912 deg,	J3=   -40.404 deg,
	J4=    -1.902 deg,	J5=    41.095 deg,	J6=     5.620 deg
};
/END
