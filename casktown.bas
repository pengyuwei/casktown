DECLARE SUB loadmap (mm AS INTEGER)
DECLARE SUB clr ()
DECLARE SUB whitesay (say$)
DECLARE SUB LoadGame (x!, y!, mx!, my!, autotime!, runstep!)
DECLARE SUB SaveGame (x!, y!, mx!, my!, autotime!, runstep!)
DECLARE SUB autorun ()
DECLARE SUB findsth ()
DECLARE SUB map16 ()
DECLARE SUB map15 ()
DECLARE SUB map14 ()
DECLARE SUB map13 ()
DECLARE SUB map12 ()
DECLARE SUB map11 ()
DECLARE SUB cg1 ()
DECLARE SUB map10 ()
DECLARE SUB map8 ()
DECLARE SUB map9 ()
DECLARE SUB map6 ()
DECLARE SUB room9 ()
DECLARE SUB debug ()
DECLARE SUB pal ()
DECLARE SUB room2 ()
DECLARE SUB readmap (a)
DECLARE SUB readhouse ()
DECLARE SUB map5 ()
DECLARE SUB room1 ()
DECLARE SUB map4 ()
DECLARE SUB map3 ()
DECLARE SUB endgame ()
DECLARE SUB clcon ()
DECLARE SUB map2 ()
DECLARE SUB clk ()
DECLARE SUB rpgsay ()
DECLARE FUNCTION object! ()
DECLARE SUB map1 ()
DECLARE SUB initstore ()
DECLARE SUB drawmap ()

DIM SHARED action(99) AS INTEGER
DIM SHARED act(99) AS INTEGER
DIM SHARED man1(246)
DIM SHARED autoMan1(246)
DIM SHARED man2(246)
DIM SHARED autoMan2(246)
DIM SHARED man3(246)
DIM SHARED autoMan3(246)
DIM SHARED man4(246)
DIM SHARED autoMan4(246)
DIM SHARED people1(246)
DIM SHARED people2(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED people3(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED people4(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED people5(4 + INT((40 * 1 + 7) / 8) * 40 * 4)   '睡仙
DIM SHARED people6(4 + INT((40 * 1 + 7) / 8) * 40 * 4)   'teacher
DIM SHARED people9(4 + INT((40 * 1 + 7) / 8) * 40 * 4)   'pal-main
DIM SHARED space(4 + INT((40 * 1 + 7) / 8) * 40 * 4)

DIM SHARED tree(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED door(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED yun(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house(4 + INT((79 * 1 + 7) / 8) * 79 * 4)
DIM SHARED house1(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house2(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house3(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house4(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house5(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED house9(4 + INT((40 * 1 + 7) / 8) * 40 * 4)

DIM SHARED disk(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED wall(4 + INT((40 * 1 + 7) / 8) * 40 * 4)
DIM SHARED myst(4 + INT((40 * 1 + 7) / 8) * 40 * 4)

DIM SHARED m(10) AS STRING
DIM SHARED o(10) AS STRING
DIM SHARED s(99) AS STRING
DIM SHARED l(99) AS INTEGER, start(99) AS INTEGER

DIM SHARED up$
DIM SHARED down$
DIM SHARED lef$
DIM SHARED righ$
DIM SHARED in AS STRING           'inkey$
DIM SHARED into AS INTEGER        'true--in the house  else out of house
DIM SHARED whichhouse
DIM SHARED loadxy AS INTEGER
DIM SHARED manname AS STRING
DIM SHARED display AS INTEGER 'display the map name
DIM SHARED nextmap AS INTEGER
DIM SHARED x, y, mx, my
DIM SHARED say AS INTEGER
DIM SHARED toward AS STRING
DIM SHARED who AS INTEGER
DIM SHARED map AS INTEGER
DIM SHARED mapname AS STRING
DIM SHARED retn AS INTEGER, retn1 AS INTEGER
DIM SHARED maythough(9) AS STRING
DIM SHARED find AS INTEGER
DIM SHARED Search AS STRING
DIM SHARED active AS INTEGER
DIM SHARED autotime
maythough(1) = "0"
maythough(2) = "F"
maythough(3) = "e"
maythough(4) = "i"
maythough(5) = "o"
maythough(6) = "E"
maythough(7) = "G"
maythough(8) = "g"
maythough(9) = "R"
CONST total = 9
CONST false = 0
CONST true = -1
loadxy = true
retn = 0
up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
lef$ = CHR$(0) + CHR$(75): righ$ = CHR$(0) + CHR$(77)
shot$ = CHR$(0) + CHR$(42)      'right shift
man$ = CHR$(1)
everystep = 10
map = 1
initstore
CLS
'map1
loadmap (1)
drawmap
mx = 2: my = 3
x = mx * 40 - 40: y = my * 40 - 40          'is important
who = 1
PUT (x + 1, y + 1), man4
wartime = TIMER
into = true
'map = 3'''
runstep = false            'run step by step
autotime = TIMER
DO
in = INKEY$
IF in <> "" THEN autotime = TIMER
IF TIMER - autotime > 2 THEN CALL autorun: autotime = TIMER
IF in = "S" AND into = true THEN SaveGame x, y, mx, my, autotime, runstep
IF in = "L" THEN GOSUB LoadGame
IF in = CHR$(0) + CHR$(45) OR in = CHR$(0) + CHR$(68) THEN END
IF in = up$ THEN
   'IF toward = "up" THEN
   'PUT (x + 1, y + 1), man1, PSET
   toward = "up"
   IF NOT object AND my > 1 THEN
      IF runstep THEN
         FOR tmp = y TO y - 40 STEP -1
             PUT (x + 1, tmp + 1), man1, PSET: PUT (x + 1, tmp + 1), man1, XOR
             IF tmp > y - 40 THEN PUT (x + 1, tmp), man1, PSET
         NEXT
      ELSE
         PUT (x + 1, y + 1), man1, PSET: PUT (x + 1, y + 1), man1, XOR
      END IF
      clk
      my = my - 1
      x = mx * 40 - 40: y = my * 40 - 40
      PUT (x + 1, y + 1), man1
   END IF
   say = 0
   'ELSE
   toward = "up"
   PUT (x + 1, y + 1), man1, PSET
   'END IF
END IF
IF in = down$ THEN
   'IF toward = "down" THEN
   'PUT (x + 1, y + 1), man2, PSET
   toward = "down"
   IF NOT object AND my < 8 THEN
      IF runstep THEN
         FOR tmp = y TO y + 40
             PUT (x + 1, tmp + 1), man2, PSET: PUT (x + 1, tmp + 1), man2, XOR
             IF tmp < y + 40 THEN PUT (x + 1, tmp + 2), man2, PSET
         NEXT
      ELSE
      PUT (x + 1, y + 1), man2, PSET: PUT (x + 1, y + 1), man2
      END IF
      clk
      my = my + 1
      x = mx * 40 - 40: y = my * 40 - 40
      PUT (x + 1, y + 1), man2
   END IF
   say = 0
   'ELSE
   toward = "down"
   PUT (x + 1, y + 1), man2, PSET
   'END IF
END IF
IF in = lef$ THEN
   'IF toward = "left" THEN
   'PUT (x + 1, y + 1), Man3, PSET
   toward = "left"
   IF NOT object AND mx > 1 THEN
      IF runstep THEN
         FOR tmp = x TO x - 40 STEP -1
             PUT (tmp + 1, y + 1), man3, PSET: PUT (tmp + 1, y + 1), man3, XOR
             IF tmp > x - 40 THEN PUT (tmp, y + 1), man3, PSET
         NEXT
      ELSE
      PUT (x + 1, y + 1), man3, PSET: PUT (x + 1, y + 1), man3
      END IF
      clk
      mx = mx - 1
      x = mx * 40 - 40: y = my * 40 - 40
      PUT (x + 1, y + 1), man3
   END IF
   say = 0
   'ELSE
   toward = "left"
   PUT (x + 1, y + 1), man3, PSET
   'END IF
END IF
IF in = righ$ THEN
   'IF toward = "right" THEN
   'PUT (x + 1, y + 1), man4, PSET
   toward = "right"
   IF NOT object AND mx < 15 THEN
      IF runstep THEN
         FOR tmp = x TO x + 40 STEP 1
             PUT (tmp + 1, y + 1), man4, PSET: PUT (tmp + 1, y + 1), man4, XOR
             IF tmp < x + 40 THEN PUT (tmp + 2, y + 1), man4, PSET
         NEXT
      ELSE
         PUT (x + 1, y + 1), man4, PSET: PUT (x + 1, y + 1), man4
      END IF
      clk
      mx = mx + 1
      x = mx * 40 - 40: y = my * 40 - 40
      PUT (x + 1, y + 1), man4
   END IF
   say = 0
   'ELSE
   toward = "right"
   PUT (x + 1, y + 1), man4, PSET
   'END IF
END IF


IF in = " " OR in = "z" OR in = CHR$(13) THEN
   temp = object
   IF NOT say THEN IF find THEN findsth
   IF say THEN rpgsay
END IF
IF LCASE$(MID$(m(my), mx, 1)) = "i" THEN
   clcon
   loadxy = false
   IF into THEN
      mx0 = mx: my0 = my + 1
      readhouse
      drawmap
      into = NOT into
    ELSE
       readmap (map)
       mx = mx0: my = my0
       drawmap
       into = true
   END IF
END IF

IF LCASE$(MID$(m(my), mx, 1)) = "e" THEN
   CALL clcon
   IF MID$(m(my), mx, 1) = "e" THEN map = map + 1: retn = false ELSE map = map - 1: retn = true
   readmap (map)
   drawmap
END IF
IF LCASE$(MID$(m(my), mx, 1)) = "g" THEN
   CALL clcon
   IF MID$(m(my), mx, 1) = "g" THEN
      readmap (nextmap)
      retn1 = false
      ELSE
      nextmap = nextmap - 1
      retn1 = true
      readmap (nextmap)
   END IF
   drawmap
END IF
IF LCASE$(MID$(m(my), mx, 1)) = "r" THEN
   retn1 = true
   CALL clcon
   readmap (map)
   drawmap
   retn1 = false
END IF

IF MID$(m(my), mx, 1) = "F" THEN endgame
pal
'debug
'action(1) = -1
'action(2) = -1
LOOP

LoadGame:
LOCATE 22, 30: PRINT "正在读取...                "
OPEN "T1.rpg" FOR INPUT AS #1
     INPUT #1, x, y, mx, my, autotime, runstep, into, who, map, whichhouse
     INPUT #1, nextmap
     INPUT #1, toward
     INPUT #1, manname
     FOR i = 1 TO 99
          INPUT #1, action(i), act(i)
     NEXT
CLOSE
display = false
tempx = x: tempy = y
tempmx = mx: tempmy = my
'IF nextmap <> 0 THEN readmap (nextmap) ELSE readmap (map)
readmap (map)
x = tempx: y = tempy
mx = tempmx: my = tempmy
drawmap
LOCATE 22, 30: PRINT "读取完毕.         "
a$ = INPUT$(1)
LOCATE 22, 30: PRINT "                        "

RETURN

SUB autorun
SELECT CASE toward
CASE "up"
CASE "down"
     FOR i = 1 TO 2
         PUT (x + 1, y + 1), autoMan2, PSET
         t = TIMER
         WHILE TIMER - t < .04: WEND
         PUT (x + 1, y + 1), man2, PSET
         t = TIMER
         WHILE TIMER - t < .3: WEND
     NEXT
     PUT (x + 1, y + 1), autoMan1, PSET
     't = TIMER
     'WHILE TIMER - t < 1: WEND
CASE "left"
     FOR i = 1 TO 2
         PUT (x + 1, y + 1), autoMan3, PSET
         t = TIMER
         WHILE TIMER - t < .04: WEND
         PUT (x + 1, y + 1), man3, PSET
         t = TIMER
         WHILE TIMER - t < .3: WEND
     NEXT
CASE "right"
     FOR i = 1 TO 2
         PUT (x + 1, y + 1), autoMan4, PSET
         t = TIMER
         WHILE TIMER - t < .04: WEND
         PUT (x + 1, y + 1), man4, PSET
         t = TIMER
         WHILE TIMER - t < .3: WEND
     NEXT
CASE ELSE
END SELECT
END SUB

SUB cg1
CLS
PALETTE 0, 0
PALETTE 15, 0
VIEW SCREEN (1, 1)-(599, 319)
FOR i = 1 TO 500 STEP 10
    CIRCLE (300, 150), i, 15
NEXT
PUT (x, y), man4
FOR i = 0 TO 45
     PALETTE 15, i + 256 * i + 65535 * i
     t = TIMER
     WHILE TIMER - t < .01: WEND
NEXT
clk
t = TIMER
DO WHILE TIMER - t < 5
FOR i = 1 TO 500 STEP 10
    CIRCLE (300, 150), i, INT(RND * 15)
NEXT
IF INKEY$ <> "" THEN EXIT DO
LOOP

i0 = 1
i = 1
t = TIMER
DO
   IF TIMER - t > .01 THEN i0 = i0 + 10: t = TIMER
   FOR i = 1 TO i0
      CIRCLE (300, 150), i, 0
   NEXT
   PUT (x, y), man4, PSET
   FOR i = i0 TO 360 STEP 20
      CIRCLE (300, 150), i, INT(RND * 15)
   NEXT
   PUT (x, y), man4, PSET
LOOP UNTIL i0 > 360
VIEW
CLS
whitesay manname + "穿过一条神奇的隧道，到达了幻界...."
PALETTE 15, 0
COLOR 15
LOCATE 12, 30
PRINT "不久以后..."
FOR i = 0 TO 45
     PALETTE 15, i + 256 * i + 65535 * i
     t = TIMER
     WHILE TIMER - t < .01: WEND
NEXT
FOR i = 45 TO 0 STEP -1
     PALETTE 15, i + 256 * i + 65535 * i
     t = TIMER
     WHILE TIMER - t < .01: WEND
NEXT

CLS
'LINE (1, 1)-(599, 319), 0, BF
'LINE (639, 479)-(0, 319), 15, BF
FOR i = 0 TO 30
    PALETTE 0, 65536 * i + 256 * i + i
    t = TIMER
    WHILE TIMER - t < .03: WEND
NEXT
map = 10
display = false
mx = 9: my = 6
drawmap
x = mx * 40 - 40: y = my * 40 - 40
clk
PUT (x + 1, y + 1), man1, PSET
t = TIMER
WHILE TIMER - t < 1: WEND
PUT (x + 1, y + 1), man2, PSET
t = TIMER
WHILE TIMER - t < .8: WEND

FOR i = 1 TO 2
PUT (x + 1, y + 1), man4, PSET
t = TIMER
WHILE TIMER - t < .8: WEND

PUT (x + 1, y + 1), man3, PSET
t = TIMER
WHILE TIMER - t < .5: WEND
NEXT
clk
who = 1
rpgsay
display = false
clk
END SUB

SUB clcon
'FOR clx = 0 TO 639
'    LINE (clx, 0)-(clx, 479), 0
'    FOR tmp = 0 TO 400: NEXT
'NEXT
'CLS
END SUB

SUB clk
WHILE INKEY$ <> "": WEND
END SUB

SUB clr
FOR i = POS(0) TO 80
    PRINT " ";
NEXT
END SUB

SUB debug
'LOCATE 21, 1: PRINT "who="; who; "  l(who)="; l(who)
'LOCATE 22, 1: PRINT "sayline="; sayline; "  start(who)="; start(who)
LOCATE 22, 1: PRINT "mx="; mx; " my="; my
LOCATE 20, 1: PRINT "map="; map
LOCATE 21, 1: PRINT "Nextmap="; nextmap
'LOCATE 20, 1: PRINT retn
END SUB

SUB drawmap '--------------dim man(4 + INT((x*1 + 7) / 8) * y * 4) when screen 12
FOR cx = 0 TO 600 STEP 40
'    LINE (cx, 0)-(cx, 320), 3
NEXT
FOR cy = 0 TO 320 STEP 40
'    LINE (0, cy)-(600, cy), 3
NEXT
COLOR 3
LINE (0, 0)-(600, 320), 1, B
FOR i = 1 TO 15
    FOR dy = 8 TO 1 STEP -1
        m$ = MID$(m(dy), i, 1)
        dmx = i * 40 - 40: dmy = dy * 40 - 40
        SELECT CASE LCASE$(m$)
        CASE "t"
        PUT (dmx + 1, dmy + 1), tree, PSET
        CASE "1"
        PUT (dmx + 1, dmy + 1), people1, PSET
        CASE "2"
        PUT (dmx + 1, dmy + 1), people2, PSET
        CASE "3"
        PUT (dmx + 1, dmy + 1), people3, PSET
        CASE "4"
        PUT (dmx + 1, dmy + 1), people4, PSET
        CASE "5"
        PUT (dmx + 1, dmy + 1), people5, PSET
        CASE "6"
        PUT (dmx + 1, dmy + 1), people6, PSET
        CASE "9"
        PUT (dmx + 1, dmy + 1), people9, PSET
        CASE "b"
        PUT (dmx + 1, dmy + 1), myst, PSET
        CASE "d"
        PUT (dmx + 1, dmy + 1), disk, PSET
        CASE "w"
        PUT (dmx + 1, dmy + 1), wall, PSET
        CASE "y"
        PUT (dmx + 1, dmy + 1), yun, PSET
       
        CASE "h"
        PUT (dmx + 1, dmy + 1), house, PSET
        CASE "!"
        PUT (dmx + 1, dmy + 1), house1, PSET
        CASE "@"
        PUT (dmx + 1, dmy + 1), house2, PSET
        CASE "#"
        PUT (dmx + 1, dmy + 1), house3, PSET
        CASE "$"
        PUT (dmx + 1, dmy + 1), house4, PSET
        CASE "%"
        PUT (dmx + 1, dmy + 1), house5, PSET
        CASE "0", "i", "z", "e", "g", "r", "f"
        PUT (dmx, dmy), space, PSET
       
        CASE ELSE
        END SELECT
    LINE (0, 0)-(600, 320), 1, B
    NEXT
'FOR temp = 0 TO 49999: NEXT
NEXT
x = mx * 40 - 40: y = my * 40 - 40
SELECT CASE toward
CASE "up"
   PUT (x + 1, y + 1), man1, PSET': PUT (x + 1, y + 1), man1, XOR
CASE "down"
   PUT (x + 1, y + 1), man2, PSET': PUT (x + 1, y + 1), man2
CASE "left"
   PUT (x + 1, y + 1), man3, PSET': PUT (x + 1, y + 1), man3
CASE "right"
   PUT (x + 1, y + 1), man4, PSET': PUT (x + 1, y + 1), man4
CASE ELSE
END SELECT
LINE (0, 0)-(600, 320), 1, B
IF NOT display THEN display = true: EXIT SUB
FOR saybox = 225 TO 500
    LINE (saybox, 370)-(saybox, 400), 1, B
    LINE (500 - saybox, 370)-(500 - saybox, 400), 1, B
    LINE (saybox - 1, 370)-(saybox - 1, 400), 0, B
    LINE (500 - saybox + 1, 370)-(500 - saybox + 1, 400), 0, B
  
    LINE (saybox, 370)-(500 - saybox, 370), 1, B
    LINE (saybox, 400)-(500 - saybox, 400), 1, B
NEXT
'LINE (50, 370)-(500, 400), 1, B'
LOCATE 22, 30
PRINT mapname
clk
a$ = INPUT$(1)
FOR saybox = 500 TO 225 STEP -1
    LINE (saybox, 370)-(saybox, 400), 1, B
    LINE (500 - saybox, 370)-(500 - saybox, 400), 1, B
    LINE (saybox + 1, 370)-(saybox + 1, 400), 0, B
    LINE (500 - saybox - 1, 370)-(500 - saybox - 1, 400), 0, B
 
    LINE (saybox, 370)-(500 - saybox, 370), 1, B
    LINE (saybox, 400)-(500 - saybox, 400), 1, B
NEXT
LINE (50, 370)-(500, 400), 0, BF
'drawscore
END SUB

SUB drawscore
VIEW PRINT
COLOR 5
LINE (0, 0)-(520, 320), , B

'FOR i = o TO 520 STEP 40
'    LINE (i, 0)-(i, 320)
'NEXT
'FOR i = 0 TO 320 STEP 40
'    LINE (0, i)-(520, i)
'NEXT

COLOR 2
LOCATE 1, 68
PRINT "生命力:"
LOCATE 3, 72
PRINT "9999"
LOCATE 5, 68
PRINT "体  力:"
LOCATE 7, 72
PRINT "9999"
LOCATE 9, 68
PRINT "经验值:"
LOCATE 11, 72
PRINT "9999"
LOCATE 13, 68
PRINT "所需经验值:"
LOCATE 15, 72
PRINT "9999"
LINE (530, 0)-(630, 320), 12, B


END SUB

SUB endgame
l(1) = 0: start(1) = 1: who = 1
s(1) = manname + "：跑喽！ss"
rpgsay
VIEW PRINT
CLS
PALETTE 15, 0
PALETTE 13, 0
PALETTE 4, 0
PALETTE 0, 65536 * 20 + 256 * 20 + 20
pal
clcon
COLOR 4
LOCATE 17, 15
PRINT "联系地址 : 100083 北京科技大学8712信箱 98-3班  P.Y.W.收"
LOCATE 18, 15
PRINT "TEL      : (010) 62394625"
LOCATE 19, 15
PRINT "E-mail   : Toyshop@263.net"
pal
COLOR 15
LOCATE 11, 15
PRINT "内部测试版  V56.8"

COLOR 13
LOCATE 14, 15
PRINT "我们的故事暂时到此结束."
FOR i = 1 TO 45
    PALETTE 15, 65535 * i + 256 * i + i
    t = TIMER
    pal
    WHILE TIMER - t < .1: WEND
NEXT
FOR i = 1 TO 45
    PALETTE 13, 65535 * i + 256 * i + i
    t = TIMER
    pal
    WHILE TIMER - t < .1: WEND
NEXT
FOR i = 45 TO 1 STEP -1
    PALETTE 13, 65535 * i + 256 * i + i
    PALETTE 15, 65535 * i + 256 * i + i
    t = TIMER
    pal
    WHILE TIMER - t < .05: WEND
NEXT

   l(1) = 1: start(1) = 1
   s(1) = "导演：这剧本谁写的？ss"
   s(2) = "策划：不知道。ss"
CLS
toward = "right"
LOCATE 13, 2: PRINT "？"
rpgsay
clk
pal
CLS
PALETTE 15, 0
PALETTE 13, 0
COLOR 3
cc = 10
't
LINE (43, 71)-(73, 77), cc, BF
LINE (53, 77)-(63, 105), cc, BF
'o
'LOCATE 12, 12: PRINT "o"
FOR i = 5 TO 15
CIRCLE (91, 93), i, cc, , , 1.3
'CIRCLE (91, 93), 5, cc, , , 1.3
NEXT
'y
LINE (109, 80)-(118, 80), cc
LINE (109, 80)-(118, 105), cc
LINE (118, 105)-(110, 124), cc
LINE (118, 80)-(123, 95), cc
LINE (123, 95)-(129, 80), cc
LINE (128, 80)-(137, 80), cc
LINE (137, 80)-(119, 124), cc
LINE (119, 124)-(110, 124), cc
PAINT (111, 81), cc
's
'LOCATE 12, 20: PRINT "s"
LINE (140, 80)-(165, 106), cc, BF
LINE (149, 85)-(165, 90), 0, BF
LINE (140, 96)-(158, 100), 0, BF
'h
LINE (171, 65)-(178, 105), cc, BF
LINE (171, 82)-(195, 88), cc, BF
LINE (188, 88)-(195, 105), cc, BF
'o
'LOCATE 12, 28: PRINT "o"
FOR i = 5 TO 15
CIRCLE (217, 93), i, cc, , , 1.3
'CIRCLE (217, 93), 5, cc, , , 1.3
NEXT
'p
LINE (238, 80)-(265, 105), cc, BF
LINE (238, 80)-(245, 124), cc, BF

LINE (245, 87)-(258, 98), 0, BF
LINE (45, 125)-(259, 145), cc, BF
LOCATE 8, 7: COLOR 10: PRINT "s    t    u    d    i    o"
LOCATE 9, 35: PRINT "PRESENT"
LOCATE 19, 50: PRINT "    ART : G.W."
LOCATE 20, 50: PRINT "Program : P.Y.W.(FFB)"
LOCATE 21, 50: PRINT "   Main : 1998.11-1999.2"
LOCATE 22, 48: PRINT "最后修改于1999年08月17日."

FOR toyi = 1 TO 42
    PALETTE 15, 65535 * toyi + 256 * toyi + toyi
    IF INKEY$ <> "" THEN toyi = 40
    B = TIMER
    WHILE TIMER - B < .01: WEND
NEXT
FOR i = 20 TO 0 STEP -1
    PALETTE 0, 65536 * i + 256 * i + i
    B = TIMER
    WHILE TIMER - B < .01: WEND
NEXT
a$ = INPUT$(1)
FOR toyi = 52 TO 0 STEP -1
    PALETTE 10, 65535 * toyi + 256 * toyi + toyi
    B = TIMER
    WHILE TIMER - B < .01: WEND
NEXT
CLS : END
END SUB

SUB findsth

LOCATE 22, 10: PRINT "发现" + Search
a$ = INPUT$(1)
LOCATE 22, 10: clr
find = false
END SUB

SUB initstore
addjin = 20
jin = 1
KEY 1, CHR$(27) + "马宇驰"
KEY 2, CHR$(27) + "曾昕宗"
KEY 3, CHR$(27) + "韩佳里"
KEY 4, CHR$(27) + "李洪志"
KEY 5, CHR$(27) + "希特勒"
KEY 6, CHR$(27) + "韦小宝"
KEY 7, CHR$(27) + "机器猫"
KEY 8, CHR$(27) + "野比"
KEY 9, CHR$(27) + "强夫"
KEY 10, CHR$(27) + "呆瓜"
        
pause = false

manname = "乐乐"
CLS
COLOR 3
LOCATE 9, 15
PRINT "主人公:";
COLOR 10
PRINT manname
COLOR 3
LOCATE 11, 15
PRINT "是否更改?(y/n)";
clk
a$ = INPUT$(1)
IF a$ = "y" OR a$ = "Y" THEN
   DO
   LOCATE 12, 15
   INPUT "请输入姓名:", B$
   IF LEN(B$) < 10 THEN EXIT DO
   LOCATE 15, 1: PRINT "不合要求,人名应小于四个汉字."
   LOOP
   IF LEN(B$) >= 1 THEN manname = B$
END IF
SCREEN 12
PALETTE 7, 65536 * 60 + 256 * 60 + 60
PALETTE 14, 65535 * 40 + 256 * 40 + 40
FOR i = 1 TO 15
    PALETTE i, 0
NEXT
display = true
COLOR 14    'name color
FOR i = 1 TO 99
    action(i) = false             '未发生  事件
    act(i) = false             '未发生   对话etc.
NEXT

'   FOR cx = 0 TO 600 STEP 40
'       LINE (cx, 0)-(cx, 320), 3
'   NEXT
'   FOR cy = 0 TO 320 STEP 40
'       LINE (0, cy)-(600, cy), 3
'   NEXT

'map=15x8     box=40x40
COLOR 14
'----------------------------------------------------men4
jin = jin + addjin: GOSUB add
FOR i = 10 TO 25: CIRCLE (20, 10), i, 6: NEXT
FOR i = 10 TO 23: CIRCLE (20, 12), i, 6: NEXT
FOR i = 1 TO 5: CIRCLE (6, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 24), i, 0: NEXT
FOR i = 1 TO 5: CIRCLE (34, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 24), i, 0: NEXT
LINE (0, 0)-(40, 24), 0, BF
FOR i = 1 TO 12: CIRCLE (20, 16), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 14), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 18), i, 7: NEXT
FOR i = 1 TO 12: CIRCLE (20, 0), i, 0: NEXT
FOR i = 1 TO 10: CIRCLE (20, 2), i, 0: NEXT
CIRCLE (20, 16), 12, 7: CIRCLE (26, 16), 2, 0, 1, 2
LINE (25, 18)-(26, 19), 0, B
CIRCLE (25, 27), 2, 0, 1.5, 2
LINE (19, 31)-(21, 33), 0, BF
CIRCLE (20, 32), 2, 7
CIRCLE (8, 35), 1, 7: CIRCLE (32, 35), 1, 7: CIRCLE (20, 37), 1, 7
LINE (13, 36)-(14, 37), 7, B: LINE (26, 36)-(27, 37), 7, B
CIRCLE (16, 20), 2, 0, -1.5, -.1
IF pause THEN a$ = INPUT$(1)
GET (1, 1)-(39, 39), man4
LINE (25, 18)-(26, 19), 7, B
LINE (24, 19)-(27, 19), 0, B
GET (1, 1)-(39, 39), autoMan4
'----------------------------------------------------men3
jin = jin + addjin: GOSUB add
FOR i = 10 TO 25: CIRCLE (20, 10), i, 6: NEXT
FOR i = 10 TO 23: CIRCLE (20, 12), i, 6: NEXT
FOR i = 1 TO 5: CIRCLE (6, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 24), i, 0: NEXT
FOR i = 1 TO 5: CIRCLE (34, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 24), i, 0: NEXT
LINE (0, 0)-(40, 24), 0, BF
FOR i = 1 TO 12: CIRCLE (20, 16), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 14), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 18), i, 7: NEXT
FOR i = 1 TO 12: CIRCLE (20, 0), i, 0: NEXT
FOR i = 1 TO 10: CIRCLE (20, 2), i, 0: NEXT
CIRCLE (20, 16), 12, 7: CIRCLE (14, 16), 2, 0, 1, 2: CIRCLE (15, 27), 2, 0, 1, 2
IF pause THEN a$ = INPUT$(1)
LINE (13, 18)-(14, 19), 0, B
LINE (19, 31)-(21, 33), 0, BF
IF pause THEN a$ = INPUT$(1)
CIRCLE (20, 32), 2, 7
CIRCLE (8, 35), 1, 7: CIRCLE (32, 35), 1, 7: CIRCLE (20, 37), 1, 7: CIRCLE (20, 16), 12, 7
LINE (13, 36)-(14, 37), 7, B: LINE (26, 36)-(27, 37), 7, B
CIRCLE (24, 20), 2, 0, -2, -1.5: PSET (22, 19), 15: PSET (23, 18), 7
PSET (23, 20), 0
GET (1, 1)-(39, 39), man3
LINE (13, 18)-(14, 19), 7, B
LINE (12, 19)-(15, 19), 0, B
GET (1, 1)-(39, 39), autoMan3
IF pause THEN a$ = INPUT$(1)
'----------------------------------------------------men1
jin = jin + addjin: GOSUB add
FOR i = 10 TO 25: CIRCLE (20, 10), i, 6: NEXT
FOR i = 10 TO 23: CIRCLE (20, 12), i, 6: NEXT
FOR i = 1 TO 5: CIRCLE (6, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 24), i, 0: NEXT
FOR i = 1 TO 5: CIRCLE (34, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 24), i, 0: NEXT
LINE (0, 0)-(40, 24), 0, BF
FOR i = 1 TO 12: CIRCLE (20, 16), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 14), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 18), i, 7: NEXT
FOR i = 1 TO 12: CIRCLE (20, 0), i, 0: NEXT
FOR i = 1 TO 10: CIRCLE (20, 2), i, 0: NEXT
CIRCLE (20, 16), 12, 7
CIRCLE (7, 27), 2, 7: CIRCLE (33, 27), 2, 7
CIRCLE (15, 36), 1, 7: CIRCLE (25, 36), 1, 7
GET (1, 1)-(39, 39), man1
IF pause THEN a$ = INPUT$(1)
'----------------------------------------------------men2
jin = jin + addjin: GOSUB add
FOR i = 10 TO 25: CIRCLE (20, 10), i, 6: NEXT
FOR i = 10 TO 23: CIRCLE (20, 12), i, 6: NEXT
FOR i = 1 TO 5: CIRCLE (6, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (6, 24), i, 0: NEXT
FOR i = 1 TO 5: CIRCLE (34, 26), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 28), i, 0: NEXT
FOR i = 1 TO 3: CIRCLE (34, 24), i, 0: NEXT
LINE (0, 0)-(40, 24), 0, BF
FOR i = 1 TO 12: CIRCLE (20, 16), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 14), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 18), i, 7: NEXT
FOR i = 1 TO 12: CIRCLE (20, 0), i, 0: NEXT
FOR i = 1 TO 10: CIRCLE (20, 2), i, 0: NEXT
CIRCLE (20, 16), 12, 7: CIRCLE (16, 16), 2, 0, 1, 2: CIRCLE (24, 16), 2, 0, 1, 2
LINE (16, 18)-(17, 19), 0, B: LINE (23, 18)-(24, 19), 0, B
CIRCLE (20, 25), 2, 0, 1, 2
CIRCLE (7, 27), 2, 7: CIRCLE (33, 27), 2, 7
CIRCLE (15, 36), 1, 7: CIRCLE (25, 36), 1, 7
GET (1, 1)-(39, 39), man2
IF pause THEN a$ = INPUT$(1)
LINE (16, 18)-(17, 19), 7, B: LINE (23, 18)-(24, 19), 7, B
LINE (15, 19)-(18, 19), 0, B: LINE (22, 19)-(25, 19), 0, B
GET (1, 1)-(39, 39), autoMan2
CIRCLE (20, 25), 2, 7, 1, 2
CIRCLE (20, 25), 2, 0
LINE (18, 23)-(22, 25), 7, BF
GET (1, 1)-(39, 39), autoMan1
IF pause THEN a$ = INPUT$(1)

jin = jin + addjin: GOSUB add
c = 3
LINE (1, 14)-(5, 29), c, B
IF pause THEN a$ = INPUT$(1)
LINE (5, 10)-(32, 22), c, B
IF pause THEN a$ = INPUT$(1)
LINE (33, 14)-(37, 29), c, B
IF pause THEN a$ = INPUT$(1)
LINE (13, 0)-(23, 13), c, B
LINE (14, 10)-(22, 10), 0
LINE (8, 22)-(29, 37), c, B
LINE (15, 26)-(22, 37), c, B
LINE (16, 37)-(21, 37), 0
LINE (16, 11)-(20, 11), c
LINE (17, 7)-(19, 7), c
IF pause THEN a$ = INPUT$(1)
LINE (15, 13)-(22, 21), c, B
LINE (15, 11)-(10, 15), c
LINE (10, 15)-(15, 21), c
LINE (24, 13)-(26, 15), c
LINE (26, 15)-(22, 21), c
LINE (13, 1)-(23, 1), c
PSET (18, 6), c
CIRCLE (20, 4), 1, c
CIRCLE (16, 4), 1, c
GET (1, 1)-(39, 39), people1                      'people 1
jin = jin + addjin: GOSUB add
PUT (1, 1), people1
'LOCATE 2, 1: PRINT "郭 巍"
GET (0, 0)-(40, 40), people1
jin = jin + addjin: GOSUB add
FOR i = 0 TO 19
    CIRCLE (20, 20), i, 2
NEXT
FOR i = 1 TO 5
    CIRCLE (10, 25), i, 1
NEXT
LINE (19, 1)-(21, 20), 7, BF
GET (1, 1)-(39, 39), people2                           'people2
jin = jin + addjin: GOSUB add
LOCATE 2, 1: PRINT "顾 鹏"
CIRCLE (20, 20), 19, 6
FOR i = 1 TO 5
    CIRCLE (30, 15), i, 2
NEXT
FOR i = 1 TO 5
    CIRCLE (10, 15), i, 2
NEXT

GET (1, 1)-(39, 39), people3
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add       '                                马松
LOCATE 2, 1: PRINT "马 松"
CIRCLE (20, 20), 19, 14
FOR i = 1 TO 5
    CIRCLE (30, 15), i, 9
NEXT
FOR i = 1 TO 5
    CIRCLE (10, 15), i, 9
NEXT
GET (1, 1)-(39, 39), people4   '          马松
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
'                                                            仙人
FOR i = 1 TO 10
    CIRCLE (20, 43), i, 10
NEXT
FOR i = 1 TO 14
    CIRCLE (20, 22), i, 9
NEXT
CIRCLE (20, 22), 7, 3
FOR i = 1 TO 3
    CIRCLE (15, 18), i, 7: CIRCLE (25, 18), i, 7: CIRCLE (20, 18), i, 7
    CIRCLE (20, 23), i, 7: CIRCLE (18, 21), i, 7: CIRCLE (22, 21), i, 7
NEXT
CIRCLE (20, 13), 9, 10
FOR i = 1 TO 8
    CIRCLE (20, 13), i, 0
NEXT
CIRCLE (17, 10), 2, 7, 1, 2: CIRCLE (23, 10), 2, 7, 1, 2: LINE (17, 11)-(18, 12), 14, B
LINE (22, 11)-(23, 12), 14, B: LINE (20, 24)-(20, 37), 7: LINE (19, 28)-(21, 29), 7, B
LINE (19, 33)-(21, 34), 7, B: CIRCLE (15, 28), 3, 0
FOR i = 1 TO 2
    CIRCLE (15, 28), i, 10
NEXT
CIRCLE (25, 28), 3, 0
FOR i = 1 TO 2
    CIRCLE (25, 28), i, 10
NEXT
GET (1, 1)-(39, 39), people5                             'people5
IF pause THEN a$ = INPUT$(1)
'----------------------------------------------------people6
jin = jin + addjin: GOSUB add
LINE (8, 11)-(32, 30), 5, BF: LINE (2, 11)-(8, 26), 12, BF: LINE (32, 11)-(38, 26), 12, BF
LINE (5, 27)-(8, 31), 6, BF: LINE (35, 27)-(32, 31), 6, BF: LINE (10, 31)-(18, 35), 4, BF
LINE (22, 31)-(30, 35), 4, BF: LINE (8, 35)-(18, 38), 10, BF: LINE (22, 35)-(32, 38), 10, BF
FOR i = 1 TO 10
    CIRCLE (20, 11), i, 12
NEXT
FOR i = 1 TO 8
    CIRCLE (20, 11), i, 0
NEXT
GET (1, 1)-(39, 39), people6                      'people6
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
CIRCLE (6, 10), 5, 7: CIRCLE (34, 10), 5, 7
CIRCLE (6, 15), 5, 7: CIRCLE (34, 15), 5, 7
LINE (0, 13)-(40, 20), 0, BF
FOR i = 1 TO 8: CIRCLE (20, 33), i, 5: NEXT
FOR i = 1 TO 6: CIRCLE (18, 33), i, 5: NEXT
FOR i = 1 TO 6: CIRCLE (22, 33), i, 5: NEXT
FOR i = 1 TO 10: CIRCLE (20, 43), i, 0: NEXT
FOR i = 1 TO 8: CIRCLE (18, 41), i, 0: NEXT
FOR i = 1 TO 8: CIRCLE (22, 41), i, 0: NEXT
LINE (18, 33)-(18, 38), 5: LINE (22, 33)-(22, 38), 5
LINE (18, 38)-(15, 38), 5: LINE (15, 38)-(17, 33), 5
LINE (22, 38)-(25, 38), 5: LINE (25, 38)-(23, 33), 5
LINE (17, 35)-(17, 37), 5: LINE (23, 34)-(23, 37), 5: PSET (24, 37), 5
FOR i = 1 TO 12: CIRCLE (20, 16), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 14), i, 7: NEXT
FOR i = 1 TO 10: CIRCLE (20, 18), i, 7: NEXT
FOR i = 18 TO 22 STEP 2: LINE (i, 4)-(i, 10), 0: NEXT
CIRCLE (16, 14), 2, 0, 1, 2: CIRCLE (24, 14), 2, 0, 1, 2
CIRCLE (16, 18), 2, 0: CIRCLE (24, 18), 2, 0
LINE (16, 18)-(17, 18), 0: LINE (24, 18)-(25, 18), 0
PSET (17, 19), 0: PSET (25, 19), 0
LINE (16, 19)-(16, 18), 0: LINE (24, 19)-(25, 18), 0
CIRCLE (20, 23), 2, 0: LINE (18, 21)-(22, 23), 7, BF
GET (1, 1)-(39, 39), people9                                'people9
jin = jin + addjin: GOSUB add
'CIRCLE (20, 20), 19, 7
CIRCLE (20, 15), 10, 2, , , .6
CIRCLE (20, 26), 15, 2, , , .4
LINE (20, 15)-(20, 39), 2
GET (1, 1)-(39, 39), tree                              'tree
IF pause THEN a$ = INPUT$(1)

'jin=jin+addjin:gosub add
'LOCATE 2, 2: PRINT CHR$(29)
'INE (1, 1)-(39, 39), 2, B
'INE (4, 4)-(35, 35), 2, B
'IRCLE (10, 20), 3, 5
'IF pause THEN a$ = INPUT$(1)
'GET (1, 1)-(39, 39), door

jin = jin + addjin: GOSUB add
FOR i = 5 TO 15 STEP 3
CIRCLE (20, 20), i, 14
NEXT
GET (1, 1)-(39, 39), myst                               'myst
jin = jin + addjin: GOSUB add
diskc = 2
LINE (9, 21)-(13, 32), diskc, B
LINE (13, 28)-(16, 20), diskc, B
LINE (25, 20)-(29, 32), diskc, B
LINE (29, 20)-(31, 29), diskc, B
LINE (5, 6)-(35, 20), diskc, BF
GET (1, 1)-(39, 39), disk                         'disk
'END
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
'wallc = 4    'back color
'wallcl = 8   'line color
wallc = 2
wallcl = 4

wallc = 0
wallcl = 4


LINE (1, 1)-(38, 20), wallc, BF
LINE (1, 6)-(39, 6), wallcl         '横线
LINE (1, 13)-(39, 13), wallcl       '横线
LINE (2, 6)-(2, 13), wallcl
LINE (11, 1)-(11, 6), wallcl
LINE (11, 13)-(11, 20), wallcl
LINE (20, 6)-(20, 13), wallcl
LINE (29, 1)-(29, 6), wallcl
LINE (29, 13)-(29, 20), wallcl

GET (1, 1)-(39, 20), wall
PUT (1, 14), wall, PSET
PUT (1, 27), wall, PSET
GET (1, 1)-(39, 39), wall
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
LINE (2, 40)-(20, 10), 2     '/
IF pause THEN a$ = INPUT$(1)
LINE -STEP(40, 0), 2          '--
IF pause THEN a$ = INPUT$(1)
LINE (78, 40)-(60, 10), 2      '\
IF pause THEN a$ = INPUT$(1)
LINE (78, 40)-(2, 40), 2       '-----
IF pause THEN a$ = INPUT$(1)
LINE (12, 40)-(70, 70), 2, BF  'box
IF pause THEN a$ = INPUT$(1)
LINE (24, 10)-(34, 4), 2, B 'yan
IF pause THEN a$ = INPUT$(1)
LINE (15, 69)-(30, 45), 0, BF   'door
IF pause THEN a$ = INPUT$(1)
CIRCLE (18, 57), 1, 2           'lock
IF pause THEN a$ = INPUT$(1)
LINE (40, 60)-(62, 47), 0, BF   'windows
IF pause THEN a$ = INPUT$(1)
LINE (45, 56)-(47, 50), 1     '|light
IF pause THEN a$ = INPUT$(1)
LINE (52, 56)-(54, 50), 1     '|
IF pause THEN a$ = INPUT$(1)
GET (1, 1)-(79, 79), house
IF pause THEN a$ = INPUT$(1)
'=--------------------------------------yun
jin = jin + addjin: GOSUB add
FOR i = 1 TO 10
    CIRCLE (12, 25), i, 7
NEXT
FOR i = 1 TO 10
    CIRCLE (27, 25), i, 7
NEXT
FOR i = 1 TO 10
    CIRCLE (20, 15), i, 7
NEXT
FOR i = 1 TO 10
    CIRCLE (20, 27), i, 7
NEXT
GET (1, 1)-(39, 39), yun
IF pause THEN a$ = INPUT$(1)
'--------------------------------------------------tree
jin = jin + addjin: GOSUB add
FOR i = 1 TO 5
    CIRCLE (20, 10), i, 2: CIRCLE (15, 15), i, 2: CIRCLE (25, 15), i, 2
    CIRCLE (20, 20), i, 2: CIRCLE (12, 20), i, 2: CIRCLE (28, 20), i, 2
    CIRCLE (20, 25), i, 2: CIRCLE (9, 25), i, 2: CIRCLE (31, 25), i, 2
NEXT
LINE (18, 20)-(22, 35), 6, BF: LINE (15, 35)-(25, 37), 6, BF
FOR i = 1 TO 5
    CIRCLE (20, 20), i, 2
NEXT
IF pause THEN a$ = INPUT$(1)
GET (0, 0)-(40, 40), tree
'------------------------------------------------house1
jin = jin + addjin: GOSUB add
LINE (5, 5)-(35, 20), 6, BF: LINE (8, 21)-(32, 35), 7, BF
LINE (10, 23)-(18, 31), 0, BF: LINE (14, 23)-(14, 31), 7
LINE (10, 27)-(18, 27), 7: LINE (24, 27)-(29, 35), 0, BF
FOR k = 5 TO 20
    FOR i = 5 TO 35 STEP 2
        PSET (i, k), 0
    NEXT
NEXT
LINE (24, 6)-(29, 16), 7, BF: LINE (23, 6)-(30, 8), 7, BF
GET (1, 1)-(39, 39), house1
LOCATE 10, 10: PRINT 1
IF pause THEN a$ = INPUT$(1)
'------------------------------------------------house2
jin = jin + addjin: GOSUB add
LINE (5, 5)-(35, 20), 6, BF: LINE (8, 21)-(32, 35), 7, BF
LINE (10, 23)-(18, 31), 0, BF: LINE (14, 23)-(14, 31), 7: LINE (10, 27)-(18, 27), 7
LINE (24, 27)-(29, 35), 0, BF: LINE (24, 6)-(29, 16), 7, BF: LINE (23, 6)-(30, 8), 7, BF
GET (0, 0)-(40, 40), house2
LOCATE 10, 10: PRINT 2
'------------------------------------------------house3
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
LINE (5, 15)-(20, 35), 10, BF: LINE (5, 6)-(20, 14), 10, B
LINE (21, 25)-(35, 35), 10, BF: LINE (21, 18)-(35, 24), 10, B: LINE (7, 17)-(18, 33), 1, BF
FOR i = 7 TO 18 STEP 2
    FOR k = 17 TO 33 STEP 2
        LINE (i, 17)-(i, 33), 7: LINE (7, k)-(18, k), 7
    NEXT
NEXT
LINE (23, 27)-(33, 33), 1, BF
FOR i = 23 TO 33 STEP 2
    FOR k = 27 TO 33 STEP 2
        LINE (i, 27)-(i, 33), 7: LINE (23, k)-(33, k), 7
    NEXT
NEXT
GET (0, 0)-(40, 40), house3
LOCATE 10, 10: PRINT 3
IF pause THEN a$ = INPUT$(1)
'------------------------------------------------house4
jin = jin + addjin: GOSUB add
LINE (6, 15)-(15, 8), 6: LINE (6, 25)-(15, 19), 6: LINE (6, 25)-(6, 15), 6
LINE (15, 8)-(23, 15), 6: LINE (15, 19)-(22, 25), 6: LINE (22, 15)-(35, 15), 6
LINE (22, 25)-(35, 25), 6: LINE (35, 15)-(35, 25), 6: PAINT (8, 16), 6
LINE (9, 24)-(9, 35), 7: LINE (32, 25)-(32, 35), 7: LINE (9, 35)-(32, 35), 7
LINE (9, 25)-(15, 20), 7: LINE (15, 20)-(22, 26), 7: LINE (22, 26)-(32, 26), 7
PAINT (10, 34), 7: LINE (11, 27)-(19, 33), 0, BF: LINE (15, 27)-(15, 33), 7
LINE (11, 30)-(19, 30), 7: LINE (24, 29)-(28, 35), 0, BF: LINE (28, 14)-(30, 21), 7, BF
LINE (27, 12)-(31, 14), 7, BF: LINE (29, 9)-(30, 10), 7, B: LINE (33, 6)-(34, 7), 7, B
LINE (37, 5)-(38, 6), 7, B
GET (1, 1)-(39, 39), house4
LOCATE 10, 10: PRINT 4

'------------------------------------------------house5
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
DIM xxx%(500): DIM yyy%(500)
LINE (2, 9)-(10, 38), 10, BF: LINE (2, 9)-(15, 5), 6: LINE (2, 9)-(10, 9), 6
LINE (10, 9)-(23, 5), 6: LINE (23, 5)-(15, 5), 6: LINE (21, 6)-(13, 6), 6
LINE (18, 7)-(9, 7), 6: LINE (15, 8)-(5, 8), 6: LINE (10, 10)-(23, 6), 10
LINE (10, 38)-(23, 34), 10: LINE (23, 6)-(23, 34), 10: PAINT (20, 30), 10
LINE (10, 9)-(10, 38), 6: LINE (4, 11)-(8, 36), 5, BF: LINE (6, 11)-(6, 36), 10
FOR i = 11 TO 35 STEP 2
    LINE (4, i)-(8, i), 10
NEXT
IF pause THEN a$ = INPUT$(1)
GET (0, 0)-(40, 40), xxx%: PUT (13, 0), xxx%, PSET
LINE (23, 5)-(15, 5), 6: LINE (21, 6)-(13, 6), 6: LINE (18, 7)-(9, 7), 6
LINE (13, 9)-(13, 38), 10: LINE (14, 10)-(14, 38), 6: LINE (26, 12)-(34, 9), 5
LINE (26, 14)-(34, 11), 5: LINE (26, 16)-(34, 13), 5: LINE (26, 18)-(34, 15), 5
LINE (26, 20)-(34, 17), 5: LINE (26, 22)-(34, 19), 5: LINE (26, 24)-(34, 21), 5
LINE (26, 26)-(34, 23), 5: LINE (26, 28)-(34, 25), 5: LINE (26, 30)-(34, 27), 5
LINE (26, 32)-(34, 29), 5: LINE (26, 34)-(34, 31), 5: LINE (26, 36)-(34, 33), 5
LINE (27, 11)-(27, 37), 10: LINE (29, 11)-(29, 35), 10: LINE (31, 9)-(31, 34), 10
LINE (33, 7)-(33, 33), 10
IF pause THEN a$ = INPUT$(1)
GET (0, 0)-(40, 40), house5
LOCATE 10, 10: PRINT 5
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
GET (1, 1)-(39, 39), house9
IF pause THEN a$ = INPUT$(1)
jin = jin + addjin: GOSUB add
GET (0, 0)-(40, 40), space
'it(1) = "木棍"
'it(2) = "天香续命露"
'it(3) = "饼乾"
jin = 999: GOSUB add
PALETTE
PALETTE 7, 65536 * 60 + 256 * 60 + 60
PALETTE 14, 65535 * 40 + 256 * 40 + 40
EXIT SUB

add:
CLS
RETURN
LINE (45, 378)-(502, 412), 1, B
LINE (46, 379)-(501, 411), 1, B
COLOR 3
LOCATE 14, 7: PRINT "Produce with Microsoft Quick Basic 4.0"
LOCATE 16, 7: PRINT "Toyshop Studio 1997-1999"
LOCATE 18, 7: PRINT "E-main:Toyshop@263.net"
LOCATE 20, 7: PRINT "Loading..."
pal
IF jin > 450 THEN jin = 450
LINE (0, 0)-(100, 100), 0, BF
FOR i = jin0 TO jin
    LINE (50, 380)-(50 + INT(i), 410), 14, BF
    pal
    FOR tmp = 0 TO 7999: NEXT
NEXT
LINE (49, 379)-(501, 411), 1, B
LINE (48, 378)-(502, 412), 1, B
FOR tmp = 0 TO 29999: NEXT
jin0 = jin
RETURN

END SUB

SUB loadmap (mm AS INTEGER)
OPEN "d:\pyw\d\basic\rpg\1.txt" FOR INPUT AS #1
   INPUT #1, mapname
   whichhouse = 1
   INPUT #1, mx
   INPUT #1, my
   INPUT #1, m(1)
   INPUT #1, m(2)
   INPUT #1, m(3)
   INPUT #1, m(4)
   INPUT #1, m(5)
   INPUT #1, m(6)
   INPUT #1, m(7)
   INPUT #1, m(8)

   l(1) = 0: start(1) = 1
   s(1) = manname + "：~~这是哪？？！！``ss"

END SUB

SUB map1   '15x8
mapname = "木桶小镇"
whichhouse = 1
IF loadxy THEN IF retn THEN mx = 14: my = 7 ELSE mx = 1: my = 2
m(1) = "thxt0hxthxhxttt"
m(2) = "txx00xxtxxxx1tt"
IF action(1) THEN m(2) = "0xx10xxtxxxx0tt"
IF action(2) THEN m(2) = "0xx14xxtxxxx0tt"
m(3) = "0000000000000tt"
m(4) = "t0t00hx0t0t0ttt"
m(5) = "t0t00ix0t0t0ttt"
m(6) = "t0000000000000t"
m(7) = "hx000tt0ttttt0t"
m(8) = "xxtttttttttttet"

o(1) = "000000000000000"
o(2) = "a20000000000000"
o(3) = "000000000000000"
o(4) = "t00000000000000"
o(5) = "t00001000000000"
o(6) = "t00000000000000"
o(7) = "00000000000000t"
o(8) = "t00000000000000"

IF NOT action(1) THEN
   l(1) = 4: start(1) = 14
   s(14) = manname + "：呀！这不是郭巍吗？"
   s(15) = "郭巍：那咱们再见吧....我有~~重要``的事情要做，不要打扰我。ss"
   s(16) = manname + "：......ss"
   s(17) = manname + "：那好吧，我先走了......ss"
   's(18) = manname + "心想：呀，一定是昨天我把他的像皮弄丢了，他生我的气了。ss"
   s(18) = "郭巍心想：倒霉，偏偏赶上小便时过来。ss"
ELSE
   l(1) = 4: start(1) = 1
   s(1) = "郭巍：" + manname + "，昨天晚上看〈阿拉蕾〉了吗？特好玩。ss"
   s(2) = manname + "：看了，把我乐得肚子直疼。ss"
   s(3) = "郭巍：对！没错！只不过没看到结尾，电视仿佛受了~~干扰``，"
   s(4) = "      ``全是雪花。ss"
   s(5) = manname + "：我家也是。ss"
END IF

IF action(2) THEN
   l(4) = 1: start(4) = 10
   s(10) = manname + "：马松，你回来了。ss"
   s(11) = "马松：我从坡上爬上来了。ss"
END IF
END SUB

SUB map10
PALETTE 0, 65536 * 30 + 256 * 30 + 30
mapname = "入口"
mx = 2: my = 2
m(1) = "yyyyyyyyyyyyyyy"
m(2) = "e00000000y000yy"
m(3) = "yy0000y0000000y"
m(4) = "y00y00000000y0y"
m(5) = "y0000000000000y"
m(6) = "yy000000000y00y"
m(7) = "y0000y00000000y"
m(8) = "yyyyyyyyyyyyyyy"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

IF NOT action(3) THEN
   l(1) = 0: start(1) = 1
   s(1) = manname + "：~~这是哪？？！！``ss"
   action(3) = true
   CALL cg1
END IF
END SUB

SUB map11
PALETTE 0, 65536 * 20 + 256 * 20 + 20
mapname = "入口内部"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 2
m(1) = "yyyyyyyyyyyyyyy"
m(2) = "y00000000y0000E"
m(3) = "yy0000y0y00000y"
m(4) = "y00y00y0y000y0y"
m(5) = "y0000y000y0000y"
m(6) = "yy00y000000y00y"
m(7) = "e0000y00yyy000y"
m(8) = "yyyyyyyyyyyyyyy"

o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"



END SUB

SUB map12
PALETTE 0, 65536 * 10 + 256 * 10 + 10
mapname = "幻界"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 2
loadxy = true
m(1) = "wyyyyyyyyyyyyyy"
m(2) = "wtt00000000000E"
m(3) = "wtt$$$000000y0y"
m(4) = "wtt00000$$$0yyy"
m(5) = "wtt$$$000000yyy"
m(6) = "wtt00000$$$0tty"
m(7) = "e00000000000tty"
m(8) = "wyyyyyyyyyyyyyy"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"


END SUB

SUB map13
PALETTE 0, 65536 * 0 + 256 * 0 + 0
mapname = "丛林中"
IF loadxy THEN IF retn THEN mx = 2: my = 2 ELSE mx = 14: my = 7
m(1) = "wwwwwwwwwwwwwww"
m(2) = "e0ttttttttttt0w"
m(3) = "w0t00000000000w"
m(4) = "w0t0t00tttttttw"
m(5) = "w0t0t0tt0000ttw"
m(6) = "w0t0t0t00tt00tw"
m(7) = "w000t0000ttt00E"
m(8) = "wwwwwwwwwwwwwww"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"


END SUB

SUB map14
mapname = "幻界村落"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 2
m(1) = "wwwwwwwwwwwwwww"
m(2) = "wttttttttttt00E"
m(3) = "wttttttttttt0tw"
m(4) = "wttttt$t00000tw"
m(5) = "wt9$0tttt0000tw"
m(6) = "wt0ttt$0tt000tw"
m(7) = "e0000000000tttw"
m(8) = "wwwwwwwwwwwwwww"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

l(9) = 11: start(9) = 1
s(1) = "小姑娘：　~~啊！你是谁？？``ss"
s(2) = manname + "：~~啊？！``我是木桶镇的....ss"
s(3) = "小姑娘：你怎么到这里来了？ss"
s(4) = manname + "：我是从那边的~~入口``进来的..ss"
s(5) = "小姑娘：~~镇狱冥王``没把你抓起来吗？ss"
s(6) = manname + "：..？..？..？ss"
s(7) = manname + "：是<仙剑奇侠传>里的镇狱冥王吗？ss"
s(8) = "小姑娘：什么仙？？没听说过！不过没抓起来就好？我叫~~灵儿``，你呢？ss"
s(9) = manname + "：我叫" + manname + "..ss"
s(10) = "灵儿：你快走吧！被镇狱冥王抓住可不是闹着玩的.."
s(11) = "      ``据说这镇狱冥王是练~~法轮功``出身的，据说它一叫唤地球就要毁灭！ss"
s(12) = manname + "：这么厉害，看来我得快逃。ss"
END SUB

SUB map15
mapname = "幻界山坡"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 2
m(1) = "wwwwwwwwwwwwwww"
m(2) = "wttttttttttt00E"
m(3) = "wttttttttt000tw"
m(4) = "wtttttttt000ttw"
m(5) = "wtttttt000ttttw"
m(6) = "wt0000000tttttw"
m(7) = "F00t0tttttttttw"
m(8) = "wwwwwwwwwwwwwww"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"


END SUB

SUB map16
mapname = "幻界"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 7
m(1) = "yyyyyyyyyyyyyyy"
m(2) = "y0000000000000g": nextmap = 17
m(3) = "y0yyy000000000y"
m(4) = "e00yyyyyyyyy00y"
m(5) = "yyyyy000000000y"
m(6) = "y00000yyyyyyy0y"
m(7) = "yyyyy000000000E"
m(8) = "yyyyyyyyyyyyyyy"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

END SUB

SUB map17
mapname = "幻界"
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 14: my = 7
m(1) = "yyyyyyyyyyyyyyy"
m(2) = "y0000000000000g": nextmap = 17
m(3) = "y0yyy000000000y"
m(4) = "e00yyyyyyyyy00y"
m(5) = "yyyyy000000000y"
m(6) = "y00000yyyyyyy0y"
m(7) = "yyyyy000000000E"
m(8) = "yyyyyyyyyyyyyyy"

o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

END SUB

SUB map2
mapname = "村外小路"
whichhouse = 0
IF action(1) THEN whichhouse = 9
IF loadxy THEN IF retn THEN mx = 2: my = 7 ELSE mx = 1: my = 2
IF retn1 THEN mx = 13: my = 7
m(1) = "Etttttttttttttt"
m(2) = "00000000000$!!t"
m(3) = "t0tt3000000000t"
IF action(1) THEN m(3) = "t0tt0000000030t"
m(4) = "t0tttt00ttt00tt"
m(5) = "t0000000t@tt0tt"
m(6) = "t0t$tt00ttt00tt"
m(7) = "t000000000004tt"
IF action(1) THEN m(7) = "t000000000000tt"
m(8) = "tettttttttttttt"
IF action(1) THEN m(8) = "tettttttttttgtt": nextmap = 8
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

IF NOT action(1) THEN
   l(3) = 7: start(3) = 1
   s(1) = "顾鹏：现代少女不可交，"
   s(2) = "      ``面似桃花心似刀。"
   s(3) = "      ``穷人有志她不爱，ss"
   s(4) = "      ``专爱有钱地位高。ss"
   s(5) = manname + "：啊？ss"
   s(6) = "      ``顾鹏，你又失恋了？？ss"
   s(7) = "顾鹏：别提了...."
   s(8) = "      ``还是先添饱肚子再来谈所谓的~~爱情``吧。ss"
ELSE
   l(3) = 0: start(3) = 1
   s(1) = "顾鹏：别打扰我！我正在练二节棍。ss"
END IF

l(4) = 12: start(4) = 9
s(9) = manname + "：呀！这不是马松吗？ss"
s(10) = "马松：啊！原来是你呀，" + manname + "。吓了我一跳。"
s(11) = "      ``来，尝尝我摘的巧克力蛋糕。ss"
s(12) = manname + "：......"
s(13) = "      ``嗯。真好吃！。ss"
s(14) = manname + "：是你家种的蛋糕树吗？ss"
s(15) = "马松：不是，是郭巍家的。ss"
s(16) = manname + "：......ss"
s(17) = "      ``原来是郭巍家的。ss"
s(18) = "      ``马松，人家辛辛苦苦种的蛋糕树被你吃了，"
s(19) = manname + "：太不应该了。ss"
s(20) = "马松：蛋糕好吃。ss"
s(21) = manname + "：唉....ss"
IF action(2) THEN
   l(3) = 2: start(3) = 1
   s(1) = "顾鹏：别打扰我！我正在练二节棍。ss"
   s(2) = manname + "：顾鹏，看见马松了吗？ss"
   s(3) = "顾鹏：刚才见他去木桶镇了。ss"
END IF
END SUB

SUB map3
mapname = "树林中"
whichhouse = 0
IF loadxy THEN IF retn THEN mx = 14: my = 8 ELSE mx = 1: my = 2
m(1) = "Etttttttttttttt"
m(2) = "00000000000000t"
m(3) = "tttttttttttt00t"
m(4) = "t0000000000000t"
m(5) = "t0ttttttttttt0t"
m(6) = "t0000000000000t"
m(7) = "t5$tttttttt000t"
IF action(2) THEN m(7) = "t0$tttttttt000t"
m(8) = "ttttttttttttt0e"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

IF NOT action(1) THEN
   l(5) = 3: start(5) = 1        'l(n)=lengh    start-- start from where
   s(1) = manname + "：你是酒剑仙吧？ss"
   s(2) = "睡仙：不是。我是~~睡仙``。"
   s(3) = "      ``啊--我好困呀....ss"
   s(4) = "      ``zzzzss"
ELSE
   l(5) = 7: start(5) = 1        'l(n)=lengh    start-- start from where
   s(1) = manname + "：睡仙爷爷，您知道~~入口``的事吗？ss"
   s(2) = "睡仙：小孩子  不要问这些事。ss"
   s(3) = manname + "：求求您了，告诉我吧。ss"
   s(4) = "睡仙：不行不行。ss"
   s(5) = "    "
   s(6) = "睡仙：除非你能回答我一个问题....ss"
   s(7) = manname + "：好，好！您快说吧。ss"
   s(8) = "睡仙：就不问你。ss"
END IF
END SUB

SUB map4
mapname = "学校门口"
whichhouse = 2
IF loadxy THEN
   IF retn THEN mx = 14: my = 3 ELSE mx = 1: my = 2
ELSE
   mx = 14: my = 3
END IF
m(1) = "Etttttttttttt#t"
m(2) = "00000000tt000it"
m(3) = "tttt0t00tt0000t"
m(4) = "tttt0t00tt0000t"
m(5) = "tttt0t00ttt000t"
m(6) = "tttt0t00tt0000t"
m(7) = "tbtt0000000000t"
IF action(2) THEN m(7) = "tbg00000000000t": nextmap = 10
m(8) = "ttttttttttttttt"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

IF action(1) AND NOT act(1) AND act(3) THEN
   clk
   drawmap
   l(1) = 0: who = 1
   start(1) = 1
   s(1) = manname + "：我才不叫家长来呢。ss"
   rpgsay
   act(1) = true
   display = false
END IF

END SUB

SUB map5
mapname = "学校楼道里"
whichhouse = 0
IF loadxy THEN mx = 10: my = 5
m(1) = "000000000000000"
m(2) = "000000000000000"
m(3) = "wwwwwwwwwwwwwww"
m(4) = "E0000000000000w"
m(5) = "E0000000000060w"
m(6) = "wwwwwwwwwwwwwww"
m(7) = "000000000000000"
m(8) = "000000000000000"

o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

l(6) = 16: start(6) = 1        'l(n)=lengh    start-- start from where
s(1) = manname + "：老师，您知道关于~~入口``的事吗？ss"
s(2) = "老师：啊？你怎么想起问这个？！ss"
s(3) = manname + "：我上学时看见那个~~入口``又出现了。ss"
s(4) = "老师：这....小孩子最好别管这些事。ss"
s(5) = "老师：``......"
s(6) = "      ``对了！今天你还没交作业呢！！！ss"
s(7) = manname + "：啊！我....我....我忘记带了，明天一定交。ss"
s(8) = "老师：" + manname + "呀，你最进学习可不大努力啊。ss"
s(9) = "      ``这样下去怎么参加高考呀？ss"
s(10) = manname + "：啊？我最进努力多了！ss"
s(11) = manname + "：我每天晚上十点多才睡觉、早上不到七点就起床了。ss"
s(12) = "老师：是比于畅努力。ss"
s(13) = "      ``那你平时几点睡觉？ss"
s(14) = manname + "：晚上八点睡觉、早上七点就起床。ss"
s(15) = "老师：......ss"
s(16) = "      ~~总之!!太不努力了！！！！ss"
s(17) = "老师：``明天把家长找来！AAss": active = 3
END SUB

SUB map8
mapname = "秘密小路"
IF retn1 THEN mx = 14: my = 5 ELSE mx = 2: my = 5
m(1) = "ttttttttttttttt"
m(2) = "t0000000000000t"
m(3) = "t0000000000000t"
m(4) = "tttttttttttt0tt"
m(5) = "t0000000000000g": nextmap = 9
m(6) = "tttt0tttttttttt"
m(7) = "t0000000000004t"
IF act(2) THEN m(7) = "t0000000000000t"
m(8) = "ttttttttttttttt"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

   l(4) = 6: start(4) = 1
   s(1) = manname + "：呀！马松，你怎么跑到这里来了？ss"
   s(2) = "马松：我正在摘巧克力蛋糕，忽然看见前面有一棵苹果树，"
   s(3) = "      ``要知道，木桶小镇已经很多年没有苹果树了..ss"
   s(4) = manname + "：然后呢？ss"
   s(5) = "马松：我想去摘，可脚下一滑,就掉到这来..ss"
   s(6) = manname + "：我以前怎么没来过这里？？ss"
   s(7) = "马松：我们怎么出去呀？？！！ss"
   into = true
IF act(2) AND NOT action(2) THEN
   clk
   drawmap
   who = 4
   l(4) = 0: start(4) = 1
   s(1) = manname + "：嗯？！马松哪去了？ss"
   into = true
   clk
   rpgsay
   action(2) = true
   display = false
END IF

END SUB

SUB map9
mapname = "林间小路"
mx = 2: my = 5
m(1) = "tttttttttttt00t"
IF action(2) THEN m(1) = "ttttttttttttRRt"
m(2) = "tt000t0000tt00t"
m(3) = "tt0t0t0tt00tttt"
IF action(2) THEN m(3) = "tt0t0t0tt00t00t"
m(4) = "tt0t000tt00000t"
m(5) = "G00ttttt0tttt0t"
m(6) = "tt0000t000t000t"
m(7) = "tt50t000t000ttt"
m(8) = "ttttttttttttttt"
o(1) = "000000000000000"
o(2) = "000000000000000"
o(3) = "000000000000000"
o(4) = "000000000000000"
o(5) = "000000000000000"
o(6) = "000000000000000"
o(7) = "000000000000000"
o(8) = "000000000000000"

who = 5
active = 2
  
      l(5) = 1: start(5) = 1
      s(1) = manname + "：睡仙爷爷，您怎么到这来了？ss"
      s(2) = "睡仙：我原意。AAss"
  


END SUB

FUNCTION object      'up,down,left,right
SELECT CASE toward
CASE "up"
     m$ = MID$(m(my - 1), mx, 1)
     object = -1
     FOR i = 1 TO total
         IF m$ = maythough(i) THEN object = 0
     NEXT
     IF VAL(m$) >= 1 AND VAL(m$) <= 9 THEN say = -1: who = VAL(m$)
     o$ = MID$(o(my - 1), mx, 1)
     IF o$ >= "a" AND o$ <= "z" THEN
        find = true
        MID$(o(my - 1), mx, 1) = "0"
     END IF
CASE "down"
     m$ = MID$(m(my + 1), mx, 1)
     object = -1

     FOR i = 1 TO total
         IF m$ = maythough(i) THEN object = 0
     NEXT

     IF m$ = "1" OR m$ = "2" THEN say = -1
     IF VAL(m$) >= 1 AND VAL(m$) <= 9 THEN say = -1: who = VAL(m$)
     o$ = MID$(o(my + 1), mx, 1)
     IF o$ >= "a" AND o$ <= "z" THEN
        find = true
        MID$(o(my + 1), mx, 1) = "0"
     END IF
CASE "left"
     IF mx > 1 THEN m$ = MID$(m(my), mx - 1, 1)
     object = -1
     FOR i = 1 TO total
         IF m$ = maythough(i) THEN object = 0
     NEXT
     IF m$ = "1" OR m$ = "2" THEN say = -1
     IF VAL(m$) >= 1 AND VAL(m$) <= 9 THEN say = -1: who = VAL(m$)
     IF mx > 1 THEN o$ = MID$(o(my), mx - 1, 1)
     IF o$ >= "a" AND o$ <= "z" THEN
        find = true
        MID$(o(my), mx - 1, 1) = "0"
     END IF
CASE "right"
     m$ = MID$(m(my), mx + 1, 1)
     object = -1
     FOR i = 1 TO total
         IF m$ = maythough(i) THEN object = 0
     NEXT
     IF m$ = "1" OR m$ = "2" THEN say = -1
     IF VAL(m$) >= 1 AND VAL(m$) <= 9 THEN say = -1: who = VAL(m$)
     o$ = MID$(o(my), mx + 1, 1)
     IF o$ >= "a" AND o$ <= "z" THEN
        find = true
        MID$(o(my), mx + 1, 1) = "0"
     END IF
CASE ELSE
END SELECT
  IF find THEN
        SELECT CASE o$
        CASE "t":
             Search = "松子"
        CASE "a":
             Search = "鼠儿果"
        CASE "b":
             Search = "百事可乐"
        CASE "j":
             Search = "青锋无刃日月星辰虎啸龙潭剑"
        CASE ELSE
        END SELECT
  END IF
END FUNCTION

SUB pal STATIC
IF note THEN GOTO here
t = TIMER
c14 = 40
note = -1
here:
IF TIMER - t < .01 THEN EXIT SUB
t = TIMER
IF add = 0 THEN add = -1
c14 = c14 + add
IF c14 > 45 OR c14 < 20 THEN add = -add
PALETTE 14, 65535 * INT(c14) + 256 * INT(c14) + INT(c14)

END SUB

SUB readhouse
SELECT CASE whichhouse
       CASE 1
                   CALL room1
       CASE 2
                 CALL room2
       CASE 3
                 'CALL room3
       CASE 4
                 'CALL room4
       CASE 9
                  CALL room9
      
       CASE ELSE
END SELECT
END SUB

SUB readmap (mm)
SELECT CASE mm
   CASE 1
         CALL loadmap(1)
         'CALL map1
   CASE 2
         CALL map2
   CASE 3
         CALL map3
   CASE 4
         CALL map4
   CASE 5
         CALL map5
   CASE 8
        CALL map8
   CASE 9
        CALL map9
   CASE 10
        CALL map10
   CASE 11
        CALL map11
   CASE 12
        CALL map12
   CASE 13
        CALL map13
   CASE 14
        CALL map14
   CASE 15
        CALL map15
   CASE 16
        CALL map16
        display = false
   CASE ELSE
      CALL loadmap(1)
END SELECT
loadxy = true
END SUB

SUB room1
toward = "up"
mapname = "韩小里家中"
mx = 8: my = 7
m(1) = "000000000000000"
m(2) = "0wwwwwwwwwwwww0"
m(3) = "0w00d2w000dd0w0"
IF action(1) THEN m(3) = "0w00d0w020dd0w0"
m(4) = "0w0000w000000w0"
m(5) = "0w00wwwww00www0"
m(6) = "0w00000000000w0"
m(7) = "0wwwwww00wwwww0"
m(8) = "000000ziiz00000"
IF NOT action(1) THEN
   l(2) = 12: start(2) = 1
   s(1) = manname + "：韩佳里！走，上学去！ss"
   s(2) = "韩佳里：今天不去了....ss"
   s(3) = manname + "：......ss"
   s(4) = "韩佳里：想起床真是比登天还难。ss"
   s(5) = manname + "：我说你还是快起的好，太阳都晒屁股了。ss"
   s(6) = "韩佳里：我困死了。ss"
   s(7) = manname + "：你怎么那样睡觉，姿势难看死了。ss"
   s(8) = "韩佳里：啊！s"
   s(9) = "      ~~大梦谁先觉，平生我自知。草堂春睡足，窗外日迟迟``。ss"
   s(10) = "铛！"
   s(11) = "...."
   s(12) = "（韩佳里从床上掉下来了....）ss"
   s(13) = manname + "：你再不起我不理你了。ss"
ELSE
   l(2) = 6: start(2) = 1
   s(1) = manname + "：啊，韩佳里，你终于起来了。ss"
   s(2) = "韩佳里：呆会儿还得睡。ss"
   s(3) = manname + "：......ss"
   s(4) = manname + "：那个~~入口``又出现了，不想去看看吗？ss"
   s(5) = "韩佳里：昨天晚上我在外边玩时看一个大怪物从入口钻了出来，"
   s(6) = "      ``吓死我了。ss"
   s(7) = "      ``才不去那鬼地方。ss"
END IF
END SUB

SUB room2
mapname = "教室中"
whichhouse = 2
IF loadxy THEN mx = 12: my = 2 ELSE mx = 12: my = 2
m(1) = "wwwwwwwwwwwww00"
m(2) = "w00060000000i00"
m(3) = "wdd00ddd00ddw00"
m(4) = "w00000000000w00"
m(5) = "wdd00ddd00ddw00"
m(6) = "w00000000000w00"
m(7) = "wdd00ddd00ddw00"
m(8) = "wwwwwwwwwwwww00"
IF action(1) THEN
l(6) = 5: start(6) = 1        'l(n)=lengh    start-- start from where
s(1) = manname + "：老师，听说那个入口是通往~~另一个世界``的通道，是吗？ss"
s(2) = "老师：^#@?$#x(&^%ss"
s(3) = "老师：我不想回答你的问题。多少年来，那个入口不知出现过多少回，"
s(4) = "      ``但从没有人敢进入其中。千万别到那里去！ss"
s(5) = manname + "：那么可怕....不过我不怕。ss"
s(6) = "老师：不听我的话你要后悔的！！ss"
ELSE
  who = 6
  l(6) = 6: start(6) = 1        'l(n)=lengh    start-- start from where
  s(1) = "老师：同学们，我们来做道算术题。ss"
  s(2) = "老师：花１００元买了一只羊，找回１２０元，ss"
  s(3) = "      ``请问每只羊多少钱？ss"
  s(4) = manname + "：报告！ss"
  s(5) = "老师：啊？！" + manname + "！你又迟到了！ss"
  s(6) = manname + "：啊！....不，不是....我....ss"
  s(7) = "老师：" + manname + "！给我出去罚站！！ss"

END IF
IF NOT action(1) THEN
    mx = 12: my = 2
    toward = "left"
    drawmap
    x = mx * 40 - 40: y = my * 40 - 40
    PUT (x + 1, y + 1), man3, PSET
    rpgsay
    CLS
    PALETTE 15, 0
    COLOR 15
    VIEW PRINT
    LOCATE 12, 30
    PRINT "放学后......"
    FOR i = 1 TO 40 STEP 2
        PALETTE 15, 65535 * i + 256 * i + i
        t = TIMER
        WHILE TIMER - t < .1: WEND
    NEXT
    FOR i = 45 TO 1 STEP -2
        'PALETTE 11, 65535 * i + 256 * i + i
        PALETTE 15, 65535 * i + 256 * i + i
        t = TIMER
        WHILE TIMER - t < .05: WEND
    NEXT
    CLS
    action(1) = true
    map = 5
    loadxy = true
    map5
    loadxy = false
    into = false
END IF
END SUB

SUB room9
map = 5
mapname = "秘密小路"
mx = 2: my = 5
m(1) = "ttttttttttttttt"
m(2) = "t0000000000000t"
m(3) = "t0000000000000t"
m(4) = "tttttttttttt0tt"
m(5) = "t0000000000000e"
m(6) = "tttt0tttttttttt"
m(7) = "t0000000000004t"
m(8) = "ttttttttttttttt"

l(4) = 6: start(4) = 1
s(1) = manname + "：呀！马松，你怎么跑到这里来了？ss"
s(2) = "马松：我正在摘巧克力蛋糕，忽然看见前面有一棵苹果树，"
s(3) = "     ``要知道，木桶小镇已经很多年没有苹果树了。ss"
s(4) = manname + "：然后呢？ss"
s(5) = "马松：我想去摘，可脚下一滑，就掉到这来了。ss"
s(6) = manname + "：我以前怎么没来过这里？？ss"
s(7) = "马松：我们怎么出去呀？？！！ss"
into = true
END SUB

SUB rpgsay
COLOR 3
VIEW PRINT 20 TO 23
sayline = start(who) - 1
FOR saybox = 250 TO 550
    LINE (saybox, 330)-(saybox, 450), 1, B
    LINE (550 - saybox, 330)-(550 - saybox, 450), 1, B
    LINE (saybox - 1, 330)-(saybox - 1, 450), 0, B
    LINE (550 - saybox + 1, 330)-(550 - saybox + 1, 450), 0, B
   
    LINE (saybox, 330)-(550 - saybox, 330), 1, B
    LINE (saybox, 450)-(550 - saybox, 450), 1, B
NEXT
LINE (0, 330)-(550, 450), 0, BF
DO
        COLOR 5
        sayline = sayline + 1
        sayl = LEN(s(sayline))
        PRINT "   ";
        LINE (0, 330)-(550, 450), 1, B
        FOR i = 1 TO sayl - 1 STEP 2
            k$ = MID$(s(sayline), i, 2)
            IF k$ = ":" OR k$ = "：" THEN COLOR 3
            IF LEFT$(k$, 1) = "`" THEN COLOR 3: k$ = ""
            IF LEFT$(k$, 1) = "~" THEN COLOR 10: k$ = ""        '加重
            IF RIGHT$(k$, 1) = "A" OR k$ = "Ａ" THEN act(active) = true: k$ = "": active = false
            IF RIGHT$(k$, 1) = "s" OR k$ = "ｓ" THEN EXIT FOR
            PRINT k$;
            FOR tmp = 0 TO 15000: NEXT       'sayspeed
            IF INKEY$ = CHR$(27) THEN EXIT DO
        NEXT
        PRINT
        LINE (0, 330)-(550, 450), 1, B
        IF sayline / 4 = INT(sayline / 4) OR k$ = "ss" THEN
           y0 = CSRLIN
           COLOR 3
           clk
           DO
             a$ = INKEY$
             LINE (490, 430)-(480, 430), 14
             LINE (480, 430)-(485, 435), 14
             LINE (485, 435)-(490, 430), 14
             PAINT (485, 433), 14
             pal
             IF TIMER - autotime > 2 THEN CALL autorun: autotime = TIMER
           LOOP WHILE a$ = "" OR a$ = up$ OR a$ = down$ OR a$ = lef$ OR a$ = righ$
           LINE (480, 430)-(490, 435), 0, BF
           LOCATE 23, 39: PRINT " "         'NEXT LINE
           LOCATE y0 - 1, 1
        END IF
        LINE (0, 330)-(550, 450), 1, B
'debug
LOOP UNTIL sayline - start(who) >= l(who)
IF k$ <> "ss" THEN FOR i = 1 TO 5: PRINT : NEXT
say = 0
FOR saybox = 550 TO 250 STEP -1
    LINE (saybox, 330)-(saybox, 450), 1, B
    LINE (550 - saybox, 330)-(550 - saybox, 450), 1, B
    LINE (saybox + 1, 330)-(saybox + 1, 450), 0, B
    LINE (550 - saybox - 1, 330)-(550 - saybox - 1, 450), 0, B
  
    LINE (saybox, 330)-(550 - saybox, 330), 1, B
    LINE (saybox, 450)-(550 - saybox, 450), 1, B
NEXT
LINE (0, 330)-(550, 450), 0, BF
clk
VIEW PRINT
END SUB

SUB SaveGame (x, y, mx, my, autotime, runstep)
LOCATE 22, 30: PRINT "等会儿...                   "
OPEN "T1.rpg" FOR OUTPUT AS #1
     PRINT #1, x, y, mx, my, autotime, runstep, into, who, map, whichhouse
     PRINT #1, nextmap
     PRINT #1, toward
     PRINT #1, manname
     FOR i = 1 TO 99
          PRINT #1, action(i), act(i)
     NEXT
     FOR i = 1 TO 50
          PRINT #1, INT(RND * 99), INT(RND * 99), INT(RND * 99), INT(RND * 99)
     NEXT
CLOSE
LOCATE 22, 30: PRINT "存储进度为T1.rpg ...           "
a$ = INPUT$(1)
LOCATE 22, 30: PRINT "                               "
END SUB

SUB sleeping '500,420
'LINE (0, 0)-(10, 0), 15     '  x=10     /=5
'LINE (0, 0)-(5, 5), 15
'LINE (5, 5)-(10, 0), 15
'PAINT (5, 3), 15


END SUB

SUB war STATIC
SCREEN 13
REDIM me(9) AS STRING
hp = 100: mp = 100: hp0 = 100: mp0 = 100
enemyhp = 100
me(1) = "攻击"
me(2) = "魔法"
me(3) = "逃跑"
up$ = CHR$(0) + CHR$(72): down$ = CHR$(0) + CHR$(80)
all = 3
sy = 1
dc = 3
c = 4

CLS
'PUT (50, 100), man4
GOSUB drawman
GOSUB drawmenu
GOSUB drawlife
DO
in$ = INKEY$
IF in$ = up$ AND sy > 1 THEN sy = sy - 1: GOSUB drawmenu
IF in$ = down$ AND sy < all THEN sy = sy + 1: GOSUB drawmenu
IF in$ = CHR$(13) THEN
   IF sy = 3 THEN EXIT DO
END IF
LOOP
SCREEN 12
drawmap
EXIT SUB

drawmenu:
COLOR dc
FOR i = 1 TO all
    LOCATE i, 15
    PRINT me(i)
NEXT
COLOR c
LOCATE sy, 15: PRINT me(sy)
RETURN
drawman:
CIRCLE (20, 83), 7, 4
LINE (7, 95)-(34, 95), 4
LINE (7, 95)-(17, 89), 4
LINE (34, 95)-(25, 89), 4
CIRCLE (220, 90), 20, 2
RETURN
drawlife:
LINE (0, 0)-(hp, 10), 3, BF
LINE (hp, 10)-(hp0, 10), 3, BF
LINE (0, 11)-(hp0, 11), 9, BF
RETURN
    
END SUB

SUB whitesay (say AS STRING)  '旁白
sayl = LEN(say)
VIEW PRINT 20 TO 23
LOCATE 21, 40 - sayl / 2
FOR i = 1 TO sayl - 1 STEP 2
    k$ = MID$(say, i, 2)
    PRINT k$;
    'FOR tmp = 0 TO 15000: NEXT       'sayspeed
    t = TIMER
    WHILE TIMER - t < .01: WEND
NEXT
clk
a$ = INPUT$(1)
LOCATE 21, 1
clr
VIEW PRINT
END SUB

