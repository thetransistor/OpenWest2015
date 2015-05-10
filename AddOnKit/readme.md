#How To Hack The Add On#
The add on kit is a [Propeller](http://en.wikipedia.org/wiki/Parallax_Propeller) environment with 6 buttons,
a display, and an SD card. There is an EEPROM bootloader that looks on the SD card and loads the program named run.bin.

##Using the Bitmap Loader##
The bitmap loader program is found under Software/BMP Loader.  It will cycle through two bitmaps it finds
on the SD card.  It will first load default.bmp, then 1.bmp, the back to default.bmp, then 1.bmp, etc, ad nauseum.

To run it, copy all of the contents of Software/BMP Loader to the SD card.

Some notes about creating your own bitmap:
- The badge add on kit is designed to be played while the badge is still around your neck, so when it's hanging the screen is upside down. If you want the bitmaps to be viewed right side up as you walk around, the bitmaps must be flipped both vertically and horizontally.
- The software is pretty picky about the bitmap format. I was successful with exporting the bitmap from GIMP with _**Do not write color space information**_ set and Advanced options set to _**24 bits R8 G8 B8**_

##Using the Button Test##
The button test program shows a letter on the screen for each button.  When a button is pressed the letter corresponding to the button disappears. Use the run.bin file to load the program onto your SD card and run it. Use the spin files to see and modify the source.

##Writing Your Own Code##
- Go get [Propeller IDE](http://developer.parallax.com/projects/propelleride/).
- Write a program in Spin
  - [Intro to Spin programming language](http://letsmakerobots.com/node/18214)
  - [Propeller Spin Tutorials](http://learn.parallax.com/propeller-spin-tutorials)
  - [Helpful Propeller Instructable](http://www.instructables.com/id/Programming-the-Propeller-Microcontroller/)
  - [Badge Spin Example](https://github.com/thetransistor/OpenWest2015/tree/master/AddOnKit/Software)
- Build the program in the IDE
- Rename the binary to run.bin
- Put the binary on the SD card
- Profit!!!
