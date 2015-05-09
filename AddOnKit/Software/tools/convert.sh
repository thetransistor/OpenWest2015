#!/bin/bash
convert $1 -resize 320x240 -gravity center -background black \
    -rotate 180 -extent 320x240 \
    -depth 24 \
    bmp3:1.bmp
    # -type truecolor \
    # -set colorspace sRGB -colorspace RGB \
    # -colorspace RGB \
    # -type truecolor \
