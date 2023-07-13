/PROG  PICK_PF5715
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3796;
CREATE		= DATE 21-02-10  TIME 14:40:18;
MODIFIED	= DATE 21-02-10  TIME 14:40:18;
FILE_NAME	= PICKPLAC;
VERSION		= 0;
LINE_COUNT	= 112;
MEMORY_SIZE	= 4332;
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
  16:  PAYLOAD[3:Zannini unloaded] ;
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
  31:  IF (R[102:y axis pick]>8) THEN ;
  32:  PR[4,1:Corrective]=PR[4,1:Corrective]+3    ;
  33:  ELSE ;
  34:  PR[4,1:Corrective]=PR[4,1:Corrective]+2    ;
  35:  ENDIF ;
  36:  IF (R[102:y axis pick]>13) THEN ;
  37:  PR[4:Corrective]=LPOS-LPOS    ;
  38:  PR[4,1:Corrective]=PR[4,1:Corrective]+4    ;
  39:  ENDIF ;
  40:  !Korekta w osi X nad gniazdem ;
  41:  PR[15]=PR[15]+PR[4:Corrective]    ;
  42:  !Skorygowana poz (nad gniazdem) ;
  43:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  44:  !Korekta w osi X (do gniazda) ;
  45:  PR[14]=LPOS-LPOS    ;
  46:  PR[14,1]=23*R[101:x axis pick]    ;
  47:  PR[14,2]=23*R[102:y axis pick]    ;
  48:  PR[14]=PR[14]+PR[4:Corrective]    ;
  49:  !Kontrola kolizji (druga proba) ;
  50:  SKIP CONDITION $misc[1].$hpd_trq[3]>=7 OR $misc[1].$hpd_trq[3]<=(-7) OR $misc[1].$hpd_trq[5]>=7 OR $misc[1].$hpd_trq[5]<=(-7)    ;
  51:  !Dojazd do gniazda palety ;
  52:L P[1:palet 1] 100mm/sec FINE Offset,PR[14] Skip,LBL[2],PR[14]=LPOS    ;
  53:  !Akcja jesli kolizja ;
  54:  !Odjazd nad gniazdo palety ;
  55:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  56:  !Korekta w osi X (nad gniazdem) ;
  57:  PR[4:Corrective]=PR[4:Corrective]+PR[4:Corrective]    ;
  58:  PR[15]=PR[15]-PR[4:Corrective]    ;
  59:  !Skorygowana pozycja nad gniazdem ;
  60:J P[7:palet 1] 50% FINE Offset,PR[15]    ;
  61:  !Korekta w osi X (do gniazda) ;
  62:  PR[14]=LPOS-LPOS    ;
  63:  PR[14,1]=23*R[101:x axis pick]    ;
  64:  PR[14,2]=23*R[102:y axis pick]    ;
  65:  PR[14]=PR[14]-PR[4:Corrective]    ;
  66:  !Kontrola kolizji (trzecia proba) ;
  67:  SKIP CONDITION $misc[1].$hpd_trq[3]>=7 OR $misc[1].$hpd_trq[3]<=(-7) OR $misc[1].$hpd_trq[5]>=7 OR $misc[1].$hpd_trq[5]<=(-7)    ;
  68:  !Dojazd do gniazda palety ;
  69:L P[1:palet 1] 100mm/sec FINE Offset,PR[14] Skip,LBL[3],PR[14]=LPOS    ;
  70:  !Akcja jesli kolizja ;
  71:  !Odjazd nad gniazdo palety ;
  72:J P[1:palet 1] 50% FINE Offset,PR[15]    ;
  73:  !Instrukcja jesli kolizja ;
  74:  !Pominiecie czesci ;
  75:  !Inkrementacja-kolejna czesc ;
  76:  R[23]=R[23]+1    ;
  77:  !Powrot do poczatku petli pracy ;
  78:  JMP LBL[4] ;
  79:  LBL[1] ;
  80:  LBL[2] ;
  81:  LBL[3] ;
  82:  !Zamkniecie chwytaka ;
  83:  RO[1]=ON ;
  84:  !Opoznienie zabezpieczajace ;
  85:  WAIT   1.00(sec) ;
  86:  !Chwytak zaladowany ;
  87:  PAYLOAD[4:Zannini loaded] ;
  88:  !Dojazd nad gniazdo palety ;
  89:L P[1:palet 1] 250mm/sec CNT100 Offset,PR[15]    ;
  90:  !Predkosc docelowa ;
  91:  OVERRIDE=80% ;
  92:  !Ustawienie globalnego UW ;
  93:  UFRAME_NUM=0 ;
  94:  !Inkrementacja po osi X ;
  95:  R[101:x axis pick]=R[101:x axis pick]+1    ;
  96:  !Inkrementacja ilosci sztuk ;
  97:  R[1:Counter]=R[1:Counter]+1    ;
  98:  !Statusu palety - zakonczona ;
  99:  IF (R[101:x axis pick]=11 AND R[102:y axis pick]=15) THEN ;
 100:  R[51:Palet 1]=3    ;
 101:  !Zerowanie osi pod nowa palete ;
 102:  R[101:x axis pick]=0    ;
 103:  R[102:y axis pick]=0    ;
 104:  !Inkrementacja licznika palet ;
 105:  R[60:Palet counter]=R[60:Palet counter]+1    ;
 106:  ENDIF ;
 107:  !inkrementacja po osi Y ;
 108:  IF (R[101:x axis pick]=11) THEN ;
 109:  R[102:y axis pick]=R[102:y axis pick]+1    ;
 110:  !Zerowanie osi X nowego rzedu ;
 111:  R[101:x axis pick]=0    ;
 112:  ENDIF ;
/POS
P[1:"palet 1"]{
   GP1:
	UF : 1, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.478  mm,	Y =    19.603  mm,	Z =    22.476  mm,
	W =  -179.261 deg,	P =      .361 deg,	R =    89.384 deg
};
P[7:"palet 1"]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    11.439  mm,	Y =    11.848  mm,	Z =    12.109  mm,
	W =   179.902 deg,	P =      .325 deg,	R =   -46.874 deg
};
/END
