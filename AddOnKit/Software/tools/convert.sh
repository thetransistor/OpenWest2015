#!/usr/bin/env zsh

usage() {
	echo "USAGE: ${0} [-i /path/to/input/file] [-o /path/to/output/file]"
	exit 1
}

input=""
output=""

while getopts "i:o:h?" o; do
	case "${o}" in
	i)
		input="${OPTARG}"
		;;
	o)
		output="${OPTARG}"
		;;
	*)
		usage
		;;
	esac
done

if [ "${input}" = "" ] || [ "${output}" = "" ]; then
	usage
fi

if [ ! -f "${input}" ]; then
	echo "[-] File not found: ${file}"
	exit 1
fi

convert "${input}" -resize 320x240 -gravity center -background black \
    -rotate 180 -extent 320x240 \
    -depth 24 \
    "${output}"
    # -type truecolor \
    # -set colorspace sRGB -colorspace RGB \
    # -colorspace RGB \
    # -type truecolor \
