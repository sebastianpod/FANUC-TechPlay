/PROG  JOB
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 846;
CREATE		= DATE 22-07-22  TIME 11:37:36;
MODIFIED	= DATE 22-07-27  TIME 09:45:08;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 19;
MEMORY_SIZE	= 1282;
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
/APPL

AUTO_SINGULARITY_HEADER;
  ENABLE_SINGULARITY_AVOIDANCE   : FALSE;
/MN
   1:  PR[2:off_drawing]=LPOS-LPOS    ;
   2:  FOR R[50]=1 TO 5 ;
   3:J P[1] 100% CNT100 Offset,PR[2:off_drawing]    ;
   4:  SKIP CONDITION DI[1]=ON    ;
   5:J P[2] 100% FINE Skip,LBL[1] Offset,PR[2:off_drawing]    ;
   6:  CALL PATH_RECORDER    ;
   7:J P[3] 100% FINE Offset,PR[11:new_point]    ;
   8:  CALL PATH_RECORDER    ;
   9:  PR[2,3:off_drawing]=PR[2,3:off_drawing]-50    ;
  10:  ENDFOR ;
  11:   ;
  12:   ;
  13:   ;
  14:   ;
  15:   ;
  16:   ;
  17:  LBL[1] ;
  18:   ;
  19:   ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   541.837646  mm,	Y =  -150.000000  mm,	Z =   921.837646  mm,
	W =   180.000000 deg,	P =   -90.000000 deg,	R =     0.000000 deg
};
P[2]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =  -150.000031  mm,	Y =  -541.837646  mm,	Z =   921.837646  mm,
	W =    89.999992 deg,	P =   -90.000000 deg,	R =     0.000000 deg
};
P[3]{
   GP1:
	UF : 0, UT : 1,	
	J1=     0.000000 deg,	J2=     0.000000 deg,	J3=     0.000000 deg,
	J4=     0.000000 deg,	J5=     0.000000 deg,	J6=      .000002 deg
};
/END
