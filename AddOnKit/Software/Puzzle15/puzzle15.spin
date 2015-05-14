{{

15 Sliding Puzzle 15 game. Designed for the upgraded badge from the OpenWest 2015 Conference

Author: Michael Peters

Totally open license, you may use this code however you wish, but I'm not responsible for your actions.

}}

CON
  _CLKMODE = XTAL1 + PLL16X
  _XINFREQ = 5_000_000

  nRESET= 8
  RS    = 9
  nCS   = 7
  MOSI  = 10
  SCLK  = 11
  MISO  = 12

  PAD_U = 26
  PAD_D = 1
  PAD_R = 27
  PAD_L = 0
  PAD_A = 13
  PAD_B = 14

  GRID_STARTX = 60
  GRID_STARTY = 20
  GRID_SIZE = 50
  GRID_BORDER = 3
  GRID_PADDING = 3

OBJ
  disp  : "ILI9341-spi"

VAR

  ' What number is in each square
  BYTE squares[16]
  ' Which space is blank
  BYTE blank
  ' TRUE if game is in progress
  BYTE game_in_progress
  ' How many moves have been performed since last scramble
  WORD moves
  ' Used to prevent multiple button pushes registering when holding button
  BYTE antibounce
  ' Used for formatting integers into decimal strings
  BYTE decimalString[4]

PUB Main

  ' Set up screen
  disp.Start (nRESET, nCS, RS, MOSI, SCLK)
  disp.SetColours($ffff, $0)
  disp.ClearScreen

  ' Set buttons as inputs
  DIRA[PAD_U] := 0
  DIRA[PAD_D] := 0
  DIRA[PAD_L] := 0
  DIRA[PAD_R] := 0
  DIRA[PAD_A] := 0
  DIRA[PAD_B] := 0

  ' Scramble board
  Scramble

  repeat
    CheckForInput
    waitcnt (cnt + clkfreq/128)

PUB CheckForInput
  ' Check for input on buttons. Probably not the best way to do this.
  if INA[PAD_U] == 0
    Move(PAD_U)
  elseif INA[PAD_D] == 0
    Move(PAD_D)
  elseif INA[PAD_L] == 0
    Move(PAD_L)
  elseif INA[PAD_R] == 0
    Move(PAD_R)
  elseif INA[PAD_A] == 0 OR INA[PAD_B] == 0
    Scramble
  else
    antibounce := 0

PUB DrawGrid | i
  disp.SetColours($0, $0)
  disp.DrawRect(GRID_STARTX,GRID_STARTY,GRID_STARTX+GRID_SIZE*4,GRID_STARTY+GRID_SIZE*4)

  repeat i from 0 to 15
    DrawSquare(i)

  DrawMoves

PUB DrawSquare (num) | i,j,x1,x2,y1,y2
  i := num & 3
  j := num >> 2

  disp.SetColours(word[@colors][squares[num]],$0)
  ' This looks like overkill, but it only redraws the pixels necesarry, which speeds up drawing and reduces flickering.
  'Left
  x1 := GRID_STARTX + i * GRID_SIZE + GRID_PADDING
  x2 := GRID_STARTX + i * GRID_SIZE + GRID_PADDING + GRID_BORDER
  y1 := GRID_STARTY + j * GRID_SIZE + GRID_PADDING
  y2 := GRID_STARTY + (j+1) * GRID_SIZE - GRID_PADDING
  disp.DrawRect(x1,y1,x2,y2)
  'Right
  x1 := GRID_STARTX + (i+1) * GRID_SIZE - GRID_PADDING - GRID_BORDER
  x2 := GRID_STARTX + (i+1) * GRID_SIZE - GRID_PADDING
  y1 := GRID_STARTY + j * GRID_SIZE + GRID_PADDING
  y2 := GRID_STARTY + (j+1) * GRID_SIZE - GRID_PADDING
  disp.DrawRect(x1,y1,x2,y2)
 'Top
  x1 := GRID_STARTX + i * GRID_SIZE + GRID_PADDING + GRID_BORDER
  x2 := GRID_STARTX + (i+1) * GRID_SIZE - GRID_PADDING - GRID_BORDER
  y1 := GRID_STARTY + j * GRID_SIZE + GRID_PADDING
  y2 := GRID_STARTY + j * GRID_SIZE + GRID_PADDING + GRID_BORDER
  disp.DrawRect(x1,y1,x2,y2)
 'Bottom
  x1 := GRID_STARTX + i * GRID_SIZE + GRID_PADDING + GRID_BORDER
  x2 := GRID_STARTX + (i+1) * GRID_SIZE - GRID_PADDING - GRID_BORDER
  y1 := GRID_STARTY + (j+1) * GRID_SIZE - GRID_PADDING - GRID_BORDER
  y2 := GRID_STARTY + (j+1) * GRID_SIZE - GRID_PADDING
  disp.DrawRect(x1,y1,x2,y2)

  ' For single digits, center the number (Square 9 is "10")
  if squares[num] < 9
    disp.DrawString(i*GRID_SIZE+GRID_STARTX+18,j*GRID_SIZE+GRID_STARTY+9, integerToDecimal(squares[num]+1,1))
  else
    ' For double digit numbers
    disp.DrawString(i*GRID_SIZE+GRID_STARTX+9,j*GRID_SIZE+GRID_STARTY+9, integerToDecimal(squares[num]+1,2))

PUB DrawMoves
  disp.SetColours($ffff,$0)

  disp.DrawStringSmall(320-42,240-18,integerToDecimal(moves,4))

PUB Move (dir)

  if antibounce == 1
    return
  antibounce := 1

  ifnot game_in_progress
    return

  if dir == PAD_D
    if blank =< 3
      return
    Swap(blank-4)
  elseif dir == PAD_U
    if blank => 12
      return
    Swap(blank+4)
  elseif dir == PAD_R
    if blank//4 == 0
      return
    Swap(blank-1)
  elseif dir == PAD_L
    if blank//4 == 3
      return
    Swap(blank+1)

  CheckVictory

PUB Swap (toswap) | tmp
  ' Swap value of blank and toswap in the squares array
  tmp := squares[toswap]
  squares[toswap] := squares[blank]
  squares[blank] := tmp

  ' Redraw squares that changed
  DrawSquare(blank)
  DrawSquare(toswap)

  ' Store the new blank square
  blank := toswap

  ' Increment move counter
  moves++
  DrawMoves

PUB CheckVictory | i
  repeat i from 0 to 15
    if i <> squares[i]
      return

  disp.DrawString(GRID_STARTX+70, GRID_STARTY+80,string("Win!"))
  disp.DrawStringSmall(GRID_STARTX+50, GRID_STARTY+110,string("Press A or B "))
  disp.DrawStringSmall(GRID_STARTX+50, GRID_STARTY+126,string("to play again"))
  game_in_progress := FALSE

PUB Scramble | i,j,k,random,tmp

  if antibounce == 1
    return
  antibounce := 1

  ' Initialize numbers
  repeat i from 0 to 15
    squares[i] := i
  blank := 15

  ' You can always three-way swap tiles and the puzzle will still be solvable. We will
  ' 3 way swap 100 times.
  ' Get a random seed from cnt
  random := cnt?
  repeat 100
    ' Pick three random tiles between 0 and 14 (we don't want to swap the empty tile)
    i := ||(random?//15)
    repeat
      j := ||(random?//15)
    until i <> j
    repeat
      k := ||(random?//15)
    until k <> i AND k <> j

    ' Three way swap them
    tmp        := squares[i]
    squares[i] := squares[j]
    squares[j] := squares[k]
    squares[k] := tmp

  moves := 0
  game_in_progress := TRUE

  DrawGrid


PUB integerToDecimal(number, length)
' Modified from
' http://obex.parallax.com/sites/default/files/obj/id/579/ASCII0_STREngine_1.spin

  length := (4 - ((length <# 4) #> 0))

  repeat result from 3 to 0
    decimalString[result] := ((||(number // 10)) + "0")
    number /= 10

  return @decimalString[length]

DAT
' Colors    1      2      3      4      5      6      7      8      9      10     11     12     13     14     15     blank
colors word $001f, $0391, $04eb, $07e0, $6033, $1012, $0622, $bfe0, $a82a, $a000, $f7a0, $e7e0, $f800, $fbe0, $fea0, $0000
