/PROG  PLACE_PF5458
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 2430;
CREATE		= DATE 21-02-08  TIME 12:01:26;
MODIFIED	= DATE 21-02-10  TIME 10:30:54;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 75;
MEMORY_SIZE	= 2774;
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
   1:  !Wywolanie UT Gimatic ;
   2:  UTOOL_NUM=1 ;
   3:  !Payload chwytak Gimatic loaded ;
   4:  PAYLOAD[2:Gimatic loaded] ;
   5:  !Zerowanie rejestru pozycji ;
   6:  PR[16:Blister OK XY]=LPOS-LPOS    ;
   7:  PR[17:Blister OK Z]=LPOS-LPOS    ;
   8:  !Przypisanie offsetu w osi Z ;
   9:  PR[17,3:Blister OK Z]=PR[17,3:Blister OK Z]+60    ;
  10:  !Ustawienie offsetu w osi X ;
  11:  PR[16,1:Blister OK XY]=50*R[103:x axis place]    ;
  12:  !Ustawienie offsetu w osi Y ;
  13:  PR[16,2:Blister OK XY]=24*R[104:y axis place]    ;
  14:  !Offset w osi Z podaza za XY ;
  15:  PR[17,1:Blister OK Z]=PR[16,1:Blister OK XY]    ;
  16:  PR[17,2:Blister OK Z]=PR[16,2:Blister OK XY]    ;
  17:  !Oczekiwanie deklaracja blistra ;
  18:  WAIT R[52:Blister OK 1]=2 OR R[53:Blister OK 2]=2    ;
  19:  !Zadeklarowano blister ok 1 ;
  20:  IF (R[52:Blister OK 1]=2) THEN ;
  21:  !Wywolanie UF Blistra OK 1 ;
  22:  UFRAME_NUM=2 ;
  23:  !Wywolanie pozycji posredniej ;
  24:  CALL HOME_POS_BLISTER_1    ;
  25:  !Dojazd nad gniazdo blistra ;
  26:L P[1] 500mm/sec CNT100 Offset,PR[17:Blister OK Z] Wjnt    ;
  27:  !Dojazd do gniazda blistra ;
  28:L P[1] 100mm/sec FINE Offset,PR[16:Blister OK XY] Wjnt    ;
  29:  !Wywolanie otwarcia chwytaka ;
  30:  RO[1]=OFF ;
  31:  !Opoznienie zabezpieczajace ;
  32:  WAIT   1.00(sec) ;
  33:  !Odjazd nad gniazdo palety ;
  34:L P[1] 100mm/sec FINE Offset,PR[17:Blister OK Z] Wjnt    ;
  35:  !Wywolanie pozycji posredniej ;
  36:  CALL HOME_POS_BLISTER_1    ;
  37:  !Inkrementacja po osi X ;
  38:  R[103:x axis place]=R[103:x axis place]+1    ;
  39:  ENDIF ;
  40:  !Zadeklarowano blister ok 2 ;
  41:  IF (R[53:Blister OK 2]=2) THEN ;
  42:  !Wywolanie UF Blistra OK 1 ;
  43:  UFRAME_NUM=3 ;
  44:  !Wywolanie pozycji posredniej ;
  45:  CALL HOME_POS_BLISTER_2    ;
  46:  !Dojazd nad gniazdo blistra ;
  47:L P[2] 500mm/sec CNT100 Offset,PR[17:Blister OK Z] Wjnt    ;
  48:  !Dojazd do gniazda blistra ;
  49:L P[2] 100mm/sec FINE Offset,PR[16:Blister OK XY] Wjnt    ;
  50:  !Wywolanie otwarcia chwytaka ;
  51:  RO[1]=OFF ;
  52:  !Opoznienie zabezpieczajace ;
  53:  WAIT   1.00(sec) ;
  54:  !Odjazd nad gniazdo palety ;
  55:L P[2] 100mm/sec FINE Offset,PR[17:Blister OK Z] Wjnt    ;
  56:  !Wywolanie pozycji posredniej ;
  57:  CALL HOME_POS_BLISTER_2    ;
  58:  !Inkrementacja po osi X ;
  59:  R[103:x axis place]=R[103:x axis place]+1    ;
  60:  ENDIF ;
  61:  !Spr warunku-blister pelny ;
  62:  IF (R[103:x axis place]=5 AND R[104:y axis place]=11) THEN ;
  63:  R[103:x axis place]=0    ;
  64:  R[104:y axis place]=0    ;
  65:  IF (R[52:Blister OK 1]=2) THEN ;
  66:  R[52:Blister OK 1]=3    ;
  67:  ELSE ;
  68:  R[53:Blister OK 2]=3    ;
  69:  ENDIF ;
  70:  ENDIF ;
  71:  !Spr warunku-koniec rzedu ;
  72:  IF (R[103:x axis place]=5) THEN ;
  73:  R[103:x axis place]=0    ;
  74:  R[104:y axis place]=R[104:y axis place]+1    ;
  75:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 2, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     -.000  mm,	Y =      .000  mm,	Z =      .000  mm,
	W =  -180.000 deg,	P =      .000 deg,	R =     -.000 deg
};
P[2]{
   GP1:
	UF : 3, UT : 1,		CONFIG : 'N U T, 0, 0, 1',
	X =      .000  mm,	Y =      .000  mm,	Z =      .000  mm,
	W =   180.000 deg,	P =      .000 deg,	R =      .000 deg
};
/END
