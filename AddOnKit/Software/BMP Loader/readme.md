# OpenWest 2015: BMP Loader

This binary will loop threw all images in the `/img/` directory on your SD card and display them. Unlike the previous version files nolonger need to follow a specific naming convention, but the rotation order is different. Previously the rotation order was `default.bmp`, `1.bmp` but order is now determined by directory order (alphabetical), so the display order would be `1.bmp`, `default.bmp`

## Inststallation

1. Copy `run.bin` and `img/` to your SD card.
1. Add desired images to the `/img` directory on your SD card.

## Generating bitmaps with Gimp

Bitmap images need to be 24bit bitmaps without any of the color space data included in the image file, and currently because of display settings need to be upside down if the badge is being worn on a lanyard. [Gimp](http://www.gimp.org/) is one of the best tools for generating these.

![Gimp bitmap generation](_resources/gimp-bmp.gif)

## Changelog

* __20150510__ - Added abbility to cycle through any number of images.
* __20150507__ - Initial Release