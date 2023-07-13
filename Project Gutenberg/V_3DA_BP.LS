/PROG  V_3DA_BP
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Bin Pick";
PROG_SIZE	= 1813;
CREATE		= DATE 19-12-23  TIME 21:19:46;
MODIFIED	= DATE 19-12-23  TIME 21:19:46;
FILE_NAME	= V_3DA_BP;
VERSION		= 0;
LINE_COUNT	= 54;
MEMORY_SIZE	= 2277;
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
   4:  !those set by CMT_3DA_BP.TP. ;
   5:   ;
   6:  UFRAME_NUM=1 ;
   7:  UTOOL_NUM=1 ;
   8:  CALL BINPICK_CLEAR("Parts List ID"=1) ;
   9:   ;
  10:  !SEARCH ;
  11:  LBL[1] ;
  12:L P[1:Search] 2000mm/sec FINE    ;
  13:  CALL BINPICK_ACQUIRE3DMAP("3D Area Sensor"='V_3DA_CAM') ;
  14:  CALL BINPICK_SEARCH("Parts List ID"=1,"SEARCH VP ID"=1,"Status R"=10) ;
  15:  IF R[10]<>0,JMP LBL[999] ;
  16:   ;
  17:  !POP ;
  18:  LBL[2] ;
  19:  CALL BINPICK_POP("Parts List ID"=1,"Status R"=11,"Model ID R"=12) ;
  20:  IF R[11]<>0,JMP LBL[1] ;
  21:   ;
  22:  !GETPICKPOS ;
  23:  CALL BINPICK_GETPICKPOS("Parts List ID"=1,"PICK Pos ID"=1,"Status R"=13,"PICK Pos PR"=20,"IA Offset PR"=21,"APP Pos PR"=22) ;
  24:  IF R[13]=0,JMP LBL[3] ;
  25:   ;
  26:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=22) ;
  27:  JMP LBL[2] ;
  28:   ;
  29:  !PICK ;
  30:  LBL[3] ;
  31:L P[2:Pick Approach] 2000mm/sec CNT100    ;
  32:L PR[22] 2000mm/sec CNT50    ;
  33:L PR[20] 500mm/sec FINE    ;
  34:  !Insert program instructions ;
  35:  !to grasp the part. ;
  36:  CALL ...    ;
  37:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=20) ;
  38:L PR[22] 500mm/sec CNT50    ;
  39:L P[2:Pick Approach] 2000mm/sec CNT100    ;
  40:   ;
  41:  !PLACE ;
  42:L P[3:Place Approach] 2000mm/sec CNT100    ;
  43:L P[4:Place] 500mm/sec FINE    ;
  44:  !Insert program instructions ;
  45:  !to place the part. ;
  46:  CALL ...    ;
  47:L P[3:Place Approach] 2000mm/sec CNT100    ;
  48:   ;
  49:  !CONTINUOUS ;
  50:  JMP LBL[2] ;
  51:   ;
  52:  !END ;
  53:  LBL[999] ;
  54:J P[5:Home] 100% FINE    ;
/POS
P[1:"Search"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[2:"Pick Approach"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[3:"Place Approach"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[4:"Place"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
P[5:"Home"]{
   GP1:
	UF : F, UT : F,		CONFIG : 'N D B, 0, 0, 0',
	X =  ********  mm,	Y =  ********  mm,	Z =  ********  mm,
	W =  ******** deg,	P =  ******** deg,	R =  ******** deg
};
/END
