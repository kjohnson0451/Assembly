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

FILE_LST=$FILEDIR/$SCRIPTNAME.lst
FILE_O=$FILEDIR/$SCRIPTNAME.o

nasm -f elf64 -l $FILE_LST $FILEPATH
ld -o $FILEDIR/a.out $FILE_O

rm $FILE_LST $FILE_O

exit 0

