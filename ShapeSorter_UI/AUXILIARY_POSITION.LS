/PROG  AUXILIARY_POSITION
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "ReturnFromDrop";
PROG_SIZE	= 489;
CREATE		= DATE 25-12-02  TIME 22:23:28;
MODIFIED	= DATE 25-12-02  TIME 22:26:22;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 4;
MEMORY_SIZE	= 845;
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
   1:  UFRAME_NUM=1 ;
   2:  UTOOL_NUM=1 ;
   3:   ;
   4:L P[1] 1000mm/sec FINE Offset,PR[1:4x4 grid offset]    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =      .000  mm,	Y =     -.000  mm,	Z =  -200.000  mm,
	W =      .000 deg,	P =      .000 deg,	R =      .000 deg
};
/END
