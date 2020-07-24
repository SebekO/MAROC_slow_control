#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
#echo Will update $DIR on the remote server
#rsync --recursive --verbose --dry-run --delete ./ crt.fis.agh.edu.pl:$DIR
#echo 
#echo This was a dry run
#echo Press any key to continue with the normal run
#read

rsync --recursive --verbose --delete ./ crt.fis.agh.edu.pl:$DIR
