/PROG  V_3DA_BP_MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Bin Pick Advance";
PROG_SIZE	= 3101;
CREATE		= DATE 19-12-23  TIME 21:19:54;
MODIFIED	= DATE 19-12-23  TIME 21:19:54;
FILE_NAME	= V_3DA_BP;
VERSION		= 0;
LINE_COUNT	= 102;
MEMORY_SIZE	= 3645;
PROTECT		= READ;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/APPL
/MN
   1:  !The register numbers and ;
   2:  !position register numbers below ;
   3:  !should be changed according to ;
   4:  !those set by ;
   5:  !CMT_3DA_BP_ADVANCED.TP. ;
   6:   ;
   7:  !Initialize Data ;
   8:  R[1]=0    ;
   9:  R[2]=0    ;
  10:  R[8]=0    ;
  11:  CALL BINPICK_CLEAR("Parts List ID"=1) ;
  12:   ;
  13:  !Move to Home Pos ;
  14:  UFRAME_NUM=1 ;
  15:  UTOOL_NUM=1 ;
  16:J P[1:Home] 100% FINE    ;
  17:   ;
  18:  !Move to Search Pos ;
  19:  LBL[100] ;
  20:  UFRAME_NUM=1 ;
  21:  UTOOL_NUM=1 ;
  22:J P[11:Search] 100% FINE    ;
  23:  R[8]=1    ;
  24:   ;
  25:  !ACQUIRE 3D MAP ;
  26:  LBL[200] ;
  27:  CALL BINPICK_ACQUIRE3DMAP("3D Area Sensor"='V_3DA_CAM') ;
  28:   ;
  29:  !SEARCH ;
  30:  LBL[300] ;
  31:  CALL BINPICK_SEARCH("Parts List ID"=1,"SEARCH VP ID"=1,"Status R"=4) ;
  32:  IF R[4]=0,JMP LBL[400] ;
  33:  !SEARCH Fail ;
  34:  R[1]=1    ;
  35:  JMP LBL[999] ;
  36:   ;
  37:  !POP ;
  38:  LBL[400] ;
  39:  CALL BINPICK_POP("Parts List ID"=1,"Status R"=5,"Model ID R"=6) ;
  40:  IF R[5]=0,JMP LBL[500] ;
  41:  !POP Fail ;
  42:  JMP LBL[100] ;
  43:   ;
  44:  !GETPICKPOS ;
  45:  LBL[500] ;
  46:  CALL BINPICK_GETPICKPOS("Parts List ID"=1,"PICK Pos ID"=1,"Status R"=7,"PICK Pos PR"=20,"IA Offset PR"=21,"APP Pos PR"=22) ;
  47:  IF R[7]=0,JMP LBL[600] ;
  48:  !GETPICKPOS Fail ;
  49:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=22) ;
  50:  JMP LBL[400] ;
  51:   ;
  52:  !PICK ;
  53:  LBL[600] ;
  54:  UFRAME_NUM=1 ;
  55:  UTOOL_NUM=1 ;
  56:  R[8]=0    ;
  57:   ;
  58:L P[61:Pick Approach] 500mm/sec CNT50    ;
  59:  !Move to Pick Pos ;
  60:L PR[22] 500mm/sec CNT50    ;
  61:L PR[20] 200mm/sec FINE    ;
  62:  !Insert program instructions ;
  63:  !to grasp the part. ;
  64:  CALL ...    ;
  65:L PR[22] 500mm/sec CNT50    ;
  66:L P[62:Pick Retract] 300mm/sec FINE INC    ;
  67:  !Insert program instructions ;
  68:  !whether grasp succeeds or not. ;
  69:  CALL ...    ;
  70:   ;
  71:  IF R[2]=1,JMP LBL[610] ;
  72:  !PICK Fail ;
  73:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=21) ;
  74:  JMP LBL[400] ;
  75:  !PICK Success ;
  76:  LBL[610] ;
  77:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=20) ;
  78:L P[63] 500mm/sec CNT100    ;
  79:   ;
  80:  !Start Background Calc. and PLACE ;
  81:  LBL[700] ;
  82:  R[3]=0    ;
  83:  RUN V_3DA_BP_SUB ;
  84:J P[71:Place Approach] 100% CNT100 TA    .50sec,CALL V_3DA_FOV    ;
  85:L P[72:Place Approach] 300mm/sec CNT100    ;
  86:L P[73:Place] 300mm/sec FINE    ;
  87:  !Insert program instructions ;
  88:  !to release the part. ;
  89:  CALL ...    ;
  90:   ;
  91:L P[72:Place Approach] 300mm/sec CNT100    ;
  92:L P[71:Place Approach] 300mm/sec CNT100    ;
  93:  WAIT R[3]=1    ;
  94:  !End Background Calc. ;
  95:   ;
  96:  IF R[1]=1,JMP LBL[999] ;
  97:  JMP LBL[600] ;
  98:   ;
  99:  LBL[999] ;
 100:  UFRAME_NUM=1 ;
 101:  UTOOL_NUM=1 ;
 102:J P[1:Home] 100% FINE    ;
/POS
P[1:"Home"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[11:"Search"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[61:"Pick Approach"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[62:"Pick Retract"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[63]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X = ********  mm,	Y = ********  mm,	Z = ********  mm,
	W = ******** deg,	P = ******** deg,	R = ******** deg
};
P[71:"Place Approach"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[72:"Place Approach"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[73:"Place"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
/END
