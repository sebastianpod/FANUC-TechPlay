/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "MainRobotCycle";
PROG_SIZE	= 1369;
CREATE		= DATE 25-06-27  TIME 09:01:34;
MODIFIED	= DATE 25-07-13  TIME 23:19:00;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 38;
MEMORY_SIZE	= 1741;
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

LINE_TRACK;
  LINE_TRACK_SCHEDULE_NUMBER      : 0;
  LINE_TRACK_BOUNDARY_NUMBER      : 0;
  CONTINUE_TRACK_AT_PROG_END      : TRUE;

/MN
   1:  !******************************** ;
   2:  !*                              * ;
   3:  !* Project name: Panopticon     * ;
   4:  !* Author: Sebastian PODSIADLO  * ;
   5:  !* version: 1.00                * ;
   6:  !* last update: 09.07.2025      * ;
   7:  !*                              * ;
   8:  !******************************** ;
   9:   ;
  10:  !************* MAIN ************* ;
  11:   ;
  12:  !Main robot program for vision ;
  13:  !Calls simple vision prog TEST ;
  14:  !TEST only takes a photo on call ;
  15:  !No object detection is used ;
  16:  !Take photo of known-size object ;
  17:  !Use it in calibration.py script ;
  18:  !Script finds scale: pix/mm ;
  19:  !Take photo of object to detect ;
  20:  !Run readout.py with new photo ;
  21:  !It uses calibration data (JSON) ;
  22:  !Corners are found in the image ;
  23:  !They are mapped to user frame ;
  24:  !readout.py saves points to CSV  ;
  25:  !KAREL program reads CSV file   ;
  26:  !Points saved in position reg ;
  27:   ;
  28:  CALL HOME_POSITION    ;
  29:   ;
  30:  !Snap photo ;
  31:  VISION RUN_FIND 'TOP_XY'    ;
  32:   ;
  33:  !Read pos data from csv file ;
  34:  CALL READ_COORDS    ;
  35:   ;
  36:  !Start trajectory execution ;
  37:  CALL EXEC_CONTOUR_PATH    ;
  38:   ;
/POS
/END
