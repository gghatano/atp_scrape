#!/bin/bash

dir=$(dirname $0)

file=$1


date=$(cat $file | 
grep "tournamentSubTitle" | 
sed 's/<[^>]*>//g' | 
awk -F "-" '{print $3}')

echo $date

cat $file | 
gsed 's/col_[0-9]/\nplayer_%\n/' | 
grep 'player' | 
sed -e 's/<[^>]*>//g' -e 's/ //g'| 
grep -E '(_|,)' | 
gsed 's/player_//' | 
gsed 's/,/_/g' | 
gsed 's/\n/,/g'


