echo "Copying ‘io-test.binary’ to ‘run.bin’…"
cp io-test.binary run.bin
VOLUME="$1" 
if [ -z "$VOLUME" ]
  then
    echo "Which volume to copy run.bin to? (WARNING: It will be unmounted after copy.)"
    ls /Volumes/
    read VOLUME
fi
cp run.bin /Volumes/$VOLUME/
diskutil unmountdisk /dev/disk2
echo "You may now safely remove your SD card."