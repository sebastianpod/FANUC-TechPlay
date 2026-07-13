/PROG  INITVAR
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "VariablesRestart";
PROG_SIZE	= 772;
CREATE		= DATE 25-12-07  TIME 22:07:24;
MODIFIED	= DATE 26-07-10  TIME 09:04:02;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 32;
MEMORY_SIZE	= 1144;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
LOCAL_REGISTERS	= 0,0,0;
/MN
   1:  !Reset Tic-Tac-Toe to default ;
   2:   ;
   3:  !Clear 3x3 board: set cells to 0 ;
   4:  !0=Empty, 1=O, 2=X ;
   5:  FOR R[20:AUX_LOOP_INDX]=1 TO 9 ;
   6:  R[R[20]]=0    ;
   7:  ENDFOR ;
   8:   ;
   9:  !Current turn=1 by default ;
  10:  !Player 1 uses O ;
  11:  !1=O (circle), 2=X (cross) ;
  12:  R[10:CURRENT_TURN]=1    ;
  13:   ;
  14:  !Win status 0 by default ;
  15:  !0=no win yet, 1=win, 2=draw ;
  16:  R[11:WIN_STATUS]=0    ;
  17:   ;
  18:  !No winner yet ;
  19:  !0=None, 1=O, 2=X ;
  20:  R[12:WINNER_SYMBOL]=0    ;
  21:   ;
  22:  !DOs are used by the Sim Program ;
  23:  DO[2:WIN]=OFF ;
  24:  DO[3:DRAW]=OFF ;
  25:   ;
  26:  !SIM status outputs ;
  27:  DO[4:R1_TURN]=OFF ;
  28:  DO[5:R2_TURN]=OFF ;
  29:   ;
  30:  !Clear selection ;
  31:  R[13:SELECTED_CELL]=0    ;
  32:   ;
/POS
/END
