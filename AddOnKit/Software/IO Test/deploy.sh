echo "Copying ‘io-test.binary’ to ‘run.bin’…"
cp io-test.binary run.bin
VOLUME="$1" 
SHOW_HELP=0
if [ -z "$VOLUME" ]
  then
    SHOW_HELP=1
    echo "Which volume to copy run.bin to?"
    ls /Volumes/
    read VOLUME
fi
cp run.bin /Volumes/$VOLUME/
DISK="$2"
if [ -z "$DISK" ]
  then
    SHOW_HELP=1
    diskutil list
    echo "Which disk under /dev/ to unmount?"
    read DISK
fi
diskutil unmountdisk /dev/$DISK
echo "You may now safely remove your SD card."
if [ $SHOW_HELP -eq 1 ]
  then
    echo ""
    echo "In the future, you can just pass the volume name and disk name when calling this command."
fi