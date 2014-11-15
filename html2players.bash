#!/bin/bash

dir=$(dirname $0)

file=$1
pid=$$

title=$(cat $dir/htmls/$file | 
grep "tournamentTitle" | 
sed -e 's/<[^>]*>//g' -e 's/^ *//g')


date=$(cat $dir/htmls/$file | 
grep "tournamentSubTitle" | 
awk -F "-" '{print $NF}' |
sed 's/<[^>]*>//' | 
sed 's/[^0-9\.]//g')

echo $title
echo $title > $dir/players/${date}.txt.$pid

cat $dir/htmls/$file | 
gsed 's/col_[0-9]/\nplayer_%\n/' | 
grep 'player' | 
sed -e 's/<[^>]*>//g' -e 's/ //g'| 
grep -E '(_|,)' | 
gsed 's/player_//' | 
gsed 's/,/_/g' | 
gsed 's/\n/,/g' >> $dir/players/${date}.txt.$pid

