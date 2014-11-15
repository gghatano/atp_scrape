#!/bin/bash

dir=$(dirname $0)

file=$1
pid=$$

[ $# -ne 1 ] && { echo "Usage : Unput html file name" ; exit 0 ; }

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

echo $date
echo $title
echo $tournamentGrade

echo $title > $dir/players/${tournamentGrade}_${date}.txt.$pid

cat $dir/htmls/$file | 
gsed 's/col_[0-9]/\nplayer_%\n/' | 
grep -E '(player|Bye)' |
sed -e 's/<[^>]*>//g' -e 's/ //g'| 
grep -E '(_|,|Bye)' | 
gsed 's/player_//' | 
gsed 's/,/_/g' | 
gsed 's/\n/,/g' >> $dir/players/${tournamentGrade}_${date}.txt.$pid

