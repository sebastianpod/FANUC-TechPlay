/PROG  JOB5715
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1716;
CREATE		= DATE 20-05-26  TIME 15:15:52;
MODIFIED	= DATE 21-02-10  TIME 15:26:46;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 46;
MEMORY_SIZE	= 2188;
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
   1:  !Definiowanie UT = 2 Zannini proj ;
   2:  UTOOL_NUM=2 ;
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
  25:  WAIT R[20:Palet loaded]=1    ;
  26:  !Wywolanie prog - pobieranie ;
  27:  CALL PICK_PF5715    ;
  28:  !Ustawienie globalnego UW ;
  29:  UFRAME_NUM=0 ;
  30:  !Dojazd do szczotki ;
  31:J P[2] 100% CNT100    ;
  32:  !Szczotkowanie ;
  33:J P[3] 60% CNT10 Offset,PR[3]    ;
  34:  WAIT   1.00(sec) ;
  35:J P[4] 60% CNT10 Offset,PR[3]    ;
  36:  WAIT   1.00(sec) ;
  37:J P[5] 60% CNT10 Offset,PR[3]    ;
  38:  WAIT   1.00(sec) ;
  39:J P[6] 60% CNT10 Offset,PR[3]    ;
  40:  WAIT   1.00(sec) ;
  41:  !Odjazd od szczotki ;
  42:J P[2] 100% CNT100    ;
  43:J P[7] 100% CNT100    ;
  44:  !Wywolanie prog - odkladanie ;
  45:  CALL PLACE_PF5715    ;
  46:  JMP LBL[1] ;
/POS
P[2]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   501.535  mm,	Y =  -258.159  mm,	Z =  -118.001  mm,
	W =    90.389 deg,	P =    45.525 deg,	R =  -178.391 deg
};
P[3]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   504.874  mm,	Y =  -228.963  mm,	Z =  -118.621  mm,
	W =    43.495 deg,	P =   -88.579 deg,	R =  -132.395 deg
};
P[4]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   503.821  mm,	Y =  -231.654  mm,	Z =  -118.442  mm,
	W =   -89.067 deg,	P =   -40.826 deg,	R =      .829 deg
};
P[5]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   501.535  mm,	Y =  -258.159  mm,	Z =  -118.001  mm,
	W =    90.389 deg,	P =    45.525 deg,	R =  -178.391 deg
};
P[6]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   502.881  mm,	Y =  -249.084  mm,	Z =   -74.764  mm,
	W =    90.983 deg,	P =    42.269 deg,	R =  -176.271 deg
};
P[7]{
   GP1:
	UF : 0, UT : 2,		CONFIG : 'N U T, 0, 0, 1',
	X =   375.102  mm,	Y =  -321.877  mm,	Z =    23.851  mm,
	W =  -179.225 deg,	P =      .163 deg,	R =  -176.271 deg
};
/END
