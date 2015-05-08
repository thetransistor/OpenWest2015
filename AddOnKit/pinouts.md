# OpenWest 2015 Electronic Badge Pinout
Pinouts for the add on kit.

LCD Pin | Propeller IO
--------|--------------
CS | P7
RST | P8
D/C | P9
MOSI | P10
SC | P11
MISO | P21


Misc | Propeller IO
---|---
Backlight | P6
TILT Sensor | P16


SD Card | Propeller IO
---|---
CS | P5
MOSI | P4
MISO | P3
SCK | P21


EEPROM | Propeller IO
---|---
SCL | P28
SDA | P29


Button | Propeller IO
---|---
Up | P0
Down | P1
Left | P27
Right | P26
A | P13
B | P14


## Serial EEPROM Programming / Spin Connection
NOTE: Verify your FTDI is using 3.3v AND 3.3v logic levels!
FTDI Serial | Badge
---|---
RTS | RST
TX | RX
RX | TX
GND | GND