/PROG  PATH_PICK_MARPOSS
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 977;
CREATE		= DATE 20-12-29  TIME 12:54:52;
MODIFIED	= DATE 21-03-23  TIME 15:14:20;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 13;
MEMORY_SIZE	= 1297;
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
   1:  !Wywolanie UF=1 ;
   2:  UFRAME_NUM=1 ;
   3:  !Dojazd do stacji odmuchiwania ;
   4:J P[1] 100% CNT50    ;
   5:J P[2] 100% CNT100    ;
   6:J P[3] 100% CNT100 DO[145:blowing marposs]=ON    ;
   7:  !Pozycje do odmuchiwania ;
   8:J P[4] 10% CNT80    ;
   9:J P[5] 10% CNT80    ;
  10:J P[6] 10% CNT100    ;
  11:  !Odjazd ze stacji odmuchiwania ;
  12:J P[8] 100% FINE DO[145:blowing marposs]=OFF    ;
  13:J P[2] 100% FINE RO[2]=ON    ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   -84.774  mm,	Y =   217.528  mm,	Z =    86.940  mm,
	W =    84.791 deg,	P =   -85.592 deg,	R =    93.068 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -255.995  mm,	Y =   122.645  mm,	Z =    67.920  mm,
	W =     -.485 deg,	P =   -84.998 deg,	R =   140.735 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -361.423  mm,	Y =      .441  mm,	Z =  -148.024  mm,
	W =    94.306 deg,	P =   -84.183 deg,	R =    -6.040 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -369.355  mm,	Y =   -23.432  mm,	Z =  -170.448  mm,
	W =    94.011 deg,	P =   -84.537 deg,	R =    -4.476 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -365.066  mm,	Y =   -29.237  mm,	Z =  -170.448  mm,
	W =   -91.673 deg,	P =   -70.885 deg,	R =  -178.700 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -386.666  mm,	Y =   -25.877  mm,	Z =  -170.448  mm,
	W =    90.126 deg,	P =   -53.236 deg,	R =     -.711 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =  -373.340  mm,	Y =   -11.377  mm,	Z =  -188.904  mm,
	W =    55.503 deg,	P =   -89.025 deg,	R =    36.460 deg
};
/END
