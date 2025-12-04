/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 2244;
CREATE		= DATE 25-12-03  TIME 09:50:06;
MODIFIED	= DATE 25-12-03  TIME 09:50:06;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 71;
MEMORY_SIZE	= 2760;
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
   1:  !FANUC America Corp. ;
   2:  !ROBOGUIDE Generated This TPP ;
   3:  !Run SimPRO.cf to setup frame and ;
   4:  UTOOL_NUM[GP1]=1 ;
   5:  UFRAME_NUM[GP1]=0 ;
   6:  PAYLOAD[1:Gripper empty] ;
   7:  CALL HOME_POSITION    ;
   8:  UTOOL_NUM[GP1]=1 ;
   9:  UFRAME_NUM[GP1]=0 ;
  10:  FOR R[20:MAIN LOOP IND]=1 TO 16 ;
  11:  CALL IO_RESET    ;
  12:  UTOOL_NUM[GP1]=1 ;
  13:  UFRAME_NUM[GP1]=0 ;
  14:  CALL SELECTION_ROUTINE    ;
  15:  UTOOL_NUM[GP1]=1 ;
  16:  UFRAME_NUM[GP1]=0 ;
  17:  PAYLOAD[1:Gripper empty] ;
  18:  IF DO[1:BOX]=ON,JMP LBL[1] ;
  19:  IF DO[2:HEX]=ON,JMP LBL[2] ;
  20:  IF DO[3:EMPTY]=ON,JMP LBL[3] ;
  21:  LBL[1] ;
  22:J P[1] 100% CNT100    ;
  23:  ! MoveTo-Pickup ('BOX') From ('Ta ;
  24:J P[2] 100% FINE    ;
  25:  ! Pickup ('BOX') From ('Table-Wit ;
  26:  !WAIT 0.00 (sec) ;
  27:  ! Pickup ('BOX') From ('Table-Wit ;
  28:  !WAIT 0.00 (sec) ;
  29:  PAYLOAD[2:Gripper loaded] ;
  30:L P[3] 1000mm/sec FINE    ;
  31:J P[4] 100% CNT100    ;
  32:  CALL PROG_OFFSET    ;
  33:  UTOOL_NUM[GP1]=1 ;
  34:  UFRAME_NUM[GP1]=0 ;
  35:  ! Drop ('BOX') From ('GP: 1 - UT: ;
  36:  !WAIT 0.00 (sec) ;
  37:  PAYLOAD[1:Gripper empty] ;
  38:  CALL AUXILIARY_POSITION    ;
  39:  UTOOL_NUM[GP1]=1 ;
  40:  UFRAME_NUM[GP1]=0 ;
  41:  JMP LBL[999] ;
  42:  LBL[2] ;
  43:J P[5] 100% CNT100    ;
  44:  ! MoveTo-Pickup ('HEX') From ('Ta ;
  45:J P[6] 100% FINE    ;
  46:  ! Pickup ('HEX') From ('Table-Wit ;
  47:  !WAIT 0.00 (sec) ;
  48:  ! Pickup ('HEX') From ('Table-Wit ;
  49:  !WAIT 0.00 (sec) ;
  50:  PAYLOAD[2:Gripper loaded] ;
  51:L P[7] 1000mm/sec FINE    ;
  52:J P[8] 100% CNT100    ;
  53:  CALL PROG_OFFSET    ;
  54:  UTOOL_NUM[GP1]=1 ;
  55:  UFRAME_NUM[GP1]=0 ;
  56:  ! Drop ('HEX') From ('GP: 1 - UT: ;
  57:  !WAIT 0.00 (sec) ;
  58:  PAYLOAD[1:Gripper empty] ;
  59:  CALL AUXILIARY_POSITION    ;
  60:  UTOOL_NUM[GP1]=1 ;
  61:  UFRAME_NUM[GP1]=0 ;
  62:  JMP LBL[999] ;
  63:  LBL[3] ;
  64:  CALL PROG_OFFSET    ;
  65:  UTOOL_NUM[GP1]=1 ;
  66:  UFRAME_NUM[GP1]=0 ;
  67:  LBL[999] ;
  68:  ENDFOR ;
  69:  CALL HOME_POSITION    ;
  70:  UTOOL_NUM[GP1]=1 ;
  71:  UFRAME_NUM[GP1]=0 ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =  -200.000  mm,	Z =   500.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[2]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =  -200.000  mm,	Z =   379.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[3]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =  -200.000  mm,	Z =   500.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[4]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -418.600  mm,	Y =   -73.810  mm,	Z =   495.480  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   100.000 deg
};
P[5]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =   200.000  mm,	Z =   500.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[6]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =   200.000  mm,	Z =   385.000  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[7]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X = -1100.000  mm,	Y =   200.000  mm,	Z =   500.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[8]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -418.600  mm,	Y =    73.810  mm,	Z =   495.480  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =    80.000 deg
};
/END
