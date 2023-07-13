/PROG  HOME_POSITION
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 846;
CREATE		= DATE 20-05-26  TIME 13:01:30;
MODIFIED	= DATE 21-02-08  TIME 12:55:50;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 16;
MEMORY_SIZE	= 1154;
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
   1:  !Ustawienie globalnego UW ;
   2:  UFRAME_NUM=0 ;
   3:  !Wybrano PF5458 ;
   4:  IF (R[10:PF5458]=1) THEN ;
   5:  !Chwytak Gimatic bez obciazenia ;
   6:  PAYLOAD[1:Gimatic unloaded] ;
   7:  !Pozycja startowa UT=1 ;
   8:J P[1] 100% FINE    ;
   9:  ELSE ;
  10:  !Chwytak Zannini bez obciazenia ;
  11:  PAYLOAD[3:Zannini unloaded] ;
  12:  !Pozycja startowa UT=2 ;
  13:J P[2] 100% FINE    ;
  14:  ENDIF ;
  15:  !Czy osiagnieto SAFTY POS ;
  16:  WAIT DO[167:Ref pos control]=ON    ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,	
	J1=   -51.166 deg,	J2=    -8.231 deg,	J3=   -20.611 deg,
	J4=     -.201 deg,	J5=   -68.493 deg,	J6=    35.974 deg
};
P[2]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   248.894  mm,	Y =  -307.998  mm,	Z =    93.404  mm,
	W =   179.627 deg,	P =     -.835 deg,	R =   -15.261 deg
};
/END
