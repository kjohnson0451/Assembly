#!/bin/bash

# Script for quickly building ASM files into a.out

if [ $# -eq 0 ]; then
	echo "No arguments supplied"
	exit 1
fi

FILEPATH=$1
FILEDIR=$(dirname $FILEPATH)
FILENAME=$(basename -- "$FILEPATH")
SCRIPTNAME="${FILENAME%.*}"

FILE=$FILEDIR/$SCRIPTNAME
FILE_O=$FILEDIR/$SCRIPTNAME.o

gcc -m32 -c $FILEPATH
gcc -m32 -o $FILE $FILE_O

rm $FILE_O

exit 0

