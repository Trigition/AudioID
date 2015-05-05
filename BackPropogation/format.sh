#!/bin/bash

if [ -z "$1" ]; then
	echo usage: $0 directory
	exit
fi

wd = pwd
exten = ".arff"

cd $1

for f in ./*
do
	if [[ $f =~ "*.arff" ]]; then
		echo Skipping $f ...
		continue
	fi
	
	java -jar wd/FormatConversion.jar $f$exten

done
