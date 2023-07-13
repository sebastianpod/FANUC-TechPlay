/PROG  V_3DA_BP_SUB
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "Bin Pick Advance";
PROG_SIZE	= 1010;
CREATE		= DATE 19-12-23  TIME 21:20:00;
MODIFIED	= DATE 19-12-23  TIME 21:20:00;
FILE_NAME	= V_3DA_BP;
VERSION		= 0;
LINE_COUNT	= 39;
MEMORY_SIZE	= 1526;
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
   7:  JMP LBL[300] ;
   8:   ;
   9:  !ACQUIRE 3D MAP ;
  10:  LBL[100] ;
  11:  WAIT R[8]=1    ;
  12:  CALL BINPICK_ACQUIRE3DMAP("3D Area Sensor"='V_3DA_CAM') ;
  13:   ;
  14:  !SEARCH ;
  15:  LBL[200] ;
  16:  CALL BINPICK_SEARCH("Parts List ID"=1,"SEARCH VP ID"=1,"Status R"=4) ;
  17:  IF R[4]=0,JMP LBL[300] ;
  18:  !SEARCH Fail ;
  19:  R[1]=1    ;
  20:  R[3]=1    ;
  21:  END ;
  22:   ;
  23:  !POP ;
  24:  LBL[300] ;
  25:  CALL BINPICK_POP("Parts List ID"=1,"Status R"=5,"Model ID R"=6) ;
  26:  IF R[5]=0,JMP LBL[400] ;
  27:  !POP Fail ;
  28:  JMP LBL[100] ;
  29:   ;
  30:  !GETPICKPOS ;
  31:  LBL[400] ;
  32:  CALL BINPICK_GETPICKPOS("Parts List ID"=1,"PICK Pos ID"=1,"Status R"=7,"PICK Pos PR"=20,"IA Offset PR"=21,"APP Pos PR"=22) ;
  33:  IF R[7]=0,JMP LBL[410] ;
  34:  !GETPICKPOS Fail ;
  35:  CALL BINPICK_SETSTAT("Parts List ID"=1,"Part Status"=22) ;
  36:  JMP LBL[300] ;
  37:  !GETPICKPOS Success ;
  38:  LBL[410] ;
  39:  R[3]=1    ;
/POS
/END
