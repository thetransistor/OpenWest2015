{{
////////////////////////////////////////////////////////////////////////////////////////////
//                  ILI9341-test.spin
// Test the ILI9341-spi.spin driver

// Author: Mark Tillotson
// Updated: 2013-11-16
// Designed For: P8X32A
// Version: 1.0

// Tested eBay 2.2" 320x240 TFT module using ILI9341 SPI driver.
// for instance: 
//    http://www.ebay.co.uk/itm/1PC-22-Inch-SPI-TFT-LCD-Serial-Port-Module-Display-ILI9341-5V33V-New-/380708838265

// Update History:

// v1.0 - Initial version 2013-11-16

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
  
  pA    = 14
  pB    = 13
  pU    = 26
  pD    = 1
  pL    = 0
  pR    = 27

OBJ
  disp  : "ILI9341-spi"
  'pin   : "Input Output Pins"

VAR
  BYTE buffer[100] 'buffer to assemble output strings

PUB Main | i, j, k

  dira[pA] := 0
  dira[pB] := 0
  dira[pU] := 0
  dira[pD] := 0
  dira[pL] := 0
  dira[pR] := 0

  disp.Start (nRESET, nCS, RS, MOSI, SCLK)

  disp.SetColours ($F800, $07F0)
  disp.ClearScreen

  repeat
    if ina[pA]
      disp.DrawChar (32, 32, "A")
    else
      disp.DrawChar (32, 32, " ")
    if ina[pB]
      disp.DrawChar (64, 32, "B")
    else
      disp.DrawChar (64, 32, " ")
    if ina[pU]
      disp.DrawChar (96, 32, "U")
    else
      disp.DrawChar (96, 32, " ")
    if ina[pD]
      disp.DrawChar (128, 32, "D")
    else
      disp.DrawChar (128, 32, " ")
    if ina[pL]
      disp.DrawChar (160, 32, "L")
    else
      disp.DrawChar (160, 32, " ")
    if ina[pR]
      disp.DrawChar (192, 32, "R")
    else
      disp.DrawChar (192, 32, " ")
        
    'waitcnt (cnt + clkfreq)

DAT
stringa       byte  "A",0
stringb       byte  "B",0
stringu       byte  "U",0
stringd       byte  "D",0
stringl       byte  "L",0
stringr       byte  "R",0
stringy       byte  "Test string",0
stringy2      byte  "The quick brown fox jumps over the lazy ",0

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