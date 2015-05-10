{{
////////////////////////////////////////////////////////////////////////////////////////////

// Author: Mark Tillotson
// Updated: 2013-11-15
// Designed For: P8X32A
// Version: 1.0

// Provides

// PUB  Stop

// PUB  Start (nRES, nCS, RS, MOSI, SCLK)
// pin numbers for nRESET, nCS, RS, MOSI and SCLK

// PUB  Synch
// wait for previous command to finish, normally you don't need to call this

// PUB  SetColours (fore, back)
// Colours are 16 bit, RRRRRGGGGGGBBBBB (5, 6, 5 bits per colour)
// foreground colour used for drawing generally, background for clearing screen and character backgrounds

// PUB  ClearScreen

// PUB  DrawDot (xl, yt)

// PUB  DrawLine (xl, yt, xr, yb)

// PUB  DrawChar (xl, yt, chr)
// coords of top-left, used Prop font (16x32 pixels)

// PUB  DrawCharSmall (xl, yt, chr)
// shrunk Prop font, 8x16 pixels

// PUB  DrawString (xl, yt, str)
// null terminated byte string in hub memory

// PUB  DrawStringSmall (xl, yt, str)

// PUB  DrawRect (xl, yt, xr, yb)
// Note you must ensure xl <= xr, yt <= yb else it will hang


// ToDo:   Allow setting up in portrait or landscape mode (currently landscape mode)


// See end of file for standard MIT licence / terms of use.

// Update History:

// v1.0 - Initial version 2013-11-15

////////////////////////////////////////////////////////////////////////////////////////////
}}

CON
  CMD_SETUP = 1
  CMD_SETCOLOURS = 2

  CMD_RECT    = 4
  CMD_CLEAR   = 5
  CMD_LINE    = 6
  CMD_STRING  = 7
  CMD_CHAR    = 8
  CMD_DOT     = 9
  CMD_SendBMP = 10 
  CMD_BMPinf  = 11
  
VAR
  long  cog

  long  cmd
  long  arg0
  long  arg1
  long  guard
  long  arg2
  long  arg3

  
PUB  Stop
  if cog <> 0
    cogstop (cog-1)
  cog := 0

PUB  Start (nRES, nCS, RS, MOSI, SCLK) | mask
  Stop
  cmd := CMD_SETUP

  mos:=mosi
  sck:=sclk
  
  nCSmask := 1 << nCS
  RSmask  := 1 << RS
  MOSImask := 1 << MOSI
  SCLKmask := 1 << SCLK
  nRESmask := 1 << nRES

  IF_IDLE := nRESmask | nCSmask | SCLKmask

  arg0 := @init_data

  cog := 1 + cognew (@entry, @cmd)
  if cog <> 0
    Synch
  result := cog


PUB  Synch
  repeat until cmd == 0

PUB  ClearScreen
  Synch
  cmd := CMD_CLEAR

PUB  DrawDot (xl, yt)
  Synch
  arg0 := xl << 16 | yt
  cmd := CMD_DOT

PUB  DrawLine (xl, yt, xr, yb)
  Synch
  arg0 := xl << 16 | yt
  arg1 := xr << 16 | yb
  cmd := CMD_LINE

PUB  DrawChar (xl, yt, chr)
  Synch
  arg0 := xl << 16 | yt
  arg1 := chr & $FF
  cmd := CMD_CHAR

PUB  DrawCharSmall (xl, yt, chr)
  Synch
  arg0 := xl << 16 | yt
  arg1 := chr | $100
  cmd := CMD_CHAR

PUB  DrawString (xl, yt, str)
  Synch
  arg0 := xl << 16 | yt
  arg1 := str
  cmd := CMD_STRING

PUB  DrawStringSmall (xl, yt, str)
  Synch
  arg0 := xl << 16 | yt
  arg1 := -str
  cmd := CMD_STRING

PUB  DrawRect (xl, yt, xr, yb)
  Synch
  arg0 := xl << 16 | yt
  arg1 := xr << 16 | yb
  cmd := CMD_RECT

PUB  SetColours (fore, back)
  Synch
  arg0 := (back << 16) | (fore & $ffff)
  cmd := CMD_SETCOLOURS
 
PUB  SendBMP (puntero,len)
  Synch
  arg0 := puntero
  arg1 := len

  cmd := CMD_SendBMP
  
PUB  BMPinf(x,y,lex,ley)
  Synch
  arg0 := x << 16 | y 
  arg1 := lex << 16 | ley 
  arg2 :=4-((lex*3)//4)
  if arg2==4
    arg2:=0
  arg3:=lex*ley
      
  cmd := CMD_BMPinf

DAT

init_data       long    $0A010100 ' software reset   del cnt reg arg0
                long    $00CB0539, $0234002C
                long    $00CF0300, $30C1
                long    $00E80385, $7800
                long    $00EA0200, $00
                long    $00ED0464, $811203
                long    $00F70120
                long    $00C00123
                long    $00C10110
                long    $00C5023E, $28
                long    $00C70186
                long    $00360128       ' if orient & 1, 28 else 08
                long    $003A0155
                long    $00B10200, $18
                long    $00B60308, $2782 ' 3: 82, 6: C2, 9: E2, 12: A2
                long    $00F20100
                long    $00260101
                long    $00E00F0F, $0E0C2B31, $37F14E08, $0E031007, $0009
                long    $00E10F00, $1103140E, $48C13107, $310C0F08, $0F36
                long    $80110000
                long    $00290000
                long    $002C0000

                long    0


DAT

                ORG     0

entry           mov     parm, PAR
                rdlong  op, parm        ' can assume is setup
                add     parm, #4
                rdlong  ptr, parm

                mov     OUTA, IF_IDLE
                mov     DIRA, IF_IDLE
                or      DIRA, RSmask
                or      DIRA, MOSImask
                
                mov     delaycount, #1
                call    #del_millis
                andn    outa, SCLKmask

                andn    OUTA, nRESmask  
                mov     delaycount, #2
                call    #del_millis
                or      OUTA, nRESmask
                mov     delaycount, #25
                call    #del_millis

                mov     ctra,mos            
                movi    ctra,#%0_00100_000  
                mov     ctrb,sck            
                movi    ctrb,#%0_00100_000  

:init_loop      rdlong  t, ptr  wz      ' format of init command is dddddddd rrrrrrrr nnnnnnnn aaaaaaaa
        if_z    jmp     #command_return
                add     ptr, #4

                mov     regaddr, t
                shr     regaddr, #16
                and     regaddr, #$FF
                mov     delaycount, t
                shr     delaycount, #24
                mov     reps, t
                shr     reps, #8
                and     reps, #$FF
                mov     reg_val, t
                and     reg_val, #$FF

                call    #set_ind        ' uses regaddr
:init_arg_loop
                cmp     reps, #0  wz
        if_z    jmp     #:done_args
:process_arg    call    #write_data     ' reg_val

                rdbyte  reg_val, ptr
                add     ptr, #1         ' one excess add at the end
                djnz    reps, #:process_arg


:done_args
                add     ptr, #2         ' force long alignment
                andn    ptr, #3

                cmp     delaycount, #0  wz
        if_nz   call    #del_millis

                jmp     #:init_loop


{{ --------------------------------------------------------------- }}

del_millis      mov     time, CNT
                add     time, MSdelay
                waitcnt time, #0
                djnz    delaycount, #del_millis
del_millis_ret  ret


{{ --------------------------------------------------------------- }}


command_return  wrlong  zero, PAR

command_loop    rdlong  op, PAR  wz
        if_z    jmp     #command_loop
                call    #read_args

                cmp     op, #CMD_SendBMP  wz
        if_nz   jmp     #:done_sdata
                call    #sdata
                jmp     #command_return
                
:done_sdata     cmp     op, #CMD_SETCOLOURS  wz
        if_nz   jmp     #:done_setcolours
                mov     foreground, y0
                mov     background, x0
                jmp     #command_return

:done_setcolours
                cmp     op, #CMD_CLEAR  wz
        if_nz   jmp     #:done_clear
                mov     t, foreground
                mov     foreground, background
                mov     x0, #0
                mov     x1, #319
                mov     y0, #0
                mov     y1, #239
                call    #draw_rect
                mov     foreground, t
                jmp     #command_return

:done_clear     cmp     op, #CMD_RECT  wz
        if_nz   jmp     #:done_rect

                call    #draw_rect
                jmp     #command_return

:done_rect      cmp     op, #CMD_LINE  wz
        if_nz   jmp     #:done_line

                call    #draw_line
                jmp     #command_return


:done_line      cmp     op, #CMD_STRING  wz
        if_nz   jmp     #:done_string

                mov     strp, t2

                cmps    strp, #0  wc
        if_c    neg     strp, strp
                rcl     t, #1
                call    #draw_string
                
                jmp     #command_return

:done_string    cmp     op, #CMD_CHAR  wz
        if_nz   jmp     #:done_char

                mov     char, t2

                test    char, #$100  wz
        if_z    jmp     #:normal
                and     char, #$FF
                call    #glyph_sm
                jmp     #command_return
:normal         call    #glyph
                jmp     #command_return


:done_char      cmp     op, #CMD_DOT  wz
        if_nz   jmp     #:done_info
                call    #dot
                jmp     #command_return

:done_info      cmp     op, #CMD_BMPinf  wz
        if_nz   jmp     #command_return
                call    #infoB              
                jmp     #command_return

sdata           mov     punt, t
                mov     background,  HFFFF

                mov     col, rx
                mov     row, trow               
                
:leo            mov     leng,punt
                sub     leng,t
                cmp     leng, t2   wz
         if_z   jmp     #salida

                cmp     ind, ext  wz
         if_z   jmp     #salida

                rdbyte  foreground, punt
                add     punt, #1
                
                rdbyte  g, punt
                add     punt, #1
                
                rdbyte  r, punt
                add     punt, #1
 
                shr     foreground,#3
                shr     g,#2
                shr     r,#3

                shl     g,#5
                shl     r,#11

                or      foreground,  g
                or      foreground,  r
               
                call    #move_to
                mov     regaddr, #$2C   ' RAM_ADDR
                mov     reg_val, foreground
                call    #write_reg16

                add     col, #1

                add     ind, #1
               
                cmp     col,lx   wz
        if_nz   jmp     #:leo

                mov     col, tcol
                sub     row,#1
                add     punt, nn
              
                jmp     #:leo
                
salida
                mov     rx, col
                mov     trow, row
                
sdata_ret       ret
                
infoB           mov     lx, t2
                shr     lx, #16
     
                mov     tcol, x0
                mov     trow, y0
                mov     rx, tcol

                mov     ind,#0

                mov     nn, t3
                shr     nn, #16
                mov     ext, t4

                add     lx, tcol 
                             
infoB_ret       ret

read_args       rdlong  t, parm
                add     parm, #4
                rdlong  t2, parm
                add     parm, #8
                rdlong  t3, parm
                add     parm, #4
                rdlong  t4, parm
                
                sub     parm, #16
                mov     x0, t
                shr     x0, #16
                mov     y0, t
                and     y0, HFFFF
                mov     x1, t2
                shr     x1, #16
                mov     y1, t2
                and     y1, HFFFF              
                mov     col, x0
                mov     row, y0
read_args_ret   ret



{ ------------------------------------------------------ }

draw_rect       mov     col, x0
                mov     row, y0
                mov     rcount, y1
                sub     rcount, y0
                add     rcount, #1

:rloop          call    #move_to
                call    #start_ram
                mov     reg_val, foreground
                mov     icount, x1
                sub     icount, x0
                add     icount, #1

:iloop          call    #wr_ram
                djnz    icount, #:iloop

                call    #stop_ram
                add     row, #1
                djnz    rcount, #:rloop
draw_rect_ret   ret


{ ------------------------------------------------------ }

draw_line       mov     dx, x1
                sub     dx, x0
                abs     dx, dx
                shl     dx, #8

                mov     dy, y1
                sub     dy, y0
                abs     dy, dy
                shl     dy, #8

                cmp     x0, x1  wc
                mov     xstep, #1
        if_nc   neg     xstep, xstep

                cmp     y0, y1  wc
                mov     ystep, #1
        if_nc   neg     ystep, ystep

                mov     row, y0
                mov     col, x0
                cmp     dx, dy  wc
        if_nc   jmp     #xdir

ydir            neg     t, dy
                sar     t, #1
:loop
                call    #dot
                cmp     row, y1  wz
        if_z    jmp     #draw_line_ret
                add     row, ystep
                add     t, dx  wc
        if_nc   jmp     #:loop
                add     col, xstep
                sub     t, dy
                jmp     #:loop

xdir            neg     t, dx
                sar     t, #1
:loop
                call    #dot
                cmp     col, x1  wz
        if_z    jmp     #draw_line_ret
                add     col, xstep
                add     t, dy  wc
        if_nc   jmp     #:loop
                add     row, ystep
                sub     t, dx
                jmp     #:loop
  
draw_line_ret   ret


dot             cmp     col, #320  wc,wz  ' these assume landscape mode
        if_ae   jmp     #dot_ret
                cmp     row, #240  wc,wz
        if_ae   jmp     #dot_ret

                call    #move_to

:skip_row       mov     regaddr, #$2C   ' RAM_ADDR
                mov     reg_val, foreground
                call    #write_reg16

dot_ret         ret



{ ------------------------------------------------------ }

draw_string     rdbyte  char, strp  wz
        if_z    jmp     #draw_string_ret
                add     strp, #1
                test    t, #1  wz
        if_z    call    #glyph
                test    t, #1  wz
        if_nz   call    #glyph_sm
                jmp     #draw_string
draw_string_ret ret


{ ------------------------------------------------------ }

get_patt        rdlong  pattern, gaddr          ' read long from Prop font data
                add     gaddr, #4
                test    char, #1  wz            ' deal with interleaving
        if_nz   shr     pattern, #1
get_patt_ret    ret

{ ------------------------------------------------------ }

glyph_setup     mov     gaddr, char         ' calculate address of first long in Prop font entry for char
                and     gaddr, #$FF
                shr     gaddr, #1
                or      gaddr, #$100        ' $8000 is base of font, $100 shifted left by 7
                shl     gaddr, #7           ' 32 longs = 2^7 bytes per font entry
glyph_setup_ret ret

{ ------------------------------------------------------ }

glyph           call    #glyph_setup

                mov     linecount, #32

:loop           call    #move_to
                add     row, #1

                call    #start_ram

                call    #get_patt       ' get pattern
                mov     icount, #16

:iloop          shr     pattern, #2  wc
        if_c    mov     reg_val, foreground
        if_nc   mov     reg_val, background
                call    #wr_ram
                djnz    icount, #:iloop

                djnz    linecount, #:loop

                sub     row, #32        ' move to next char position
                add     col, #16
glyph_ret       ret

{ ------------------------------------------------------ }

glyph_sm        call    #glyph_setup

                mov     linecount, #16

:loop           call    #move_to
                add     row, #1
                call    #start_ram

                call    #get_patt       ' get pattern
                add     gaddr, #4

                and     pattern, H11111111 ' get every other bit from our char to shrink it
                mov     t2, pattern
                shl     t2, #2
                or      pattern, t2     ' duplicate the bit 

                mov     icount, #8

:iloop          shr     pattern, #4  wc
        if_c    mov     reg_val, foreground
        if_nc   mov     reg_val, background
                call    #wr_ram
                djnz    icount, #:iloop

                call    #stop_ram

                djnz    linecount, #:loop

                sub     row, #16        ' move to next char position
                add     col, #8
glyph_sm_ret    ret

{ ------------------------------------------------------ }

set_ind         andn    OUTA, RSmask

                andn    OUTA, nCSmask
                mov     dval, regaddr
                call    #spi8
                or      OUTA, nCSmask

                or      OUTA, RSmask
set_ind_ret     ret

{ ------------------------------------------------------ }

write_reg16     call    #set_ind
                andn    OUTA, nCSmask
                mov     dval, reg_val
                call    #spi16
                or      OUTA, nCSmask
write_reg16_ret ret


{ ------------------------------------------------------ }

write_data      andn    OUTA, nCSmask
                mov     dval, reg_val
                call    #spi8
                or      OUTA, nCSmask
write_data_ret  ret
{ ------------------------------------------------------ }

write_data16    andn    OUTA, nCSmask
                mov     dval, reg_val
                call    #spi16
                or      OUTA, nCSmask
write_data16_ret ret


{ ------------------------------------------------------ }

move_to         mov     regaddr, #$2A  ' COL_ADDR  swap $06 and $07 for portrait mode
                mov     reg_val, col
                call    #write_reg16
                mov     reg_val, #320
                call    #write_data16

                mov     regaddr, #$2B   ' ROW_ADDR
                mov     reg_val, row
                call    #write_reg16
                mov     reg_val, #320
                call    #write_data16
:skip_row
move_to_ret     ret


{ ------------------------------------------------------ }

start_ram       mov     regaddr, #$2C    ' RAM_ADDR
                call    #set_ind
                andn    OUTA, nCSmask
                nop
                or      OUTA, RSmask
start_ram_ret   ret

{ ------------------------------------------------------ }

wr_ram          mov     dval, reg_val
                call    #spi16
wr_ram_ret      ret

{ ------------------------------------------------------ }

stop_ram        andn    OUTA, RSmask
                or      OUTA, nCSmask
stop_ram_ret    ret

{ ------------------------------------------------------ }


{ ------------------------------------------------------ }
spi8            
                mov     phsa, dval          
              
                shl     phsa, #24
            {{    mov     asd,  #7                  
                movi    phsb, #%011000000         
                movi    frqb, #%001000000   
:bit_shift_loop
                shl     phsa, #1             
                djnz    asd,  #:bit_shift_loop 
                mov     frqb, #0             
                           }}
        movi phsb,#%000000000   ' set up my clock register        
        movi frqb,#%010000000   ' start my clock line ticking!
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        mov frqb,#0 
spi8_ret        ret

spi16           mov     phsa, dval          
               
                shl     phsa, #16
        {{        mov     asd,  #15                      
                movi    phsb, #%011000000            
                movi    frqb, #%001000000   
:bit_shift_loop
                shl     phsa, #1             
                djnz    asd,  #:bit_shift_loop 
                mov     frqb, #0          
                 }}
        movi phsb,#%000000000   ' set up my clock register        
        movi frqb,#%010000000   ' start my clock line ticking!
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        shl phsa,#1             ' move next bit into the PHSA[31] slot
        mov frqb,#0 

spi16_ret       ret


{ ------------------------------------------------------ }

                       
ext             long    10000
asd             long    1
foreground      long    $FFFF
background      long    $0000

MSdelay         long    100_000

zero            long    0

HFFFF           long    $FFFF
H8000           long    $8000
H11111111       long    $11111111

mos             long    0
sck             long    0
nCSmask         long    0
RSmask          long    0
MOSImask        long    0
SCLKmask        long    0
nRESmask        long    0

IF_IDLE         long    0

ind             res     1
larg            res     1
rx              res     1

parm            res     1
op              res     1
arg             res     1
reps            res     1

delaycount      res     1

time            res     1


icount          res     1
bitcount        res     1
rcount          res     1

regaddr         res     1
reg_val         res     1
dval            res     1
t               res     1
t2              res     1
t3              res     1
t4              res     1

ptr             res     1
char            res     1
r             res     1
g             res     1
'b             res     1 

tcol            res     1
trow            res     1
leng            res     1         
punt            res     1         
col             res     1
row             res     1
gaddr           res     1
linecount       res     1
pattern         res     1
strp            res     1
left            res     1
right           res     1
lout            res     1
rout            res     1
expand          res     1

old_col         res     1
old_row         res     1

lx              res     1
'ly              res     1
x0              res     1
y0              res     1
xx              res     1
yy              res     1
x1              res     1
y1              res     1
xstep           res     1
ystep           res     1
dx              res     1
dy              res     1
'nx              res     1 
nn              res     1 


                
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