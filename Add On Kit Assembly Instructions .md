# OpenWest 2015 Electronic Badge Add-On Kit
Assembly Instructions
(Adapted from original instructions created by Compukidmike)

## Step 1: Identify Parts
Step 1: Identify Parts
You should have the following parts in your kit:
(2) Button Boards
(1) [2.2” Color LCD](http://www.adafruit.com/datasheets/ILI9341.pdf)
(1) [Propeller Microcontroller](https://www.parallax.com/product/p8x32a-d40)
(1) 40 Pin Socket
(6) Tactile Buttons
(1) Slide Switch
(1) Tilt Switch
(2) 0.1uF Capacitors (in the white packaging)
(2) 1uF Capacitors (in the clear packaging)
(10) 10K Ohm Resistors
(2) 10 Ohm Resistors
(1) Voltage Regulator
(1) Mosfet
(1) 5 MHZ Crystal
(1) EEPROM
(1) Micro SD Card
(1) SD Card Adapter
(1) Pin Strip

If you are missing parts, please let us know. 
![Step One Image](/images/instructions/addon_step1.jpg)

NOTE: The surface mount parts come in a plastic or paper tray with a thin plastic film
over them. You will need to peel this plastic off to get the parts out. BE CAREFUL
when doing this as these small parts tend to go flying everywhere.

NOTE: The easiest way to solder surface mount parts is to first put solder on one of
the pads on the board. Then, while holding the soldering iron on that pad to keep the
solder melted, use the tweezers to place the part onto the board. You can then solder
the other side of the part.

## Step 2: Voltage Regulator
- Flip the board over to the back. 
- Locate the marking for VR1. This is where the Voltage Regulator goes. Be sure that the three pins on the bottom are not shorted together after soldering. This is by far the hardest part to solder on the board.

![Step Two Image](/images/instructions/addon_step2.jpg)

## Step 3: Capacitors
- There are TWO DIFFERENT types of capacitors in this kit, but they look identical. Only open one type at a time.
- The capacitors and resistors are easy to confuse because they are the same size. The resistors are black with white numbers, while the capacitors are brown and unmarked.
- First, locate the two 1uF capacitors. They are in a CLEAR plastic strip. Place them on C9 and C10 (next to the voltage regulator from the previous step).
- Next, locate the two 0.1uF capacitors. They are in a WHITE paper strip. Place them on C7 and C8 (middle of the board).

![Step Three Image](/images/instructions/addon_step3.jpg)

## Step 4: Resistors
- There are TWO DIFFERENT values of resistors.
- The strip of 10 resistors are 10K Ohms (Labeled 103 on the resistors).
- The strip of 2 resistors are 10 Ohms. (Labeled 100 on the resistors)
- Place the ten 10K resistors on R1-R10.
- Place the two 10 Ohm resistors on R11-R12.

![Step Four Image](/images/instructions/addon_step4.jpg)

## Step 5: Mosfet, Crystal and Switch
- Locate Q1 and place the mosfet there.
- The Crystal goes on Y1.
- Then solder the slide switch on S3.

![Step Five Image](/images/instructions/addon_step5.jpg)

## Step 6: Tilt Switch, EEPROM and Socket
- Place the tilt switch on the front of the board. There are four small marks that show the outline of the switch. Make sure it lines up with the marks, and then solder the switch.
- Next, place the EEPROM. The orientation on this chip is opposite from the ATTiny85 microcontroller from the base kit. The pin 1 marking goes on the top right corner. This chip also has a half-circle shaped dimple on one side of the chip. This should face towards the right side of the board.
- Then place the 40 pin socket on the front of the board. There is a dimple on one side of the socket. Align this with the mark on the board (it should face towards the right side of the board).

![Step Six Image](/images/instructions/addon_step6.jpg)

## Step 7: LCD
- The LCD is tricky. The first thing to note is that the display only has pins on one side. You will need to cut 4 of the pins from the pin strip to put on the display. DON’T solder them to the display yet!
- While holding the pins in place on the display, put the display in place on the front of the board.
- Carefully flip the board over and solder the first pin on the right side of the board (the pad on the board is square shaped).
- Now you need to check that the display is parallel to the front of the board. It tends to not lay flat due to the SD card socket on the back. One way to fix it is to gently squeeze the board and display where the SD card is located, while at the same time re-heating the solder joint on the first pin. When the solder melts, the screen will ‘snap’ into the correct position.
- You can then solder the rest of the pins.

![Step Seven Image](/images/instructions/addon_step7.jpg)

##Step 8: Button Boards
- The button boards are interesting. They are both identical, but each side is
different. We will use one of each side to produce the required button layout.
- Start by soldering the Left and Right buttons on the Right board.
- Then do the top and bottom buttons
- And finally solder the two buttons on the left board.

![Step Eight One Image](/images/instructions/addon_step8.1.jpg)

- Once the boards are done, you will need to cut more pins from the pin strip.
- Cut four sets of 2 pins and two sets of 6 pins.
- Place them in the main board with the long side down.
- Now place the button boards on top of the pins. They will not stay by themselves. While holding both boards, flip them over. Now gravity will help the button boards stay flat while you solder all the pins.
- Next, flip the board back over and solder the top of the pins on the button
boards.

![Step Eight Two Image](/images/instructions/addon_step8.2.jpg)

## Step 9: Propeller and SD Card
- The end is near! It’s now time to put in the propeller chip. This is a big chip, and it’s expensive so please be careful with it.
- To get the chip into the socket, you will need to bend the legs inward slightly. The easiest way to do this is to put the chip on its side on a flat surface. Then GENTLY press the chip down so that all the pins on that side bend inward a little. Flip the chip over and repeat on the other side.
- Now the pins should be pointing straight down on the sides of the chip.
- Make sure that the dimple is on the right side of the chip and place it into the socket. It will take some force to press it in, so be sure that it is lined up properly.
- After the propeller is in place, put the MicroSD card into the SD adapter and place it in the top of the LCD.

![Step Nine Image](/images/instructions/addon_step9.jpg)

## Step 9: Test
- You’re done! Put some batteries in, flip the new switch to “ON” and the LCD should light up and display some test patterns. 
- If it doesn’t, please let us know and we’d be happy to help you get it working.
- Enjoy your add-on kit!
