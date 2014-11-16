#!/bin/bash

dir=$(dirname $0)

file="t_1_year_2014_1.html"
file=$1
pid=$$

[ $# -ne 1 ] && { echo "Usage : Input html file name" ; exit 0 ; }

## tournament title
title=$(cat $dir/htmls/$file | 
grep "tournamentTitle" | 
sed -e 's/<[^>]*>//g' -e 's/^ *//g' -e 's/.$//')
echo $title


## tournament date 
date=$(cat $dir/htmls/$file | 
grep "tournamentSubTitle" | 
awk -F "-" '{print $NF}' |
sed 's/<[^>]*>//' | 
sed 's/[^0-9\.]//g')

## tournament grade

tournamentGrade=$(echo $file | cut -d"_" -f 1,2)

echo $date
echo $title
echo $tournamentGrade

tournamentGradeNum=$(echo $tournamentGrade | cut -d"_" -f 2)
year=$(echo $date | cut -d"." -f 3)
month=$(echo $date | cut -d"." -f 2)
day=$(echo $date | cut -d"." -f 1)

echo "$dir/scores/${tournamentGrade}_${date}.txt.$pid"

cat $dir/htmls/$file | 
grep "ScoreLink" | 
hxselect -s "\n" -c a | 
sed -e 's/RET/_RET/' -e 's/,/_/g' -e 's/ //g' | 
sed "s/^/$title,$tournamentGradeNum,$year,$month,$day,/" > $dir/scores/${tournamentGrade}_${date}.txt.$pid

#cat $dir/scores/${tournamentGrade}_${date}.txt.$pid

