/PROG  MAIN
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 18773;
CREATE		= DATE 23-07-13  TIME 11:47:04;
MODIFIED	= DATE 23-07-13  TIME 11:47:04;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 499;
MEMORY_SIZE	= 19505;
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
  LINE_TRACK_BOUNDARY_NUMBER      : 1;
  CONTINUE_TRACK_AT_PROG_END      : FALSE;

/MN
   1:  !FANUC America Corp. ;
   2:  !ROBOGUIDE Generated This TPP ;
   3:  !Run SimPRO.cf to setup frame and ;
   4:  UTOOL_NUM[GP1]=1 ;
   5:  UFRAME_NUM[GP1]=1 ;
   6:  CALL HOME_POS    ;
   7:  UTOOL_NUM[GP1]=1 ;
   8:  UFRAME_NUM[GP1]=1 ;
   9:  FOR R[99:For_counter]=1 TO 30 ;
  10:  CALL IO_RESET    ;
  11:  UTOOL_NUM[GP1]=1 ;
  12:  UFRAME_NUM[GP1]=1 ;
  13:  CALL PROG_OFFSET    ;
  14:  UTOOL_NUM[GP1]=1 ;
  15:  UFRAME_NUM[GP1]=1 ;
  16:  CALL IO_CONTROL    ;
  17:  UTOOL_NUM[GP1]=1 ;
  18:  UFRAME_NUM[GP1]=1 ;
  19:  IF DO[1:LETTER A]=ON,JMP LBL[1] ;
  20:  IF DO[1:LETTER A]=OFF,JMP LBL[11] ;
  21:  LBL[1] ;
  22:J P[1] 100% CNT100    ;
  23:  CALL PROG_VIS    ;
  24:  UTOOL_NUM[GP1]=1 ;
  25:  UFRAME_NUM[GP1]=1 ;
  26:  ! MoveTo-Pickup ('Alphabet block  ;
  27:J P[2] 100% FINE VOFFSET,VR[1]    ;
  28:  ! Pickup ('Alphabet block - A') F ;
  29:  !WAIT 0.00 (sec) ;
  30:L P[3] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
  31:J P[4] 100% CNT100    ;
  32:  ! MoveTo-Drop ('Alphabet block -  ;
  33:J P[5] 100% FINE Offset,PR[1]    ;
  34:  ! Drop ('Alphabet block - A') Fro ;
  35:  !WAIT 0.00 (sec) ;
  36:L P[6] 2000mm/sec CNT100 Offset,PR[1]    ;
  37:  JMP LBL[228] ;
  38:  LBL[11] ;
  39:  IF DO[2:LETTER B]=ON,JMP LBL[2] ;
  40:  IF DO[2:LETTER B]=OFF,JMP LBL[22] ;
  41:  LBL[2] ;
  42:J P[7] 100% CNT100    ;
  43:  CALL PROG_VIS    ;
  44:  UTOOL_NUM[GP1]=1 ;
  45:  UFRAME_NUM[GP1]=1 ;
  46:  ! MoveTo-Pickup ('Alphabet block  ;
  47:J P[8] 100% FINE VOFFSET,VR[1]    ;
  48:  ! Pickup ('Alphabet block - B') F ;
  49:  !WAIT 0.00 (sec) ;
  50:L P[9] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
  51:J P[10] 100% CNT100    ;
  52:  ! MoveTo-Drop ('Alphabet block -  ;
  53:J P[11] 100% FINE Offset,PR[1]    ;
  54:  ! Drop ('Alphabet block - B') Fro ;
  55:  !WAIT 0.00 (sec) ;
  56:L P[12] 2000mm/sec CNT100 Offset,PR[1]    ;
  57:  JMP LBL[228] ;
  58:  LBL[22] ;
  59:  IF DO[3:LETTER C]=ON,JMP LBL[3] ;
  60:  IF DO[3:LETTER C]=OFF,JMP LBL[33] ;
  61:  LBL[3] ;
  62:J P[13] 100% CNT100    ;
  63:  CALL PROG_VIS    ;
  64:  UTOOL_NUM[GP1]=1 ;
  65:  UFRAME_NUM[GP1]=1 ;
  66:  ! MoveTo-Pickup ('Alphabet block  ;
  67:J P[14] 100% FINE VOFFSET,VR[1]    ;
  68:  ! Pickup ('Alphabet block - C') F ;
  69:  !WAIT 0.00 (sec) ;
  70:L P[15] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
  71:J P[16] 100% CNT100    ;
  72:  ! MoveTo-Drop ('Alphabet block -  ;
  73:J P[17] 100% FINE Offset,PR[1]    ;
  74:  ! Drop ('Alphabet block - C') Fro ;
  75:  !WAIT 0.00 (sec) ;
  76:L P[18] 2000mm/sec CNT100    ;
  77:  JMP LBL[228] ;
  78:  LBL[33] ;
  79:  IF DO[4:LETTER D]=ON,JMP LBL[4] ;
  80:  IF DO[4:LETTER D]=OFF,JMP LBL[44] ;
  81:  LBL[4] ;
  82:J P[19] 100% CNT100    ;
  83:  CALL PROG_VIS    ;
  84:  UTOOL_NUM[GP1]=1 ;
  85:  UFRAME_NUM[GP1]=1 ;
  86:  ! MoveTo-Pickup ('Alphabet block  ;
  87:J P[20] 100% FINE VOFFSET,VR[1]    ;
  88:  ! Pickup ('Alphabet block - D') F ;
  89:  !WAIT 0.00 (sec) ;
  90:L P[21] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
  91:J P[22] 100% CNT100    ;
  92:  ! MoveTo-Drop ('Alphabet block -  ;
  93:J P[23] 100% FINE Offset,PR[1]    ;
  94:  ! Drop ('Alphabet block - D') Fro ;
  95:  !WAIT 0.00 (sec) ;
  96:L P[24] 2000mm/sec CNT100 Offset,PR[1]    ;
  97:  JMP LBL[228] ;
  98:  LBL[44] ;
  99:  IF DO[5:LETTER E]=ON,JMP LBL[5] ;
 100:  IF DO[5:LETTER E]=OFF,JMP LBL[55] ;
 101:  LBL[5] ;
 102:J P[25] 100% CNT100    ;
 103:  CALL PROG_VIS    ;
 104:  UTOOL_NUM[GP1]=1 ;
 105:  UFRAME_NUM[GP1]=1 ;
 106:  ! MoveTo-Pickup ('Alphabet block  ;
 107:J P[26] 100% FINE VOFFSET,VR[1]    ;
 108:  ! Pickup ('Alphabet block - E') F ;
 109:  !WAIT 0.00 (sec) ;
 110:L P[27] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 111:J P[28] 100% CNT100    ;
 112:  ! MoveTo-Drop ('Alphabet block -  ;
 113:J P[29] 100% FINE Offset,PR[1]    ;
 114:  ! Drop ('Alphabet block - E') Fro ;
 115:  !WAIT 0.00 (sec) ;
 116:L P[30] 2000mm/sec CNT100 Offset,PR[1]    ;
 117:  JMP LBL[228] ;
 118:  LBL[55] ;
 119:  IF DO[6:LETTER F]=ON,JMP LBL[6] ;
 120:  IF DO[6:LETTER F]=OFF,JMP LBL[66] ;
 121:  LBL[6] ;
 122:J P[31] 100% CNT100    ;
 123:  CALL PROG_VIS    ;
 124:  UTOOL_NUM[GP1]=1 ;
 125:  UFRAME_NUM[GP1]=1 ;
 126:  ! MoveTo-Pickup ('Alphabet block  ;
 127:J P[32] 100% FINE VOFFSET,VR[1]    ;
 128:  ! Pickup ('Alphabet block - F') F ;
 129:  !WAIT 0.00 (sec) ;
 130:L P[33] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 131:J P[34] 100% CNT100    ;
 132:  ! MoveTo-Drop ('Alphabet block -  ;
 133:J P[35] 100% FINE Offset,PR[1]    ;
 134:  ! Drop ('Alphabet block - F') Fro ;
 135:  !WAIT 0.00 (sec) ;
 136:L P[36] 2000mm/sec CNT100 Offset,PR[1]    ;
 137:  JMP LBL[228] ;
 138:  LBL[66] ;
 139:  IF DO[7:LETTER G]=ON,JMP LBL[7] ;
 140:  IF DO[7:LETTER G]=OFF,JMP LBL[77] ;
 141:  LBL[7] ;
 142:J P[37] 100% CNT100    ;
 143:  CALL PROG_VIS    ;
 144:  UTOOL_NUM[GP1]=1 ;
 145:  UFRAME_NUM[GP1]=1 ;
 146:  ! MoveTo-Pickup ('Alphabet block  ;
 147:J P[38] 100% FINE VOFFSET,VR[1]    ;
 148:  ! Pickup ('Alphabet block - G') F ;
 149:  !WAIT 0.00 (sec) ;
 150:L P[39] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 151:J P[40] 100% CNT100    ;
 152:  ! MoveTo-Drop ('Alphabet block -  ;
 153:J P[41] 100% FINE Offset,PR[1]    ;
 154:  ! Drop ('Alphabet block - G') Fro ;
 155:  !WAIT 0.00 (sec) ;
 156:L P[42] 2000mm/sec CNT100 Offset,PR[1]    ;
 157:  JMP LBL[228] ;
 158:  LBL[77] ;
 159:  IF DO[8:LETTER H]=ON,JMP LBL[8] ;
 160:  IF DO[8:LETTER H]=OFF,JMP LBL[88] ;
 161:  LBL[8] ;
 162:J P[43] 100% CNT100    ;
 163:  CALL PROG_VIS    ;
 164:  UTOOL_NUM[GP1]=1 ;
 165:  UFRAME_NUM[GP1]=1 ;
 166:  ! MoveTo-Pickup ('Alphabet block  ;
 167:J P[44] 100% FINE VOFFSET,VR[1]    ;
 168:  ! Pickup ('Alphabet block - H') F ;
 169:  !WAIT 0.00 (sec) ;
 170:L P[45] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 171:J P[46] 100% CNT100    ;
 172:  ! MoveTo-Drop ('Alphabet block -  ;
 173:J P[47] 100% FINE Offset,PR[1]    ;
 174:  ! Drop ('Alphabet block - H') Fro ;
 175:  !WAIT 0.00 (sec) ;
 176:L P[48] 2000mm/sec CNT100 Offset,PR[1]    ;
 177:  JMP LBL[228] ;
 178:  LBL[88] ;
 179:  IF DO[9:LETTER I]=ON,JMP LBL[9] ;
 180:  IF DO[9:LETTER I]=OFF,JMP LBL[99] ;
 181:  LBL[9] ;
 182:J P[49] 100% CNT100    ;
 183:  CALL PROG_VIS    ;
 184:  UTOOL_NUM[GP1]=1 ;
 185:  UFRAME_NUM[GP1]=1 ;
 186:  ! MoveTo-Pickup ('Alphabet block  ;
 187:J P[50] 100% FINE VOFFSET,VR[1]    ;
 188:  ! Pickup ('Alphabet block - I') F ;
 189:  !WAIT 0.00 (sec) ;
 190:L P[51] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 191:J P[52] 100% CNT100    ;
 192:  ! MoveTo-Drop ('Alphabet block -  ;
 193:J P[53] 100% FINE Offset,PR[1]    ;
 194:  ! Drop ('Alphabet block - I') Fro ;
 195:  !WAIT 0.00 (sec) ;
 196:L P[54] 2000mm/sec CNT100 Offset,PR[1]    ;
 197:  JMP LBL[228] ;
 198:  LBL[99] ;
 199:  IF DO[10:LETTER J]=ON,JMP LBL[10] ;
 200:  IF DI[10]=OFF,JMP LBL[110] ;
 201:  LBL[10] ;
 202:J P[55] 100% CNT100    ;
 203:  CALL PROG_VIS    ;
 204:  UTOOL_NUM[GP1]=1 ;
 205:  UFRAME_NUM[GP1]=1 ;
 206:  ! MoveTo-Pickup ('Alphabet block  ;
 207:J P[56] 100% FINE VOFFSET,VR[1]    ;
 208:  ! Pickup ('Alphabet block - J') F ;
 209:  !WAIT 0.00 (sec) ;
 210:L P[57] 2000mm/sec CNT100    ;
 211:J P[58] 100% CNT100    ;
 212:  ! MoveTo-Drop ('Alphabet block -  ;
 213:J P[59] 100% FINE Offset,PR[1]    ;
 214:  ! Drop ('Alphabet block - J') Fro ;
 215:  !WAIT 0.00 (sec) ;
 216:L P[60] 2000mm/sec CNT100 Offset,PR[1]    ;
 217:  JMP LBL[228] ;
 218:  LBL[110] ;
 219:  IF DO[11:LETTER K]=ON,JMP LBL[100] ;
 220:  IF DO[11:LETTER K]=OFF,JMP LBL[111] ;
 221:  LBL[100] ;
 222:J P[61] 100% CNT100    ;
 223:  CALL PROG_VIS    ;
 224:  UTOOL_NUM[GP1]=1 ;
 225:  UFRAME_NUM[GP1]=1 ;
 226:  ! MoveTo-Pickup ('Alphabet block  ;
 227:J P[62] 100% FINE VOFFSET,VR[1]    ;
 228:  ! Pickup ('Alphabet block - K') F ;
 229:  !WAIT 0.00 (sec) ;
 230:L P[63] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 231:J P[64] 100% CNT100    ;
 232:  ! MoveTo-Drop ('Alphabet block -  ;
 233:J P[65] 100% FINE Offset,PR[1]    ;
 234:  ! Drop ('Alphabet block - K') Fro ;
 235:  !WAIT 0.00 (sec) ;
 236:L P[66] 2000mm/sec CNT100    ;
 237:  JMP LBL[228] ;
 238:  LBL[111] ;
 239:  IF DO[12:LETTER L]=ON,JMP LBL[12] ;
 240:  IF DO[12:LETTER L]=OFF,JMP LBL[112] ;
 241:  LBL[12] ;
 242:J P[67] 100% CNT100    ;
 243:  CALL PROG_VIS    ;
 244:  UTOOL_NUM[GP1]=1 ;
 245:  UFRAME_NUM[GP1]=1 ;
 246:  ! MoveTo-Pickup ('Alphabet block  ;
 247:J P[68] 100% FINE VOFFSET,VR[1]    ;
 248:  ! Pickup ('Alphabet block - L') F ;
 249:  !WAIT 0.00 (sec) ;
 250:L P[69] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 251:J P[70] 100% CNT100    ;
 252:  ! MoveTo-Drop ('Alphabet block -  ;
 253:J P[71] 100% FINE Offset,PR[1]    ;
 254:  ! Drop ('Alphabet block - L') Fro ;
 255:  !WAIT 0.00 (sec) ;
 256:L P[72] 2000mm/sec CNT100 Offset,PR[1]    ;
 257:  JMP LBL[228] ;
 258:  LBL[112] ;
 259:  IF DO[13:LETTER M]=ON,JMP LBL[13] ;
 260:  IF DO[13:LETTER M]=OFF,JMP LBL[113] ;
 261:  LBL[13] ;
 262:J P[73] 100% CNT100    ;
 263:  CALL PROG_VIS    ;
 264:  UTOOL_NUM[GP1]=1 ;
 265:  UFRAME_NUM[GP1]=1 ;
 266:  ! MoveTo-Pickup ('Alphabet block  ;
 267:J P[74] 100% FINE VOFFSET,VR[1]    ;
 268:  ! Pickup ('Alphabet block - M') F ;
 269:  !WAIT 0.00 (sec) ;
 270:L P[75] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 271:J P[76] 100% CNT100    ;
 272:  ! MoveTo-Drop ('Alphabet block -  ;
 273:J P[77] 100% FINE Offset,PR[1]    ;
 274:  ! Drop ('Alphabet block - M') Fro ;
 275:  !WAIT 0.00 (sec) ;
 276:L P[78] 2000mm/sec CNT100 Offset,PR[1]    ;
 277:  JMP LBL[228] ;
 278:  LBL[113] ;
 279:  IF DO[14:LETTER N]=ON,JMP LBL[14] ;
 280:  IF DO[14:LETTER N]=OFF,JMP LBL[114] ;
 281:  LBL[14] ;
 282:J P[79] 100% CNT100    ;
 283:  CALL PROG_VIS    ;
 284:  UTOOL_NUM[GP1]=1 ;
 285:  UFRAME_NUM[GP1]=1 ;
 286:  ! MoveTo-Pickup ('Alphabet block  ;
 287:J P[80] 100% FINE VOFFSET,VR[1]    ;
 288:  ! Pickup ('Alphabet block - N') F ;
 289:  !WAIT 0.00 (sec) ;
 290:L P[81] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 291:J P[82] 100% CNT100    ;
 292:  ! MoveTo-Drop ('Alphabet block -  ;
 293:J P[83] 100% FINE Offset,PR[1]    ;
 294:  ! Drop ('Alphabet block - N') Fro ;
 295:  !WAIT 0.00 (sec) ;
 296:L P[84] 2000mm/sec CNT100 Offset,PR[1]    ;
 297:  JMP LBL[228] ;
 298:  LBL[114] ;
 299:  IF DO[15:LETTER O]=ON,JMP LBL[15] ;
 300:  IF DO[15:LETTER O]=OFF,JMP LBL[115] ;
 301:  LBL[15] ;
 302:J P[85] 100% CNT100    ;
 303:  CALL PROG_VIS    ;
 304:  UTOOL_NUM[GP1]=1 ;
 305:  UFRAME_NUM[GP1]=1 ;
 306:  ! MoveTo-Pickup ('Alphabet block  ;
 307:J P[86] 100% FINE VOFFSET,VR[1]    ;
 308:  ! Pickup ('Alphabet block - O') F ;
 309:  !WAIT 0.00 (sec) ;
 310:L P[87] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 311:J P[88] 100% CNT100    ;
 312:  ! MoveTo-Drop ('Alphabet block -  ;
 313:L P[89] 2000mm/sec FINE Offset,PR[1]    ;
 314:  ! Drop ('Alphabet block - O') Fro ;
 315:  !WAIT 0.00 (sec) ;
 316:L P[90] 2000mm/sec CNT100 Offset,PR[1]    ;
 317:  JMP LBL[228] ;
 318:  LBL[115] ;
 319:  IF DO[16:LETTER P]=ON,JMP LBL[16] ;
 320:  IF DO[16:LETTER P]=OFF,JMP LBL[116] ;
 321:  LBL[16] ;
 322:J P[91] 100% CNT100    ;
 323:  CALL PROG_VIS    ;
 324:  UTOOL_NUM[GP1]=1 ;
 325:  UFRAME_NUM[GP1]=1 ;
 326:  ! MoveTo-Pickup ('Alphabet block  ;
 327:J P[92] 100% FINE VOFFSET,VR[1]    ;
 328:  ! Pickup ('Alphabet block - P') F ;
 329:  !WAIT 0.00 (sec) ;
 330:L P[93] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 331:J P[94] 100% CNT100    ;
 332:  ! MoveTo-Drop ('Alphabet block -  ;
 333:J P[95] 100% FINE Offset,PR[1]    ;
 334:  ! Drop ('Alphabet block - P') Fro ;
 335:  !WAIT 0.00 (sec) ;
 336:L P[96] 2000mm/sec CNT100 Offset,PR[1]    ;
 337:  JMP LBL[228] ;
 338:  LBL[116] ;
 339:  IF DO[17:LETTER R]=ON,JMP LBL[17] ;
 340:  IF DO[17:LETTER R]=OFF,JMP LBL[117] ;
 341:  LBL[17] ;
 342:J P[97] 100% CNT100    ;
 343:  CALL PROG_VIS    ;
 344:  UTOOL_NUM[GP1]=1 ;
 345:  UFRAME_NUM[GP1]=1 ;
 346:  ! MoveTo-Pickup ('Alphabet block  ;
 347:J P[98] 100% FINE VOFFSET,VR[1]    ;
 348:  ! Pickup ('Alphabet block - R') F ;
 349:  !WAIT 0.00 (sec) ;
 350:L P[99] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 351:J P[100] 100% CNT100    ;
 352:  ! MoveTo-Drop ('Alphabet block -  ;
 353:J P[101] 100% FINE Offset,PR[1]    ;
 354:  ! Drop ('Alphabet block - R') Fro ;
 355:  !WAIT 0.00 (sec) ;
 356:L P[102] 2000mm/sec CNT100 Offset,PR[1]    ;
 357:  JMP LBL[228] ;
 358:  LBL[117] ;
 359:  IF DO[18:LETTER S]=ON,JMP LBL[18] ;
 360:  IF DO[18:LETTER S]=OFF,JMP LBL[118] ;
 361:  LBL[18] ;
 362:J P[103] 100% CNT100    ;
 363:  CALL PROG_VIS    ;
 364:  UTOOL_NUM[GP1]=1 ;
 365:  UFRAME_NUM[GP1]=1 ;
 366:  ! MoveTo-Pickup ('Alphabet block  ;
 367:J P[104] 100% FINE VOFFSET,VR[1]    ;
 368:  ! Pickup ('Alphabet block - S') F ;
 369:  !WAIT 0.00 (sec) ;
 370:L P[105] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 371:J P[106] 100% CNT100    ;
 372:  ! MoveTo-Drop ('Alphabet block -  ;
 373:J P[107] 100% FINE Offset,PR[1]    ;
 374:  ! Drop ('Alphabet block - S') Fro ;
 375:  !WAIT 0.00 (sec) ;
 376:L P[108] 2000mm/sec CNT100 Offset,PR[1]    ;
 377:  JMP LBL[228] ;
 378:  LBL[118] ;
 379:  IF DO[19:LETTER T]=ON,JMP LBL[19] ;
 380:  IF DO[19:LETTER T]=OFF,JMP LBL[119] ;
 381:  LBL[19] ;
 382:J P[109] 100% CNT100    ;
 383:  CALL PROG_VIS    ;
 384:  UTOOL_NUM[GP1]=1 ;
 385:  UFRAME_NUM[GP1]=1 ;
 386:  ! MoveTo-Pickup ('Alphabet block  ;
 387:J P[110] 100% FINE VOFFSET,VR[1]    ;
 388:  ! Pickup ('Alphabet block - T') F ;
 389:  !WAIT 0.00 (sec) ;
 390:L P[111] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 391:J P[112] 100% CNT100    ;
 392:  ! MoveTo-Drop ('Alphabet block -  ;
 393:J P[113] 100% FINE Offset,PR[1]    ;
 394:  ! Drop ('Alphabet block - T') Fro ;
 395:  !WAIT 0.00 (sec) ;
 396:J P[114] 100% CNT100 VOFFSET,VR[1]    ;
 397:  JMP LBL[228] ;
 398:  LBL[119] ;
 399:  IF DO[20:LETTER U]=ON,JMP LBL[20] ;
 400:  IF DO[20:LETTER U]=OFF,JMP LBL[220] ;
 401:  LBL[20] ;
 402:J P[115] 100% CNT100    ;
 403:  ! MoveTo-Pickup ('Alphabet block  ;
 404:J P[116] 100% FINE VOFFSET,VR[1]    ;
 405:  ! Pickup ('Alphabet block - U') F ;
 406:  !WAIT 0.00 (sec) ;
 407:L P[117] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 408:J P[118] 100% CNT100    ;
 409:  ! MoveTo-Drop ('Alphabet block -  ;
 410:J P[119] 100% FINE Offset,PR[1]    ;
 411:  ! Drop ('Alphabet block - U') Fro ;
 412:  !WAIT 0.00 (sec) ;
 413:L P[120] 2000mm/sec CNT100 Offset,PR[1]    ;
 414:  JMP LBL[228] ;
 415:  LBL[220] ;
 416:  IF DO[25:LETTER W]=ON,JMP LBL[25] ;
 417:  IF DO[25:LETTER W]=OFF,JMP LBL[225] ;
 418:  LBL[25] ;
 419:J P[121] 100% CNT100    ;
 420:  CALL PROG_VIS    ;
 421:  UTOOL_NUM[GP1]=1 ;
 422:  UFRAME_NUM[GP1]=1 ;
 423:  ! MoveTo-Pickup ('Alphabet block  ;
 424:J P[122] 100% FINE VOFFSET,VR[1]    ;
 425:  ! Pickup ('Alphabet block - W') F ;
 426:  !WAIT 0.00 (sec) ;
 427:L P[123] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 428:J P[124] 100% CNT100    ;
 429:  ! MoveTo-Drop ('Alphabet block -  ;
 430:J P[125] 100% FINE Offset,PR[1]    ;
 431:  ! Drop ('Alphabet block - W') Fro ;
 432:  !WAIT 0.00 (sec) ;
 433:L P[126] 2000mm/sec CNT100 Offset,PR[1]    ;
 434:  JMP LBL[228] ;
 435:  LBL[225] ;
 436:  IF DO[26:LETTER X]=ON,JMP LBL[26] ;
 437:  IF DO[26:LETTER X]=OFF,JMP LBL[226] ;
 438:  LBL[26] ;
 439:J P[127] 100% CNT100    ;
 440:  CALL PROG_VIS    ;
 441:  UTOOL_NUM[GP1]=1 ;
 442:  UFRAME_NUM[GP1]=1 ;
 443:  ! MoveTo-Pickup ('Alphabet block  ;
 444:J P[128] 100% FINE VOFFSET,VR[1]    ;
 445:  ! Pickup ('Alphabet block - X') F ;
 446:  !WAIT 0.00 (sec) ;
 447:L P[129] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 448:J P[130] 100% CNT100    ;
 449:  ! MoveTo-Drop ('Alphabet block -  ;
 450:J P[131] 100% FINE Offset,PR[1]    ;
 451:  ! Drop ('Alphabet block - X') Fro ;
 452:  !WAIT 0.00 (sec) ;
 453:L P[132] 2000mm/sec CNT100 Offset,PR[1]    ;
 454:  JMP LBL[228] ;
 455:  LBL[226] ;
 456:  IF DO[27:LETTER Y]=ON,JMP LBL[27] ;
 457:  IF DO[27:LETTER Y]=OFF,JMP LBL[227] ;
 458:  LBL[27] ;
 459:J P[133] 100% CNT100    ;
 460:  CALL PROG_VIS    ;
 461:  UTOOL_NUM[GP1]=1 ;
 462:  UFRAME_NUM[GP1]=1 ;
 463:  ! MoveTo-Pickup ('Alphabet block  ;
 464:J P[134] 100% FINE VOFFSET,VR[1]    ;
 465:  ! Pickup ('Alphabet block - Y') F ;
 466:  !WAIT 0.00 (sec) ;
 467:L P[135] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 468:J P[136] 100% CNT100    ;
 469:  ! MoveTo-Drop ('Alphabet block -  ;
 470:J P[137] 100% FINE Offset,PR[1]    ;
 471:  ! Drop ('Alphabet block - Y') Fro ;
 472:  !WAIT 0.00 (sec) ;
 473:L P[138] 2000mm/sec CNT100 Offset,PR[1]    ;
 474:  JMP LBL[228] ;
 475:  LBL[227] ;
 476:  IF DO[28:LETTER Z]=ON,JMP LBL[28] ;
 477:  IF DO[28:LETTER Z]=OFF,JMP LBL[228] ;
 478:  LBL[28] ;
 479:J P[139] 100% CNT100    ;
 480:  CALL PROG_VIS    ;
 481:  UTOOL_NUM[GP1]=1 ;
 482:  UFRAME_NUM[GP1]=1 ;
 483:  ! MoveTo-Pickup ('Alphabet block  ;
 484:J P[140] 100% FINE VOFFSET,VR[1]    ;
 485:  ! Pickup ('Alphabet block - Z') F ;
 486:  !WAIT 0.00 (sec) ;
 487:L P[141] 2000mm/sec CNT100 VOFFSET,VR[1]    ;
 488:J P[142] 100% CNT100    ;
 489:  ! MoveTo-Drop ('Alphabet block -  ;
 490:J P[143] 100% FINE Offset,PR[1]    ;
 491:  ! Drop ('Alphabet block - Z') Fro ;
 492:  !WAIT 0.00 (sec) ;
 493:L P[144] 2000mm/sec CNT100 Offset,PR[1]    ;
 494:  IF DO[29:SPACE]=ON,JMP LBL[228] ;
 495:  LBL[228] ;
 496:  ENDFOR ;
 497:  CALL HOME_POS    ;
 498:  UTOOL_NUM[GP1]=1 ;
 499:  UFRAME_NUM[GP1]=1 ;
/POS
P[1]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[2]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[3]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 1, 0, 0',
	X =     0.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[4]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[5]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[6]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[7]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[8]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[9]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[10]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[11]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[12]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[13]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[14]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[15]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[16]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[17]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[18]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[19]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[20]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[21]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[22]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[23]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[24]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[25]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[26]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[27]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[28]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[29]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[30]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[31]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[32]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[33]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[34]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[35]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[36]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[37]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[38]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[39]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[40]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[41]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[42]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[43]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[44]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =   240.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[45]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =   240.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[46]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[47]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[48]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[49]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =   180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[50]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[51]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[52]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[53]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[54]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[55]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[56]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[57]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[58]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[59]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[60]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[61]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[62]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[63]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[64]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[65]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[66]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[67]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[68]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =   115.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[69]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =   115.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[70]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[71]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1941.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[72]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1941.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[73]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[74]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[75]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[76]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[77]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[78]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[79]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[80]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[81]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[82]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[83]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[84]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[85]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[86]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[87]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[88]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[89]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[90]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[91]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[92]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =   120.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[93]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =   120.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[94]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[95]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[96]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[97]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[98]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[99]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     0.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[100]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[101]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[102]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[103]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[104]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[105]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[106]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[107]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[108]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[109]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[110]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[111]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   240.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[112]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[113]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[114]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[115]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[116]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[117]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   360.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[118]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[119]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[120]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[121]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[122]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[123]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   480.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[124]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[125]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[126]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[127]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[128]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[129]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   600.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[130]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[131]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[132]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  1000.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[133]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[134]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[135]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   720.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[136]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[137]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[138]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[139]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   180.000 deg
};
P[140]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =     0.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[141]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   840.000  mm,	Y =     0.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =    90.000 deg
};
P[142]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    48.970  mm,	Y =  -880.000  mm,	Z =   772.970  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =  -180.000 deg
};
P[143]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =  -128.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
P[144]{
   GP1:
	UF : 1, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   960.000  mm,	Y = -1946.000  mm,	Z =   100.000  mm,
	W =  -180.000 deg,	P =     0.000 deg,	R =   -90.000 deg
};
/END
