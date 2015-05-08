# OpenWest 2015 Electronic Badge
Assembly Instructions
(Adapted from original instructions created by Compukidmike)

## Step 1: Identify Parts
- 1x Badge PCB
- 1x [ATTiny85](http://www.atmel.com/devices/attiny85.aspx)
- 1x 3xAAA Battery Holder
- 1x Push Button
- 1x Power Switch
- 5x RGB LEDs (WS2812b)
- 6x 0.1uF Capacitors, Ceramic
- 1x Double-Sided Sticky Square

If you are missing parts, please let us know. 
![Step One Image](/images/instructions/step1.png)

## Step 2: Capacitors and Switch
- Flip the board over to the back. Locate the markings for C1-C5 and C6.
- Solder the 6 capacitors. Orientation does not matter for the capacitors.
- Locate S1 and solder the switch there. The switch has little plastic tabs on the bottom that fit into holes on the board.
![Step Two Image](/images/instructions/step2.png)

Note: The surface mount parts come in a plastic or paper tray with a thin plastic film
over them. You will need to peel this plastic off to get the parts out. BE CAREFUL
when doing this as these small parts tend to go flying everywhere.

Note: The easiest way to solder surface mount parts is to first put solder on one of
the pads on the board. Then, while holding the soldering iron on that pad to keep the
solder melted, use the tweezers to place the part onto the board. You can then solder
the other side of the part.

## Step 3: LEDs and Button
- Flip the board back over to the front. Locate the 5 sets of pads at the top of the board, above the OPENWEST text. This is where the LEDs go.
- Orientation is critical for these parts! There are two ways to make sure you put them on the correct way. The easiest is to find the small brown rectangle inside the LED. This should be towards the top of the board. The other way is to find the cut off corner on the LED. This should correspond to a triangle on the board.
- Once you have determined the correct orientation for the LEDs, solder all 5 of them.
- Then, locate the button in the bottom left corner of the board and solder it.
![Step Three Image](/images/instructions/step3.png)
Note: Solder the LEDs and button the same way as the capacitors. Put
solder on one pad, place the part, and then solder the rest of the pads.

## Step 4: Microcontroller
It’s time for the Microcontroller. The Badge uses an Atmel ATTiny85. Once again, orientation matters! The microcontroller goes in the bottom left corner of the board. There is a marking on the top next to pin 1. This marking should be in the bottom-left corner of the chip (pointing to the left). If you are unsure of the correct orientation, please ask us before soldering it!
![Step Four Image](/images/instructions/step4.png)

## Step 5: Battery Holder
This is it, the final piece! 
- The first thing to do is put the sticky square on the bottom of the battery holder. You might need to adjust the wire on the bottom so that it fits in the groove.
- Then place the battery holder on the board with the wires coming out to the left.
- Now you will need to cut the wires to the correct length. They need to reach the square marked B1. The black wire goes to the “-” and the red wire goes to the “+”.
- Once you cut the wires, strip off about 1/4” of insulation.
- Place the wires through the holes and solder them on the front side of the board, then cut off the excess wire close to the board.

![Step Five Image](/images/instructions/step5.png)

## Step 6: Test
- Install a set of batteries (available up front)
- Slide your power switch to "ON" 
- Check that all 5 LEDs light up
- If you have any trouble, please switch off the device and bring it to one of the staff members to help you diagnose.
