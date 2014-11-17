#!/bin/bash

dir=$(dirname $0)

# file=$(ls htmls | grep 1968 | grep t_1 | head -n 1)
file=$1

# [ $# -ne 1 ] && { echo "Usage : Input html file name" ; exit 0 ; }

## tournament title
title=$(cat $dir/htmls/$file | 
grep "tournamentTitle" | 
sed -e 's/<[^>]*>//g' -e 's/^ *//g' -e 's/.$//' -e 's/ /_/g' -e "s/\'/_/g")
echo $title


## tournament date 
date=$(cat $dir/htmls/$file | 
grep "tournamentSubTitle" | 
awk -F "-" '{print $NF}' |
sed 's/<[^>]*>//' | 
sed 's/[^0-9\.]//g')

year=$(echo $date | cut -d"." -f 3)
month=$(echo $date | cut -d"." -f 2)
day=$(echo $date | cut -d"." -f 1)

fileName=$(echo ${title}_${year}_${month}_${day}.txt)
echo $fileName

## tournament grade

echo $date
echo $title

cat $dir/htmls/$file | 
grep "ScoreLink" | 
sed -e 's/<[^>]*>//g' |
sed -e 's/RET/_RET/' -e 's/,/_/g' -e 's/ //g' -e 's/.$//'| 
sed "s/^/$title,$year,$month,$day,/" > $dir/scores/$fileName

# cat $dir/scores/$fileName
