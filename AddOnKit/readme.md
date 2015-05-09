#How To Hack The Add On#
The add on kit is a [Propeller](http://en.wikipedia.org/wiki/Parallax_Propeller) environment with 6 buttons,
a display, and an SD card. There is an EEPROM bootloader that looks on the SD card and loads the program named run.bin.

##Using the Bitmap Loader##
The bitmap loader program is found under Software/BMP Loader.  It will cycle through bitmaps it finds
on the SD card.  It will first load default.bmp, then 1.bmp, and assume will keep going through higher numbers.

To run it, copy all of the contents of Software/BMP Loader to the SD card.

Some notes about creating your own bitmap:
- The badge add on kit is designed to be played while the badge is still around your neck, so when it's hanging the screen is upside down. If you want the bitmaps to be viewed right side up as you walk around, the bitmaps must be flipped both vertically and horizontally.
- The software is pretty picky about the bitmap format. I was successful with exporting the bitmap from GIMP with _**Do not write color space information**_ set and Advanced options set to _**24 bits R8 G8 B8**_
