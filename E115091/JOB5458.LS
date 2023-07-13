/PROG  JOB5458
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1728;
CREATE		= DATE 20-05-26  TIME 15:13:50;
MODIFIED	= DATE 21-02-10  TIME 10:29:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 47;
MEMORY_SIZE	= 2196;
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
   1:  !Definiowanie UT = 1 Gimatic ;
   2:  UTOOL_NUM=1 ;
   3:  !Zero rej poz osi Z brushing  ;
   4:  PR[3]=LPOS-LPOS    ;
   5:  !Regulacja wys szczotkowania ;
   6:  PR[3,3]=(-1)*R[3:z axis brushing]    ;
   7:  !Zerowanie statusu palet ;
   8:  R[51:Palet 1]=0    ;
   9:  R[52:Blister OK 1]=0    ;
  10:  R[53:Blister OK 2]=0    ;
  11:  !Zerowanie osi palety pick ;
  12:  R[101:x axis pick]=0    ;
  13:  R[102:y axis pick]=0    ;
  14:  !Zerowanie osi blitra OK ;
  15:  R[103:x axis place]=0    ;
  16:  R[104:y axis place]=0    ;
  17:  !Pocztek petli pracy ;
  18:  LBL[1] ;
  19:  !Zerowanie osi na koniec palety ;
  20:  IF (R[101:x axis pick]=0 AND R[102:y axis pick]=0) THEN ;
  21:  !Dojazd do pozycji startowej ;
  22:  CALL HOME_POSITION    ;
  23:  ENDIF ;
  24:  !Kontrola deklaracji palety ;
  25:  WAIT R[51:Palet 1]=1    ;
  26:  !Wywolanie prog - pobieranie ;
  27:  CALL PICK_PF5458    ;
  28:  !Ustawienie globalnego UW ;
  29:  UFRAME_NUM=0 ;
  30:  !Dojazd do szczotki ;
  31:J P[2] 100% FINE    ;
  32:  !Szczotkowanie ;
  33:J P[3] 60% CNT10 Offset,PR[3]    ;
  34:  WAIT   1.00(sec) ;
  35:J P[4] 60% CNT10 Offset,PR[3]    ;
  36:  WAIT   1.00(sec) ;
  37:J P[5] 60% CNT10 Offset,PR[3]    ;
  38:  WAIT   1.00(sec) ;
  39:J P[6] 60% CNT10 Offset,PR[3]    ;
  40:  WAIT   1.00(sec) ;
  41:J P[3] 60% CNT10 Offset,PR[3]    ;
  42:  !Odjazd od szczotki ;
  43:J P[2] 100% CNT100    ;
  44:J P[7] 100% CNT100    ;
  45:  !Wywolanie prog - odkladanie ;
  46:  CALL PLACE_PF5458    ;
  47:  JMP LBL[1] ;
/POS
P[2]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   496.786  mm,	Y =  -170.639  mm,	Z =   -89.946  mm,
	W =   -90.665 deg,	P =    15.419 deg,	R =     1.341 deg
};
P[3]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   497.000  mm,	Y =  -150.574  mm,	Z =  -115.500  mm,
	W =   -90.000 deg,	P =    15.419 deg,	R =     1.300 deg
};
P[4]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   497.000  mm,	Y =  -129.224  mm,	Z =  -115.500  mm,
	W =   -90.000 deg,	P =    15.419 deg,	R =     1.300 deg
};
P[5]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   497.000  mm,	Y =  -129.224  mm,	Z =  -115.500  mm,
	W =    90.000 deg,	P =     -.965 deg,	R =  -180.000 deg
};
P[6]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, -1',
	X =   497.000  mm,	Y =  -129.225  mm,	Z =  -115.500  mm,
	W =   -90.000 deg,	P =     1.593 deg,	R =     0.000 deg
};
P[7]{
   GP1:
	UF : 0, UT : 1,	
	J1=   -29.683 deg,	J2=    24.394 deg,	J3=   -40.940 deg,
	J4=      .553 deg,	J5=   -49.860 deg,	J6=    30.558 deg
};
/END
