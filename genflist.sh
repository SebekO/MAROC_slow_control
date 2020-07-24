#!/bin/bash

PATTERNS="ip/*/example_design src"
LIST=$(ls $PATTERNS)
>tagfilelist.txt

for line in $LIST; do
	if [[ ! -z $PATH_PREPEND ]]; then
		if [[ $line =~ \.v$ ]]; then
			echo ${PATH_PREPEND/:/}/$line | tee -a tagfilelist.txt
		fi
	fi

	if [[ $line =~ :$ ]]; then
		PATH_PREPEND=$line
		echo ===========================
		echo Found catalog $PATH_PREPEND
		echo ===========================
	fi
done
