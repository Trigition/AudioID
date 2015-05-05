#!/bin/bash

if [ -z "$1" ]; then
	echo usage: $0 directory "[binDir]"
	exit
fi

wd=`pwd`
exten=".arff"
output=$wd\formattedJerks

if [ ! -z "$2" ]; then
	#this means we have a second parameter
	#which means we have a different bin than normal
	echo Changing output directory to $2
	output=$2
fi

cd $1

for f in ./*
do
	echo $f
	if [[ $f == *.arff ]]; then
		echo Skipping $f ...
		continue
	fi
	
	java -jar $wd/FormatConversion.jar $f $f$exten

done
