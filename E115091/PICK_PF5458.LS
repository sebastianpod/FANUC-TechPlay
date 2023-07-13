/PROG  PICK_PF5458
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3595;
CREATE		= DATE 21-02-08  TIME 08:39:32;
MODIFIED	= DATE 22-03-16  TIME 10:45:36;
FILE_NAME	= PLACE_SC;
VERSION		= 0;
LINE_COUNT	= 104;
MEMORY_SIZE	= 4163;
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
/APPL
/MN
   1:  !Poczatek petli pracy ;
   2:  LBL[4] ;
   3:  !Zerowanie rej poz osi XY palety ;
   4:  PR[14]=LPOS-LPOS    ;
   5:  PR[15]=LPOS-LPOS    ;
   6:  PR[4:Corrective]=LPOS-LPOS    ;
   7:  !Odl miedzy pinami w osi X ;
   8:  PR[14,1]=23*R[101:x axis pick]    ;
   9:  !Odl miedzy pinami w osi Y ;
  10:  PR[14,2]=23*R[102:y axis pick]    ;
  11:  !Offset w osi Z podaza za XY ;
  12:  PR[15]=PR[14]    ;
  13:  !Offset w osi Z nad czesciami ;
  14:  PR[15,3]=60+PR[15,3]    ;
  15:  !Chwytak pusty ;
  16:  PAYLOAD[1:Gimatic unloaded] ;
  17:  !Ladowanie ukladu wsp palety 1 ;
  18:  UFRAME_NUM=1 ;
  19:  !Dojazd nad gniazdo palety ;
  20:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  21:  !Kontrola kolizji ;
  22:  SKIP CONDITION $misc[1].$hpd_trq[3]>=7 OR $misc[1].$hpd_trq[3]<=(-7) OR $misc[1].$hpd_trq[5]>=7 OR $misc[1].$hpd_trq[5]<=(-7)    ;
  23:  !Ustawienie predkosci ;
  24:  OVERRIDE=40% ;
  25:  !Dojazd do gniazda palety ;
  26:L P[1:palet 1] 100mm/sec FINE Offset,PR[14] Skip,LBL[1],PR[14]=LPOS    ;
  27:  !Akcja jesli kolizja ;
  28:  !Odjazd nad gniazdo palety ;
  29:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  30:  !Ustawienie offsetu korygujacego ;
  31:  PR[4,1:Corrective]=PR[4,1:Corrective]+2    ;
  32:  !Korekta w osi X nad gniazdem ;
  33:  PR[15]=PR[15]+PR[4:Corrective]    ;
  34:  !Skorygowana poz (nad gniazdem) ;
  35:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  36:  !Korekta w osi X (do gniazda) ;
  37:  PR[14]=LPOS-LPOS    ;
  38:  PR[14,1]=23*R[101:x axis pick]    ;
  39:  PR[14,2]=23*R[102:y axis pick]    ;
  40:  PR[14]=PR[14]+PR[4:Corrective]    ;
  41:  !Kontrola kolizji (druga proba) ;
  42:  SKIP CONDITION $misc[1].$hpd_trq[3]>=7 OR $misc[1].$hpd_trq[3]<=(-7) OR $misc[1].$hpd_trq[5]>=7 OR $misc[1].$hpd_trq[5]<=(-7)    ;
  43:  !Dojazd do gniazda palety ;
  44:L P[1:palet 1] 100mm/sec FINE Offset,PR[14] Skip,LBL[2],PR[14]=LPOS    ;
  45:  !Akcja jesli kolizja ;
  46:  !Odjazd nad gniazdo palety ;
  47:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  48:  !Korekta w osi X (nad gniazdem) ;
  49:  PR[4:Corrective]=PR[4:Corrective]+PR[4:Corrective]    ;
  50:  PR[15]=PR[15]-PR[4:Corrective]    ;
  51:  !Skorygowana pozycja nad gniazdem ;
  52:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  53:  !Korekta w osi X (do gniazda) ;
  54:  PR[14]=LPOS-LPOS    ;
  55:  PR[14,1]=23*R[101:x axis pick]    ;
  56:  PR[14,2]=23*R[102:y axis pick]    ;
  57:  PR[14]=PR[14]-PR[4:Corrective]    ;
  58:  !Kontrola kolizji (trzecia proba) ;
  59:  SKIP CONDITION $misc[1].$hpd_trq[3]>=7 OR $misc[1].$hpd_trq[3]<=(-7) OR $misc[1].$hpd_trq[5]>=7 OR $misc[1].$hpd_trq[5]<=(-7)    ;
  60:  !Dojazd do gniazda palety ;
  61:L P[1:palet 1] 100mm/sec FINE Offset,PR[14] Skip,LBL[3],PR[14]=LPOS    ;
  62:  !Akcja jesli kolizja ;
  63:  !Odjazd nad gniazdo palety ;
  64:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  65:  !Instrukcja jesli kolizja ;
  66:  !Pominiecie czesci ;
  67:  !Inkrementacja-kolejna czesc ;
  68:  R[23]=R[23]+1    ;
  69:  !Powrot do poczatku petli pracy ;
  70:  JMP LBL[4] ;
  71:  LBL[1] ;
  72:  LBL[2] ;
  73:  LBL[3] ;
  74:  !Zamkniecie chwytaka ;
  75:  RO[1]=ON ;
  76:  !Opoznienie zabezpieczajace ;
  77:  WAIT   1.00(sec) ;
  78:  !Chwytak zaladowany ;
  79:  PAYLOAD[2:Gimatic loaded] ;
  80:  !Dojazd nad gniazdo palety ;
  81:L P[1:palet 1] 250mm/sec CNT100 Offset,PR[15]    ;
  82:  !Predkosc docelowa ;
  83:  OVERRIDE=80% ;
  84:  !Ustawienie globalnego UW ;
  85:  UFRAME_NUM=0 ;
  86:  !Inkrementacja po osi X ;
  87:  R[101:x axis pick]=R[101:x axis pick]+1    ;
  88:  !Inkrementacja ilosci sztuk ;
  89:  R[1:Counter]=R[1:Counter]+1    ;
  90:  !Statusu palety - zakonczona ;
  91:  IF (R[101:x axis pick]=11 AND R[102:y axis pick]=15) THEN ;
  92:  R[51:Palet 1]=3    ;
  93:  !Zerowanie osi pod nowa palete ;
  94:  R[101:x axis pick]=0    ;
  95:  R[102:y axis pick]=0    ;
  96:  !Inkrementacja licznika palet ;
  97:  R[60:Palet counter]=R[60:Palet counter]+1    ;
  98:  ENDIF ;
  99:  !inkrementacja po osi Y ;
 100:  IF (R[101:x axis pick]=11) THEN ;
 101:  R[102:y axis pick]=R[102:y axis pick]+1    ;
 102:  !Zerowanie osi X nowego rzedu ;
 103:  R[101:x axis pick]=0    ;
 104:  ENDIF ;
/POS
P[1:"palet 1"]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.595  mm,	Y =    19.658  mm,	Z =    31.475  mm,
	W =   179.261 deg,	P =     -.361 deg,	R =   -90.616 deg
};
/END
