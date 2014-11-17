#!/bin/bash

dir=$(dirname $0)

file=$1
# file=$(ls htmls | grep Event)

[ $# -ne 1 ] && { echo "Usage : Input html file name" ; exit 0 ; }

## tournament title
title=$(cat $dir/htmls/$file | 
grep "tournamentTitle" | 
sed -e 's/<[^>]*>//g' -e 's/^ *//g')


## tournament date 
date=$(cat $dir/htmls/$file | 
grep "tournamentSubTitle" | 
awk -F "-" '{print $NF}' |
sed 's/<[^>]*>//' | 
sed 's/[^0-9\.]//g')

## tournament grade

tournamentGrade=$(echo $file | cut -d"_" -f 1,2)

# echo $date
echo $title
# echo $tournamentGrade

tournamentGradeNum=$(echo $tournamentGrade | cut -d"_" -f 2)
year=$(echo $date | cut -d"." -f 3)
month=$(echo $date | cut -d"." -f 2)
day=$(echo $date | cut -d"." -f 1)
tournamentName=$(echo $title | sed -e 's/ /_/g' -e 's/.$//')

# echo $tournamentName, $year, $month, $day

fileName="$dir/players/players_${tournamentName}_${year}_${month}_${day}.txt"

echo $tournamentName,$tournamentGradeNum > $fileName

cat $dir/htmls/$file | 
gsed 's/col_[0-9]/\nplayers_%\n/' | 
grep -E '(Player1Link|Bye|players_)' |
sed -e 's/<[^>]*>//g' -e 's/^ *//' | 
gsed -e 's/,//g' -e 's/ /_/g' | 
gsed -e 's/players_//' -e 's/,/_/g' -e 's/[^%]$//' | 
gsed 's/\n/,/g'   >> $fileName


