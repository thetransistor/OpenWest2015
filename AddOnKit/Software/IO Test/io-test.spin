{{
////////////////////////////////////////////////////////////////////////////////////////////
//                  io-test.spin
// Test IO Pin Values

// Author: Joe Skeen
// Updated: 2015-5-9
// Designed For: P8X32A (Specifically Open West Conference 2015 Badge)
// Version: 1.0

////////////////////////////////////////////////////////////////////////////////////////////
}}

CON
  _CLKMODE = XTAL1 + PLL16X
  _XINFREQ = 5_000_000

  propTX  = 30 'programming output
  propRX  = 31 'programming input
  baudrate = 57_600

  nRESET= 8
  RS    = 9
  nCS   = 7
  MOSI  = 10
  SCLK  = 11
  MISO  = 12

  cBLUE = $0000F
  cGREEN = $00F00
  cRED = $0F000
  cWHITE = $FFFFF

  pA = 14
  pB = 13
  pLEFT = 0
  pRIGHT = 27
  pUP = 26
  pDOWN = 1

OBJ
  disp  : "ILI9341-spi"
  nums  : "Simple_Numbers"

PUB Main | i, j, k

  disp.Start (nRESET, nCS, RS, MOSI, SCLK)
  TestPins

PUB TestPins | i, x, y, pinval
{{  Monitors and reports the status of each pin.  }}

  disp.SetColours(cGREEN, cWHITE)
  disp.ClearScreen

  disp.DrawStringSmall(0,0,@pins)

  ' draw pin numbers in green
  repeat i from 0 to 31
    x := ((i) / 4 * 40)
    y := ((i) // 4 * 30) + 20
    disp.DrawStringSmall(x, y, nums.decf(i,2))
    waitcnt (cnt + clkfreq / 16)

  disp.SetColours(cBLUE, cWHITE)

  disp.DrawStringSmall(0,220,@footer)

  repeat
    disp.SetColours(cBLUE, cWHITE)
    repeat i from 0 to 31
      pinval := ina[i]
      x := ((i) / 4 * 40) + 20
      y := ((i) // 4 * 30) + 20
      disp.DrawStringSmall(x, y, nums.dec(pinval))
    TestButtons
    waitcnt (cnt + clkfreq / 16)

PUB TestButtons
  SetColorsForButtonOutput(pUP)
  disp.DrawStringSmall(80,140,@up)

  SetColorsForButtonOutput(pDOWN)
  disp.DrawStringSmall(80,180,@down)

  SetColorsForButtonOutput(pLEFT)
  disp.DrawStringSmall(40,160,@left)

  SetColorsForButtonOutput(pRIGHT)
  disp.DrawStringSmall(120,160,@right)

  SetColorsForButtonOutput(pA)
  disp.DrawStringSmall(245,175,@a)

  SetColorsForButtonOutput(pB)
  disp.DrawStringSmall(275,145,@b)

PUB SetColorsForButtonOutput (buttonPin)
  if ina[buttonPin] == 0
    disp.SetColours(cWHITE, cRED)
  else
    disp.SetColours(cBLUE, cWHITE)

DAT
footer      byte  "       Open West Conference 2015        ",0
pins        byte  "PINS",0
up          byte  "U",0
down        byte  "D",0
left        byte  "L",0
right       byte  "R",0
a           byte  "A",0
b           byte  "B",0

{{
////////////////////////////////////////////////////////////////////////////////////////////
//                                TERMS OF USE: MIT License
////////////////////////////////////////////////////////////////////////////////////////////
// Permission is hereby granted, free of charge, to any person obtaining a copy of this 
// software and associated documentation files (the "Software"), to deal in the Software 
// without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
// persons to whom the Software is furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or
// substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
// INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
// PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
// OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER 
// DEALINGS IN THE SOFTWARE.
////////////////////////////////////////////////////////////////////////////////////////////
}}
