#!/bin/sh
# Quick and dirty, but inefficient shellscript that
# turns all memcpy calls into memmove calls
# From Ray Strode

set -e

INPUT="$1"

MEMCPY=0x$(objdump -S -j .plt $INPUT | grep memcpy |awk '{ print $1 }')
[ $MEMCPY = "0x" ] && echo "Can't find memcpy call in $INPUT PLT" 1>&2 && exit 1

MEMMOVE=0x$(objdump -S -j .plt $INPUT | grep memmove |awk '{ print $1 }')
[ $MEMMOVE = "0x" ] && echo "Can't find memmove call in $INPUT PLT" 1>&2 && exit 2

DELTA=$(($MEMMOVE - $MEMCPY))
MEMCPY="$(printf '%x' $MEMCPY)"

TEMP_OUTPUT="$(mktemp)"
trap "rm -f $TEMP_OUTPUT" ERR

cp $INPUT $TEMP_OUTPUT
objdump -S -j .text $INPUT | while read offset e8 byte1 byte2 byte3 byte4 call call_offset rest; do
    test "$call_offset" = "$MEMCPY" || continue;

    OFFSET=$(printf "0x%x" $((0x${offset%:} + 1)))
    NUMBER="0x${byte4}${byte3}${byte2}${byte1}"
    echo -n "Changing call at offset $OFFSET from [${byte1} ${byte2} ${byte3} ${byte4}]"
    NUMBER=$(printf "0x%08x" $(($NUMBER + $DELTA)))

    BYTE1=$(printf "%02x" $((($NUMBER >> 24) & 0xff)))
    BYTE2=$(printf "%02x" $((($NUMBER >> 16) & 0xff)))
    BYTE3=$(printf "%02x" $((($NUMBER >>  8) & 0xff)))
    BYTE4=$(printf "%02x" $((($NUMBER >>  0) & 0xff)))

    echo " to [${BYTE4} ${BYTE3} ${BYTE2} ${BYTE1}]"
    echo -ne "\x$BYTE4\x$BYTE3\x$BYTE2\x$BYTE1" | dd of=$TEMP_OUTPUT bs=1 seek=$(($OFFSET)) count=4 conv=notrunc 2> /dev/null
done

mv $TEMP_OUTPUT $INPUT
