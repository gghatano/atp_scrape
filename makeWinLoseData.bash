#!/bin/bash

dir=$(dirname $0)
file=$1
# file="11.01.1987.txt.4950"

[ $# -ne 1 ] && { echo "Usage: the name of unput player_tounament_file." ; exit 0 ; }

## make date
day=$(echo $file | awk -F "." '{print $1}')
month=$(echo $file | awk -F "." '{print $2}')
year=$(echo $file | awk -F "." '{print $3}')
date=$(echo $year,$month,$day)

echo $date

title=$(cat $dir/players/$file | head -n 1)
echo $title 

## get tounament-round-player-relation
cat $dir/players/$file | 
awk '{if(NR>1) print $0}' | 
sed 's/[^a-zA-Z_%]//g' | 
tr '\n' ',' | 
tr '%' '\n' | 
sed -e 's/^,//' -e 's/,$//' | 
grep -v -E "^ *$" > $dir/tournament.txt

round=0
[ -e "$dir/matches.txt" ] && rm $dir/matches.txt
cat $dir/tournament.txt | while read line 
do
  round=$(($round + 1))
  echo $line |
  gsed 's/\([^,]*\),\([^,]*\),/\1,\2\n/g' | 
  gsed "s/^/$date,$round,/" >> $dir/matches.txt
done

## get winner-name 
cat $dir/tournament.txt | 
awk '{if(NR>1) print $0}' | 
tr '\n' ',' | 
tr ',' '\n' > $dir/winner.txt

## make data table 
## date-round-player1-player2-winner
echo $title > $dir/dataTable/$file.dataTable 
paste -d"," $dir/matches.txt $dir/winner.txt | 
awk -F "," '{if(NF>6) print $0}' >> $dir/dataTable/$file.dataTable

